<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Document;
use App\Models\Summary;
use App\Services\PdfTextExtractor;
use App\Services\SummaryService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class DocumentController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();

        $history = Document::where('user_id', $user->id)
            ->with('summary')
            ->latest()
            ->get();

        return response()->json([
            'status' => true,
            'message' => 'Riwayat berhasil diambil.',
            'data' => $history
        ]);
    }

    public function store(Request $request, SummaryService $aiService)
    {
        $validated = $request->validate([
            'file' => ['required', 'file', 'mimes:pdf,txt,docx', 'max:20480'],
            'length' => ['nullable', 'string'],
            'make_quiz' => ['nullable', 'string'],
            'quiz_count' => ['nullable', 'string'],
        ]);

        $file = $validated['file'];
        $path = $file->store('documents');
        $absolutePath = Storage::disk('local')->path($path);

        $document = Document::create([
            'user_id' => $request->user()->id,
            'file_name' => $file->getClientOriginalName(),
            'file_path' => $path,
        ]);

        try {

            $text = $aiService->extractText($absolutePath);

            if (!$text) {
                throw new \Exception("Gagal mengambil teks dari file. Pastikan format file benar.");
            }

            $document->update([
                'extracted_text' => $text,
                'extraction_engine' => (string) config('document_extraction.engine', 'php'),
            ]);

            $wantsQuiz = filter_var($request->input('make_quiz'), FILTER_VALIDATE_BOOLEAN);

            $summaryText = $aiService->getGroqSummary(
                $text,
                $request->input('length', 'Sedang (5-7 Paragraf)'),
                $wantsQuiz,
                $request->input('quiz_count', '5 Soal')
            );

            $summary = Summary::create([
                'document_id' => $document->id,
                'summary_text' => $summaryText,
            ]);

            return response()->json([
                'status' => true,
                'message' => 'Upload, ekstraksi, & rangkuman berhasil.',
                'document' => $document,
                'summary' => $summary,
            ], 201);
        } catch (\Throwable $e) {
            return response()->json([
                'status' => false,
                'message' => 'Proses gagal.',
                'error' => $e->getMessage(),
                'document' => $document,
            ], 500);
        }
    }

    public function show(Request $request, $id)
    {
        $user = $request->user();

        $document = Document::where('user_id', $user->id)
            ->with('summary') 
            ->find($id);

        if (!$document) {
            return response()->json([
                'status' => false,
                'message' => 'Dokumen tidak ditemukan atau Anda tidak memiliki akses.'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'message' => 'Detail dokumen berhasil diambil.',
            'data' => $document
        ]);
    }
}

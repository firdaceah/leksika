<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Document;
use App\Models\Summary;
use App\Services\SummaryService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\DB; 

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

        DB::beginTransaction();

        try {
            $file = $validated['file'];
            $path = $file->store('documents');
            $absolutePath = Storage::disk('local')->path($path);

            $document = Document::create([
                'user_id' => $request->user()->id,
                'file_name' => $file->getClientOriginalName(),
                'file_path' => $path,
            ]);

            $text = $aiService->extractText($absolutePath);

            if (!$text || strlen(trim($text)) < 10) {
                throw new \Exception("File tidak memiliki teks yang cukup untuk dirangkum.");
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

            if (!$summaryText || str_contains(strtolower($summaryText), 'gagal merangkum')) {
                throw new \Exception("AI gagal memproses rangkuman materi ini.");
            }

            $summary = Summary::create([
                'document_id' => $document->id,
                'summary_text' => $summaryText,
            ]);

            DB::commit();

            return response()->json([
                'status' => true,
                'message' => 'Upload & Rangkuman berhasil.',
                'data' => $document->load('summary'), 
            ], 201);

        } catch (\Throwable $e) {
            DB::rollBack();

            if (isset($path)) {
                Storage::delete($path);
            }

            return response()->json([
                'status' => false,
                'message' => 'Proses Rangkuman Gagal.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function show(Request $request, $id)
    {
        $document = Document::where('user_id', $request->user()->id)
            ->with('summary') 
            ->find($id);

        if (!$document) {
            return response()->json([
                'status' => false,
                'message' => 'Dokumen tidak ditemukan.'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'data' => $document
        ]);
    }
}
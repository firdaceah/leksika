<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Document;
use App\Services\PdfTextExtractor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class DocumentController extends Controller
{
    public function store(Request $request, PdfTextExtractor $extractor)
    {
        $validated = $request->validate([
            'file' => ['required', 'file', 'mimes:pdf', 'max:20480'],
        ]);

        $file = $validated['file'];
        $path = $file->store('documents');

        $document = Document::create([
            'user_id' => $request->user()->id,
            'file_name' => $file->getClientOriginalName(),
            'file_path' => $path,
        ]);

        $absolutePath = Storage::path($path);

        try {
            $text = $extractor->extract($absolutePath);

            $document->update([
                'extracted_text' => $text,
                'extraction_engine' => (string) config('document_extraction.engine', 'php'),
            ]);
        } catch (\Throwable $e) {
            // Keep the document row; return extraction failure details.
            return response()->json([
                'status' => false,
                'message' => 'Upload berhasil, tapi ekstraksi teks gagal.',
                'error' => $e->getMessage(),
                'document' => $document,
            ], 500);
        }

        return response()->json([
            'status' => true,
            'message' => 'Upload & ekstraksi berhasil.',
            'document' => $document,
        ], 201);
    }
}

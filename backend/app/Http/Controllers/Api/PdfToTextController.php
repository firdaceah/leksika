<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Symfony\Component\Process\Process;

class PdfToTextController extends Controller
{
    public function convert(Request $request)
    {
        $validated = $request->validate([
            'file' => [
                'required',
                'file',
                'mimes:pdf',
                'max:20480',
            ],
        ]);

        $binary = config('services.pdftotext.binary', 'pdftotext');

        if (! File::exists($binary) && strtolower($binary) !== 'pdftotext') {
            return response()->json([
                'message' => 'Binary pdftotext tidak ditemukan. Set PDFTOTEXT_BINARY di .env.',
            ], 500);
        }

        $workspace = storage_path('app/tmp/pdf-parse/' . uniqid('job_', true));
        File::ensureDirectoryExists($workspace);

        $uploadedFile = $validated['file'];
        $storedName = $uploadedFile->hashName();
        $inputPath = $uploadedFile->move($workspace, $storedName)->getPathname();
        $outputPath = $workspace . '/result.txt';

        $process = new Process([
            $binary,
            '-layout',
            $inputPath,
            $outputPath,
        ]);

        $process->setTimeout(120);
        $process->run();

        if (! $process->isSuccessful()) {
            File::deleteDirectory($workspace);

            return response()->json([
                'message' => 'Gagal parsing PDF ke teks.',
                'error' => trim($process->getErrorOutput()) ?: trim($process->getOutput()),
            ], 500);
        }

        if (! File::exists($outputPath)) {
            File::deleteDirectory($workspace);

            return response()->json([
                'message' => 'Parsing selesai, tetapi file teks tidak ditemukan.',
            ], 500);
        }

        $text = File::get($outputPath);

        File::deleteDirectory($workspace);

        return response()->json([
            'message' => 'Berhasil parsing PDF ke teks.',
            'text' => $text,
        ]);
    }
}

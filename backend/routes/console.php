<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Str;
use App\Services\PdfTextExtractor;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');

Artisan::command('document:pdf-to-text {path : Absolute/relative path to a PDF}', function (PdfTextExtractor $extractor) {
    $path = (string) $this->argument('path');

    try {
        $text = $extractor->extract($path);
    } catch (Throwable $e) {
        $this->error($e->getMessage());
        return self::FAILURE;
    }

    $length = function_exists('mb_strlen') ? mb_strlen($text, 'UTF-8') : strlen($text);
    $this->info("Extracted {$length} characters");

    $preview = preg_replace('/\s+/u', ' ', $text) ?? $text;
    $this->line(Str::limit($preview, 500));

    return self::SUCCESS;
})->purpose('Extract text from a PDF (engine: php/poppler)');


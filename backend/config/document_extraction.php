<?php

return [
    // Engine options:
    // - 'php': pure PHP parsing (works on XAMPP/shared hosting; may be less accurate)
    // - 'poppler': use pdftotext binary (often most accurate for text-based PDFs)
    'engine' => env('PDF_TEXT_ENGINE', 'php'),

    // Prefer PDFTOTEXT_PATH, but keep compatibility with older/local env keys.
    'pdftotext_path' => env('PDFTOTEXT_PATH', env('PDFTOTEXT_BINARY', 'pdftotext')),
    'pdftotext_timeout' => (int) env('PDFTOTEXT_TIMEOUT', 60),
];

<?php

namespace App\Services;

use App\Services\PdfTextExtractor;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use PhpOffice\PhpWord\IOFactory;

class SummaryService
{
  protected $extractor;

  public function __construct(PdfTextExtractor $extractor)
  {
    $this->extractor = $extractor;
  }

  public function extractText($filePath)
  {
    try {
      $extension = strtolower(pathinfo($filePath, PATHINFO_EXTENSION));

      if ($extension === 'pdf') {
        return $this->extractor->extract($filePath);
      }

      if ($extension === 'docx') {
        $phpWord = IOFactory::load($filePath);
        $fullText = '';

        foreach ($phpWord->getSections() as $section) {
          foreach ($section->getElements() as $element) {
            $fullText .= $this->parseWordElement($element) . " ";
          }
        }
        return trim($fullText);
      }

      return trim(file_get_contents($filePath));
    } catch (\Exception $e) {
      Log::error("Ekstraksi gagal: " . $e->getMessage());
      return null;
    }
  }

  private function parseWordElement($element)
  {
    $text = '';

    if (method_exists($element, 'getText')) {
      $content = $element->getText();
      return is_string($content) ? $content : '';
    }

    if (method_exists($element, 'getElements')) {
      foreach ($element->getElements() as $childElement) {
        $text .= $this->parseWordElement($childElement);
      }
    }

    return $text;
  }
  public function getGroqSummary($text, $length, $makeQuiz = false, $quizCount = "5 Soal")
  {
    $cleanText = mb_strimwidth($text, 0, 20000, "...");

    $apiKey = env('GROQ_API_KEY');
    $url = "https://api.groq.com/openai/v1/chat/completions";

    if (!$text) return "Teks kosong, tidak ada konten untuk dirangkum.";

    $systemInstructions = "Anda adalah asisten akademik Leksika yang ahli merangkum materi kuliah dalam Bahasa Indonesia.\n\n" .
      "TUGAS ANDA:\n" .
      "1. Gunakan # untuk Judul Utama (hanya satu kali di awal).\n" .
      "2. Gunakan ### untuk Sub-judul setiap bagian.\n" .
      "3. Gunakan bullet points (-) untuk penjelasan.\n" .
      "4. Gunakan **teks** untuk istilah penting yang perlu ditebalkan.\n" .
      "5. Panjang rangkuman: $length.\n";

    if ($makeQuiz) {
      $systemInstructions .= "6. Jika ada flashcard, buat di akhir dengan header ### LATIHAN FLASHCARD sebanyak $quizCount.\n" .
        "7. Setiap soal flashcard harus memiliki Pertanyaan dan Jawaban yang jelas.\n";
    }

    $systemInstructions .= "\nJangan berikan kata pengantar, langsung berikan konten rangkumannya.";

    try {
      $response = Http::withToken($apiKey)
        ->timeout(120)
        ->post($url, [
          "model" => "llama-3.1-8b-instant",
          "messages" => [
            [
              "role" => "system",
              "content" => $systemInstructions
            ],
            [
              "role" => "user",
              "content" => "Materi: " . $cleanText
            ]
          ],
          "temperature" => 0.5
        ]);

      if ($response->successful()) {
        return $response->json()['choices'][0]['message']['content'];
      }

      Log::error("Groq API Error: " . $response->body());
      return "Maaf, AI gagal merangkum materi saat ini.";
    } catch (\Exception $e) {
      Log::error("Groq Exception: " . $e->getMessage());
      return "Error koneksi AI: " . $e->getMessage();
    }
  }
}

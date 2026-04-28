<?php

namespace App\Services;

use RuntimeException;
use Smalot\PdfParser\Parser;

class PdfTextExtractor
{
    public function extract(string $pdfPath): string
    {
        if (!is_file($pdfPath) || !is_readable($pdfPath)) {
            throw new RuntimeException("PDF file not found or not readable: {$pdfPath}");
        }

        $engine = (string) config('document_extraction.engine', 'php');
        if ($engine === 'poppler') {
            return $this->extractWithPoppler($pdfPath);
        }

        return $this->extractWithPhpParser($pdfPath);
    }

    private function extractWithPhpParser(string $pdfPath): string
    {
        try {
            $parser = new Parser();
            $pdf = $parser->parseFile($pdfPath);
            return $this->normalize($pdf->getText());
        } catch (\Throwable $e) {
            throw new RuntimeException('PDF parse failed: ' . $e->getMessage(), previous: $e);
        }
    }

    private function extractWithPoppler(string $pdfPath): string
    {

        $binary = (string) config('document_extraction.pdftotext_path', 'pdftotext');
        if ($binary === '') {
            $binary = 'pdftotext';
        }

        $binary = $this->normalizeBinaryPath($binary);

        $timeoutSeconds = (int) config('document_extraction.pdftotext_timeout', 60);
        if ($timeoutSeconds <= 0) {
            $timeoutSeconds = 60;
        }

        [$exitCode, $stdout, $stderr] = $this->runProcess(
            $this->buildCommand($binary, [
                '-enc',
                'UTF-8',
                '-nopgbrk',
                $pdfPath,
                '-',
            ]),
            is_file($binary) ? dirname($binary) : null,
            $timeoutSeconds,
        );

        if ($exitCode !== 0) {
            $stderr = trim($stderr);
            $hint = $this->isLikelyMissingBinary($stderr)
                ? ' (Hint: install Poppler and set PDFTOTEXT_PATH or add pdftotext.exe to PATH)'
                : '';

            throw new RuntimeException("pdftotext failed (exit {$exitCode}): {$stderr}{$hint}");
        }

        return $this->normalize($stdout);
    }

    public function isAvailable(): bool
    {
        $engine = (string) config('document_extraction.engine', 'php');
        if ($engine !== 'poppler') {
            return class_exists(Parser::class);
        }

        $binary = (string) config('document_extraction.pdftotext_path', 'pdftotext');
        if ($binary === '') {
            $binary = 'pdftotext';
        }

        $binary = $this->normalizeBinaryPath($binary);

        try {
            [$exitCode] = $this->runProcess(
                $this->buildCommand($binary, ['-v']),
                is_file($binary) ? dirname($binary) : null,
                5,
            );

            return $exitCode === 0;
        } catch (\Throwable) {
            return false;
        }
    }

    private function normalize(string $text): string
    {
        $text = str_replace("\r\n", "\n", $text);
        $text = str_replace("\r", "\n", $text);
        return trim($text);
    }

    private function normalizeBinaryPath(string $binary): string
    {
        $binary = trim($binary);
        $binary = trim($binary, "\"'");

        // Many Windows examples use forward slashes; normalize to backslashes.
        if (DIRECTORY_SEPARATOR === '\\') {
            $binary = str_replace('/', '\\', $binary);
        }

        return $binary;
    }

    /**
     * Build a shell command string with safe argument quoting.
     *
     * We intentionally use a string command (shell execution) because on some
     * Windows setups, calling Poppler via proc_open array/Symfony Process can
     * crash with access violations while direct execution works.
     */
    private function buildCommand(string $binary, array $args): string
    {
        $parts = [escapeshellarg($binary)];

        foreach ($args as $arg) {
            $parts[] = escapeshellarg((string) $arg);
        }

        return implode(' ', $parts);
    }

    /**
     * @return array{0:int,1:string,2:string}
     */
    private function runProcess(string $command, ?string $cwd, int $timeoutSeconds): array
    {
        $descriptors = [
            1 => ['pipe', 'w'],
            2 => ['pipe', 'w'],
        ];

        $options = [];
        // Let Windows resolve execution the normal way.
        if (DIRECTORY_SEPARATOR === '\\') {
            $options['bypass_shell'] = false;
        }

        $process = proc_open($command, $descriptors, $pipes, $cwd ?: null, null, $options);
        if (!is_resource($process)) {
            throw new RuntimeException('Failed to start pdftotext process');
        }

        stream_set_blocking($pipes[1], false);
        stream_set_blocking($pipes[2], false);

        $stdout = '';
        $stderr = '';
        $start = microtime(true);

        while (true) {
            $status = proc_get_status($process);
            $stdout .= stream_get_contents($pipes[1]);
            $stderr .= stream_get_contents($pipes[2]);

            if (!$status['running']) {
                break;
            }

            if ((microtime(true) - $start) > $timeoutSeconds) {
                proc_terminate($process);
                $stdout .= stream_get_contents($pipes[1]);
                $stderr .= stream_get_contents($pipes[2]);
                throw new RuntimeException('pdftotext timed out');
            }

            usleep(20_000);
        }

        $stdout .= stream_get_contents($pipes[1]);
        $stderr .= stream_get_contents($pipes[2]);

        fclose($pipes[1]);
        fclose($pipes[2]);

        $exitCode = proc_close($process);
        return [(int) $exitCode, (string) $stdout, (string) $stderr];
    }

    private function isLikelyMissingBinary(string $stderr): bool
    {
        $stderrLower = strtolower($stderr);
        return str_contains($stderrLower, 'not found')
            || str_contains($stderrLower, 'is not recognized')
            || str_contains($stderrLower, 'cannot run program')
            || str_contains($stderrLower, 'system cannot find');
    }
}

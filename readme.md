# 📚 Leksika AI - Sprint 1 Setup

Panduan ini untuk seluruh anggota tim (UI, Frontend, Backend, PO, SM) untuk memulai project secara lokal.

## 📁 Struktur Folder
- `backend/` : Framework Laravel 11 (REST API)
- `frontend/` : Framework Flutter (Mobile App)

## 🛠️ Langkah Awal (Backend)
1. `cd backend`
2. `composer install`
3. `cp .env.example .env` (Lalu buat database di postgresql dengan nama `leksika`)
4. `php artisan key:generate`
5. `php artisan migrate`
6. `php artisan serve --host=0.0.0.0`

## 📱 Langkah Awal (Frontend)
1. `cd frontend`
2. `flutter pub get`
3. Buka emulator/HP
4. `flutter run`

## 🔗 Koneksi API
- Jika pakai **Android Emulator**, URL Base API adalah: `http://10.0.2.2:8000/api`
- Jika pakai **iOS Simulator**, URL Base API adalah: `http://127.0.0.1:8000/api`

## ⚡ Cheatsheet Cepat (10 Langkah)
1. `cd backend`
2. `composer install`
3. `cp .env.example .env`
4. Set DB PostgreSQL di `.env` (`leksika`, username, password)
5. Install parser PDF: `winget install oschwartz10612.Poppler`
6. Set `.env`: `PDFTOTEXT_BINARY="pdftotext"` *(atau path absolut `pdftotext.exe`)*
7. `php artisan key:generate`
8. `php artisan migrate`
9. `php artisan config:clear && php artisan serve --host=0.0.0.0`
10. Test endpoint: `POST /api/convert/pdf-to-text` + header `Authorization: Bearer <token>` + form-data `file` (pdf)

## ✅ Kesimpulan Implementasi (Backend PDF → Parsing Text)

Fitur yang dipakai saat ini adalah **upload PDF lalu ekstrak teks** melalui endpoint backend:
- `POST /api/convert/pdf-to-text`
- Dilindungi `auth:sanctum` (wajib login/register dulu untuk dapat bearer token)

### Kenapa dipilih `pdftotext` (Poppler), bukan LibreOffice?
- `pdftotext` lebih stabil untuk ekstraksi teks dari **PDF digital**
- LibreOffice lebih cocok untuk **konversi format dokumen** (misalnya DOCX → PDF)
- Untuk parsing teks, LibreOffice cenderung menghasilkan line break/struktur yang kurang rapi

### Kebutuhan di laptop tim
1. PHP + Composer + ekstensi yang diperlukan Laravel
2. PostgreSQL aktif (database: `leksika`)
3. Poppler (`pdftotext`) terpasang
	 - Windows (disarankan): `winget install oschwartz10612.Poppler`

### Setup backend dari nol (ringkas)
1. `cd backend`
2. `composer install`
3. `cp .env.example .env` *(jika file belum ada)*
4. Isi `.env` database PostgreSQL
5. Set path parser PDF di `.env`:
	 - `PDFTOTEXT_BINARY="pdftotext"` *(jika PATH sudah benar)*
	 - atau isi path absolut `pdftotext.exe` *(Windows, jika belum terbaca PATH)*
6. `php artisan key:generate`
7. `php artisan migrate`
8. `php artisan config:clear`
9. `php artisan serve --host=0.0.0.0`

### Alur pakai API
1. Register/login untuk dapat `access_token`
2. Kirim `POST /api/convert/pdf-to-text`
	 - Header: `Authorization: Bearer <token>`
	 - Body: `multipart/form-data`, field `file` (pdf)
3. Respons API mengembalikan JSON berisi hasil teks parsing

### Troubleshooting cepat
- Error `could not find driver` saat migrate:
	- Aktifkan driver DB yang sesuai di `php.ini` (mis. `pdo_pgsql` untuk PostgreSQL)
- Error auth PostgreSQL (`no password supplied`):
	- Pastikan `DB_USERNAME` dan `DB_PASSWORD` di `.env` benar
- Error parser (`Binary pdftotext tidak ditemukan`):
	- Install Poppler dan set `PDFTOTEXT_BINARY` ke path yang valid
- Error `405 Method Not Allowed` pada route convert:
	- Endpoint convert harus dipanggil dengan **POST**, bukan GET

### Catatan kualitas hasil
- Paling bagus untuk PDF digital berbasis teks
- Jika PDF hasil scan/gambar, gunakan OCR (misalnya Tesseract) sebagai jalur lanjutan

## 🤝 Kontribusi (Git Workflow)
1. Selalu lakukan `git pull origin main` sebelum mulai bekerja.
2. Buat branch baru: `git checkout -b fitur/nama-fitur`
3. Setelah selesai: `git add .` -> `git commit -m "pesan"` -> `git push origin fitur/nama-fitur`


features/
├── auth/         ← semua yang berkaitan dengan user & auth
├── document/     ← upload, riwasama: Document
└── summary/      ← hasil rangkuman & quiz (data sama: Summary)
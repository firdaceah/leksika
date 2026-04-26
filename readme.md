# 📚 Leksika AI - Sprint 1 Setup

Panduan ini untuk seluruh anggota tim (UI, Frontend, Backend, PO, SM) untuk memulai project secara lokal.

## 📁 Struktur Folder
- `leksika_backend/` : Framework Laravel 11 (REST API)
- `leksika_app/` : Framework Flutter (Mobile App)

## 🛠️ Langkah Awal (Backend)
1. `cd leksika_backend`
2. `composer install`
3. `cp .env.example .env` (Lalu buat database di postgresql dengan nama `leksika`)
4. `php artisan key:generate`
5. `php artisan migrate`
6. `php artisan serve --host=0.0.0.0`

## 📱 Langkah Awal (Frontend)
1. `cd leksika_app`
2. `flutter pub get`
3. Buka emulator/HP
4. `flutter run`

## 🔗 Koneksi API
- Jika pakai **Android Emulator**, URL Base API adalah: `http://10.0.2.2:8000/api`
- Jika pakai **iOS Simulator**, URL Base API adalah: `http://127.0.0.1:8000/api`

## 🤝 Kontribusi (Git Workflow)
1. Selalu lakukan `git pull origin main` sebelum mulai bekerja.
2. Buat branch baru: `git checkout -b fitur/nama-fitur`
3. Setelah selesai: `git add .` -> `git commit -m "pesan"` -> `git push origin fitur/nama-fitur`
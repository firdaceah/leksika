import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna Hijau Mint Cerah Figma
    Color mintGreen = const Color(0xFF65FBBD);
    // Warna Hijau Tua Tombol
    Color darkGreenButton = const Color(0xFF0C6B58);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // --- BAGIAN ATAS (Hijau Mint + Lingkaran) - Fix Size agar tidak overflow ---
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.55, // Sedikit diperkecil
            color: mintGreen,
            child: Center(
              child: Container(
                width: 200, // Diperkecil sedikit biar pas di Chrome
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  // Ikon Buku Hijau Tua
                  child: Icon(
                    Icons.book_rounded, 
                    size: 90, 
                    color: darkGreenButton.withOpacity(0.6)
                  ),
                ),
              ),
            ),
          ),

          // --- BAGIAN BAWAH (PENTING: Pake ScrollView biar ga sleret!) ---
          Expanded(
            child: SingleChildScrollView( // <-- INI OBATNYA
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10), // Jarak atas
                  // Judul
                  const Text(
                    "Upload PDF,\ndapat Ringkasan Instan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20, // Diperkecil dikit
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Deskripsi
                  Text(
                    "AI kami membaca materi di dokumenmu dan mengubahnya jadi ringkasan yang mudah dipahami dalam detik.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13, // Diperkecil dikit
                      color: Colors.grey[700], 
                      height: 1.6
                    ),
                  ),
                  const SizedBox(height: 30), // Jarak sebelum tombol

                  // Tombol MULAI (Lonjong, Hijau Tua)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkGreenButton,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(200, 48), // Tinggi standar
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 4,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      "MULAI",
                      style: TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold, 
                        letterSpacing: 1
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Jarak bawah
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
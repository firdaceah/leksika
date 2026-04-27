import 'package:flutter/material.dart';

class Ringkasan extends StatefulWidget {
  const Ringkasan({super.key});
  @override
  RingkasanState createState() => RingkasanState();
}

class RingkasanState extends State<Ringkasan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // --- CUSTOM APP BAR ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF00362A)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Rangkuman",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00362A),
                    ),
                  ),
                  // Ikon lonceng sesuai desain
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF006947),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.notifications_outlined, color: Colors.white, size: 20),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            // --- KONTEN UTAMA ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul Materi
                    const Text(
                      "Struktur Data & Algoritma",
                      style: TextStyle(
                        color: Color(0xFF00362A),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Dibuat dari 18 Halaman",
                      style: TextStyle(color: Color(0xFF2F6555), fontSize: 14),
                    ),

                    const SizedBox(height: 24),

                    // Poin Ringkasan
                    _buildPointCard(
                      "Konsep Array & Linked List",
                      "Array menyimpan elemen secara berurutan di memori, akses O(1). Linked List fleksibel dalam insert/delete namun akses O(n). Pilih berdasarkan kebutuhan operasi dominan.",
                    ),
                    _buildPointCard(
                      "Algoritma Sorting",
                      "Bubble sort O(n2) cocok untuk data kecil. Merge sort O(n log n) lebih efisien untuk dataset besar dengan teknik divide and conquer.",
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointCard(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        // ✅ Card hijau muda, konsisten sama halaman Riwayat
        color: const Color(0xFFE8F7F2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFB2DFD0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header card ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
            child: Row(
              children: [
                // Bullet hijau sesuai desain
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: const Color(0xFF006947),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF00362A),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Garis pemisah ──
          const Divider(height: 1, color: Color(0xFFB2DFD0)),

          // ── Isi konten ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
            child: Text(
              content,
              style: const TextStyle(
                color: Color(0xFF2F6555),
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
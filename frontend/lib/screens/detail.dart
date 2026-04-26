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
            // --- CUSTOM APP BAR (BACK BUTTON) ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF00362A)),
                    onPressed: () => Navigator.pop(context), // Fungsi Back
                  ),
                  const Text(
                    "Detail Ringkasan",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00362A),
                    ),
                  ),
                ],
              ),
            ),

            // --- KONTEN UTAMA (SCROLLABLE) ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner Image Background (Optional if using your network image)
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        image: const DecorationImage(
                          image: NetworkImage("https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/3a840d30-4bfe-4ad1-bd66-5e6e13c94beb"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),

                    // Judul Materi
                    const Text(
                      "Struktur Data & Algoritma",
                      style: TextStyle(
                        color: Color(0xFF00362A),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "18 hal  • Dibuat tadi • 3 poin utama",
                      style: TextStyle(color: Color(0xFF2F6555), fontSize: 14),
                    ),

                    const SizedBox(height: 30),

                    // Poin Ringkasan 1
                    _buildPointCard(
                      "Konsep Array & Linked List",
                      "Array menyimpan elemen secara berurutan di memori, akses O(1). Linked List fleksibel dalam insert/delete namun akses O(n). Pilih berdasarkan kebutuhan operasi dominan."
                    ),

                    // Poin Ringkasan 2
                    _buildPointCard(
                      "Algoritma Sorting",
                      "Bubble sort O(n2) cocok untuk data kecil. Merge sort O(n log n) lebih efisien untuk dataset besar dengan teknik divide and conquer."
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

  // Widget Helper untuk Kartu Poin (Desain tetap sama)
  Widget _buildPointCard(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(color: Color(0x0800362A), blurRadius: 20, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFF67B187),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(color: Color(0xFF00362A), fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(color: Colors.black87, fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }
}
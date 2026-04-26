import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class CREATERANGKUMAN extends StatefulWidget {
  const CREATERANGKUMAN({super.key});
  @override
  CREATERANGKUMANState createState() => CREATERANGKUMANState();
}

class CREATERANGKUMANState extends State<CREATERANGKUMAN> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( // AGAR BISA SCROLL DAN TIDAK ERROR
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER HIJAU ---
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF006947),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(48),
                    bottomLeft: Radius.circular(48),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      "Buat Ringkasan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // --- AREA UPLOAD (DASHED BORDER) ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    border: DashedBorder.fromBorderSide(
                      dashLength: 15,
                      side: const BorderSide(color: Color(0x4D81B8A5), width: 2),
                    ),
                    borderRadius: BorderRadius.circular(48),
                    color: const Color(0x99FFFFFF),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: const Color(0xFF69F6B8),
                        child: const Icon(Icons.file_upload_outlined, size: 40, color: Color(0xFF006947)),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Tap untuk Upload File",
                        style: TextStyle(
                          color: Color(0xFF00362A),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Dukung PDF, DOCX, atau Gambar",
                        style: TextStyle(color: Color(0xFF2F6555), fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // --- PILIHAN PANJANG RINGKASAN ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("PANJANG RINGKASAN", 
                      style: TextStyle(color: Color(0xFF2F6555), fontSize: 10, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    _buildDropdownContainer("Sedang (5-7 Paragraf)"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- PILIHAN JUMLAH SOAL ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("JUMLAH SOAL KUIS", 
                      style: TextStyle(color: Color(0xFF2F6555), fontSize: 10, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    _buildDropdownContainer("10 Soal"),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // --- TOMBOL BUAT SEKARANG ---
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      // Logika proses AI
                      Navigator.pushNamed(context, '/detail');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006947),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                      elevation: 10,
                      shadowColor: const Color(0x33006947),
                    ),
                    child: const Text("Buat Ringkasan Sekarang", 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Helper untuk box dropdown agar desain konsisten
  Widget _buildDropdownContainer(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFBFFEE7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: const TextStyle(color: Color(0xFF00362A), fontSize: 16)),
          const Icon(Icons.keyboard_arrow_down, color: Color(0xFF00362A)),
        ],
      ),
    );
  }
}
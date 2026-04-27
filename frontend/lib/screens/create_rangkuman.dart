import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class CREATERANGKUMAN extends StatefulWidget {
  const CREATERANGKUMAN({super.key});
  @override
  CREATERANGKUMANState createState() => CREATERANGKUMANState();
}

class CREATERANGKUMANState extends State<CREATERANGKUMAN> {
  String _selectedPanjang = "Sedang (5-7 Paragraf)";
  String _selectedSoal = "10 Soal";

  final List<String> _panjangOptions = [
    "Singkat (3-4 Paragraf)",
    "Sedang (5-7 Paragraf)",
    "Panjang (8-10 Paragraf)",
  ];

  final List<String> _soalOptions = [
    "5 Soal",
    "10 Soal",
    "15 Soal",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                    const Text(
                      "PANJANG RINGKASAN",
                      style: TextStyle(color: Color(0xFF2F6555), fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _buildDropdown(
                      value: _selectedPanjang,
                      items: _panjangOptions,
                      onChanged: (val) => setState(() => _selectedPanjang = val!),
                    ),
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
                    const Text(
                      "JUMLAH SOAL KUIS",
                      style: TextStyle(color: Color(0xFF2F6555), fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _buildDropdown(
                      value: _selectedSoal,
                      items: _soalOptions,
                      onChanged: (val) => setState(() => _selectedSoal = val!),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // --- TOMBOL BUAT SEKARANG ---
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/detail'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006947),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                      elevation: 10,
                      shadowColor: const Color(0x33006947),
                    ),
                    child: const Text(
                      "Buat Ringkasan Sekarang",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
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

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFBFFEE7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF00362A)),
          dropdownColor: const Color(0xFFBFFEE7),
          borderRadius: BorderRadius.circular(20),
          style: const TextStyle(color: Color(0xFF00362A), fontSize: 16),
          items: items.map((item) => DropdownMenuItem(
            value: item,
            child: Text(item),
          )).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
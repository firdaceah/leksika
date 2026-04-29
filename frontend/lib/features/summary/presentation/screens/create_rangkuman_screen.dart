import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class CreateRangkumanScreen extends StatefulWidget {
  const CreateRangkumanScreen({super.key});
  @override
  CreateRangkumanScreenState createState() => CreateRangkumanScreenState();
}

class CreateRangkumanScreenState extends State<CreateRangkumanScreen> {
  String _selectedPanjang = 'Sedang (5-7 Paragraf)';
  String _selectedSoal = '10 Soal';
  bool _buatFlashcard = true;

  final List<String> _panjangOptions = [
    'Singkat (3-4 Paragraf)',
    'Sedang (5-7 Paragraf)',
    'Panjang (8-10 Paragraf)',
  ];

  final List<String> _soalOptions = [
    '5 Soal',
    '10 Soal',
    '15 Soal',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAFAF3),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF006947),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 8, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Buat Rangkuman',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.notifications_none_outlined,
                          color: Color(0xFF006947), size: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 36),
                      decoration: BoxDecoration(
                        border: DashedBorder.fromBorderSide(
                          dashLength: 12,
                          side: const BorderSide(
                              color: Color(0xFF81B8A5), width: 1.5),
                        ),
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              color: Color(0xFF69F6B8),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.upload_file_outlined,
                                size: 32, color: Color(0xFF006947)),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Tap untuk Upload File',
                            style: TextStyle(
                              color: Color(0xFF00362A),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Dukung PDF, DOCX, atau Gambar',
                            style: TextStyle(
                                color: Color(0xFF2F6555), fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: const [
                        Icon(Icons.tune, color: Color(0xFF2F6555), size: 18),
                        SizedBox(width: 6),
                        Text(
                          'Pengaturan Rangkuman',
                          style: TextStyle(
                            color: Color(0xFF00362A),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAFAF3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.style_outlined,
                                color: Color(0xFF006947), size: 22),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Buat Flashcard',
                                  style: TextStyle(
                                    color: Color(0xFF00362A),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Otomatis buat kuis',
                                  style: TextStyle(
                                      color: Color(0xFF2F6555), fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _buatFlashcard,
                            onChanged: (val) =>
                                setState(() => _buatFlashcard = val),
                            activeColor: Colors.white,
                            activeTrackColor: const Color(0xFF006947),
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: const Color(0xFFCCCCCC),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PANJANG RINGKASAN',
                          style: TextStyle(
                              color: Color(0xFF2F6555),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5),
                        ),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          value: _selectedPanjang,
                          items: _panjangOptions,
                          onChanged: (val) =>
                              setState(() => _selectedPanjang = val!),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'JUMLAH SOAL KUIS',
                          style: TextStyle(
                              color: Color(0xFF2F6555),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5),
                        ),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          value: _selectedSoal,
                          items: _soalOptions,
                          onChanged: (val) =>
                              setState(() => _selectedSoal = val!),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/detail'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF006947),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 58),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9999)),
                        elevation: 6,
                        shadowColor: const Color(0x40006947),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Buat Rangkuman Sekarang',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.help_outline,
                            color: Color(0xFF2F6555), size: 14),
                        SizedBox(width: 4),
                        Text(
                          'Need Help?',
                          style: TextStyle(
                              color: Color(0xFF2F6555),
                              fontSize: 13,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              color: Color(0xFF00362A)),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(14),
          style: const TextStyle(color: Color(0xFF00362A), fontSize: 15),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

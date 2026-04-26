import 'package:flutter/material.dart';

class Riwayat extends StatefulWidget {
  const Riwayat({super.key});
  @override
  RiwayatState createState() => RiwayatState();
}

class RiwayatState extends State<Riwayat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // TOMBOL TAMBAH (FIGMA STYLE)
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create-rangkuman'),
        backgroundColor: const Color(0xFF006947),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: _buildBottomNavbar(),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeaderTitle(),

              // List Riwayat yang bisa diklik ke Detail
              _buildHistoryCard(
                "Struktur Data & Algoritma",
                "Mempelajari fundamental linked list dan binary tree transversal secara mendalam.",
                "2 hours ago",
                "18 pages",
                const Color(0xFF9DECD2),
              ),
              _buildHistoryCard(
                "Kemerdekaan RI",
                "Analisis pergeseran kekuatan ekonomi di Asia Tenggara dan dampaknya pada perdagangan.",
                "3 days ago",
                "11 pages",
                const Color(0xFF9DECD2),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Riwayat Rangkuman", 
            style: TextStyle(color: Color(0xFF00362A), fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Container(width: 48, height: 4, color: const Color(0xFF006947)),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(String title, String desc, String time, String pages, Color iconBg) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: const [BoxShadow(color: Color(0x0800362A), blurRadius: 20, offset: Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.description, size: 20, color: Color(0xFF006947)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFF69F6B8), borderRadius: BorderRadius.circular(10)),
                  child: const Text("RINGKASAN", style: TextStyle(color: Color(0xFF005A3C), fontSize: 10, fontWeight: FontWeight.bold)),
                )
              ],
            ),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(color: Color(0xFF00362A), fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(desc, style: const TextStyle(color: Color(0xFF2F6555), fontSize: 14)),
            const Divider(height: 32, color: Color(0x1A81B8A5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(time, style: const TextStyle(color: Color(0xFF2F6555), fontSize: 12)),
                Text(pages, style: const TextStyle(color: Color(0xFF2F6555), fontSize: 12)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavbar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _navItem(Icons.home_outlined, "BERANDA", false, '/home'),
              _navItem(Icons.history, "RIWAYAT", true, '/riwayat'),
            ],
          ),
          Row(
            children: [
              _navItem(Icons.style_outlined, "FLASHCARD", false, '/home'),
              _navItem(Icons.settings_outlined, "SETELAN", false, '/home'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive, String route) {
    return InkWell(
      onTap: () { if (!isActive) Navigator.pushNamed(context, route); },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? const Color(0xFF064E3B) : const Color(0xFF059669)),
            Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isActive ? const Color(0xFF064E3B) : const Color(0xFF059669))),
          ],
        ),
      ),
    );
  }
}
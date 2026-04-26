import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              _buildGreetingSection(),
              _buildMainBanner(),
              _buildHistoryHeader(),
              
              _buildHistoryCard(
                "Struktur Data & Algoritma",
                "Mempelajari fundamental linked list dan binary tree transversal secara mendalam.",
                "2 hours ago",
                "18 pages",
              ),
              _buildHistoryCard(
                "Kemerdekaan RI",
                "Analisis pergeseran kekuatan ekonomi di Asia Tenggara dan dampaknya...",
                "3 days ago",
                "11 pages",
              ),

              _buildDailyTarget(),
              const SizedBox(height: 100), 
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildGreetingSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF69F6B8), width: 2),
                ),
                child: const Icon(Icons.person, color: Colors.grey),
              ),
              const SizedBox(width: 16),
              const Text("Halo, Juli!", 
                style: TextStyle(color: Color(0xFF00362A), fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
          const Icon(Icons.notifications_none, size: 28),
        ],
      ),
    );
  }

  Widget _buildMainBanner() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(colors: [Color(0xFF006947), Color(0xFF69F6B8)]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("SELAMAT DATANG KEMBALI,", style: TextStyle(color: Colors.white70, fontSize: 12)),
          const Text("Juli Ayu", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color(0xFFF8A010), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.local_fire_department, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("STREAK BELAJAR", style: TextStyle(color: Color(0xFF005A3C), fontSize: 10, fontWeight: FontWeight.bold)),
                  Text("7 hari berturut-turut!", style: TextStyle(color: Color(0xFF005A3C), fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildHistoryHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Riwayat Rangkuman", style: TextStyle(color: Color(0xFF00362A), fontSize: 22, fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/riwayat'),
            child: const Text("Lihat semua →", style: TextStyle(color: Color(0xFF006947), fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _buildHistoryCard(String title, String desc, String time, String pages) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
                const Icon(Icons.description, color: Color(0xFF9DECD2)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFF69F6B8), borderRadius: BorderRadius.circular(10)),
                  child: const Text("RINGKASAN", style: TextStyle(color: Color(0xFF005A3C), fontSize: 10, fontWeight: FontWeight.bold)),
                )
              ],
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(color: Color(0xFF00362A), fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(desc, style: const TextStyle(color: Color(0xFF2F6555), fontSize: 14)),
            const Divider(height: 30),
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

  Widget _buildDailyTarget() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: const Color(0x0D006947), borderRadius: BorderRadius.circular(32)),
      child: Column(
        children: [
          const Text("Target Hari Ini", style: TextStyle(color: Color(0xFF006947), fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text("Hampir mencapai target! Buat rangkuman lagi.", textAlign: TextAlign.center),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/create-rangkuman'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF006947), foregroundColor: Colors.white),
            child: const Text("Lanjut Belajar"),
          )
        ],
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
              _navItem(Icons.home, "BERANDA", true, '/home'),
              _navItem(Icons.history, "RIWAYAT", false, '/riwayat'),
            ],
          ),
          Row(
            children: [
              _navItem(Icons.style, "FLASHCARD", false, '/home'),
              _navItem(Icons.settings, "SETELAN", false, '/home'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
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
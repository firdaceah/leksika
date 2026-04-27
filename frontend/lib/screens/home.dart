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
                "Analisis pergeseran kekuatan ekonomi di Asia Tenggara dan dampaknya pada perdagangan.",
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
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF69F6B8), width: 2),
                ),
                child: const Icon(Icons.person, color: Colors.grey),
              ),
              const SizedBox(width: 16),
              const Text(
                "Halo, Juli!",
                style: TextStyle(
                  color: Color(0xFF00362A),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
        gradient: const LinearGradient(
          colors: [Color(0xFF006947), Color(0xFF69F6B8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "SELAMAT DATANG KEMBALI,",
            style: TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 0.5),
          ),
          const SizedBox(height: 4),
          const Text(
            "Juli",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8A010),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.local_fire_department, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "STREAK MERANGKUM",
                    style: TextStyle(
                      color: Color(0xFF005A3C),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "7 hari berturut-turut!",
                    style: TextStyle(
                      color: Color(0xFF005A3C),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
          const Text(
            "Riwayat Rangkuman",
            style: TextStyle(
              color: Color(0xFF00362A),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/riwayat'),
            child: const Text(
              "Lihat semua →",
              style: TextStyle(
                color: Color(0xFF006947),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(
      String title, String desc, String time, String pages) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF006947),
          borderRadius: BorderRadius.circular(32),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3000362A),
              blurRadius: 20,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.description, color: Colors.white70),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF69F6B8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "RINGKASAN",
                    style: TextStyle(
                      color: Color(0xFF005A3C),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              desc,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const Divider(height: 30, color: Colors.white24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time,
                        size: 14, color: Colors.white70),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
                // Page icon + pages
                Row(
                  children: [
                    const Icon(Icons.insert_drive_file_outlined,
                        size: 14, color: Colors.white70),
                    const SizedBox(width: 4),
                    Text(
                      pages,
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyTarget() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      decoration: BoxDecoration(
        color: const Color(0x0D006947),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              children: [
                const Text(
                  "Target Hari Ini",
                  style: TextStyle(
                    color: Color(0xFF006947),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Kamu hampir mencapai target belajar harianmu! Buat rangkuman lagi untuk mempertahankan streak.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF2F6555), fontSize: 13),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/create-rangkuman'),
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: const Text("Lanjut Belajar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006947),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Illustration block at the bottom of the card
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF006947), Color(0xFF004D35)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  // Background decorative circles / landscape
                  Positioned(
                    bottom: -20,
                    left: -20,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0x33000000),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -30,
                    right: 40,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0x2200362A),
                      ),
                    ),
                  ),
                  // Simple illustration: mountains / landscape
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CustomPaint(
                      size: const Size(double.infinity, 80),
                      painter: _LandscapePainter(),
                    ),
                  ),
                  // Small icon overlay
                  const Center(
                    child: Icon(
                      Icons.menu_book_rounded,
                      color: Colors.white24,
                      size: 60,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavbar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: Colors.white,
      elevation: 8,
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

  Widget _navItem(
      IconData icon, String label, bool isActive, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive
                  ? const Color(0xFF064E3B)
                  : const Color(0xFF059669),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isActive
                    ? const Color(0xFF064E3B)
                    : const Color(0xFF059669),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for the landscape illustration at the bottom of Daily Target card
class _LandscapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Back hill
    paint.color = const Color(0xFF005A3C);
    final backPath = Path()
      ..moveTo(0, size.height * 0.6)
      ..quadraticBezierTo(
          size.width * 0.3, size.height * 0.1,
          size.width * 0.6, size.height * 0.5)
      ..quadraticBezierTo(
          size.width * 0.8, size.height * 0.7,
          size.width, size.height * 0.4)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(backPath, paint);

    // Front hill
    paint.color = const Color(0xFF004030);
    final frontPath = Path()
      ..moveTo(0, size.height * 0.8)
      ..quadraticBezierTo(
          size.width * 0.25, size.height * 0.4,
          size.width * 0.5, size.height * 0.7)
      ..quadraticBezierTo(
          size.width * 0.75, size.height * 0.9,
          size.width, size.height * 0.6)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(frontPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
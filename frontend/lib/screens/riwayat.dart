import 'package:flutter/material.dart';
import 'detail.dart'; // Pastikan file detail.dart sudah kamu update juga ya!

class Riwayat extends StatefulWidget {
  const Riwayat({super.key});

  @override
  RiwayatState createState() => RiwayatState();
}

class RiwayatState extends State<Riwayat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF5EC),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create-rangkuman'),
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Color(0xFF006947), size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavbar(),
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  // --- KARTU 1 ---
                  _buildHistoryCard(
                    context,
                    "Struktur Data & Algoritma",
                    "Mempelajari fundamental linked list dan binary tree transversal secara mendalam.",
                    "2 hours ago",
                    "18 Halaman",
                    Icons.monitor_outlined,
                    [
                      {
                        "subTitle": "Konsep Array & Linked List",
                        "body": "Array menyimpan elemen secara berurutan di memori, akses O(1). Linked List fleksibel dalam insert/delete namun akses O(n). Pilih berdasarkan kebutuhan operasi dominan."
                      },
                      {
                        "subTitle": "Algoritma Sorting",
                        "body": "Bubble sort O(n2) cocok untuk data kecil. Merge sort O(n log n) lebih efisien untuk dataset besar dengan teknik divide and conquer."
                      },
                    ],
                  ),

                  // --- KARTU 2 ---
                  _buildHistoryCard(
                    context,
                    "Kemerdekaan RI",
                    "Analisis pergeseran kekuatan ekonomi di Asia Tenggara dan dampaknya pada perdagangan.",
                    "3 days ago",
                    "11 Halaman",
                    Icons.language_outlined,
                    [
                      {
                        "subTitle": "Peristiwa Rengasdengklok",
                        "body": "Golongan muda mendesak Soekarno-Hatta untuk segera memproklamasikan kemerdekaan setelah Jepang menyerah."
                      },
                      {
                        "subTitle": "Makna Proklamasi",
                        "body": "Proklamasi 17 Agustus 1945 menandai lahirnya negara berdaulat dan titik balik perjuangan bangsa Indonesia."
                      },
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
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
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              const Text(
                "Riwayat Rangkuman",
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
    );
  }

  Widget _buildHistoryCard(
    BuildContext context,
    String title,
    String desc,
    String time,
    String pages,
    IconData cardIcon,
    List<Map<String, String>> detailContent,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Ringkasan(
              title: title,
              pageCount: pages,
              contents: detailContent,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB7EDD9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(cardIcon, size: 22, color: const Color(0xFF006947)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF69F6B8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "RINGKASAN",
                    style: TextStyle(
                      color: Color(0xFF004D33),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF00362A),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              desc,
              style: const TextStyle(
                color: Color(0xFF2F6555),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Divider(height: 1, color: Color(0xFFDDEDE8)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded, size: 14, color: Color(0xFF2F6555)),
                    const SizedBox(width: 5),
                    Text(time, style: const TextStyle(color: Color(0xFF2F6555), fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.description_outlined, size: 14, color: Color(0xFF2F6555)),
                    const SizedBox(width: 5),
                    Text(pages, style: const TextStyle(color: Color(0xFF2F6555), fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavbar() {
    return BottomAppBar(
      padding: const EdgeInsets.symmetric(vertical: 8),
      height: 70,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _navItem(Icons.home_outlined, "BERANDA", false, '/home'),
              _navItem(Icons.description_outlined, "RIWAYAT", true, '/riwayat'),
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
      onTap: () {
        if (!isActive) Navigator.pushNamed(context, route);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isActive
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB7EDD9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: const Color(0xFF064E3B), size: 20),
                  )
                : Icon(icon, color: const Color(0xFF059669), size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isActive ? const Color(0xFF064E3B) : const Color(0xFF059669),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
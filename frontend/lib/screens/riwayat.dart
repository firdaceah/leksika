import 'package:flutter/material.dart';
import 'detail.dart'; // Pastikan file detail.dart sudah kamu update juga ya!
import 'bottom_navbar.dart'; // 👈 import shared navbar

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
        backgroundColor: const Color(0xFF006947), // ✅ sama dengan home
        shape: const CircleBorder(),
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // ✅ Pakai shared navbar, activeIndex: 1 = RIWAYAT
      bottomNavigationBar: const BottomNavbar(activeIndex: 1),
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
              // ✅ Tombol back dengan warna hijau muda
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white, size: 18),
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                ),
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
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
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
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFF5EC),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(cardIcon,
                      size: 18, color: const Color(0xFF006947)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6AEFB8),
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
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF003D2A),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              desc,
              style: const TextStyle(
                color: Color(0xFF2F6555),
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1, color: Color(0xFFDDEDE8)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded,
                        size: 13, color: Color(0xFF2F6555)),
                    const SizedBox(width: 4),
                    Text(time,
                        style: const TextStyle(
                            color: Color(0xFF2F6555), fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.description_outlined,
                        size: 13, color: Color(0xFF2F6555)),
                    const SizedBox(width: 4),
                    Text(pages,
                        style: const TextStyle(
                            color: Color(0xFF2F6555), fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  
}
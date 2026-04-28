import 'package:flutter/material.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isSecondSplash = false;

  @override
  void initState() {
    super.initState();
    // Splash 1 selama 5 detik
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          isSecondSplash = true; // Ganti ke Splash 2
        });
      }

      // Splash 2 selama 10 detik -> ke Onboarding
      Timer(const Duration(seconds: 10), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/onboarding');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Warna Hijau Tosca Tua sesuai Figma
    Color figmaGreen = const Color(0xFF3F8A7D);

    return Scaffold(
      backgroundColor: figmaGreen,
      body: Stack(
        children: [
          // --- BULAT-BULAT HIASAN BACKGROUND (Sesuai Figma) ---
          Positioned(
            top: -150,
            left: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          // --- KONTEN UTAMA ---
          SizedBox.expand(
            child: isSecondSplash 
              ? _buildSplash2() // Tampilan Logo di Tengah
              : Center(child: _buildSplash1()), // Tampilan Teks Awal
          ),
        ],
      ),
    );
  }

  // Tampilan Splash 1: Cuma teks subtitle di tengah
  Widget _buildSplash1() {
    return const Text(
      "AI Study Assistant",
      style: TextStyle(
        color: Colors.white70,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  // Tampilan Splash 2: Logo LEKSIKA Benar-benar di Tengah
  Widget _buildSplash2() {
    return Column(
      children: [
        // Spacer Atas (flex 3)
        const Spacer(flex: 3),

        // --- KONTEN TENGAH ---
        const Icon(Icons.book_outlined, size: 90, color: Colors.white),
        const SizedBox(height: 25),
        const Text(
          "LEKSIKA",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "AI Study Assistant",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),

        // Spacer Bawah (flex 3) biar konten di atas benar-benar Center
        const Spacer(flex: 3),

        // --- TEKS FOOTER (Tetap di posisi bawah layar) ---
        const Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Text(
            "Belajar lebih cerdas, Bukan lebih keras.",
            style: TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
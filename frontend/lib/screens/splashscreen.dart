import 'package:flutter/material.dart';
import 'dart:async';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  SplashscreenState createState() => SplashscreenState();
}

class SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    // Berpindah ke halaman login setelah 3 detik
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF327065), 
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.network(
              "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/29286b61-0128-42a3-abc3-42cce78075a9",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
          ),
          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/4a4cd1fb-81a3-4ffc-b6d2-1e9814988f4d",
                  width: 250,
                  height: 250,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                const Text(
                  "AI Study Assistant",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
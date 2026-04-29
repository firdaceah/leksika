import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F4C81)),
      scaffoldBackgroundColor: const Color(0xFFF6F7FB),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFF0F4C81),
        elevation: 0,
      ),
    );
  }
}

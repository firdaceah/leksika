import 'package:flutter/material.dart';
import 'screens/splashscreen.dart';
import 'screens/onboarding.dart';
import 'screens/login.dart';
import 'screens/register.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LEKSIKA',
      // HARUS DISET KE '/' BIAR MULAI DARI SPLASH
      initialRoute: '/', 
      routes: {
        '/': (context) => const SplashPage(),
        '/onboarding': (context) => const Onboarding(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const Scaffold(body: Center(child: Text("Halaman Utama"))),
      },
    );
  }
}
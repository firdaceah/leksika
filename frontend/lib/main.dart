import 'package:flutter/material.dart';
import 'screens/splashscreen.dart';
import 'screens/register.dart';
import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/create_rangkuman.dart';
import 'screens/detail.dart';
import 'screens/riwayat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leksika AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/', 
      routes: {
        '/': (context) => const Splashscreen(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/home': (context) => const HomePage(),
        '/create-rangkuman': (context) => const CREATERANGKUMAN(),
        '/riwayat': (context) => const Riwayat(),
      },
    );
  }
}
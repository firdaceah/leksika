import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isRemember = false;
  bool _obs = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // BIAR GAK OVERFLOW (GARIS KUNING)
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 80, bottom: 50, left: 30, right: 30),
              decoration: const BoxDecoration(
                color: Color(0xFF76B0A6),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("WELCOME BACK,\nLeksikans!", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF1E3F39), height: 1.2)),
                  SizedBox(height: 10),
                  Text("Ready to ace your study session today?", style: TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  _field("Email", Icons.email_outlined, "example@leksikans.com"),
                  const SizedBox(height: 15),
                  _field("Password", Icons.lock_outline, "••••••••", isPass: true),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(value: _isRemember, onChanged: (v) => setState(() => _isRemember = v!), activeColor: const Color(0xFF006947)),
                          const Text("Remember me", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      TextButton(onPressed: () {}, child: const Text("Lupa password?", style: TextStyle(color: Colors.grey, fontSize: 12))),
                    ],
                  ),

                  const SizedBox(height: 20),
                  _btn("LOGIN →", () => Navigator.pushReplacementNamed(context, '/home')),
                  
                  const SizedBox(height: 20),
                  const Text("Or continue with", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 15),

                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    icon: const Icon(Icons.g_mobiledata, size: 30, color: Colors.blue),
                    label: const Text("Google", style: TextStyle(color: Colors.black)),
                    onPressed: () {},
                  ),

                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Belum punya akun? "),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/register'),
                        child: const Text("Daftar sekarang", style: TextStyle(color: Color(0xFF006947), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, IconData icon, String hint, {bool isPass = false}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        obscureText: isPass ? _obs : false,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF006947)),
          suffixIcon: isPass ? IconButton(icon: Icon(_obs ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _obs = !_obs)) : null,
          hintText: hint,
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        ),
      ),
    ]);
  }

  Widget _btn(String t, VoidCallback p) {
    return SizedBox(
      width: double.infinity, height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF006947), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        onPressed: p,
        child: Text(t, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
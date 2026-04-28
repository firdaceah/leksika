import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isAgree = false;
  
  // State terpisah agar mata password & konfirmasi tidak barengan bukanya
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( 
        child: Column(
          children: [
            // Header Register (Sesuai Figma)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 80, bottom: 40, left: 30, right: 30),
              decoration: const BoxDecoration(
                color: Color(0xFFD1E7E0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50), 
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CREATE YOUR\nACCOUNT", 
                    style: TextStyle(
                      fontSize: 32, 
                      fontWeight: FontWeight.w900, 
                      color: Color(0xFF006947), 
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Become a Leksikans today and unlock your AI superpower", 
                    style: TextStyle(color: Color(0xFF4A8F83), fontSize: 14),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  _buildInputField("Email", Icons.email_outlined, "member@leksika.com"),
                  const SizedBox(height: 15),
                  
                  // --- PASSWORD DENGAN MATA ---
                  _buildInputField(
                    "Password", 
                    Icons.lock_outline, 
                    "••••••••", 
                    isPassword: true, 
                    isObscured: _obscurePassword,
                    onToggle: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  
                  // --- KONFIRMASI PASSWORD DENGAN MATA ---
                  _buildInputField(
                    "Konfirmasi Password", 
                    Icons.lock_clock_outlined, 
                    "••••••••", 
                    isPassword: true, 
                    isObscured: _obscureConfirmPassword,
                    onToggle: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 15),
                  
                  // Checkbox I Agree
                  Row(
                    children: [
                      Checkbox(
                        value: _isAgree, 
                        onChanged: (v) => setState(() => _isAgree = v!), 
                        activeColor: const Color(0xFF006947),
                      ),
                      const Expanded(
                        child: Text(
                          "I agree to the Terms of Service and Privacy Policy", 
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  
                  // Tombol Buat Akun
                  SizedBox(
                    width: double.infinity, 
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF006947), 
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: _isAgree ? () => Navigator.pop(context) : null,
                      child: const Text(
                        "BUAT AKUN →", 
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () => Navigator.pop(context), 
                    child: const Text(
                      "Sudah punya akun? Log in", 
                      style: TextStyle(color: Color(0xFF006947)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget reusable untuk Input Field
  Widget _buildInputField(
    String label, 
    IconData icon, 
    String hint, {
    bool isPassword = false, 
    bool isObscured = false, 
    VoidCallback? onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword ? isObscured : false,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF006947)),
            // Tombol Mata
            suffixIcon: isPassword 
              ? IconButton(
                  icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility),
                  onPressed: onToggle, // Ini yang menjalankan setState di atas
                  color: Colors.grey,
                ) 
              : null,
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), 
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Tambahkan dekorasi gradasi di sini
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF99B9FF), Color(0xFF00226B)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ilustrasi kereta
              Image.asset(
                'res/images/train.png', // Pastikan file terdaftar di pubspec.yaml
                height: 300,
              ),
              const SizedBox(height: 20), // Spasi antara gambar dan teks

              // Teks di bawah gambar
              Text(
                'Let’s book your train\nwith easy way.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Warna teks
                ),
              ),
              const SizedBox(height: 40), // Spasi antara teks dan tombol

              // Tombol Get Started
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke layar login
                  Navigator.pushReplacementNamed(context, '/local');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white, // Warna tombol
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

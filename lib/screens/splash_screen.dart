import 'dart:async';
import 'package:flutter/material.dart';
import '/screens/home_screen.dart'; // Ganti dengan path yang benar
import '/screens/login_screen.dart'; // Ganti dengan path yang benar
import '/services/auth_service.dart'; // Ganti dengan path yang benar

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    // Memulai timer saat halaman pertama kali dibuka
    Timer(const Duration(seconds: 5), () => _checkLoginStatus());
  }

  void _checkLoginStatus() async {
    // Memeriksa status login dari AuthService
    bool loggedIn = await _authService.isLoggedIn();

    // Pastikan widget masih ada di tree sebelum navigasi (best practice)
    if (!mounted) return;

    // Navigasi berdasarkan status login
    if (loggedIn) {
      // Jika sudah login, arahkan ke HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Jika belum login, arahkan ke LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade400, Colors.indigo.shade800],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.school, size: 100, color: Colors.white),
              SizedBox(height: 24),
              Text(
                'Kampusku App',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

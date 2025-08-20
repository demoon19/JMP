import 'package:flutter/material.dart';
import 'package:jmp/screens/crud_screen.dart';
import 'package:jmp/screens/informasi_screen.dart';
import 'package:jmp/screens/list_screen.dart';
import '../services/auth_service.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  String _userName = 'Pengguna';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    var profile = await _authService.getUserProfile();
    if (profile != null) {
      setState(() {
        _userName = profile['name'] ?? 'Pengguna';
      });
    }
  }

  // Widget helper untuk membuat kartu kategori
  Widget _buildCategoryCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required List<Color> gradientColors,
  }) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(width: 24),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade400, Colors.indigo.shade800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Selamat Datang, $_userName!',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          // ListView untuk menampilkan kategori secara vertikal
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildCategoryCard(
                  icon: Icons.list_alt,
                  title: 'Lihat Data',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentListScreen(),
                      ),
                    );
                  },
                  gradientColors: [
                    Colors.indigo.shade400,
                    Colors.indigo.shade600
                  ],
                ),
                const SizedBox(height: 16),
                _buildCategoryCard(
                  icon: Icons.add_box,
                  title: 'Input Data',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddEditStudentScreen(),
                      ),
                    );
                  },
                  gradientColors: [
                    Colors.blue.shade400,
                    Colors.blue.shade600
                  ],
                ),
                const SizedBox(height: 16),
                _buildCategoryCard(
                  icon: Icons.info,
                  title: 'Informasi',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InformationScreen(),
                      ),
                    );
                  },
                  gradientColors: [
                    Colors.purple.shade400,
                    Colors.purple.shade600
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
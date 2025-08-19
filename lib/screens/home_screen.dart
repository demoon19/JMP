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
  }) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Theme.of(context).primaryColor),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
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

          // Grid untuk menampilkan kategori
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // 2 kolom
              padding: const EdgeInsets.all(16.0),
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
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
                ),
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
                ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

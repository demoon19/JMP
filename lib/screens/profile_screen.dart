import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? _userProfile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    var profile = await _authService.getUserProfile();
    setState(() {
      _userProfile = profile;
    });
  }

  void _logout() async {
    await _authService.logout();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  Widget _buildProfileInfo(String label, String value, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo.shade700),
        title: Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
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
              colors: [Colors.indigo.shade400, Colors.indigo.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Profil Pengguna',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _userProfile == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue[100],
                    child: Icon(
                      Icons.account_circle,
                      size: 90,
                      color: Colors.blue[600],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _userProfile!['name'] ?? 'Pengguna',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _userProfile!['email'] ?? 'email@contoh.com',
                    style: TextStyle(color: Colors.grey[600], fontSize: 15),
                  ),
                  const SizedBox(height: 24),

                  // Info Profile dalam bentuk Card List
                  _buildProfileInfo(
                    'Nama Lengkap',
                    _userProfile!['name'] ?? 'N/A',
                    Icons.person,
                  ),
                  _buildProfileInfo(
                    'NIM',
                    _userProfile!['nim'] ?? 'N/A',
                    Icons.badge,
                  ),
                  _buildProfileInfo(
                    'Email',
                    _userProfile!['email'] ?? 'N/A',
                    Icons.email,
                  ),
                  _buildProfileInfo(
                    'Tanggal Registrasi',
                    _userProfile!['registrationDate'] ?? 'N/A',
                    Icons.calendar_today,
                  ),

                  const SizedBox(height: 32),

                  // Tombol Logout
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _logout,
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

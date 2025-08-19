import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _loggedInKey = 'isLoggedIn';
  static const String _usersKey = 'users';
  static const String _userProfileKey = 'user_profile'; // Key baru

  // Fungsi internal untuk mengambil daftar semua pengguna
  Future<List<Map<String, dynamic>>> _getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final String? usersString = prefs.getString(_usersKey);
    if (usersString == null) {
      return [];
    }
    final List<dynamic> usersJson = jsonDecode(usersString);
    return usersJson.cast<Map<String, dynamic>>();
  }

  // Fungsi registrasi diperbarui
  Future<bool> register(String name, String nim, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> users = await _getUsers();

    // Cek apakah email atau NIM sudah terdaftar
    if (users.any((user) => user['email'] == email || user['nim'] == nim)) {
      return false; // Gagal karena email atau NIM sudah ada
    }

    // Tambahkan pengguna baru dengan data lengkap
    users.add({
      'name': name,
      'nim': nim,
      'email': email,
      'password': password,
      // Tambahkan tanggal registrasi secara otomatis
      'registrationDate': DateTime.now().toIso8601String().substring(0, 10),
    });
    await prefs.setString(_usersKey, jsonEncode(users));
    return true; // Registrasi berhasil
  }

  // Fungsi login diperbarui
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> users = await _getUsers();

    var userProfile = users.firstWhere(
      (user) => user['email'] == email && user['password'] == password,
      orElse: () => {},
    );

    if (userProfile.isNotEmpty) {
      await prefs.setBool(_loggedInKey, true);
      // Simpan seluruh profil pengguna yang login sebagai string JSON
      await prefs.setString(_userProfileKey, jsonEncode(userProfile));
      return true;
    }
    return false;
  }

  // Fungsi baru untuk mendapatkan profil pengguna yang sedang login
  Future<Map<String, dynamic>?> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final String? profileString = prefs.getString(_userProfileKey);
    if (profileString == null) {
      return null;
    }
    return jsonDecode(profileString);
  }

  // Fungsi logout diperbarui
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInKey);
    await prefs.remove(_userProfileKey); // Hapus profil saat logout
  }
  
  // Fungsi isLoggedIn tidak berubah
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }
}
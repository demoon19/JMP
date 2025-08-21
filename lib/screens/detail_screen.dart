import 'package:flutter/material.dart';
import '../models/student_model.dart';

class StudentDetailScreen extends StatelessWidget {
  final Student student;

  const StudentDetailScreen({super.key, required this.student});

  // Widget helper untuk menampilkan baris info agar rapi
  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
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
          'Detail Mahasiswa',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Agar card menyesuaikan ukuran konten
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      // Ikon diubah menggunakan gambar aset
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image(
                            image: AssetImage(
                              'assets/icon.png',
                            ), // Path ke gambar Anda
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        student.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Divider(height: 32),
                _buildInfoRow('NIM', student.nim, Icons.badge),
                _buildInfoRow(
                  'Tanggal Lahir',
                  student.tanggalLahir,
                  Icons.calendar_today,
                ),
                _buildInfoRow(
                  'Jenis Kelamin',
                  student.jenisKelamin,
                  Icons.person_outline,
                ),
                _buildInfoRow('Lokasi', student.lokasi, Icons.location_on),
                _buildInfoRow(
                    'Nomor Telepon', student.noTelepon, Icons.phone),
                _buildInfoRow(
                    'Program Studi', student.prodi, Icons.school),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
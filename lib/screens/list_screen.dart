import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jmp/screens/crud_screen.dart';
import 'package:jmp/screens/detail_screen.dart';
import '../models/student_model.dart';
import '../services/hive_service.dart';

class StudentListScreen extends StatelessWidget {
  StudentListScreen({super.key});

  final HiveService _hiveService = HiveService();

  // Fungsi untuk menampilkan dialog pilihan
  void _showOptionsDialog(BuildContext context, Student student) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Aksi'),
          content: Text(
            'Apa yang ingin Anda lakukan dengan data ${student.name}?',
          ),
          actions: <Widget>[
            // Tombol Lihat Data
            TextButton(
              child: const Text('Lihat Data'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentDetailScreen(student: student),
                  ),
                );
              },
            ),
            // Tombol Update Data
            TextButton(
              child: const Text('Update Data'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddEditStudentScreen(student: student),
                  ),
                );
              },
            ),
            // Tombol Hapus Data
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Hapus Data'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                _hiveService.deleteStudent(student.nim);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Data ${student.name} berhasil dihapus!'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Mahasiswa")),
      body: ValueListenableBuilder(
        valueListenable: _hiveService.getListenable(),
        builder: (context, Box<Student> box, _) {
          final students = box.values.toList().cast<Student>();
          if (students.isEmpty) {
            return const Center(child: Text("Tidak ada data mahasiswa."));
          }
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(student.jenisKelamin.substring(0, 1)),
                ),
                title: Text(student.name),
                subtitle: Text("NIM: ${student.nim} | Asal: ${student.lokasi}"),
                // ===================================
                // ===== PERUBAHAN UTAMA DI SINI =====
                // ===================================
                onTap: () {
                  _showOptionsDialog(context, student);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditStudentScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Tambah Mahasiswa',
      ),
    );
  }
}

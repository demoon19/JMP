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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
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
                    backgroundColor: Colors.redAccent,
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
          "Daftar Mahasiswa",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ValueListenableBuilder(
        valueListenable: _hiveService.getListenable(),
        builder: (context, Box<Student> box, _) {
          final students = box.values.toList().cast<Student>();
          if (students.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Tidak ada data mahasiswa.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 8.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 16.0,
                  ),
                  leading: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: Image(
                        image: AssetImage(
                          'assets/icon.png',
                        ), // Menggunakan ikon wisudawan
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                  title: Text(
                    student.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "NIM: ${student.nim} | Prodi: ${student.prodi}",
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    _showOptionsDialog(context, student);
                  },
                ),
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
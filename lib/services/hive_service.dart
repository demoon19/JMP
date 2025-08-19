import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/student_model.dart';

class HiveService {
  final Box<Student> _studentBox = Hive.box<Student>('students');

  // CREATE & UPDATE: Hive menggunakan 'put' untuk keduanya.
  // Jika key sudah ada, data akan di-update. Jika belum, data baru akan dibuat.
  Future<void> addOrUpdateStudent(Student student) async {
    // Kita gunakan NIM sebagai key unik
    await _studentBox.put(student.nim, student);
  }

  // READ (Single Student)
  Student? getStudent(String nim) {
    return _studentBox.get(nim);
  }

  // READ (All Students)
  List<Student> getAllStudents() {
    return _studentBox.values.toList();
  }

  // DELETE
  Future<void> deleteStudent(String nim) async {
    await _studentBox.delete(nim);
  }

  // Untuk UI Reaktif
  ValueListenable<Box<Student>> getListenable() {
    return _studentBox.listenable();
  }
}
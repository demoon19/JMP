import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/student_model.dart'; // Import model Anda
import 'screens/splash_screen.dart';

Future<void> main() async {
  // 1. Inisialisasi Hive
  await Hive.initFlutter();

  // 2. Registrasi Adapter yang sudah di-generate
  Hive.registerAdapter(StudentAdapter());

  // 3. Buka Box untuk menyimpan data mahasiswa
  await Hive.openBox<Student>('students');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kampusku App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
    );
  }
}

import 'package:hive/hive.dart';

part 'student_model.g.dart'; // File ini akan di-generate ulang

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String nim;

  @HiveField(3) // Lanjutkan penomoran
  late String tanggalLahir;

  @HiveField(4)
  late String jenisKelamin;

  @HiveField(5)
  late String lokasi;

  get prodi => null;
}

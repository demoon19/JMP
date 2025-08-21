// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 0;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..nim = fields[2] as String
      ..tanggalLahir = fields[3] as String
      ..jenisKelamin = fields[4] as String
      ..lokasi = fields[5] as String
      ..noTelepon = fields[6] as String
      ..prodi = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.nim)
      ..writeByte(3)
      ..write(obj.tanggalLahir)
      ..writeByte(4)
      ..write(obj.jenisKelamin)
      ..writeByte(5)
      ..write(obj.lokasi)
      ..writeByte(6)
      ..write(obj.noTelepon)
      ..writeByte(7)
      ..write(obj.prodi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
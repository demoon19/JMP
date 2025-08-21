import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/student_model.dart';
import '../services/hive_service.dart';

class AddEditStudentScreen extends StatefulWidget {
  final Student? student;

  const AddEditStudentScreen({super.key, this.student});

  @override
  State<AddEditStudentScreen> createState() => _AddEditStudentScreenState();
}

class _AddEditStudentScreenState extends State<AddEditStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final HiveService _hiveService = HiveService();

  late final TextEditingController _nameController;
  late final TextEditingController _nimController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _locationController;
  late final TextEditingController _phoneController;
  late final TextEditingController _prodiController;

  String? _selectedGender;
  final List<String> _genderOptions = ['Laki-laki', 'Perempuan'];

  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _nimController = TextEditingController();
    _birthDateController = TextEditingController();
    _locationController = TextEditingController();
    _phoneController = TextEditingController();
    _prodiController = TextEditingController();

    if (widget.student != null) {
      _isEditMode = true;
      _nameController.text = widget.student!.name;
      _nimController.text = widget.student!.nim;
      _birthDateController.text = widget.student!.tanggalLahir;
      _locationController.text = widget.student!.lokasi;
      _selectedGender = widget.student!.jenisKelamin;
      _phoneController.text = widget.student!.noTelepon;
      _prodiController.text = widget.student!.prodi;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    _birthDateController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    _prodiController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _birthDateController.text = formattedDate;
      });
    }
  }

  void _onSave() async {
    if (_formKey.currentState!.validate()) {
      final newStudent = Student()
        ..name = _nameController.text
        ..nim = _nimController.text
        ..tanggalLahir = _birthDateController.text
        ..jenisKelamin = _selectedGender!
        ..lokasi = _locationController.text
        ..noTelepon = _phoneController.text
        ..prodi = _prodiController.text
        ..id = _nimController.text;

      await _hiveService.addOrUpdateStudent(newStudent);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditMode
                ? 'Data berhasil diperbarui!'
                : 'Data berhasil ditambahkan!',
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap lengkapi semua field yang wajib diisi.'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
        title: Text(
          _isEditMode ? 'Edit Mahasiswa' : 'Tambah Mahasiswa',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // NIM
                  TextFormField(
                    controller: _nimController,
                    enabled: !_isEditMode,
                    decoration: const InputDecoration(
                      labelText: 'NIM',
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'NIM wajib diisi'
                        : null,
                  ),
                  const SizedBox(height: 16.0),

                  // Nama
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Lengkap',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Nama wajib diisi'
                        : null,
                  ),
                  const SizedBox(height: 16.0),

                  // Tanggal Lahir
                  TextFormField(
                    controller: _birthDateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Tanggal Lahir',
                      prefixIcon: Icon(Icons.calendar_today_outlined),
                    ),
                    onTap: _selectDate,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Tanggal lahir wajib diisi'
                        : null,
                  ),
                  const SizedBox(height: 16.0),

                  // Jenis Kelamin
                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    items: _genderOptions.map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedGender = newValue;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Jenis Kelamin',
                      prefixIcon: Icon(Icons.wc_outlined),
                    ),
                    validator: (value) =>
                        value == null ? 'Jenis kelamin wajib dipilih' : null,
                  ),
                  const SizedBox(height: 16.0),

                  // Lokasi
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Lokasi (Kota Asal)',
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Lokasi wajib diisi'
                        : null,
                  ),
                  const SizedBox(height: 16.0),

                  // Nomor Telepon
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Nomor Telepon',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Nomor telepon wajib diisi'
                        : null,
                  ),
                  const SizedBox(height: 16.0),

                  // Program Studi
                  TextFormField(
                    controller: _prodiController,
                    decoration: const InputDecoration(
                      labelText: 'Program Studi',
                      prefixIcon: Icon(Icons.school_outlined),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Program studi wajib diisi'
                        : null,
                  ),
                  const SizedBox(height: 24.0),

                  // Tombol Simpan
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .indigo, // Menambahkan warna background indigo
                        foregroundColor: Colors
                            .white, // Membuat teks menjadi putih agar kontras
                      ),
                      child: Text(
                        _isEditMode ? 'Perbarui' : 'Simpan',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

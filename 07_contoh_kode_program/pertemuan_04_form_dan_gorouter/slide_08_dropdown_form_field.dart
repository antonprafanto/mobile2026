// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 08: DROPDOWNBUTTONFORMFIELD
// TOPIK: Input pilihan terintegrasi validator form
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide08App());
}

class Slide08App extends StatelessWidget {
  const Slide08App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slide08Screen(),
    );
  }
}

class Slide08Screen extends StatefulWidget {
  const Slide08Screen({super.key});

  @override
  State<Slide08Screen> createState() => _Slide08ScreenState();
}

class _Slide08ScreenState extends State<Slide08Screen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedProdi;

  final List<String> _daftarProdi = [
    'Teknik Informatika',
    'Sistem Informasi',
    'Teknik Komputer',
    'Sains Data',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 08: DropdownButtonFormField'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih Program Studi Anda (Wajib Dipilih):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedProdi,
                decoration: const InputDecoration(
                  labelText: 'Program Studi',
                  prefixIcon: Icon(Icons.school_outlined),
                  border: OutlineInputBorder(),
                ),
                items: _daftarProdi.map((prodi) {
                  return DropdownMenuItem(
                    value: prodi,
                    child: Text(prodi),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedProdi = val;
                  });
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Program studi wajib dipilih!';
                  }
                  return null; // Lolos
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Prodi terpilih: $_selectedProdi'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFE600),
                  foregroundColor: Colors.black,
                ),
                child: const Text('VALIDASI PILIHAN DROPDOWN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

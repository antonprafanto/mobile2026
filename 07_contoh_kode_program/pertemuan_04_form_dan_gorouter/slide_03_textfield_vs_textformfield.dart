// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 03: DUA JENIS INPUT TEKS
// TOPIK: Perbedaan TextField (Search Bar) vs TextFormField (Form Validasi)
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide03App());
}

class Slide03App extends StatelessWidget {
  const Slide03App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const Slide03Screen(),
    );
  }
}

class Slide03Screen extends StatefulWidget {
  const Slide03Screen({super.key});

  @override
  State<Slide03Screen> createState() => _Slide03ScreenState();
}

class _Slide03ScreenState extends State<Slide03Screen> {
  final _formKey = GlobalKey<FormState>();
  String _hasilPencarian = '';
  String _hasilForm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 03: TextField vs TextFormField'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. CONTOH TEXTFIELD BIASA (KOLOM PENCARIAN)
            const Text(
              '1. CONTOH TEXTFIELD (Untuk Input Bebas / Search Bar):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Ketik untuk mencari sesuatu...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                setState(() {
                  _hasilPencarian = text;
                });
              },
            ),
            const SizedBox(height: 6),
            Text('Karakter pencarian: "$_hasilPencarian"', style: const TextStyle(color: Colors.blueGrey)),

            const Divider(height: 40, thickness: 2),

            // 2. CONTOH TEXTFORMFIELD CERDAS (UNTUK FORM DENGAN VALIDASI)
            const Text(
              '2. CONTOH TEXTFORMFIELD (Terintegrasi Form & Validator):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email Mahasiswa',
                      hintText: 'nama@mhs.kampus.ac.id',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Email wajib diisi, tidak boleh kosong!';
                      }
                      if (!val.contains('@')) {
                        return 'Format email harus memuat simbol @!';
                      }
                      return null; // Lolos
                    },
                    onSaved: (val) => _hasilForm = val ?? '',
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Lolos Validasi! Nilai tersimpan: $_hasilForm'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFE600),
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('SUBMIT TEXTFORMFIELD'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 10: LOGIKA VALIDATOR & REGEX KAMPUS
// TOPIK: Aturan kembalian null vs String galat & Regex @mhs.kampus.ac.id
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide10App());
}

class Slide10App extends StatelessWidget {
  const Slide10App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slide10Screen(),
    );
  }
}

class Slide10Screen extends StatefulWidget {
  const Slide10Screen({super.key});

  @override
  State<Slide10Screen> createState() => _Slide10ScreenState();
}

class _Slide10ScreenState extends State<Slide10Screen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 10: Validator & Regex Sanitasi'),
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
                'Coba masukkan email bebas, lalu bandingkan jika memakai domain resmi @mhs.kampus.ac.id:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'Email Kampus Resmi',
                  hintText: 'nama@mhs.kampus.ac.id',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // 1. Periksa teks kosong
                  if (value == null || value.trim().isEmpty) {
                    return 'Email tidak boleh kosong!';
                  }
                  // 2. Pola Regex domain resmi
                  final regex = RegExp(r'^[\w\.-]+@mhs\.kampus\.ac\.id$');
                  if (!regex.hasMatch(value.trim())) {
                    return 'Wajib menggunakan domain resmi: @mhs.kampus.ac.id';
                  }
                  // 3. Jika benar, WAJIB mengembalikan null!
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Lolos! Email resmi kampus terverifikasi.'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFE600),
                  foregroundColor: Colors.black,
                ),
                child: const Text('UJI REGEX EMAIL'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

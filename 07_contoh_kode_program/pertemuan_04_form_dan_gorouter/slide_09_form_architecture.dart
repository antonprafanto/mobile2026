// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 09: FORM & GLOBALKEY<FORMSTATE>
// TOPIK: Analogi Map Berkas & Stempel Legalisir untuk mengecek form serentak
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide09App());
}

class Slide09App extends StatelessWidget {
  const Slide09App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slide09Screen(),
    );
  }
}

class Slide09Screen extends StatefulWidget {
  const Slide09Screen({super.key});

  @override
  State<Slide09Screen> createState() => _Slide09ScreenState();
}

class _Slide09ScreenState extends State<Slide09Screen> {
  // Stempel Kunci Form
  final _formKey = GlobalKey<FormState>();

  void _kirimForm() {
    // 1 Perintah untuk memeriksa seluruh kolom di dalam Form:
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Seluruh isian lolos verifikasi!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 09: GlobalKey<FormState>'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Pasang kunci stempel pada widget Form
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? 'Nama wajib diisi!' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? 'Nomor telepon wajib diisi!' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _kirimForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFE600),
                  foregroundColor: Colors.black,
                ),
                child: const Text('STEMPEL FORMULIR (VALIDATE)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

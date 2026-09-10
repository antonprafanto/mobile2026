// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 11: UMPAN BALIK PENGGUNA (SNACKBAR)
// TOPIK: Menampilkan floating SnackBar hijau (sukses) dan merah (galat)
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide11App());
}

class Slide11App extends StatelessWidget {
  const Slide11App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slide11Screen(),
    );
  }
}

class Slide11Screen extends StatelessWidget {
  const Slide11Screen({super.key});

  void _tampilkanSnackBar(BuildContext context, bool sukses) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(sukses ? Icons.check_circle : Icons.error, color: Colors.black),
            const SizedBox(width: 10),
            Text(
              sukses ? 'Registrasi Berhasil Diproses!' : 'Koneksi Server Terputus!',
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: sukses ? const Color(0xFF4ADE80) : const Color(0xFFFB7185),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 11: SnackBar Feedback UX'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _tampilkanSnackBar(context, true),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4ADE80), foregroundColor: Colors.black),
              child: const Text('Uji Sukses (Hijau)'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () => _tampilkanSnackBar(context, false),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFB7185), foregroundColor: Colors.black),
              child: const Text('Uji Galat (Merah)'),
            ),
          ],
        ),
      ),
    );
  }
}

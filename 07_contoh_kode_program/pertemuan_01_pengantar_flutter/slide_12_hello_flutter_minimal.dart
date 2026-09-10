// =====================================================================
// SLIDE 12: HELLO FLUTTER MINIMAL (ANATOMI MAIN.DART)
// Topik: Baris Kode Minimal untuk Memulai Aplikasi Flutter
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

// 1. Pintu masuk eksekusi program
void main() {
  runApp(const HelloFlutterApp());
}

// 2. Widget induk pengatur tema dan navigasi
class HelloFlutterApp extends StatelessWidget {
  const HelloFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello Flutter',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      // 3. Halaman utama aplikasi
      home: const HelloHomeScreen(),
    );
  }
}

// 4. Struktur layar utama dengan Scaffold
class HelloHomeScreen extends StatelessWidget {
  const HelloHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halo Mahasiswa TI 2026'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flutter_dash, size: 72, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Selamat Datang di Pemrograman Mobile!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Ini adalah baris kode pertama Anda yang berhasil tampil.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

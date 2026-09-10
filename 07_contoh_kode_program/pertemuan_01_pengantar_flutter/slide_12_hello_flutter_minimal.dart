// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 12: ANATOMI MAIN.DART MINIMAL
// TOPIK: Baris Kode Terbersih & Paling Sederhana untuk Pemula Baru
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

// 1. PINTU MASUK UTAMA (void main)
// Fungsi ini yang pertama kali dicari dan dieksekusi oleh sistem Android/iOS.
void main() {
  runApp(const AplikasiPerdana());
}

// 2. WIDGET INDUK (MaterialApp)
// Membungkus seluruh aplikasi dengan standar tema Material 3 Google.
class AplikasiPerdana extends StatelessWidget {
  const AplikasiPerdana({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Perdana Mahasiswa',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFFFE600),
      ),
      // 3. KANVAS UTAMA (Scaffold)
      home: const HalamanUtama(),
    );
  }
}

// 4. HALAMAN TAMPILAN (StatelessWidget)
class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5), // Kanvas Warm Cream
      appBar: AppBar(
        title: const Text(
          'Halo Teknik Informatika 2026',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: const Color(0xFFFFE600), // Kuning Canary
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 3),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(6, 6)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.flutter_dash, size: 64, color: Color(0xFF02569B)),
              SizedBox(height: 16),
              Text(
                'Selamat Datang di Flutter!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Ini adalah baris kode pertama Anda yang berhasil dikompilasi ke layar!',
                style: TextStyle(fontSize: 13, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

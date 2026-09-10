// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 03: RELEVANSI INDUSTRI & SINGLE CODEBASE
// TOPIK: Simulasi Efisiensi Biaya & Waktu Flutter vs Dual Native Team
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide03EfisiensiApp());
}

class Slide03EfisiensiApp extends StatelessWidget {
  const Slide03EfisiensiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 03 - Single Codebase Simulator',
      theme: ThemeData(useMaterial3: true),
      home: const EfisiensiScreen(),
    );
  }
}

class EfisiensiScreen extends StatefulWidget {
  const EfisiensiScreen({super.key});

  @override
  State<EfisiensiScreen> createState() => _EfisiensiScreenState();
}

class _EfisiensiScreenState extends State<EfisiensiScreen> {
  int _jumlahFitur = 5;

  @override
  Widget build(BuildContext context) {
    // Perhitungan kalkulator komparasi:
    final waktuNativeBulan = (_jumlahFitur * 1.5).toStringAsFixed(1);
    final waktuFlutterBulan = (_jumlahFitur * 0.8).toStringAsFixed(1);
    const engineerNative = 6; // 3 Kotlin + 3 Swift
    const engineerFlutter = 3; // 3 Flutter/Dart

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('SLIDE 03: Mengapa Flutter di 2026?'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kalkulator Simulasi: Efisiensi Pengembangan Aplikasi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 6),
            const Text(
              'Geser slider jumlah fitur di bawah untuk melihat perbedaan waktu dan sumber daya antara pendekatan Native terpisah vs Flutter Single Codebase:',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(height: 16),

            // Slider Jumlah Fitur
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(3, 3)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estimasi Fitur Aplikasi yang Dibangun: $_jumlahFitur Fitur',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Slider(
                    value: _jumlahFitur.toDouble(),
                    min: 1,
                    max: 20,
                    divisions: 19,
                    activeColor: Colors.black,
                    label: '$_jumlahFitur Fitur',
                    onChanged: (val) =>
                        setState(() => _jumlahFitur = val.toInt()),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Kartu Pendekatan Lama (Native)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE4E6), // Light Red/Pink
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '❌ CARA LAMA: DUA TIM NATIVE TERPISAH',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Tim Android (Kotlin): 3 Engineer\n• Tim iOS (Swift): 3 Engineer\n• Total Engineer: $engineerNative Orang\n• Estimasi Waktu Rilis: $waktuNativeBulan Bulan\n• Kelemahan: Biaya 2x lipat, fitur Android dan iOS sering tidak sinkron!',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Kartu Pendekatan Modern (Flutter)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7), // Light Green
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '✅ CARA MODERN: FLUTTER SINGLE CODEBASE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• 1 Tim Gabungan (Dart): $engineerFlutter Engineer Cukup!\n• 1 Basis Kode: Otomatis jalan di Android, iPhone, Web, & Desktop\n• Estimasi Waktu Rilis: $waktuFlutterBulan Bulan (Lebih Cepat ~50%!)\n• Keunggulan: Sekali buat, rilis serentak di Google Play & App Store.',
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

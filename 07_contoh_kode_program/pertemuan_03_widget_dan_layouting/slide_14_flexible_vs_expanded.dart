// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 14: FLEXIBLE VS EXPANDED
// TOPIK: Perbedaan FlexFit.loose (Flexible) vs FlexFit.tight (Expanded)
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide14FlexApp());

class Slide14FlexApp extends StatelessWidget {
  const Slide14FlexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SLIDE 14 • FLEXIBLE VS EXPANDED',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color(0xFF38BDF8),
          elevation: 0,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.5),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Penjelasan Ringkas
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2.5),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                  ],
                ),
                child: const Text(
                  '• Flexible (FlexFit.loose): Mengizinkan anak berukuran LEBIH KECIL dari ruang jatahnya.\n'
                  '• Expanded (FlexFit.tight): Memaksa anak MELEBAR PENUH mengisi seluruh ruang jatahnya.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Kasus 1: Menggunakan Flexible (Longgar / Loose)
              const Text(
                '1. Menggunakan Flexible (fit: FlexFit.loose):',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
              ),
              const SizedBox(height: 6),
              Container(
                color: Colors.black12,
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: const Color(0xFF4ADE80),
                        child: const Text(
                          'Teks Pendek (Tidak Dipaksa Melebar)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Kasus 2: Menggunakan Expanded (Ketat / Tight)
              const Text(
                '2. Menggunakan Expanded (fit: FlexFit.tight):',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
              ),
              const SizedBox(height: 6),
              Container(
                color: Colors.black12,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: const Color(0xFFFFE600),
                        child: const Text(
                          'Teks Pendek (DIPAKSA MELEBAR PENUH!)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

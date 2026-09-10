// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 09: WIDGET SAFEAREA
// TOPIK: Menghindari Teks Tertutup Notch (Poni HP) atau Status Bar
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiSafeArea());
}

class AplikasiSafeArea extends StatelessWidget {
  const AplikasiSafeArea({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // Bungkus body dengan SafeArea agar tidak tertabrak poni kamera HP
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Teks ini aman karena dibungkus SafeArea!\n'
              'SafeArea otomatis memberi jarak di bagian atas (notch/kamera) '
              'dan bagian bawah (gesture bar HP).',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

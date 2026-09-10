// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 22: TRIK KOMA AJAIB (TRAILING COMMA)
// TOPIK: Format Otomatis Rapi di VS Code dengan Koma di Akhir Kurung
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HalamanTrailingComma(),
    ),
  );
}

class HalamanTrailingComma extends StatelessWidget {
  const HalamanTrailingComma({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trik Koma Ajaib')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Perhatikan tanda koma di setiap akhir kurung penutup.'),
              SizedBox(height: 10),
              Text('Tekan Shift + Alt + F di VS Code untuk auto-format rapi!'),
            ], // <- Koma di sini
          ), // <- Koma di sini
        ), // <- Koma di sini
      ), // <- Koma di sini
    );
  }
}

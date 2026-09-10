// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 11: JEBAKAN COLOR VS DECORATION
// TOPIK: Solusi Error "Cannot provide both a color and a decoration"
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HalamanBoxDecoration(),
    ),
  );
}

class HalamanBoxDecoration extends StatelessWidget {
  const HalamanBoxDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aturan Warna Container')),
      body: Center(
        // ATURAN EMAS:
        // Jangan menulis 'color:' di luar jika sudah menggunakan 'decoration:'.
        // Pindahkan warna ke DALAM BoxDecoration(color: ...)!
        child: Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blue, // ✓ BENAR: Warna ada di dalam BoxDecoration
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              'BoxDecoration Benar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

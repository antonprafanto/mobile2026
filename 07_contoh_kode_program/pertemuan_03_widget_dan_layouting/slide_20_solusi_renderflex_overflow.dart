// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 20: SOLUSI RENDERFLEX OVERFLOW
// TOPIK: Mengatasi Garis Kuning-Hitam dengan Widget Expanded
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HalamanFixOverflow(),
    ),
  );
}

class HalamanFixOverflow extends StatelessWidget {
  const HalamanFixOverflow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solusi RenderFlex Overflow')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: const [
            Icon(Icons.info, color: Colors.blue, size: 30),
            SizedBox(width: 10),
            // SOLUSI: Bungkus teks panjang dengan Expanded agar tidak menabrak batas layar!
            Expanded(
              child: Text(
                'Teks yang sangat panjang ini aman dan tidak akan memicu '
                'garis kuning-hitam (overflow) karena dibungkus dengan widget Expanded.',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

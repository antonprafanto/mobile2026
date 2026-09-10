// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 23: PINTASAN REFACTOR ALT + ENTER
// TOPIK: Membungkus atau Membongkar Widget dengan Cepat Tanpa Mengetik Ulang
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HalamanRefactor(),
    ),
  );
}

class HalamanRefactor extends StatelessWidget {
  const HalamanRefactor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pintasan Alt + Enter')),
      body: Center(
        // Tips Praktik di VS Code:
        // Arahkan kursor ke kata 'Text' di bawah, lalu tekan Alt + Enter (atau Cmd + . di Mac).
        // Anda bisa langsung memilih 'Wrap with Padding', 'Wrap with Center', atau 'Remove this widget'.
        child: const Text(
          'Klik di sini lalu tekan Alt + Enter!',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 21: SOLUSI UNBOUNDED HEIGHT
// TOPIK: Memasang ListView di Dalam Column Menggunakan Expanded
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HalamanFixUnbounded(),
    ),
  );
}

class HalamanFixUnbounded extends StatelessWidget {
  const HalamanFixUnbounded({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solusi Unbounded Height')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Daftar di Bawah Berada di Dalam Column:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          // SOLUSI: Selalu bungkus ListView dengan Expanded jika ditaruh di dalam Column!
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(title: Text('Baris Data #${index + 1}'));
              },
            ),
          ),
        ],
      ),
    );
  }
}

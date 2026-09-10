// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 17: SINGLECHILDSCROLLVIEW
// TOPIK: Mencegah Form Tertutup Keyboard Saat Mengisi Data di HP
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: HalamanScroll()),
  );
}

class HalamanScroll extends StatelessWidget {
  const HalamanScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SingleChildScrollView')),
      // SingleChildScrollView membuat seluruh halaman bisa di-scroll
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Nama Mahasiswa'),
            ),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'NIM')),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Program Studi'),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Email Kampus'),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Alamat Rumah'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () {}, child: const Text('Simpan Data')),
          ],
        ),
      ),
    );
  }
}

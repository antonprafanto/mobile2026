// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 13: SIZEDBOX, SPACER, & EXPANDED
// TOPIK: Tiga Cara Mengatur Jarak Antar Elemen Tanpa Rumit
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: HalamanSpasi()),
  );
}

class HalamanSpasi extends StatelessWidget {
  const HalamanSpasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SizedBox vs Spacer vs Expanded')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. SizedBox: Jarak pasti / tetap
            const Text(
              '1. SizedBox (Jarak Tetap 20px):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(width: 50, height: 50, color: Colors.red),
                const SizedBox(width: 20), // Memberi spasi tetap 20px
                Container(width: 50, height: 50, color: Colors.green),
              ],
            ),
            const SizedBox(height: 24),

            // 2. Spacer: Mendorong elemen berikutnya ke ujung
            const Text(
              '2. Spacer (Mendorong ke Ujung Kanan):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Text('Judul di Kiri'),
                Spacer(), // Otomatis menghabiskan ruang kosong di tengah
                Icon(Icons.star, color: Colors.orange),
              ],
            ),
            const SizedBox(height: 24),

            // 3. Expanded: Membagi ruang secara proporsional
            const Text(
              '3. Expanded (Memenuhi Sisa Ruang):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 1, // 1 bagian
                  child: Container(
                    height: 40,
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        '1 Bagian',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2, // 2 bagian (dua kali lebih lebar)
                  child: Container(
                    height: 40,
                    color: Colors.teal,
                    child: const Center(
                      child: Text(
                        '2 Bagian',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

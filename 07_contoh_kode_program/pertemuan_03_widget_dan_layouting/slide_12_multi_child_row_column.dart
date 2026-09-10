// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 12: MULTI-CHILD (ROW & COLUMN)
// TOPIK: Menyusun Banyak Widget Secara Horizontal (Row) & Vertikal (Column)
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HalamanRowColumn(),
    ),
  );
}

class HalamanRowColumn extends StatelessWidget {
  const HalamanRowColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Row & Column')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Susunan Horizontal (Row):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Row menyusun elemen dari kiri ke kanan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(width: 50, height: 50, color: Colors.red),
                Container(width: 50, height: 50, color: Colors.green),
                Container(width: 50, height: 50, color: Colors.blue),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Susunan Vertikal (Column):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Column menyusun elemen dari atas ke bawah
            Column(
              children: [
                Container(
                  height: 30,
                  color: Colors.amber,
                  child: const Center(child: Text('Baris 1')),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 30,
                  color: Colors.cyan,
                  child: const Center(child: Text('Baris 2')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

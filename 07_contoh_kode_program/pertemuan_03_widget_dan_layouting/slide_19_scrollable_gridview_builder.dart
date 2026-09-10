// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 19: GRIDVIEW.BUILDER
// TOPIK: Menampilkan Item dalam Bentuk Kolom Grid (2 Kolom)
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HalamanGridView(),
    ),
  );
}

class HalamanGridView extends StatelessWidget {
  const HalamanGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GridView.builder')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        // Menentukan 2 kolom dengan jarak spasi 10px
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.blue[100 * ((index % 5) + 1)],
            child: Center(
              child: Text(
                'Kotak #${index + 1}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

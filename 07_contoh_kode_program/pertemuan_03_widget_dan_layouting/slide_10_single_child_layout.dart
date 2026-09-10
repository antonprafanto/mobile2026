// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 10: SINGLE-CHILD LAYOUT
// TOPIK: Perbedaan Center, Padding, dan Container
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HalamanSingleChild(),
    ),
  );
}

class HalamanSingleChild extends StatelessWidget {
  const HalamanSingleChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Center, Padding, & Container')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Center: Meletakkan anak di tengah
          const Center(child: Text('Teks di Tengah (Center)')),
          const Divider(),

          // 2. Padding: Hanya memberi jarak tepi tanpa warna/border
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Teks dengan Padding 16px'),
          ),
          const Divider(),

          // 3. Container: Wadah serbaguna (warna, padding, margin)
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            color: Colors.amber[200],
            child: const Text('Teks di dalam Container Berwarna'),
          ),
        ],
      ),
    );
  }
}

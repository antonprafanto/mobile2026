// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 08: HUKUM BOX CONSTRAINTS
// TOPIK: "Constraints Down, Sizes Up, Parent Sets Position"
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HalamanConstraints(),
    ),
  );
}

class HalamanConstraints extends StatelessWidget {
  const HalamanConstraints({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hukum Box Constraints')),
      body: Center(
        // 1. Constraints Down: SizedBox membatasi lebar 200 dan tinggi 50
        child: SizedBox(
          width: 200,
          height: 50,
          // 2. Sizes Up: Tombol menyesuaikan diri dengan batas induk
          child: ElevatedButton(
            onPressed: () {},
            // 3. Parent Sets Position: Center menempatkan tombol tepat di tengah
            child: const Text('Ukuran Diatur Induk'),
          ),
        ),
      ),
    );
  }
}

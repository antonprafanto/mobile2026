// =====================================================================
// SLIDE 05: INPUTDECORATION & KEYBOARD UX
// Topik: Memilih keyboardType yang Tepat & Menghias Kolom Input
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const InputDecorationDemoApp());
}

class InputDecorationDemoApp extends StatelessWidget {
  const InputDecorationDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 05 - Input UX',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: const InputUxScreen(),
    );
  }
}

class InputUxScreen extends StatelessWidget {
  const InputUxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 05: Desain Input & Keyboard'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // 1. Input Teks Biasa (Capitalize Words)
          TextField(
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap (Huruf Kapital Awal Kata)',
              hintText: 'Contoh: Ahmad Dahlan',
              prefixIcon: Icon(Icons.badge_outlined),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // 2. Input Angka (keyboardType: number)
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Nomor Induk Mahasiswa (NIM)',
              hintText: 'Hanya angka, contoh: 2026001001',
              helperText: 'Papan ketik numerik akan terbuka di HP',
              prefixIcon: Icon(Icons.numbers),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // 3. Input Email (keyboardType: emailAddress)
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Alamat Email',
              hintText: 'nama@kampus.ac.id',
              helperText: 'Menyediakan tombol @ dan .com di keyboard HP',
              prefixIcon: Icon(Icons.alternate_email),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // 4. Input Multi-baris / Catatan (maxLines)
          TextField(
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              labelText: 'Catatan / Alasan Minat Studi',
              hintText: 'Tuliskan deskripsi singkat Anda di sini...',
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

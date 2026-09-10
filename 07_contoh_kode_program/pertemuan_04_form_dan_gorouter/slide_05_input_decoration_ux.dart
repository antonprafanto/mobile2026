// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 05: DESAIN UX INPUT & KEYBOARD TYPE
// TOPIK: Mempercantik kolom dengan label, hint, ikon, dan papan ketik HP
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide05App());
}

class Slide05App extends StatelessWidget {
  const Slide05App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slide05Screen(),
    );
  }
}

class Slide05Screen extends StatelessWidget {
  const Slide05Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 05: InputDecoration & UX'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Kolom 1: Keyboard Angka (Telepon/NIM)
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nomor WhatsApp / HP',
                hintText: '0812xxxxxxxx',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Kolom 2: Keyboard Email (Ada Simbol @)
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Kampus',
                hintText: 'nama@mhs.kampus.ac.id',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Kolom 3: Kolom Catatan Multi-Line
            TextFormField(
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: 'Catatan Keperluan Mahasiswa',
                hintText: 'Tuliskan alasan pengajuan di sini...',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

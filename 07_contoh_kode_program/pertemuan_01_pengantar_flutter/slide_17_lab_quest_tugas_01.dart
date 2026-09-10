// =====================================================================
// SLIDE 17: SOLUSI LAB QUEST TUGAS 01
// Topik: Kartu Identitas Mahasiswa Interaktif dengan Counter Like
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const TugasPraktikum01App());
}

class TugasPraktikum01App extends StatelessWidget {
  const TugasPraktikum01App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Praktikum 01',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const KartuMahasiswaScreen(),
    );
  }
}

class KartuMahasiswaScreen extends StatefulWidget {
  const KartuMahasiswaScreen({super.key});

  @override
  State<KartuMahasiswaScreen> createState() => _KartuMahasiswaScreenState();
}

class _KartuMahasiswaScreenState extends State<KartuMahasiswaScreen> {
  int _likes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas Praktikum 01'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 36,
                    child: Icon(Icons.person, size: 40),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Anton Prafanto',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'NIM: 2026001001 • Teknik Informatika',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const Divider(height: 24),
                  const Text(
                    'Halo! Saya mahasiswa Teknik Informatika yang sedang '
                    'mempelajari Pemrograman Perangkat Bergerak menggunakan Flutter.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _likes++;
                      });
                    },
                    icon: const Icon(Icons.thumb_up, color: Colors.teal),
                    label: Text('Sukai Profil ($_likes)'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

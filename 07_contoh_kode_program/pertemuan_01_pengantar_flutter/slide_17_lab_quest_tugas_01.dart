// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 17: SOLUSI MASTER LAB QUEST MODUL 01
// TOPIK: Hello Flutter, Personalisasi Nama/NIM Mahasiswa, Tema, & Counter
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// 3. Tunjukkan ke Dosen / Asisten Lab untuk penilaian Modul 1!
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const TugasPraktikum01App());
}

class TugasPraktikum01App extends StatefulWidget {
  const TugasPraktikum01App({super.key});

  @override
  State<TugasPraktikum01App> createState() => _TugasPraktikum01AppState();
}

class _TugasPraktikum01AppState extends State<TugasPraktikum01App> {
  // Mahasiswa bisa memilih warna tema favorit:
  Color _warnaTema = Colors.teal;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Praktikum 01',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: _warnaTema),
      home: HalamanTugas(
        onColorChanged: (newColor) {
          setState(() => _warnaTema = newColor);
        },
      ),
    );
  }
}

class HalamanTugas extends StatefulWidget {
  final ValueChanged<Color> onColorChanged;
  const HalamanTugas({super.key, required this.onColorChanged});

  @override
  State<HalamanTugas> createState() => _HalamanTugasState();
}

class _HalamanTugasState extends State<HalamanTugas> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text(
          'Praktikum Mobile - Tugas 01',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Kartu Identitas Mahasiswa
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2.5),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(5, 5)),
                ],
              ),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Color(0xFFFFE600),
                    child: Icon(Icons.person, size: 40, color: Colors.black),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Ahmad Fauzan Pratama',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'NIM: 2210511099 • Teknik Informatika 2026',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Pilihan Warna Tema Seed
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(3, 3)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pilih Tema Warna Aplikasi (seedColor):',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildThemeChip('Teal', Colors.teal),
                      _buildThemeChip('Amber', Colors.amber),
                      _buildThemeChip('Indigo', Colors.indigo),
                      _buildThemeChip('Rose', Colors.pink),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Kartu Counter Interaktif
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(3, 3)),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Uji Coba Interaktivitas (Counter):',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_counter',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () => setState(() => _counter++),
                    icon: const Icon(Icons.touch_app),
                    label: const Text('Klik Saya (+1)'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeChip(String label, Color color) {
    return InkWell(
      onTap: () => widget.onColorChanged(color),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black, width: 1.5),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}

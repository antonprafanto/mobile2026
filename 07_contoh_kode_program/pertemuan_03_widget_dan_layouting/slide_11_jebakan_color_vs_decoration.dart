// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 11: JEBAKAN COLOR VS DECORATION
// TOPIK: Solusi Error "Cannot provide both a color and a decoration"
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide11ColorBugApp());

class Slide11ColorBugApp extends StatelessWidget {
  const Slide11ColorBugApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SLIDE 11 • JEBAKAN COLOR VS DECORATION',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color(0xFFFB7185),
          elevation: 0,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.5),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Kartu Penjelasan
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2.5),
                    boxShadow: const [
                      BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jebakan Maut Mahasiswa Pemula:',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '❌ KODE PENYEBAB CRASH LAYAR MERAH:\n'
                        'Container(\n'
                        '  color: Colors.yellow, // ❌ ERROR CRASH!\n'
                        '  decoration: BoxDecoration(...),\n'
                        ')\n\n'
                        '✓ SOLUSI BENAR:\n'
                        'Pindahkan properti warna ke dalam BoxDecoration(color: Colors.yellow)!',
                        style: TextStyle(
                          fontFamily: 'Consolas',
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Implementasi Kode Benar (Neo-Brutalist Card)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFFFFE600,
                    ), // ✓ Warna di dalam BoxDecoration!
                    border: Border.all(color: Colors.black, width: 3),
                    boxShadow: const [
                      BoxShadow(color: Colors.black, offset: Offset(6, 6)),
                    ],
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.check_circle, size: 48, color: Colors.black),
                      SizedBox(height: 10),
                      Text(
                        '✓ BERHASIL DITAMPILKAN SEMPURNA!',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Warna berada di dalam BoxDecoration, sehingga tidak memicu konflik compiler.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

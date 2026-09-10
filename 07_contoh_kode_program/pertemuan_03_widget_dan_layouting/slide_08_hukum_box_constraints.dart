// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 08: HUKUM EMAS BOX CONSTRAINTS
// TOPIK: "Constraints Down, Sizes Up, Parent Sets Position"
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide08ConstraintsApp());

class Slide08ConstraintsApp extends StatefulWidget {
  const Slide08ConstraintsApp({super.key});

  @override
  State<Slide08ConstraintsApp> createState() => _Slide08ConstraintsAppState();
}

class _Slide08ConstraintsAppState extends State<Slide08ConstraintsApp> {
  double _parentWidth = 260.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SLIDE 08 • HUKUM BOX CONSTRAINTS',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color(0xFFFFE600),
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
                // Kartu Edukasi
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
                    children: [
                      Text(
                        'Tiga Hukum Tata Letak Flutter:',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '1. Constraints Down: Induk memberi batas min/max lebar & tinggi ke anak.\n'
                        '2. Sizes Up: Anak menentukan ukurannya sendiri di dalam batas tersebut.\n'
                        '3. Parent Sets Position: Induk menentukan koordinat posisi anak di layar.',
                        style: TextStyle(fontSize: 13, height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Slider Batasan Induk
                Text(
                  'Ubah Lebar Maksimal Induk: ${_parentWidth.toInt()} px',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Slider(
                  value: _parentWidth,
                  min: 150.0,
                  max: 340.0,
                  activeColor: Colors.black,
                  inactiveColor: Colors.grey,
                  onChanged: (val) => setState(() => _parentWidth = val),
                ),
                const SizedBox(height: 16),

                // Induk (SizedBox) dengan batas lebar
                Container(
                  width: _parentWidth,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'KOTAK INDUK (MEMBATASI)',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Anak memutuskan ukurannya sendiri
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4ADE80),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          side: const BorderSide(color: Colors.black, width: 2),
                          shape: const RoundedRectangleBorder(),
                        ),
                        child: const Text(
                          'ANAK: ELEVATED BUTTON',
                          textAlign: TextAlign.center,
                        ),
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

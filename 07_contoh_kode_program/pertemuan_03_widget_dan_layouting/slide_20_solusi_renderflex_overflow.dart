// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 20: SOLUSI RENDERFLEX OVERFLOW
// TOPIK: Mengatasi Galat Garis Kuning-Hitam "A RenderFlex overflowed"
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide20OverflowFixApp());

class Slide20OverflowFixApp extends StatefulWidget {
  const Slide20OverflowFixApp({super.key});

  @override
  State<Slide20OverflowFixApp> createState() => _Slide20OverflowFixAppState();
}

class _Slide20OverflowFixAppState extends State<Slide20OverflowFixApp> {
  bool _useFix = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SLIDE 20 • SOLUSI RENDERFLEX OVERFLOW',
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2.5),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Penyebab Error Garis Kuning-Hitam:',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Terjadi ketika teks atau deretan widget di dalam Row melebihi lebar layar fisik HP.\n'
                      'Tiga Solusi Standar Industri:\n'
                      '1. Bungkus teks dengan widget Expanded.\n'
                      '2. Tambahkan properti overflow: TextOverflow.ellipsis.\n'
                      '3. Gunakan SingleChildScrollView(scrollDirection: Axis.horizontal).',
                      style: TextStyle(fontSize: 12, height: 1.4),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => setState(() => _useFix = !_useFix),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _useFix
                            ? const Color(0xFF4ADE80)
                            : const Color(0xFFFB7185),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        side: const BorderSide(color: Colors.black, width: 2),
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: Text(
                        _useFix
                            ? '✓ MODE SOLUSI: EXPANDED (AKTIF)'
                            : '⚠ MODE ASLI: BIKIN OVERFLOW',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Kotak Uji
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE600),
                  border: Border.all(color: Colors.black, width: 2.5),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info, size: 28),
                    const SizedBox(width: 10),
                    if (_useFix)
                      // SOLUSI: Bungkus dengan Expanded agar teks menghormati batas layar!
                      const Expanded(
                        child: Text(
                          'Teks ini sangat panjang sekali hingga pasti menabrak batas kanan layar jika tidak dilindungi Expanded!',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    else
                      // TANPA EXPANDED: Di layar HP sempit akan memicu error garis kuning-hitam!
                      const Text(
                        'Teks ini sangat panjang sekali hingga pasti menabrak batas kanan layar jika tidak dilindungi Expanded!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

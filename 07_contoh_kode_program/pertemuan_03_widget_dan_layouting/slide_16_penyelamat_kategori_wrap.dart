// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 16: PENYELAMAT KATEGORI (WIDGET WRAP)
// TOPIK: Solusi Anti-Overflow untuk Daftar Tag, Kategori & Chip
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide16WrapApp());

class Slide16WrapApp extends StatefulWidget {
  const Slide16WrapApp({super.key});

  @override
  State<Slide16WrapApp> createState() => _Slide16WrapAppState();
}

class _Slide16WrapAppState extends State<Slide16WrapApp> {
  final List<String> _skills = [
    'Flutter 2026',
    'Dart Modern',
    'GoRouter',
    'Material 3',
    'Sound Null Safety',
    'REST API',
    'Firebase BaaS',
    'Cubit State',
    'Clean Architecture',
  ];

  bool _useWrap = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SLIDE 16 • WIDGET WRAP',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color(0xFF4ADE80),
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
              // Penjelasan
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
                      'Mengapa Butuh Wrap?',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Jika deretan tombol chip ditaruh di dalam Row, saat melewati batas layar akan terjadi '
                      'ERROR GARIS KUNING-HITAM (OVERFLOW).\n'
                      'Widget Wrap secara otomatis melipat baris ke bawah saat ruang horizontal habis!',
                      style: TextStyle(fontSize: 13, height: 1.4),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => setState(() => _useWrap = !_useWrap),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _useWrap
                            ? const Color(0xFFFB7185)
                            : const Color(0xFF4ADE80),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        side: const BorderSide(color: Colors.black, width: 2),
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: Text(
                        _useWrap
                            ? 'UBAH KE ROW (LIHAT POTENSI OVERFLOW)'
                            : 'KEMBALIKAN KE WRAP (AMAN)',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Daftar Keahlian Mobile (${_useWrap ? "Mode: Wrap" : "Mode: Row"}):',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),

              // Wadah Uji Coba
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE600),
                  border: Border.all(color: Colors.black, width: 2.5),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(5, 5)),
                  ],
                ),
                child: _useWrap
                    ? Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: _skills.map((s) => _buildChip(s)).toList(),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _skills
                              .map(
                                (s) => Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: _buildChip(s),
                                ),
                              )
                              .toList(),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(2, 2))],
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}

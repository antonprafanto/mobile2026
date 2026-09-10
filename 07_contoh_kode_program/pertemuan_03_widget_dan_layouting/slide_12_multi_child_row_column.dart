// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 12: MULTI-CHILD LAYOUT (ROW & COLUMN)
// TOPIK: Menguasai MainAxisAlignment & CrossAxisAlignment
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide12RowColumnApp());

class Slide12RowColumnApp extends StatefulWidget {
  const Slide12RowColumnApp({super.key});

  @override
  State<Slide12RowColumnApp> createState() => _Slide12RowColumnAppState();
}

class _Slide12RowColumnAppState extends State<Slide12RowColumnApp> {
  MainAxisAlignment _mainAlign = MainAxisAlignment.spaceBetween;
  CrossAxisAlignment _crossAlign = CrossAxisAlignment.center;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SLIDE 12 • ROW & COLUMN LAYOUT',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color(0xFF38BDF8),
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
              // Kontrol Interaktif
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
                      'Atur MainAxisAlignment (Sumbu Utama Row = Horizontal):',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _btnAlign('Start', MainAxisAlignment.start),
                        _btnAlign('Center', MainAxisAlignment.center),
                        _btnAlign('End', MainAxisAlignment.end),
                        _btnAlign(
                          'SpaceBetween',
                          MainAxisAlignment.spaceBetween,
                        ),
                        _btnAlign('SpaceAround', MainAxisAlignment.spaceAround),
                        _btnAlign('SpaceEvenly', MainAxisAlignment.spaceEvenly),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Kotak Visualisasi Row
              Container(
                height: 140,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE600),
                  border: Border.all(color: Colors.black, width: 2.5),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(5, 5)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: _mainAlign,
                  crossAxisAlignment: _crossAlign,
                  children: [
                    _boxItem('1', const Color(0xFF4ADE80), 50),
                    _boxItem('2', const Color(0xFF38BDF8), 70),
                    _boxItem('3', const Color(0xFFFB7185), 45),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Mode Aktif: $_mainAlign',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _btnAlign(String title, MainAxisAlignment align) {
    final isSelected = _mainAlign == align;
    return ElevatedButton(
      onPressed: () => setState(() => _mainAlign = align),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.black : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        elevation: 0,
        side: const BorderSide(color: Colors.black, width: 1.5),
        shape: const RoundedRectangleBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _boxItem(String label, Color col, double h) {
    return Container(
      width: 50,
      height: h,
      color: col,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
      ),
    );
  }
}

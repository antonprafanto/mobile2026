// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 03: FILOSOFI EVERYTHING IS A WIDGET
// TOPIK: Memahami Penyusunan Antarmuka Secara Hierarkis (Analogi Lego)
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide03LegoApp());

class Slide03LegoApp extends StatelessWidget {
  const Slide03LegoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: const LegoInspectorScreen(),
    );
  }
}

class LegoInspectorScreen extends StatelessWidget {
  const LegoInspectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SLIDE 03 • EVERYTHING IS A WIDGET',
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Balok Luar 1: Container Utama (Bingkai Lego)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 3),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(6, 6)),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Balok Anak 2: Icon Widget
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE600),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: const Icon(
                        Icons.widgets,
                        size: 48,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Balok Anak 3: Text Widget Judul
                    const Text(
                      'Semua Adalah Widget!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Balok Anak 4: Text Widget Penjelasan
                    const Text(
                      'Teks ini adalah widget.\n'
                      'Jarak spasi (SizedBox) adalah widget.\n'
                      'Pewarnaan latar (Container) adalah widget.\n'
                      'Perataan ke tengah (Center) adalah widget!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, height: 1.4),
                    ),
                    const SizedBox(height: 16),

                    // Balok Anak 5: Tombol Widget
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Anda menekan balok ElevatedButton!'),
                            backgroundColor: Colors.black,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF38BDF8),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        side: const BorderSide(color: Colors.black, width: 2),
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: const Text(
                        'KLIK SAYA (ELEVATED BUTTON)',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Hierarki: Center -> Container -> Column -> [Container, SizedBox, Text, ElevatedButton]',
                style: TextStyle(
                  fontFamily: 'Consolas',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

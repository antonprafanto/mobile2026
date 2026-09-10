// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 23: SHORTCUT REFACTOR & INSPECTOR
// TOPIK: Menguasai Pintasan Sakti Alt+Enter & Debug Visual UI
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide23InspectorApp());

class Slide23InspectorApp extends StatelessWidget {
  const Slide23InspectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SLIDE 23 • REFACTOR SHORTCUTS',
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pintasan Sakti Pemrograman Flutter di VS Code:',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1. Alt + Enter (atau Cmd + . di Mac):\n'
                      '   Arahkan kursor ke nama Widget -> tekan Alt+Enter untuk:\n'
                      '   • Wrap with Padding\n'
                      '   • Wrap with Center\n'
                      '   • Wrap with Column / Row\n'
                      '   • Remove this widget (Membongkar widget tanpa repot hapus kurung!)\n\n'
                      '2. Flutter Inspector (Widget Tree Visualizer):\n'
                      '   Buka tab Flutter di bilah samping VS Code untuk melihat '
                      '   garis batas piksel asli di layar secara langsung!',
                      style: TextStyle(fontSize: 13, height: 1.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Contoh Kartu Latihan Refactor
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF38BDF8),
                  border: Border.all(color: Colors.black, width: 2.5),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Coba arahkan kursor ke kata "Center" di baris 75 file ini, '
                    'lalu tekan Alt + Enter untuk melihat menu refactor sakti!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

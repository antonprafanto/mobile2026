// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 12: GESTUREDTECTOR VS INKWELL
// TOPIK: Membandingkan sentuhan mentah vs riak air Material Splash Effect
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide12App());
}

class Slide12App extends StatelessWidget {
  const Slide12App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slide12Screen(),
    );
  }
}

class Slide12Screen extends StatefulWidget {
  const Slide12Screen({super.key});

  @override
  State<Slide12Screen> createState() => _Slide12ScreenState();
}

class _Slide12ScreenState extends State<Slide12Screen> {
  String _statusSentuh = 'Sentuh salah satu kotak di bawah:';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 12: GestureDetector vs InkWell'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(_statusSentuh, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // 1. GestureDetector (Sentuhan Mentah Tanpa Efek Visual)
            GestureDetector(
              onTap: () {
                setState(() => _statusSentuh = 'Kotak GestureDetector disentuh (tanpa animasi riak air)!');
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                color: const Color(0xFF38BDF8),
                child: const Text('1. GESTUREDTECTOR (Mentah)', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),

            // 2. InkWell (Sentuhan Ber-animasi Riak Air Material Splash)
            Material(
              color: const Color(0xFFFFE600),
              child: InkWell(
                onTap: () {
                  setState(() => _statusSentuh = 'Kotak InkWell disentuh (ada efek cipratan riak air tinta)!');
                },
                splashColor: Colors.black26,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
                  child: const Text('2. INKWELL (Ada Ripple Splash)', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

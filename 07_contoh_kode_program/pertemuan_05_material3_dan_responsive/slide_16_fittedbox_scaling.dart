// =====================================================================
// SLIDE 16: FITTEDBOX & SKALA TEKS (ANTI-OVERFLOW PADA FONT BESAR)
// Topik: Menyesuaikan Ukuran Teks Saat Aksesibilitas Sistem Ditinggikan
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const FittedBoxDemoApp());
}

class FittedBoxDemoApp extends StatelessWidget {
  const FittedBoxDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 16 - FittedBox Scaling',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: const FittedBoxScreen(),
    );
  }
}

class FittedBoxScreen extends StatelessWidget {
  const FittedBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 16: FittedBox Scaling'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Contoh Box Lebar Tetap (240dp):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Wadah terbatas dengan FittedBox
            Container(
              width: 240,
              padding: const EdgeInsets.all(12),
              color: Colors.deepPurple.shade50,
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'RP 150.000.000.000,-',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '💡 Keuntungan FittedBox: Teks angka/nominal saldo rekening bank '
                  'tidak akan pernah menyebabkan error garis kuning-hitam (A RenderFlex overflowed) '
                  'karena otomatis dikecilkan (scaleDown) agar pas di dalam batas wadahnya.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

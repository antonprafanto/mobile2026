// =====================================================================
// SLIDE 07: RESPONSIF 1: MEDIAQUERY (DIMENSI LAYAR GLOBAL)
// Topik: Membaca Ukuran Layar Fisik & Rasio Aspek Perangkat
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const MediaQueryDemoApp());
}

class MediaQueryDemoApp extends StatelessWidget {
  const MediaQueryDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 07 - MediaQuery',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const MediaQueryScreen(),
    );
  }
}

class MediaQueryScreen extends StatelessWidget {
  const MediaQueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Membaca ukuran layar global perangkat
    final size = MediaQuery.sizeOf(context);
    final orientation = MediaQuery.orientationOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 07: MediaQuery'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.straighten),
                title: const Text('Lebar Layar Total (Screen Width)'),
                subtitle: Text('${size.width.toStringAsFixed(1)} dp'),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.height),
                title: const Text('Tinggi Layar Total (Screen Height)'),
                subtitle: Text('${size.height.toStringAsFixed(1)} dp'),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.screen_rotation),
                title: const Text('Orientasi Layar'),
                subtitle: Text(
                  orientation == Orientation.portrait
                      ? 'Portrait (Tegak)'
                      : 'Landscape (Miring)',
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '⚠️ Catatan: MediaQuery mengukur SELURUH layar perangkat, bukan ruang '
              'yang tersisa di dalam widget tertentu.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// SLIDE 15: DETEKSI LAYAR & HARDWARE PERANGKAT (MEDIAQUERY)
// Topik: Membaca Dimensi, Orientasi, dan Rasio Piksel Layar
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const DeviceInfoDemoApp());
}

class DeviceInfoDemoApp extends StatelessWidget {
  const DeviceInfoDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 15 - Device Info',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: const DeviceInfoScreen(),
    );
  }
}

class DeviceInfoScreen extends StatelessWidget {
  const DeviceInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isPortrait = media.orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 15: Informasi Layar Perangkat'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.aspect_ratio),
              title: const Text('Dimensi Layar (Logical Pixel)'),
              subtitle: Text(
                'Lebar: ${media.size.width.toStringAsFixed(1)} dp\n'
                'Tinggi: ${media.size.height.toStringAsFixed(1)} dp',
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(
                isPortrait
                    ? Icons.stay_current_portrait
                    : Icons.stay_current_landscape,
              ),
              title: const Text('Orientasi Layar'),
              subtitle: Text(
                isPortrait ? 'Portrait (Tegak)' : 'Landscape (Mendatar)',
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.density_medium),
              title: const Text('Device Pixel Ratio (DPR)'),
              subtitle: Text('${media.devicePixelRatio.toStringAsFixed(2)}x'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text('Kecerahan Tema Sistem'),
              subtitle: Text(
                media.platformBrightness == Brightness.dark
                    ? 'Dark Mode (Gelap)'
                    : 'Light Mode (Terang)',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SLIDE 02: TOOLS & PREVIEW RESPONSIF
// Topik: Menguji UI Responsif di Browser Chrome dengan Menarik Ukuran Jendela
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// Tips: Tarik tepi jendela browser Chrome untuk melihat perubahan ukuran layar!
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveToolsApp());
}

class ResponsiveToolsApp extends StatelessWidget {
  const ResponsiveToolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 02 - Uji Responsif',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const ResponsiveToolsScreen(),
    );
  }
}

class ResponsiveToolsScreen extends StatelessWidget {
  const ResponsiveToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Membaca lebar layar secara real-time saat jendela diubah ukurannya
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 02: Uji Ukuran Jendela'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isMobile ? Icons.phone_android : Icons.laptop,
                size: 72,
                color: isMobile ? Colors.orange : Colors.green,
              ),
              const SizedBox(height: 16),
              Text(
                isMobile
                    ? 'Tampilan: Mobile (<600dp)'
                    : 'Tampilan: Tablet / Desktop (>=600dp)',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Lebar jendela saat ini: ${screenWidth.toStringAsFixed(1)} dp',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Trik Lab: Jalankan perintah "flutter run -d chrome" lalu tarik '
                    'sisi kanan jendela Chrome untuk menyimulasikan layar HP dan Tablet '
                    'tanpa memerlukan emulator Android yang berat.',
                    textAlign: TextAlign.center,
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

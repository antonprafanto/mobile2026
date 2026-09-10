// =====================================================================
// SLIDE 14: SOLUSI LAB RAM 8GB (FLUTTER RUN DI WEB / CHROME)
// Topik: Menjalankan Aplikasi Mobile di Browser Tanpa Emulator Berat
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const ChromePreviewApp());
}

class ChromePreviewApp extends StatelessWidget {
  const ChromePreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 14 - Web Preview',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const ChromePreviewScreen(),
    );
  }
}

class ChromePreviewScreen extends StatelessWidget {
  const ChromePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 14: Preview Ringan di Chrome'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.laptop_chromebook,
                      size: 56,
                      color: Colors.indigo,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Target Kompilasi: Chrome',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Emulator Android membutuhkan RAM 2GB - 4GB.\n'
                      'Dengan Chrome, memori yang terpakai < 150MB dan '
                      'Hot Reload bekerja sangat cepat!',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.terminal, color: Colors.green),
                      title: const Text('Perintah Terminal:'),
                      subtitle: const Text('flutter run -d chrome'),
                      dense: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

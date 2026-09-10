// =====================================================================
// SLIDE 05: STRUKTUR DIREKTORI FEATURE-FIRST
// Topik: Mengapa Skala Enterprise Mengelompokkan Kode Berdasarkan Fitur
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const FeatureFirstDemoApp());
}

class FeatureFirstDemoApp extends StatelessWidget {
  const FeatureFirstDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    const tree = '''
lib/
├── core/
│   ├── network/      # HTTP Client / Dio
│   └── di/           # Service Locator (injection.dart)
└── features/
    ├── auth/         # Fitur Login & Register
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    └── product/      # Fitur Katalog Produk
        ├── data/
        ├── domain/
        └── presentation/
''';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 05 - Feature-First',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber),
      home: Scaffold(
        appBar: AppBar(title: const Text('Slide 05: Struktur Feature-First')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hierarki Folder Standar Industri 2026:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      tree,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        color: Colors.lightGreenAccent,
                        fontSize: 13,
                      ),
                    ),
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

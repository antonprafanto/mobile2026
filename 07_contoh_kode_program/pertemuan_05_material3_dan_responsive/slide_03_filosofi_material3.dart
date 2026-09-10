// =====================================================================
// SLIDE 03: FILOSOFI DESAIN MATERIAL 3 (M3)
// Topik: Mengaktifkan useMaterial3: true & Menikmati Komponen Modern Google
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Material3DemoApp());
}

class Material3DemoApp extends StatelessWidget {
  const Material3DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 03 - Material 3',
      // Mengaktifkan sistem desain Material 3 Google
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const Material3Screen(),
    );
  }
}

class Material3Screen extends StatelessWidget {
  const Material3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 03: Komponen Material 3'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. FilledButton khas Material 3
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.check),
                label: const Text('FilledButton (Standar Utama M3)'),
              ),
              const SizedBox(height: 12),

              // 2. FilledButton.tonal (Warna sekunder lembut)
              FilledButton.tonalIcon(
                onPressed: () {},
                icon: const Icon(Icons.bookmark_border),
                label: const Text('FilledButton.tonal (Kontras Sedang)'),
              ),
              const SizedBox(height: 12),

              // 3. OutlinedButton
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                label: const Text('OutlinedButton (Garis Tepi Halus)'),
              ),
              const SizedBox(height: 24),

              // 4. Card Material 3
              const Card(
                elevation: 1,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Ciri Khas M3: Sudut membulat alami (12dp), bayangan elevasi '
                    'halus, dan pewarnaan tonal harmonis dari benih warna utama.',
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

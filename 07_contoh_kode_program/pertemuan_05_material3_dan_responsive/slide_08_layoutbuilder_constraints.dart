// =====================================================================
// SLIDE 08: RESPONSIF 2: LAYOUTBUILDER (BATASAN WIDGET LOKAL)
// Topik: Membaca Ruang Tersedia dari Widget Induk (BoxConstraints)
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const LayoutBuilderDemoApp());
}

class LayoutBuilderDemoApp extends StatelessWidget {
  const LayoutBuilderDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 08 - LayoutBuilder',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: const LayoutBuilderScreen(),
    );
  }
}

class LayoutBuilderScreen extends StatelessWidget {
  const LayoutBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 08: LayoutBuilder'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // constraints.maxWidth membaca ruang yang diberikan oleh parent
            final isNarrow = constraints.maxWidth < 500;

            return Column(
              children: [
                Text(
                  'Ruang Tersedia: ${constraints.maxWidth.toStringAsFixed(1)} dp',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                if (isNarrow)
                  // Tampilan vertikal (Column) jika ruang sempit
                  const Column(
                    children: [
                      Card(child: ListTile(title: Text('Kartu 1 (Vertikal)'))),
                      SizedBox(height: 8),
                      Card(child: ListTile(title: Text('Kartu 2 (Vertikal)'))),
                    ],
                  )
                else
                  // Tampilan horizontal (Row) jika ruang lapang
                  const Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: ListTile(title: Text('Kartu 1 (Horizontal)')),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Card(
                          child: ListTile(title: Text('Kartu 2 (Horizontal)')),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 24),
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Perbedaan Kunci: LayoutBuilder jauh lebih fleksibel daripada MediaQuery '
                      'karena widget dapat menyesuaikan diri di dalam split-view atau dialog kecil!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

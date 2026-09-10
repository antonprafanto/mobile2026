// =====================================================================
// SLIDE 10: ORIENTATIONBUILDER (TEGAK VS MIRING)
// Topik: Merespons Rotasi Layar Smartphone (Portrait vs Landscape)
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const OrientationDemoApp());
}

class OrientationDemoApp extends StatelessWidget {
  const OrientationDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 10 - OrientationBuilder',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
      home: const OrientationScreen(),
    );
  }
}

class OrientationScreen extends StatelessWidget {
  const OrientationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 10: OrientationBuilder'),
        centerTitle: true,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isPortrait
                          ? Icons.smartphone
                          : Icons.screen_rotation,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isPortrait
                          ? 'Mode: PORTRAIT (Tegak)'
                          : 'Mode: LANDSCAPE (Miring)',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.count(
                    // 2 kolom jika portrait, 4 kolom jika landscape
                    crossAxisCount: isPortrait ? 2 : 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: List.generate(8, (index) {
                      return Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: Center(
                          child: Text(
                            'Item ${index + 1}',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

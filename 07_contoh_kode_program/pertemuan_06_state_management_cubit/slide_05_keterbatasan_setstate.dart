// =====================================================================
// SLIDE 05: KETERBATASAN SETSTATE & JEBAKAN PROP DRILLING
// Topik: Mengapa Mengoper Callback Melewati Banyak Widget Berbahaya
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const PropDrillingDemoApp());
}

class PropDrillingDemoApp extends StatefulWidget {
  const PropDrillingDemoApp({super.key});

  @override
  State<PropDrillingDemoApp> createState() => _PropDrillingDemoAppState();
}

class _PropDrillingDemoAppState extends State<PropDrillingDemoApp> {
  int _counter = 0;

  void _increment() {
    setState(() => _counter++);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 05 - Prop Drilling',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber),
      home: Scaffold(
        appBar: AppBar(title: const Text('Slide 05: Masalah Prop Drilling')),
        body: Center(
          // Kakek harus mengoper callback ke Ayah, lalu Ayah ke Cucu:
          child: LevelAyahWidget(counter: _counter, onIncrement: _increment),
        ),
      ),
    );
  }
}

// Widget Perantara (Ayah) - Terpaksa memegang data yang tidak ia gunakan!
class LevelAyahWidget extends StatelessWidget {
  final int counter;
  final VoidCallback onIncrement;

  const LevelAyahWidget({
    super.key,
    required this.counter,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Widget Ayah (Hanya Titipan Kurir)'),
            const SizedBox(height: 12),
            LevelCucuWidget(counter: counter, onIncrement: onIncrement),
          ],
        ),
      ),
    );
  }
}

// Widget Ujung (Cucu) - Konsumen data sesungguhnya
class LevelCucuWidget extends StatelessWidget {
  final int counter;
  final VoidCallback onIncrement;

  const LevelCucuWidget({
    super.key,
    required this.counter,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Skor di Cucu: $counter',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        FilledButton.icon(
          onPressed: onIncrement,
          icon: const Icon(Icons.add),
          label: const Text('Tambah Skor via Callback'),
        ),
      ],
    );
  }
}

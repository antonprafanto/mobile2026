// =====================================================================
// SLIDE 13: MEMBEDAH DEFAULT COUNTER APP
// Topik: Memahami setState() dengan Tambah, Kurang, dan Reset
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const CounterDeepDiveApp());
}

class CounterDeepDiveApp extends StatelessWidget {
  const CounterDeepDiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 13 - Counter Deep Dive',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  // Variabel penampung state di memori
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 13: Counter Deep Dive'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Anda telah menekan tombol sebanyak:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _decrement,
                    icon: const Icon(Icons.remove),
                    label: const Text('Kurang'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: _reset,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: _increment,
                    icon: const Icon(Icons.add),
                    label: const Text('Tambah'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Tambah',
        child: const Icon(Icons.add),
      ),
    );
  }
}

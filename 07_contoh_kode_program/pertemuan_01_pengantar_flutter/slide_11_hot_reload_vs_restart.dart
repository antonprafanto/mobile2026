// =====================================================================
// SLIDE 11: HOT RELOAD VS HOT RESTART
// Topik: Memahami Perbedaan Mempertahankan State vs Reset State
// =====================================================================
// Jalankan dengan: flutter run -d chrome (atau F5 di VS Code)
// Coba tekan 'r' (Hot Reload) dan 'R' (Hot Restart) di terminal!
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const HotReloadDemoApp());
}

class HotReloadDemoApp extends StatelessWidget {
  const HotReloadDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 11 - Hot Reload vs Restart',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const HotReloadScreen(),
    );
  }
}

class HotReloadScreen extends StatefulWidget {
  const HotReloadScreen({super.key});

  @override
  State<HotReloadScreen> createState() => _HotReloadScreenState();
}

class _HotReloadScreenState extends State<HotReloadScreen> {
  int _counter = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 11: Hot Reload vs Restart'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Nilai State di Memori:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                '$_counter',
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => setState(() => _counter++),
                    icon: const Icon(Icons.add),
                    label: const Text('Tambah (+1)'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () => setState(() => _counter = 0),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset (0)'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Eksperimen Mahasiswa:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '1. Tambah angka hingga misal 15.\n'
                        '2. Tekan "r" di terminal (Hot Reload) -> Angka tetap 15!\n'
                        '3. Tekan "R" di terminal (Hot Restart) -> Angka kembali ke 10.',
                      ),
                    ],
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

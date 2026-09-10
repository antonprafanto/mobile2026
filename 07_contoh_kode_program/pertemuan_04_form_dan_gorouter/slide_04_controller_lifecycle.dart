// =====================================================================
// SLIDE 04: TEXTEDITINGCONTROLLER & SIKLUS HIDUP (ANTI MEMORY LEAK)
// Topik: Membaca, Mengubah, Mengosongkan, & Wajib dispose()
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const ControllerLifecycleApp());
}

class ControllerLifecycleApp extends StatelessWidget {
  const ControllerLifecycleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 04 - Controller Lifecycle',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const ControllerDemoScreen(),
    );
  }
}

class ControllerDemoScreen extends StatefulWidget {
  const ControllerDemoScreen({super.key});

  @override
  State<ControllerDemoScreen> createState() => _ControllerDemoScreenState();
}

class _ControllerDemoScreenState extends State<ControllerDemoScreen> {
  // 1. Deklarasi controller di dalam State
  final TextEditingController _nameController = TextEditingController();
  String _liveText = '';

  @override
  void initState() {
    super.initState();
    // Mendengarkan perubahan input secara real-time
    _nameController.addListener(() {
      setState(() {
        _liveText = _nameController.text;
      });
    });
  }

  @override
  void dispose() {
    // 2. WAJIB: Bersihkan controller saat widget dimusnahkan agar tidak bocor di RAM
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 04: Controller & dispose()'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Ketik Nama Lengkap Anda',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Mengosongkan kolom input secara terprogram
                      _nameController.clear();
                    },
                    icon: const Icon(Icons.clear),
                    label: const Text('Bersihkan'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Mengubah teks input secara terprogram
                      _nameController.text = 'Budi Raharjo';
                    },
                    icon: const Icon(Icons.auto_fix_high),
                    label: const Text('Set Otomatis'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status Controller di Memori:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Teks terbaca: "${_liveText.isEmpty ? "(masih kosong)" : _liveText}"',
                      style: const TextStyle(fontSize: 16, color: Colors.teal),
                    ),
                    const Divider(height: 24),
                    const Text(
                      'Peringatan Penting:\n'
                      'Setiap objek TextEditingController wajib ditutup menggunakan dispose() '
                      'di dalam blok override dispose() agar tidak terjadi Memory Leak.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

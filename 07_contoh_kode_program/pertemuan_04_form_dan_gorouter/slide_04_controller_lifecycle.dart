// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 04: TEXTEDITINGCONTROLLER & DISPOSE
// TOPIK: Membaca teks, mengosongkan teks, dan mencegah kebocoran memori RAM
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide04App());
}

class Slide04App extends StatelessWidget {
  const Slide04App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slide04Screen(),
    );
  }
}

class Slide04Screen extends StatefulWidget {
  const Slide04Screen({super.key});

  @override
  State<Slide04Screen> createState() => _Slide04ScreenState();
}

class _Slide04ScreenState extends State<Slide04Screen> {
  // 1. Inisialisasi Controller
  final _namaController = TextEditingController();
  String _teksTerbaca = '-';

  // 2. WAJIB DISPOSE: Mencegah Kebocoran Memori (Memory Leak)
  @override
  void dispose() {
    _namaController.dispose(); // Matikan remote pengendali teks!
    super.dispose();
  }

  void _bacaTeks() {
    setState(() {
      _teksTerbaca = _namaController.text;
    });
  }

  void _kosongkanKolom() {
    _namaController.clear();
    setState(() {
      _teksTerbaca = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 04: Controller & Lifecycle'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Remote Pengendali Input Teks (TextEditingController):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Ketik Nama Anda',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _bacaTeks,
                  icon: const Icon(Icons.search),
                  label: const Text('BACA TEKS'),
                ),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: _kosongkanKolom,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('KOSONGKAN'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              color: Colors.amber.shade100,
              child: Text(
                'Nilai di controller saat ini:
"$_teksTerbaca"',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 07: SIKLUS HIDUP STATEFUL WIDGET
// TOPIK: Memahami initState(), build(), dan dispose()
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HalamanSiklusHidup(),
    ),
  );
}

class HalamanSiklusHidup extends StatefulWidget {
  const HalamanSiklusHidup({super.key});

  @override
  State<HalamanSiklusHidup> createState() => _HalamanSiklusHidupState();
}

class _HalamanSiklusHidupState extends State<HalamanSiklusHidup> {
  late TextEditingController _controller;
  int _counter = 0;

  // 1. Dijalankan TEPAT 1 KALI saat widget pertama kali dibuat
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    print('1. initState() dipanggil: Controller berhasil disiapkan');
  }

  // 2. Dijalankan SETIAP KALI setState() dipanggil untuk menggambar layar
  @override
  Widget build(BuildContext context) {
    print('2. build() dipanggil: Merender tampilan layar');
    return Scaffold(
      appBar: AppBar(title: const Text('Siklus Hidup StatefulWidget')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Ketik sesuatu',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Nilai Counter: $_counter',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Panggil setState()'),
            ),
          ],
        ),
      ),
    );
  }

  // 3. Dijalankan saat widget dihancurkan (keluar halaman)
  @override
  void dispose() {
    _controller.dispose(); // Wajib agar memori RAM tidak bocor!
    print('3. dispose() dipanggil: Controller dibersihkan dari RAM');
    super.dispose();
  }
}

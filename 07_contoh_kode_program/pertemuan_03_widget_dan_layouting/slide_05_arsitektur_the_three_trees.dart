// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 05: THE THREE TREES
// TOPIK: Widget Tree (Konfigurasi), Element Tree, & RenderObject Tree
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiTigaPohon());
}

class AplikasiTigaPohon extends StatefulWidget {
  const AplikasiTigaPohon({super.key});

  @override
  State<AplikasiTigaPohon> createState() => _AplikasiTigaPohonState();
}

class _AplikasiTigaPohonState extends State<AplikasiTigaPohon> {
  Color _kotakWarna = Colors.blue;

  void _ubahWarna() {
    setState(() {
      _kotakWarna = (_kotakWarna == Colors.blue) ? Colors.orange : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Widget Tree: Dibuat ulang setiap build() dipanggil (sangat ringan).
    // 2. Element Tree: Menetap di memori untuk menghubungkan state.
    // 3. RenderObject Tree: Hanya menggambar ulang piksel yang berubah warna.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('The Three Trees')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                color: _kotakWarna,
                child: const Center(
                  child: Text(
                    'Kotak',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _ubahWarna,
                child: const Text('Ganti Warna Kotak'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

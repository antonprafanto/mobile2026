// =====================================================================
// SLIDE 07: KENDALI FOCUS & TUTUP KEYBOARD OTOMATIS
// Topik: Menutup Papan Ketik Virtual Saat Area Kosong Disentuh
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const KeyboardFocusApp());
}

class KeyboardFocusApp extends StatelessWidget {
  const KeyboardFocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 07 - Focus Control',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueGrey),
      home: const KeyboardFocusScreen(),
    );
  }
}

class KeyboardFocusScreen extends StatelessWidget {
  const KeyboardFocusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // GestureDetector membungkus Scaffold untuk mendeteksi ketukan di luar kolom input
    return GestureDetector(
      onTap: () {
        // Menghilangkan fokus dari input aktif dan menutup papan ketik HP
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Slide 07: Tutup Keyboard Otomatis'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Trik UX Terbaik di Flutter:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ketik sesuatu di kolom di bawah, lalu sentuh area kosong layar ini. '
                'Papan ketik akan otomatis tertutup rapi.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Kolom Uji Coba Fokus',
                  hintText: 'Sentuh untuk membuka keyboard...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.keyboard),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // Tombol eksplisit untuk menutup keyboard
                  FocusScope.of(context).unfocus();
                },
                icon: const Icon(Icons.keyboard_hide),
                label: const Text('Tutup Keyboard Manual'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

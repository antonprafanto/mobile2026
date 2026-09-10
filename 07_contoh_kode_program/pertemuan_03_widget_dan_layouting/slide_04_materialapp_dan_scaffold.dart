// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 04: MATERIALAPP & SCAFFOLD
// TOPIK: Pondasi Dasar Aplikasi & Slot Bawaan Scaffold
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiScaffold());
}

class AplikasiScaffold extends StatelessWidget {
  const AplikasiScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Scaffold adalah kerangka utama halaman (kanvas putih standar)
      home: Scaffold(
        // 1. Bilah Judul Atas
        appBar: AppBar(
          title: const Text('Contoh Dasar Scaffold'),
          backgroundColor: Colors.blue,
        ),
        // 2. Menu Samping (Tarik dari kiri layar)
        drawer: Drawer(
          child: ListView(
            children: const [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  'Menu Drawer',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              ListTile(title: Text('Beranda')),
              ListTile(title: Text('Pengaturan')),
            ],
          ),
        ),
        // 3. Konten Utama Layar
        body: const Center(
          child: Text(
            'Ini adalah area Body dari Scaffold.',
            style: TextStyle(fontSize: 16),
          ),
        ),
        // 4. Tombol Aksi Mengambang di Pojok Kanan Bawah
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 01: PENGENALAN FLUTTER
// CONTOH 06: Mengintip Siklus Hidup (Lifecycle) Aplikasi
// Topik: AppLifecycleListener mencatat setiap perubahan status aplikasi.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke lib/main.dart.
// 2. Jalankan: flutter run -d chrome  (atau di HP Android: flutter run)
// 3. Pindah ke tab/aplikasi lain, lalu kembali. Lihat catatannya.
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: HalamanSiklusHidup()));
}

class HalamanSiklusHidup extends StatefulWidget {
  const HalamanSiklusHidup({super.key});

  @override
  State<HalamanSiklusHidup> createState() => _HalamanSiklusHidupState();
}

class _HalamanSiklusHidupState extends State<HalamanSiklusHidup> {
  // "Pendengar" yang dikabari setiap kali status aplikasi berubah.
  late final AppLifecycleListener _pendengar;
  final List<String> _catatan = ['Aplikasi dibuka (resumed)'];

  @override
  void initState() {
    super.initState();
    _pendengar = AppLifecycleListener(onStateChange: _catatStatus);
  }

  void _catatStatus(AppLifecycleState status) {
    // Ambil jam sekarang dengan format JJ:MM:DD, misalnya 09:15:30.
    final String jam = DateTime.now().toIso8601String().substring(11, 19);
    setState(() {
      // insert(0, ...) = taruh catatan terbaru di urutan paling atas.
      _catatan.insert(0, '$jam  ->  ${status.name}');
    });
  }

  @override
  void dispose() {
    // WAJIB: lepaskan pendengar saat halaman ditutup agar memori tidak bocor.
    _pendengar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Siklus Hidup Aplikasi')),
      body: ListView.builder(
        itemCount: _catatan.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: const Icon(Icons.history),
            title: Text(_catatan[index]),
          );
        },
      ),
    );
  }
}

// STATUS YANG MUNGKIN MUNCUL:
// resumed  = tampil & bisa disentuh     inactive = tampil tapi tidak fokus
// hidden   = tidak terlihat              paused   = berjalan di latar belakang
// detached = mesin Flutter masih ada, tetapi tampilannya sudah terlepas

// =====================================================================
// SLIDE 11: UMPAN BALIK VISUAL SNACKBAR & SCAFFOLDMESSENGER
// Topik: Memberikan Notifikasi Mengambang (Floating SnackBar) & Aksi Batal
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const SnackBarFeedbackApp());
}

class SnackBarFeedbackApp extends StatelessWidget {
  const SnackBarFeedbackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 11 - SnackBar Feedback',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const SnackBarDemoScreen(),
    );
  }
}

class SnackBarDemoScreen extends StatelessWidget {
  const SnackBarDemoScreen({super.key});

  void _showSuccessSnackBar(BuildContext context) {
    // Menghapus SnackBar lama yang sedang antre jika ada
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    // Menampilkan SnackBar baru bergaya modern (floating)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text('Data pendaftaran berhasil disimpan ke server!'),
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'BATALKAN',
          textColor: Colors.amberAccent,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text('Penyimpanan data dibatalkan.'),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 11: Floating SnackBar'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.notifications_active_outlined,
                size: 64,
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              const Text(
                'Umpan Balik Responsif Standar M3',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Gunakan SnackBarBehavior.floating agar notifikasi tidak menempel '
                'kaku di tepi bawah layar perangkat.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _showSuccessSnackBar(context),
                icon: const Icon(Icons.send),
                label: const Text('Tampilkan SnackBar Sukses'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

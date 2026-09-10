// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 07: MENJINAKKAN KEYBOARD HP
// TOPIK: Pindah kolom otomatis dengan Next & menutup keyboard virtual
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome (atau di smartphone)
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide07App());
}

class Slide07App extends StatelessWidget {
  const Slide07App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slide07Screen(),
    );
  }
}

class Slide07Screen extends StatelessWidget {
  const Slide07Screen({super.key});

  void _submitData(BuildContext context) {
    // KUNCI EMAS: Tutup keyboard virtual seketika!
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Keyboard HP berhasil ditutup secara elegan!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 07: Unfocus & Keyboard Action'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Kolom 1: Menekan Enter HP otomatis pindah ke Kolom 2
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Kolom 1: Nama (Tekan panah Next pada keyboard HP)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Kolom 2: Menekan Enter HP menandakan Selesai (Done)
            TextFormField(
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Kolom 2: Catatan (Ikon centang Done)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => _submitData(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFE600),
                foregroundColor: Colors.black,
              ),
              child: const Text('SUBMIT & TUTUP KEYBOARD'),
            ),
          ],
        ),
      ),
    );
  }
}

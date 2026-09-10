// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 18: PREVIEW MODERN DART (PERTEMUAN 02)
// TOPIK: Sound Null Safety, Collections, dan Asynchronous (Future/delayed)
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide18PreviewDartApp());
}

class Slide18PreviewDartApp extends StatelessWidget {
  const Slide18PreviewDartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 18 - Preview Modern Dart',
      theme: ThemeData(useMaterial3: true),
      home: const PreviewDartScreen(),
    );
  }
}

class PreviewDartScreen extends StatefulWidget {
  const PreviewDartScreen({super.key});

  @override
  State<PreviewDartScreen> createState() => _PreviewDartScreenState();
}

class _PreviewDartScreenState extends State<PreviewDartScreen> {
  // 1. Sound Null Safety
  final String _namaWajib = 'Budi Santoso';
  String? _catatanOpsional; // Boleh null

  // 2. Asynchronous State
  bool _isLoading = false;
  String _hasilAsinkronus = 'Belum ada data dari server.';

  Future<void> _simulasiAmbilDataInternet() async {
    setState(() {
      _isLoading = true;
      _hasilAsinkronus = 'Sedang menghubungi server via jaringan...';
    });

    // Simulasi penundaan 2 detik layaknya mengambil data dari REST API:
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _hasilAsinkronus =
          '🚀 Sukses! Data jadwal kuliah berhasil diunduh dari cloud.';
    });
  }

  @override
  Widget build(BuildContext context) {
    // Penggunaan operator penjinak null (??)
    final catatanTampil = _catatanOpsional ?? '(Catatan masih kosong / null)';

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('SLIDE 18: Preview Materi Pertemuan 02 (Dart)'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian 1: Null Safety
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(3, 3)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '1. FITUR SOUND NULL SAFETY:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Text('• Nama Mahasiswa (Wajib): $_namaWajib'),
                  Text('• Catatan Khusus (Opsional): $catatanTampil'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFE600),
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black, width: 1.5),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _catatanOpsional = _catatanOpsional == null
                            ? 'Hadir tepat waktu di lab.'
                            : null;
                      });
                    },
                    child: Text(
                      _catatanOpsional == null
                          ? 'Isi Catatan'
                          : 'Kosongkan Catatan (Null)',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Bagian 2: Asinkronus (Future & async/await)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(3, 3)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '2. OPERASI ASINKRONUS (Future & async/await):',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Text(_hasilAsinkronus, style: const TextStyle(fontSize: 13)),
                  const SizedBox(height: 12),
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    )
                  else
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4ADE80),
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.black, width: 1.5),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: _simulasiAmbilDataInternet,
                      icon: const Icon(Icons.cloud_download),
                      label: const Text('Tarik Data Cloud (Delay 2 Detik)'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

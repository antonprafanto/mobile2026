// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 05: ARSITEKTUR GRAFIS FLUTTER
// TOPIK: Mengapa Flutter Menggambar Sendiri Pikselnya Tanpa Bridge?
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide05ArsitekturApp());
}

class Slide05ArsitekturApp extends StatelessWidget {
  const Slide05ArsitekturApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 05 - Arsitektur Grafis',
      theme: ThemeData(useMaterial3: true),
      home: const ArsitekturScreen(),
    );
  }
}

class ArsitekturScreen extends StatefulWidget {
  const ArsitekturScreen({super.key});

  @override
  State<ArsitekturScreen> createState() => _ArsitekturScreenState();
}

class _ArsitekturScreenState extends State<ArsitekturScreen> {
  int _modeIndex = 2; // Default ke Flutter Impeller

  final List<Map<String, dynamic>> _models = [
    {
      'judul': '1. Native Murni (Kotlin / Swift)',
      'alur': 'Kode App -> Platform Native OEM Widgets -> Layar GPU',
      'kelebihan': 'Sangat cepat dan responsif.',
      'kekurangan': 'Wajib menulis 2 aplikasi berbeda untuk Android dan iOS.',
      'warna': const Color(0xFFE2E8F0),
    },
    {
      'judul': '2. Hybrid WebView (Cordova / Ionic)',
      'alur': 'HTML/CSS/JS -> Web Browser Internal (WebView) -> Layar GPU',
      'kelebihan': 'Cukup bisa membuat website biasa.',
      'kekurangan':
          'Berat, scroll patah-patah, tidak terasa seperti aplikasi mobile asli.',
      'warna': const Color(0xFFFFE4E6),
    },
    {
      'judul': '3. Canvas Engine (Flutter Impeller)',
      'alur': 'Kode Dart -> Impeller Graphics Engine -> GPU Canvas Layar',
      'kelebihan':
          'Bebas jembatan penerjemah (bridge), tampilan 100% konsisten di semua HP, mulus 120 FPS!',
      'kekurangan':
          'Ukuran file instalasi awal (APK) sedikit lebih besar (~15-20MB).',
      'warna': const Color(0xFFDCFCE7),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final modeAktif = _models[_modeIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('SLIDE 05: Komparasi Arsitektur Grafis'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sentuh Pilihan Arsitektur untuk Mempelajari Alurnya:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Column(
              children: List.generate(_models.length, (i) {
                final isSelected = _modeIndex == i;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () => setState(() => _modeIndex = i),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFFFE600)
                            : Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            offset: isSelected
                                ? const Offset(2, 2)
                                : const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        _models[i]['judul'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            // Kartu Alur
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: modeAktif['warna'],
                border: Border.all(color: Colors.black, width: 2.5),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(5, 5)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🚀 ALUR KOMPILASI & GAMBAR:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    child: Text(
                      modeAktif['alur'],
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    '✅ Kelebihan:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  Text(
                    modeAktif['kelebihan'],
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '⚠️ Konsekuensi / Catatan:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  Text(
                    modeAktif['kekurangan'],
                    style: const TextStyle(fontSize: 13),
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

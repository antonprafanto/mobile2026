// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 09: EKSPLORER STRUKTUR FOLDER FLUTTER
// TOPIK: Membedah Folder lib/, pubspec.yaml, android/, ios/, & web/
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide09FolderExplorerApp());
}

class Slide09FolderExplorerApp extends StatelessWidget {
  const Slide09FolderExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 09 - Struktur Folder',
      theme: ThemeData(useMaterial3: true),
      home: const FolderExplorerScreen(),
    );
  }
}

class FolderExplorerScreen extends StatefulWidget {
  const FolderExplorerScreen({super.key});

  @override
  State<FolderExplorerScreen> createState() => _FolderExplorerScreenState();
}

class _FolderExplorerScreenState extends State<FolderExplorerScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _folders = [
    {
      'name': '📁 lib/ (RUMAH UTAMA CODING)',
      'badge': 'WAJIB DIPAHAMI 100%',
      'color': const Color(0xFFFFE600), // Kuning
      'desc':
          'Tempat seluruh kode Dart kita tinggal. 99% waktu praktikum semester ini Anda akan berkutat di dalam folder ini!',
      'files': [
        'main.dart (Pintu gerbang aplikasi dimulai)',
        'screens/ (Halaman antarmuka)',
        'widgets/ (Komponen kustom)',
      ],
    },
    {
      'name': '📜 pubspec.yaml (KTP & DAFTAR BELANJA)',
      'badge': 'SANGAT PENTING',
      'color': const Color(0xFF38BDF8), // Biru
      'desc':
          'Menyimpan identitas nama aplikasi, versi rilis, dependensi pustaka luar (packages), dan pendaftaran aset gambar/font.',
      'files': [
        'dependencies: paket pihak ketiga',
        'assets: daftar gambar lokal',
      ],
    },
    {
      'name': '📁 android/ & 📁 ios/',
      'badge': 'JANGAN DIUBAH PEMULA',
      'color': const Color(0xFFFB7185), // Pink
      'desc':
          'Pembungkus native Gradle (Android) dan Xcode (iOS). Berkas di sini dihasilkan otomatis oleh Flutter. Jangan diubah kecuali Anda butuh setelan izin khusus (misal izin kamera).',
      'files': ['AndroidManifest.xml', 'build.gradle', 'Info.plist'],
    },
    {
      'name': '📁 web/',
      'badge': 'TARGET LAB HEMAT RAM',
      'color': const Color(0xFF4ADE80), // Hijau
      'desc':
          'Tempat berkas HTML/JS pembungkus untuk menjalankan aplikasi di browser Google Chrome tanpa membebani memori RAM komputer.',
      'files': ['index.html', 'manifest.json', 'favicon.png'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final active = _folders[_selectedIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('SLIDE 09: Eksplorer Struktur Folder Proyek'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sentuh Folder untuk Membaca Fungsinya bagi Pemula:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Column(
              children: List.generate(_folders.length, (i) {
                final isSelected = _selectedIndex == i;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () => setState(() => _selectedIndex = i),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? _folders[i]['color'] : Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            offset: isSelected
                                ? const Offset(1, 1)
                                : const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _folders[i]['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            color: Colors.black,
                            child: Text(
                              _folders[i]['badge'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),

            // Kartu Penjelasan
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2.5),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    active['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    active['desc'],
                    style: const TextStyle(fontSize: 13, height: 1.4),
                  ),
                  const Divider(color: Colors.black, thickness: 1, height: 20),
                  const Text(
                    '📄 Berkas Penting di Dalamnya:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  for (String f in active['files'])
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(
                        '• $f',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
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

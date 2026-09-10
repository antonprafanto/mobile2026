// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 02: ROADMAP PERKULIAHAN 16 MINGGU
// TOPIK: Rencana Capaian Belajar & Portofolio Mobile Developer 2026
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide02RoadmapApp());
}

class Slide02RoadmapApp extends StatelessWidget {
  const Slide02RoadmapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 02 - Roadmap Perkuliahan',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF4ADE80), // Neo Mint
      ),
      home: const RoadmapScreen(),
    );
  }
}

class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key});

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  int _selectedSprintIndex = 0;

  final List<Map<String, dynamic>> _sprints = [
    {
      'fase': 'FASE 1 • MINGGU 01-05',
      'judul': 'Fondasi Dart & Desain Layout UI Modern',
      'fokus':
          'Dart OOP, Null Safety, Widget Tree, GoRouter Navigasi, & Form Validasi.',
      'output':
          'Portofolio UI Aplikasi Portal Kampus Responsif & Bebas Overflow.',
      'warna': const Color(0xFFFFE600), // Canary Yellow
      'icon': Icons.layers_outlined,
    },
    {
      'fase': 'FASE 2 • MINGGU 06-08',
      'judul': 'State Management BLoC & Arsitektur Bersih',
      'fokus':
          'Cubit, BLoC Pattern, Immutable State, Clean Architecture, & Ujian Tengah Semester (UTS).',
      'output':
          'Aplikasi E-Commerce Katalog dengan Manajemen Keranjang Belanja Terpusat.',
      'warna': const Color(0xFF38BDF8), // Electric Cyan
      'icon': Icons.alt_route_rounded,
    },
    {
      'fase': 'FASE 3 • MINGGU 09-12',
      'judul': 'Networking Dio, Offline Database, & Cloud BaaS',
      'fokus':
          'Dio REST API Client, Offline-First SQLite/Drift, Firebase Auth & Firestore, Sensor Kamera/GPS.',
      'output':
          'Aplikasi Berita & Presensi Kampus yang Mampu Bekerja Luring (Offline-First).',
      'warna': const Color(0xFFC084FC), // Lavender
      'icon': Icons.cloud_sync_outlined,
    },
    {
      'fase': 'FASE 4 • MINGGU 13-16',
      'judul': 'Keamanan, Automated Testing, & Demo Day UAS',
      'fokus':
          'Security SSL Pinning, Unit & Widget Testing, DevTools Profiling, & Presentasi Publik.',
      'output':
          'Aplikasi Mobile Standar Industri Terpublikasi di GitHub & Portofolio Kerja.',
      'warna': const Color(0xFFFB7185), // Neo Coral
      'icon': Icons.verified_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final sprintAktif = _sprints[_selectedSprintIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5), // Warm Cream
      appBar: AppBar(
        title: const Text(
          'SLIDE 02: Roadmap Kuliah Mobile 2026',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Sambutan Pemula
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🎯 TARGET CAPAIAN SEMESTER INI',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Dalam 16 minggu ke depan, Anda akan bertransformasi dari mahasiswa yang belum pernah membuat aplikasi mobile menjadi engineer yang menguasai ekosistem industri modern!',
                    style: TextStyle(fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Tombol Pilihan Fase Sprint
            const Text(
              'Pilih Fase Perkuliahan untuk Membaca Detailnya:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_sprints.length, (index) {
                  final isSelected = _selectedSprintIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () => setState(() => _selectedSprintIndex = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _sprints[index]['warna']
                              : Colors.white,
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
                        child: Text(
                          'Fase ${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),

            // Kartu Detail Fase Aktif
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2.5),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(5, 5)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: sprintAktif['warna'],
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    child: Text(
                      sprintAktif['fase'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(sprintAktif['icon'], size: 28),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          sprintAktif['judul'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1.5,
                    height: 24,
                  ),
                  const Text(
                    '📌 Fokus Pembelajaran:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sprintAktif['fokus'],
                    style: const TextStyle(fontSize: 13, height: 1.4),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    '🏆 Bukti Output Portofolio:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Text(
                      sprintAktif['output'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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

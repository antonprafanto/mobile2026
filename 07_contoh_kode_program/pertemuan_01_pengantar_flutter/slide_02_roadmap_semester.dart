// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 02: ROADMAP PERKULIAHAN 16 MINGGU
// TOPIK: Empat Fase Pembelajaran Menjadi Pengembang Mobile Flutter
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiRoadmap());
}

class AplikasiRoadmap extends StatefulWidget {
  const AplikasiRoadmap({super.key});

  @override
  State<AplikasiRoadmap> createState() => _AplikasiRoadmapState();
}

class _AplikasiRoadmapState extends State<AplikasiRoadmap> {
  int _indexFase = 0;

  final List<Map<String, String>> _faseKuliah = [
    {
      'minggu': 'Fase 1 (Minggu 01 - 05)',
      'judul': 'Fondasi Dart & Desain Layout UI',
      'fokus': 'Dart Modern, Null Safety, Widget Tree, dan Form Validation.',
    },
    {
      'minggu': 'Fase 2 (Minggu 06 - 08)',
      'judul': 'State Management & Arsitektur Bersih',
      'fokus':
          'Cubit, BLoC Pattern, Clean Architecture, dan Ujian Tengah Semester.',
    },
    {
      'minggu': 'Fase 3 (Minggu 09 - 12)',
      'judul': 'Networking API & Cloud Backend',
      'fokus':
          'REST API Dio, Offline Caching, Firebase Auth & Cloud Firestore.',
    },
    {
      'minggu': 'Fase 4 (Minggu 13 - 16)',
      'judul': 'Pengujian, Keamanan, & Rilis Aplikasi',
      'fokus':
          'Unit Testing, DevTools Profiling, dan Pameran Akhir Aplikasi (UAS).',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final faseAktif = _faseKuliah[_indexFase];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Roadmap Perkuliahan Mobile 2026'),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih Fase untuk Melihat Rencana Belajar:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              // Pilihan 4 Fase
              Wrap(
                spacing: 8,
                children: List.generate(_faseKuliah.length, (i) {
                  return ChoiceChip(
                    label: Text('Fase ${i + 1}'),
                    selected: _indexFase == i,
                    onSelected: (selected) {
                      if (selected) setState(() => _indexFase = i);
                    },
                  );
                }),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              // Tampilan Detail Fase Terpilih
              Text(
                faseAktif['minggu']!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                faseAktif['judul']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                faseAktif['fokus']!,
                style: const TextStyle(fontSize: 14, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

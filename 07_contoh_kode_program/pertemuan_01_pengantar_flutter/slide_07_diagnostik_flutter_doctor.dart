// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 07: DIAGNOSTIK FLUTTER DOCTOR
// TOPIK: Membaca & Memahami Tanda Centang [✓], Tanda Seru [!], dan Silang [✗]
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide07DoctorApp());
}

class Slide07DoctorApp extends StatelessWidget {
  const Slide07DoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 07 - Flutter Doctor Diagnostik',
      theme: ThemeData(useMaterial3: true),
      home: const DoctorScreen(),
    );
  }
}

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final List<Map<String, dynamic>> _checklist = [
    {
      'title': 'Flutter SDK (Channel stable, 3.24.x / 3.27.x)',
      'status': 'OK',
      'detail':
          'Flutter SDK telah terpasang dengan benar di sistem komputer Anda.',
      'solusi': 'Jalankan "flutter --version" untuk memeriksa versi stabil.',
    },
    {
      'title': 'Android Toolchain - Android SDK',
      'status': 'WARN',
      'detail': 'Lisensi SDK Android belum disetujui sepenuhnya.',
      'solusi':
          'Ketik di terminal: "flutter doctor --android-licenses" lalu ketik y dan Enter.',
    },
    {
      'title': 'Chrome - develop for the web',
      'status': 'OK',
      'detail':
          'Browser Google Chrome terdeteksi. Target kompilasi tercepat untuk praktikum lab!',
      'solusi': 'Cukup ketik "flutter run -d chrome" untuk langsung mencoba.',
    },
    {
      'title': 'VS Code (version 1.9x)',
      'status': 'OK',
      'detail':
          'Editor kode utama terdeteksi dengan ekstensi Flutter terpasang.',
      'solusi':
          'Pastikan ekstensi resmi "Flutter" dan "Dart" sudah di-install dari Marketplace.',
    },
    {
      'title': 'Connected device (1 available)',
      'status': 'INFO',
      'detail':
          'Perangkat pengujian aktif tersedia (Chrome / Windows / HP Fisik).',
      'solusi':
          'Tancapkan HP fisik dengan kabel data USB jika ingin menguji di smartphone nyata.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('SLIDE 07: Simulasi flutter doctor'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _checklist.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF121212),
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                ],
              ),
              child: const Text(
                r'$ flutter doctor -v\n[Menganalisis kesehatan sistem instalasi...]',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Color(0xFF4ADE80),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          final item = _checklist[index - 1];
          Color badgeColor = const Color(0xFF4ADE80); // Hijau
          IconData iconData = Icons.check_circle;
          if (item['status'] == 'WARN') {
            badgeColor = const Color(0xFFFFE600); // Kuning
            iconData = Icons.warning_amber_rounded;
          } else if (item['status'] == 'INFO') {
            badgeColor = const Color(0xFF38BDF8); // Biru
            iconData = Icons.info_outline;
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
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
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: Icon(iconData, size: 18, color: Colors.black),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item['detail'],
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                ),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    border: Border.all(color: Colors.black54, width: 1),
                  ),
                  child: Text(
                    '💡 Tindakan: ${item['solusi']}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

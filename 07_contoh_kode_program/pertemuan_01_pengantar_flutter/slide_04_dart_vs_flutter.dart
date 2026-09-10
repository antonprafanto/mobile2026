// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 04: ANALOGI DART VS FLUTTER
// TOPIK: Membedakan Bahasa Logika (Dart) dengan Framework Tampilan (Flutter)
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide04DartVsFlutterApp());
}

// ---------------------------------------------------------------------
// 1. KODE DART (Logika Mesin Mobil & Pengolah Data)
// Dart murni tidak peduli tombol apa yang ada di layar,
// Dart hanya bertugas mengolah data dan aturan kerja (logic).
// ---------------------------------------------------------------------
class MesinMobil {
  final String merk;
  int kecepatanKmH = 0;

  MesinMobil({required this.merk});

  String bunyikanKlakson() {
    return '🔊 Tin! Tin! Mobil $merk siap meluncur!';
  }

  void injakGas() {
    kecepatanKmH += 20;
    if (kecepatanKmH > 180) kecepatanKmH = 180;
  }

  void injakRem() {
    kecepatanKmH -= 20;
    if (kecepatanKmH < 0) kecepatanKmH = 0;
  }
}

// ---------------------------------------------------------------------
// 2. KODE FLUTTER (Bodi Visual, Setir, & Tombol di Layar Pengguna)
// Flutter bertugas menggambar komponen yang bisa dilihat & disentuh user.
// ---------------------------------------------------------------------
class Slide04DartVsFlutterApp extends StatelessWidget {
  const Slide04DartVsFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 04 - Dart vs Flutter',
      theme: ThemeData(useMaterial3: true),
      home: const MobilScreen(),
    );
  }
}

class MobilScreen extends StatefulWidget {
  const MobilScreen({super.key});

  @override
  State<MobilScreen> createState() => _MobilScreenState();
}

class _MobilScreenState extends State<MobilScreen> {
  // Instansiasi mesin logika Dart:
  final _mobil = MesinMobil(merk: 'Tesla Model F');
  String _pesanStatus = 'Mesin menyala. Siap dikendarai!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('SLIDE 04: Dart (Mesin) vs Flutter (Bodi)'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Kartu Speedometer
              Container(
                width: 280,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 3),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(5, 5)),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'SPEEDOMETER',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${_mobil.kecepatanKmH}',
                      style: const TextStyle(
                        fontSize: 54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'KM / JAM',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Kotak Status Respon Dart
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2FE),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Text(
                  _pesanStatus,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),

              // Tombol-Tombol UI Flutter
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  // Tombol Klakson
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFE600),
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black, width: 2),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        // Memanggil method Dart murni
                        _pesanStatus = _mobil.bunyikanKlakson();
                      });
                    },
                    icon: const Icon(Icons.volume_up),
                    label: const Text(
                      'Klakson (Dart Method)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Tombol Gas
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4ADE80),
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black, width: 2),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _mobil.injakGas();
                        _pesanStatus =
                            'Gas diinjak! Kecepatan naik jadi ${_mobil.kecepatanKmH} km/h.';
                      });
                    },
                    icon: const Icon(Icons.speed),
                    label: const Text(
                      'Injak Gas (+20)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Tombol Rem
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFB7185),
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black, width: 2),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _mobil.injakRem();
                        _pesanStatus =
                            'Rem diinjak. Kecepatan turun jadi ${_mobil.kecepatanKmH} km/h.';
                      });
                    },
                    icon: const Icon(Icons.handyman),
                    label: const Text(
                      'Injak Rem (-20)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Penjelasan Ringkas Mahasiswa
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
                child: const Text(
                  '💡 Pelajaran Kunci:\n• Dart = Logika Mesin (Class MesinMobil, hitungan kecepatan, teks pesan).\n• Flutter = Tombol & Layar (ElevatedButton, Text, Scaffold, Container).\nAnda mengendalikan tampilan Flutter dengan menuliskan kode logika Dart!',
                  style: TextStyle(fontSize: 12, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 04: WIDGET & TATA LETAK
// CONTOH 06: Stack dan Positioned
// Topik: Menumpuk widget: lencana notifikasi, banner promo, dan foto
//        profil dengan titik status.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiStack());
}

class AplikasiStack extends StatelessWidget {
  const AplikasiStack({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: const HalamanStack(),
    );
  }
}

class HalamanStack extends StatelessWidget {
  const HalamanStack({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Stack dan Positioned')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            // 1) Banner promo: anak yang ditulis TERAKHIR berada PALING ATAS.
            //    ClipRRect memotong semua isi Stack mengikuti sudut bulat.
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Container(height: 160, color: warna.primary),
                  Positioned(
                    right: -16,
                    bottom: -24,
                    child: Icon(
                      Icons.local_dining,
                      size: 140,
                      color: warna.onPrimary.withValues(alpha: 0.2),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 16,
                    child: Text(
                      'Diskon 20%\nMenu Sarapan',
                      style: gayaTeks.headlineSmall?.copyWith(
                        color: warna.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 12,
                    right: 12,
                    child: Chip(label: Text('Baru')),
                  ),
                ],
              ),
            ),

            // 2) Lencana notifikasi di pojok ikon.
            Row(
              spacing: 32,
              children: [
                Stack(
                  clipBehavior: Clip.none, // boleh menonjol keluar kotak
                  children: [
                    const Icon(Icons.notifications, size: 40),
                    Positioned(
                      right: -6,
                      top: -6,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: warna.error,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '3',
                          style: TextStyle(color: warna.onError, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                // Flutter juga punya widget Badge yang siap pakai:
                const Badge(
                  label: Text('3'),
                  child: Icon(Icons.mail, size: 40),
                ),
              ],
            ),

            // 3) Foto profil dengan titik status "online" di kanan bawah.
            Stack(
              alignment: Alignment.bottomRight, // posisi anak tanpa Positioned
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: warna.secondaryContainer,
                  child: const Text('RA'),
                ),
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: warna.surface, width: 3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

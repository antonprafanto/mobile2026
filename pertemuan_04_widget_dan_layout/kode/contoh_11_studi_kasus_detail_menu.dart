// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 04: WIDGET & TATA LETAK
// CONTOH 11: Studi Kasus - Halaman Detail Menu Kantin
// Topik: Menggabungkan Stack, Row, Column, Expanded, Wrap, Card, dan
//        widget buatan sendiri menjadi satu halaman yang aman di layar
//        sempit maupun lebar.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiKantin());
}

class AplikasiKantin extends StatelessWidget {
  const AplikasiKantin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const HalamanDetailMenu(),
    );
  }
}

class HalamanDetailMenu extends StatelessWidget {
  const HalamanDetailMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Menu')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const BannerMenu(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  // Nama menu dibungkus Expanded agar harga tidak terdorong.
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Expanded(
                        child: Text(
                          'Nasi Goreng Kampung Spesial',
                          style: gayaTeks.headlineSmall,
                        ),
                      ),
                      Text(
                        'Rp18.000',
                        style: gayaTeks.titleLarge?.copyWith(
                          color: warna.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 2,
                    children: [
                      for (int i = 1; i <= 5; i++)
                        Icon(
                          i <= 4 ? Icons.star : Icons.star_border,
                          color: warna.tertiary,
                          size: 20,
                        ),
                      const SizedBox(width: 6),
                      const Text('4,0 (120 ulasan)'),
                    ],
                  ),
                  // Wrap: label otomatis pindah baris di layar sempit.
                  const Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        avatar: Icon(Icons.local_fire_department),
                        label: Text('Pedas'),
                      ),
                      Chip(avatar: Icon(Icons.verified), label: Text('Halal')),
                      Chip(
                        avatar: Icon(Icons.favorite),
                        label: Text('Favorit'),
                      ),
                      Chip(
                        avatar: Icon(Icons.restaurant),
                        label: Text('Porsi besar'),
                      ),
                    ],
                  ),
                  Text('Deskripsi', style: gayaTeks.titleMedium),
                  const Text(
                    'Nasi goreng bumbu kampung dengan telur mata sapi, ayam '
                    'suwir, kerupuk, dan acar segar. Dimasak saat dipesan.',
                  ),
                  const Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: KotakInfo(
                          ikon: Icons.timer,
                          nilai: '10 mnt',
                          label: 'Waktu',
                        ),
                      ),
                      Expanded(
                        child: KotakInfo(
                          ikon: Icons.bolt,
                          nilai: '650 kkal',
                          label: 'Kalori',
                        ),
                      ),
                      Expanded(
                        child: KotakInfo(
                          ikon: Icons.person,
                          nilai: '1 orang',
                          label: 'Porsi',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Tombol aksi selalu terlihat di bagian bawah layar.
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 12,
            children: [
              // Tombol ikon berukuran tetap: aman di layar sempit.
              IconButton.outlined(
                onPressed: () {}, // aksi tombol dibahas di Pertemuan 5
                tooltip: 'Simpan ke favorit',
                icon: const Icon(Icons.favorite_border),
              ),
              // Tombol utama mengambil seluruh sisa lebar.
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Pesan Sekarang'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Gambar utama + lencana yang ditumpuk dengan Stack.
class BannerMenu extends StatelessWidget {
  const BannerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Container(
          height: 200,
          color: warna.primaryContainer,
          child: Center(
            child: Icon(
              Icons.rice_bowl,
              size: 120,
              color: warna.onPrimaryContainer,
            ),
          ),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: warna.error,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('Terlaris', style: TextStyle(color: warna.onError)),
          ),
        ),
        const Positioned(
          right: 12,
          bottom: 12,
          child: Chip(
            avatar: Icon(Icons.schedule),
            label: Text('Siap 10 menit'),
          ),
        ),
      ],
    );
  }
}

// Kotak kecil berisi satu informasi gizi atau penyajian.
class KotakInfo extends StatelessWidget {
  const KotakInfo({
    super.key,
    required this.ikon,
    required this.nilai,
    required this.label,
  });

  final IconData ikon;
  final String nilai;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: warna.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        spacing: 4,
        children: [
          Icon(ikon, color: warna.primary),
          Text(nilai, style: gayaTeks.titleSmall),
          Text(label, textAlign: TextAlign.center, style: gayaTeks.labelSmall),
        ],
      ),
    );
  }
}

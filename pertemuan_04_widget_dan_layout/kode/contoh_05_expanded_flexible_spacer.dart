// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 04: WIDGET & TATA LETAK
// CONTOH 05: Expanded, Flexible, dan Spacer
// Topik: Membagi sisa ruang di dalam Row dan Column.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiExpanded());
}

class AplikasiExpanded extends StatelessWidget {
  const AplikasiExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const HalamanExpanded(),
    );
  }
}

class HalamanExpanded extends StatelessWidget {
  const HalamanExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Expanded, Flexible, Spacer')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            // 1) Expanded dengan flex: sisa ruang dibagi sesuai perbandingan.
            const Text('Expanded flex 2 : flex 1'),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: KotakLabel(teks: 'flex: 2', warna: warna.primary),
                ),
                Expanded(
                  child: KotakLabel(teks: 'flex: 1', warna: warna.secondary),
                ),
              ],
            ),

            // 2) Lebar tetap + Expanded: Expanded mengambil SEMUA sisa ruang.
            const Text('Lebar tetap 80 + Expanded'),
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: KotakLabel(teks: '80', warna: warna.tertiary),
                ),
                Expanded(
                  child: KotakLabel(teks: 'sisa ruang', warna: warna.primary),
                ),
              ],
            ),

            // 3) Flexible: boleh LEBIH KECIL dari jatahnya (secukupnya).
            //    Expanded: WAJIB memenuhi jatahnya.
            const Text('Flexible (secukupnya) vs Expanded (memenuhi jatah)'),
            Row(
              children: [
                Flexible(
                  child: KotakLabel(teks: 'Flexible', warna: warna.secondary),
                ),
                Expanded(
                  child: KotakLabel(teks: 'Expanded', warna: warna.primary),
                ),
              ],
            ),

            // 4) Spacer: "pendorong" kosong yang mengisi sisa ruang.
            const Text('Spacer mendorong anak berikutnya ke ujung'),
            Row(
              children: [
                KotakLabel(teks: 'Kiri', warna: warna.primary),
                const Spacer(),
                KotakLabel(teks: 'Kanan', warna: warna.secondary),
              ],
            ),

            // 5) Contoh nyata: nama panjang tidak mendorong harga keluar.
            const Text('Contoh nyata: baris keranjang belanja'),
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  spacing: 12,
                  children: [
                    const Icon(Icons.shopping_bag),
                    const Expanded(
                      child: Text(
                        'Paket Nasi Goreng Spesial Telur Dadar dan Es Teh Manis',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'Rp25.000',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: warna.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Kotak berwarna dengan teks di tengah.
class KotakLabel extends StatelessWidget {
  const KotakLabel({super.key, required this.teks, required this.warna});

  final String teks;
  final Color warna;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: warna,
      // widthFactor: 1 -> lebar Center secukupnya mengikuti teks, sehingga
      // kotak ini hanya melebar jika DIPAKSA (misalnya oleh Expanded).
      child: Center(
        widthFactor: 1,
        child: Text(
          teks,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}

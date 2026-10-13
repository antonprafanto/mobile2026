// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 04: WIDGET & TATA LETAK
// CONTOH 01: Widget Dasar
// Topik: Text, Icon, CircleAvatar, dan gambar dari internet.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiWidgetDasar());
}

class AplikasiWidgetDasar extends StatelessWidget {
  const AplikasiWidgetDasar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HalamanWidgetDasar(),
    );
  }
}

class HalamanWidgetDasar extends StatelessWidget {
  const HalamanWidgetDasar({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil gaya teks dan warna dari tema, bukan menulis warna sendiri.
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Widget Dasar')),
      // SingleChildScrollView membuat isi bisa digulir jika layar pendek.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1) Text: menampilkan tulisan.
            Text('Judul Besar', style: gayaTeks.headlineMedium),
            Text('Teks biasa dengan gaya bodyLarge', style: gayaTeks.bodyLarge),
            Text(
              'Teks berwarna, tebal, dan miring',
              style: TextStyle(
                color: warna.primary,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            const Text(
              'Teks yang terlalu panjang bisa dipotong dengan tanda elipsis '
              'agar tetap rapi dan tidak memakan banyak tempat di layar.',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Divider(height: 32),

            // 2) Icon: ikon Material siap pakai.
            Row(
              spacing: 16,
              children: [
                const Icon(Icons.home),
                Icon(Icons.favorite, color: warna.error, size: 32),
                Icon(Icons.star, color: warna.tertiary, size: 40),
              ],
            ),
            const Divider(height: 32),

            // 3) CircleAvatar: lingkaran untuk foto profil atau inisial.
            Row(
              spacing: 16,
              children: [
                const CircleAvatar(child: Text('RA')),
                CircleAvatar(
                  radius: 28,
                  backgroundColor: warna.primaryContainer,
                  child: Icon(Icons.person, color: warna.onPrimaryContainer),
                ),
              ],
            ),
            const Divider(height: 32),

            // 4) Image.network: gambar dari internet. errorBuilder menampilkan
            //    ikon pengganti jika gambar gagal dimuat (misalnya offline).
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://picsum.photos/600/300?image=9',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (BuildContext context, Object error, StackTrace? jejak) {
                      return const SizedBox(
                        height: 150,
                        child: Center(
                          child: Icon(Icons.broken_image, size: 48),
                        ),
                      );
                    },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

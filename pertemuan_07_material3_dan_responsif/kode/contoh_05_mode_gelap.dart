// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 07: MATERIAL 3 & UI RESPONSIF
// CONTOH 05: Mode Gelap (theme, darkTheme, themeMode)
// Topik: MaterialApp menerima dua tema (terang dan gelap) dan satu
//        pilihan themeMode: ikuti sistem, selalu terang, atau selalu
//        gelap. Pilihan pengguna disimpan di AKAR aplikasi karena
//        MaterialApp-lah yang memakainya. Bandingkan juga teks yang
//        warnanya diambil dari tema dengan teks yang warnanya ditulis
//        langsung.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiModeGelap());
}

// Akar aplikasi menjadi StatefulWidget karena menyimpan pilihan mode.
class AplikasiModeGelap extends StatefulWidget {
  const AplikasiModeGelap({super.key});

  @override
  State<AplikasiModeGelap> createState() => _AplikasiModeGelapState();
}

class _AplikasiModeGelapState extends State<AplikasiModeGelap> {
  ThemeMode _mode = ThemeMode.system; // bawaan: ikuti pengaturan perangkat

  void _gantiMode(ThemeMode modeBaru) {
    setState(() {
      _mode = modeBaru;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Tema terang dan tema gelap dibuat dari benih yang SAMA.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: _mode, // tema mana yang dipakai sekarang
      home: HalamanTampilan(mode: _mode, onModeBerubah: _gantiMode),
    );
  }
}

class HalamanTampilan extends StatelessWidget {
  const HalamanTampilan({
    super.key,
    required this.mode,
    required this.onModeBerubah,
  });

  final ThemeMode mode;
  final ValueChanged<ThemeMode> onModeBerubah;

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = Theme.of(context);
    final ColorScheme warna = tema.colorScheme;
    final TextTheme gayaTeks = tema.textTheme;

    // brightness tema yang SEDANG dipakai (hasil akhir themeMode).
    final bool sedangGelap = tema.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan Tampilan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Mode tema', style: gayaTeks.titleMedium),
          const SizedBox(height: 8),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(
                value: ThemeMode.system,
                icon: Icon(Icons.brightness_auto),
                label: Text('Sistem'),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                icon: Icon(Icons.light_mode),
                label: Text('Terang'),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                icon: Icon(Icons.dark_mode),
                label: Text('Gelap'),
              ),
            ],
            selected: {mode},
            onSelectionChanged: (Set<ThemeMode> pilihan) {
              onModeBerubah(pilihan.first);
            },
          ),
          const SizedBox(height: 8),
          Text(
            sedangGelap
                ? 'Tema yang sedang dipakai: gelap'
                : 'Tema yang sedang dipakai: terang',
            style: gayaTeks.bodyMedium?.copyWith(color: warna.onSurfaceVariant),
          ),
          const SizedBox(height: 24),
          Text('Pratinjau', style: gayaTeks.titleMedium),
          const SizedBox(height: 8),
          // ✅ Warna dari tema: otomatis menyesuaikan mode terang/gelap.
          Card(
            child: ListTile(
              leading: Icon(Icons.check_circle, color: warna.primary),
              title: const Text('Warna diambil dari tema'),
              subtitle: const Text('Terbaca di mode terang maupun gelap.'),
            ),
          ),
          const SizedBox(height: 8),
          // ❌ Warna ditulis langsung: tidak ikut berubah.
          const Card(
            child: ListTile(
              leading: Icon(Icons.cancel, color: Colors.black54),
              title: Text(
                'Teks hitam ditulis langsung',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Nyaris hilang di mode gelap.',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // ❌ Kotak putih ditulis langsung: menyilaukan di mode gelap.
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: const Text(
              'Kotak putih ditulis langsung: silau di mode gelap.',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

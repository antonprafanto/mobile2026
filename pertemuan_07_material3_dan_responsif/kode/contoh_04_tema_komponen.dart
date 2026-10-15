// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 07: MATERIAL 3 & UI RESPONSIF
// CONTOH 04: Tema Komponen dan Tema Lokal
// Topik: Tampilan SEMUA komponen sejenis (AppBar, Card, TextField,
//        FilledButton) diatur sekali di ThemeData, sehingga widget di
//        halaman tidak perlu diberi gaya satu per satu. Widget Theme
//        dipakai untuk mengubah tema hanya pada sebagian layar.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiPendaftaran());
}

class AplikasiPendaftaran extends StatelessWidget {
  const AplikasiPendaftaran({super.key});

  @override
  Widget build(BuildContext context) {
    // Skema dibuat lebih dulu agar warnanya bisa dipakai tema komponen.
    final ColorScheme skema = ColorScheme.fromSeed(seedColor: Colors.indigo);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: skema,
        // 1) Semua AppBar: berlatar warna wadah utama.
        appBarTheme: AppBarThemeData(
          backgroundColor: skema.primaryContainer,
          foregroundColor: skema.onPrimaryContainer,
        ),
        // 2) Semua Card: tanpa bayangan, bergaris tepi, sudut 16.
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: skema.outlineVariant),
          ),
        ),
        // 3) Semua TextField: berlatar dan bergaris tepi.
        inputDecorationTheme: const InputDecorationThemeData(
          filled: true,
          border: OutlineInputBorder(),
        ),
        // 4) Semua FilledButton: selebar wadahnya dan setinggi 52.
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
        ),
      ),
      home: const HalamanPendaftaran(),
    );
  }
}

const List<String> daftarUkm = [
  'Paduan Suara',
  'Robotika',
  'Pecinta Alam',
  'Bulu Tangkis',
  'Fotografi',
];

class HalamanPendaftaran extends StatefulWidget {
  const HalamanPendaftaran({super.key});

  @override
  State<HalamanPendaftaran> createState() => _HalamanPendaftaranState();
}

class _HalamanPendaftaranState extends State<HalamanPendaftaran> {
  String _ukm = daftarUkm.first;

  void _kirim() {
    final ScaffoldMessengerState pesan = ScaffoldMessenger.of(context);
    pesan.hideCurrentSnackBar();
    pesan.showSnackBar(
      SnackBar(content: Text('Pendaftaran UKM $_ukm terkirim.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    // Perhatikan: tidak ada satu pun warna, garis, atau tinggi tombol
    // yang ditulis di halaman ini. Semuanya datang dari tema.
    return Scaffold(
      appBar: AppBar(title: const Text('Pendaftaran UKM')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Data diri', style: gayaTeks.titleMedium),
                  const SizedBox(height: 12),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Nama lengkap',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'NIM',
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pilih UKM', style: gayaTeks.titleMedium),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final String ukm in daftarUkm)
                        ChoiceChip(
                          label: Text(ukm),
                          selected: ukm == _ukm,
                          onSelected: (_) {
                            setState(() {
                              _ukm = ukm;
                            });
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _kirim,
            child: const Text('Kirim pendaftaran'),
          ),
          const SizedBox(height: 32),
          Text('Zona berbahaya', style: gayaTeks.titleMedium),
          const SizedBox(height: 8),
          // Tema LOKAL: hanya tombol di dalam Theme ini yang memakai warna
          // error sebagai warna utamanya. Bagian lain tetap memakai tema
          // aplikasi.
          Theme(
            data: Theme.of(context).copyWith(
              colorScheme: warna.copyWith(
                primary: warna.error,
                onPrimary: warna.onError,
              ),
            ),
            child: FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.delete_outline),
              label: const Text('Batalkan semua pendaftaran'),
            ),
          ),
        ],
      ),
    );
  }
}

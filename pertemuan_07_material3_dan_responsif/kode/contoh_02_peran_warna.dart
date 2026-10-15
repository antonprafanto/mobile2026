// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 07: MATERIAL 3 & UI RESPONSIF
// CONTOH 02: Skema Warna Material 3 dan Peran Warna
// Topik: ColorScheme.fromSeed membuat puluhan warna dari SATU warna
//        benih. Setiap warna punya PERAN (primary, surface, error, ...)
//        dan berpasangan dengan warna "on" untuk teks/ikon di atasnya.
//        Ganti benih, varian, dan mode gelap, lalu amati paletnya.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiPalet());
}

class AplikasiPalet extends StatelessWidget {
  const AplikasiPalet({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const HalamanPalet(),
    );
  }
}

class PilihanBenih {
  const PilihanBenih(this.nama, this.warna);

  final String nama;
  final Color warna;
}

const List<PilihanBenih> daftarBenih = [
  PilihanBenih('Biru', Color(0xFF1565C0)),
  PilihanBenih('Hijau', Color(0xFF2E7D32)),
  PilihanBenih('Oranye', Color(0xFFEF6C00)),
  PilihanBenih('Ungu', Color(0xFF6A1B9A)),
];

// Empat dari sembilan varian yang tersedia.
const List<DynamicSchemeVariant> daftarVarian = [
  DynamicSchemeVariant.tonalSpot, // bawaan: lembut, tidak menyilaukan
  DynamicSchemeVariant.fidelity, // setia pada warna benih
  DynamicSchemeVariant.vibrant, // lebih mencolok
  DynamicSchemeVariant.monochrome, // abu-abu saja
];

// Satu baris palet: warna latar dan warna isi yang aman di atasnya.
class PasanganWarna {
  const PasanganWarna(this.namaLatar, this.namaIsi, this.latar, this.isi);

  final String namaLatar;
  final String namaIsi;
  final Color latar;
  final Color isi;
}

class HalamanPalet extends StatefulWidget {
  const HalamanPalet({super.key});

  @override
  State<HalamanPalet> createState() => _HalamanPaletState();
}

class _HalamanPaletState extends State<HalamanPalet> {
  PilihanBenih _benih = daftarBenih.first;
  DynamicSchemeVariant _varian = DynamicSchemeVariant.tonalSpot;
  bool _gelap = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    // Skema dibuat ulang setiap kali pilihan berubah. Skema ini hanya
    // DIGAMBAR di bawah, tidak dipasang sebagai tema aplikasi.
    final ColorScheme skema = ColorScheme.fromSeed(
      seedColor: _benih.warna,
      brightness: _gelap ? Brightness.dark : Brightness.light,
      dynamicSchemeVariant: _varian,
    );

    final List<PasanganWarna> daftarPasangan = [
      PasanganWarna('primary', 'onPrimary', skema.primary, skema.onPrimary),
      PasanganWarna(
        'primaryContainer',
        'onPrimaryContainer',
        skema.primaryContainer,
        skema.onPrimaryContainer,
      ),
      PasanganWarna(
        'secondary',
        'onSecondary',
        skema.secondary,
        skema.onSecondary,
      ),
      PasanganWarna(
        'secondaryContainer',
        'onSecondaryContainer',
        skema.secondaryContainer,
        skema.onSecondaryContainer,
      ),
      PasanganWarna('tertiary', 'onTertiary', skema.tertiary, skema.onTertiary),
      PasanganWarna(
        'tertiaryContainer',
        'onTertiaryContainer',
        skema.tertiaryContainer,
        skema.onTertiaryContainer,
      ),
      PasanganWarna('error', 'onError', skema.error, skema.onError),
      PasanganWarna(
        'errorContainer',
        'onErrorContainer',
        skema.errorContainer,
        skema.onErrorContainer,
      ),
      PasanganWarna('surface', 'onSurface', skema.surface, skema.onSurface),
      PasanganWarna(
        'surfaceContainerHighest',
        'onSurfaceVariant',
        skema.surfaceContainerHighest,
        skema.onSurfaceVariant,
      ),
      PasanganWarna(
        'inverseSurface',
        'onInverseSurface',
        skema.inverseSurface,
        skema.onInverseSurface,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Palet Warna Material 3')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Warna benih', style: gayaTeks.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final PilihanBenih benih in daftarBenih)
                ChoiceChip(
                  label: Text(benih.nama),
                  selected: benih == _benih,
                  onSelected: (_) {
                    setState(() {
                      _benih = benih;
                    });
                  },
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Varian skema', style: gayaTeks.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final DynamicSchemeVariant varian in daftarVarian)
                ChoiceChip(
                  label: Text(varian.name),
                  selected: varian == _varian,
                  onSelected: (_) {
                    setState(() {
                      _varian = varian;
                    });
                  },
                ),
            ],
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Mode gelap'),
            value: _gelap,
            onChanged: (bool nilaiBaru) {
              setState(() {
                _gelap = nilaiBaru;
              });
            },
          ),
          const SizedBox(height: 8),
          // "Kanvas" berlatar surface dari skema yang sedang dicoba,
          // supaya palet mode gelap terlihat di atas latar gelap.
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: skema.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: skema.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final PasanganWarna pasangan in daftarPasangan)
                  KotakPasangan(
                    pasangan: pasangan,
                    garis: skema.outlineVariant,
                  ),
                const SizedBox(height: 8),
                Text(
                  'Tangga surfaceContainer (latar bertingkat)',
                  style: gayaTeks.labelLarge?.copyWith(color: skema.onSurface),
                ),
                const SizedBox(height: 8),
                TanggaSurface(skema: skema),
                const SizedBox(height: 16),
                Text(
                  'Garis tepi',
                  style: gayaTeks.labelLarge?.copyWith(color: skema.onSurface),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: KotakGaris(
                        nama: 'outline',
                        warnaGaris: skema.outline,
                        warnaTeks: skema.onSurface,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: KotakGaris(
                        nama: 'outlineVariant',
                        warnaGaris: skema.outlineVariant,
                        warnaTeks: skema.onSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class KotakPasangan extends StatelessWidget {
  const KotakPasangan({super.key, required this.pasangan, required this.garis});

  final PasanganWarna pasangan;
  final Color garis;

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: pasangan.latar,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: garis),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pasangan.namaLatar,
            style: gayaTeks.titleSmall?.copyWith(color: pasangan.isi),
          ),
          Text(
            'teks di atasnya: ${pasangan.namaIsi}',
            style: gayaTeks.bodySmall?.copyWith(color: pasangan.isi),
          ),
        ],
      ),
    );
  }
}

// Lima tingkat latar: makin "tinggi", makin kontras dengan surface.
class TanggaSurface extends StatelessWidget {
  const TanggaSurface({super.key, required this.skema});

  final ColorScheme skema;

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    final TextStyle? gaya = gayaTeks.labelSmall?.copyWith(
      color: skema.onSurface,
    );

    final List<String> nama = ['Lowest', 'Low', 'biasa', 'High', 'Highest'];
    final List<Color> warna = [
      skema.surfaceContainerLowest,
      skema.surfaceContainerLow,
      skema.surfaceContainer,
      skema.surfaceContainerHigh,
      skema.surfaceContainerHighest,
    ];

    return Row(
      children: [
        for (int i = 0; i < nama.length; i++)
          Expanded(
            child: Container(
              height: 56,
              alignment: Alignment.center,
              color: warna[i],
              child: Text(nama[i], style: gaya),
            ),
          ),
      ],
    );
  }
}

class KotakGaris extends StatelessWidget {
  const KotakGaris({
    super.key,
    required this.nama,
    required this.warnaGaris,
    required this.warnaTeks,
  });

  final String nama;
  final Color warnaGaris;
  final Color warnaTeks;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: warnaGaris, width: 2),
      ),
      child: Text(nama, style: TextStyle(color: warnaTeks)),
    );
  }
}

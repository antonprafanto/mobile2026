// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 07: MATERIAL 3 & UI RESPONSIF
// CONTOH 06: Warna Khusus Aplikasi dengan ThemeExtension
// Topik: ColorScheme tidak punya warna "sukses" atau "peringatan".
//        Warna seperti itu ditambahkan ke tema lewat ThemeExtension,
//        sehingga tetap punya versi terang dan versi gelap. Pasangan
//        warnanya dibuat oleh ColorScheme.fromSeed agar kontrasnya
//        terjamin. Tekan ikon di AppBar untuk berganti mode.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiPinjaman());
}

// ---------- 1. Wadah warna khusus ----------
class WarnaStatus extends ThemeExtension<WarnaStatus> {
  const WarnaStatus({
    required this.sukses,
    required this.onSukses,
    required this.peringatan,
    required this.onPeringatan,
  });

  final Color sukses; // latar label "aman"
  final Color onSukses; // teks di atas latar sukses
  final Color peringatan; // latar label "hampir jatuh tempo"
  final Color onPeringatan; // teks di atas latar peringatan

  // Wajib ada (1): membuat salinan dengan sebagian nilai diganti.
  @override
  WarnaStatus copyWith({
    Color? sukses,
    Color? onSukses,
    Color? peringatan,
    Color? onPeringatan,
  }) {
    return WarnaStatus(
      sukses: sukses ?? this.sukses,
      onSukses: onSukses ?? this.onSukses,
      peringatan: peringatan ?? this.peringatan,
      onPeringatan: onPeringatan ?? this.onPeringatan,
    );
  }

  // Wajib ada (2): mencampur dua tema saat berganti terang <-> gelap,
  // supaya warnanya berubah halus, tidak meloncat.
  @override
  WarnaStatus lerp(WarnaStatus? other, double t) {
    if (other == null) {
      return this;
    }
    return WarnaStatus(
      sukses: Color.lerp(sukses, other.sukses, t)!,
      onSukses: Color.lerp(onSukses, other.onSukses, t)!,
      peringatan: Color.lerp(peringatan, other.peringatan, t)!,
      onPeringatan: Color.lerp(onPeringatan, other.onPeringatan, t)!,
    );
  }
}

// ---------- 2. Tema terang dan gelap dari satu fungsi ----------
ThemeData buatTema(Brightness kecerahan) {
  // Skema bantu: dipakai hanya untuk "meminjam" pasangan warnanya.
  final ColorScheme hijau = ColorScheme.fromSeed(
    seedColor: Colors.green,
    brightness: kecerahan,
  );
  final ColorScheme kuning = ColorScheme.fromSeed(
    seedColor: Colors.amber,
    brightness: kecerahan,
  );

  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: kecerahan,
    ),
    // Warna khusus dititipkan ke tema lewat extensions.
    extensions: <ThemeExtension<dynamic>>[
      WarnaStatus(
        sukses: hijau.primaryContainer,
        onSukses: hijau.onPrimaryContainer,
        peringatan: kuning.primaryContainer,
        onPeringatan: kuning.onPrimaryContainer,
      ),
    ],
  );
}

// ---------- 3. Data ----------
class Pinjaman {
  const Pinjaman(this.judul, this.sisaHari);

  final String judul;
  final int sisaHari; // negatif berarti sudah terlambat
}

const List<Pinjaman> daftarPinjaman = [
  Pinjaman('Belajar Flutter dari Nol', 9),
  Pinjaman('Basis Data Terapan', 2),
  Pinjaman('Statistika Dasar', -3),
  Pinjaman('Desain Antarmuka Seluler', 0),
  Pinjaman('Jaringan Komputer', 12),
];

enum Status { aman, hampirJatuhTempo, terlambat }

Status statusDari(int sisaHari) {
  if (sisaHari < 0) {
    return Status.terlambat;
  }
  if (sisaHari <= 3) {
    return Status.hampirJatuhTempo;
  }
  return Status.aman;
}

// ---------- 4. Aplikasi ----------
class AplikasiPinjaman extends StatefulWidget {
  const AplikasiPinjaman({super.key});

  @override
  State<AplikasiPinjaman> createState() => _AplikasiPinjamanState();
}

class _AplikasiPinjamanState extends State<AplikasiPinjaman> {
  bool _gelap = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buatTema(Brightness.light),
      darkTheme: buatTema(Brightness.dark),
      themeMode: _gelap ? ThemeMode.dark : ThemeMode.light,
      home: HalamanPinjaman(
        gelap: _gelap,
        onGantiMode: () {
          setState(() {
            _gelap = !_gelap;
          });
        },
      ),
    );
  }
}

class HalamanPinjaman extends StatelessWidget {
  const HalamanPinjaman({
    super.key,
    required this.gelap,
    required this.onGantiMode,
  });

  final bool gelap;
  final VoidCallback onGantiMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pinjaman Buku Saya'),
        actions: [
          IconButton(
            onPressed: onGantiMode,
            tooltip: gelap ? 'Mode terang' : 'Mode gelap',
            icon: Icon(gelap ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: daftarPinjaman.length,
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(indent: 16, endIndent: 16),
        itemBuilder: (BuildContext context, int index) {
          final Pinjaman pinjaman = daftarPinjaman[index];
          return ListTile(
            leading: const Icon(Icons.menu_book),
            title: Text(pinjaman.judul),
            subtitle: Text(keteranganSisa(pinjaman.sisaHari)),
            trailing: LabelStatus(status: statusDari(pinjaman.sisaHari)),
          );
        },
      ),
    );
  }
}

String keteranganSisa(int sisaHari) {
  if (sisaHari < 0) {
    return 'Terlambat ${-sisaHari} hari';
  }
  if (sisaHari == 0) {
    return 'Kembalikan hari ini';
  }
  return 'Kembalikan dalam $sisaHari hari';
}

// ---------- 5. Membaca warna khusus dari tema ----------
class LabelStatus extends StatelessWidget {
  const LabelStatus({super.key, required this.status});

  final Status status;

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = Theme.of(context);
    // extension<WarnaStatus>() mengambil warna khusus milik tema aktif.
    // Tanda ! dipakai karena kita yakin sudah mendaftarkannya.
    final WarnaStatus warnaStatus = tema.extension<WarnaStatus>()!;
    final ColorScheme warna = tema.colorScheme;

    final Color latar;
    final Color isi;
    final String teks;
    switch (status) {
      case Status.aman:
        latar = warnaStatus.sukses;
        isi = warnaStatus.onSukses;
        teks = 'Aman';
      case Status.hampirJatuhTempo:
        latar = warnaStatus.peringatan;
        isi = warnaStatus.onPeringatan;
        teks = 'Segera';
      case Status.terlambat:
        // Warna "error" sudah disediakan ColorScheme, tidak perlu dibuat.
        latar = warna.errorContainer;
        isi = warna.onErrorContainer;
        teks = 'Terlambat';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: latar,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        teks,
        style: tema.textTheme.labelMedium?.copyWith(color: isi),
      ),
    );
  }
}

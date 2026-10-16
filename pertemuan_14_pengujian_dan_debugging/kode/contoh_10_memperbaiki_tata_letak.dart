// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 14: PENGUJIAN & DEBUGGING
// CONTOH 10: Memperbaiki Galat Tata Letak - "Info Kegiatan Kampus"
// Topik: Tiga galat tata letak yang paling sering dialami pemula.
//        Buka setiap kasus, lihat gejalanya, baca pesan galatnya di
//        Debug Console (VS Code) atau panel Console (DartPad), lalu
//        nyalakan sakelar "Perbaiki" di kanan atas untuk melihat
//        versi yang benar (modul Bagian 13).
//        Kasus 1: teks panjang di dalam Row -> pita kuning-hitam,
//                 "A RenderFlex overflowed by ... pixels on the right."
//        Kasus 2: ListView di dalam Column  -> daftar tidak tampil,
//                 "Vertical viewport was given unbounded height."
//        Kasus 3: TextField di dalam Row    -> kolom isian tidak tampil,
//                 "An InputDecorator, which is typically created by a
//                 TextField, cannot have an unbounded width."
//        Isi setiap kasus dibatasi selebar ponsel (360), agar galatnya
//        juga muncul di jendela Chrome yang lebar.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome (atau tekan F5 di
//    VS Code agar pesan galat tampil di Debug Console).
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiInfoKegiatan());
}

class AplikasiInfoKegiatan extends StatelessWidget {
  const AplikasiInfoKegiatan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Info Kegiatan Kampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HalamanDaftarKasus(),
    );
  }
}

/// Satu kasus latihan: judul, gejala, dan isi halamannya.
class Kasus {
  const Kasus({required this.judul, required this.gejala, required this.isi});

  final String judul;
  final String gejala;

  /// Membuat isi halaman. perbaiki = true berarti versi yang benar.
  final Widget Function(bool perbaiki) isi;
}

final List<Kasus> semuaKasus = [
  Kasus(
    judul: 'Kasus 1: Teks panjang di Row',
    gejala: 'Pita kuning-hitam di tepi kanan kartu.',
    isi: (bool perbaiki) => KartuKegiatan(perbaiki: perbaiki),
  ),
  Kasus(
    judul: 'Kasus 2: ListView di Column',
    gejala: 'Daftar peserta tidak tampil sama sekali.',
    isi: (bool perbaiki) => DaftarPeserta(perbaiki: perbaiki),
  ),
  Kasus(
    judul: 'Kasus 3: TextField di Row',
    gejala: 'Kolom komentar dan tombol kirim tidak tampil.',
    isi: (bool perbaiki) => KolomKomentar(perbaiki: perbaiki),
  ),
];

class HalamanDaftarKasus extends StatelessWidget {
  const HalamanDaftarKasus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Info Kegiatan Kampus')),
      body: ListView(
        children: [
          for (final Kasus kasus in semuaKasus)
            ListTile(
              leading: const Icon(Icons.bug_report_outlined),
              title: Text(kasus.judul),
              subtitle: Text('Gejala: ${kasus.gejala}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        HalamanKasus(kasus: kasus),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class HalamanKasus extends StatefulWidget {
  const HalamanKasus({super.key, required this.kasus});

  final Kasus kasus;

  @override
  State<HalamanKasus> createState() => _HalamanKasusState();
}

class _HalamanKasusState extends State<HalamanKasus> {
  bool _perbaiki = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sakelar diletakkan di AppBar, BUKAN di body. Saat body gagal
      // ditata, AppBar tetap tampil dan sakelarnya tetap bisa diketuk.
      appBar: AppBar(
        title: Text(widget.kasus.judul),
        actions: [
          const Text('Perbaiki'),
          Switch(
            value: _perbaiki,
            onChanged: (bool nilai) => setState(() => _perbaiki = nilai),
          ),
        ],
      ),
      // Lebar isi dibatasi 360, seperti layar ponsel.
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: widget.kasus.isi(_perbaiki),
        ),
      ),
    );
  }
}

// ======================= KASUS 1: TEKS PANJANG =======================

class KartuKegiatan extends StatelessWidget {
  const KartuKegiatan({super.key, required this.perbaiki});

  final bool perbaiki;

  static const String judul =
      'Seminar Nasional Teknologi Informasi dan Pendidikan di Era '
      'Kecerdasan Buatan';

  @override
  Widget build(BuildContext context) {
    final Widget isiKartu;
    if (!perbaiki) {
      // SALAH: Row memberi Text lebar SEBESAR YANG IA MAU. Judul yang
      // panjang tidak turun baris, jadi Row meluap ke kanan.
      isiKartu = const Row(
        children: [
          Icon(Icons.event),
          SizedBox(width: 12),
          Text(judul),
          SizedBox(width: 12),
          Text('08.00'),
        ],
      );
    } else {
      // BENAR: Expanded memberi Text SISA lebar Row, sehingga judul
      // turun baris di dalam ruang yang tersedia.
      isiKartu = const Row(
        children: [
          Icon(Icons.event),
          SizedBox(width: 12),
          Expanded(child: Text(judul)),
          SizedBox(width: 12),
          Text('08.00'),
        ],
      );
    }
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(padding: const EdgeInsets.all(16), child: isiKartu),
    );
  }
}

// =================== KASUS 2: LISTVIEW DI COLUMN ===================

class DaftarPeserta extends StatelessWidget {
  const DaftarPeserta({super.key, required this.perbaiki});

  final bool perbaiki;

  static final List<String> peserta = [
    for (int i = 1; i <= 30; i++) 'Peserta ke-$i',
  ];

  @override
  Widget build(BuildContext context) {
    final Widget daftar = ListView(
      children: [
        for (final String nama in peserta)
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text(nama),
          ),
      ],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            '${peserta.length} peserta terdaftar',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        // SALAH: Column membiarkan anaknya setinggi apa pun, sedangkan
        // ListView ingin setinggi ruang yang tersedia: tidak terbatas.
        // BENAR: Expanded memberi ListView SISA tinggi Column.
        if (!perbaiki) daftar else Expanded(child: daftar),
      ],
    );
  }
}

// =================== KASUS 3: TEXTFIELD DI ROW ===================

class KolomKomentar extends StatelessWidget {
  const KolomKomentar({super.key, required this.perbaiki});

  final bool perbaiki;

  @override
  Widget build(BuildContext context) {
    const Widget isian = TextField(
      decoration: InputDecoration(
        hintText: 'Tulis komentar',
        border: OutlineInputBorder(),
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // SALAH: TextField ingin selebar ruang yang tersedia, padahal
          // Row memberinya lebar tidak terbatas.
          // BENAR: Expanded memberi TextField SISA lebar Row.
          if (!perbaiki) isian else const Expanded(child: isian),
          const SizedBox(width: 8),
          IconButton.filled(
            tooltip: 'Kirim komentar',
            onPressed: () {},
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

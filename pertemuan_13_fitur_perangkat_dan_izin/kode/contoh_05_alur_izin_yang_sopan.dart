// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 13: FITUR PERANGKAT & IZIN
// CONTOH 05: Alur Izin yang Sopan (Simulasi)
// Topik: Fitur "urutkan ruang belajar dari yang terdekat" membutuhkan
//        lokasi. Agar bisa dicoba tanpa HP, dialog izin dan halaman
//        Pengaturan di sini adalah SIMULASI yang meniru perilaku Android.
//        Yang dipelajari adalah ALURNYA:
//        1. izin diminta saat pengguna mengetuk fitur, BUKAN saat
//           aplikasi dibuka;
//        2. manfaatnya dijelaskan dulu di layar kita sendiri, lengkap
//           dengan pilihan "Nanti saja";
//        3. jika ditolak, aplikasi TETAP bisa dipakai (daftar diurutkan
//           menurut abjad), dan pesannya menyebut apa yang tidak bisa;
//        4. jika diblokir, tombol "Buka Pengaturan" ditawarkan dengan
//           tenang, tanpa memaksa;
//        5. setelah kembali dari Pengaturan, izin diperiksa ulang.
//        Menu titik tiga di kanan atas: "Tutup lalu buka lagi" (untuk
//        mencoba "Hanya kali ini") dan "Pasang ulang aplikasi".
// =====================================================================
// CARA MENJALANKAN: buka https://dartpad.dev, tempel seluruh isi berkas
// ini, klik Run. (Bisa juga di proyek Flutter mana pun, tanpa paket
// tambahan.)
// =====================================================================

import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const AplikasiRuangBelajar());

class AplikasiRuangBelajar extends StatelessWidget {
  const AplikasiRuangBelajar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ruang Belajar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const HalamanRuangBelajar(),
    );
  }
}

// ===================== SISTEM OPERASI (SIMULASI) =====================

enum StatusIzin { ditolak, ditolakPermanen, saatDipakai }

enum JawabanDialog {
  saatDipakai('Saat aplikasi digunakan'),
  hanyaKaliIni('Hanya kali ini'),
  jangan('Jangan izinkan');

  const JawabanDialog(this.label);
  final String label;
}

/// Meniru catatan izin yang disimpan sistem operasi Android.
class SistemTiruan {
  StatusIzin _status = StatusIzin.ditolak;
  int _penolakan = 0;
  bool _hanyaKaliIni = false;

  /// Seperti Geolocator.checkPermission(): hanya melihat.
  StatusIzin get status => _status;

  /// Seperti Geolocator.requestPermission(): dialog hanya muncul jika
  /// izin masih boleh diminta. (Versi asli tidak butuh context; simulasi
  /// ini butuh context untuk menggambar dialognya.)
  Future<StatusIzin> minta(BuildContext context) async {
    if (_status != StatusIzin.ditolak) return _status;
    final JawabanDialog? jawaban = await showDialog<JawabanDialog>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const _DialogSistemTiruan(),
    );
    switch (jawaban) {
      case JawabanDialog.saatDipakai:
        _status = StatusIzin.saatDipakai;
      case JawabanDialog.hanyaKaliIni:
        _status = StatusIzin.saatDipakai;
        _hanyaKaliIni = true;
      case JawabanDialog.jangan || null:
        _penolakan++;
        // Menolak lebih dari sekali = penolakan permanen.
        if (_penolakan >= 2) _status = StatusIzin.ditolakPermanen;
    }
    return _status;
  }

  void aplikasiDitutup() {
    if (_hanyaKaliIni) {
      _status = StatusIzin.ditolak;
      _hanyaKaliIni = false;
    }
  }

  void ubahDiPengaturan(StatusIzin baru) {
    _status = baru;
    _penolakan = baru == StatusIzin.ditolakPermanen ? 2 : 0;
    _hanyaKaliIni = false;
  }

  void pasangUlang() => ubahDiPengaturan(StatusIzin.ditolak);
}

// =============================== DATA ===============================

class Ruang {
  const Ruang(this.nama, this.lintang, this.bujur);
  final String nama;
  final double lintang;
  final double bujur;
}

const List<Ruang> semuaRuang = [
  Ruang('Lab Pemrograman', -0.4700, 117.1580),
  Ruang('Masjid Kampus', -0.4689, 117.1561),
  Ruang('Perpustakaan Pusat', -0.4721, 117.1602),
  Ruang('Pojok Diskusi Gedung C', -0.4709, 117.1590),
  Ruang('Selasar Fakultas Teknik', -0.4694, 117.1575),
  Ruang('Taman Baca Rektorat', -0.4732, 117.1549),
];

/// Posisi pengguna dalam simulasi ini (di depan Gedung C).
const double lintangSaya = -0.4707;
const double bujurSaya = 117.1588;

double jarakMeter(double l1, double b1, double l2, double b2) {
  double rad(double d) => d * pi / 180;
  final double h =
      pow(sin(rad(l2 - l1) / 2), 2) +
      pow(sin(rad(b2 - b1) / 2), 2) * cos(rad(l1)) * cos(rad(l2));
  return 6378137.0 * 2 * asin(sqrt(h));
}

// ============================== HALAMAN ==============================

class HalamanRuangBelajar extends StatefulWidget {
  const HalamanRuangBelajar({super.key});

  @override
  State<HalamanRuangBelajar> createState() => _HalamanRuangBelajarState();
}

class _HalamanRuangBelajarState extends State<HalamanRuangBelajar> {
  final SistemTiruan _sistem = SistemTiruan();

  /// Apakah aplikasi sudah pernah meminta izin sejak dibuka.
  bool _pernahMinta = false;

  /// Pengguna memilih "Nanti saja" pada kartu penjelasan.
  bool _nantiSaja = false;

  Future<void> _gunakanLokasi() async {
    final StatusIzin hasil = await _sistem.minta(context);
    if (!mounted) return;
    setState(() => _pernahMinta = true);
    if (hasil == StatusIzin.saatDipakai) {
      _beriTahu('Daftar diurutkan dari yang terdekat.');
    }
  }

  Future<void> _bukaPengaturan() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>
            HalamanPengaturanTiruan(sistem: _sistem),
      ),
    );
    // Kembali dari Pengaturan: periksa ulang izinnya. Di aplikasi
    // sungguhan, Pengaturan adalah aplikasi LAIN, jadi pemeriksaan ulang
    // dilakukan di AppLifecycleListener(onResume: ...), seperti Contoh 03.
    if (!mounted) return;
    setState(() {});
  }

  void _simulasi(String pilihan) {
    setState(() {
      if (pilihan == 'tutup') {
        _sistem.aplikasiDitutup();
      } else {
        _sistem.pasangUlang();
      }
      _pernahMinta = false;
      _nantiSaja = false;
    });
    _beriTahu(
      pilihan == 'tutup'
          ? 'Aplikasi ditutup lalu dibuka lagi (simulasi).'
          : 'Aplikasi dipasang ulang (simulasi): semua izin hilang.',
    );
  }

  void _beriTahu(String pesan) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(pesan)));
  }

  @override
  Widget build(BuildContext context) {
    final StatusIzin status = _sistem.status;
    final bool urutJarak = status == StatusIzin.saatDipakai;
    final List<(Ruang, double)> daftar = [
      for (final Ruang r in semuaRuang)
        (r, jarakMeter(lintangSaya, bujurSaya, r.lintang, r.bujur)),
    ];
    daftar.sort(
      (a, b) =>
          urutJarak ? a.$2.compareTo(b.$2) : a.$1.nama.compareTo(b.$1.nama),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ruang Belajar'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _simulasi,
            itemBuilder: (BuildContext context) => const [
              PopupMenuItem(
                value: 'tutup',
                child: Text('Tutup lalu buka lagi'),
              ),
              PopupMenuItem(
                value: 'pasang',
                child: Text('Pasang ulang aplikasi'),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          _KartuStatus(
            status: status,
            pernahMinta: _pernahMinta,
            nantiSaja: _nantiSaja,
            onGunakanLokasi: _gunakanLokasi,
            onNantiSaja: () => setState(() => _nantiSaja = true),
            onBukaPengaturan: _bukaPengaturan,
          ),
          for (final (Ruang r, double jarak) in daftar)
            ListTile(
              leading: const Icon(Icons.menu_book_outlined),
              title: Text(r.nama),
              trailing: urutJarak ? Text('${jarak.round()} m') : null,
            ),
        ],
      ),
    );
  }
}

/// Isi kartu di atas daftar bergantung pada status izin.
class _KartuStatus extends StatelessWidget {
  const _KartuStatus({
    required this.status,
    required this.pernahMinta,
    required this.nantiSaja,
    required this.onGunakanLokasi,
    required this.onNantiSaja,
    required this.onBukaPengaturan,
  });

  final StatusIzin status;
  final bool pernahMinta;
  final bool nantiSaja;
  final VoidCallback onGunakanLokasi;
  final VoidCallback onNantiSaja;
  final VoidCallback onBukaPengaturan;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    switch (status) {
      case StatusIzin.saatDipakai:
        return ListTile(
          tileColor: warna.secondaryContainer,
          leading: const Icon(Icons.near_me),
          title: const Text('Diurutkan dari yang terdekat'),
          subtitle: const Text('Lokasi hanya dipakai di perangkat ini.'),
        );

      case StatusIzin.ditolak when !pernahMinta && !nantiSaja:
        // Penjelasan SEBELUM dialog sistem, di layar kita sendiri.
        return Card(
          margin: const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cari ruang belajar terdekat?',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Izinkan akses lokasi agar ruang terdekat tampil paling '
                  'atas. Lokasi hanya dipakai di perangkat ini dan tidak '
                  'dikirim ke mana pun.',
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    FilledButton.icon(
                      onPressed: onGunakanLokasi,
                      icon: const Icon(Icons.my_location),
                      label: const Text('Gunakan lokasi saya'),
                    ),
                    TextButton(
                      onPressed: onNantiSaja,
                      child: const Text('Nanti saja'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );

      case StatusIzin.ditolak:
        // Ditolak (atau "Nanti saja"): aplikasi tetap jalan, urut abjad.
        return ListTile(
          leading: const Icon(Icons.sort_by_alpha),
          title: const Text('Diurutkan menurut abjad'),
          subtitle: Text(
            pernahMinta
                ? 'Akses lokasi tidak diizinkan.'
                : 'Urutan jarak membutuhkan lokasi.',
          ),
          trailing: TextButton(
            onPressed: onGunakanLokasi,
            child: Text(pernahMinta ? 'Coba lagi' : 'Urutkan jarak'),
          ),
        );

      case StatusIzin.ditolakPermanen:
        return Card(
          margin: const EdgeInsets.all(12),
          color: warna.surfaceContainerHighest,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Akses lokasi diblokir. Daftar tetap bisa dipakai '
                  '(urut abjad). Jika ingin mengurutkan dari yang '
                  'terdekat, izinkan lokasi di Pengaturan.',
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: onBukaPengaturan,
                  icon: const Icon(Icons.settings_outlined),
                  label: const Text('Buka Pengaturan'),
                ),
              ],
            ),
          ),
        );
    }
  }
}

// ======================= TAMPILAN SISTEM (SIMULASI) =======================

class _DialogSistemTiruan extends StatelessWidget {
  const _DialogSistemTiruan();

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'SIMULASI DIALOG SISTEM',
              style: TextStyle(fontSize: 11, color: warna.outline),
            ),
            const SizedBox(height: 12),
            Icon(Icons.location_on, color: warna.primary, size: 32),
            const SizedBox(height: 12),
            const Text(
              'Izinkan Ruang Belajar mengakses lokasi perangkat ini?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            for (final JawabanDialog j in JawabanDialog.values)
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(j),
                  child: Text(j.label),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class HalamanPengaturanTiruan extends StatefulWidget {
  const HalamanPengaturanTiruan({super.key, required this.sistem});

  final SistemTiruan sistem;

  @override
  State<HalamanPengaturanTiruan> createState() =>
      _HalamanPengaturanTiruanState();
}

class _HalamanPengaturanTiruanState extends State<HalamanPengaturanTiruan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan (simulasi)')),
      body: ListView(
        children: [
          const ListTile(
            leading: Icon(Icons.apps),
            title: Text('Ruang Belajar'),
            subtitle: Text('Izin aplikasi -> Lokasi'),
          ),
          RadioGroup<StatusIzin>(
            groupValue: widget.sistem.status,
            onChanged: (StatusIzin? baru) {
              if (baru == null) return;
              setState(() => widget.sistem.ubahDiPengaturan(baru));
            },
            child: const Column(
              children: [
                RadioListTile<StatusIzin>(
                  value: StatusIzin.saatDipakai,
                  title: Text('Izinkan hanya saat aplikasi digunakan'),
                ),
                RadioListTile<StatusIzin>(
                  value: StatusIzin.ditolak,
                  title: Text('Tanyakan setiap kali'),
                ),
                RadioListTile<StatusIzin>(
                  value: StatusIzin.ditolakPermanen,
                  title: Text('Jangan izinkan'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

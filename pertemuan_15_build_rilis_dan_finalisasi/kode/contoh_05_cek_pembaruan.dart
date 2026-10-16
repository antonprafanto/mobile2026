// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 15: BUILD, RILIS & FINALISASI
// CONTOH 05: Cek Pembaruan dari Server
// Topik: Aplikasi yang dibagikan lewat GitHub (bukan Play Store) TIDAK
//        diperbarui otomatis. Pengguna perlu diberi tahu bila ada versi
//        baru, dan diminta memperbarui bila versinya sudah terlalu lama
//        (misalnya karena format data di server berubah).
//        1. Server menyimpan berkas kecil info_rilis.json berisi versi
//           terbaru, versi MINIMUM yang masih didukung, catatan rilis,
//           dan tautan unduhan;
//        2. saat aplikasi dibuka, berkas itu diambil lalu dibandingkan
//           dengan versi terpasang memakai aturan Contoh 01;
//        3. "disarankan" -> MaterialBanner yang boleh ditutup;
//           "wajib"      -> dialog yang tidak bisa ditutup (PopScope);
//        4. server mati atau JSON rusak -> aplikasi tetap bisa dipakai.
//           Cek pembaruan TIDAK boleh menghalangi pengguna.
//        "Server" diganti MockClient agar bisa dicoba tanpa internet.
//        Pilih skenarionya lewat menu di pojok kanan atas.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Proyek Flutter: jalankan sekali `flutter pub add http`, salin
//    berkas ini ke lib/main.dart, lalu flutter run -d chrome
// =====================================================================

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

// Versi aplikasi ini. Di proyek sungguhan: package_info_plus.
final Versi versiTerpasang = Versi.urai('1.2.4+10');

void main() => runApp(const AplikasiCekPembaruan());

// ====================== VERSI (dari Contoh 01) ======================

class Versi implements Comparable<Versi> {
  const Versi(this.mayor, this.minor, this.patch, [this.build = 1]);

  final int mayor;
  final int minor;
  final int patch;
  final int build;

  static final RegExp _pola = RegExp(r'^(\d+)\.(\d+)\.(\d+)(?:\+(\d+))?$');

  static Versi urai(String teks) {
    final RegExpMatch? cocok = _pola.firstMatch(teks.trim());
    if (cocok == null) {
      throw FormatException('format harus MAYOR.MINOR.PATCH+BUILD', teks);
    }
    return Versi(
      int.parse(cocok.group(1)!),
      int.parse(cocok.group(2)!),
      int.parse(cocok.group(3)!),
      int.parse(cocok.group(4) ?? '1'),
    );
  }

  String get nama => '$mayor.$minor.$patch';

  @override
  int compareTo(Versi lain) {
    if (mayor != lain.mayor) return mayor.compareTo(lain.mayor);
    if (minor != lain.minor) return minor.compareTo(lain.minor);
    return patch.compareTo(lain.patch);
  }

  bool lebihLamaDari(Versi lain) => compareTo(lain) < 0;
}

enum Keputusan { terbaru, disarankan, wajib }

Keputusan putuskanPembaruan({
  required Versi terpasang,
  required Versi terbaru,
  required Versi minimum,
}) {
  if (terpasang.lebihLamaDari(minimum)) return Keputusan.wajib;
  if (terpasang.lebihLamaDari(terbaru)) return Keputusan.disarankan;
  return Keputusan.terbaru;
}

// ===================== INFO RILIS DARI SERVER =====================

class InfoRilis {
  const InfoRilis({
    required this.terbaru,
    required this.minimum,
    required this.catatan,
    required this.tautan,
  });

  final Versi terbaru;
  final Versi minimum;
  final String catatan;
  final Uri tautan;

  static InfoRilis dariJson(Object? json) {
    return switch (json) {
      {
        'versi_terbaru': final String terbaru,
        'versi_minimum': final String minimum,
        'catatan': final String catatan,
        'tautan': final String tautan,
      } =>
        InfoRilis(
          terbaru: Versi.urai(terbaru),
          minimum: Versi.urai(minimum),
          catatan: catatan,
          tautan: Uri.parse(tautan),
        ),
      _ => throw const FormatException('Bentuk info_rilis.json tidak dikenal'),
    };
  }
}

class LayananInfoRilis {
  LayananInfoRilis({required this._klien, required this.alamat});

  final http.Client _klien;
  final Uri alamat;

  /// null = gagal memeriksa. Sengaja TIDAK melempar galat: cek pembaruan
  /// hanyalah fitur tambahan dan tidak boleh membuat aplikasi macet.
  Future<InfoRilis?> ambil() async {
    try {
      final http.Response respons = await _klien
          .get(alamat)
          .timeout(const Duration(seconds: 5));
      if (respons.statusCode != 200) {
        throw http.ClientException('kode status ${respons.statusCode}');
      }
      return InfoRilis.dariJson(jsonDecode(respons.body));
    } on Exception catch (galat) {
      if (kDebugMode) debugPrint('Cek pembaruan gagal: $galat');
      return null;
    }
  }
}

// ===================== SKENARIO SERVER PALSU =====================

enum Skenario {
  samaDenganTerpasang('Server: belum ada versi baru'),
  adaVersiBaru('Server: ada versi 1.3.0'),
  minimumNaik('Server: versi minimum naik ke 1.3.0'),
  serverMati('Server mati (kode 503)'),
  jsonRusak('Server mengirim JSON rusak');

  const Skenario(this.label);

  final String label;

  http.Client buatKlien() {
    String info(String terbaru, String minimum) => jsonEncode({
      'versi_terbaru': terbaru,
      'versi_minimum': minimum,
      'catatan': 'Jadwal bisa diekspor; perbaikan tombol simpan.',
      // Alamat contoh. Ganti dengan halaman rilis repositori Anda.
      'tautan': 'https://github.com/contoh/jadwal_kuliah/releases/latest',
    });

    return MockClient((http.Request permintaan) async {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return switch (this) {
        Skenario.samaDenganTerpasang => http.Response(
          info('1.2.4', '1.0.0'),
          200,
        ),
        Skenario.adaVersiBaru => http.Response(info('1.3.0', '1.2.0'), 200),
        Skenario.minimumNaik => http.Response(info('1.3.0', '1.3.0'), 200),
        Skenario.serverMati => http.Response('Service Unavailable', 503),
        Skenario.jsonRusak => http.Response('{"versi_terbaru": 13', 200),
      };
    });
  }
}

// ============================ VIEW ============================

class AplikasiCekPembaruan extends StatelessWidget {
  const AplikasiCekPembaruan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jadwal Kuliah',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  Skenario _skenario = Skenario.adaVersiBaru;
  String _hasil = 'Belum diperiksa';

  @override
  void initState() {
    super.initState();
    _periksa(); // diperiksa SEKALI saat aplikasi dibuka
  }

  Future<void> _periksa() async {
    setState(() => _hasil = 'Memeriksa ...');
    final http.Client klien = _skenario.buatKlien();
    final InfoRilis? info = await LayananInfoRilis(
      klien: klien,
      alamat: Uri.https('contoh.github.io', '/jadwal_kuliah/info_rilis.json'),
    ).ambil();
    klien.close();
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    if (info == null) {
      setState(() => _hasil = 'Gagal memeriksa. Aplikasi tetap bisa dipakai.');
      return;
    }
    final Keputusan keputusan = putuskanPembaruan(
      terpasang: versiTerpasang,
      terbaru: info.terbaru,
      minimum: info.minimum,
    );
    setState(() => _hasil = 'Keputusan: ${keputusan.name}');
    switch (keputusan) {
      case Keputusan.terbaru:
        break;
      case Keputusan.disarankan:
        _tampilkanBanner(info);
      case Keputusan.wajib:
        await _tampilkanDialogWajib(info);
    }
  }

  void _tampilkanBanner(InfoRilis info) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        leading: const Icon(Icons.system_update),
        content: Text('Versi ${info.terbaru.nama} tersedia.\n${info.catatan}'),
        actions: [
          TextButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: const Text('Nanti'),
          ),
          FilledButton(
            onPressed: () => _bukaTautan(info.tautan),
            child: const Text('Perbarui'),
          ),
        ],
      ),
    );
  }

  Future<void> _tampilkanDialogWajib(InfoRilis info) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // ketukan di luar dialog tidak menutupnya
      builder: (BuildContext context) => PopScope(
        canPop: false, // tombol Kembali Android juga tidak menutupnya
        child: AlertDialog(
          icon: const Icon(Icons.update),
          title: const Text('Perbarui aplikasi'),
          content: Text(
            'Versi ${versiTerpasang.nama} sudah tidak didukung. '
            'Perbarui ke versi ${info.terbaru.nama} untuk melanjutkan.',
          ),
          actions: [
            FilledButton(
              onPressed: () {
                _bukaTautan(info.tautan);
                // Hanya untuk demo, agar skenario lain bisa dicoba. Di
                // aplikasi sungguhan, dialog ini tetap terbuka.
                Navigator.of(context).pop();
              },
              child: const Text('Perbarui sekarang'),
            ),
          ],
        ),
      ),
    );
  }

  void _bukaTautan(Uri tautan) {
    // Di aplikasi sungguhan: launchUrl(tautan) dari paket url_launcher
    // (Pertemuan 13) membuka halaman unduhan di browser.
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Membuka $tautan')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Kuliah'),
        actions: [
          PopupMenuButton<Skenario>(
            tooltip: 'Pilih skenario server',
            icon: const Icon(Icons.dns_outlined),
            onSelected: (Skenario skenario) {
              setState(() => _skenario = skenario);
              _periksa();
            },
            itemBuilder: (BuildContext context) => [
              for (final Skenario s in Skenario.values)
                PopupMenuItem<Skenario>(value: s, child: Text(s.label)),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.phone_android),
            title: Text('Versi terpasang: ${versiTerpasang.nama}'),
            subtitle: Text('Nomor build ${versiTerpasang.build}'),
          ),
          ListTile(
            leading: const Icon(Icons.dns_outlined),
            title: Text(_skenario.label),
            subtitle: Text(_hasil),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _periksa,
            icon: const Icon(Icons.refresh),
            label: const Text('Periksa lagi'),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 10: ASINKRON & REST API
// CONTOH 10: Menguji Repository Tanpa Internet dengan MockClient
// Topik: Paket http menyediakan MockClient: "server tiruan" yang
//        jawabannya kita tentukan sendiri. Karena LayananDummyJson
//        menerima http.Client lewat constructor, kita bisa memberinya
//        MockClient saat pengujian, lalu memeriksa:
//        - apakah JSON diubah menjadi Model dengan benar;
//        - apakah alamat dan parameter query yang dikirim sudah benar;
//        - apakah kode 404, JSON rusak, dan server lambat menghasilkan
//          exception yang tepat.
//        Semua uji berjalan dalam sekejap, tanpa koneksi internet.
//        SATU pemeriksaan sengaja GAGAL karena ada kesalahan kecil di
//        RepositoriProdukApi. Temukan, perbaiki, lalu jalankan ulang.
// =====================================================================
// CARA MENJALANKAN:
// 1. Proyek Flutter: jalankan `flutter pub add http` sekali.
//    (DartPad sudah menyediakan paket http.)
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
// 3. Jalankan di terminal: flutter run -d chrome
//    Tidak butuh koneksi internet.
// =====================================================================

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

// ========== LAPISAN DATA (sama dengan Contoh 07, dipersingkat) ==========

class Produk {
  const Produk({
    required this.id,
    required this.judul,
    required this.harga,
    required this.rating,
    required this.gambar,
  });

  final int id;
  final String judul;
  final double harga;
  final double rating;
  final String gambar;
}

class HalamanProduk {
  const HalamanProduk({required this.isi, required this.total});

  final List<Produk> isi;
  final int total;
}

class ApiException implements Exception {
  const ApiException(this.kodeStatus);

  final int kodeStatus;

  @override
  String toString() => 'ApiException: kode status $kodeStatus';
}

class LayananDummyJson {
  LayananDummyJson({
    http.Client? klien,
    this.batasWaktu = const Duration(seconds: 10),
  }) : _klien = klien ?? http.Client();

  static const String _host = 'dummyjson.com';

  final http.Client _klien;
  final Duration batasWaktu;

  Future<Map<String, dynamic>> ambilJson(
    String jalur, {
    Map<String, String>? query,
  }) async {
    final http.Response respons = await _klien
        .get(
          Uri.https(_host, jalur, query),
          headers: {'Accept': 'application/json'},
        )
        .timeout(batasWaktu);
    if (respons.statusCode != 200) {
      throw ApiException(respons.statusCode);
    }
    return switch (jsonDecode(utf8.decode(respons.bodyBytes))) {
      final Map<String, dynamic> data => data,
      _ => throw const FormatException('Bentuk JSON tidak dikenal'),
    };
  }
}

class RepositoriProdukApi {
  RepositoriProdukApi({required this._layanan});

  final LayananDummyJson _layanan;

  Future<HalamanProduk> cari({
    required String kataKunci,
    required int lewati,
    required int jumlah,
  }) async {
    final Map<String, dynamic> json = await _layanan.ambilJson(
      kataKunci.isEmpty ? '/products' : '/products/search',
      query: {
        if (kataKunci.isNotEmpty) 'q': kataKunci,
        'limit': '$jumlah',
        'skip': '$jumlah',
        'select': 'title,price,rating,thumbnail',
      },
    );
    return switch (json) {
      {'products': final List<dynamic> isi, 'total': final int total} =>
        HalamanProduk(isi: isi.map(_dariJson).toList(), total: total),
      _ => throw const FormatException('Bentuk data katalog tidak sesuai'),
    };
  }

  Produk _dariJson(dynamic item) {
    return switch (item) {
      {
        'id': final int id,
        'title': final String judul,
        'price': final num harga,
        'rating': final num rating,
        'thumbnail': final String gambar,
      } =>
        Produk(
          id: id,
          judul: judul,
          harga: harga.toDouble(),
          rating: rating.toDouble(),
          gambar: gambar,
        ),
      _ => throw const FormatException('Bentuk data produk tidak sesuai'),
    };
  }
}

// ======================= PEMERIKSAAN =======================

const String jsonDuaProduk = '''
{
  "products": [
    {"id": 1, "title": "Ponsel A", "price": 15, "rating": 4.5,
     "thumbnail": "https://contoh.test/a.webp"},
    {"id": 2, "title": "Ponsel B", "price": 9.99, "rating": 3,
     "thumbnail": "https://contoh.test/b.webp"}
  ],
  "total": 2,
  "skip": 0,
  "limit": 10
}
''';

class HasilUji {
  const HasilUji(this.nama, this.lulus, this.keterangan);

  final String nama;
  final bool lulus;
  final String keterangan;
}

HasilUji periksa(String nama, Object? didapat, Object? diharapkan) {
  final bool lulus = didapat == diharapkan;
  return HasilUji(
    nama,
    lulus,
    lulus
        ? 'Hasil: $didapat'
        : 'Diharapkan $diharapkan, tetapi hasilnya $didapat',
  );
}

// Menjalankan sebuah aksi dan melaporkan JENIS galat yang muncul.
Future<String> galatDari(Future<Object?> Function() aksi) async {
  try {
    await aksi();
    return 'tidak ada galat';
  } on ApiException catch (galat) {
    return 'ApiException ${galat.kodeStatus}';
  } on FormatException {
    return 'FormatException';
  } on TimeoutException {
    return 'TimeoutException';
  } catch (galat) {
    return 'galat lain: ${galat.runtimeType}';
  }
}

// Membuat repository yang "servernya" adalah MockClient.
RepositoriProdukApi repositoriDengan(
  MockClient server, {
  Duration batasWaktu = const Duration(seconds: 2),
}) {
  return RepositoriProdukApi(
    layanan: LayananDummyJson(klien: server, batasWaktu: batasWaktu),
  );
}

Future<List<HasilUji>> jalankanSemuaUji() async {
  final List<HasilUji> hasil = [];

  // Server tiruan yang selalu menjawab dua produk, sambil mencatat
  // permintaan terakhir yang diterimanya.
  http.Request? terakhir;
  final MockClient serverBaik = MockClient((http.Request permintaan) async {
    terakhir = permintaan;
    return http.Response(jsonDuaProduk, 200);
  });
  final RepositoriProdukApi repo = repositoriDengan(serverBaik);

  // 1-3. JSON -> Model, dan alamat tanpa kata kunci.
  final HalamanProduk halaman = await repo.cari(
    kataKunci: '',
    lewati: 0,
    jumlah: 10,
  );
  hasil.add(periksa('Membaca 2 produk', halaman.isi.length, 2));
  hasil.add(periksa('Judul produk kedua', halaman.isi[1].judul, 'Ponsel B'));
  hasil.add(
    periksa('Tanpa kata kunci: /products', terakhir!.url.path, '/products'),
  );

  // 4. Kata kunci dikirim lewat /products/search?q=...
  await repo.cari(kataKunci: 'phone', lewati: 0, jumlah: 10);
  hasil.add(
    periksa(
      'Kata kunci dikirim sebagai q',
      '${terakhir!.url.path}?q=${terakhir!.url.queryParameters['q']}',
      '/products/search?q=phone',
    ),
  );

  // 5. Halaman ketiga harus melewati 20 produk pertama.
  await repo.cari(kataKunci: '', lewati: 20, jumlah: 10);
  hasil.add(
    periksa(
      'Halaman ketiga: skip=20',
      terakhir!.url.queryParameters['skip'],
      '20',
    ),
  );

  // 6. Server menjawab 404.
  final RepositoriProdukApi repo404 = repositoriDengan(
    MockClient((http.Request permintaan) async => http.Response('{}', 404)),
  );
  hasil.add(
    periksa(
      'Kode 404 menjadi ApiException',
      await galatDari(() => repo404.cari(kataKunci: '', lewati: 0, jumlah: 10)),
      'ApiException 404',
    ),
  );

  // 7. Server menjawab 200, tetapi isinya bukan JSON.
  final RepositoriProdukApi repoHtml = repositoriDengan(
    MockClient(
      (http.Request permintaan) async =>
          http.Response('<html>Server sibuk</html>', 200),
    ),
  );
  hasil.add(
    periksa(
      'Body bukan JSON menjadi FormatException',
      await galatDari(
        () => repoHtml.cari(kataKunci: '', lewati: 0, jumlah: 10),
      ),
      'FormatException',
    ),
  );

  // 8. JSON sah, tetapi kolom price hilang.
  final RepositoriProdukApi repoTakLengkap = repositoriDengan(
    MockClient(
      (http.Request permintaan) async => http.Response(
        '{"products": [{"id": 1, "title": "X", "rating": 4, '
        '"thumbnail": "x"}], "total": 1}',
        200,
      ),
    ),
  );
  hasil.add(
    periksa(
      'Kolom price hilang menjadi FormatException',
      await galatDari(
        () => repoTakLengkap.cari(kataKunci: '', lewati: 0, jumlah: 10),
      ),
      'FormatException',
    ),
  );

  // 9. Server terlalu lambat (300 ms), batas waktu 100 ms.
  final RepositoriProdukApi repoLambat = repositoriDengan(
    MockClient((http.Request permintaan) async {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return http.Response(jsonDuaProduk, 200);
    }),
    batasWaktu: const Duration(milliseconds: 100),
  );
  hasil.add(
    periksa(
      'Server lambat menjadi TimeoutException',
      await galatDari(
        () => repoLambat.cari(kataKunci: '', lewati: 0, jumlah: 10),
      ),
      'TimeoutException',
    ),
  );

  return hasil;
}

// ============================ VIEW ============================

Future<void> main() async {
  final List<HasilUji> hasil = await jalankanSemuaUji();
  for (final HasilUji uji in hasil) {
    debugPrint('${uji.lulus ? 'LULUS' : 'GAGAL'}  ${uji.nama}');
  }
  runApp(AplikasiUji(hasil: hasil));
}

class AplikasiUji extends StatelessWidget {
  const AplikasiUji({super.key, required this.hasil});

  final List<HasilUji> hasil;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uji Repository',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: HalamanHasilUji(hasil: hasil),
    );
  }
}

class HalamanHasilUji extends StatelessWidget {
  const HalamanHasilUji({super.key, required this.hasil});

  final List<HasilUji> hasil;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    final int jumlahLulus = hasil.where((HasilUji uji) => uji.lulus).length;
    final bool semuaLulus = jumlahLulus == hasil.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Uji Repository')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card.filled(
            color: semuaLulus ? warna.primaryContainer : warna.errorContainer,
            child: ListTile(
              leading: Icon(
                semuaLulus ? Icons.verified : Icons.bug_report,
                color: semuaLulus
                    ? warna.onPrimaryContainer
                    : warna.onErrorContainer,
              ),
              title: Text(
                '$jumlahLulus dari ${hasil.length} uji lulus',
                style: gayaTeks.titleMedium?.copyWith(
                  color: semuaLulus
                      ? warna.onPrimaryContainer
                      : warna.onErrorContainer,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          for (final HasilUji uji in hasil)
            ListTile(
              leading: Icon(
                uji.lulus ? Icons.check_circle : Icons.cancel,
                color: uji.lulus ? warna.primary : warna.error,
              ),
              title: Text(uji.nama),
              subtitle: Text(uji.keterangan),
            ),
        ],
      ),
    );
  }
}

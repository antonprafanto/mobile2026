// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 10: ASINKRON & REST API
// CONTOH 07: Parameter Query, Pencarian, dan "Muat Lebih Banyak"
// Topik: Katalog produk dari https://dummyjson.com/products.
//        - Parameter query (?q=...&limit=10&skip=0) dibuat dengan
//          Uri.https(host, jalur, {...}), bukan disambung manual.
//        - Pencarian menunggu pengguna berhenti mengetik 400 ms
//          (debounce) sebelum mengirim permintaan.
//        - Jawaban yang datang TERLAMBAT (milik pencarian lama) dibuang
//          dengan nomor permintaan.
//        - "Muat lebih banyak" meminta 10 produk berikutnya (skip).
//        - Gambar dari internet ditampilkan dengan Image.network,
//          lengkap dengan tampilan saat memuat dan saat gagal.
// =====================================================================
// CARA MENJALANKAN:
// 1. Proyek Flutter: jalankan `flutter pub add http provider` sekali.
//    (DartPad sudah menyediakan kedua paket ini.)
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
// 3. Jalankan di terminal: flutter run -d chrome
//    Butuh koneksi internet.
// =====================================================================

import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<LayananDummyJson>(
          create: (BuildContext context) => LayananDummyJson(),
          dispose: (BuildContext context, LayananDummyJson layanan) =>
              layanan.tutup(),
        ),
        Provider<RepositoriProduk>(
          create: (BuildContext context) =>
              RepositoriProdukApi(layanan: context.read<LayananDummyJson>()),
        ),
      ],
      child: const AplikasiKatalog(),
    ),
  );
}

// =========================== MODEL ===========================

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
  final double harga; // dalam dolar AS, sesuai data DummyJSON
  final double rating;
  final String gambar; // alamat gambar kecil (thumbnail)
}

// Satu "halaman" hasil: sebagian produk + jumlah seluruh produk yang cocok.
class HalamanProduk {
  const HalamanProduk({required this.isi, required this.total});

  final List<Produk> isi;
  final int total;
}

// ===================== SERVICE (LAYANAN) =====================

class ApiException implements Exception {
  const ApiException(this.kodeStatus);

  final int kodeStatus;

  @override
  String toString() => 'ApiException: kode status $kodeStatus';
}

class LayananDummyJson {
  LayananDummyJson({http.Client? klien}) : _klien = klien ?? http.Client();

  static const String _host = 'dummyjson.com';
  static const Duration _batasWaktu = Duration(seconds: 10);

  final http.Client _klien;

  Future<Map<String, dynamic>> ambilJson(
    String jalur, {
    Map<String, String>? query,
  }) async {
    final Uri alamat = Uri.https(_host, jalur, query);
    debugPrint('GET $alamat');
    final http.Response respons = await _klien
        .get(alamat, headers: {'Accept': 'application/json'})
        .timeout(_batasWaktu);

    if (respons.statusCode != 200) {
      throw ApiException(respons.statusCode);
    }
    return switch (jsonDecode(utf8.decode(respons.bodyBytes))) {
      final Map<String, dynamic> data => data,
      _ => throw const FormatException('Bentuk JSON tidak dikenal'),
    };
  }

  void tutup() => _klien.close();
}

// ========================= REPOSITORY =========================

abstract class RepositoriProduk {
  Future<HalamanProduk> cari({
    required String kataKunci,
    required int lewati,
    required int jumlah,
  });
}

class RepositoriProdukApi implements RepositoriProduk {
  RepositoriProdukApi({required this._layanan});

  final LayananDummyJson _layanan;

  @override
  Future<HalamanProduk> cari({
    required String kataKunci,
    required int lewati,
    required int jumlah,
  }) async {
    final Map<String, dynamic> json = await _layanan.ambilJson(
      // Tanpa kata kunci: semua produk. Dengan kata kunci: pencarian.
      kataKunci.isEmpty ? '/products' : '/products/search',
      query: {
        if (kataKunci.isNotEmpty) 'q': kataKunci,
        'limit': '$jumlah',
        'skip': '$lewati',
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

// ========================= VIEWMODEL =========================

enum StatusMuat { memuat, berhasil, gagal }

class KatalogViewModel extends ChangeNotifier {
  KatalogViewModel({required this._repositori});

  static const int _perHalaman = 10;

  final RepositoriProduk _repositori;

  StatusMuat _status = StatusMuat.memuat;
  final List<Produk> _produk = [];
  int _total = 0;
  String _kataKunci = '';
  String _pesanGalat = '';
  bool _memuatLagi = false;
  bool _galatMuatLagi = false;

  // Setiap permintaan halaman pertama diberi nomor. Jawaban dengan nomor
  // lama (milik pencarian sebelumnya) diabaikan.
  int _nomorPermintaan = 0;
  Timer? _penunda;
  bool _sudahDibuang = false;

  StatusMuat get status => _status;
  UnmodifiableListView<Produk> get produk => UnmodifiableListView(_produk);
  int get total => _total;
  String get kataKunci => _kataKunci;
  String get pesanGalat => _pesanGalat;
  bool get memuatLagi => _memuatLagi;
  bool get galatMuatLagi => _galatMuatLagi;
  bool get masihAda => _produk.length < _total;

  // Memuat halaman pertama (juga dipakai tombol "Coba lagi").
  Future<void> muat() async {
    final int nomor = ++_nomorPermintaan;
    _status = StatusMuat.memuat;
    _memuatLagi = false;
    _galatMuatLagi = false;
    notifyListeners();

    try {
      final HalamanProduk halaman = await _repositori.cari(
        kataKunci: _kataKunci,
        lewati: 0,
        jumlah: _perHalaman,
      );
      if (_sudahDibuang || nomor != _nomorPermintaan) {
        return; // jawaban terlambat: sudah ada pencarian yang lebih baru
      }
      _produk
        ..clear()
        ..addAll(halaman.isi);
      _total = halaman.total;
      _status = StatusMuat.berhasil;
    } catch (galat) {
      if (_sudahDibuang || nomor != _nomorPermintaan) {
        return;
      }
      debugPrint('Galat saat memuat katalog: $galat');
      _pesanGalat = 'Katalog gagal dimuat. Periksa koneksi, lalu coba lagi.';
      _status = StatusMuat.gagal;
    }
    notifyListeners();
  }

  // Dipanggil setiap kali isi kotak pencarian berubah.
  void cari(String teks) {
    _kataKunci = teks.trim();
    // Debounce: batalkan penunda lama, mulai menunggu 400 ms lagi.
    _penunda?.cancel();
    _penunda = Timer(const Duration(milliseconds: 400), muat);
  }

  Future<void> muatLagi() async {
    if (_memuatLagi || !masihAda || _status != StatusMuat.berhasil) {
      return;
    }
    final int nomor = _nomorPermintaan;
    _memuatLagi = true;
    _galatMuatLagi = false;
    notifyListeners();

    try {
      final HalamanProduk halaman = await _repositori.cari(
        kataKunci: _kataKunci,
        lewati: _produk.length, // lewati produk yang sudah ditampilkan
        jumlah: _perHalaman,
      );
      if (_sudahDibuang || nomor != _nomorPermintaan) {
        return;
      }
      _produk.addAll(halaman.isi);
      _total = halaman.total;
    } catch (galat) {
      if (_sudahDibuang || nomor != _nomorPermintaan) {
        return;
      }
      debugPrint('Galat saat memuat lagi: $galat');
      _galatMuatLagi = true;
    }
    _memuatLagi = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _penunda?.cancel();
    _sudahDibuang = true;
    super.dispose();
  }
}

// ============================ VIEW ============================

class AplikasiKatalog extends StatelessWidget {
  const AplikasiKatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Produk',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: ChangeNotifierProvider(
        create: (BuildContext context) =>
            KatalogViewModel(repositori: context.read<RepositoriProduk>())
              ..muat(),
        child: const HalamanKatalog(),
      ),
    );
  }
}

class HalamanKatalog extends StatelessWidget {
  const HalamanKatalog({super.key});

  @override
  Widget build(BuildContext context) {
    final KatalogViewModel vm = context.watch<KatalogViewModel>();

    final Widget isi = switch (vm.status) {
      StatusMuat.memuat => const Center(child: CircularProgressIndicator()),
      StatusMuat.gagal => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(vm.pesanGalat, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => context.read<KatalogViewModel>().muat(),
                icon: const Icon(Icons.refresh),
                label: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      ),
      StatusMuat.berhasil when vm.produk.isEmpty => Center(
        child: Text('Tidak ada produk yang cocok dengan "${vm.kataKunci}".'),
      ),
      StatusMuat.berhasil => DaftarProduk(vm: vm),
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Katalog Produk')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: SearchBar(
              hintText: 'Cari produk, misalnya phone',
              leading: const Icon(Icons.search),
              onChanged: (String teks) =>
                  context.read<KatalogViewModel>().cari(teks),
            ),
          ),
          Expanded(child: isi),
        ],
      ),
    );
  }
}

class DaftarProduk extends StatelessWidget {
  const DaftarProduk({super.key, required this.vm});

  final KatalogViewModel vm;

  @override
  Widget build(BuildContext context) {
    final List<Produk> daftar = vm.produk;

    return ListView.builder(
      // +1 untuk baris paling bawah (keterangan dan tombol muat lagi).
      itemCount: daftar.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == daftar.length) {
          return BarisBawah(vm: vm);
        }
        final Produk produk = daftar[index];
        return ListTile(
          leading: GambarProduk(alamat: produk.gambar),
          title: Text(produk.judul),
          subtitle: Text(
            'US\$${produk.harga.toStringAsFixed(2)} · '
            'rating ${produk.rating.toStringAsFixed(1)}',
          ),
        );
      },
    );
  }
}

class GambarProduk extends StatelessWidget {
  const GambarProduk({super.key, required this.alamat});

  final String alamat;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox.square(
        dimension: 56,
        child: Image.network(
          alamat,
          fit: BoxFit.cover,
          // Selama gambar diunduh: lingkaran kecil.
          loadingBuilder:
              (BuildContext context, Widget child, ImageChunkEvent? proses) {
                if (proses == null) return child; // sudah selesai
                return const Center(
                  child: SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
          // Jika gagal (alamat salah, tidak ada koneksi): ikon pengganti.
          errorBuilder:
              (BuildContext context, Object galat, StackTrace? jejak) =>
                  ColoredBox(
                    color: warna.surfaceContainerHighest,
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: warna.onSurfaceVariant,
                    ),
                  ),
        ),
      ),
    );
  }
}

class BarisBawah extends StatelessWidget {
  const BarisBawah({super.key, required this.vm});

  final KatalogViewModel vm;

  @override
  Widget build(BuildContext context) {
    final Widget aksi;
    if (vm.memuatLagi) {
      aksi = const CircularProgressIndicator();
    } else if (vm.galatMuatLagi) {
      aksi = TextButton.icon(
        onPressed: () => context.read<KatalogViewModel>().muatLagi(),
        icon: const Icon(Icons.refresh),
        label: const Text('Gagal memuat. Coba lagi'),
      );
    } else if (vm.masihAda) {
      aksi = OutlinedButton(
        onPressed: () => context.read<KatalogViewModel>().muatLagi(),
        child: const Text('Muat lebih banyak'),
      );
    } else {
      aksi = const Text('Semua produk sudah ditampilkan.');
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Menampilkan ${vm.produk.length} dari ${vm.total} produk'),
          const SizedBox(height: 8),
          aksi,
        ],
      ),
    );
  }
}

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 12: CLEAN ARCHITECTURE
// CONTOH 05: Hasil<T> dan Kegagalan: Galat yang Menyeberangi Lapisan
// Topik: Di Pertemuan 10, ViewModel menangkap ClientException,
//        TimeoutException, dan FormatException sendiri, sehingga lapisan
//        UI ikut mengenal urusan HTTP. Di sini repository mengembalikan
//        Hasil<T>: Berhasil(nilai) ATAU Gagal(kegagalan). Exception
//        teknis diterjemahkan SEKALI di lapisan data menjadi Kegagalan
//        milik aplikasi (TanpaKoneksi, WaktuHabis, ServerBermasalah,
//        DataRusak). Pilih skenario "server" di atas layar (dibuat
//        dengan MockClient, tanpa internet) dan perhatikan kotak "Yang
//        diterima ViewModel".
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Proyek Flutter: jalankan sekali `flutter pub add http provider`,
//    salin seluruh isi berkas ini ke lib/main.dart, lalu
//    flutter run -d chrome --web-port=8080
// =====================================================================

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Hasil dan Kegagalan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const HalamanUji(),
    ),
  );
}

// ============================== DOMAIN ==============================

class Ruang {
  const Ruang({required this.kode, required this.nama});

  final String kode;
  final String nama;
}

// Hasil<T>: kotak berisi nilai bertipe T (Berhasil) ATAU kegagalan
// (Gagal). Karena sealed, switch wajib menangani keduanya.
sealed class Hasil<T> {
  const Hasil();
}

final class Berhasil<T> extends Hasil<T> {
  const Berhasil(this.nilai);

  final T nilai;
}

final class Gagal<T> extends Hasil<T> {
  const Gagal(this.kegagalan);

  final Kegagalan kegagalan;
}

// Bahasa kegagalan milik aplikasi, bebas dari istilah HTTP.
sealed class Kegagalan {
  const Kegagalan();
}

final class TanpaKoneksi extends Kegagalan {
  const TanpaKoneksi();
}

final class WaktuHabis extends Kegagalan {
  const WaktuHabis();
}

final class ServerBermasalah extends Kegagalan {
  const ServerBermasalah(this.kodeStatus);

  final int kodeStatus;
}

final class DataRusak extends Kegagalan {
  const DataRusak();
}

abstract class RepositoriRuang {
  Future<Hasil<List<Ruang>>> semuaRuang();
}

// =============================== DATA ===============================

class ApiException implements Exception {
  const ApiException(this.kodeStatus);

  final int kodeStatus;
}

// Layanan: boleh melempar exception teknis.
class LayananApiKampus {
  LayananApiKampus({required this._klien});

  static const Duration batasWaktu = Duration(seconds: 3);

  final http.Client _klien;

  Future<Object?> ambilDataRuang() async {
    final http.Response respons = await _klien
        .get(Uri.https('api.kampus.example', '/ruang'))
        .timeout(batasWaktu);
    if (respons.statusCode != 200) throw ApiException(respons.statusCode);
    return jsonDecode(respons.body);
  }
}

// Repository: SATU-SATUNYA tempat exception diterjemahkan.
class RepositoriRuangServer implements RepositoriRuang {
  RepositoriRuangServer({required this._layanan});

  final LayananApiKampus _layanan;

  @override
  Future<Hasil<List<Ruang>>> semuaRuang() async {
    try {
      final Object? json = await _layanan.ambilDataRuang();
      final List<Ruang> daftar = switch (json) {
        {'rooms': final List<Object?> rooms} => [
          for (final Object? baris in rooms) _bacaRuang(baris),
        ],
        _ => throw const FormatException('Kolom rooms tidak ditemukan'),
      };
      return Berhasil(daftar);
    } on TimeoutException {
      return const Gagal(WaktuHabis());
    } on http.ClientException {
      return const Gagal(TanpaKoneksi());
    } on ApiException catch (galat) {
      return Gagal(ServerBermasalah(galat.kodeStatus));
    } on FormatException {
      return const Gagal(DataRusak());
    }
  }

  // Satu baris JSON -> Ruang. Baris yang tidak sesuai melempar
  // FormatException, yang lalu ditangkap di semuaRuang() di atas.
  static Ruang _bacaRuang(Object? baris) {
    return switch (baris) {
      {'room_code': final String kode, 'room_name': final String nama} => Ruang(
        kode: kode,
        nama: nama,
      ),
      _ => throw const FormatException('Baris ruang tidak sesuai'),
    };
  }
}

// "Server" palsu untuk setiap skenario (MockClient, tanpa internet).
enum Skenario {
  normal('Normal'),
  lambat('Lambat 5 detik'),
  galatServer('Server error'),
  bukanJson('Bukan JSON'),
  tanpaKoneksi('Tanpa koneksi');

  const Skenario(this.label);

  final String label;
}

const String jsonRuang = '''
{"rooms": [
  {"room_code": "LAB-1", "room_name": "Laboratorium Komputer 1"},
  {"room_code": "C-105", "room_name": "Ruang Seminar C.105"},
  {"room_code": "C-110", "room_name": "Ruang Diskusi C.110"}
]}
''';

http.Client buatKlienPalsu(Skenario skenario) {
  return MockClient((http.Request permintaan) async {
    switch (skenario) {
      case Skenario.normal:
        return http.Response(jsonRuang, 200);
      case Skenario.lambat:
        await Future<void>.delayed(const Duration(seconds: 5));
        return http.Response(jsonRuang, 200);
      case Skenario.galatServer:
        return http.Response('{"error": "database down"}', 500);
      case Skenario.bukanJson:
        return http.Response('<html>Halaman perawatan</html>', 200);
      case Skenario.tanpaKoneksi:
        throw http.ClientException('Failed to fetch');
    }
  });
}

// ================================ UI ================================

class RuangViewModel extends ChangeNotifier {
  RuangViewModel({required this._repositori});

  final RepositoriRuang _repositori;

  bool _memuat = false;
  Hasil<List<Ruang>>? _hasil;
  bool _sudahDibuang = false;

  bool get memuat => _memuat;
  Hasil<List<Ruang>>? get hasil => _hasil;

  Future<void> muat() async {
    _memuat = true;
    notifyListeners();
    // Tidak ada try-catch: semua kemungkinan sudah ada di dalam Hasil.
    final Hasil<List<Ruang>> hasil = await _repositori.semuaRuang();
    if (_sudahDibuang) return;
    _hasil = hasil;
    _memuat = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    super.dispose();
  }
}

// Satu tempat untuk kalimat yang dibaca pengguna. switch wajib lengkap.
String pesanKegagalan(Kegagalan kegagalan) {
  return switch (kegagalan) {
    TanpaKoneksi() => 'Tidak dapat terhubung. Periksa koneksi internet Anda.',
    WaktuHabis() => 'Server terlalu lama menjawab. Coba lagi sebentar lagi.',
    ServerBermasalah(:final int kodeStatus) =>
      'Server sedang bermasalah (kode $kodeStatus). Coba lagi nanti.',
    DataRusak() => 'Data dari server tidak bisa dibaca.',
  };
}

// Hanya untuk pelajaran: menuliskan isi Hasil apa adanya.
String gambarkan(Hasil<List<Ruang>> hasil) {
  return switch (hasil) {
    Berhasil(:final List<Ruang> nilai) => 'Berhasil(${nilai.length} ruang)',
    Gagal(:final Kegagalan kegagalan) => switch (kegagalan) {
      TanpaKoneksi() => 'Gagal(TanpaKoneksi())',
      WaktuHabis() => 'Gagal(WaktuHabis())',
      ServerBermasalah(:final int kodeStatus) =>
        'Gagal(ServerBermasalah($kodeStatus))',
      DataRusak() => 'Gagal(DataRusak())',
    },
  };
}

class HalamanUji extends StatefulWidget {
  const HalamanUji({super.key});

  @override
  State<HalamanUji> createState() => _HalamanUjiState();
}

class _HalamanUjiState extends State<HalamanUji> {
  Skenario _skenario = Skenario.normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Uji Kegagalan')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final Skenario s in Skenario.values)
                  ChoiceChip(
                    label: Text(s.label),
                    selected: s == _skenario,
                    onSelected: (_) => setState(() => _skenario = s),
                  ),
              ],
            ),
          ),
          Expanded(
            // Skenario berganti -> repository dan ViewModel dibuat ulang.
            child: Provider<RepositoriRuang>(
              key: ValueKey(_skenario),
              create: (BuildContext context) => RepositoriRuangServer(
                layanan: LayananApiKampus(klien: buatKlienPalsu(_skenario)),
              ),
              child: ChangeNotifierProvider(
                create: (BuildContext context) =>
                    RuangViewModel(repositori: context.read<RepositoriRuang>())
                      ..muat(),
                child: const TampilanHasil(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TampilanHasil extends StatelessWidget {
  const TampilanHasil({super.key});

  @override
  Widget build(BuildContext context) {
    final RuangViewModel vm = context.watch<RuangViewModel>();
    final Hasil<List<Ruang>>? hasil = vm.hasil;
    if (vm.memuat || hasil == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final ColorScheme warna = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.inventory_2_outlined),
            title: const Text('Yang diterima ViewModel'),
            subtitle: Text(
              gambarkan(hasil),
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // View membaca Hasil dengan switch: tidak ada exception di sini.
        ...switch (hasil) {
          Berhasil(:final List<Ruang> nilai) => [
            for (final Ruang r in nilai)
              ListTile(
                leading: const Icon(Icons.meeting_room_outlined),
                title: Text(r.nama),
                subtitle: Text(r.kode),
              ),
          ],
          Gagal(:final Kegagalan kegagalan) => [
            Card(
              color: warna.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pesanKegagalan(kegagalan),
                      style: TextStyle(color: warna.onErrorContainer),
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: vm.muat,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba lagi'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        },
      ],
    );
  }
}

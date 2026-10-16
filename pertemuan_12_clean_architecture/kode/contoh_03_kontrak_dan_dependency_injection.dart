// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 12: CLEAN ARCHITECTURE
// CONTOH 03: Kontrak Repository dan Dependency Injection
// Topik: ViewModel hanya mengenal KONTRAK RepositoriRuang. Ada dua
//        implementasi: RepositoriRuangMemori (data palsu) dan
//        RepositoriRuangServer (JSON dari GitHub). Implementasi dipilih
//        di SATU tempat, yaitu akar komposisi (composition root).
//        Tombol "Data palsu" / "Server" di atas layar menukar
//        implementasi yang diberikan kepada ViewModel, sedangkan
//        ViewModel dan View tidak berubah sedikit pun. Versi server juga
//        menyimpan salinan data: tukar ke "Data palsu", lalu kembali ke
//        "Server". Angka "Permintaan ke server" tetap 1.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Proyek Flutter: jalankan sekali `flutter pub add http provider`,
//    salin seluruh isi berkas ini ke lib/main.dart, lalu
//    flutter run -d chrome --web-port=8080
// =====================================================================

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Kontrak dan DI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const AkarKomposisi(),
    ),
  );
}

// =========================== DOMAIN ===========================

class Ruang {
  const Ruang({
    required this.kode,
    required this.nama,
    required this.gedung,
    required this.kapasitas,
  });

  final String kode;
  final String nama;
  final String gedung;
  final int kapasitas;
}

// KONTRAK: hanya menyebut APA yang tersedia, bukan dari mana datangnya.
abstract class RepositoriRuang {
  Future<List<Ruang>> semuaRuang();
}

// ============================ DATA ============================

class RepositoriRuangMemori implements RepositoriRuang {
  static const List<Ruang> _data = [
    Ruang(kode: 'LAB-1', nama: 'Lab Komputer 1', gedung: 'B', kapasitas: 40),
    Ruang(kode: 'B-204', nama: 'Kelas B.204', gedung: 'B', kapasitas: 45),
    Ruang(kode: 'C-110', nama: 'Diskusi C.110', gedung: 'C', kapasitas: 12),
  ];

  @override
  Future<List<Ruang>> semuaRuang() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return _data;
  }
}

class RepositoriRuangServer implements RepositoriRuang {
  // Kebutuhan khusus implementasi ini (klien HTTP dan penghitung)
  // ikut disuntikkan dari luar. ViewModel tidak perlu tahu.
  RepositoriRuangServer({required this._klien, this.saatMeminta});

  final http.Client _klien;
  final void Function()? saatMeminta;
  List<Ruang>? _salinan;

  static final Uri alamat = Uri.https(
    'raw.githubusercontent.com',
    '/antonprafanto/mobile2026/main/'
        'pertemuan_12_clean_architecture/data/ruang_kampus.json',
  );

  @override
  Future<List<Ruang>> semuaRuang() async {
    final List<Ruang>? salinan = _salinan;
    if (salinan != null) return salinan; // tanpa internet
    final http.Response respons = await _klien
        .get(alamat)
        .timeout(const Duration(seconds: 10));
    saatMeminta?.call();
    if (respons.statusCode != 200) {
      throw http.ClientException('Kode status ${respons.statusCode}');
    }
    final List<Ruang> daftar = switch (jsonDecode(respons.body)) {
      {'rooms': final List<Object?> rooms} => [
        for (final Object? baris in rooms) ?_bacaRuang(baris),
      ],
      _ => throw const FormatException('Bentuk data ruang tidak sesuai'),
    };
    return _salinan = daftar;
  }

  // Baris yang tidak aktif atau tidak lengkap menjadi null (dilewati).
  static Ruang? _bacaRuang(Object? baris) {
    return switch (baris) {
      {
        'room_code': final String kode,
        'room_name': final String nama,
        'building': final String gedung,
        'capacity': final int kapasitas,
        'is_active': true,
      } =>
        Ruang(kode: kode, nama: nama, gedung: gedung, kapasitas: kapasitas),
      _ => null,
    };
  }
}

// ============================= UI =============================

enum StatusMuat { memuat, berhasil, gagal }

class DaftarRuangViewModel extends ChangeNotifier {
  // Satu-satunya yang dikenal ViewModel: KONTRAK RepositoriRuang.
  DaftarRuangViewModel({required this._repositori});

  final RepositoriRuang _repositori;

  StatusMuat _status = StatusMuat.memuat;
  List<Ruang> _daftar = [];
  bool _sudahDibuang = false;

  StatusMuat get status => _status;
  List<Ruang> get daftar => _daftar;

  Future<void> muat() async {
    _status = StatusMuat.memuat;
    notifyListeners();
    try {
      final List<Ruang> hasil = await _repositori.semuaRuang();
      if (_sudahDibuang) return;
      _daftar = hasil;
      _status = StatusMuat.berhasil;
    } catch (galat) {
      if (_sudahDibuang) return;
      debugPrint('Gagal memuat ruang: $galat');
      _status = StatusMuat.gagal;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    super.dispose();
  }
}

enum SumberData { memori, server }

// AKAR KOMPOSISI: satu-satunya tempat yang menyebut nama implementasi.
// Biasanya ditulis di main(). Di contoh ini ia berupa widget agar
// sumbernya bisa ditukar saat aplikasi berjalan.
class AkarKomposisi extends StatefulWidget {
  const AkarKomposisi({super.key});

  @override
  State<AkarKomposisi> createState() => _AkarKomposisiState();
}

class _AkarKomposisiState extends State<AkarKomposisi> {
  final http.Client _klien = http.Client();
  SumberData _sumber = SumberData.memori;
  int _permintaan = 0;

  // Setiap implementasi dibuat SEKALI lalu dipakai ulang, sehingga
  // salinan data milik versi server tidak hilang saat sumber ditukar.
  late final RepositoriRuang _memori = RepositoriRuangMemori();
  late final RepositoriRuang _server = RepositoriRuangServer(
    klien: _klien,
    saatMeminta: () => setState(() => _permintaan++),
  );

  @override
  void dispose() {
    _klien.close();
    super.dispose();
  }

  RepositoriRuang get _repositori => switch (_sumber) {
    SumberData.memori => _memori,
    SumberData.server => _server,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Ruang')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                SegmentedButton<SumberData>(
                  segments: const [
                    ButtonSegment(
                      value: SumberData.memori,
                      icon: Icon(Icons.memory),
                      label: Text('Data palsu'),
                    ),
                    ButtonSegment(
                      value: SumberData.server,
                      icon: Icon(Icons.cloud_outlined),
                      label: Text('Server'),
                    ),
                  ],
                  selected: {_sumber},
                  onSelectionChanged: (Set<SumberData> pilihan) {
                    setState(() => _sumber = pilihan.first);
                  },
                ),
                const SizedBox(height: 8),
                Text('Permintaan ke server sejauh ini: $_permintaan'),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            // Provider.value: objek repository-nya sudah ada, jadi tidak
            // dibuat di sini. key: sumber berganti -> ViewModel dibuat
            // ulang dengan repository yang lain.
            child: Provider<RepositoriRuang>.value(
              key: ValueKey(_sumber),
              value: _repositori,
              child: ChangeNotifierProvider(
                create: (BuildContext context) => DaftarRuangViewModel(
                  repositori: context.read<RepositoriRuang>(),
                )..muat(),
                child: const TampilanDaftarRuang(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// View: tidak tahu apa pun tentang memori, server, atau JSON.
class TampilanDaftarRuang extends StatelessWidget {
  const TampilanDaftarRuang({super.key});

  @override
  Widget build(BuildContext context) {
    final DaftarRuangViewModel vm = context.watch<DaftarRuangViewModel>();
    return switch (vm.status) {
      StatusMuat.memuat => const Center(child: CircularProgressIndicator()),
      StatusMuat.gagal => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Data ruang gagal dimuat.'),
            const SizedBox(height: 8),
            FilledButton(onPressed: vm.muat, child: const Text('Coba lagi')),
          ],
        ),
      ),
      StatusMuat.berhasil => ListView(
        children: [
          for (final Ruang r in vm.daftar)
            ListTile(
              leading: const Icon(Icons.meeting_room_outlined),
              title: Text(r.nama),
              subtitle: Text('${r.kode} · Gedung ${r.gedung}'),
              trailing: Text('${r.kapasitas} orang'),
            ),
        ],
      ),
    };
  }
}

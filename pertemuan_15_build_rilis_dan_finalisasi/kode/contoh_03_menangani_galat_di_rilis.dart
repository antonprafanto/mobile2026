// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 15: BUILD, RILIS & FINALISASI
// CONTOH 03: Menangani Galat di Aplikasi Rilis
// Topik: Di mode debug, galat saat membangun widget tampil sebagai layar
//        MERAH berisi pesan lengkap. Di build RILIS, layar merah itu
//        menjadi kotak ABU-ABU tanpa keterangan, dan pesan galatnya
//        hilang begitu saja. Contoh ini memasang jaring pengaman:
//        1. FlutterError.onError       : galat saat membangun, menata,
//                                        dan menggambar widget;
//        2. PlatformDispatcher.onError : galat asinkron yang lolos
//                                        (Android, iOS, desktop);
//           runZonedGuarded            : galat asinkron yang lolos di
//                                        web, karena di web (terbukti di
//                                        DartPad) PlatformDispatcher
//                                        .onError tidak terpanggil;
//        3. ErrorWidget.builder        : pengganti kotak merah/abu-abu
//                                        yang ramah bagi pengguna.
//        Semua galat dicatat oleh PelaporGalat. Aplikasi sungguhan
//        mengirimnya ke layanan pelaporan seperti Firebase Crashlytics
//        atau Sentry; di sini catatannya cukup ditampilkan di layar.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Proyek Flutter: salin ke lib/main.dart, lalu
//    flutter run -d chrome            (mode debug)
//    flutter run -d chrome --release  (mode rilis: bandingkan!)
// =====================================================================

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final PelaporGalat pelapor = PelaporGalat();

void main() {
  if (kIsWeb) {
    // Semua kode di dalam runZonedGuarded berada di satu "zona". Galat
    // asinkron yang tidak ditangkap di zona ini diteruskan ke fungsi
    // kedua, alih-alih hilang di konsol browser.
    runZonedGuarded(
      mulaiAplikasi,
      (Object galat, StackTrace jejak) =>
          pelapor.catat(galat, jejak, sumber: 'async (zona web)'),
    );
  } else {
    mulaiAplikasi();
  }
}

void mulaiAplikasi() {
  // Dipanggil di DALAM zona yang sama dengan runApp (penting di web).
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Galat di dalam build, layout, dan paint.
  FlutterError.onError = (FlutterErrorDetails rincian) {
    // Tetap tampilkan pesan lengkap di konsol saat pengembangan.
    FlutterError.presentError(rincian);
    pelapor.catat(rincian.exception, rincian.stack, sumber: 'widget');
  };

  // 2. Galat asinkron yang lolos (Android, iOS, desktop).
  PlatformDispatcher.instance.onError = (Object galat, StackTrace jejak) {
    pelapor.catat(galat, jejak, sumber: 'async (platform)');
    return true; // true = galat sudah ditangani
  };

  // 3. Pengganti kotak merah (debug) dan kotak abu-abu (rilis).
  ErrorWidget.builder = (FlutterErrorDetails rincian) =>
      KotakGalatRamah(rincian: rincian);

  runApp(const AplikasiUjiGalat());
}

// ========================= PELAPOR GALAT =========================

class CatatanGalat {
  const CatatanGalat({
    required this.waktu,
    required this.sumber,
    required this.pesan,
  });

  final DateTime waktu;
  final String sumber;
  final String pesan;
}

class PelaporGalat extends ChangeNotifier {
  static const int batas = 20; // simpan paling banyak 20 catatan

  final List<CatatanGalat> _catatan = [];

  List<CatatanGalat> get catatan => List.unmodifiable(_catatan);

  void catat(Object galat, StackTrace? jejak, {required String sumber}) {
    _catatan.insert(
      0,
      CatatanGalat(waktu: DateTime.now(), sumber: sumber, pesan: '$galat'),
    );
    if (_catatan.length > batas) {
      _catatan.removeLast();
    }
    // Di aplikasi sungguhan, galat + jejaknya (stack trace) dikirim ke
    // layanan pelaporan di sini. JANGAN kirim data pribadi pengguna.
    if (kDebugMode) {
      debugPrint('[pelapor] $sumber: $galat');
    }
    // catat() bisa dipanggil SAAT widget sedang dibangun. Memberi tahu
    // pendengar saat itu juga akan memicu galat baru ("markNeedsBuild()
    // called during build"), jadi pemberitahuan ditunda sebentar.
    scheduleMicrotask(notifyListeners);
  }

  void bersihkan() {
    _catatan.clear();
    notifyListeners();
  }
}

// ======================= PENGGANTI LAYAR MERAH =======================

class KotakGalatRamah extends StatelessWidget {
  const KotakGalatRamah({super.key, required this.rincian});

  final FlutterErrorDetails rincian;

  @override
  Widget build(BuildContext context) {
    // Widget ini bisa muncul DI MANA SAJA, bahkan di atas MaterialApp,
    // jadi Directionality dan Material disediakan sendiri.
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        color: Colors.orange.shade50,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.sentiment_dissatisfied, color: Colors.orange.shade900),
              const SizedBox(height: 4),
              const Text(
                'Bagian ini gagal ditampilkan. Laporan sudah dicatat.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87),
              ),
              // Rincian teknis hanya untuk pengembang (mode debug).
              if (kDebugMode)
                Text(
                  rincian.exceptionAsString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================ VIEW ============================

class AplikasiUjiGalat extends StatelessWidget {
  const AplikasiUjiGalat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uji Galat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const HalamanUjiGalat(),
    );
  }
}

class HalamanUjiGalat extends StatefulWidget {
  const HalamanUjiGalat({super.key});

  @override
  State<HalamanUjiGalat> createState() => _HalamanUjiGalatState();
}

class _HalamanUjiGalatState extends State<HalamanUjiGalat> {
  bool _tampilkanKartuRusak = false;

  // Galat yang DIDUGA (server mati, data rusak) ditangani di tempatnya,
  // dengan pesan yang ramah. Jaring pengaman hanya untuk yang tak terduga.
  Future<void> _muatDenganBenar() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      throw const FormatException('JSON dari server rusak');
    } on FormatException catch (galat, jejak) {
      pelapor.catat(galat, jejak, sumber: 'ditangani');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data gagal dibaca. Coba lagi nanti.')),
      );
    }
  }

  void _lupaMenangkap() {
    // Sengaja TIDAK di-await dan TIDAK dibungkus try-catch, seperti bug
    // sungguhan. Galatnya lolos dan ditangkap jaring pengaman.
    Future<void>.delayed(const Duration(milliseconds: 300), () {
      throw StateError('Token masuk kedaluwarsa');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uji Galat'),
        actions: [
          IconButton(
            tooltip: 'Bersihkan laporan',
            onPressed: pelapor.bersihkan,
            icon: const Icon(Icons.delete_sweep_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('1. Tampilkan kartu yang rusak'),
            subtitle: const Text('Galat saat membangun widget'),
            value: _tampilkanKartuRusak,
            onChanged: (bool nilai) =>
                setState(() => _tampilkanKartuRusak = nilai),
          ),
          if (_tampilkanKartuRusak) const KartuNilai(nilai: null),
          ListTile(
            title: const Text('2. Galat asinkron yang lupa ditangkap'),
            trailing: FilledButton(
              onPressed: _lupaMenangkap,
              child: const Text('Picu'),
            ),
          ),
          ListTile(
            title: const Text('3. Galat yang ditangani dengan benar'),
            trailing: FilledButton.tonal(
              onPressed: _muatDenganBenar,
              child: const Text('Muat'),
            ),
          ),
          const Divider(),
          Text(
            'Laporan galat (yang akan dikirim ke layanan pelaporan)',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          ListenableBuilder(
            listenable: pelapor,
            builder: (BuildContext context, Widget? _) {
              if (pelapor.catatan.isEmpty) {
                return const ListTile(title: Text('Belum ada galat.'));
              }
              return Column(
                children: [
                  for (final CatatanGalat c in pelapor.catatan)
                    ListTile(
                      dense: true,
                      leading: const Icon(Icons.bug_report_outlined),
                      title: Text(c.pesan),
                      subtitle: Text(c.sumber),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class KartuNilai extends StatelessWidget {
  const KartuNilai({super.key, required this.nilai});

  // Seharusnya selalu ada, tetapi server kadang tidak mengirimnya.
  final int? nilai;

  @override
  Widget build(BuildContext context) {
    // BUG yang disengaja: tanda ! pada nilai yang ternyata null.
    return Card(
      child: ListTile(
        title: const Text('Nilai UTS'),
        trailing: Text('${nilai!}'),
      ),
    );
  }
}

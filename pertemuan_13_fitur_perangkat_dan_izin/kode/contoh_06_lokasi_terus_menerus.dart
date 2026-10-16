// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 13: FITUR PERANGKAT & IZIN
// CONTOH 06: Mengikuti Lokasi Terus-Menerus (getPositionStream)
// Topik: Aplikasi "Jalan Pagi" mencatat jarak jalan kaki:
//        1. getPositionStream() adalah Stream: posisi baru dikirim
//           setiap kali perangkat berpindah sejauh distanceFilter (5 m);
//        2. langganannya (StreamSubscription) disimpan, lalu DIBATALKAN
//           saat tombol Berhenti diketuk dan di dispose(). Tanpa itu,
//           GPS terus menyala dan baterai cepat habis;
//        3. titik dengan akurasi buruk (lebih dari 25 m) diabaikan, agar
//           total jarak tidak "melompat";
//        4. total jarak = jumlah jarak antartitik
//           (Geolocator.distanceBetween);
//        5. galat di tengah jalan (layanan dimatikan, izin dicabut)
//           diterima lewat onError, lalu pencatatan dihentikan;
//        6. penjaga ketukan ganda: tombol Mulai nonaktif selama layanan
//           dan izin diperiksa, agar tidak terbuat dua langganan.
//        Contoh ini hanya mencatat selama aplikasi terbuka. Mencatat di
//        latar belakang membutuhkan izin "selalu" dan layanan latar
//        depan (foreground service), yang tidak dibahas di sini.
// =====================================================================
// CARA MENJALANKAN (tidak bisa di DartPad):
// 1. Proyek yang sama dengan Contoh 03 (paket geolocator + izin lokasi
//    di AndroidManifest.xml / Info.plist).
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
// 3. Jalankan di HP Android (flutter run), lalu berjalanlah beberapa
//    puluh meter. Di Chrome (flutter run -d chrome --web-port=8080),
//    ganti-ganti lokasi lewat DevTools -> Sensors.
// =====================================================================

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(const AplikasiJalanPagi());

class AplikasiJalanPagi extends StatelessWidget {
  const AplikasiJalanPagi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jalan Pagi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
      ),
      home: const HalamanJalanPagi(),
    );
  }
}

class HalamanJalanPagi extends StatefulWidget {
  const HalamanJalanPagi({super.key});

  @override
  State<HalamanJalanPagi> createState() => _HalamanJalanPagiState();
}

class _HalamanJalanPagiState extends State<HalamanJalanPagi> {
  // Dua "keran" yang harus ditutup: langganan lokasi dan pewaktu.
  StreamSubscription<Position>? _langganan;
  Timer? _pewaktu;

  final List<Position> _titik = [];
  double _totalMeter = 0;
  int _diabaikan = 0;
  DateTime? _waktuMulai;
  String? _pesan;

  /// true selama layanan dan izin diperiksa (dialog izin mungkin terbuka).
  bool _menyiapkan = false;

  bool get _sedangMencatat => _langganan != null;

  @override
  void dispose() {
    // Halaman ditutup: hentikan GPS dan pewaktu.
    _langganan?.cancel();
    _pewaktu?.cancel();
    super.dispose();
  }

  /// Ringkasan alur Contoh 03. null = siap; selain itu = pesan masalah.
  Future<String?> _siapkanLokasi() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return 'Nyalakan layanan lokasi di perangkat terlebih dahulu.';
    }
    LocationPermission izin = await Geolocator.checkPermission();
    if (izin == LocationPermission.denied ||
        izin == LocationPermission.unableToDetermine) {
      izin = await Geolocator.requestPermission();
    }
    return switch (izin) {
      LocationPermission.denied =>
        'Izin lokasi dibutuhkan untuk mencatat jarak jalan kaki.',
      LocationPermission.deniedForever =>
        'Izin lokasi diblokir. Izinkan lewat Pengaturan untuk memakai '
            'fitur ini.',
      LocationPermission.whileInUse ||
      LocationPermission.always ||
      LocationPermission.unableToDetermine => null,
    };
  }

  Future<void> _mulai() async {
    // Penjaga ketukan ganda. Tanpa ini, dua ketukan cepat bisa membuat
    // DUA langganan, dan yang pertama tidak pernah dibatalkan.
    if (_menyiapkan || _sedangMencatat) return;
    setState(() => _menyiapkan = true);
    final String? masalah = await _siapkanLokasi();
    if (!mounted) return;
    if (masalah != null) {
      setState(() {
        _menyiapkan = false;
        _pesan = masalah;
      });
      return;
    }
    setState(() {
      _menyiapkan = false;
      _titik.clear();
      _totalMeter = 0;
      _diabaikan = 0;
      _waktuMulai = DateTime.now();
      _pesan = null;
      // Mulai berlangganan. Selama langganan aktif, GPS menyala.
      _langganan = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 5, // kirim posisi baru setiap pindah >= 5 m
        ),
      ).listen(_titikBaru, onError: _galatLokasi);
    });
    // Perbarui tampilan waktu setiap detik.
    _pewaktu = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() {}),
    );
  }

  void _berhenti() {
    _langganan?.cancel();
    _pewaktu?.cancel();
    setState(() {
      _langganan = null;
      _pewaktu = null;
    });
  }

  void _titikBaru(Position p) {
    if (p.accuracy > 25) {
      setState(() => _diabaikan++); // terlalu kabur, abaikan
      return;
    }
    setState(() {
      if (_titik.isNotEmpty) {
        final Position sebelum = _titik.last;
        _totalMeter += Geolocator.distanceBetween(
          sebelum.latitude,
          sebelum.longitude,
          p.latitude,
          p.longitude,
        );
      }
      _titik.add(p);
    });
  }

  void _galatLokasi(Object galat) {
    _berhenti();
    setState(() {
      _pesan = switch (galat) {
        LocationServiceDisabledException() =>
          'Layanan lokasi dimatikan, jadi pencatatan dihentikan.',
        PermissionDeniedException() =>
          'Izin lokasi dicabut, jadi pencatatan dihentikan.',
        _ => 'Lokasi terputus, jadi pencatatan dihentikan.',
      };
    });
  }

  String get _teksWaktu {
    final DateTime? mulai = _waktuMulai;
    if (mulai == null) return '00:00';
    final Duration d = DateTime.now().difference(mulai);
    final String menit = d.inMinutes.toString().padLeft(2, '0');
    final String detik = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$menit:$detik';
  }

  String get _teksJarak {
    if (_totalMeter < 1000) return '${_totalMeter.round()} m';
    final String km = (_totalMeter / 1000).toStringAsFixed(2);
    return '${km.replaceAll('.', ',')} km';
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme teks = Theme.of(context).textTheme;
    final String? pesan = _pesan;
    // Lima titik terakhir, yang terbaru di atas.
    final List<Position> terakhir = _titik.reversed.take(5).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Jalan Pagi')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: _Angka(label: 'Jarak', nilai: _teksJarak),
              ),
              Expanded(
                child: _Angka(label: 'Waktu', nilai: _teksWaktu),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${_titik.length} titik tercatat, $_diabaikan diabaikan '
            '(akurasi lebih dari 25 m)',
            textAlign: TextAlign.center,
            style: teks.bodySmall,
          ),
          const SizedBox(height: 16),
          if (_sedangMencatat)
            FilledButton.icon(
              onPressed: _berhenti,
              icon: const Icon(Icons.stop),
              label: const Text('Berhenti'),
            )
          else
            FilledButton.icon(
              onPressed: _menyiapkan ? null : _mulai,
              icon: const Icon(Icons.directions_walk),
              label: const Text('Mulai mencatat'),
            ),
          if (pesan != null) ...[
            const SizedBox(height: 12),
            Text(
              pesan,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          const SizedBox(height: 16),
          for (final Position p in terakhir)
            ListTile(
              dense: true,
              leading: const Icon(Icons.place_outlined),
              title: Text(
                '${p.latitude.toStringAsFixed(5)}, '
                '${p.longitude.toStringAsFixed(5)}',
              ),
              trailing: Text('± ${p.accuracy.round()} m'),
            ),
        ],
      ),
    );
  }
}

class _Angka extends StatelessWidget {
  const _Angka({required this.label, required this.nilai});

  final String label;
  final String nilai;

  @override
  Widget build(BuildContext context) {
    final TextTheme teks = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(label, style: teks.labelLarge),
        Text(nilai, style: teks.displaySmall),
      ],
    );
  }
}

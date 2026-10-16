// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 13: FITUR PERANGKAT & IZIN
// CONTOH 03: Lokasi Sekarang dengan geolocator
// Topik: Aplikasi "Di Mana Saya?" mengambil koordinat perangkat dengan
//        paket geolocator, lewat TIGA pemeriksaan berurutan:
//        1. layanan lokasi: sakelar Lokasi di HP menyala?
//           (isLocationServiceEnabled);
//        2. izin: periksa dulu (checkPermission), minta hanya jika masih
//           boleh diminta (requestPermission). Kelima nilai
//           LocationPermission ditangani dengan switch;
//        3. posisi: getCurrentPosition dengan LocationSettings (akurasi
//           tinggi, batas waktu 15 detik).
//        Setiap kegagalan punya pesan dan tombol yang berbeda. Saat
//        pengguna kembali dari Pengaturan, aplikasi memeriksa ulang
//        dengan AppLifecycleListener. Jarak dan arah ke kampus dihitung
//        dengan Geolocator.distanceBetween dan bearingBetween.
// =====================================================================
// CARA MENJALANKAN (tidak bisa di DartPad, karena DartPad tidak
// menyediakan paket geolocator):
// 1. Di proyek Flutter, jalankan sekali: flutter pub add geolocator
// 2. Android: tambahkan izin ACCESS_COARSE_LOCATION dan
//    ACCESS_FINE_LOCATION ke android/app/src/main/AndroidManifest.xml.
//    iOS: tambahkan NSLocationWhenInUseUsageDescription ke
//    ios/Runner/Info.plist (modul Bagian 3).
// 3. Salin seluruh isi berkas ini ke lib/main.dart.
// 4. Jalankan: flutter run -d chrome --web-port=8080
//    (di HP Android cukup: flutter run). Di Chrome, lokasi bisa
//    dipalsukan lewat DevTools -> Sensors (modul Bagian 11.1).
// =====================================================================

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(const AplikasiDiManaSaya());

/// Koordinat CONTOH titik pusat kampus. Ganti dengan kampus Anda.
const double lintangKampus = -0.4700;
const double bujurKampus = 117.1580;

class AplikasiDiManaSaya extends StatelessWidget {
  const AplikasiDiManaSaya({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Di Mana Saya?',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      home: const HalamanLokasi(),
    );
  }
}

// ============================ KEADAAN ============================

enum MasalahLokasi {
  layananMati,
  izinDitolak,
  izinDiblokir,
  waktuHabis,
  lainnya,
}

/// Empat keadaan layar. sealed: switch atas KeadaanLokasi wajib lengkap.
sealed class KeadaanLokasi {
  const KeadaanLokasi();
}

class BelumDiminta extends KeadaanLokasi {
  const BelumDiminta();
}

class SedangMencari extends KeadaanLokasi {
  const SedangMencari();
}

class LokasiDitemukan extends KeadaanLokasi {
  const LokasiDitemukan(this.posisi);
  final Position posisi;
}

class LokasiGagal extends KeadaanLokasi {
  const LokasiGagal(this.masalah);
  final MasalahLokasi masalah;
}

// ============================ HALAMAN ============================

class HalamanLokasi extends StatefulWidget {
  const HalamanLokasi({super.key});

  @override
  State<HalamanLokasi> createState() => _HalamanLokasiState();
}

class _HalamanLokasiState extends State<HalamanLokasi> {
  KeadaanLokasi _keadaan = const BelumDiminta();
  late final AppLifecycleListener _pendengar;

  @override
  void initState() {
    super.initState();
    // Dipanggil setiap kali aplikasi kembali aktif, misalnya setelah
    // pengguna membuka Pengaturan lalu kembali ke aplikasi ini.
    _pendengar = AppLifecycleListener(onResume: _saatKembali);
  }

  @override
  void dispose() {
    _pendengar.dispose();
    super.dispose();
  }

  void _saatKembali() {
    final KeadaanLokasi k = _keadaan;
    // Hanya periksa ulang jika tadi gagal karena hal yang diubah di
    // Pengaturan. Dialog izin TIDAK akan muncul lagi untuk izin yang
    // diblokir, jadi pemeriksaan ini tidak mengganggu pengguna.
    if (k is LokasiGagal &&
        (k.masalah == MasalahLokasi.layananMati ||
            k.masalah == MasalahLokasi.izinDiblokir)) {
      _cariLokasi();
    }
  }

  Future<void> _cariLokasi() async {
    if (_keadaan is SedangMencari) return; // cegah ketukan ganda
    setState(() => _keadaan = const SedangMencari());
    final KeadaanLokasi hasil = await _ambilLokasi();
    if (!mounted) return;
    setState(() => _keadaan = hasil);
  }

  /// Layanan -> izin -> posisi. Urutannya penting.
  Future<KeadaanLokasi> _ambilLokasi() async {
    // 1. Sakelar Lokasi di perangkat. (Di web selalu true.)
    if (!await Geolocator.isLocationServiceEnabled()) {
      return const LokasiGagal(MasalahLokasi.layananMati);
    }

    // 2. Izin. checkPermission() tidak pernah menampilkan dialog;
    //    requestPermission() menampilkannya jika masih boleh.
    LocationPermission izin = await Geolocator.checkPermission();
    if (izin == LocationPermission.denied ||
        izin == LocationPermission.unableToDetermine) {
      izin = await Geolocator.requestPermission();
    }
    final MasalahLokasi? masalahIzin = switch (izin) {
      LocationPermission.denied => MasalahLokasi.izinDitolak,
      LocationPermission.deniedForever => MasalahLokasi.izinDiblokir,
      LocationPermission.whileInUse ||
      LocationPermission.always ||
      LocationPermission.unableToDetermine => null,
    };
    if (masalahIzin != null) return LokasiGagal(masalahIzin);

    // 3. Posisi. GPS bisa lama di dalam gedung, jadi diberi batas waktu.
    try {
      final Position posisi = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );
      return LokasiDitemukan(posisi);
    } on TimeoutException {
      return const LokasiGagal(MasalahLokasi.waktuHabis);
    } on LocationServiceDisabledException {
      return const LokasiGagal(MasalahLokasi.layananMati);
    } on PermissionDeniedException {
      return const LokasiGagal(MasalahLokasi.izinDitolak);
    } on PositionUpdateException {
      return const LokasiGagal(MasalahLokasi.lainnya);
    }
  }

  Future<void> _bukaPengaturan(MasalahLokasi masalah) async {
    if (masalah == MasalahLokasi.layananMati) {
      await Geolocator.openLocationSettings();
    } else {
      await Geolocator.openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    final KeadaanLokasi keadaan = _keadaan;
    return Scaffold(
      appBar: AppBar(title: const Text('Di Mana Saya?')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Aplikasi ini memakai lokasi Anda untuk menghitung jarak ke '
            'kampus. Lokasi hanya dipakai di perangkat ini.',
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: keadaan is SedangMencari ? null : _cariLokasi,
            icon: const Icon(Icons.my_location),
            label: const Text('Gunakan lokasi saya'),
          ),
          const SizedBox(height: 16),
          switch (keadaan) {
            BelumDiminta() => const SizedBox.shrink(),
            SedangMencari() => const _SedangMencari(),
            LokasiDitemukan(:final Position posisi) => _KartuPosisi(
              posisi: posisi,
            ),
            LokasiGagal(:final MasalahLokasi masalah) => _KartuMasalah(
              masalah: masalah,
              onCobaLagi: _cariLokasi,
              onBukaPengaturan: () => _bukaPengaturan(masalah),
            ),
          },
        ],
      ),
    );
  }
}

class _SedangMencari extends StatelessWidget {
  const _SedangMencari();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox.square(
          dimension: 24,
          child: CircularProgressIndicator(strokeWidth: 3),
        ),
        SizedBox(width: 12),
        Expanded(child: Text('Mencari lokasi... (paling lama 15 detik)')),
      ],
    );
  }
}

String _namaArah(double derajat) {
  const List<String> nama = [
    'utara',
    'timur laut',
    'timur',
    'tenggara',
    'selatan',
    'barat daya',
    'barat',
    'barat laut',
  ];
  final double normal = (derajat + 360) % 360; // bearingBetween: -180..180
  return nama[((normal + 22.5) ~/ 45) % 8];
}

String _teksJarak(double meter) {
  if (meter < 1000) return '${meter.round()} m';
  return '${(meter / 1000).toStringAsFixed(1).replaceAll('.', ',')} km';
}

String _duaDigit(int n) => n.toString().padLeft(2, '0');

class _KartuPosisi extends StatelessWidget {
  const _KartuPosisi({required this.posisi});

  final Position posisi;

  @override
  Widget build(BuildContext context) {
    final double jarak = Geolocator.distanceBetween(
      lintangKampus,
      bujurKampus,
      posisi.latitude,
      posisi.longitude,
    );
    // Arah DARI posisi kita KE kampus.
    final double arah = Geolocator.bearingBetween(
      posisi.latitude,
      posisi.longitude,
      lintangKampus,
      bujurKampus,
    );
    final DateTime waktu = posisi.timestamp.toLocal();
    final String jam =
        '${_duaDigit(waktu.hour)}.${_duaDigit(waktu.minute)}.'
        '${_duaDigit(waktu.second)}';

    return Card.outlined(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.place_outlined),
            title: const Text('Koordinat'),
            subtitle: Text(
              '${posisi.latitude.toStringAsFixed(6)}, '
              '${posisi.longitude.toStringAsFixed(6)}',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.gps_fixed),
            title: const Text('Akurasi'),
            // Lingkaran ketidakpastian: posisi asli ada di dalam radius ini.
            subtitle: Text('± ${posisi.accuracy.round()} m (pukul $jam)'),
          ),
          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: const Text('Jarak ke kampus'),
            subtitle: Text('${_teksJarak(jarak)}, arah ${_namaArah(arah)}'),
          ),
          if (posisi.isMocked)
            const ListTile(
              leading: Icon(Icons.warning_amber),
              title: Text('Lokasi ini berasal dari aplikasi pemalsu GPS.'),
            ),
        ],
      ),
    );
  }
}

class _KartuMasalah extends StatelessWidget {
  const _KartuMasalah({
    required this.masalah,
    required this.onCobaLagi,
    required this.onBukaPengaturan,
  });

  final MasalahLokasi masalah;
  final VoidCallback onCobaLagi;
  final VoidCallback onBukaPengaturan;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final (String pesan, bool lewatPengaturan) = switch (masalah) {
      MasalahLokasi.layananMati => (
        'Layanan lokasi di perangkat Anda mati. Nyalakan sakelar Lokasi, '
            'lalu kembali ke aplikasi ini.',
        true,
      ),
      MasalahLokasi.izinDitolak => (
        'Anda belum mengizinkan akses lokasi, jadi jarak ke kampus tidak '
            'bisa dihitung. Fitur lain tetap bisa dipakai.',
        false,
      ),
      MasalahLokasi.izinDiblokir => (
        'Izin lokasi diblokir, sehingga aplikasi tidak bisa memintanya '
            'lagi. Jika ingin memakai fitur ini, izinkan lokasi di '
            'Pengaturan.',
        true,
      ),
      MasalahLokasi.waktuHabis => (
        'Lokasi belum didapat dalam 15 detik. Coba di dekat jendela atau '
            'di luar ruangan.',
        false,
      ),
      MasalahLokasi.lainnya => ('Lokasi tidak tersedia saat ini.', false),
    };

    return Card(
      color: warna.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pesan, style: TextStyle(color: warna.onErrorContainer)),
            const SizedBox(height: 12),
            if (!lewatPengaturan)
              FilledButton.tonal(
                onPressed: onCobaLagi,
                child: const Text('Coba lagi'),
              )
            else if (kIsWeb)
              // Di browser, izin situs diatur lewat ikon di sebelah kiri
              // alamat situs. openAppSettings() tidak tersedia di web.
              Text(
                'Klik ikon di sebelah kiri alamat situs, lalu izinkan '
                'Lokasi. Setelah itu klik Gunakan lokasi saya.',
                style: TextStyle(color: warna.onErrorContainer),
              )
            else
              FilledButton.tonal(
                onPressed: onBukaPengaturan,
                child: const Text('Buka Pengaturan'),
              ),
          ],
        ),
      ),
    );
  }
}

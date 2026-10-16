// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 15: BUILD, RILIS & FINALISASI
// CONTOH 04: Halaman "Tentang Aplikasi", Kebijakan Privasi, dan Lisensi
// Topik: Aplikasi yang dibagikan ke orang lain harus jujur tentang
//        dirinya. Halaman "Tentang" di aplikasi "Cuaca Kampus"
//        (Pertemuan 10) menjawab:
//        1. versi berapa yang sedang dipakai (penting saat melapor bug);
//        2. dari mana datanya: Open-Meteo mewajibkan atribusi CC BY 4.0;
//        3. data apa yang dikumpulkan: kebijakan privasi DI DALAM
//           aplikasi (diwajibkan Google Play untuk SEMUA aplikasi);
//        4. paket sumber terbuka apa saja yang dipakai: showLicensePage()
//           menampilkan lisensi semua paket secara otomatis, dan
//           LicenseRegistry.addLicense() menambah lisensi data.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
//    Catatan: DartPad tidak menyertakan berkas daftar lisensi paket,
//    jadi daftarnya tidak lengkap (isinya bisa aneh). Di proyek Flutter,
//    daftarnya lengkap.
// B. Proyek Flutter: salin ke lib/main.dart, lalu flutter run -d chrome
// =====================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Di proyek sungguhan, nama dan versi dibaca dari pubspec.yaml dengan
// paket package_info_plus (Modul Bagian 5.4), agar tidak ada dua tempat
// yang harus diubah setiap rilis. DartPad tidak menyediakan paket itu,
// jadi di sini ditulis sebagai konstanta.
const String namaAplikasi = 'Cuaca Kampus';
const String versiAplikasi = '1.0.0';
const String nomorBuild = '1';
const String surelPengembang = 'tim.cuacakampus@example.com';

void main() {
  // Lisensi paket Dart tercatat otomatis. Lisensi DATA tidak, jadi
  // ditambahkan sendiri. Tulis di main(), sebelum halaman lisensi dibuka.
  LicenseRegistry.addLicense(() async* {
    yield const LicenseEntryWithLineBreaks(
      ['Data cuaca Open-Meteo'],
      'Data cuaca disediakan oleh Open-Meteo.com dan dilisensikan dengan '
      'Creative Commons Attribution 4.0 International (CC BY 4.0).\n\n'
      'https://open-meteo.com/en/licence',
    );
  });
  runApp(const AplikasiCuaca());
}

class AplikasiCuaca extends StatelessWidget {
  const AplikasiCuaca({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: namaAplikasi,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      home: const HalamanBeranda(),
    );
  }
}

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(namaAplikasi),
        actions: [
          IconButton(
            tooltip: 'Tentang aplikasi',
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const HalamanTentang(),
              ),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text('Halaman utama: cuaca hari ini, prakiraan 7 hari, ...'),
      ),
    );
  }
}

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  Future<void> _salin(BuildContext context, String teks) async {
    await Clipboard.setData(ClipboardData(text: teks));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Disalin: $teks')));
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    // Ikon yang sama dipakai di halaman lisensi.
    const Widget ikon = CircleAvatar(
      radius: 28,
      child: Icon(Icons.wb_sunny_outlined, size: 32),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Aplikasi')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          const Center(child: ikon),
          const SizedBox(height: 8),
          Center(child: Text(namaAplikasi, style: gayaTeks.titleLarge)),
          Center(
            child: Text(
              'Versi $versiAplikasi (build $nomorBuild)'
              '${kDebugMode ? ' · mode debug' : ''}',
            ),
          ),
          const SizedBox(height: 16),
          const ListTile(
            leading: Icon(Icons.cloud_outlined),
            title: Text('Sumber data: Open-Meteo.com'),
            subtitle: Text('Prakiraan cuaca, lisensi CC BY 4.0'),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Kebijakan privasi'),
            subtitle: const Text('Data apa yang disimpan dan dikirim'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    const HalamanKebijakanPrivasi(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.mail_outline),
            title: const Text('Hubungi pengembang'),
            subtitle: const Text(surelPengembang),
            trailing: IconButton(
              tooltip: 'Salin alamat surel',
              icon: const Icon(Icons.copy),
              onPressed: () => _salin(context, surelPengembang),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Lisensi sumber terbuka'),
            subtitle: const Text('Paket dan data yang dipakai aplikasi ini'),
            trailing: const Icon(Icons.chevron_right),
            // Halaman lisensi bawaan Flutter: daftar paket beserta teks
            // lisensinya, dikumpulkan otomatis saat aplikasi di-build.
            onTap: () => showLicensePage(
              context: context,
              applicationName: namaAplikasi,
              applicationVersion: versiAplikasi,
              applicationIcon: const Padding(
                padding: EdgeInsets.all(8),
                child: ikon,
              ),
              applicationLegalese: '© 2026 Tim Cuaca Kampus',
            ),
          ),
        ],
      ),
    );
  }
}

class HalamanKebijakanPrivasi extends StatelessWidget {
  const HalamanKebijakanPrivasi({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    // Teks singkat DI DALAM aplikasi. Versi lengkapnya juga perlu ada di
    // alamat web publik (misalnya GitHub Pages) untuk toko aplikasi.
    return Scaffold(
      appBar: AppBar(title: const Text('Kebijakan Privasi')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Data yang dikumpulkan', style: gayaTeks.titleMedium),
          const Text(
            'Tidak ada. Aplikasi ini tidak meminta akun, nama, nomor HP, '
            'maupun lokasi Anda.',
          ),
          const SizedBox(height: 12),
          Text('Data yang disimpan di perangkat', style: gayaTeks.titleMedium),
          const Text(
            'Kota yang terakhir Anda pilih, agar langsung tampil saat '
            'aplikasi dibuka lagi. Data ini terhapus jika aplikasi dihapus.',
          ),
          const SizedBox(height: 12),
          Text('Data yang dikirim', style: gayaTeks.titleMedium),
          const Text(
            'Koordinat kota kampus yang dipilih dikirim ke Open-Meteo.com '
            'untuk mengambil prakiraan cuaca. Tidak ada data lain yang '
            'dikirim.',
          ),
          const SizedBox(height: 12),
          Text('Pertanyaan', style: gayaTeks.titleMedium),
          const Text('Hubungi $surelPengembang.'),
        ],
      ),
    );
  }
}

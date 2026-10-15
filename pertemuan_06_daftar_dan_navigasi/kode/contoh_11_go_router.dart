// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 06: DAFTAR DATA & NAVIGASI
// CONTOH 11: go_router, Navigasi Berbasis Alamat
// Topik: Setiap halaman punya ALAMAT seperti situs web, misalnya
//        /fakultas/teknik. Peta rute ditulis sekali di GoRouter.
//        context.go(alamat) = pindah ke alamat itu (tumpukan disusun
//        ulang mengikuti peta rute). context.push(alamat) = menumpuk
//        halaman di atas halaman sekarang.
// =====================================================================
// CARA MENJALANKAN:
// 1. Di proyek Flutter, tambahkan paket go_router (lihat modul Bagian
//    13.2), lalu jalankan: flutter pub get
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
//    (Di https://dartpad.dev paket go_router sudah tersedia.)
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const AplikasiInfoKampus());
}

class Fakultas {
  const Fakultas(this.kode, this.nama, this.jumlahProdi, this.ikon);

  final String kode; // dipakai di alamat, misalnya /fakultas/teknik
  final String nama;
  final int jumlahProdi;
  final IconData ikon;
}

const List<Fakultas> daftarFakultas = [
  Fakultas('teknik', 'Fakultas Teknik', 8, Icons.engineering),
  Fakultas('ekonomi', 'Fakultas Ekonomi dan Bisnis', 5, Icons.account_balance),
  Fakultas('kedokteran', 'Fakultas Kedokteran', 3, Icons.local_hospital),
  Fakultas('hukum', 'Fakultas Hukum', 2, Icons.gavel),
  Fakultas('pertanian', 'Fakultas Pertanian', 6, Icons.agriculture),
];

// Mencari fakultas berdasarkan kodenya. Hasilnya null jika tidak ada.
Fakultas? cariFakultas(String kode) {
  for (final Fakultas fakultas in daftarFakultas) {
    if (fakultas.kode == kode) {
      return fakultas;
    }
  }
  return null;
}

// ---------- Peta rute: alamat -> halaman ----------
final GoRouter petaRute = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HalamanBeranda();
      },
      // Rute anak: halaman yang "berada di atas" beranda.
      routes: [
        GoRoute(
          // :kode adalah bagian alamat yang isinya berubah-ubah
          // (path parameter). Alamat lengkapnya /fakultas/teknik, dst.
          path: 'fakultas/:kode',
          builder: (BuildContext context, GoRouterState state) {
            // Tanda ! aman: rute ini hanya cocok jika :kode terisi.
            final String kode = state.pathParameters['kode']!;
            return HalamanFakultas(kode: kode);
          },
        ),
        GoRoute(
          path: 'tentang',
          builder: (BuildContext context, GoRouterState state) {
            return const HalamanTentang();
          },
        ),
      ],
    ),
  ],
  // Halaman untuk alamat yang tidak ada di peta rute.
  errorBuilder: (BuildContext context, GoRouterState state) {
    return HalamanTidakDitemukan(alamat: state.uri.toString());
  },
);

class AplikasiInfoKampus extends StatelessWidget {
  const AplikasiInfoKampus({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp.router: pengganti MaterialApp + home.
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      routerConfig: petaRute,
    );
  }
}

// Menampilkan alamat halaman yang sedang dibuka. Di browser, alamat
// ini juga tampil di bilah alamat (address bar).
class BilahAlamat extends StatelessWidget {
  const BilahAlamat({super.key});

  @override
  Widget build(BuildContext context) {
    final String alamat = GoRouterState.of(context).uri.toString();
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      color: warna.surfaceContainerHighest,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        'Alamat: $alamat',
        style: const TextStyle(fontFamily: 'monospace'),
      ),
    );
  }
}

// ---------- Halaman: / ----------
class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Info Kampus')),
      body: Column(
        children: [
          const BilahAlamat(),
          Expanded(
            child: ListView(
              children: [
                for (final Fakultas fakultas in daftarFakultas)
                  ListTile(
                    leading: Icon(fakultas.ikon),
                    title: Text(fakultas.nama),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go('/fakultas/${fakultas.kode}'),
                  ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('Tentang kampus'),
                  onTap: () => context.go('/tentang'),
                ),
                ListTile(
                  leading: const Icon(Icons.link_off),
                  title: const Text('Coba alamat yang tidak ada'),
                  subtitle: const Text('/beasiswa'),
                  onTap: () => context.go('/beasiswa'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- Halaman: /fakultas/:kode ----------
class HalamanFakultas extends StatelessWidget {
  const HalamanFakultas({super.key, required this.kode});

  final String kode;

  @override
  Widget build(BuildContext context) {
    final Fakultas? fakultas = cariFakultas(kode);

    // Alamatnya cocok dengan peta rute, tetapi kodenya tidak dikenal,
    // misalnya /fakultas/sastra.
    if (fakultas == null) {
      return HalamanTidakDitemukan(alamat: '/fakultas/$kode');
    }

    return Scaffold(
      appBar: AppBar(title: Text(fakultas.nama)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BilahAlamat(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8,
              children: [
                Icon(fakultas.ikon, size: 64),
                Text(
                  '${fakultas.jumlahProdi} program studi',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Bandingkan dua tombol di bawah, lalu tekan panah '
                  'kembali di halaman Tentang:',
                ),
                // go: tumpukan disusun ulang menjadi Beranda > Tentang.
                OutlinedButton(
                  onPressed: () => context.go('/tentang'),
                  child: const Text("context.go('/tentang')"),
                ),
                // push: Tentang ditumpuk di atas halaman fakultas ini.
                FilledButton(
                  onPressed: () => context.push('/tentang'),
                  child: const Text("context.push('/tentang')"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- Halaman: /tentang ----------
class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Kampus')),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BilahAlamat(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Kampus kita memiliki lima fakultas. Tekan panah kembali '
              'di kiri atas dan perhatikan halaman mana yang muncul.',
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- Halaman untuk alamat yang salah ----------
class HalamanTidakDitemukan extends StatelessWidget {
  const HalamanTidakDitemukan({super.key, required this.alamat});

  final String alamat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Tidak Ditemukan')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wrong_location, size: 64),
              const SizedBox(height: 12),
              Text('Alamat "$alamat" tidak ada.', textAlign: TextAlign.center),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => context.go('/'),
                child: const Text('Ke beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

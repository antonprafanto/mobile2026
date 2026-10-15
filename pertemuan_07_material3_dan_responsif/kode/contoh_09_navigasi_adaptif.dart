// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 07: MATERIAL 3 & UI RESPONSIF
// CONTOH 09: Navigasi Adaptif (NavigationBar <-> NavigationRail)
// Topik: Pola "abstraksi - ukur - cabangkan". Daftar tujuan ditulis
//        SEKALI, lalu ditampilkan sebagai NavigationBar di bawah layar
//        (jendela < 600), NavigationRail di samping (600-1199), atau
//        NavigationRail yang diperlebar (>= 1200). Tujuan yang sedang
//        dipilih tetap sama walaupun ukuran jendela berubah.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome, lalu ubah lebar
//    jendela Chrome dari sempit ke lebar.
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiPortal());
}

class AplikasiPortal extends StatelessWidget {
  const AplikasiPortal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HalamanUtama(),
    );
  }
}

// ---------- 1. ABSTRAKSI: data tujuan ditulis sekali ----------
class Tujuan {
  const Tujuan(this.label, this.ikon, this.ikonTerpilih, {this.jumlahBaru = 0});

  final String label;
  final IconData ikon;
  final IconData ikonTerpilih;
  final int jumlahBaru; // angka pada lencana (badge); 0 = tanpa lencana
}

const List<Tujuan> daftarTujuan = [
  Tujuan('Beranda', Icons.home_outlined, Icons.home),
  Tujuan('Jadwal', Icons.calendar_month_outlined, Icons.calendar_month),
  Tujuan('Tugas', Icons.assignment_outlined, Icons.assignment, jumlahBaru: 3),
  Tujuan('Profil', Icons.person_outline, Icons.person),
];

// Ikon tujuan, diberi lencana jika ada yang baru.
class IkonTujuan extends StatelessWidget {
  const IkonTujuan({super.key, required this.ikon, required this.jumlahBaru});

  final IconData ikon;
  final int jumlahBaru;

  @override
  Widget build(BuildContext context) {
    if (jumlahBaru == 0) {
      return Icon(ikon);
    }
    return Badge.count(count: jumlahBaru, child: Icon(ikon));
  }
}

// ---------- 2 & 3. UKUR lalu CABANGKAN ----------
class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  // Disimpan DI ATAS percabangan, sehingga tetap sama saat tata letak
  // berganti dari NavigationBar ke NavigationRail.
  int _terpilih = 0;

  void _pilih(int indeks) {
    setState(() {
      _terpilih = indeks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double lebar = MediaQuery.widthOf(context); // UKUR
    final Widget isi = IsiHalaman(
      tujuan: daftarTujuan[_terpilih],
      lebar: lebar,
    );

    // CABANG 1: jendela ringkas -> NavigationBar di bawah layar.
    if (lebar < 600) {
      return Scaffold(
        appBar: AppBar(title: const Text('Portal Mahasiswa')),
        body: isi,
        bottomNavigationBar: NavigationBar(
          selectedIndex: _terpilih,
          onDestinationSelected: _pilih,
          destinations: [
            for (final Tujuan tujuan in daftarTujuan)
              NavigationDestination(
                icon: IkonTujuan(
                  ikon: tujuan.ikon,
                  jumlahBaru: tujuan.jumlahBaru,
                ),
                selectedIcon: IkonTujuan(
                  ikon: tujuan.ikonTerpilih,
                  jumlahBaru: tujuan.jumlahBaru,
                ),
                label: tujuan.label,
              ),
          ],
        ),
      );
    }

    // CABANG 2 dan 3: NavigationRail di samping; diperlebar mulai 1200.
    final bool railLebar = lebar >= 1200;
    return Scaffold(
      appBar: AppBar(title: const Text('Portal Mahasiswa')),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _terpilih,
            onDestinationSelected: _pilih,
            extended: railLebar,
            // Rail yang diperlebar sudah menulis label di samping ikon,
            // jadi labelType harus none (atau null).
            labelType: railLebar
                ? NavigationRailLabelType.none
                : NavigationRailLabelType.all,
            destinations: [
              for (final Tujuan tujuan in daftarTujuan)
                NavigationRailDestination(
                  icon: IkonTujuan(
                    ikon: tujuan.ikon,
                    jumlahBaru: tujuan.jumlahBaru,
                  ),
                  selectedIcon: IkonTujuan(
                    ikon: tujuan.ikonTerpilih,
                    jumlahBaru: tujuan.jumlahBaru,
                  ),
                  label: Text(tujuan.label),
                ),
            ],
          ),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(child: isi),
        ],
      ),
    );
  }
}

class IsiHalaman extends StatelessWidget {
  const IsiHalaman({super.key, required this.tujuan, required this.lebar});

  final Tujuan tujuan;
  final double lebar;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    final String navigasi;
    if (lebar < 600) {
      navigasi = 'NavigationBar (di bawah)';
    } else if (lebar < 1200) {
      navigasi = 'NavigationRail (di samping)';
    } else {
      navigasi = 'NavigationRail diperlebar';
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(tujuan.ikonTerpilih, size: 72, color: warna.primary),
            const SizedBox(height: 16),
            Text(tujuan.label, style: gayaTeks.headlineMedium),
            const SizedBox(height: 8),
            Text(
              'Lebar jendela ${lebar.toStringAsFixed(0)}\n'
              'Navigasi: $navigasi',
              textAlign: TextAlign.center,
              style: gayaTeks.bodyLarge?.copyWith(
                color: warna.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

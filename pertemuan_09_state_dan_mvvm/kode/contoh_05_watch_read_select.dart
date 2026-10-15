// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 09: MANAJEMEN STATE & MVVM
// CONTOH 05: watch, read, select, dan Consumer
// Topik: Cara mengambil objek dari provider menentukan widget mana yang
//        dibangun ulang saat datanya berubah:
//        - watch  : dibangun ulang setiap kali objek berubah;
//        - select : dibangun ulang HANYA jika nilai yang dipilih berubah;
//        - read   : tidak pernah dibangun ulang (untuk memanggil metode);
//        - Consumer: seperti watch, tetapi hanya untuk bagian builder-nya.
//        Setiap kartu menampilkan berapa kali ia sudah dibangun. Tekan
//        "Gol" untuk Tim Biru beberapa kali, lalu bandingkan angkanya.
// =====================================================================
// CARA MENJALANKAN:
// 1. Proyek Flutter: jalankan `flutter pub add provider` sekali.
//    (DartPad sudah menyediakan paket provider.)
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => Pertandingan(),
      child: const AplikasiSkor(),
    ),
  );
}

class Pertandingan extends ChangeNotifier {
  int _skorBiru = 0;
  int _skorMerah = 0;

  int get skorBiru => _skorBiru;
  int get skorMerah => _skorMerah;
  int get totalGol => _skorBiru + _skorMerah;

  String get keterangan {
    if (_skorBiru == _skorMerah) {
      return 'Skor imbang';
    }
    return _skorBiru > _skorMerah ? 'Tim Biru unggul' : 'Tim Merah unggul';
  }

  void golBiru() {
    _skorBiru++;
    notifyListeners();
  }

  void golMerah() {
    _skorMerah++;
    notifyListeners();
  }

  void ulang() {
    _skorBiru = 0;
    _skorMerah = 0;
    notifyListeners();
  }
}

// HANYA untuk pembuktian di contoh ini: menghitung berapa kali sebuah
// widget dibangun. Jangan menaruh efek samping seperti ini di build
// pada aplikasi sungguhan.
final Map<String, int> jumlahBuild = {};

int catatBuild(String nama) {
  jumlahBuild[nama] = (jumlahBuild[nama] ?? 0) + 1;
  return jumlahBuild[nama]!;
}

class AplikasiSkor extends StatelessWidget {
  const AplikasiSkor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Papan Skor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const HalamanSkor(),
    );
  }
}

class HalamanSkor extends StatelessWidget {
  const HalamanSkor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Papan Skor Futsal')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Row(
            children: [
              Expanded(child: KartuSkorBiru()),
              SizedBox(width: 12),
              Expanded(child: KartuSkorMerah()),
            ],
          ),
          SizedBox(height: 12),
          KartuKeterangan(),
          SizedBox(height: 12),
          KartuTotalGol(),
          SizedBox(height: 12),
          PanelTombol(),
        ],
      ),
    );
  }
}

// select: hanya peduli skor Tim Biru.
class KartuSkorBiru extends StatelessWidget {
  const KartuSkorBiru({super.key});

  @override
  Widget build(BuildContext context) {
    final int skor = context.select((Pertandingan p) => p.skorBiru);
    return KartuAngka(
      judul: 'Tim Biru',
      angka: '$skor',
      cara: 'select',
      jumlahBuild: catatBuild('biru'),
    );
  }
}

// select: hanya peduli skor Tim Merah.
class KartuSkorMerah extends StatelessWidget {
  const KartuSkorMerah({super.key});

  @override
  Widget build(BuildContext context) {
    final int skor = context.select((Pertandingan p) => p.skorMerah);
    return KartuAngka(
      judul: 'Tim Merah',
      angka: '$skor',
      cara: 'select',
      jumlahBuild: catatBuild('merah'),
    );
  }
}

// watch: dibangun ulang pada SETIAP perubahan.
class KartuKeterangan extends StatelessWidget {
  const KartuKeterangan({super.key});

  @override
  Widget build(BuildContext context) {
    final Pertandingan pertandingan = context.watch<Pertandingan>();
    return KartuAngka(
      judul: 'Keterangan',
      angka: pertandingan.keterangan,
      cara: 'watch',
      jumlahBuild: catatBuild('keterangan'),
    );
  }
}

// Consumer: hanya isi builder yang dibangun ulang. Bagian `child`
// (logo) dibuat sekali dan dipakai ulang.
class KartuTotalGol extends StatelessWidget {
  const KartuTotalGol({super.key});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<Pertandingan>(
          builder: (BuildContext context, Pertandingan p, Widget? child) {
            return Row(
              children: [
                child!, // logo, tidak dibuat ulang
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Total gol: ${p.totalGol}\n'
                    'Consumer dibangun ${catatBuild('consumer')}x',
                  ),
                ),
              ],
            );
          },
          child: const LogoLiga(),
        ),
      ),
    );
  }
}

class LogoLiga extends StatelessWidget {
  const LogoLiga({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    return CircleAvatar(
      backgroundColor: warna.tertiaryContainer,
      child: Text(
        '${catatBuild('logo')}x',
        style: TextStyle(color: warna.onTertiaryContainer),
      ),
    );
  }
}

// read: tombol hanya MEMANGGIL metode, tidak perlu dibangun ulang.
class PanelTombol extends StatelessWidget {
  const PanelTombol({super.key});

  @override
  Widget build(BuildContext context) {
    final int dibangun = catatBuild('tombol');
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Panel tombol (read) dibangun ${dibangun}x'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: () => context.read<Pertandingan>().golBiru(),
                  child: const Text('Gol Tim Biru'),
                ),
                FilledButton.tonal(
                  onPressed: () => context.read<Pertandingan>().golMerah(),
                  child: const Text('Gol Tim Merah'),
                ),
                TextButton(
                  onPressed: () => context.read<Pertandingan>().ulang(),
                  child: const Text('Ulang'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class KartuAngka extends StatelessWidget {
  const KartuAngka({
    super.key,
    required this.judul,
    required this.angka,
    required this.cara,
    required this.jumlahBuild,
  });

  final String judul;
  final String angka;
  final String cara;
  final int jumlahBuild;

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(judul, style: gayaTeks.titleMedium),
            Text(angka, style: gayaTeks.headlineMedium),
            const SizedBox(height: 4),
            Text('$cara · dibangun ${jumlahBuild}x', style: gayaTeks.bodySmall),
          ],
        ),
      ),
    );
  }
}

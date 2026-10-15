// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 09: MANAJEMEN STATE & MVVM
// CONTOH 02: ChangeNotifier dan ListenableBuilder
// Topik: ChangeNotifier adalah class yang bisa "mengumumkan" bahwa
//        datanya berubah dengan memanggil notifyListeners(). Widget yang
//        mendengarkannya lewat ListenableBuilder dibangun ulang otomatis.
//        Di sini SATU objek antrean dipakai bersama oleh tiga widget,
//        dan halamannya sama sekali tidak memanggil setState.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiAntrean());
}

// ---------- 1. Objek yang menyimpan data dan mengumumkan perubahan ----------
class AntreanLayanan extends ChangeNotifier {
  // Data disimpan privat (diawali _), agar hanya bisa diubah lewat metode
  // di bawah. Dengan begitu notifyListeners() tidak mungkin terlupa.
  int _nomorTerakhir = 0; // nomor terakhir yang sudah diambil mahasiswa
  int _dipanggil = 0; // nomor yang sedang dilayani (0 = belum ada)

  // Getter: dari luar hanya bisa DIBACA.
  int get nomorTerakhir => _nomorTerakhir;
  int get dipanggil => _dipanggil;
  int get menunggu => _nomorTerakhir - _dipanggil; // nilai turunan
  bool get adaYangMenunggu => menunggu > 0;

  void ambilNomor() {
    _nomorTerakhir++;
    notifyListeners(); // "Hai pendengar, data berubah!"
  }

  void panggilBerikutnya() {
    if (!adaYangMenunggu) {
      return;
    }
    _dipanggil++;
    notifyListeners();
  }
}

// Mengubah 7 menjadi "A007".
String kodeAntrean(int nomor) => 'A${nomor.toString().padLeft(3, '0')}';

// ---------- 2. Aplikasi ----------
class AplikasiAntrean extends StatelessWidget {
  const AplikasiAntrean({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Antrean Layanan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HalamanAntrean(),
    );
  }
}

class HalamanAntrean extends StatefulWidget {
  const HalamanAntrean({super.key});

  @override
  State<HalamanAntrean> createState() => _HalamanAntreanState();
}

class _HalamanAntreanState extends State<HalamanAntrean> {
  // Objek dibuat SEKALI bersama State, lalu dibuang di dispose.
  final AntreanLayanan _antrean = AntreanLayanan();

  @override
  void dispose() {
    _antrean.dispose();
    super.dispose();
  }

  // Tidak ada setState di halaman ini. Setiap widget di bawah
  // mendengarkan _antrean sendiri-sendiri.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Antrean Layanan Akademik')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          PapanPanggilan(antrean: _antrean),
          const SizedBox(height: 16),
          PanelPetugas(antrean: _antrean),
          const SizedBox(height: 16),
          PanelMahasiswa(antrean: _antrean),
        ],
      ),
    );
  }
}

// ---------- 3. Tiga widget yang mendengarkan objek yang sama ----------

// Papan besar yang dilihat semua orang di ruang tunggu.
class PapanPanggilan extends StatelessWidget {
  const PapanPanggilan({super.key, required this.antrean});

  final AntreanLayanan antrean;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    // ListenableBuilder menjalankan builder lagi SETIAP KALI antrean
    // memanggil notifyListeners().
    return ListenableBuilder(
      listenable: antrean,
      builder: (BuildContext context, Widget? child) {
        return Card.filled(
          color: warna.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Nomor yang dipanggil',
                  style: gayaTeks.titleMedium?.copyWith(
                    color: warna.onPrimaryContainer,
                  ),
                ),
                Text(
                  antrean.dipanggil == 0 ? '-' : kodeAntrean(antrean.dipanggil),
                  style: gayaTeks.displayLarge?.copyWith(
                    color: warna.onPrimaryContainer,
                  ),
                ),
                Text(
                  '${antrean.menunggu} orang menunggu',
                  style: gayaTeks.bodyLarge?.copyWith(
                    color: warna.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Panel petugas loket: memanggil nomor berikutnya.
class PanelPetugas extends StatelessWidget {
  const PanelPetugas({super.key, required this.antrean});

  final AntreanLayanan antrean;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: antrean,
      builder: (BuildContext context, Widget? child) {
        return Card.outlined(
          child: ListTile(
            leading: const Icon(Icons.support_agent),
            title: const Text('Petugas loket'),
            subtitle: Text(
              antrean.adaYangMenunggu
                  ? 'Berikutnya: ${kodeAntrean(antrean.dipanggil + 1)}'
                  : 'Tidak ada yang menunggu',
            ),
            // Tombol nonaktif (onPressed: null) jika antrean kosong.
            trailing: FilledButton(
              onPressed: antrean.adaYangMenunggu
                  ? antrean.panggilBerikutnya
                  : null,
              child: const Text('Panggil'),
            ),
          ),
        );
      },
    );
  }
}

// Panel mahasiswa: mengambil nomor antrean.
class PanelMahasiswa extends StatelessWidget {
  const PanelMahasiswa({super.key, required this.antrean});

  final AntreanLayanan antrean;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Mahasiswa'),
            const SizedBox(height: 8),
            // Hanya teks ini yang perlu mendengarkan, jadi hanya bagian
            // ini yang dibungkus ListenableBuilder.
            ListenableBuilder(
              listenable: antrean,
              builder: (BuildContext context, Widget? child) {
                return Text(
                  antrean.nomorTerakhir == 0
                      ? 'Belum ada nomor yang diambil.'
                      : 'Nomor terakhir diambil: '
                            '${kodeAntrean(antrean.nomorTerakhir)}',
                );
              },
            ),
            const SizedBox(height: 12),
            // Tombol tidak perlu mendengarkan: ia hanya MEMANGGIL metode.
            OutlinedButton.icon(
              onPressed: antrean.ambilNomor,
              icon: const Icon(Icons.confirmation_number_outlined),
              label: const Text('Ambil nomor antrean'),
            ),
          ],
        ),
      ),
    );
  }
}

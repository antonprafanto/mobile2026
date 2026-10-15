// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 09: MANAJEMEN STATE & MVVM
// CONTOH 11: Studi Kasus "Kuis Kampus"
// Topik: Merangkai materi hari ini dengan pola MVVM:
//        - Model      : Topik, Soal, Skor.
//        - Repository : RepositoriSoal (data soal, dengan jeda memuat).
//        - ViewModel  : RiwayatSkor (dipakai seluruh aplikasi) dan
//                       KuisViewModel (hanya hidup selama satu kuis).
//        - View       : Beranda, halaman kuis, dan tampilan hasil.
//        Semua logika (menilai jawaban, menghitung skor, menyimpan skor
//        terbaik) ada di ViewModel. View hanya menampilkan dan meneruskan
//        ketukan pengguna.
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
    MultiProvider(
      providers: [
        Provider<RepositoriSoal>(
          create: (BuildContext context) => RepositoriSoalLokal(),
        ),
        ChangeNotifierProvider(create: (BuildContext context) => RiwayatSkor()),
      ],
      child: const AplikasiKuis(),
    ),
  );
}

// ============================ 1. MODEL ============================

enum Topik {
  dart('Dasar Dart', Icons.code),
  widget('Widget & Tata Letak', Icons.widgets),
  state('State & Navigasi', Icons.sync_alt);

  const Topik(this.label, this.ikon);

  final String label;
  final IconData ikon;
}

class Soal {
  const Soal({
    required this.pertanyaan,
    required this.pilihan,
    required this.indeksBenar,
    required this.pembahasan,
  });

  final String pertanyaan;
  final List<String> pilihan;
  final int indeksBenar;
  final String pembahasan;
}

class Skor {
  const Skor({required this.benar, required this.jumlahSoal});

  final int benar;
  final int jumlahSoal;
}

// ========================== 2. REPOSITORY ==========================

abstract class RepositoriSoal {
  Future<List<Soal>> ambilSoal(Topik topik);
}

// Soal disimpan di kode. Pertemuan 10 bisa menggantinya dengan soal dari
// REST API tanpa mengubah ViewModel maupun View.
class RepositoriSoalLokal implements RepositoriSoal {
  @override
  Future<List<Soal>> ambilSoal(Topik topik) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return switch (topik) {
      Topik.dart => soalDart,
      Topik.widget => soalWidget,
      Topik.state => soalState,
    };
  }
}

const List<Soal> soalDart = [
  Soal(
    pertanyaan: 'Tipe data untuk menyimpan nilai benar atau salah adalah ...',
    pilihan: ['int', 'String', 'bool', 'double'],
    indeksBenar: 2,
    pembahasan: 'bool hanya punya dua nilai: true dan false.',
  ),
  Soal(
    pertanyaan: 'Hasil dari 7 ~/ 2 adalah ...',
    pilihan: ['3.5', '3', '4', '1'],
    indeksBenar: 1,
    pembahasan: '~/ adalah pembagian bulat: 7 dibagi 2 hasilnya 3, sisa 1.',
  ),
  Soal(
    pertanyaan: "Jika nama bernilai null, print(nama ?? 'Tamu') mencetak ...",
    pilihan: ['Tamu', 'null', 'nama', 'Error'],
    indeksBenar: 0,
    pembahasan: 'Operator ?? memakai nilai cadangan jika nilai kirinya null.',
  ),
  Soal(
    pertanyaan:
        'Variabel yang diisi sekali saat program berjalan, lalu tidak bisa '
        'diubah, ditandai dengan ...',
    pilihan: ['var', 'dynamic', 'void', 'final'],
    indeksBenar: 3,
    pembahasan:
        'final hanya boleh diisi sekali. Nilainya boleh ditentukan saat '
        'program berjalan, berbeda dengan const.',
  ),
  Soal(
    pertanyaan: 'Perulangan paling ringkas untuk membaca setiap isi List ...',
    pilihan: ['switch', 'for-in', 'if-else', 'try-catch'],
    indeksBenar: 1,
    pembahasan: 'for (final x in daftar) membaca isi List satu per satu.',
  ),
];

const List<Soal> soalWidget = [
  Soal(
    pertanyaan: 'Widget untuk menyusun anak-anaknya secara mendatar ...',
    pilihan: ['Row', 'Column', 'Stack', 'Center'],
    indeksBenar: 0,
    pembahasan: 'Row menyusun mendatar, Column menyusun tegak.',
  ),
  Soal(
    pertanyaan:
        'Teks panjang di dalam Row menimbulkan garis kuning-hitam. '
        'Text sebaiknya dibungkus ...',
    pilihan: ['Center', 'Padding', 'Expanded', 'SizedBox'],
    indeksBenar: 2,
    pembahasan:
        'Expanded membatasi Text pada sisa lebar Row, sehingga teks bisa '
        'turun baris.',
  ),
  Soal(
    pertanyaan: 'Untuk menampilkan 1.000 baris data yang bisa digulir ...',
    pilihan: ['Column', 'Wrap', 'Row', 'ListView.builder'],
    indeksBenar: 3,
    pembahasan: 'ListView.builder hanya membangun baris yang terlihat.',
  ),
  Soal(
    pertanyaan: 'Teks di atas latar primaryContainer sebaiknya berwarna ...',
    pilihan: ['onPrimaryContainer', 'primary', 'Colors.black', 'surface'],
    indeksBenar: 0,
    pembahasan:
        'Pasangan "on" dijamin kontras dengan latarnya, di mode terang '
        'maupun gelap.',
  ),
  Soal(
    pertanyaan: 'Agar sebuah widget berjarak 16 di semua sisinya, gunakan ...',
    pilihan: [
      'SizedBox(width: 16)',
      'Padding dengan EdgeInsets.all(16)',
      'Spacer()',
      'Expanded(flex: 16)',
    ],
    indeksBenar: 1,
    pembahasan: 'EdgeInsets.all(16) memberi jarak yang sama di keempat sisi.',
  ),
];

const List<Soal> soalState = [
  Soal(
    pertanyaan:
        'Di StatefulWidget, tampilan digambar ulang setelah data diubah '
        'di dalam ...',
    pilihan: ['initState', 'dispose', 'setState', 'main'],
    indeksBenar: 2,
    pembahasan: 'setState memberi tahu Flutter bahwa tampilan perlu dibangun.',
  ),
  Soal(
    pertanyaan: 'ChangeNotifier mengumumkan perubahan dengan memanggil ...',
    pilihan: ['notifyListeners()', 'setState()', 'build()', 'dispose()'],
    indeksBenar: 0,
    pembahasan:
        'Semua pendengar, misalnya ListenableBuilder atau context.watch, '
        'lalu dibangun ulang.',
  ),
  Soal(
    pertanyaan: 'Di dalam onPressed, objek dari provider diambil dengan ...',
    pilihan: ['context.watch', 'context.select', 'Consumer', 'context.read'],
    indeksBenar: 3,
    pembahasan:
        'read tidak mendengarkan perubahan, sehingga cocok untuk memanggil '
        'metode dari tombol.',
  ),
  Soal(
    pertanyaan: 'Navigator.pop(context, true) dipakai untuk ...',
    pilihan: [
      'membuka halaman baru',
      'menutup halaman sambil mengirim hasil true',
      'menghapus semua halaman',
      'membangun ulang halaman',
    ],
    indeksBenar: 1,
    pembahasan: 'Halaman sebelumnya menerima true dari await Navigator.push.',
  ),
  Soal(
    pertanyaan: 'Dalam MVVM, logika menyaring daftar sebaiknya ditulis di ...',
    pilihan: ['View', 'main()', 'ViewModel', 'MaterialApp'],
    indeksBenar: 2,
    pembahasan: 'View hanya menampilkan; ViewModel menyimpan state dan logika.',
  ),
];

// ================ 3. VIEWMODEL APLIKASI: riwayat skor ================

class RiwayatSkor extends ChangeNotifier {
  final Map<Topik, Skor> _terbaik = {};
  int _jumlahKuis = 0;

  int get jumlahKuis => _jumlahKuis;
  Skor? terbaik(Topik topik) => _terbaik[topik];

  void catat(Topik topik, Skor skor) {
    _jumlahKuis++;
    final Skor? lama = _terbaik[topik];
    if (lama == null || skor.benar > lama.benar) {
      _terbaik[topik] = skor;
    }
    notifyListeners();
  }
}

// ============= 4. VIEWMODEL HALAMAN: jalannya satu kuis =============

enum StatusKuis { memuat, gagal, menjawab, selesai }

enum KeadaanPilihan { biasa, benar, salah }

class KuisViewModel extends ChangeNotifier {
  KuisViewModel({
    required this.topik,
    required this._repositori,
    required this._riwayat,
  });

  final Topik topik;
  final RepositoriSoal _repositori;
  final RiwayatSkor _riwayat;

  StatusKuis _status = StatusKuis.memuat;
  List<Soal> _soal = [];
  List<int?> _jawaban = []; // jawaban per soal; null = belum dijawab
  int _indeks = 0;
  bool _sudahDibuang = false;

  // ---------- Dibaca View ----------
  StatusKuis get status => _status;
  int get jumlahSoal => _soal.length;
  int get nomor => _indeks + 1;
  Soal get soalSekarang => _soal[_indeks];
  bool get sudahDijawab => _jawaban[_indeks] != null;
  bool get soalTerakhir => _indeks == _soal.length - 1;
  bool get jawabanBenar => _jawaban[_indeks] == soalSekarang.indeksBenar;

  int get skor {
    int benar = 0;
    for (int i = 0; i < _soal.length; i++) {
      if (_jawaban[i] == _soal[i].indeksBenar) {
        benar++;
      }
    }
    return benar;
  }

  String get pesanHasil {
    if (skor == jumlahSoal) {
      return 'Sempurna! Kamu menguasai topik ini.';
    }
    if (skor * 10 >= jumlahSoal * 6) {
      return 'Bagus! Tinggal sedikit lagi.';
    }
    return 'Baca lagi modulnya, lalu coba sekali lagi.';
  }

  Soal soalKe(int indeks) => _soal[indeks];
  bool benarDi(int indeks) => _jawaban[indeks] == _soal[indeks].indeksBenar;

  // Keadaan setiap pilihan juga disiapkan ViewModel, agar View tinggal
  // memilih warnanya.
  KeadaanPilihan keadaanPilihan(int indeksPilihan) {
    if (!sudahDijawab) {
      return KeadaanPilihan.biasa;
    }
    if (indeksPilihan == soalSekarang.indeksBenar) {
      return KeadaanPilihan.benar;
    }
    if (indeksPilihan == _jawaban[_indeks]) {
      return KeadaanPilihan.salah;
    }
    return KeadaanPilihan.biasa;
  }

  // ---------- Perintah ----------
  Future<void> muat() async {
    _status = StatusKuis.memuat;
    notifyListeners();
    try {
      _soal = await _repositori.ambilSoal(topik);
      _jawaban = List<int?>.filled(_soal.length, null);
      _indeks = 0;
      _status = StatusKuis.menjawab;
    } catch (galat) {
      debugPrint('Galat saat memuat soal: $galat');
      _status = StatusKuis.gagal;
    }
    if (_sudahDibuang) {
      return;
    }
    notifyListeners();
  }

  void pilih(int indeksPilihan) {
    // Jawaban yang sudah dipilih tidak bisa diganti.
    if (_status != StatusKuis.menjawab || sudahDijawab) {
      return;
    }
    _jawaban[_indeks] = indeksPilihan;
    notifyListeners();
  }

  void lanjut() {
    if (!sudahDijawab) {
      return;
    }
    if (soalTerakhir) {
      _status = StatusKuis.selesai;
      _riwayat.catat(topik, Skor(benar: skor, jumlahSoal: jumlahSoal));
    } else {
      _indeks++;
    }
    notifyListeners();
  }

  void ulangi() {
    _jawaban = List<int?>.filled(_soal.length, null);
    _indeks = 0;
    _status = StatusKuis.menjawab;
    notifyListeners();
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    super.dispose();
  }
}

// ============================= 5. VIEW =============================

class AplikasiKuis extends StatelessWidget {
  const AplikasiKuis({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kuis Kampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const HalamanBeranda(),
    );
  }
}

// Membatasi lebar isi agar tetap nyaman dibaca di layar lebar.
class IsiTerbatas extends StatelessWidget {
  const IsiTerbatas({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: child,
      ),
    );
  }
}

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  void _mulaiKuis(BuildContext context, Topik topik) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        // KuisViewModel hanya hidup selama halaman kuis terbuka.
        builder: (BuildContext context) => ChangeNotifierProvider(
          create: (BuildContext context) => KuisViewModel(
            topik: topik,
            repositori: context.read<RepositoriSoal>(),
            riwayat: context.read<RiwayatSkor>(),
          )..muat(),
          child: const HalamanKuis(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final RiwayatSkor riwayat = context.watch<RiwayatSkor>();
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Kuis Kampus')),
      body: IsiTerbatas(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card.filled(
              color: warna.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Uji pemahamanmu!',
                      style: gayaTeks.titleLarge?.copyWith(
                        color: warna.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${riwayat.jumlahKuis} kuis sudah diselesaikan',
                      style: gayaTeks.bodyMedium?.copyWith(
                        color: warna.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Pilih topik', style: gayaTeks.titleMedium),
            const SizedBox(height: 8),
            for (final Topik topik in Topik.values)
              KartuTopik(
                topik: topik,
                terbaik: riwayat.terbaik(topik),
                onTap: () => _mulaiKuis(context, topik),
              ),
          ],
        ),
      ),
    );
  }
}

class KartuTopik extends StatelessWidget {
  const KartuTopik({
    super.key,
    required this.topik,
    required this.terbaik,
    required this.onTap,
  });

  final Topik topik;
  final Skor? terbaik;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final Skor? skor = terbaik;

    return Card.outlined(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: warna.secondaryContainer,
          child: Icon(topik.ikon, color: warna.onSecondaryContainer),
        ),
        title: Text(topik.label),
        subtitle: Text(
          skor == null
              ? 'Belum pernah dicoba'
              : 'Skor terbaik: ${skor.benar}/${skor.jumlahSoal}',
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class HalamanKuis extends StatelessWidget {
  const HalamanKuis({super.key});

  @override
  Widget build(BuildContext context) {
    final KuisViewModel vm = context.watch<KuisViewModel>();

    final Widget isi = switch (vm.status) {
      StatusKuis.memuat => const Center(child: CircularProgressIndicator()),
      StatusKuis.gagal => Center(
        child: FilledButton.icon(
          onPressed: () => context.read<KuisViewModel>().muat(),
          icon: const Icon(Icons.refresh),
          label: const Text('Soal gagal dimuat. Coba lagi'),
        ),
      ),
      StatusKuis.menjawab => const TampilanSoal(),
      StatusKuis.selesai => const TampilanHasil(),
    };

    return Scaffold(
      appBar: AppBar(title: Text('Kuis: ${vm.topik.label}')),
      body: IsiTerbatas(child: isi),
    );
  }
}

class TampilanSoal extends StatelessWidget {
  const TampilanSoal({super.key});

  @override
  Widget build(BuildContext context) {
    final KuisViewModel vm = context.watch<KuisViewModel>();
    final Soal soal = vm.soalSekarang;
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    const String huruf = 'ABCD';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        LinearProgressIndicator(value: vm.nomor / vm.jumlahSoal),
        const SizedBox(height: 8),
        Text(
          'Soal ${vm.nomor} dari ${vm.jumlahSoal}',
          style: gayaTeks.labelLarge,
        ),
        const SizedBox(height: 8),
        Text(soal.pertanyaan, style: gayaTeks.titleLarge),
        const SizedBox(height: 16),
        for (int i = 0; i < soal.pilihan.length; i++)
          KartuPilihan(
            huruf: huruf[i],
            teks: soal.pilihan[i],
            keadaan: vm.keadaanPilihan(i),
            onTap: vm.sudahDijawab
                ? null
                : () => context.read<KuisViewModel>().pilih(i),
          ),
        if (vm.sudahDijawab) ...[
          const SizedBox(height: 8),
          KartuPembahasan(benar: vm.jawabanBenar, pembahasan: soal.pembahasan),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => context.read<KuisViewModel>().lanjut(),
            child: Text(vm.soalTerakhir ? 'Lihat hasil' : 'Soal berikutnya'),
          ),
        ],
      ],
    );
  }
}

class KartuPilihan extends StatelessWidget {
  const KartuPilihan({
    super.key,
    required this.huruf,
    required this.teks,
    required this.keadaan,
    required this.onTap,
  });

  final String huruf;
  final String teks;
  final KeadaanPilihan keadaan;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    // Warna dan tanda dipilih dari keadaan yang disiapkan ViewModel.
    Color latar = warna.surface;
    Color tulisan = warna.onSurface;
    Widget? tanda;
    switch (keadaan) {
      case KeadaanPilihan.benar:
        latar = warna.primaryContainer;
        tulisan = warna.onPrimaryContainer;
        tanda = Icon(
          Icons.check_circle,
          color: tulisan,
          semanticLabel: 'Benar',
        );
      case KeadaanPilihan.salah:
        latar = warna.errorContainer;
        tulisan = warna.onErrorContainer;
        tanda = Icon(Icons.cancel, color: tulisan, semanticLabel: 'Salah');
      case KeadaanPilihan.biasa:
        break;
    }

    return Card.outlined(
      color: latar,
      child: ListTile(
        leading: CircleAvatar(child: Text(huruf)),
        title: Text(teks, style: TextStyle(color: tulisan)),
        trailing: tanda,
        onTap: onTap,
      ),
    );
  }
}

class KartuPembahasan extends StatelessWidget {
  const KartuPembahasan({
    super.key,
    required this.benar,
    required this.pembahasan,
  });

  final bool benar;
  final String pembahasan;

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Card.filled(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              benar ? 'Tepat!' : 'Kurang tepat.',
              style: gayaTeks.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(pembahasan),
          ],
        ),
      ),
    );
  }
}

class TampilanHasil extends StatelessWidget {
  const TampilanHasil({super.key});

  @override
  Widget build(BuildContext context) {
    final KuisViewModel vm = context.watch<KuisViewModel>();
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card.filled(
          color: warna.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Skor kamu',
                  style: gayaTeks.titleMedium?.copyWith(
                    color: warna.onPrimaryContainer,
                  ),
                ),
                Text(
                  '${vm.skor}/${vm.jumlahSoal}',
                  style: gayaTeks.displayMedium?.copyWith(
                    color: warna.onPrimaryContainer,
                  ),
                ),
                Text(
                  vm.pesanHasil,
                  textAlign: TextAlign.center,
                  style: gayaTeks.bodyLarge?.copyWith(
                    color: warna.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Ringkasan jawaban', style: gayaTeks.titleMedium),
        for (int i = 0; i < vm.jumlahSoal; i++)
          ListTile(
            leading: Icon(
              vm.benarDi(i) ? Icons.check_circle : Icons.cancel,
              color: vm.benarDi(i) ? warna.primary : warna.error,
            ),
            title: Text('${i + 1}. ${vm.soalKe(i).pertanyaan}'),
            subtitle: Text(
              'Jawaban benar: '
              '${vm.soalKe(i).pilihan[vm.soalKe(i).indeksBenar]}',
            ),
          ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.home),
          label: const Text('Kembali ke beranda'),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () => context.read<KuisViewModel>().ulangi(),
          icon: const Icon(Icons.replay),
          label: const Text('Ulangi kuis'),
        ),
      ],
    );
  }
}

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 09: MANAJEMEN STATE & MVVM
// CONTOH 08: Repository dan Status Memuat di ViewModel
// Topik: ViewModel tidak membuat data sendiri, tetapi memintanya dari
//        REPOSITORY. Repository di sini "palsu": datanya ditulis di kode
//        dan diberi jeda 1,5 detik seolah-olah mengambil dari internet.
//        Percobaan ke-2, ke-4, dan seterusnya sengaja GAGAL, agar Anda
//        bisa melihat ketiga status: memuat, berhasil, dan gagal (dengan
//        tombol "Coba lagi"). Tekan tombol muat ulang di AppBar.
//        Pertemuan 10 mengganti repository palsu ini dengan repository
//        yang benar-benar memanggil REST API, tanpa mengubah View.
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
    // Repository dititipkan sekali untuk seluruh aplikasi. Provider biasa
    // (bukan ChangeNotifierProvider), karena repository tidak mengumumkan
    // perubahan apa pun.
    Provider<RepositoriPengumuman>(
      create: (BuildContext context) => RepositoriPengumumanPalsu(),
      child: const AplikasiPengumuman(),
    ),
  );
}

// =========================== MODEL ===========================

class Pengumuman {
  const Pengumuman({
    required this.judul,
    required this.isi,
    required this.tanggal,
  });

  final String judul;
  final String isi;
  final String tanggal;
}

// ========================= REPOSITORY =========================

// Kontrak: APA yang bisa diminta, tanpa peduli DARI MANA datanya.
abstract class RepositoriPengumuman {
  Future<List<Pengumuman>> ambilSemua();
}

// Implementasi palsu untuk latihan.
class RepositoriPengumumanPalsu implements RepositoriPengumuman {
  int _percobaan = 0;

  @override
  Future<List<Pengumuman>> ambilSemua() async {
    _percobaan++;
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    if (_percobaan.isEven) {
      throw Exception('Server tidak dapat dihubungi');
    }
    return const [
      Pengumuman(
        judul: 'Jadwal UTS diumumkan',
        isi: 'Jadwal ujian tengah semester dapat dilihat di portal akademik.',
        tanggal: '13 Okt 2026',
      ),
      Pengumuman(
        judul: 'Lab Komputer 2 ditutup sementara',
        isi: 'Perawatan jaringan pada hari Jumat, pukul 08.00-12.00.',
        tanggal: '12 Okt 2026',
      ),
      Pengumuman(
        judul: 'Pendaftaran asisten praktikum',
        isi: 'Dibuka untuk mahasiswa semester 5 ke atas sampai 20 Oktober.',
        tanggal: '10 Okt 2026',
      ),
      Pengumuman(
        judul: 'Seminar karier industri aplikasi',
        isi: 'Aula utama, Sabtu pukul 09.00. Gratis untuk mahasiswa.',
        tanggal: '8 Okt 2026',
      ),
    ];
  }
}

// ========================= VIEWMODEL =========================

enum StatusMuat { memuat, berhasil, gagal }

class PengumumanViewModel extends ChangeNotifier {
  // Repository diterima lewat constructor (bukan dibuat sendiri), sehingga
  // mudah ditukar dengan repository lain.
  PengumumanViewModel({required this._repositori});

  final RepositoriPengumuman _repositori;

  StatusMuat _status = StatusMuat.memuat;
  List<Pengumuman> _daftar = [];
  String _pesanGalat = '';
  bool _sudahDibuang = false;

  StatusMuat get status => _status;
  List<Pengumuman> get daftar => _daftar;
  String get pesanGalat => _pesanGalat;

  Future<void> muat() async {
    _status = StatusMuat.memuat;
    notifyListeners();

    try {
      _daftar = await _repositori.ambilSemua();
      _status = StatusMuat.berhasil;
    } catch (galat) {
      // Pesan teknis untuk pengembang (konsol), pesan ramah untuk pengguna.
      debugPrint('Galat saat memuat: $galat');
      _pesanGalat = 'Pengumuman gagal dimuat. Periksa koneksi, lalu coba lagi.';
      _status = StatusMuat.gagal;
    }

    // Selama menunggu, halaman bisa saja sudah ditutup dan ViewModel ini
    // sudah dibuang. Memanggil notifyListeners() setelah dibuang = error.
    if (_sudahDibuang) {
      return;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    super.dispose();
  }
}

// ============================ VIEW ============================

class AplikasiPengumuman extends StatelessWidget {
  const AplikasiPengumuman({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pengumuman Prodi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      // ViewModel halaman dibuat oleh ChangeNotifierProvider: dibuat sekali
      // saat halaman pertama kali butuh, dibuang otomatis saat tidak dipakai.
      home: ChangeNotifierProvider(
        create: (BuildContext context) => PengumumanViewModel(
          repositori: context.read<RepositoriPengumuman>(),
        )..muat(),
        child: const HalamanPengumuman(),
      ),
    );
  }
}

class HalamanPengumuman extends StatelessWidget {
  const HalamanPengumuman({super.key});

  @override
  Widget build(BuildContext context) {
    final PengumumanViewModel vm = context.watch<PengumumanViewModel>();

    // switch ekspresi: satu tampilan untuk setiap status.
    final Widget isi = switch (vm.status) {
      StatusMuat.memuat => const TampilanMemuat(),
      StatusMuat.gagal => TampilanGagal(
        pesan: vm.pesanGalat,
        onCobaLagi: () => context.read<PengumumanViewModel>().muat(),
      ),
      StatusMuat.berhasil => DaftarPengumuman(daftar: vm.daftar),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengumuman Prodi'),
        actions: [
          IconButton(
            // Nonaktif selama memuat, agar tidak dimuat dua kali.
            onPressed: vm.status == StatusMuat.memuat
                ? null
                : () => context.read<PengumumanViewModel>().muat(),
            tooltip: 'Muat ulang',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: isi,
    );
  }
}

class TampilanMemuat extends StatelessWidget {
  const TampilanMemuat({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Memuat pengumuman...'),
        ],
      ),
    );
  }
}

class TampilanGagal extends StatelessWidget {
  const TampilanGagal({
    super.key,
    required this.pesan,
    required this.onCobaLagi,
  });

  final String pesan;
  final VoidCallback onCobaLagi;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off, size: 64, color: warna.error),
            const SizedBox(height: 12),
            Text(pesan, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onCobaLagi,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}

class DaftarPengumuman extends StatelessWidget {
  const DaftarPengumuman({super.key, required this.daftar});

  final List<Pengumuman> daftar;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: daftar.length,
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 1),
      itemBuilder: (BuildContext context, int index) {
        final Pengumuman pengumuman = daftar[index];
        return ListTile(
          leading: const Icon(Icons.campaign_outlined),
          title: Text(pengumuman.judul),
          subtitle: Text('${pengumuman.tanggal}\n${pengumuman.isi}'),
          isThreeLine: true,
        );
      },
    );
  }
}

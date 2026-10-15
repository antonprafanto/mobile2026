// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 09: MANAJEMEN STATE & MVVM
// CONTOH 09: Cakupan dan Umur Provider
// Topik: Di mana provider dipasang menentukan siapa yang bisa memakainya
//        dan berapa lama objeknya hidup:
//        - Provider DI ATAS MaterialApp (Simpanan) hidup selama aplikasi
//          berjalan dan dipakai bersama oleh semua halaman.
//        - Provider DI DALAM sebuah rute halaman (PendaftaranViewModel)
//          dibuat saat halaman dibuka dan dibuang (dispose) saat halaman
//          ditutup. Membuka halaman lagi = objek BARU, jumlah peserta
//          kembali ke 1.
//        Perhatikan tulisan "ViewModel ke-..." dan pesan di konsol.
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
      create: (BuildContext context) => Simpanan(),
      child: const AplikasiWorkshop(),
    ),
  );
}

// =========================== MODEL ===========================

class Workshop {
  const Workshop({
    required this.id,
    required this.judul,
    required this.pemateri,
    required this.biaya,
  });

  final int id;
  final String judul;
  final String pemateri;
  final int biaya; // per peserta, dalam rupiah
}

const List<Workshop> daftarWorkshop = [
  Workshop(
    id: 1,
    judul: 'Desain UI dengan Figma',
    pemateri: 'Rina Kusuma',
    biaya: 50000,
  ),
  Workshop(
    id: 2,
    judul: 'Git untuk Pemula',
    pemateri: 'Bayu Pratama',
    biaya: 25000,
  ),
  Workshop(
    id: 3,
    judul: 'Membangun REST API',
    pemateri: 'Sari Wulandari',
    biaya: 75000,
  ),
];

String formatRupiah(int angka) {
  final String digit = angka.toString();
  String hasil = '';
  for (int i = 0; i < digit.length; i++) {
    final int sisaDiKanan = digit.length - i;
    if (i > 0 && sisaDiKanan % 3 == 0) {
      hasil += '.';
    }
    hasil += digit[i];
  }
  return 'Rp$hasil';
}

// ============ STATE APLIKASI: hidup selama aplikasi berjalan ============

class Simpanan extends ChangeNotifier {
  final Set<int> _id = {};

  int get jumlah => _id.length;
  bool disimpan(Workshop workshop) => _id.contains(workshop.id);

  void ubah(Workshop workshop) {
    if (_id.contains(workshop.id)) {
      _id.remove(workshop.id);
    } else {
      _id.add(workshop.id);
    }
    notifyListeners();
  }
}

// ======= VIEWMODEL HALAMAN: hidup selama halaman detail terbuka =======

class PendaftaranViewModel extends ChangeNotifier {
  PendaftaranViewModel(this.workshop) : nomor = ++_jumlahDibuat {
    debugPrint('ViewModel ke-$nomor DIBUAT untuk "${workshop.judul}"');
  }

  static int _jumlahDibuat = 0;

  final Workshop workshop;
  final int nomor; // urutan pembuatan, hanya untuk pembuktian
  int _peserta = 1;

  int get peserta => _peserta;
  int get totalBiaya => _peserta * workshop.biaya;

  void tambahPeserta() {
    if (_peserta < 10) {
      _peserta++;
      notifyListeners();
    }
  }

  void kurangiPeserta() {
    if (_peserta > 1) {
      _peserta--;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    debugPrint('ViewModel ke-$nomor DIBUANG');
    super.dispose();
  }
}

// ============================ VIEW ============================

class AplikasiWorkshop extends StatelessWidget {
  const AplikasiWorkshop({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Workshop Kampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      home: const HalamanDaftarWorkshop(),
    );
  }
}

class HalamanDaftarWorkshop extends StatelessWidget {
  const HalamanDaftarWorkshop({super.key});

  void _bukaDetail(BuildContext context, Workshop workshop) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        // Provider dipasang DI DALAM rute: hanya halaman ini yang bisa
        // memakainya, dan objeknya dibuang saat halaman ditutup.
        builder: (BuildContext context) => ChangeNotifierProvider(
          create: (BuildContext context) => PendaftaranViewModel(workshop),
          child: const HalamanPendaftaran(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Simpanan simpanan = context.watch<Simpanan>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workshop Kampus'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Badge.count(
              count: simpanan.jumlah,
              isLabelVisible: simpanan.jumlah > 0,
              child: const Icon(Icons.bookmark),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: daftarWorkshop.length,
        itemBuilder: (BuildContext context, int index) {
          final Workshop workshop = daftarWorkshop[index];
          final bool disimpan = simpanan.disimpan(workshop);
          return ListTile(
            leading: const Icon(Icons.event_note),
            title: Text(workshop.judul),
            subtitle: Text(
              '${workshop.pemateri} · ${formatRupiah(workshop.biaya)}',
            ),
            trailing: IconButton(
              onPressed: () => context.read<Simpanan>().ubah(workshop),
              tooltip: disimpan ? 'Hapus dari simpanan' : 'Simpan',
              icon: Icon(disimpan ? Icons.bookmark : Icons.bookmark_border),
            ),
            onTap: () => _bukaDetail(context, workshop),
          );
        },
      ),
    );
  }
}

class HalamanPendaftaran extends StatelessWidget {
  const HalamanPendaftaran({super.key});

  @override
  Widget build(BuildContext context) {
    // Dua provider dengan cakupan berbeda, dipakai di halaman yang sama.
    final PendaftaranViewModel vm = context.watch<PendaftaranViewModel>();
    final bool disimpan = context.watch<Simpanan>().disimpan(vm.workshop);
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Pendaftaran')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(vm.workshop.judul, style: gayaTeks.headlineSmall),
          Text('Pemateri: ${vm.workshop.pemateri}'),
          const SizedBox(height: 8),
          Chip(
            avatar: const Icon(Icons.memory),
            label: Text('ViewModel ke-${vm.nomor}'),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              IconButton.filledTonal(
                onPressed: vm.peserta > 1
                    ? () =>
                          context.read<PendaftaranViewModel>().kurangiPeserta()
                    : null,
                tooltip: 'Kurangi peserta',
                icon: const Icon(Icons.remove),
              ),
              Expanded(
                child: Text(
                  '${vm.peserta} peserta',
                  textAlign: TextAlign.center,
                  style: gayaTeks.titleLarge,
                ),
              ),
              IconButton.filledTonal(
                onPressed: vm.peserta < 10
                    ? () => context.read<PendaftaranViewModel>().tambahPeserta()
                    : null,
                tooltip: 'Tambah peserta',
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Total: ${formatRupiah(vm.totalBiaya)}',
            textAlign: TextAlign.center,
            style: gayaTeks.titleMedium,
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () => context.read<Simpanan>().ubah(vm.workshop),
            icon: Icon(disimpan ? Icons.bookmark : Icons.bookmark_border),
            label: Text(disimpan ? 'Tersimpan' : 'Simpan workshop ini'),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 13: FITUR PERANGKAT & IZIN
// CONTOH 07: Fitur Perangkat di Balik Kontrak + Data Palsu
// Topik: Arsitektur Pertemuan 12 diterapkan pada GPS dan kamera:
//        1. DOMAIN tidak mengenal geolocator atau image_picker. Ia hanya
//           mengenal KONTRAK (LayananLokasi, PemilihFoto,
//           PengaturanPerangkat), entitas Posisi dan FotoBukti, serta
//           Kegagalan baru: LayananLokasiMati, IzinDitolak,
//           IzinDiblokir, PerangkatTidakMendukung, Dibatalkan, dan
//           WaktuHabis;
//        2. implementasi PALSU yang skenarionya bisa diatur dipakai
//           untuk mengembangkan tampilan dan untuk menguji, tanpa HP dan
//           tanpa dialog izin. Implementasi ASLI ada di Contoh 08;
//        3. ViewModel memakai Perintah (Pertemuan 12), dan satu fungsi
//           tanggapanUntuk() mengubah setiap Kegagalan menjadi pesan
//           beserta tombol yang tepat;
//        4. jalankanUji() memeriksa semua skenario dalam sekejap.
//           Hasilnya tampil di konsol. Coba juga lewat chip di layar.
// =====================================================================
// CARA MENJALANKAN: buka https://dartpad.dev, tempel seluruh isi berkas
// ini, klik Run. (Di proyek sendiri: flutter pub add provider.)
// =====================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await jalankanUji();
  runApp(
    MultiProvider(
      providers: [
        // Akar komposisi. Di sini jenis yang dititipkan sengaja kelas
        // PALSU, karena chip skenario di layar perlu mengubah skenarionya.
        // Di aplikasi sungguhan (Contoh 08) yang dititipkan adalah KONTRAK.
        Provider<LayananLokasiPalsu>(create: (_) => LayananLokasiPalsu()),
        Provider<PemilihFotoPalsu>(create: (_) => PemilihFotoPalsu()),
        Provider<PengaturanPerangkatPalsu>(
          create: (_) => PengaturanPerangkatPalsu(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => CatatanLapanganViewModel(
            layananLokasi: context.read<LayananLokasiPalsu>(),
            pemilihFoto: context.read<PemilihFotoPalsu>(),
            pengaturan: context.read<PengaturanPerangkatPalsu>(),
          ),
        ),
      ],
      child: const AplikasiCatatanLapangan(),
    ),
  );
}

class AplikasiCatatanLapangan extends StatelessWidget {
  const AplikasiCatatanLapangan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catatan Lapangan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: const HalamanCatatanLapangan(),
    );
  }
}

// ============================== DOMAIN ==============================

sealed class Hasil<T> {
  const Hasil();
}

final class Berhasil<T> extends Hasil<T> {
  const Berhasil(this.nilai);
  final T nilai;
}

final class Gagal<T> extends Hasil<T> {
  const Gagal(this.kegagalan);
  final Kegagalan kegagalan;
}

enum Fitur {
  lokasi('lokasi'),
  kamera('kamera'),
  galeri('galeri');

  const Fitur(this.nama);
  final String nama;
}

/// Kegagalan milik aplikasi. Tidak ada satu pun yang menyebut nama paket.
sealed class Kegagalan {
  const Kegagalan();
}

final class LayananLokasiMati extends Kegagalan {
  const LayananLokasiMati();
}

final class IzinDitolak extends Kegagalan {
  const IzinDitolak(this.fitur);
  final Fitur fitur;
}

final class IzinDiblokir extends Kegagalan {
  const IzinDiblokir(this.fitur);
  final Fitur fitur;
}

final class PerangkatTidakMendukung extends Kegagalan {
  const PerangkatTidakMendukung(this.fitur);
  final Fitur fitur;
}

/// Pengguna sengaja menutup pemilih foto. Bukan kesalahan siapa pun.
final class Dibatalkan extends Kegagalan {
  const Dibatalkan();
}

final class WaktuHabis extends Kegagalan {
  const WaktuHabis();
}

class Posisi {
  const Posisi({
    required this.lintang,
    required this.bujur,
    required this.akurasiMeter,
    required this.waktu,
    this.palsu = false,
  });

  final double lintang;
  final double bujur;
  final double akurasiMeter;
  final DateTime waktu;

  /// true jika berasal dari aplikasi pemalsu GPS.
  final bool palsu;
}

class FotoBukti {
  const FotoBukti({required this.nama, required this.bita});

  final String nama;
  final Uint8List bita;
}

// ----- KONTRAK (di proyek: lib/domain/services/) -----

abstract interface class LayananLokasi {
  /// Memeriksa layanan dan izin, lalu mengambil posisi sekarang.
  Future<Hasil<Posisi>> posisiSekarang();
}

abstract interface class PemilihFoto {
  bool get kameraTersedia;

  Future<Hasil<FotoBukti>> ambil({required bool dariKamera});
}

abstract interface class PengaturanPerangkat {
  Future<void> bukaPengaturanAplikasi();

  Future<void> bukaPengaturanLokasi();
}

// =========================== DATA PALSU ===========================
// Di proyek: folder testing/ (dipakai uji) dan lib/data/ (dipakai
// main_pengembangan.dart).

enum SkenarioLokasi {
  berhasil('Berhasil'),
  layananMati('Layanan mati'),
  izinDitolak('Izin ditolak'),
  izinDiblokir('Izin diblokir'),
  waktuHabis('Waktu habis');

  const SkenarioLokasi(this.label);
  final String label;
}

class LayananLokasiPalsu implements LayananLokasi {
  SkenarioLokasi skenario = SkenarioLokasi.berhasil;
  int dipanggil = 0;

  @override
  Future<Hasil<Posisi>> posisiSekarang() async {
    dipanggil++;
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return switch (skenario) {
      SkenarioLokasi.berhasil => Berhasil(
        Posisi(
          lintang: -0.470180,
          bujur: 117.158050,
          akurasiMeter: 8,
          waktu: DateTime(2026, 10, 16, 9, 30),
        ),
      ),
      SkenarioLokasi.layananMati => const Gagal(LayananLokasiMati()),
      SkenarioLokasi.izinDitolak => const Gagal(IzinDitolak(Fitur.lokasi)),
      SkenarioLokasi.izinDiblokir => const Gagal(IzinDiblokir(Fitur.lokasi)),
      SkenarioLokasi.waktuHabis => const Gagal(WaktuHabis()),
    };
  }
}

enum SkenarioFoto {
  berhasil('Berhasil'),
  dibatalkan('Dibatalkan'),
  kameraDiblokir('Kamera diblokir'),
  tanpaKamera('Tanpa kamera');

  const SkenarioFoto(this.label);
  final String label;
}

class PemilihFotoPalsu implements PemilihFoto {
  SkenarioFoto skenario = SkenarioFoto.berhasil;
  int dipanggil = 0;

  @override
  bool get kameraTersedia => skenario != SkenarioFoto.tanpaKamera;

  @override
  Future<Hasil<FotoBukti>> ambil({required bool dariKamera}) async {
    dipanggil++;
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return switch (skenario) {
      SkenarioFoto.dibatalkan => const Gagal(Dibatalkan()),
      SkenarioFoto.kameraDiblokir when dariKamera => const Gagal(
        IzinDiblokir(Fitur.kamera),
      ),
      SkenarioFoto.tanpaKamera when dariKamera => const Gagal(
        PerangkatTidakMendukung(Fitur.kamera),
      ),
      _ => Berhasil(
        FotoBukti(
          nama: dariKamera ? 'IMG_20261016_093012.jpg' : 'tiang_lampu.jpg',
          bita: Uint8List(318 * 1024), // anggap saja foto 318 KB
        ),
      ),
    };
  }
}

class PengaturanPerangkatPalsu implements PengaturanPerangkat {
  final List<String> dibuka = [];

  @override
  Future<void> bukaPengaturanAplikasi() async => dibuka.add('aplikasi');

  @override
  Future<void> bukaPengaturanLokasi() async => dibuka.add('lokasi');
}

// ========== UI: PERINTAH (sama dengan Pertemuan 12, Contoh 07) ==========

abstract class Perintah<T> extends ChangeNotifier {
  bool _sedangBerjalan = false;
  Hasil<T>? _hasil;
  bool _sudahDibuang = false;

  bool get sedangBerjalan => _sedangBerjalan;
  Hasil<T>? get hasil => _hasil;

  Future<void> _jalankan(Future<Hasil<T>> Function() aksi) async {
    if (_sedangBerjalan) return; // penjaga ketukan ganda
    _sedangBerjalan = true;
    _hasil = null;
    _kabari();
    try {
      _hasil = await aksi();
    } finally {
      _sedangBerjalan = false;
      _kabari();
    }
  }

  void _kabari() {
    if (!_sudahDibuang) notifyListeners();
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    super.dispose();
  }
}

class Perintah0<T> extends Perintah<T> {
  Perintah0(this._aksi);
  final Future<Hasil<T>> Function() _aksi;
  Future<void> jalankan() => _jalankan(_aksi);
}

class Perintah1<T, A> extends Perintah<T> {
  Perintah1(this._aksi);
  final Future<Hasil<T>> Function(A) _aksi;
  Future<void> jalankan(A argumen) => _jalankan(() => _aksi(argumen));
}

// ====================== UI: PESAN UNTUK PENGGUNA ======================

enum AksiPerbaikan { tidakAda, cobaLagi, bukaPengaturan, nyalakanLokasi }

class Tanggapan {
  const Tanggapan(this.pesan, this.aksi);
  final String pesan;
  final AksiPerbaikan aksi;
}

/// SATU-SATUNYA tempat yang mengubah Kegagalan menjadi kalimat.
/// null berarti tidak perlu pesan apa pun.
Tanggapan? tanggapanUntuk(Kegagalan kegagalan) {
  return switch (kegagalan) {
    Dibatalkan() => null,
    LayananLokasiMati() => const Tanggapan(
      'Layanan lokasi mati. Nyalakan, lalu coba lagi.',
      AksiPerbaikan.nyalakanLokasi,
    ),
    IzinDitolak(:final Fitur fitur) => Tanggapan(
      'Izin ${fitur.nama} belum diberikan, jadi fitur ini belum bisa '
      'dipakai.',
      AksiPerbaikan.cobaLagi,
    ),
    IzinDiblokir(:final Fitur fitur) => Tanggapan(
      'Izin ${fitur.nama} diblokir. Jika ingin memakai fitur ini, '
      'izinkan di Pengaturan.',
      AksiPerbaikan.bukaPengaturan,
    ),
    PerangkatTidakMendukung(:final Fitur fitur) => Tanggapan(
      'Perangkat ini tidak memiliki ${fitur.nama}.',
      AksiPerbaikan.tidakAda,
    ),
    WaktuHabis() => const Tanggapan(
      'Lokasi belum didapat. Coba di dekat jendela atau di luar ruangan.',
      AksiPerbaikan.cobaLagi,
    ),
  };
}

// =========================== UI: VIEWMODEL ===========================

class CatatanLapanganViewModel extends ChangeNotifier {
  CatatanLapanganViewModel({
    required this._layananLokasi,
    required this._pemilihFoto,
    required this._pengaturan,
  }) {
    tandaiLokasi = Perintah0<Posisi>(_ambilPosisi);
    ambilFoto = Perintah1<FotoBukti, bool>(_ambilFoto);
  }

  final LayananLokasi _layananLokasi;
  final PemilihFoto _pemilihFoto;
  final PengaturanPerangkat _pengaturan;

  late final Perintah0<Posisi> tandaiLokasi;
  late final Perintah1<FotoBukti, bool> ambilFoto;

  Posisi? _posisi;
  FotoBukti? _fotoBukti;

  Posisi? get posisi => _posisi;
  FotoBukti? get foto => _fotoBukti;
  bool get kameraTersedia => _pemilihFoto.kameraTersedia;

  Future<Hasil<Posisi>> _ambilPosisi() async {
    final Hasil<Posisi> hasil = await _layananLokasi.posisiSekarang();
    if (hasil case Berhasil(:final Posisi nilai)) {
      _posisi = nilai;
      notifyListeners();
    }
    return hasil;
  }

  Future<Hasil<FotoBukti>> _ambilFoto(bool dariKamera) async {
    final Hasil<FotoBukti> hasil = await _pemilihFoto.ambil(
      dariKamera: dariKamera,
    );
    // Jika dibatalkan atau gagal, foto lama tetap dipakai.
    if (hasil case Berhasil(:final FotoBukti nilai)) {
      _fotoBukti = nilai;
      notifyListeners();
    }
    return hasil;
  }

  Future<void> perbaiki(AksiPerbaikan aksi, VoidCallback cobaLagi) async {
    switch (aksi) {
      case AksiPerbaikan.cobaLagi:
        cobaLagi();
      case AksiPerbaikan.bukaPengaturan:
        await _pengaturan.bukaPengaturanAplikasi();
      case AksiPerbaikan.nyalakanLokasi:
        await _pengaturan.bukaPengaturanLokasi();
      case AksiPerbaikan.tidakAda:
        break;
    }
  }

  @override
  void dispose() {
    tandaiLokasi.dispose();
    ambilFoto.dispose();
    super.dispose();
  }
}

// ================================ VIEW ================================

class HalamanCatatanLapangan extends StatelessWidget {
  const HalamanCatatanLapangan({super.key});

  @override
  Widget build(BuildContext context) {
    final CatatanLapanganViewModel vm = context
        .watch<CatatanLapanganViewModel>();
    // watch, bukan read: membaca Provider di dalam build harus lewat watch.
    final LayananLokasiPalsu lokasiPalsu = context.watch<LayananLokasiPalsu>();
    final PemilihFotoPalsu fotoPalsu = context.watch<PemilihFotoPalsu>();
    final TextTheme teks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Catatan Lapangan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Skenario lokasi (data palsu)', style: teks.labelLarge),
          _PilihanSkenario<SkenarioLokasi>(
            nilai: SkenarioLokasi.values,
            terpilih: lokasiPalsu.skenario,
            label: (SkenarioLokasi s) => s.label,
            onPilih: (SkenarioLokasi s) => lokasiPalsu.skenario = s,
          ),
          Text('Skenario foto (data palsu)', style: teks.labelLarge),
          _PilihanSkenario<SkenarioFoto>(
            nilai: SkenarioFoto.values,
            terpilih: fotoPalsu.skenario,
            label: (SkenarioFoto s) => s.label,
            onPilih: (SkenarioFoto s) => fotoPalsu.skenario = s,
          ),
          const Divider(height: 32),
          ListenableBuilder(
            listenable: vm.ambilFoto,
            builder: (BuildContext context, _) => _BagianFoto(vm: vm),
          ),
          const SizedBox(height: 16),
          ListenableBuilder(
            listenable: vm.tandaiLokasi,
            builder: (BuildContext context, _) => _BagianLokasi(vm: vm),
          ),
        ],
      ),
    );
  }
}

class _PilihanSkenario<S> extends StatefulWidget {
  const _PilihanSkenario({
    required this.nilai,
    required this.terpilih,
    required this.label,
    required this.onPilih,
  });

  final List<S> nilai;
  final S terpilih;
  final String Function(S) label;
  final ValueChanged<S> onPilih;

  @override
  State<_PilihanSkenario<S>> createState() => _PilihanSkenarioState<S>();
}

class _PilihanSkenarioState<S> extends State<_PilihanSkenario<S>> {
  late S _terpilih = widget.terpilih;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: [
        for (final S s in widget.nilai)
          ChoiceChip(
            label: Text(widget.label(s)),
            selected: s == _terpilih,
            onSelected: (_) {
              setState(() => _terpilih = s);
              widget.onPilih(s);
            },
          ),
      ],
    );
  }
}

class _BagianFoto extends StatelessWidget {
  const _BagianFoto({required this.vm});

  final CatatanLapanganViewModel vm;

  @override
  Widget build(BuildContext context) {
    final FotoBukti? foto = vm.foto;
    final Perintah1<FotoBukti, bool> perintah = vm.ambilFoto;
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Foto', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              foto == null
                  ? 'Belum ada foto.'
                  : '${foto.nama} · ${(foto.bita.length / 1024).round()} KB',
            ),
            if (perintah.sedangBerjalan) const LinearProgressIndicator(),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                if (vm.kameraTersedia)
                  FilledButton.tonal(
                    onPressed: perintah.sedangBerjalan
                        ? null
                        : () => perintah.jalankan(true),
                    child: const Text('Kamera'),
                  ),
                FilledButton.tonal(
                  onPressed: perintah.sedangBerjalan
                      ? null
                      : () => perintah.jalankan(false),
                  child: const Text('Galeri'),
                ),
              ],
            ),
            _PesanKegagalan(
              hasil: perintah.hasil,
              vm: vm,
              cobaLagi: () => perintah.jalankan(true),
            ),
          ],
        ),
      ),
    );
  }
}

class _BagianLokasi extends StatelessWidget {
  const _BagianLokasi({required this.vm});

  final CatatanLapanganViewModel vm;

  @override
  Widget build(BuildContext context) {
    final Posisi? posisi = vm.posisi;
    final Perintah0<Posisi> perintah = vm.tandaiLokasi;
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lokasi', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              posisi == null
                  ? 'Belum ditandai.'
                  : '${posisi.lintang.toStringAsFixed(6)}, '
                        '${posisi.bujur.toStringAsFixed(6)} '
                        '(± ${posisi.akurasiMeter.round()} m)',
            ),
            if (perintah.sedangBerjalan) const LinearProgressIndicator(),
            const SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: perintah.sedangBerjalan ? null : perintah.jalankan,
              child: const Text('Tandai lokasi'),
            ),
            _PesanKegagalan(
              hasil: perintah.hasil,
              vm: vm,
              cobaLagi: perintah.jalankan,
            ),
          ],
        ),
      ),
    );
  }
}

class _PesanKegagalan extends StatelessWidget {
  const _PesanKegagalan({
    required this.hasil,
    required this.vm,
    required this.cobaLagi,
  });

  final Hasil<Object>? hasil;
  final CatatanLapanganViewModel vm;
  final VoidCallback cobaLagi;

  @override
  Widget build(BuildContext context) {
    final Hasil<Object>? h = hasil;
    if (h is! Gagal<Object>) return const SizedBox.shrink();
    final Tanggapan? t = tanggapanUntuk(h.kegagalan);
    if (t == null) return const SizedBox.shrink();
    final ColorScheme warna = Theme.of(context).colorScheme;
    final String? tombol = switch (t.aksi) {
      AksiPerbaikan.tidakAda => null,
      AksiPerbaikan.cobaLagi => 'Coba lagi',
      AksiPerbaikan.bukaPengaturan => 'Buka Pengaturan',
      AksiPerbaikan.nyalakanLokasi => 'Nyalakan lokasi',
    };
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.pesan, style: TextStyle(color: warna.error)),
          if (tombol != null)
            TextButton(
              onPressed: () => vm.perbaiki(t.aksi, cobaLagi),
              child: Text(tombol),
            ),
        ],
      ),
    );
  }
}

// ============== PEMERIKSAAN (di proyek: folder test/) ==============

int _lulus = 0;
int _jumlah = 0;

void periksa(String nama, Object? didapat, Object? diharapkan) {
  _jumlah++;
  if (didapat == diharapkan) {
    _lulus++;
    debugPrint('LULUS  $nama');
  } else {
    debugPrint('GAGAL  $nama: diharapkan $diharapkan, hasilnya $didapat');
  }
}

Future<void> jalankanUji() async {
  debugPrint('=== Pemeriksaan Catatan Lapangan ===');
  final LayananLokasiPalsu lokasi = LayananLokasiPalsu();
  final PemilihFotoPalsu foto = PemilihFotoPalsu();
  final PengaturanPerangkatPalsu pengaturan = PengaturanPerangkatPalsu();
  CatatanLapanganViewModel buatVm() => CatatanLapanganViewModel(
    layananLokasi: lokasi,
    pemilihFoto: foto,
    pengaturan: pengaturan,
  );

  String? pesanLokasi(CatatanLapanganViewModel vm) {
    final Hasil<Posisi>? h = vm.tandaiLokasi.hasil;
    return h is Gagal<Posisi> ? tanggapanUntuk(h.kegagalan)?.pesan : null;
  }

  AksiPerbaikan? aksiLokasi(CatatanLapanganViewModel vm) {
    final Hasil<Posisi>? h = vm.tandaiLokasi.hasil;
    return h is Gagal<Posisi> ? tanggapanUntuk(h.kegagalan)?.aksi : null;
  }

  // 1. Berhasil: posisi tersimpan, tanpa pesan.
  CatatanLapanganViewModel vm = buatVm();
  await vm.tandaiLokasi.jalankan();
  periksa('Lokasi berhasil -> posisi tersimpan', vm.posisi?.akurasiMeter, 8);
  periksa('Lokasi berhasil -> tanpa pesan', pesanLokasi(vm), null);

  // 2. Setiap skenario gagal menghasilkan tombol yang berbeda.
  final Map<SkenarioLokasi, AksiPerbaikan> harapan = {
    SkenarioLokasi.layananMati: AksiPerbaikan.nyalakanLokasi,
    SkenarioLokasi.izinDitolak: AksiPerbaikan.cobaLagi,
    SkenarioLokasi.izinDiblokir: AksiPerbaikan.bukaPengaturan,
    SkenarioLokasi.waktuHabis: AksiPerbaikan.cobaLagi,
  };
  for (final MapEntry<SkenarioLokasi, AksiPerbaikan> e in harapan.entries) {
    lokasi.skenario = e.key;
    vm = buatVm();
    await vm.tandaiLokasi.jalankan();
    periksa(
      '${e.key.label} -> tombol ${e.value.name}',
      aksiLokasi(vm),
      e.value,
    );
    periksa('${e.key.label} -> posisi tetap kosong', vm.posisi, null);
  }

  // 3. Tombol "Buka Pengaturan" benar-benar membuka Pengaturan aplikasi.
  await vm.perbaiki(AksiPerbaikan.bukaPengaturan, () {});
  periksa(
    'Buka Pengaturan -> pengaturan aplikasi',
    pengaturan.dibuka.last,
    'aplikasi',
  );

  // 4. Foto: batal tidak memunculkan pesan dan tidak menghapus foto lama.
  foto.skenario = SkenarioFoto.berhasil;
  vm = buatVm();
  await vm.ambilFoto.jalankan(false);
  foto.skenario = SkenarioFoto.dibatalkan;
  await vm.ambilFoto.jalankan(true);
  final Hasil<FotoBukti>? hFoto = vm.ambilFoto.hasil;
  periksa(
    'Foto dibatalkan -> tanpa pesan',
    hFoto is Gagal<FotoBukti> ? tanggapanUntuk(hFoto.kegagalan) : 'bukan Gagal',
    null,
  );
  periksa(
    'Foto dibatalkan -> foto lama tetap',
    vm.foto?.nama,
    'tiang_lampu.jpg',
  );

  // 5. Tanpa kamera: tombol Kamera disembunyikan.
  foto.skenario = SkenarioFoto.tanpaKamera;
  periksa('Tanpa kamera -> kameraTersedia false', vm.kameraTersedia, false);

  // 6. Dua ketukan cepat -> layanan lokasi dipanggil SEKALI.
  lokasi
    ..skenario = SkenarioLokasi.berhasil
    ..dipanggil = 0;
  vm = buatVm();
  await Future.wait([vm.tandaiLokasi.jalankan(), vm.tandaiLokasi.jalankan()]);
  periksa('Dua ketukan cepat -> layanan dipanggil sekali', lokasi.dipanggil, 1);

  debugPrint('Ringkasan: $_lulus dari $_jumlah uji lulus');
  // Kembalikan skenario awal untuk tampilan.
  lokasi.skenario = SkenarioLokasi.berhasil;
  foto.skenario = SkenarioFoto.berhasil;
}

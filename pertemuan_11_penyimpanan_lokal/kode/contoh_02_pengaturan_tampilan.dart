// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 11: PENYIMPANAN LOKAL
// CONTOH 02: Pengaturan Tampilan yang Tersimpan (SharedPreferencesWithCache)
// Topik: Lanjutan Contoh 05 Pertemuan 7. Pilihan mode tema, warna utama,
//        dan tingkat kontras kini TERSIMPAN, sehingga aplikasi langsung
//        tampil dengan pilihan terakhir saat dibuka lagi.
//        - SharedPreferencesWithCache dibuat SEKALI di main(), sebelum
//          runApp. Semua nilainya dibaca ke memori (cache), sehingga
//          membacanya kemudian tidak perlu await: tema sudah benar sejak
//          layar pertama, tanpa "berkedip".
//        - allowList: daftar kunci yang boleh dipakai aplikasi ini.
//        - Enum disimpan sebagai NAMA-nya (teks), lalu dibaca kembali
//          dengan asNameMap().
//        Polanya MVVM (Pertemuan 9): Repository -> ViewModel -> View.
// =====================================================================
// CARA MENJALANKAN:
// 1. Proyek Flutter: jalankan `flutter pub add shared_preferences provider`
//    sekali.
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
// 3. Jalankan di terminal: flutter run -d chrome --web-port=8080
//    Ganti beberapa pengaturan, hentikan aplikasi (tekan q), lalu
//    jalankan lagi dengan perintah yang sama.
// =====================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // Wajib dipanggil jika plugin (seperti shared_preferences) dipakai
  // SEBELUM runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // Membaca semua pengaturan dari perangkat ke memori, sekali saja.
  final SharedPreferencesWithCache prefs =
      await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(
          // Hanya kunci-kunci ini yang boleh dibaca dan ditulis.
          allowList: RepositoriPengaturanPrefs.semuaKunci,
        ),
      );

  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) =>
          PengaturanViewModel(repositori: RepositoriPengaturanPrefs(prefs)),
      child: const AplikasiPengaturan(),
    ),
  );
}

// ============================ MODEL ============================

enum WarnaTema {
  hijauToska('Hijau toska', Colors.teal),
  indigo('Indigo', Colors.indigo),
  oranye('Oranye', Colors.deepOrange),
  merahMuda('Merah muda', Colors.pink);

  const WarnaTema(this.label, this.benih);

  final String label;
  final Color benih;
}

// Tiga pengaturan dibungkus menjadi satu objek yang tidak bisa diubah
// (immutable). Untuk "mengubah", buat objek baru dengan copyWith.
class Pengaturan {
  const Pengaturan({
    this.mode = ThemeMode.system,
    this.warna = WarnaTema.hijauToska,
    this.kontras = 0.0,
  });

  final ThemeMode mode;
  final WarnaTema warna;
  final double kontras; // 0.0 normal, 0.5 sedang, 1.0 tinggi

  Pengaturan copyWith({ThemeMode? mode, WarnaTema? warna, double? kontras}) {
    return Pengaturan(
      mode: mode ?? this.mode,
      warna: warna ?? this.warna,
      kontras: kontras ?? this.kontras,
    );
  }
}

// ========================= REPOSITORY =========================

abstract class RepositoriPengaturan {
  // Sinkron (tanpa Future), karena nilainya sudah ada di cache.
  Pengaturan baca();

  Future<void> simpan(Pengaturan pengaturan);

  Future<void> hapusSemua();
}

class RepositoriPengaturanPrefs implements RepositoriPengaturan {
  RepositoriPengaturanPrefs(this._prefs);

  static const String kunciMode = 'mode_tema';
  static const String kunciWarna = 'warna_tema';
  static const String kunciKontras = 'kontras';
  static const Set<String> semuaKunci = {kunciMode, kunciWarna, kunciKontras};

  final SharedPreferencesWithCache _prefs;

  @override
  Pengaturan baca() {
    final String? namaMode = _prefs.getString(kunciMode); // misal 'dark'
    final String? namaWarna = _prefs.getString(kunciWarna); // misal 'indigo'

    // asNameMap() membuat peta nama -> nilai enum, misalnya
    // {'system': ThemeMode.system, 'light': ..., 'dark': ...}.
    // Jika kunci belum pernah disimpan (null) atau isinya tidak dikenal,
    // hasilnya null, lalu nilai bawaan setelah ?? yang dipakai.
    return Pengaturan(
      mode: ThemeMode.values.asNameMap()[namaMode] ?? ThemeMode.system,
      warna: WarnaTema.values.asNameMap()[namaWarna] ?? WarnaTema.hijauToska,
      kontras: _prefs.getDouble(kunciKontras) ?? 0.0,
    );
  }

  @override
  Future<void> simpan(Pengaturan pengaturan) async {
    // .name mengubah nilai enum menjadi teks: ThemeMode.dark -> 'dark'.
    await _prefs.setString(kunciMode, pengaturan.mode.name);
    await _prefs.setString(kunciWarna, pengaturan.warna.name);
    await _prefs.setDouble(kunciKontras, pengaturan.kontras);
  }

  // clear() hanya menghapus kunci yang ada di allowList.
  @override
  Future<void> hapusSemua() => _prefs.clear();
}

// ========================= VIEWMODEL =========================

class PengaturanViewModel extends ChangeNotifier {
  PengaturanViewModel({required RepositoriPengaturan repositori})
    : _repositori = repositori,
      // Nilai awal langsung dibaca dari repository (sinkron).
      _pengaturan = repositori.baca();

  final RepositoriPengaturan _repositori;
  Pengaturan _pengaturan;

  Pengaturan get pengaturan => _pengaturan;

  Future<void> ubahMode(ThemeMode mode) =>
      _terapkan(_pengaturan.copyWith(mode: mode));

  Future<void> ubahWarna(WarnaTema warna) =>
      _terapkan(_pengaturan.copyWith(warna: warna));

  Future<void> ubahKontras(double kontras) =>
      _terapkan(_pengaturan.copyWith(kontras: kontras));

  Future<void> kembalikanBawaan() async {
    _pengaturan = const Pengaturan();
    notifyListeners();
    await _repositori.hapusSemua();
  }

  Future<void> _terapkan(Pengaturan baru) async {
    _pengaturan = baru;
    notifyListeners(); // tampilan langsung berubah...
    await _repositori.simpan(baru); // ...lalu pilihan disimpan
  }
}

// ============================ VIEW ============================

ThemeData buatTema(Pengaturan pengaturan, Brightness kecerahan) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: pengaturan.warna.benih,
      brightness: kecerahan,
      contrastLevel: pengaturan.kontras,
    ),
  );
}

class AplikasiPengaturan extends StatelessWidget {
  const AplikasiPengaturan({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp ikut dibangun ulang setiap pengaturan berubah.
    final PengaturanViewModel vm = context.watch<PengaturanViewModel>();
    final Pengaturan pengaturan = vm.pengaturan;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pengaturan Tampilan',
      theme: buatTema(pengaturan, Brightness.light),
      darkTheme: buatTema(pengaturan, Brightness.dark),
      themeMode: pengaturan.mode,
      home: const HalamanPengaturan(),
    );
  }
}

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});

  @override
  Widget build(BuildContext context) {
    final PengaturanViewModel vm = context.watch<PengaturanViewModel>();
    final Pengaturan pengaturan = vm.pengaturan;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan Tampilan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const KartuPratinjau(),
          const SizedBox(height: 24),
          Text('Mode tema', style: gayaTeks.titleMedium),
          const SizedBox(height: 8),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(
                value: ThemeMode.system,
                icon: Icon(Icons.brightness_auto),
                label: Text('Sistem'),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                icon: Icon(Icons.light_mode),
                label: Text('Terang'),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                icon: Icon(Icons.dark_mode),
                label: Text('Gelap'),
              ),
            ],
            selected: {pengaturan.mode},
            onSelectionChanged: (Set<ThemeMode> pilihan) {
              context.read<PengaturanViewModel>().ubahMode(pilihan.first);
            },
          ),
          const SizedBox(height: 24),
          Text('Warna utama', style: gayaTeks.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final WarnaTema warna in WarnaTema.values)
                ChoiceChip(
                  avatar: CircleAvatar(backgroundColor: warna.benih),
                  label: Text(warna.label),
                  selected: pengaturan.warna == warna,
                  onSelected: (_) {
                    context.read<PengaturanViewModel>().ubahWarna(warna);
                  },
                ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Kontras warna', style: gayaTeks.titleMedium),
          const SizedBox(height: 8),
          SegmentedButton<double>(
            segments: const [
              ButtonSegment(value: 0.0, label: Text('Normal')),
              ButtonSegment(value: 0.5, label: Text('Sedang')),
              ButtonSegment(value: 1.0, label: Text('Tinggi')),
            ],
            selected: {pengaturan.kontras},
            onSelectionChanged: (Set<double> pilihan) {
              context.read<PengaturanViewModel>().ubahKontras(pilihan.first);
            },
          ),
          const SizedBox(height: 32),
          OutlinedButton.icon(
            onPressed: () {
              context.read<PengaturanViewModel>().kembalikanBawaan();
            },
            icon: const Icon(Icons.settings_backup_restore),
            label: const Text('Kembalikan ke bawaan'),
          ),
        ],
      ),
    );
  }
}

class KartuPratinjau extends StatelessWidget {
  const KartuPratinjau({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Card.filled(
      color: warna.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pratinjau',
              style: gayaTeks.titleLarge?.copyWith(
                color: warna.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tutup aplikasi lalu buka lagi: tampilannya tetap seperti '
              'pilihan terakhir Anda.',
              style: gayaTeks.bodyMedium?.copyWith(
                color: warna.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(onPressed: () {}, child: const Text('Tombol')),
                OutlinedButton(onPressed: () {}, child: const Text('Garis')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

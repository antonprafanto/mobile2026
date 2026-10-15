// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 09: MANAJEMEN STATE & MVVM
// CONTOH 06: MultiProvider: Pengaturan Tampilan dan Profil Pengguna
// Topik: MultiProvider menitipkan beberapa objek sekaligus. Di sini ada
//        dua: PengaturanTampilan (mode gelap dan warna aplikasi) dan
//        ProfilPengguna (nama). MaterialApp sendiri membaca pengaturan
//        dengan context.watch, sehingga mengubah mode di halaman
//        Pengaturan langsung mengubah seluruh aplikasi. Bandingkan
//        dengan Pertemuan 7 yang memakai state di akar dan callback.
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
        ChangeNotifierProvider(
          create: (BuildContext context) => PengaturanTampilan(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ProfilPengguna(),
        ),
      ],
      child: const AplikasiKu(),
    ),
  );
}

// ---------- Dua objek state aplikasi ----------
class PilihanWarna {
  const PilihanWarna(this.nama, this.warna);

  final String nama;
  final Color warna;
}

const List<PilihanWarna> daftarWarna = [
  PilihanWarna('Indigo', Colors.indigo),
  PilihanWarna('Hijau', Colors.green),
  PilihanWarna('Oranye', Colors.deepOrange),
];

class PengaturanTampilan extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.light;
  Color _benih = daftarWarna.first.warna;

  ThemeMode get mode => _mode;
  Color get benih => _benih;

  void gantiMode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  void gantiBenih(Color benih) {
    _benih = benih;
    notifyListeners();
  }
}

class ProfilPengguna extends ChangeNotifier {
  String _nama = 'Rina';

  String get nama => _nama;

  void gantiNama(String nama) {
    final String bersih = nama.trim();
    if (bersih.isEmpty) {
      return; // nama kosong diabaikan
    }
    _nama = bersih;
    notifyListeners();
  }
}

// ---------- Aplikasi ----------
class AplikasiKu extends StatelessWidget {
  const AplikasiKu({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp ikut dibangun ulang saat pengaturan berubah.
    final PengaturanTampilan atur = context.watch<PengaturanTampilan>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profil Kampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: atur.benih),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: atur.benih,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: atur.mode,
      home: const HalamanBeranda(),
    );
  }
}

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final String nama = context.watch<ProfilPengguna>().nama;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Halo, $nama!'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const HalamanPengaturan(),
                ),
              );
            },
            tooltip: 'Pengaturan',
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Jadwal hari ini', style: gayaTeks.titleLarge),
          const SizedBox(height: 8),
          const Card.outlined(
            child: ListTile(
              leading: Icon(Icons.class_outlined),
              title: Text('Pemrograman Piranti Bergerak'),
              subtitle: Text('08.00 · Lab Komputer 2'),
            ),
          ),
          const Card.outlined(
            child: ListTile(
              leading: Icon(Icons.class_outlined),
              title: Text('Basis Data'),
              subtitle: Text('10.00 · Ruang B204'),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Buka Pengaturan untuk mengganti nama, mode gelap, dan warna. '
            'Perubahannya langsung terlihat di halaman ini.',
            style: gayaTeks.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class HalamanPengaturan extends StatefulWidget {
  const HalamanPengaturan({super.key});

  @override
  State<HalamanPengaturan> createState() => _HalamanPengaturanState();
}

class _HalamanPengaturanState extends State<HalamanPengaturan> {
  // Teks yang sedang diketik adalah state LOKAL halaman ini.
  late final TextEditingController _kontrolNama;

  @override
  void initState() {
    super.initState();
    // read boleh dipakai di initState untuk mengambil nilai awal.
    _kontrolNama = TextEditingController(
      text: context.read<ProfilPengguna>().nama,
    );
  }

  @override
  void dispose() {
    _kontrolNama.dispose();
    super.dispose();
  }

  void _simpanNama() {
    context.read<ProfilPengguna>().gantiNama(_kontrolNama.text);
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final PengaturanTampilan atur = context.watch<PengaturanTampilan>();
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Nama panggilan', style: gayaTeks.titleMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _kontrolNama,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _simpanNama(),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: _simpanNama,
                tooltip: 'Simpan nama',
                icon: const Icon(Icons.check),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Mode tampilan', style: gayaTeks.titleMedium),
          const SizedBox(height: 8),
          SegmentedButton<ThemeMode>(
            segments: const [
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
            selected: {atur.mode},
            onSelectionChanged: (Set<ThemeMode> pilihan) {
              context.read<PengaturanTampilan>().gantiMode(pilihan.first);
            },
          ),
          const SizedBox(height: 24),
          Text('Warna aplikasi', style: gayaTeks.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final PilihanWarna pilihan in daftarWarna)
                ChoiceChip(
                  label: Text(pilihan.nama),
                  selected: pilihan.warna == atur.benih,
                  onSelected: (_) {
                    context.read<PengaturanTampilan>().gantiBenih(
                      pilihan.warna,
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

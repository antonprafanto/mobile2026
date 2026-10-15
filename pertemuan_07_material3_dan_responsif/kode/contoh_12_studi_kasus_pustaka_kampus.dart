// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 07: MATERIAL 3 & UI RESPONSIF
// CONTOH 12: Studi Kasus "Pustaka Kampus"
// Topik: Merangkai materi hari ini. Tema dibuat dari warna benih yang
//        bisa diganti pengguna, mode gelap bisa dipilih, navigasi
//        berubah dari NavigationBar ke NavigationRail sesuai lebar
//        jendela, katalog memakai pola daftar-detail, dan halaman
//        detail menyusun dirinya dengan LayoutBuilder.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome, lalu coba di jendela
//    sempit (< 600), sedang, dan lebar (>= 840).
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiPustaka());
}

// ---------- 1. Data ----------
enum Kategori {
  teknologi('Teknologi', Icons.computer),
  sains('Sains', Icons.science),
  bahasa('Bahasa', Icons.translate),
  bisnis('Bisnis', Icons.trending_up);

  const Kategori(this.label, this.ikon);

  final String label;
  final IconData ikon;
}

class Buku {
  const Buku({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.tahun,
    required this.kategori,
    required this.sinopsis,
  });

  final int id;
  final String judul;
  final String penulis;
  final int tahun;
  final Kategori kategori;
  final String sinopsis;
}

const List<Buku> daftarBuku = [
  Buku(
    id: 1,
    judul: 'Belajar Flutter dari Nol',
    penulis: 'Rina Kusuma',
    tahun: 2025,
    kategori: Kategori.teknologi,
    sinopsis:
        'Panduan bertahap membuat aplikasi seluler dengan Flutter, mulai '
        'dari widget pertama sampai aplikasi yang siap dirilis.',
  ),
  Buku(
    id: 2,
    judul: 'Algoritma untuk Pemula',
    penulis: 'Bayu Pratama',
    tahun: 2021,
    kategori: Kategori.teknologi,
    sinopsis:
        'Mengenal cara berpikir algoritmis lewat contoh sehari-hari, '
        'lengkap dengan latihan dan pembahasannya.',
  ),
  Buku(
    id: 3,
    judul: 'Basis Data Terapan',
    penulis: 'Sari Wulandari',
    tahun: 2023,
    kategori: Kategori.teknologi,
    sinopsis:
        'Merancang tabel, relasi, dan kueri SQL untuk kebutuhan aplikasi '
        'nyata seperti toko daring dan sistem akademik.',
  ),
  Buku(
    id: 4,
    judul: 'Fisika Dasar Bergambar',
    penulis: 'Andi Saputra',
    tahun: 2020,
    kategori: Kategori.sains,
    sinopsis:
        'Konsep gerak, gaya, dan energi dijelaskan dengan ilustrasi '
        'sehingga mudah dibayangkan.',
  ),
  Buku(
    id: 5,
    judul: 'Kimia di Sekitar Kita',
    penulis: 'Nurul Hidayah',
    tahun: 2022,
    kategori: Kategori.sains,
    sinopsis:
        'Reaksi kimia yang terjadi di dapur, di kebun, dan di tubuh kita, '
        'diceritakan dengan bahasa yang ringan.',
  ),
  Buku(
    id: 6,
    judul: 'Bahasa Inggris Akademik',
    penulis: 'Maya Anggraini',
    tahun: 2023,
    kategori: Kategori.bahasa,
    sinopsis:
        'Kosakata dan pola kalimat untuk menulis ringkasan, abstrak, dan '
        'presentasi ilmiah dalam bahasa Inggris.',
  ),
  Buku(
    id: 7,
    judul: 'Menulis Ilmiah Populer',
    penulis: 'Hendra Gunawan',
    tahun: 2019,
    kategori: Kategori.bahasa,
    sinopsis:
        'Teknik menulis artikel sains yang enak dibaca tanpa mengorbankan '
        'ketepatan isi.',
  ),
  Buku(
    id: 8,
    judul: 'Kewirausahaan Digital',
    penulis: 'Fajar Nugroho',
    tahun: 2024,
    kategori: Kategori.bisnis,
    sinopsis:
        'Langkah memulai usaha berbasis aplikasi: menemukan masalah, '
        'menguji ide, dan menghitung biaya.',
  ),
];

Buku? cariBuku(int? id) {
  for (final Buku buku in daftarBuku) {
    if (buku.id == id) {
      return buku;
    }
  }
  return null;
}

class PilihanWarna {
  const PilihanWarna(this.nama, this.warna);

  final String nama;
  final Color warna;
}

const List<PilihanWarna> daftarWarna = [
  PilihanWarna('Biru', Color(0xFF1565C0)),
  PilihanWarna('Hijau', Color(0xFF2E7D32)),
  PilihanWarna('Merah bata', Color(0xFFB23A2E)),
  PilihanWarna('Ungu', Color(0xFF6A1B9A)),
];

// ---------- 2. Tema ----------
ThemeData buatTema(Color benih, Brightness kecerahan) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: benih, brightness: kecerahan),
  );
}

// ---------- 3. Akar aplikasi: menyimpan pilihan tampilan ----------
class AplikasiPustaka extends StatefulWidget {
  const AplikasiPustaka({super.key});

  @override
  State<AplikasiPustaka> createState() => _AplikasiPustakaState();
}

class _AplikasiPustakaState extends State<AplikasiPustaka> {
  ThemeMode _mode = ThemeMode.system;
  Color _benih = daftarWarna.first.warna;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pustaka Kampus',
      theme: buatTema(_benih, Brightness.light),
      darkTheme: buatTema(_benih, Brightness.dark),
      themeMode: _mode,
      home: HalamanUtama(
        mode: _mode,
        benih: _benih,
        onModeBerubah: (ThemeMode modeBaru) {
          setState(() {
            _mode = modeBaru;
          });
        },
        onBenihBerubah: (Color benihBaru) {
          setState(() {
            _benih = benihBaru;
          });
        },
      ),
    );
  }
}

// ---------- 4. Halaman utama: navigasi adaptif ----------
class HalamanUtama extends StatefulWidget {
  const HalamanUtama({
    super.key,
    required this.mode,
    required this.benih,
    required this.onModeBerubah,
    required this.onBenihBerubah,
  });

  final ThemeMode mode;
  final Color benih;
  final ValueChanged<ThemeMode> onModeBerubah;
  final ValueChanged<Color> onBenihBerubah;

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int _tujuan = 0; // 0 = Katalog, 1 = Pinjaman, 2 = Pengaturan
  int? _idTerpilih; // buku yang tampil di panel detail (dua panel)
  final Set<int> _dipinjam = {3, 6}; // id buku yang sedang dipinjam

  void _pilihTujuan(int indeks) {
    setState(() {
      _tujuan = indeks;
    });
  }

  void _ubahPinjaman(Buku buku) {
    final bool sudahDipinjam = _dipinjam.contains(buku.id);
    setState(() {
      if (sudahDipinjam) {
        _dipinjam.remove(buku.id);
      } else {
        _dipinjam.add(buku.id);
      }
    });

    final ScaffoldMessengerState pesan = ScaffoldMessenger.of(context);
    pesan.hideCurrentSnackBar();
    pesan.showSnackBar(
      SnackBar(
        content: Text(
          sudahDipinjam
              ? '"${buku.judul}" dikembalikan.'
              : '"${buku.judul}" dipinjam.',
        ),
      ),
    );
  }

  // Jendela sempit: detail dibuka sebagai halaman baru dan mengirim
  // jawaban "true" jika tombol pinjam/kembalikan ditekan.
  Future<void> _bukaHalamanDetail(Buku buku) async {
    final bool? ubah = await Navigator.push<bool>(
      context,
      MaterialPageRoute<bool>(
        builder: (BuildContext context) => HalamanDetailBuku(
          buku: buku,
          dipinjam: _dipinjam.contains(buku.id),
        ),
      ),
    );
    if (!mounted) {
      return;
    }
    if (ubah == true) {
      _ubahPinjaman(buku);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double lebar = MediaQuery.widthOf(context);
    final bool duaPanel = lebar >= 840;

    final List<Tujuan> daftarTujuan = [
      const Tujuan('Katalog', Icons.menu_book_outlined, Icons.menu_book),
      Tujuan(
        'Pinjaman',
        Icons.bookmarks_outlined,
        Icons.bookmarks,
        jumlah: _dipinjam.length,
      ),
      const Tujuan('Pengaturan', Icons.settings_outlined, Icons.settings),
    ];

    final Widget isi;
    if (_tujuan == 0) {
      isi = PanelKatalog(
        duaPanel: duaPanel,
        idTerpilih: _idTerpilih,
        dipinjam: _dipinjam,
        onPilih: (Buku buku) {
          if (duaPanel) {
            setState(() {
              _idTerpilih = buku.id;
            });
          } else {
            _bukaHalamanDetail(buku);
          }
        },
        onUbahPinjaman: _ubahPinjaman,
      );
    } else if (_tujuan == 1) {
      isi = PanelPinjaman(dipinjam: _dipinjam, onKembalikan: _ubahPinjaman);
    } else {
      isi = PanelPengaturan(
        mode: widget.mode,
        benih: widget.benih,
        onModeBerubah: widget.onModeBerubah,
        onBenihBerubah: widget.onBenihBerubah,
      );
    }

    final AppBar appBar = AppBar(title: const Text('Pustaka Kampus'));

    // Jendela ringkas: NavigationBar di bawah.
    if (lebar < 600) {
      return Scaffold(
        appBar: appBar,
        body: isi,
        bottomNavigationBar: NavigationBar(
          selectedIndex: _tujuan,
          onDestinationSelected: _pilihTujuan,
          destinations: [
            for (final Tujuan tujuan in daftarTujuan)
              NavigationDestination(
                icon: IkonTujuan(ikon: tujuan.ikon, jumlah: tujuan.jumlah),
                selectedIcon: IkonTujuan(
                  ikon: tujuan.ikonTerpilih,
                  jumlah: tujuan.jumlah,
                ),
                label: tujuan.label,
              ),
          ],
        ),
      );
    }

    // Jendela sedang ke atas: NavigationRail; diperlebar mulai 1200.
    final bool railLebar = lebar >= 1200;
    return Scaffold(
      appBar: appBar,
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _tujuan,
            onDestinationSelected: _pilihTujuan,
            extended: railLebar,
            labelType: railLebar
                ? NavigationRailLabelType.none
                : NavigationRailLabelType.all,
            destinations: [
              for (final Tujuan tujuan in daftarTujuan)
                NavigationRailDestination(
                  icon: IkonTujuan(ikon: tujuan.ikon, jumlah: tujuan.jumlah),
                  selectedIcon: IkonTujuan(
                    ikon: tujuan.ikonTerpilih,
                    jumlah: tujuan.jumlah,
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

class Tujuan {
  const Tujuan(this.label, this.ikon, this.ikonTerpilih, {this.jumlah = 0});

  final String label;
  final IconData ikon;
  final IconData ikonTerpilih;
  final int jumlah; // angka lencana; 0 = tanpa lencana
}

class IkonTujuan extends StatelessWidget {
  const IkonTujuan({super.key, required this.ikon, required this.jumlah});

  final IconData ikon;
  final int jumlah;

  @override
  Widget build(BuildContext context) {
    if (jumlah == 0) {
      return Icon(ikon);
    }
    return Badge.count(count: jumlah, child: Icon(ikon));
  }
}

// ---------- 5. Katalog: satu panel atau dua panel ----------
class PanelKatalog extends StatelessWidget {
  const PanelKatalog({
    super.key,
    required this.duaPanel,
    required this.idTerpilih,
    required this.dipinjam,
    required this.onPilih,
    required this.onUbahPinjaman,
  });

  final bool duaPanel;
  final int? idTerpilih;
  final Set<int> dipinjam;
  final ValueChanged<Buku> onPilih;
  final ValueChanged<Buku> onUbahPinjaman;

  @override
  Widget build(BuildContext context) {
    final Widget daftar = ListView.builder(
      itemCount: daftarBuku.length,
      itemBuilder: (BuildContext context, int index) {
        final Buku buku = daftarBuku[index];
        return BarisBuku(
          buku: buku,
          terpilih: duaPanel && buku.id == idTerpilih,
          dipinjam: dipinjam.contains(buku.id),
          onTap: () => onPilih(buku),
        );
      },
    );

    if (!duaPanel) {
      return daftar;
    }

    final Buku? terpilih = cariBuku(idTerpilih);
    return Row(
      children: [
        SizedBox(width: 360, child: daftar),
        const VerticalDivider(width: 1, thickness: 1),
        Expanded(
          child: terpilih == null
              ? const PanelKosong(pesan: 'Pilih buku di sebelah kiri.')
              : DetailBuku(
                  buku: terpilih,
                  dipinjam: dipinjam.contains(terpilih.id),
                  onTombol: () => onUbahPinjaman(terpilih),
                ),
        ),
      ],
    );
  }
}

class BarisBuku extends StatelessWidget {
  const BarisBuku({
    super.key,
    required this.buku,
    required this.terpilih,
    required this.dipinjam,
    required this.onTap,
  });

  final Buku buku;
  final bool terpilih;
  final bool dipinjam;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return ListTile(
      selected: terpilih,
      selectedTileColor: warna.secondaryContainer,
      selectedColor: warna.onSecondaryContainer,
      leading: CircleAvatar(
        backgroundColor: warna.primaryContainer,
        child: Icon(buku.kategori.ikon, color: warna.onPrimaryContainer),
      ),
      title: Text(buku.judul, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text('${buku.penulis} · ${buku.tahun}'),
      trailing: dipinjam
          ? Icon(Icons.bookmark, color: warna.tertiary)
          : const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

// Detail buku menyusun dirinya sendiri berdasarkan ruang yang tersedia.
class DetailBuku extends StatelessWidget {
  const DetailBuku({
    super.key,
    required this.buku,
    required this.dipinjam,
    required this.onTombol,
  });

  final Buku buku;
  final bool dipinjam;
  final VoidCallback onTombol;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    final Widget sampul = Container(
      width: 120,
      height: 160,
      decoration: BoxDecoration(
        color: warna.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        buku.kategori.ikon,
        size: 56,
        color: warna.onPrimaryContainer,
      ),
    );

    final Widget keterangan = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(buku.judul, style: gayaTeks.headlineSmall),
        const SizedBox(height: 4),
        Text(
          '${buku.penulis} · ${buku.tahun}',
          style: gayaTeks.bodyLarge?.copyWith(color: warna.onSurfaceVariant),
        ),
        const SizedBox(height: 12),
        Chip(
          avatar: Icon(buku.kategori.ikon),
          label: Text(buku.kategori.label),
        ),
        const SizedBox(height: 12),
        if (dipinjam)
          OutlinedButton.icon(
            onPressed: onTombol,
            icon: const Icon(Icons.assignment_return),
            label: const Text('Kembalikan'),
          )
        else
          FilledButton.icon(
            onPressed: onTombol,
            icon: const Icon(Icons.bookmark_add),
            label: const Text('Pinjam buku'),
          ),
      ],
    );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints batasan) {
        // Ruang lega: sampul di kiri, keterangan di kanan.
        // Ruang sempit: sampul di atas, keterangan di bawahnya.
        final bool lega = batasan.maxWidth >= 520;

        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            if (lega)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sampul,
                  const SizedBox(width: 24),
                  Expanded(child: keterangan),
                ],
              )
            else ...[
              Center(child: sampul),
              const SizedBox(height: 24),
              keterangan,
            ],
            const SizedBox(height: 24),
            Text('Sinopsis', style: gayaTeks.titleMedium),
            const SizedBox(height: 8),
            Text(buku.sinopsis, style: gayaTeks.bodyLarge),
          ],
        );
      },
    );
  }
}

class HalamanDetailBuku extends StatelessWidget {
  const HalamanDetailBuku({
    super.key,
    required this.buku,
    required this.dipinjam,
  });

  final Buku buku;
  final bool dipinjam;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Buku')),
      body: DetailBuku(
        buku: buku,
        dipinjam: dipinjam,
        // Kirim jawaban "ubah status pinjaman" ke halaman sebelumnya.
        onTombol: () => Navigator.pop(context, true),
      ),
    );
  }
}

class PanelKosong extends StatelessWidget {
  const PanelKosong({super.key, required this.pesan});

  final String pesan;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_stories, size: 64, color: warna.outline),
            const SizedBox(height: 12),
            Text(
              pesan,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- 6. Pinjaman ----------
class PanelPinjaman extends StatelessWidget {
  const PanelPinjaman({
    super.key,
    required this.dipinjam,
    required this.onKembalikan,
  });

  final Set<int> dipinjam;
  final ValueChanged<Buku> onKembalikan;

  @override
  Widget build(BuildContext context) {
    // Nilai turunan: buku-buku yang id-nya ada di dalam Set.
    final List<Buku> bukuDipinjam = [
      for (final Buku buku in daftarBuku)
        if (dipinjam.contains(buku.id)) buku,
    ];

    if (bukuDipinjam.isEmpty) {
      return const PanelKosong(pesan: 'Belum ada buku yang dipinjam.');
    }

    // Di layar lebar, daftar tidak dibiarkan melebar lebih dari 720.
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: bukuDipinjam.length,
          itemBuilder: (BuildContext context, int index) {
            final Buku buku = bukuDipinjam[index];
            return Card.outlined(
              child: ListTile(
                leading: Icon(buku.kategori.ikon),
                title: Text(buku.judul),
                subtitle: Text(buku.penulis),
                trailing: IconButton(
                  onPressed: () => onKembalikan(buku),
                  tooltip: 'Kembalikan',
                  icon: const Icon(Icons.assignment_return),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ---------- 7. Pengaturan tampilan ----------
class PanelPengaturan extends StatelessWidget {
  const PanelPengaturan({
    super.key,
    required this.mode,
    required this.benih,
    required this.onModeBerubah,
    required this.onBenihBerubah,
  });

  final ThemeMode mode;
  final Color benih;
  final ValueChanged<ThemeMode> onModeBerubah;
  final ValueChanged<Color> onBenihBerubah;

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    // Kelas ukuran jendela (Material 3), hanya untuk ditampilkan.
    final double lebar = MediaQuery.widthOf(context);
    final String kelas;
    if (lebar < 600) {
      kelas = 'ringkas';
    } else if (lebar < 840) {
      kelas = 'sedang';
    } else if (lebar < 1200) {
      kelas = 'lebar';
    } else if (lebar < 1600) {
      kelas = 'besar';
    } else {
      kelas = 'ekstra besar';
    }

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
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
              selected: {mode},
              onSelectionChanged: (Set<ThemeMode> pilihan) {
                onModeBerubah(pilihan.first);
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
                    selected: pilihan.warna == benih,
                    onSelected: (_) {
                      onBenihBerubah(pilihan.warna);
                    },
                  ),
              ],
            ),
            const SizedBox(height: 24),
            Card.filled(
              child: ListTile(
                leading: const Icon(Icons.aspect_ratio),
                title: const Text('Lebar jendela'),
                subtitle: Text('${lebar.toStringAsFixed(0)}, kelas $kelas'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

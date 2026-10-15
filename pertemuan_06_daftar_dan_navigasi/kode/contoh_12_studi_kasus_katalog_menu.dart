// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 06: DAFTAR DATA & NAVIGASI
// CONTOH 12: Studi Kasus "Katalog Menu Kantin"
// Topik: Merangkai materi hari ini. Daftar menu dari List objek,
//        pencarian + chip kategori, halaman detail beralamat /menu/:id
//        (go_router), jumlah porsi dikirim balik sebagai hasil, lalu
//        isi keranjang ditampilkan di bottom sheet.
// =====================================================================
// CARA MENJALANKAN:
// 1. Pastikan paket go_router sudah ada di pubspec.yaml proyek Anda
//    (lihat modul Bagian 13.2), lalu jalankan: flutter pub get
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
//    (Di https://dartpad.dev paket go_router sudah tersedia.)
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const AplikasiKatalogKantin());
}

// ===================== 1) DATA =====================

enum Kategori {
  makanan('Makanan'),
  minuman('Minuman'),
  camilan('Camilan');

  const Kategori(this.label);

  final String label;
}

class Menu {
  const Menu({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.ikon,
    required this.deskripsi,
  });

  final int id; // tanda pengenal unik, dipakai di alamat /menu/:id
  final String nama;
  final Kategori kategori;
  final int harga;
  final IconData ikon;
  final String deskripsi;
}

const List<Menu> daftarMenu = [
  Menu(
    id: 1,
    nama: 'Nasi Goreng Spesial',
    kategori: Kategori.makanan,
    harga: 15000,
    ikon: Icons.rice_bowl,
    deskripsi: 'Nasi goreng dengan telur mata sapi, ayam suwir, dan kerupuk.',
  ),
  Menu(
    id: 2,
    nama: 'Mie Ayam Bakso',
    kategori: Kategori.makanan,
    harga: 13000,
    ikon: Icons.ramen_dining,
    deskripsi: 'Mie ayam kecap dengan dua butir bakso sapi.',
  ),
  Menu(
    id: 3,
    nama: 'Soto Banjar',
    kategori: Kategori.makanan,
    harga: 16000,
    ikon: Icons.soup_kitchen,
    deskripsi: 'Soto ayam berkuah bening dengan perkedel dan ketupat.',
  ),
  Menu(
    id: 4,
    nama: 'Es Teh Manis',
    kategori: Kategori.minuman,
    harga: 4000,
    ikon: Icons.local_cafe,
    deskripsi: 'Teh melati dingin dengan gula secukupnya.',
  ),
  Menu(
    id: 5,
    nama: 'Jus Alpukat',
    kategori: Kategori.minuman,
    harga: 10000,
    ikon: Icons.local_drink,
    deskripsi: 'Jus alpukat kental dengan susu cokelat.',
  ),
  Menu(
    id: 6,
    nama: 'Kopi Susu Gula Aren',
    kategori: Kategori.minuman,
    harga: 12000,
    ikon: Icons.coffee,
    deskripsi: 'Kopi robusta, susu segar, dan gula aren.',
  ),
  Menu(
    id: 7,
    nama: 'Pisang Goreng',
    kategori: Kategori.camilan,
    harga: 6000,
    ikon: Icons.cookie,
    deskripsi: 'Tiga potong pisang kepok goreng yang renyah.',
  ),
  Menu(
    id: 8,
    nama: 'Tahu Isi',
    kategori: Kategori.camilan,
    harga: 5000,
    ikon: Icons.bakery_dining,
    deskripsi: 'Dua tahu isi sayuran, lengkap dengan cabai rawit.',
  ),
];

// Mencari menu berdasarkan id. Hasilnya null jika tidak ada.
Menu? cariMenu(int id) {
  for (final Menu menu in daftarMenu) {
    if (menu.id == id) {
      return menu;
    }
  }
  return null;
}

// Satu baris di keranjang: menu apa dan berapa porsi.
class ItemKeranjang {
  const ItemKeranjang(this.menu, this.jumlah);

  final Menu menu;
  final int jumlah;

  int get subtotal => menu.harga * jumlah;
}

// Mengubah 15000 menjadi "Rp15.000": sisipkan titik setiap tiga angka
// dari kanan.
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

// ===================== 2) PETA RUTE =====================

final GoRouter petaRute = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HalamanKatalog();
      },
      routes: [
        GoRoute(
          path: 'menu/:id',
          builder: (BuildContext context, GoRouterState state) {
            // Isi alamat selalu berupa teks, jadi id diubah dulu ke int.
            final int? id = int.tryParse(state.pathParameters['id']!);
            final Menu? menu = id == null ? null : cariMenu(id);
            if (menu == null) {
              return HalamanTidakDitemukan(alamat: state.uri.toString());
            }
            return HalamanDetailMenu(menu: menu);
          },
        ),
      ],
    ),
  ],
  errorBuilder: (BuildContext context, GoRouterState state) {
    return HalamanTidakDitemukan(alamat: state.uri.toString());
  },
);

class AplikasiKatalogKantin extends StatelessWidget {
  const AplikasiKatalogKantin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      routerConfig: petaRute,
    );
  }
}

// ===================== 3) HALAMAN KATALOG ( / ) =====================

class HalamanKatalog extends StatefulWidget {
  const HalamanKatalog({super.key});

  @override
  State<HalamanKatalog> createState() => _HalamanKatalogState();
}

class _HalamanKatalogState extends State<HalamanKatalog> {
  final TextEditingController _kontrolCari = TextEditingController();
  String _kataKunci = '';
  Kategori? _kategori; // null = semua kategori

  // Isi keranjang: id menu -> jumlah porsi. Ini state yang sebenarnya.
  final Map<int, int> _keranjang = {};

  // ---------- Nilai turunan (dihitung, bukan disimpan) ----------
  List<Menu> get _hasil {
    final String kunci = _kataKunci.trim().toLowerCase();
    return daftarMenu.where((Menu menu) {
      final bool cocokNama = menu.nama.toLowerCase().contains(kunci);
      final bool cocokKategori =
          _kategori == null || menu.kategori == _kategori;
      return cocokNama && cocokKategori;
    }).toList();
  }

  List<ItemKeranjang> get _isiKeranjang {
    final List<ItemKeranjang> hasil = [];
    for (final Menu menu in daftarMenu) {
      final int? jumlah = _keranjang[menu.id];
      if (jumlah != null) {
        hasil.add(ItemKeranjang(menu, jumlah));
      }
    }
    return hasil;
  }

  int get _jumlahPorsi {
    int total = 0;
    for (final int jumlah in _keranjang.values) {
      total += jumlah;
    }
    return total;
  }

  int get _totalHarga {
    int total = 0;
    for (final ItemKeranjang item in _isiKeranjang) {
      total += item.subtotal;
    }
    return total;
  }

  // ---------- Aksi ----------
  Future<void> _bukaDetail(Menu menu) async {
    // push ke /menu/id lalu MENUNGGU jumlah porsi yang dikirim balik.
    final int? jumlah = await context.push<int>('/menu/${menu.id}');
    if (!mounted) return;
    if (jumlah == null) return; // kembali tanpa menambah

    setState(() {
      _keranjang[menu.id] = (_keranjang[menu.id] ?? 0) + jumlah;
    });
    final ScaffoldMessengerState pesan = ScaffoldMessenger.of(context);
    pesan.hideCurrentSnackBar();
    pesan.showSnackBar(
      SnackBar(content: Text('$jumlah × ${menu.nama} masuk keranjang.')),
    );
  }

  Future<void> _lihatKeranjang() async {
    final bool? pesanSekarang = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      // Tanpa ini, tinggi lembar dibatasi 9/16 layar. Pada layar pendek
      // isinya tidak muat dan muncul garis kuning-hitam (overflow).
      isScrollControlled: true,
      builder: (BuildContext context) {
        return LembarKeranjang(isi: _isiKeranjang, total: _totalHarga);
      },
    );
    if (!mounted) return;
    if (pesanSekarang != true) return;

    setState(() {
      _keranjang.clear();
    });
    final ScaffoldMessengerState pesan = ScaffoldMessenger.of(context);
    pesan.hideCurrentSnackBar();
    pesan.showSnackBar(
      const SnackBar(content: Text('Pesanan dikirim ke dapur. Terima kasih!')),
    );
  }

  @override
  void dispose() {
    _kontrolCari.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Menu> hasil = _hasil;
    final int porsi = _jumlahPorsi;

    return Scaffold(
      appBar: AppBar(title: const Text('Katalog Kantin')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: SearchBar(
              controller: _kontrolCari,
              hintText: 'Cari menu',
              leading: const Icon(Icons.search),
              onChanged: (String teks) {
                setState(() {
                  _kataKunci = teks;
                });
              },
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Semua'),
                  selected: _kategori == null,
                  onSelected: (_) {
                    setState(() {
                      _kategori = null;
                    });
                  },
                ),
                for (final Kategori kategori in Kategori.values)
                  ChoiceChip(
                    label: Text(kategori.label),
                    selected: _kategori == kategori,
                    onSelected: (_) {
                      setState(() {
                        _kategori = kategori;
                      });
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: hasil.isEmpty
                ? const Center(child: Text('Menu yang dicari tidak ada.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: hasil.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Menu menu = hasil[index];
                      return KartuMenu(
                        menu: menu,
                        jumlahDiKeranjang: _keranjang[menu.id] ?? 0,
                        onTap: () => _bukaDetail(menu),
                      );
                    },
                  ),
          ),
        ],
      ),
      // Tombol keranjang hanya muncul jika keranjang tidak kosong.
      bottomNavigationBar: porsi == 0
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton.icon(
                  onPressed: _lihatKeranjang,
                  icon: const Icon(Icons.shopping_bag),
                  label: Text('$porsi porsi · ${formatRupiah(_totalHarga)}'),
                ),
              ),
            ),
    );
  }
}

class KartuMenu extends StatelessWidget {
  const KartuMenu({
    super.key,
    required this.menu,
    required this.jumlahDiKeranjang,
    required this.onTap,
  });

  final Menu menu;
  final int jumlahDiKeranjang;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: warna.primaryContainer,
          child: Icon(menu.ikon, color: warna.onPrimaryContainer),
        ),
        title: Text(menu.nama),
        subtitle: Text('${menu.kategori.label} · ${formatRupiah(menu.harga)}'),
        // Tanda jumlah porsi yang sudah masuk keranjang. Ukuran huruf
        // ditulis sendiri karena teks trailing bawaan M3 kecil (11).
        trailing: jumlahDiKeranjang == 0
            ? const Icon(Icons.chevron_right)
            : Text(
                '×$jumlahDiKeranjang',
                style: TextStyle(
                  color: warna.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
        onTap: onTap,
      ),
    );
  }
}

class LembarKeranjang extends StatelessWidget {
  const LembarKeranjang({super.key, required this.isi, required this.total});

  final List<ItemKeranjang> isi;
  final int total;

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    // Jika keranjang berisi banyak menu, isinya bisa digulir.
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Keranjang', style: gayaTeks.titleLarge),
          const SizedBox(height: 8),
          for (final ItemKeranjang item in isi)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(item.menu.nama),
              subtitle: Text(
                '${item.jumlah} × ${formatRupiah(item.menu.harga)}',
              ),
              trailing: Text(formatRupiah(item.subtotal)),
            ),
          const Divider(),
          Row(
            children: [
              Expanded(child: Text('Total', style: gayaTeks.titleMedium)),
              Text(formatRupiah(total), style: gayaTeks.titleMedium),
            ],
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Pesan sekarang'),
          ),
        ],
      ),
    );
  }
}

// ===================== 4) HALAMAN DETAIL ( /menu/:id ) =====================

class HalamanDetailMenu extends StatefulWidget {
  const HalamanDetailMenu({super.key, required this.menu});

  final Menu menu;

  @override
  State<HalamanDetailMenu> createState() => _HalamanDetailMenuState();
}

class _HalamanDetailMenuState extends State<HalamanDetailMenu> {
  int _jumlah = 1;

  @override
  Widget build(BuildContext context) {
    final Menu menu = widget.menu;
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(menu.nama)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: warna.primaryContainer,
            child: Icon(menu.ikon, size: 48, color: warna.onPrimaryContainer),
          ),
          const SizedBox(height: 16),
          Text(
            menu.nama,
            textAlign: TextAlign.center,
            style: gayaTeks.headlineSmall,
          ),
          Text(menu.kategori.label, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text(menu.deskripsi, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text(
            formatRupiah(menu.harga),
            textAlign: TextAlign.center,
            style: gayaTeks.titleLarge?.copyWith(color: warna.primary),
          ),
          const SizedBox(height: 24),
          Center(
            child: TombolJumlah(
              jumlah: _jumlah,
              minimum: 1,
              maksimum: 10,
              onKurang: () {
                setState(() {
                  _jumlah--;
                });
              },
              onTambah: () {
                setState(() {
                  _jumlah++;
                });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            // Tutup halaman ini SAMBIL mengirim jumlah porsi.
            onPressed: () => context.pop(_jumlah),
            icon: const Icon(Icons.add_shopping_cart),
            label: Text('Tambah · ${formatRupiah(menu.harga * _jumlah)}'),
          ),
        ),
      ),
    );
  }
}

// TombolJumlah dari Pertemuan 5 (contoh 11).
class TombolJumlah extends StatelessWidget {
  const TombolJumlah({
    super.key,
    required this.jumlah,
    required this.onTambah,
    required this.onKurang,
    this.minimum = 0,
    this.maksimum = 99,
  });

  final int jumlah;
  final VoidCallback onTambah;
  final VoidCallback onKurang;
  final int minimum;
  final int maksimum;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.outlined(
          tooltip: 'Kurangi',
          onPressed: jumlah > minimum ? onKurang : null,
          icon: const Icon(Icons.remove),
        ),
        SizedBox(
          width: 32,
          child: Text(
            '$jumlah',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        IconButton.filled(
          tooltip: 'Tambah',
          onPressed: jumlah < maksimum ? onTambah : null,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

// ===================== 5) HALAMAN ALAMAT SALAH =====================

class HalamanTidakDitemukan extends StatelessWidget {
  const HalamanTidakDitemukan({super.key, required this.alamat});

  final String alamat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tidak Ditemukan')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.no_food, size: 64),
              const SizedBox(height: 12),
              Text(
                'Menu dengan alamat "$alamat" tidak ada.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => context.go('/'),
                child: const Text('Kembali ke katalog'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

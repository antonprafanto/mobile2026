// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 05: INTERAKSI & STATE LOKAL
// CONTOH 10: Mengangkat State (Lifting State Up)
// Topik: State disimpan di induk, anak cukup StatelessWidget yang
//        menerima data (parameter) dan melapor lewat callback
//        (VoidCallback). Total harga dihitung dari state, bukan disimpan.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiKeranjang());
}

class Menu {
  const Menu(this.nama, this.harga, this.ikon);

  final String nama;
  final int harga;
  final IconData ikon;
}

const List<Menu> daftarMenu = [
  Menu('Nasi Goreng', 15000, Icons.rice_bowl),
  Menu('Mie Ayam', 12000, Icons.ramen_dining),
  Menu('Es Teh', 4000, Icons.local_cafe),
];

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

class AplikasiKeranjang extends StatelessWidget {
  const AplikasiKeranjang({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const HalamanKeranjang(),
    );
  }
}

// ---------------------------------------------------------------------
// INDUK: satu-satunya tempat state jumlah disimpan.
// ---------------------------------------------------------------------
class HalamanKeranjang extends StatefulWidget {
  const HalamanKeranjang({super.key});

  @override
  State<HalamanKeranjang> createState() => _HalamanKeranjangState();
}

class _HalamanKeranjangState extends State<HalamanKeranjang> {
  // _jumlah[0] untuk menu ke-0, _jumlah[1] untuk menu ke-1, dan seterusnya.
  final List<int> _jumlah = List<int>.filled(daftarMenu.length, 0);

  // Nilai TURUNAN dihitung dari state lewat getter (Pertemuan 3),
  // tidak disimpan di variabel tersendiri. Jadi tidak mungkin "telat".
  int get _totalPorsi {
    int hasil = 0;
    for (int porsi in _jumlah) {
      hasil += porsi;
    }
    return hasil;
  }

  int get _totalHarga {
    int hasil = 0;
    for (int i = 0; i < daftarMenu.length; i++) {
      hasil += daftarMenu[i].harga * _jumlah[i];
    }
    return hasil;
  }

  void _ubahJumlah(int indeks, int perubahan) {
    setState(() {
      _jumlah[indeks] += perubahan;
    });
  }

  void _bayar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$_totalPorsi porsi (${formatRupiah(_totalHarga)}) dikirim ke dapur.',
        ),
      ),
    );
    setState(() {
      _jumlah.fillRange(0, _jumlah.length, 0); // kosongkan keranjang
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Kantin')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 8,
          children: [
            for (int i = 0; i < daftarMenu.length; i++)
              KartuMenu(
                menu: daftarMenu[i],
                jumlah: _jumlah[i], // data turun ke anak
                onTambah: () => _ubahJumlah(i, 1), // laporan naik ke induk
                onKurang: () => _ubahJumlah(i, -1),
              ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 12,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('$_totalPorsi porsi'),
                    Text(
                      formatRupiah(_totalHarga),
                      style: gayaTeks.titleLarge?.copyWith(
                        color: warna.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              FilledButton.icon(
                // Nonaktif selama keranjang masih kosong.
                onPressed: _totalPorsi > 0 ? _bayar : null,
                icon: const Icon(Icons.payments_outlined),
                label: const Text('Bayar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// ANAK: StatelessWidget. Tidak menyimpan jumlah sendiri. Ia hanya
// MENAMPILKAN jumlah dari induk dan MELAPOR saat tombol ditekan.
// ---------------------------------------------------------------------
class KartuMenu extends StatelessWidget {
  const KartuMenu({
    super.key,
    required this.menu,
    required this.jumlah,
    required this.onTambah,
    required this.onKurang,
  });

  final Menu menu;
  final int jumlah;
  // VoidCallback = fungsi tanpa parameter dan tanpa nilai kembali.
  final VoidCallback onTambah;
  final VoidCallback onKurang;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          spacing: 12,
          children: [
            CircleAvatar(child: Icon(menu.ikon)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.nama,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(formatRupiah(menu.harga)),
                ],
              ),
            ),
            TombolJumlah(
              jumlah: jumlah,
              onTambah: onTambah,
              onKurang: onKurang,
            ),
          ],
        ),
      ),
    );
  }
}

// Tombol - angka + yang bisa dipakai ulang di halaman mana saja.
class TombolJumlah extends StatelessWidget {
  const TombolJumlah({
    super.key,
    required this.jumlah,
    required this.onTambah,
    required this.onKurang,
  });

  final int jumlah;
  final VoidCallback onTambah;
  final VoidCallback onKurang;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.outlined(
          tooltip: 'Kurangi',
          // Tidak bisa dikurangi lagi jika sudah 0.
          onPressed: jumlah > 0 ? onKurang : null,
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
          onPressed: onTambah,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 09: MANAJEMEN STATE & MVVM
// CONTOH 01: Masalah State yang Dioper Bertingkat
// Topik: Contoh ini SENGAJA memperlihatkan dua masalah setState ketika
//        satu data dipakai banyak widget dan banyak halaman:
//        1. Data dan callback harus dioper lewat constructor dari tingkat
//           ke tingkat, termasuk melewati widget yang tidak memakainya.
//        2. Halaman Keranjang tidak langsung berubah saat barang dihapus.
//           setState di HalamanToko hanya membangun ulang HalamanToko,
//           bukan halaman lain yang dibuka di atasnya.
//        Contoh 04 memperbaiki kedua masalah ini dengan paket provider.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// 4. Tambahkan tiga barang, buka keranjang, lalu hapus satu barang.
//    Perhatikan: barang itu tetap terlihat sampai halaman ditutup.
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiBelanja());
}

const List<String> daftarBarang = [
  'Beras 5 kg',
  'Minyak goreng 1 L',
  'Telur 1 kg',
  'Mi instan 5 bungkus',
  'Gula pasir 1 kg',
  'Kopi sachet 10 bungkus',
];

class AplikasiBelanja extends StatelessWidget {
  const AplikasiBelanja({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Belanja Kos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const HalamanToko(),
    );
  }
}

// TINGKAT 1: halaman toko menyimpan isi keranjang.
class HalamanToko extends StatefulWidget {
  const HalamanToko({super.key});

  @override
  State<HalamanToko> createState() => _HalamanTokoState();
}

class _HalamanTokoState extends State<HalamanToko> {
  final List<String> _keranjang = [];

  void _tambah(String barang) {
    setState(() {
      _keranjang.add(barang);
    });
  }

  void _hapus(int indeks) {
    setState(() {
      _keranjang.removeAt(indeks);
    });
  }

  void _bukaKeranjang() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        // Halaman baru menerima keranjang dan callback lewat constructor.
        builder: (BuildContext context) =>
            HalamanKeranjang(keranjang: _keranjang, onHapus: _hapus),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belanja Kos'),
        actions: [
          IconButton(
            onPressed: _bukaKeranjang,
            tooltip: 'Keranjang',
            icon: Badge.count(
              count: _keranjang.length,
              isLabelVisible: _keranjang.isNotEmpty,
              child: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      // DaftarBarang harus menerima _tambah walaupun tidak memakainya.
      body: DaftarBarang(onTambah: _tambah),
    );
  }
}

// TINGKAT 2: daftar hanya MENERUSKAN onTambah ke setiap baris.
class DaftarBarang extends StatelessWidget {
  const DaftarBarang({super.key, required this.onTambah});

  final ValueChanged<String> onTambah;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: daftarBarang.length,
      itemBuilder: (BuildContext context, int index) {
        return BarisBarang(nama: daftarBarang[index], onTambah: onTambah);
      },
    );
  }
}

// TINGKAT 3: baru di sini onTambah benar-benar dipakai.
class BarisBarang extends StatelessWidget {
  const BarisBarang({super.key, required this.nama, required this.onTambah});

  final String nama;
  final ValueChanged<String> onTambah;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.shopping_basket_outlined),
      title: Text(nama),
      trailing: IconButton(
        onPressed: () => onTambah(nama),
        tooltip: 'Tambah ke keranjang',
        icon: const Icon(Icons.add_shopping_cart),
      ),
    );
  }
}

// MASALAH 2: halaman ini dibangun saat dibuka. Saat tombol hapus ditekan,
// data di HalamanToko berubah dan HalamanToko dibangun ulang, tetapi
// halaman ini TIDAK, sehingga barang yang dihapus masih terlihat.
class HalamanKeranjang extends StatelessWidget {
  const HalamanKeranjang({
    super.key,
    required this.keranjang,
    required this.onHapus,
  });

  final List<String> keranjang;
  final ValueChanged<int> onHapus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Keranjang (${keranjang.length})')),
      body: keranjang.isEmpty
          ? const Center(child: Text('Keranjang masih kosong.'))
          : ListView.builder(
              itemCount: keranjang.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(keranjang[index]),
                  trailing: IconButton(
                    onPressed: () => onHapus(index),
                    tooltip: 'Hapus',
                    icon: const Icon(Icons.delete_outline),
                  ),
                );
              },
            ),
    );
  }
}

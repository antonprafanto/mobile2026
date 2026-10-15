// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 09: MANAJEMEN STATE & MVVM
// CONTOH 04: Paket provider: Satu Keranjang untuk Semua Halaman
// Topik: Aplikasi yang sama dengan Contoh 01, tetapi keranjang kini
//        sebuah ChangeNotifier yang "dititipkan" di atas MaterialApp
//        dengan ChangeNotifierProvider. Widget mana pun, di halaman mana
//        pun, bisa mengambilnya langsung:
//        - context.watch<Keranjang>() untuk MENAMPILKAN isinya
//          (widget dibangun ulang saat keranjang berubah);
//        - context.read<Keranjang>() untuk MEMANGGIL metodenya
//          (misalnya di onPressed).
//        Tidak ada lagi data yang dioper lewat constructor, dan halaman
//        Keranjang langsung berubah saat barang dihapus.
// =====================================================================
// CARA MENJALANKAN:
// 1. Proyek Flutter: jalankan `flutter pub add provider` sekali.
//    (DartPad sudah menyediakan paket provider.)
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // Keranjang dititipkan DI ATAS MaterialApp, sehingga semua halaman,
    // termasuk yang dibuka dengan Navigator.push, bisa memakainya.
    ChangeNotifierProvider(
      create: (BuildContext context) => Keranjang(),
      child: const AplikasiBelanja(),
    ),
  );
}

const List<String> daftarBarang = [
  'Beras 5 kg',
  'Minyak goreng 1 L',
  'Telur 1 kg',
  'Mi instan 5 bungkus',
  'Gula pasir 1 kg',
  'Kopi sachet 10 bungkus',
];

// ---------- State aplikasi: keranjang belanja ----------
class Keranjang extends ChangeNotifier {
  final List<String> _isi = [];

  // Dari luar hanya bisa dibaca. UnmodifiableListView melempar error
  // jika ada yang mencoba isi.add(...) tanpa lewat metode tambah.
  UnmodifiableListView<String> get isi => UnmodifiableListView(_isi);
  int get jumlah => _isi.length;

  void tambah(String barang) {
    _isi.add(barang);
    notifyListeners();
  }

  void hapus(int indeks) {
    _isi.removeAt(indeks);
    notifyListeners();
  }

  void kosongkan() {
    _isi.clear();
    notifyListeners();
  }
}

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

// Kini StatelessWidget: datanya ada di Keranjang, bukan di halaman ini.
class HalamanToko extends StatelessWidget {
  const HalamanToko({super.key});

  @override
  Widget build(BuildContext context) {
    // watch: ambil keranjang DAN dengarkan perubahannya.
    final int jumlah = context.watch<Keranjang>().jumlah;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Belanja Kos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  // Tidak ada data yang dioper lewat constructor.
                  builder: (BuildContext context) => const HalamanKeranjang(),
                ),
              );
            },
            tooltip: 'Keranjang',
            icon: Badge.count(
              count: jumlah,
              isLabelVisible: jumlah > 0,
              child: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: daftarBarang.length,
        itemBuilder: (BuildContext context, int index) {
          return BarisBarang(nama: daftarBarang[index]);
        },
      ),
    );
  }
}

class BarisBarang extends StatelessWidget {
  const BarisBarang({super.key, required this.nama});

  final String nama;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.shopping_basket_outlined),
      title: Text(nama),
      trailing: IconButton(
        // read: cukup ambil keranjang lalu panggil metodenya. Baris ini
        // tidak perlu dibangun ulang saat keranjang berubah.
        onPressed: () => context.read<Keranjang>().tambah(nama),
        tooltip: 'Tambah ke keranjang',
        icon: const Icon(Icons.add_shopping_cart),
      ),
    );
  }
}

class HalamanKeranjang extends StatelessWidget {
  const HalamanKeranjang({super.key});

  @override
  Widget build(BuildContext context) {
    // Halaman ini juga mendengarkan, jadi langsung berubah saat dihapus.
    final Keranjang keranjang = context.watch<Keranjang>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang (${keranjang.jumlah})'),
        actions: [
          TextButton(
            onPressed: keranjang.jumlah == 0
                ? null
                : () => context.read<Keranjang>().kosongkan(),
            child: const Text('Kosongkan'),
          ),
        ],
      ),
      body: keranjang.jumlah == 0
          ? const Center(child: Text('Keranjang masih kosong.'))
          : ListView.builder(
              itemCount: keranjang.jumlah,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(keranjang.isi[index]),
                  trailing: IconButton(
                    onPressed: () => context.read<Keranjang>().hapus(index),
                    tooltip: 'Hapus',
                    icon: const Icon(Icons.delete_outline),
                  ),
                );
              },
            ),
    );
  }
}

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 06: DAFTAR DATA & NAVIGASI
// CONTOH 03: GridView.builder, Daftar Berbentuk Kotak-Kotak
// Topik: GridView menyusun data dalam baris DAN kolom. Dengan
//        SliverGridDelegateWithMaxCrossAxisExtent, jumlah kolom
//        menyesuaikan lebar layar: 2 kolom di ponsel, lebih banyak
//        di tablet atau jendela browser yang lebar.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// 4. Coba ubah lebar jendela browser dan perhatikan jumlah kolomnya.
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiKoperasi());
}

class Produk {
  const Produk(this.nama, this.harga, this.ikon);

  final String nama;
  final int harga;
  final IconData ikon;
}

const List<Produk> daftarProduk = [
  Produk('Buku Tulis', 5000, Icons.menu_book),
  Produk('Pulpen Gel', 4000, Icons.edit),
  Produk('Kertas HVS (1 rim)', 55000, Icons.description),
  Produk('Map Plastik', 3000, Icons.folder),
  Produk('Flashdisk 32 GB', 65000, Icons.usb),
  Produk('Kalkulator', 85000, Icons.calculate),
  Produk('Tas Laptop', 150000, Icons.work),
  Produk('Botol Minum', 35000, Icons.local_drink),
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

class AplikasiKoperasi extends StatelessWidget {
  const AplikasiKoperasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const HalamanEtalase(),
    );
  }
}

class HalamanEtalase extends StatelessWidget {
  const HalamanEtalase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Etalase Koperasi')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        // gridDelegate mengatur UKURAN dan JARAK kotak.
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180, // lebar maksimal satu kotak
          mainAxisExtent: 160, // tinggi tetap satu kotak
          mainAxisSpacing: 12, // jarak atas-bawah antarkotak
          crossAxisSpacing: 12, // jarak kiri-kanan antarkotak
        ),
        itemCount: daftarProduk.length,
        itemBuilder: (BuildContext context, int index) {
          return KartuProduk(produk: daftarProduk[index]);
        },
      ),
    );
  }
}

class KartuProduk extends StatelessWidget {
  const KartuProduk({super.key, required this.produk});

  final Produk produk;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Card(
      // Memotong efek riak (ripple) agar tidak keluar dari sudut kartu.
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          final ScaffoldMessengerState pesan = ScaffoldMessenger.of(context);
          pesan.hideCurrentSnackBar();
          pesan.showSnackBar(
            SnackBar(content: Text('${produk.nama} dipilih.')),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: warna.primaryContainer,
                child: Icon(produk.ikon, color: warna.onPrimaryContainer),
              ),
              const SizedBox(height: 8),
              // Nama produk bisa panjang: batasi dua baris, sisanya "...".
              Text(
                produk.nama,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                formatRupiah(produk.harga),
                style: TextStyle(
                  color: warna.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

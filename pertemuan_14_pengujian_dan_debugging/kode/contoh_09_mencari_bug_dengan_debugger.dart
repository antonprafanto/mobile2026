// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 14: PENGUJIAN & DEBUGGING
// CONTOH 09: Mencari Bug dengan Debugger - "Kasir Kantin"
// Topik: Aplikasi kasir kecil ini SENGAJA berisi tiga bug. Temukan
//        penyebabnya dengan alat debugging (modul Bagian 10 dan 11),
//        bukan dengan menebak-nebak. Kerjakan berurutan:
//        Gejala 1 (layar merah): ketuk tombol + pada menu mana pun.
//        Gejala 2 (angka salah, tanpa pesan galat): pesan tepat
//                 Rp50.000, misalnya 2 Nasi Goreng. Diskonnya Rp0,
//                 padahal aturannya "diskon 10% mulai Rp50.000".
//        Gejala 3 (layar tidak berubah): ketik uang yang dibayar.
//                 Kembalian tetap "-", baru berubah setelah tombol
//                 lain diketuk.
// =====================================================================
// CARA MENJALANKAN (dengan debugger):
// 1. Salin seluruh isi berkas ini ke lib/main.dart proyek Flutter.
// 2. Di VS Code tekan F5 (Run > Start Debugging). Pilih Chrome atau
//    emulator Android sebagai perangkat.
// 3. Ikuti langkah di modul Bagian 11.
// Di DartPad aplikasinya juga bisa dijalankan dan gejalanya terlihat,
// tetapi DartPad tidak punya breakpoint.
// =====================================================================

import 'dart:developer' as developer;

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiKasirKantin());
}

// ============================= DATA =============================

class Menu {
  const Menu(this.nama, this.harga);

  final String nama;
  final int harga;
}

const List<Menu> daftarMenu = [
  Menu('Nasi Goreng', 25000),
  Menu('Mie Ayam', 18000),
  Menu('Soto Ayam', 20000),
  Menu('Es Teh', 5000),
  Menu('Jus Jeruk', 12000),
];

/// Satu baris pesanan: menu apa dan berapa porsi.
class BarisPesanan {
  BarisPesanan(this.menu);

  final Menu menu;
  int jumlah = 1;

  int get subtotal => menu.harga * jumlah;
}

// ============================ ATURAN ============================

/// Diskon 10% untuk belanja MINIMAL Rp50.000.
const int batasDiskon = 50000;

int hitungDiskon(int subtotal) {
  if (subtotal > batasDiskon) {
    return subtotal ~/ 10;
  }
  return 0;
}

/// 50000 -> 'Rp50.000'
String rupiah(int nilai) {
  final String angka = nilai.toString();
  final StringBuffer hasil = StringBuffer('Rp');
  for (int i = 0; i < angka.length; i++) {
    // Titik sebelum setiap kelompok tiga angka dari belakang.
    if (i > 0 && (angka.length - i) % 3 == 0) hasil.write('.');
    hasil.write(angka[i]);
  }
  return hasil.toString();
}

/// Teks kembalian. Selama uang belum diisi, tampilkan "-".
String teksKembalian(int dibayar, int total) {
  if (dibayar == 0) return '-';
  if (dibayar < total) return 'uang kurang ${rupiah(total - dibayar)}';
  return rupiah(dibayar - total);
}

// ============================ TAMPILAN ============================

class AplikasiKasirKantin extends StatelessWidget {
  const AplikasiKasirKantin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kasir Kantin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const HalamanKasir(),
    );
  }
}

class HalamanKasir extends StatefulWidget {
  const HalamanKasir({super.key});

  @override
  State<HalamanKasir> createState() => _HalamanKasirState();
}

class _HalamanKasirState extends State<HalamanKasir> {
  final List<BarisPesanan> _pesanan = [];
  final TextEditingController _isianBayar = TextEditingController();
  int _dibayar = 0;

  int get _subtotal {
    int jumlah = 0;
    for (final BarisPesanan baris in _pesanan) {
      jumlah += baris.subtotal;
    }
    return jumlah;
  }

  @override
  void dispose() {
    _isianBayar.dispose();
    super.dispose();
  }

  void _tambah(Menu menu) {
    setState(() {
      final int indeks = _pesanan.indexWhere(
        (BarisPesanan baris) => baris.menu == menu,
      );
      if (indeks == -1) {
        _pesanan.add(BarisPesanan(menu));
      } else {
        _pesanan[indeks].jumlah++;
      }
    });
    // Catatan untuk pengembang. Tampil di Debug Console VS Code, tidak
    // tampil di layar pengguna.
    developer.log(
      'Tambah ${menu.nama}. Baris pesanan: ${_pesanan.length}',
      name: 'kasir',
    );
  }

  void _pesananBaru() {
    setState(() {
      _pesanan.clear();
      _dibayar = 0;
      _isianBayar.clear();
    });
  }

  List<Widget> _barisRincian() {
    final List<Widget> hasil = [];
    for (int i = 0; i <= _pesanan.length; i++) {
      final BarisPesanan baris = _pesanan[i];
      hasil.add(
        ListTile(
          dense: true,
          title: Text('${i + 1}. ${baris.menu.nama} × ${baris.jumlah}'),
          trailing: Text(rupiah(baris.subtotal)),
        ),
      );
    }
    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    final int subtotal = _subtotal;
    final int diskon = hitungDiskon(subtotal);
    final int total = subtotal - diskon;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Kasir Kantin')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Menu', style: gayaTeks.titleMedium),
          for (final Menu menu in daftarMenu)
            ListTile(
              title: Text(menu.nama),
              subtitle: Text(rupiah(menu.harga)),
              trailing: IconButton.filledTonal(
                tooltip: 'Tambah ${menu.nama}',
                onPressed: () => _tambah(menu),
                icon: const Icon(Icons.add),
              ),
            ),
          const Divider(),
          Text('Rincian pesanan', style: gayaTeks.titleMedium),
          if (_pesanan.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('Belum ada pesanan.'),
            )
          else
            ..._barisRincian(),
          const Divider(),
          BarisRingkasan(label: 'Subtotal', nilai: rupiah(subtotal)),
          BarisRingkasan(label: 'Diskon', nilai: rupiah(diskon)),
          BarisRingkasan(label: 'Total', nilai: rupiah(total), tebal: true),
          const SizedBox(height: 16),
          TextField(
            controller: _isianBayar,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Uang dibayar',
              prefixText: 'Rp',
              border: OutlineInputBorder(),
            ),
            onChanged: (String isian) {
              _dibayar = int.tryParse(isian) ?? 0;
            },
          ),
          const SizedBox(height: 8),
          BarisRingkasan(
            label: 'Kembalian',
            nilai: teksKembalian(_dibayar, total),
            tebal: true,
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _pesananBaru,
            icon: const Icon(Icons.refresh),
            label: const Text('Pesanan baru'),
          ),
        ],
      ),
    );
  }
}

/// Satu baris ringkasan: label di kiri, nilai di kanan.
class BarisRingkasan extends StatelessWidget {
  const BarisRingkasan({
    super.key,
    required this.label,
    required this.nilai,
    this.tebal = false,
  });

  final String label;
  final String nilai;
  final bool tebal;

  @override
  Widget build(BuildContext context) {
    final TextStyle? gaya = tebal
        ? Theme.of(context).textTheme.titleMedium
        : null;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: gaya),
          Text(nilai, style: gaya),
        ],
      ),
    );
  }
}

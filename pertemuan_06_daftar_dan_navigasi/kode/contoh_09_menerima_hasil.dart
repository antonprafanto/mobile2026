// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 06: DAFTAR DATA & NAVIGASI
// CONTOH 09: Menerima Hasil dari Halaman yang Ditutup
// Topik: Navigator.push mengembalikan Future. Halaman pertama MENUNGGU
//        (await) sampai halaman kedua ditutup dengan
//        Navigator.pop(context, hasil). Hasilnya bisa null jika
//        pengguna kembali tanpa memilih.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiKirimPaket());
}

const List<String> daftarKota = [
  'Samarinda',
  'Balikpapan',
  'Bontang',
  'Banjarmasin',
  'Makassar',
  'Surabaya',
  'Yogyakarta',
  'Jakarta',
];

class AplikasiKirimPaket extends StatelessWidget {
  const AplikasiKirimPaket({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const HalamanPengiriman(),
    );
  }
}

// ---------- Halaman 1: formulir pengiriman ----------
class HalamanPengiriman extends StatefulWidget {
  const HalamanPengiriman({super.key});

  @override
  State<HalamanPengiriman> createState() => _HalamanPengirimanState();
}

class _HalamanPengirimanState extends State<HalamanPengiriman> {
  String? _kotaTujuan; // null = belum dipilih

  Future<void> _pilihKota() async {
    // <String> = jenis data yang akan DIKEMBALIKAN halaman tujuan.
    final String? kota = await Navigator.push<String>(
      context,
      MaterialPageRoute<String>(
        builder: (BuildContext context) {
          return HalamanPilihKota(terpilih: _kotaTujuan);
        },
      ),
    );

    // Selama menunggu, halaman ini bisa saja sudah ditutup.
    if (!mounted) return;

    if (kota == null) {
      // Pengguna menekan panah kembali tanpa memilih apa pun.
      final ScaffoldMessengerState pesan = ScaffoldMessenger.of(context);
      pesan.hideCurrentSnackBar();
      pesan.showSnackBar(
        const SnackBar(content: Text('Kota tujuan tidak diubah.')),
      );
      return;
    }

    setState(() {
      _kotaTujuan = kota;
    });
  }

  void _kirim(String kota) {
    final ScaffoldMessengerState pesan = ScaffoldMessenger.of(context);
    pesan.hideCurrentSnackBar();
    pesan.showSnackBar(SnackBar(content: Text('Paket dikirim ke $kota.')));
  }

  @override
  Widget build(BuildContext context) {
    // Salin ke variabel lokal agar Dart yakin nilainya tidak null.
    final String? kota = _kotaTujuan;

    return Scaffold(
      appBar: AppBar(title: const Text('Kirim Paket')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.location_city),
                title: const Text('Kota tujuan'),
                subtitle: Text(kota ?? 'Belum dipilih'),
                trailing: const Icon(Icons.chevron_right),
                onTap: _pilihKota,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              // Tombol aktif hanya jika kota sudah dipilih.
              onPressed: kota == null ? null : () => _kirim(kota),
              icon: const Icon(Icons.local_shipping),
              label: const Text('Kirim Paket'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Halaman 2: memilih kota ----------
class HalamanPilihKota extends StatelessWidget {
  const HalamanPilihKota({super.key, required this.terpilih});

  // Kota yang sedang terpilih (boleh null), untuk diberi tanda centang.
  final String? terpilih;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Kota Tujuan')),
      body: ListView.builder(
        itemCount: daftarKota.length,
        itemBuilder: (BuildContext context, int index) {
          final String kota = daftarKota[index];
          return ListTile(
            title: Text(kota),
            trailing: kota == terpilih ? const Icon(Icons.check) : null,
            onTap: () {
              // Tutup halaman ini SAMBIL mengirim kota yang diketuk.
              Navigator.pop(context, kota);
            },
          );
        },
      ),
    );
  }
}

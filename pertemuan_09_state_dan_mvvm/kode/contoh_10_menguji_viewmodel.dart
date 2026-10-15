// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 09: MANAJEMEN STATE & MVVM
// CONTOH 10: Menguji ViewModel Tanpa Menyentuh Layar
// Topik: Karena logika ada di ViewModel, kita bisa memeriksanya dengan
//        memanggil metodenya langsung, lalu membandingkan hasilnya dengan
//        yang diharapkan. Tidak perlu mengetuk tombol satu per satu.
//        Aplikasi ini menjalankan delapan pemeriksaan saat dibuka dan
//        menampilkan hasilnya. SATU pemeriksaan sengaja GAGAL karena ada
//        kesalahan kecil di KeranjangViewModel. Temukan kesalahannya,
//        perbaiki, lalu jalankan ulang sampai semua lulus.
//        Pertemuan 14 membahas cara resminya dengan package:flutter_test.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

// ========================= VIEWMODEL =========================

// Aturan toko: belanja mulai Rp100.000 mendapat diskon 10%.
class KeranjangViewModel extends ChangeNotifier {
  final Map<String, int> _jumlah = {}; // nama barang -> jumlah
  final Map<String, int> _harga = {}; // nama barang -> harga satuan

  int get jumlahBarang {
    int total = 0;
    for (final int jumlah in _jumlah.values) {
      total += jumlah;
    }
    return total;
  }

  int get total {
    int hasil = 0;
    _jumlah.forEach((String nama, int jumlah) {
      hasil += jumlah * _harga[nama]!;
    });
    return hasil;
  }

  int get diskon => total > 100000 ? total ~/ 10 : 0;
  int get bayar => total - diskon;

  void tambah(String nama, int harga) {
    _harga[nama] = harga;
    _jumlah[nama] = (_jumlah[nama] ?? 0) + 1;
    notifyListeners();
  }

  void kurangi(String nama) {
    final int? jumlah = _jumlah[nama];
    if (jumlah == null) {
      return; // barang tidak ada: tidak ada yang berubah
    }
    if (jumlah == 1) {
      _jumlah.remove(nama);
    } else {
      _jumlah[nama] = jumlah - 1;
    }
    notifyListeners();
  }
}

// ======================= PEMERIKSAAN =======================

class HasilUji {
  const HasilUji(this.nama, this.lulus, this.keterangan);

  final String nama;
  final bool lulus;
  final String keterangan;
}

HasilUji periksa(String nama, Object didapat, Object diharapkan) {
  final bool lulus = didapat == diharapkan;
  return HasilUji(
    nama,
    lulus,
    lulus
        ? 'Hasil: $didapat'
        : 'Diharapkan $diharapkan, tetapi hasilnya $didapat',
  );
}

List<HasilUji> jalankanSemuaUji() {
  final List<HasilUji> hasil = [];

  // 1. Keranjang baru harus kosong.
  final KeranjangViewModel baru = KeranjangViewModel();
  hasil.add(periksa('Keranjang baru kosong', baru.jumlahBarang, 0));

  // 2-3. Menambah barang yang sama dua kali.
  final KeranjangViewModel kopi = KeranjangViewModel()
    ..tambah('Kopi', 15000)
    ..tambah('Kopi', 15000);
  hasil.add(periksa('Tambah kopi 2 kali: 2 barang', kopi.jumlahBarang, 2));
  hasil.add(periksa('Total 2 kopi', kopi.total, 30000));

  // 4. Mengurangi sampai habis.
  kopi
    ..kurangi('Kopi')
    ..kurangi('Kopi');
  hasil.add(periksa('Kurangi 2 kali: kosong lagi', kopi.jumlahBarang, 0));

  // 5-6. Diskon di atas dan TEPAT di batas Rp100.000.
  final KeranjangViewModel sepatu = KeranjangViewModel()
    ..tambah('Sepatu', 150000);
  hasil.add(periksa('Diskon belanja Rp150.000', sepatu.diskon, 15000));
  final KeranjangViewModel tas = KeranjangViewModel()..tambah('Tas', 100000);
  hasil.add(periksa('Diskon belanja TEPAT Rp100.000', tas.diskon, 10000));

  // 7-8. Memeriksa kapan notifyListeners() dipanggil.
  final KeranjangViewModel teh = KeranjangViewModel();
  int jumlahPengumuman = 0;
  teh.addListener(() => jumlahPengumuman++);
  teh.kurangi('Teh');
  hasil.add(
    periksa(
      'Kurangi barang yang tidak ada: tanpa pengumuman',
      jumlahPengumuman,
      0,
    ),
  );
  teh.tambah('Teh', 5000);
  hasil.add(periksa('Tambah: tepat 1 pengumuman', jumlahPengumuman, 1));

  for (final KeranjangViewModel vm in [baru, kopi, sepatu, tas, teh]) {
    vm.dispose();
  }
  return hasil;
}

// ============================ VIEW ============================

void main() {
  final List<HasilUji> hasil = jalankanSemuaUji();
  for (final HasilUji uji in hasil) {
    debugPrint('${uji.lulus ? 'LULUS' : 'GAGAL'}  ${uji.nama}');
  }
  runApp(AplikasiUji(hasil: hasil));
}

class AplikasiUji extends StatelessWidget {
  const AplikasiUji({super.key, required this.hasil});

  final List<HasilUji> hasil;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uji ViewModel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: HalamanHasilUji(hasil: hasil),
    );
  }
}

class HalamanHasilUji extends StatelessWidget {
  const HalamanHasilUji({super.key, required this.hasil});

  final List<HasilUji> hasil;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    final int jumlahLulus = hasil.where((HasilUji uji) => uji.lulus).length;
    final bool semuaLulus = jumlahLulus == hasil.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Uji ViewModel')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card.filled(
            color: semuaLulus ? warna.primaryContainer : warna.errorContainer,
            child: ListTile(
              leading: Icon(
                semuaLulus ? Icons.verified : Icons.bug_report,
                color: semuaLulus
                    ? warna.onPrimaryContainer
                    : warna.onErrorContainer,
              ),
              title: Text(
                '$jumlahLulus dari ${hasil.length} uji lulus',
                style: gayaTeks.titleMedium?.copyWith(
                  color: semuaLulus
                      ? warna.onPrimaryContainer
                      : warna.onErrorContainer,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          for (final HasilUji uji in hasil)
            ListTile(
              leading: Icon(
                uji.lulus ? Icons.check_circle : Icons.cancel,
                color: uji.lulus ? warna.primary : warna.error,
              ),
              title: Text(uji.nama),
              subtitle: Text(uji.keterangan),
            ),
        ],
      ),
    );
  }
}

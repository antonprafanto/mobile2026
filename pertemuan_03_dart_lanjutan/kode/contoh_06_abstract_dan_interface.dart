// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 03: DART LANJUTAN
// CONTOH 06: Abstract Class dan Interface
// Topik: Kontrak yang wajib dipenuhi class lain (abstract, implements).
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_06_abstract_dan_interface.dart
// =====================================================================

// abstract class = KONTRAK + kerangka. Tidak bisa dibuat objeknya langsung.
// Setiap metode pengiriman WAJIB punya nama dan cara menghitung ongkir.
abstract class Pengiriman {
  String get nama; // abstrak: tanpa isi, wajib diisi class anak
  int hitungOngkir(int beratKg); // abstrak

  // Method biasa (punya isi) boleh ada di abstract class dan diwarisi.
  void tampilkanOngkir(int beratKg) {
    print('$nama, $beratKg kg: Rp${hitungOngkir(beratKg)}');
  }
}

class Reguler extends Pengiriman {
  @override
  String get nama => 'Reguler (3-5 hari)';

  @override
  int hitungOngkir(int beratKg) => beratKg * 9000;
}

class AmbilSendiri extends Pengiriman {
  @override
  String get nama => 'Ambil di toko';

  @override
  int hitungOngkir(int beratKg) => 0;
}

// Interface: daftar kemampuan. Class yang "implements" WAJIB menulis
// ulang SEMUA anggotanya. Satu class boleh implements banyak interface.
abstract class BisaDilacak {
  String lacak(String nomorResi);
}

class Kilat extends Pengiriman implements BisaDilacak {
  @override
  String get nama => 'Kilat (1 hari)';

  @override
  int hitungOngkir(int beratKg) {
    int ongkir = beratKg * 15000;
    return ongkir < 20000 ? 20000 : ongkir; // ongkir minimal Rp20.000
  }

  @override
  String lacak(String nomorResi) => 'Paket $nomorResi sedang diantar kurir.';
}

void main() {
  // Pengiriman p = Pengiriman(); // ERROR: abstract class tidak bisa dibuat

  // Polimorfisme lagi: semua diperlakukan sebagai Pengiriman.
  List<Pengiriman> pilihan = [Reguler(), Kilat(), AmbilSendiri()];
  for (Pengiriman metode in pilihan) {
    metode.tampilkanOngkir(1);
  }

  Kilat kilat = Kilat();
  kilat.tampilkanOngkir(3);
  print(kilat.lacak('KLT-001'));
}

// OUTPUT:
// Reguler (3-5 hari), 1 kg: Rp9000
// Kilat (1 hari), 1 kg: Rp20000
// Ambil di toko, 1 kg: Rp0
// Kilat (1 hari), 3 kg: Rp45000
// Paket KLT-001 sedang diantar kurir.

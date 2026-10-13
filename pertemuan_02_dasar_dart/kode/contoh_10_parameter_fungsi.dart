// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 02: DASAR PEMROGRAMAN DART
// CONTOH 10: Jenis-Jenis Parameter Fungsi
// Topik: Parameter opsional [ ], parameter bernama { }, required, default.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_10_parameter_fungsi.dart
// =====================================================================

// 1) Parameter posisi opsional: dibungkus [ ] dan boleh tidak diisi.
String perkenalan(String nama, [String? asal]) {
  if (asal == null) {
    return 'Saya $nama.';
  }
  return 'Saya $nama dari $asal.';
}

// 2) Parameter bernama: dibungkus { } dan dipanggil dengan namanya.
//    required = wajib diisi. Yang lain boleh punya nilai bawaan (default).
int hitungTotal({required int harga, int jumlah = 1, int diskonPersen = 0}) {
  int subtotal = harga * jumlah;
  int potongan = subtotal * diskonPersen ~/ 100;
  return subtotal - potongan;
}

// 3) Fungsi juga bisa dikirim sebagai parameter ("titip aksi").
void ulangi(int kali, void Function(int ke) aksi) {
  for (int i = 1; i <= kali; i++) {
    aksi(i);
  }
}

void main() {
  print(perkenalan('Andi'));
  print(perkenalan('Andi', 'Balikpapan'));

  // Parameter bernama: urutannya bebas dan maknanya jelas saat dibaca.
  print('Total 1: Rp${hitungTotal(harga: 15000)}');
  print('Total 2: Rp${hitungTotal(harga: 15000, jumlah: 3)}');
  print('Total 3: Rp${hitungTotal(diskonPersen: 10, harga: 20000, jumlah: 2)}');

  // Fungsi anonim (tanpa nama) dikirim langsung sebagai argumen.
  ulangi(3, (int ke) {
    print('Push-up ke-$ke');
  });
}

// OUTPUT:
// Saya Andi.
// Saya Andi dari Balikpapan.
// Total 1: Rp15000
// Total 2: Rp45000
// Total 3: Rp36000
// Push-up ke-1
// Push-up ke-2
// Push-up ke-3

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 03: DART LANJUTAN
// CONTOH 03: Bentuk Constructor Lainnya
// Topik: const constructor, factory constructor, dan primary constructor
//        (cara ringkas yang baru tersedia di Dart 3.13).
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_03_constructor_lainnya.dart
// =====================================================================

// 1) const constructor: untuk objek yang nilainya pasti dan tidak berubah.
//    Ingat widget Flutter seperti const Text('Halo'): itu memakai
//    constructor const. Syaratnya, semua properti harus final.
class Warna {
  final int merah;
  final int hijau;
  final int biru;

  const Warna(this.merah, this.hijau, this.biru);
}

// 2) factory constructor: constructor yang boleh "berpikir" dulu sebelum
//    membuat objek, misalnya mengolah teks. Pola yang sama nanti dipakai
//    untuk mengubah data JSON dari internet menjadi objek (Pertemuan 10).
class Produk {
  final String nama;
  final int harga;

  Produk(this.nama, this.harga);

  factory Produk.dariTeks(String teks) {
    List<String> bagian = teks.split(';'); // 'Kopi Susu;12000'
    return Produk(bagian[0], int.parse(bagian[1]));
  }
}

// 3) Primary constructor (Dart 3.13 ke atas): properti dan constructor
//    ditulis sekaligus di "kepala" class, cukup satu baris.
//    Kata final di depan parameter berarti "jadikan juga properti final".
class Titik(final int x, final int y);

void main() {
  // const: objek dibuat sekali saja dan dipakai bersama. Dua objek const
  // yang isinya sama adalah objek yang SAMA di memori. Inilah alasan
  // Flutter menyarankan const: menghemat memori dan kerja menggambar ulang.
  const Warna merah1 = Warna(255, 0, 0);
  const Warna merah2 = Warna(255, 0, 0);
  print('merah1 dan merah2 objek yang sama? ${identical(merah1, merah2)}');

  Warna biru1 = Warna(0, 0, 255); // tanpa const -> objek baru
  Warna biru2 = Warna(0, 0, 255);
  print('biru1 dan biru2 objek yang sama? ${identical(biru1, biru2)}');

  Produk kopi = Produk.dariTeks('Kopi Susu;12000');
  print('${kopi.nama}: Rp${kopi.harga}');

  Titik t = Titik(3, 4);
  print('Titik berada di (${t.x}, ${t.y})');
}

// OUTPUT:
// merah1 dan merah2 objek yang sama? true
// biru1 dan biru2 objek yang sama? false
// Kopi Susu: Rp12000
// Titik berada di (3, 4)

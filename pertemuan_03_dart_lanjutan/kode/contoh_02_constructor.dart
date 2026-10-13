// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 03: DART LANJUTAN
// CONTOH 02: Constructor
// Topik: Parameter bernama, required, nilai bawaan, dan named constructor.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_02_constructor.dart
// =====================================================================

class Buku {
  // final: setelah objek dibuat, isinya tidak bisa diubah lagi.
  final String judul;
  final String penulis;
  final int halaman;

  // Constructor dengan parameter BERNAMA, persis seperti widget Flutter.
  // required = wajib diisi. halaman punya nilai bawaan (default) 100.
  Buku({required this.judul, required this.penulis, this.halaman = 100});

  // Named constructor: cara kedua membuat objek, dengan nama yang jelas.
  // ": this(...)" meneruskan pekerjaannya ke constructor utama di atas.
  Buku.anonim(String judul) : this(judul: judul, penulis: 'Anonim');

  void tampilkan() {
    print('"$judul" karya $penulis, $halaman halaman');
  }
}

void main() {
  // Parameter bernama: urutannya bebas dan maknanya jelas saat dibaca.
  Buku buku1 = Buku(
    judul: 'Belajar Flutter Itu Mudah',
    penulis: 'Rina Amelia',
    halaman: 320,
  );
  Buku buku2 = Buku(penulis: 'Budi Santoso', judul: 'Dasar Dart');
  Buku buku3 = Buku.anonim('Hikayat Negeri Awan');

  buku1.tampilkan();
  buku2.tampilkan(); // halaman tidak diisi -> memakai nilai bawaan 100
  buku3.tampilkan();

  // Coba hapus tanda // di depan baris berikut:
  // buku1.judul = 'Judul Lain'; // ERROR: judul bersifat final
  // Buku(judul: 'Tanpa Penulis'); // ERROR: penulis wajib (required)
}

// OUTPUT:
// "Belajar Flutter Itu Mudah" karya Rina Amelia, 320 halaman
// "Dasar Dart" karya Budi Santoso, 100 halaman
// "Hikayat Negeri Awan" karya Anonim, 100 halaman

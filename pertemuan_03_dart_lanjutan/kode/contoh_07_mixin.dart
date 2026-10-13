// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 03: DART LANJUTAN
// CONTOH 07: Mixin
// Topik: Menambahkan "kemampuan" ke beberapa class sekaligus dengan with.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_07_mixin.dart
// =====================================================================

class Hewan {
  final String nama;

  Hewan(this.nama);
}

// mixin = paket kemampuan yang bisa "ditempelkan" ke class mana pun.
// "on Hewan" berarti mixin ini khusus untuk keluarga Hewan, sehingga
// di dalamnya kita boleh memakai properti milik Hewan, yaitu nama.
mixin BisaBerjalan on Hewan {
  void berjalan() {
    print('$nama berjalan dengan kakinya.');
  }
}

mixin BisaBerenang on Hewan {
  void berenang() {
    print('$nama berenang di kolam.');
  }
}

mixin BisaTerbang on Hewan {
  int ketinggianMaks = 100; // mixin juga boleh membawa properti

  void terbang() {
    print('$nama terbang hingga $ketinggianMaks meter.');
  }
}

// Satu class hanya boleh punya SATU induk (extends), tetapi boleh memakai
// BANYAK mixin (with). Bebek bisa berjalan, berenang, dan terbang.
class Bebek extends Hewan with BisaBerjalan, BisaBerenang, BisaTerbang {
  Bebek(super.nama);
}

class Ikan extends Hewan with BisaBerenang {
  Ikan(super.nama);
}

class Elang extends Hewan with BisaTerbang {
  Elang(super.nama) {
    ketinggianMaks = 3000; // menyesuaikan properti dari mixin
  }
}

void main() {
  Bebek kwek = Bebek('Kwek si bebek');
  kwek.berjalan();
  kwek.berenang();
  kwek.terbang();

  Ikan koki = Ikan('Koki si ikan');
  koki.berenang();
  // koki.terbang(); // ERROR: Ikan tidak memakai mixin BisaTerbang

  Elang elang = Elang('Elang Jawa');
  elang.terbang();

  // Objek yang memakai mixin juga dianggap bertipe mixin tersebut.
  List<BisaBerenang> perenang = [kwek, koki];
  print('Jumlah hewan yang bisa berenang: ${perenang.length}');
}

// OUTPUT:
// Kwek si bebek berjalan dengan kakinya.
// Kwek si bebek berenang di kolam.
// Kwek si bebek terbang hingga 100 meter.
// Koki si ikan berenang di kolam.
// Elang Jawa terbang hingga 3000 meter.
// Jumlah hewan yang bisa berenang: 2

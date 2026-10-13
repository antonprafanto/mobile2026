// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 03: DART LANJUTAN
// CONTOH 05: Pewarisan (Inheritance) dan Polimorfisme
// Topik: extends, super, @override, toString(), dan operator is.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_05_pewarisan.dart
// =====================================================================

// Class INDUK (parent / superclass): sifat umum semua hewan.
class Hewan {
  final String nama;

  Hewan(this.nama);

  void bersuara() {
    print('$nama mengeluarkan suara.');
  }

  // toString() menentukan tulisan yang muncul saat objek di-print.
  // Semua class di Dart mewarisi toString() dari class Object.
  @override
  String toString() => 'Hewan bernama $nama';
}

// Class ANAK (child / subclass): mewarisi semua isi Hewan, lalu
// menambah atau mengganti perilakunya sendiri.
class Kucing extends Hewan {
  // super.nama = "teruskan nama ini ke constructor induk".
  Kucing(super.nama);

  // @override = "saya sengaja MENGGANTI method milik induk".
  @override
  void bersuara() {
    print('$nama: Meong!');
  }
}

class Burung extends Hewan {
  final bool bisaBicara;

  Burung(super.nama, {this.bisaBicara = false});

  @override
  void bersuara() {
    super.bersuara(); // jalankan dulu versi milik induk
    if (bisaBicara) {
      print('$nama: Halo, apa kabar?');
    }
  }

  // Method tambahan yang hanya dimiliki burung.
  void terbang() {
    print('$nama terbang tinggi.');
  }
}

void main() {
  Kucing oyen = Kucing('Oyen');
  Burung kiki = Burung('Kiki', bisaBicara: true);

  oyen.bersuara();
  kiki.bersuara();
  kiki.terbang();
  print(oyen); // memakai toString() yang diwarisi dari Hewan

  // POLIMORFISME: satu daftar bertipe Hewan berisi berbagai jenis hewan.
  // Perintahnya sama (bersuara), tetapi hasilnya menyesuaikan jenisnya.
  List<Hewan> kebunBinatang = [oyen, kiki, Hewan('Sapi')];
  print('--- Semua hewan bersuara ---');
  for (Hewan hewan in kebunBinatang) {
    hewan.bersuara();
  }

  // Operator is: memeriksa jenis sebuah objek. Setelah dicek, Dart
  // mengizinkan kita memanggil method khusus jenis tersebut.
  print('--- Siapa yang bisa terbang? ---');
  for (Hewan hewan in kebunBinatang) {
    if (hewan is Burung) {
      hewan.terbang();
    } else {
      print('${hewan.nama} tidak bisa terbang.');
    }
  }
}

// OUTPUT:
// Oyen: Meong!
// Kiki mengeluarkan suara.
// Kiki: Halo, apa kabar?
// Kiki terbang tinggi.
// Hewan bernama Oyen
// --- Semua hewan bersuara ---
// Oyen: Meong!
// Kiki mengeluarkan suara.
// Kiki: Halo, apa kabar?
// Sapi mengeluarkan suara.
// --- Siapa yang bisa terbang? ---
// Oyen tidak bisa terbang.
// Kiki terbang tinggi.
// Sapi tidak bisa terbang.

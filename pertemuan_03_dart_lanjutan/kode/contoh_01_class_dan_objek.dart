// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 03: DART LANJUTAN
// CONTOH 01: Class dan Objek
// Topik: Class sebagai cetakan, objek sebagai hasil cetakan.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_01_class_dan_objek.dart
// =====================================================================

// Class = CETAKAN. Di sini kita menentukan "seperti apa" seorang
// mahasiswa: punya data (properti) dan bisa melakukan sesuatu (method).
// Nama class memakai gaya UpperCamelCase: huruf pertama kapital.
class Mahasiswa {
  // Properti (field): data yang dimiliki SETIAP objek mahasiswa.
  String nama;
  String nim;
  int semester;

  // Constructor: "mesin pencetak" yang mengisi properti saat objek dibuat.
  // this.nama artinya "isi properti nama dengan nilai yang dikirim".
  Mahasiswa(this.nama, this.nim, this.semester);

  // Method: perilaku atau aksi yang bisa dilakukan objek.
  void perkenalan() {
    print('Halo, saya $nama (NIM $nim), semester $semester.');
  }

  void naikSemester() {
    semester++;
  }
}

void main() {
  // Objek = HASIL CETAKAN. Satu cetakan bisa menghasilkan banyak objek.
  Mahasiswa andi = Mahasiswa('Andi', '2609106001', 1);
  Mahasiswa sari = Mahasiswa('Sari', '2609106002', 3);

  // Memanggil method memakai tanda titik (.)
  andi.perkenalan();
  sari.perkenalan();

  // Setiap objek menyimpan datanya sendiri-sendiri.
  andi.naikSemester();
  print('Setelah naik semester, ${andi.nama} di semester ${andi.semester}.');
  print('${sari.nama} tetap di semester ${sari.semester}.');

  // Properti juga bisa dibaca dan diubah memakai tanda titik.
  sari.nama = 'Sari Wulandari';
  sari.perkenalan();
}

// OUTPUT:
// Halo, saya Andi (NIM 2609106001), semester 1.
// Halo, saya Sari (NIM 2609106002), semester 3.
// Setelah naik semester, Andi di semester 2.
// Sari tetap di semester 3.
// Halo, saya Sari Wulandari (NIM 2609106002), semester 3.

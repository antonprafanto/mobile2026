// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 02: DASAR PEMROGRAMAN DART
// CONTOH 02: Variabel dan Tipe Data
// Topik: String, int, double, bool, num, var, dan konversi tipe.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run 02_variabel_dan_tipe_data.dart
// =====================================================================

void main() {
  // 1) Variabel = "kotak berlabel" untuk menyimpan data.
  //    Format: TipeData namaVariabel = nilai;
  String nama = 'Siti Aminah'; // teks
  int umur = 19; // bilangan bulat
  double ipk = 3.75; // bilangan desimal (pakai titik, bukan koma!)
  bool sudahLulus = false; // hanya true atau false

  print('Nama        : $nama');
  print('Umur        : $umur tahun');
  print('IPK         : $ipk');
  print('Sudah lulus : $sudahLulus');

  // 2) var: Dart menebak tipenya sendiri dari nilai awal.
  var kota = 'Samarinda'; // otomatis menjadi String
  var semester = 3; // otomatis menjadi int
  print('$kota, semester $semester');

  // 3) Nilai boleh diganti, tetapi TIPENYA tidak boleh berubah.
  umur = 20;
  // umur = 'dua puluh'; // ERROR: teks tidak bisa masuk kotak int
  print('Umur tahun depan: $umur');

  // 4) num bisa menampung int maupun double.
  num suhu = 30;
  suhu = 30.5;
  print('Suhu hari ini: $suhu derajat');

  // 5) Konversi tipe data.
  int tahun = int.parse('2026'); // teks -> int
  double tinggi = double.parse('165.5'); // teks -> double
  String teksIpk = ipk.toString(); // double -> teks
  print('Tahun depan: ${tahun + 1}');
  print('Tinggi badan: $tinggi cm');
  print('IPK dalam bentuk teks: $teksIpk');
  print('Satu angka di belakang koma: ${ipk.toStringAsFixed(1)}');
}

// OUTPUT:
// Nama        : Siti Aminah
// Umur        : 19 tahun
// IPK         : 3.75
// Sudah lulus : false
// Samarinda, semester 3
// Umur tahun depan: 20
// Suhu hari ini: 30.5 derajat
// Tahun depan: 2027
// Tinggi badan: 165.5 cm
// IPK dalam bentuk teks: 3.75
// Satu angka di belakang koma: 3.8

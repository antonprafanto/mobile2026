// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 02: DASAR PEMROGRAMAN DART
// CONTOH 06: Operator
// Topik: Aritmatika, penugasan, perbandingan, logika, dan kondisional.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run 06_operator.dart
// =====================================================================

void main() {
  int a = 17;
  int b = 5;

  // 1) Aritmatika
  print('$a + $b = ${a + b}');
  print('$a - $b = ${a - b}');
  print('$a * $b = ${a * b}');
  print('$a / $b = ${a / b}'); // pembagian biasa, hasilnya double
  print('$a ~/ $b = ${a ~/ b}'); // pembagian bulat, desimalnya dibuang
  print('$a % $b = ${a % b}'); // sisa bagi (modulo)

  // 2) Penugasan gabungan dan increment
  int skor = 10;
  skor += 5; // sama dengan: skor = skor + 5  -> 15
  skor *= 2; // sama dengan: skor = skor * 2  -> 30
  skor++; //    tambah 1                      -> 31
  print('Skor akhir: $skor');

  // 3) Perbandingan: hasilnya selalu bool (true / false)
  print('a == b : ${a == b}'); // sama dengan
  print('a != b : ${a != b}'); // tidak sama dengan
  print('a > b  : ${a > b}');
  print('a <= 17: ${a <= 17}');

  // 4) Logika: && (DAN), || (ATAU), ! (BUKAN)
  int sksLulus = 110;
  int tunggakanUkt = 500000;
  bool sksCukup = sksLulus >= 100; // true
  bool sudahLunas = tunggakanUkt == 0; // false
  print('Boleh daftar sidang? ${sksCukup && sudahLunas}');
  print('Minimal satu syarat terpenuhi? ${sksCukup || sudahLunas}');
  print('Masih ada tunggakan? ${!sudahLunas}');

  // 5) Operator kondisional: kondisi ? nilaiJikaBenar : nilaiJikaSalah
  int nilai = 78;
  String status = nilai >= 60 ? 'LULUS' : 'TIDAK LULUS';
  print('Nilai $nilai -> $status');
}

// OUTPUT:
// 17 + 5 = 22
// 17 - 5 = 12
// 17 * 5 = 85
// 17 / 5 = 3.4
// 17 ~/ 5 = 3
// 17 % 5 = 2
// Skor akhir: 31
// a == b : false
// a != b : true
// a > b  : true
// a <= 17: true
// Boleh daftar sidang? false
// Minimal satu syarat terpenuhi? true
// Masih ada tunggakan? true
// Nilai 78 -> LULUS

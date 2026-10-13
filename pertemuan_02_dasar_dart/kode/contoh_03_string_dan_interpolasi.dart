// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 02: DASAR PEMROGRAMAN DART
// CONTOH 03: String dan Interpolasi
// Topik: Menyisipkan nilai ke teks dan method String yang sering dipakai.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_03_string_dan_interpolasi.dart
// =====================================================================

void main() {
  String namaDepan = 'Budi';
  String namaBelakang = 'Santoso';

  // 1) Interpolasi: sisipkan isi variabel dengan $namaVariabel
  print('Halo, $namaDepan!');

  // 2) Sisipkan EKSPRESI (perhitungan / pemanggilan method) dengan ${...}
  print('Nama lengkap: ${namaDepan.toUpperCase()} $namaBelakang');
  print('Panjang nama depan: ${namaDepan.length} huruf');
  print('5 x 4 = ${5 * 4}');

  // 3) Tanda kutip di dalam teks
  print("Jum'at berkah"); // kutip ganda jika teks berisi kutip tunggal
  print('Ia berkata, "Siap!"'); // kutip tunggal jika berisi kutip ganda

  // 4) Teks beberapa baris memakai tiga tanda kutip
  String alamat = '''
Jl. Pahlawan No. 1
Samarinda, Kalimantan Timur''';
  print(alamat);

  // 5) Method String yang sering dipakai
  String kalimat = '  Belajar Flutter itu seru  ';
  print('[${kalimat.trim()}]'); // hapus spasi di awal dan akhir
  print(kalimat.trim().toLowerCase()); // huruf kecil semua
  print(kalimat.contains('Flutter')); // apakah mengandung kata?
  print(kalimat.trim().replaceAll('seru', 'asyik')); // ganti kata
  print('Flutter'.substring(0, 3)); // ambil huruf indeks 0 sampai 2
  print('Apel,Mangga,Jeruk'.split(',')); // pecah menjadi daftar
}

// OUTPUT:
// Halo, Budi!
// Nama lengkap: BUDI Santoso
// Panjang nama depan: 4 huruf
// 5 x 4 = 20
// Jum'at berkah
// Ia berkata, "Siap!"
// Jl. Pahlawan No. 1
// Samarinda, Kalimantan Timur
// [Belajar Flutter itu seru]
// belajar flutter itu seru
// true
// Belajar Flutter itu asyik
// Flu
// [Apel, Mangga, Jeruk]

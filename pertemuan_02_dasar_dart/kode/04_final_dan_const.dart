// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 02: DASAR PEMROGRAMAN DART
// CONTOH 04: final dan const
// Topik: Variabel yang nilainya tidak boleh diubah setelah diisi.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run 04_final_dan_const.dart
// =====================================================================

// Konstanta di luar fungsi (tingkat atas) memakai const.
const int jumlahHariSeminggu = 7;
const double nilaiPi = 3.14;

void main() {
  // final: diisi SEKALI ketika program berjalan, lalu terkunci.
  // Cocok untuk nilai yang baru diketahui saat program jalan.
  final DateTime waktuMulai = DateTime.now();
  final String namaPengguna = 'Rina';

  // const: nilainya sudah pasti SEBELUM program berjalan.
  // Cocok untuk nilai tetap seperti batas nilai atau daftar hari.
  const int nilaiMaksimal = 100;
  const List<String> hariKuliah = ['Senin', 'Rabu', 'Jumat'];

  print('Pengguna    : $namaPengguna');
  print('Tahun mulai : ${waktuMulai.year}');
  print('Seminggu ada $jumlahHariSeminggu hari');
  print('Nilai maksimal ujian: $nilaiMaksimal');
  print('Keliling lingkaran r=10: ${(2 * nilaiPi * 10).toStringAsFixed(2)}');
  print('Kuliah pertama hari ${hariKuliah[0]}');

  // Coba hapus tanda // di depan baris berikut satu per satu:
  // namaPengguna = 'Andi';         // ERROR: final tidak bisa diubah
  // const waktu = DateTime.now();  // ERROR: nilainya baru ada saat berjalan
  // hariKuliah.add('Kamis');       // GAGAL saat berjalan: list const terkunci
}

// OUTPUT (tahun mengikuti tanggal di komputer Anda):
// Pengguna    : Rina
// Tahun mulai : 2026
// Seminggu ada 7 hari
// Nilai maksimal ujian: 100
// Keliling lingkaran r=10: 62.80
// Kuliah pertama hari Senin

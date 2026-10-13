// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 02: DASAR PEMROGRAMAN DART
// CONTOH 09: Fungsi Dasar
// Topik: Membuat fungsi, parameter, nilai kembali (return), fungsi panah.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run 09_fungsi_dasar.dart
// =====================================================================

// 1) Fungsi tanpa nilai kembali: diawali kata void ("tidak mengembalikan").
void sapa(String nama) {
  print('Halo, $nama! Selamat datang di kelas Mobile.');
}

// 2) Fungsi dengan nilai kembali: tipe hasilnya ditulis di depan nama.
int tambah(int a, int b) {
  return a + b; // return = "serahkan hasil ini ke pemanggil"
}

// 3) Fungsi panah (=>): ringkasan untuk fungsi yang isinya SATU ekspresi.
double luasPersegiPanjang(double panjang, double lebar) => panjang * lebar;

bool apakahLulus(int nilai) => nilai >= 60;

// 4) Fungsi boleh memanggil fungsi lain.
String predikat(int nilai) {
  if (apakahLulus(nilai)) {
    return 'Lulus';
  }
  return 'Mengulang';
}

void main() {
  sapa('Rizky');
  sapa('Nadia');

  int hasil = tambah(7, 8);
  print('7 + 8 = $hasil');
  print('Luas lahan 12.5 x 8: ${luasPersegiPanjang(12.5, 8)} m2');
  print('Nilai 75 -> ${predikat(75)}');
  print('Nilai 40 -> ${predikat(40)}');
}

// OUTPUT:
// Halo, Rizky! Selamat datang di kelas Mobile.
// Halo, Nadia! Selamat datang di kelas Mobile.
// 7 + 8 = 15
// Luas lahan 12.5 x 8: 100 m2   (di terminal `dart run`: 100.0 m2)
// Nilai 75 -> Lulus
// Nilai 40 -> Mengulang

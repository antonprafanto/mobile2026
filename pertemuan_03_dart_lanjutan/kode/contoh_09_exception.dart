// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 03: DART LANJUTAN
// CONTOH 09: Menangani Error dengan Exception
// Topik: try, on, catch, finally, throw, dan exception buatan sendiri.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_09_exception.dart
// =====================================================================

// Exception buatan sendiri: nama yang jelas memudahkan penanganannya.
class SaldoTidakCukupException implements Exception {
  final int kekurangan;

  SaldoTidakCukupException(this.kekurangan);

  @override
  String toString() => 'Saldo kurang Rp$kekurangan';
}

int tarikTunai(int saldo, int jumlah) {
  if (jumlah > saldo) {
    // throw = "lempar" masalah ke pemanggil fungsi ini.
    throw SaldoTidakCukupException(jumlah - saldo);
  }
  return saldo - jumlah;
}

int bacaUmur(String teks) {
  try {
    return int.parse(teks);
  } on FormatException {
    // on = tangkap HANYA jenis error tertentu.
    print('"$teks" bukan angka. Umur dianggap 0.');
    return 0;
  }
}

void main() {
  // 1) Menangkap jenis error bawaan Dart.
  print('Umur: ${bacaUmur('19')}');
  print('Umur: ${bacaUmur('sembilan belas')}');

  // 2) Menangkap exception buatan sendiri, lalu finally.
  //    finally SELALU dijalankan, baik berhasil maupun gagal.
  try {
    int sisa = tarikTunai(50000, 20000);
    print('Penarikan berhasil, sisa saldo Rp$sisa');
    sisa = tarikTunai(sisa, 80000);
    print('Baris ini tidak akan pernah dicetak.');
  } on SaldoTidakCukupException catch (e) {
    // catch (e) = simpan objek error ke variabel e agar bisa dibaca.
    print('Penarikan gagal: $e');
  } finally {
    print('Struk transaksi dicetak.');
  }

  // 3) catch tanpa on: menangkap SEMUA jenis error.
  try {
    List<String> antrean = ['Andi', 'Budi'];
    print(antrean[5]);
  } catch (e) {
    print('Terjadi kesalahan saat membaca antrean.');
  }

  print('Program tetap berjalan sampai selesai.');
}

// OUTPUT:
// Umur: 19
// "sembilan belas" bukan angka. Umur dianggap 0.
// Umur: 0
// Penarikan berhasil, sisa saldo Rp30000
// Penarikan gagal: Saldo kurang Rp50000
// Struk transaksi dicetak.
// Terjadi kesalahan saat membaca antrean.
// Program tetap berjalan sampai selesai.

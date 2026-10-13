// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 02: DASAR PEMROGRAMAN DART
// CONTOH 05: Null Safety
// Topik: Tipe nullable (?), operator ??, ?., ??=, dan ! (tanda seru).
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_05_null_safety.dart
// =====================================================================

// Fungsi kecil (fungsi dibahas di Contoh 09) yang mengembalikan nama
// panggilan seorang mahasiswa, atau null jika ia tidak mengisinya.
// Perhatikan tanda ? pada String? : hasilnya BOLEH null.
String? cariNamaPanggilan(String nama) {
  if (nama == 'Wahyuni') {
    return 'Yuyun';
  }
  return null;
}

// Mengembalikan ibu kota provinsi, atau null jika provinsi tidak dikenal.
String? cariKota(String provinsi) {
  if (provinsi == 'Kalimantan Timur') {
    return 'Samarinda';
  }
  return null;
}

void main() {
  // 1) Variabel biasa TIDAK BOLEH berisi null (kosong).
  String nama = 'Dewi';
  // nama = null; // ERROR: kotak String tidak boleh kosong

  // 2) Tambahkan tanda ? agar BOLEH null (nullable).
  String? panggilanDewi = cariNamaPanggilan('Dewi'); // Dewi tidak mengisi
  String? panggilanYuni = cariNamaPanggilan('Wahyuni'); // berisi 'Yuyun'
  print('Panggilan Dewi: $panggilanDewi');
  print('Panggilan Wahyuni: $panggilanYuni');

  // 3) ?? artinya "jika null, pakai nilai cadangan".
  print('Halo, ${panggilanDewi ?? nama}!');
  print('Halo, ${panggilanYuni ?? 'Wahyuni'}!');

  // 4) ?. artinya "panggil hanya jika tidak null".
  //    Jika null, hasilnya null (bukan error yang membuat program berhenti).
  print('Panjang panggilan Dewi: ${panggilanDewi?.length}');
  print('Panjang panggilan Wahyuni: ${panggilanYuni?.length}');

  // 5) ??= artinya "isi hanya jika masih null".
  panggilanDewi ??= 'Dede';
  print('Panggilan Dewi sekarang: $panggilanDewi');

  // 6) Contoh nyata: int.tryParse() menghasilkan int? (null jika gagal).
  int? umur = int.tryParse('dua puluh');
  print('Umur: ${umur ?? 0}');

  // 7) ! artinya "saya JAMIN tidak null". Berbahaya jika ternyata null!
  String? kota = cariKota('Kalimantan Timur');
  print('Jumlah huruf nama kota: ${kota!.length}');
  // print(cariKota('Bali')!.length); // ERROR saat berjalan: hasilnya null
}

// OUTPUT:
// Panggilan Dewi: null
// Panggilan Wahyuni: Yuyun
// Halo, Dewi!
// Halo, Yuyun!
// Panjang panggilan Dewi: null
// Panjang panggilan Wahyuni: 5
// Panggilan Dewi sekarang: Dede
// Umur: 0
// Jumlah huruf nama kota: 9

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 02: DASAR PEMROGRAMAN DART
// CONTOH 07: Percabangan
// Topik: if-else if-else, switch (pernyataan), dan switch (ekspresi).
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_07_percabangan.dart
// =====================================================================

void main() {
  int nilai = 82;

  // 1) if - else if - else
  //    Diperiksa dari atas ke bawah; berhenti di kondisi PERTAMA yang benar.
  String huruf;
  if (nilai >= 85) {
    huruf = 'A';
  } else if (nilai >= 70) {
    huruf = 'B';
  } else if (nilai >= 55) {
    huruf = 'C';
  } else if (nilai >= 40) {
    huruf = 'D';
  } else {
    huruf = 'E';
  }
  print('Nilai $nilai -> huruf $huruf');

  // 2) switch (pernyataan): memilih satu dari beberapa nilai pasti.
  //    Dua case yang ditulis berurutan tanpa isi akan berbagi isi yang sama.
  String hari = 'Sabtu';
  switch (hari) {
    case 'Sabtu':
    case 'Minggu':
      print('$hari: libur kuliah');
    case 'Jumat':
      print('$hari: kuliah selesai sebelum salat Jumat');
    default:
      print('$hari: kuliah seperti biasa');
  }

  // 3) switch (ekspresi), gaya Dart 3: ringkas dan langsung menghasilkan nilai.
  String keterangan = switch (huruf) {
    'A' => 'Sangat baik',
    'B' => 'Baik',
    'C' => 'Cukup',
    _ => 'Perlu perbaikan', // _ berarti "selain semua pilihan di atas"
  };
  print('Keterangan: $keterangan');
}

// OUTPUT:
// Nilai 82 -> huruf B
// Sabtu: libur kuliah
// Keterangan: Baik

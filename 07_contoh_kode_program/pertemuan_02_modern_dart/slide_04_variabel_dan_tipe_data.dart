// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 04: VARIABEL & TIPE DATA MODERN
// TOPIK: Eksplorasi int, double, String, bool, var, final, vs const
// =====================================================================
// CARA MENJALANKAN:
// 1. Lewat Terminal: dart run slide_04_variabel_dan_tipe_data.dart
// 2. Lewat Browser : salin ke https://dartpad.dev lalu klik "Run"
// =====================================================================

void main() {
  print('=== EKSPLORASI TIPE DATA DART ===');

  // 1. Tipe Data Eksplisit
  int jumlahSks = 20;
  double ipkTarget = 3.85;
  String mataKuliah = 'Pemrograman Piranti Bergerak';
  bool isLulusTeori = true;

  print('Mata Kuliah : $mataKuliah');
  print('Beban SKS   : $jumlahSks SKS');
  print('Target IPK  : $ipkTarget');
  print('Status Lulus: $isLulusTeori');
  print('');

  // 2. Kata Kunci "var" (Type Inference otomatis)
  var namaDosen = 'Pak Anton'; // Dart otomatis mendeteksi tipe String
  print('Dosen Pengampu: $namaDosen (Tipe: ${namaDosen.runtimeType})');
  print('');

  // 3. Perbedaan Vital: "final" vs "const"
  // final: Nilai dikunci saat program berjalan (runtime). Contoh: waktu sekarang.
  final waktuAksesRuntime = DateTime.now();

  // const: Nilai mutlak sudah pasti sejak sebelum kompilasi (compile-time).
  const double tarifPajak = 0.11; // PPN 11%

  print('final (Runtime)   : Jam Akses = $waktuAksesRuntime');
  print('const (Compile)   : Tarif PPN = ${tarifPajak * 100}%');
  print('');
  print('💡 PERATURAN EMAS DI FLUTTER:');
  print(
    'Gunakan "const" sebanyak mungkin pada Widget statis agar aplikasi super hemat RAM!',
  );
}

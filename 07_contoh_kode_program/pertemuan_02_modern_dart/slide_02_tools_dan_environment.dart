// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 02: TEMPAT MENGUJI KODE DART (TOOLS)
// TOPIK: Menjalankan Program Dart di Terminal Lokal & DartPad Browser
// =====================================================================
// CARA MENJALANKAN:
// 1. Lewat Terminal Lokal:
//    Buka terminal (Ctrl + ~), lalu ketik:
//    dart run slide_02_tools_dan_environment.dart
// 2. Lewat Browser (Tanpa Install):
//    Salin kode ini dan buka: https://dartpad.dev
//    Tempelkan kode lalu tekan tombol "Run"!
// =====================================================================

void main() {
  print('======================================================');
  print('✦ SELAMAT DATANG DI LABORATORIUM MODERN DART 2026 ✦');
  print('======================================================');

  final waktuSekarang = DateTime.now();
  const namaBahasa = 'Dart SDK';
  const targetFramework = 'Flutter Mobile';

  print('Bahasa Pemrograman : $namaBahasa');
  print('Target Framework   : $targetFramework');
  print('Waktu Eksekusi     : $waktuSekarang');
  print('');
  print('💡 TIPS MAHASISWA:');
  print(
    '• Jika laptop terasa berat, Anda bisa menggunakan https://dartpad.dev',
  );
  print(
    '• Jika menggunakan VS Code, pasang ekstensi resmi "Dart" & "Flutter".',
  );
  print('======================================================');
}

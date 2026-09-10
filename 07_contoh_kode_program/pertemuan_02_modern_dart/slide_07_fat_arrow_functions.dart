// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 07: FAT ARROW FUNCTIONS (=>)
// TOPIK: Menyederhanakan Fungsi 1 Baris Menjadi Bersih & Elegan
// =====================================================================
// CARA MENJALANKAN:
// 1. Lewat Terminal: dart run slide_07_fat_arrow_functions.dart
// 2. Lewat Browser : salin ke https://dartpad.dev lalu klik "Run"
// =====================================================================

// 1. Cara Konvensional (Menggunakan { return ...; }):
int luasPersegiPanjangTradisional(int panjang, int lebar) {
  return panjang * lebar;
}

// 2. Cara Modern Dart (Fat Arrow =>):
int luasPersegiPanjang(int panjang, int lebar) => panjang * lebar;

// 3. Fungsi boolean kondisi:
bool isNilaiCumlaude(double ipk) => ipk >= 3.50;

// 4. Fungsi pemformat teks:
String sapaMahasiswa(String nama) => 'Halo, Saudara $nama! Selamat ngoding.';

void main() {
  print('=== DEMO FAT ARROW FUNCTIONS (=>) ===');

  final p = 12;
  final l = 5;

  print('Hitung Luas Persegi ($p x $l):');
  print('• Hasil Tradisional : ${luasPersegiPanjangTradisional(p, l)} m2');
  print('• Hasil Fat Arrow   : ${luasPersegiPanjang(p, l)} m2');
  print('');

  final ipkSaya = 3.78;
  print('Cek Predikat IPK $ipkSaya:');
  print(
    '• Apakah Cumlaude? : ${isNilaiCumlaude(ipkSaya) ? "YA, SELAMAT!" : "BELUM"}',
  );
  print('');

  print(sapaMahasiswa('Budi Santoso'));
  print('');
  print('💡 DI FLUTTER:');
  print(
    'Fat arrow sangat sering digunakan saat menulis Event Handler, misalnya:',
  );
  print('onPressed: () => print("Tombol diklik!")');
}

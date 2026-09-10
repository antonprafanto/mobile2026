// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 05: SOUND NULL SAFETY (DASAR)
// TOPIK: Perbedaan Variabel Non-Nullable (Wajib Ada) vs Nullable (?)
// =====================================================================
// CARA MENJALANKAN:
// 1. Lewat Terminal: dart run slide_05_sound_null_safety.dart
// 2. Lewat Browser : salin ke https://dartpad.dev lalu klik "Run"
// =====================================================================

void main() {
  print('=== SIMULASI SOUND NULL SAFETY ===');

  // 1. NON-NULLABLE (Bawaan Standar):
  // Variabel ini WAJIB memiliki nilai valid. Kompilator menolak keras nilai null!
  String namaLengkap = 'Ahmad Fauzi';
  int nim = 2210511001;

  print('Identitas Mahasiswa:');
  print('• Nama : $namaLengkap');
  print('• NIM  : $nim');
  print('');

  // 2. NULLABLE TYPE (Ditandai Tanda Tanya ?):
  // Variabel ini ibarat kotak bekal yang BOLEH kosong (bernilai null).
  String? nomorTeleponDarurat; // Awalnya berisi null
  String? riwayatAlergi;

  print('Data Kontak Darurat:');
  print(
    '• No. Darurat : $nomorTeleponDarurat',
  ); // Tercetak: null (aman, tidak crash!)
  print('• Riwayat     : $riwayatAlergi'); // Tercetak: null

  // Mengisi variabel nullable jika pengguna menginput data:
  nomorTeleponDarurat = '+62 812-3456-7890';
  riwayatAlergi = 'Alergi debu & kacang';

  print('');
  print('Setelah Mahasiswa Mengisi Profil:');
  print('• No. Darurat : $nomorTeleponDarurat');
  print('• Riwayat     : $riwayatAlergi');
  print('');
  print('💡 KESIMPULAN:');
  print('Dengan Sound Null Safety, aplikasi Flutter Anda 100% bebas dari');
  print(
    'galat legendaris "NullPointerException" yang sering memicu force close!',
  );
}

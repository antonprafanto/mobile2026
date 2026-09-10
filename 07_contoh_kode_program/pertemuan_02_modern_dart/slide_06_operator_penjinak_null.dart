// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 06: OPERATOR PENJINAK NULL
// TOPIK: Menguasai Operator ?. (Safe Access), ?? (Fallback), dan late
// =====================================================================
// CARA MENJALANKAN:
// 1. Lewat Terminal: dart run slide_06_operator_penjinak_null.dart
// 2. Lewat Browser : salin ke https://dartpad.dev lalu klik "Run"
// =====================================================================

void main() {
  print('=== OPERATOR PENJINAK NULL DART ===');

  // Helper simulasi data dari API/database:
  String? ambilEmailDariDatabase(bool ada) =>
      ada ? 'budi@kampus.ac.id' : null;

  // Data simulasi pengguna yang baru mendaftar (bisa null atau ada nilai):
  String? bioProfil; // null
  String? emailUser = ambilEmailDariDatabase(false); // null saat ini

  // 1. Operator ?. (Safe Navigation / Safe Call)
  print('1. Safe Access (?.):');
  print('Panjang email: ${emailUser?.length}'); // output: null (aman, tidak crash!)
  print('');

  // 2. Operator ?? (If-Null / Default Fallback)
  print('2. Fallback Nilai Default (??):');
  String tampilanBio = bioProfil ?? 'Pengguna ini belum menuliskan bio.';
  String tampilanEmail = emailUser ?? 'email.pribadi@anonim.com';

  print('Bio Mahasiswa  : $tampilanBio');
  print('Email Terdaftar: $tampilanEmail');
  print('');

  // 3. Operator ??= (Assign if null)
  String? kotaAsal;
  kotaAsal ??= 'Jakarta (Default)';
  print('3. Operator ??= : Kota Asal = $kotaAsal');
  print('');

  // 4. Kata Kunci "late" (Janji Pengisian Nanti)
  print('4. Kata Kunci late:');
  late String tokenOtentikasi;
  tokenOtentikasi = 'JWT-TOKEN-SECRET-12345';
  print('Token berhasil diinisialisasi: $tokenOtentikasi');
  print('');
  print('💡 PERINGATAN:');
  print(
    'Hindari memakai tanda seru (!) alias force unwrap jika tidak 100% yakin,',
  );
  print('karena jika variabel ternyata null, aplikasi akan langsung crash!');
}

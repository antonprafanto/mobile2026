// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 14: FUTURE, ASYNC, AWAIT, & TRY-CATCH
// TOPIK: Mengunduh Data dari Cloud Server & Menangani Error Jaringan
// =====================================================================
// CARA MENJALANKAN:
// 1. Lewat Terminal: dart run slide_14_future_async_await.dart
// 2. Lewat Browser : salin ke https://dartpad.dev lalu klik "Run"
// =====================================================================

Future<Map<String, dynamic>> fetchProfilDariServer(int idMahasiswa) async {
  print(
    '  📡 Mengirim paket HTTP GET ke https://api.kampus.ac.id/user/$idMahasiswa...',
  );

  await Future.delayed(const Duration(seconds: 2));

  if (idMahasiswa <= 0) {
    throw Exception(
      '404 NOT FOUND: ID Mahasiswa tidak terdaftar di pangkalan data!',
    );
  }

  return {
    'status': 200,
    'id': idMahasiswa,
    'nama': 'M. Rizky Ramadhan',
    'prodi': 'Teknik Informatika',
    'ipk': 3.92,
  };
}

Future<void> main() async {
  print('=== DEMO ASINKRON: FUTURE & ASYNC / AWAIT ===');
  print('');

  // SKENARIO 1: Pengambilan Data Berhasil
  print('>>> UJI COBA 1: Mengambil Data Mahasiswa ID #42...');
  try {
    final hasil = await fetchProfilDariServer(42);
    print('  ✅ Data Diterima Sukses:');
    print('     • Nama Mahasiswa : ${hasil["nama"]}');
    print('     • Program Studi  : ${hasil["prodi"]}');
    print('     • Nilai IPK      : ${hasil["ipk"]}');
  } catch (error) {
    print('  ❌ Terjadi kegagalan: $error');
  }
  print('-----------------------------------------------------');
  print('');

  // SKENARIO 2: Pengambilan Data Gagal
  print('>>> UJI COBA 2: Mengambil Data Mahasiswa ID #-99 (Simulasi Error)...');
  try {
    final hasil = await fetchProfilDariServer(-99);
    print('  ✅ Data Diterima: $hasil');
  } catch (error) {
    print('  🚨 Penanganan Error Berhasil (Aplikasi Tidak Crash):');
    print('     Pesan Galat: $error');
  }

  print('');
  print('💡 KESIMPULAN:');
  print(
    'Selalu gunakan blok "try-catch" saat memanggil fungsi asinkron "await"',
  );
  print('agar aplikasi mobile Anda tidak force close saat internet mati!');
}

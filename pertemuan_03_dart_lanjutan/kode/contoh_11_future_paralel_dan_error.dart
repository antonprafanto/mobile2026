// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 03: DART LANJUTAN
// CONTOH 11: Menjalankan Beberapa Future Sekaligus dan Menangani Errornya
// Topik: Future.wait, serta try-catch-finally pada kode asinkron.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_11_future_paralel_dan_error.dart
// =====================================================================

// Pura-pura bertanya stok ke tiga gudang. Setiap gudang butuh 1 detik.
Future<int> cekStokGudang(String gudang) async {
  await Future.delayed(Duration(seconds: 1));
  return switch (gudang) {
    'Samarinda' => 12,
    'Balikpapan' => 8,
    _ => 5,
  };
}

// Pura-pura mengambil saldo dari server yang bisa saja sedang gangguan.
Future<int> ambilSaldo({required bool serverAktif}) async {
  await Future.delayed(Duration(milliseconds: 500));
  if (!serverAktif) {
    throw Exception('Server sedang gangguan');
  }
  return 150000;
}

Future<void> main() async {
  Stopwatch stopwatch = Stopwatch()..start();

  // Future.wait: jalankan SEMUA sekaligus, lalu tunggu semuanya selesai.
  // Tiga pekerjaan @1 detik selesai dalam ±1 detik, bukan 3 detik.
  List<int> stok = await Future.wait([
    cekStokGudang('Samarinda'),
    cekStokGudang('Balikpapan'),
    cekStokGudang('Bontang'),
  ]);
  int total = stok.reduce((int a, int b) => a + b);
  print('Stok per gudang: $stok, total $total');
  print('Waktu tunggu: ${stopwatch.elapsed.inSeconds} detik');

  // Error pada kode asinkron ditangkap dengan try-catch biasa + await.
  for (bool aktif in [true, false]) {
    print('Memuat saldo (server aktif: $aktif)...');
    try {
      int saldo = await ambilSaldo(serverAktif: aktif);
      print('Saldo Anda: Rp$saldo');
    } catch (e) {
      print('Gagal memuat saldo: $e');
    } finally {
      print('Indikator loading disembunyikan.');
    }
  }
}

// OUTPUT:
// Stok per gudang: [12, 8, 5], total 25
// Waktu tunggu: 1 detik
// Memuat saldo (server aktif: true)...
// Saldo Anda: Rp150000
// Indikator loading disembunyikan.
// Memuat saldo (server aktif: false)...
// Gagal memuat saldo: Exception: Server sedang gangguan
// Indikator loading disembunyikan.

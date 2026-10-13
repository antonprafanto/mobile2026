// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 03: DART LANJUTAN
// CONTOH 10: Future, async, dan await
// Topik: Menunggu pekerjaan yang butuh waktu tanpa membuat aplikasi macet.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_10_future_async_await.dart
// =====================================================================

// Fungsi async mengembalikan Future: "janji" bahwa hasilnya akan ada NANTI.
// Future.delayed di sini hanya PURA-PURA menunggu server selama 1 detik.
Future<String> ambilNamaPengguna() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Rina';
}

Future<int> ambilJumlahNotifikasi() async {
  await Future.delayed(Duration(seconds: 1));
  return 3;
}

// main juga boleh async, agar di dalamnya kita bisa memakai await.
Future<void> main() async {
  print('1. Aplikasi dibuka, mulai memuat data...');

  // TANPA await: program tidak menunggu dan langsung lanjut ke baris
  // berikutnya. Hasilnya diambil nanti lewat then().
  ambilNamaPengguna().then((String nama) {
    print('3. (then) Nama akhirnya tiba: $nama');
  });
  print('2. Baris ini dicetak lebih dulu, tanpa menunggu.');

  // DENGAN await: program "menunggu di baris ini" sampai janjinya ditepati,
  // tetapi aplikasi TIDAK macet. Pekerjaan lain tetap boleh berjalan.
  Stopwatch stopwatch = Stopwatch()..start();
  String nama = await ambilNamaPengguna();
  int notifikasi = await ambilJumlahNotifikasi();
  print('4. Halo, $nama! Ada $notifikasi notifikasi baru.');
  print('5. Memuat dua data berurutan: ${stopwatch.elapsed.inSeconds} detik.');
}

// OUTPUT:
// 1. Aplikasi dibuka, mulai memuat data...
// 2. Baris ini dicetak lebih dulu, tanpa menunggu.
// 3. (then) Nama akhirnya tiba: Rina
// 4. Halo, Rina! Ada 3 notifikasi baru.
// 5. Memuat dua data berurutan: 2 detik.

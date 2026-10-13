// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 03: DART LANJUTAN
// CONTOH 12: Stream
// Topik: Aliran data yang datang berkali-kali: async*, yield, await for,
//        listen, serta mengolah stream dengan where dan map.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_12_stream.dart
// =====================================================================

// async* + yield: fungsi yang "mengalirkan" banyak nilai, satu per satu,
// dari waktu ke waktu. Bandingkan dengan Future yang hanya SATU nilai.
Stream<int> hitungMundur(int dari) async* {
  for (int i = dari; i >= 1; i--) {
    await Future.delayed(Duration(milliseconds: 500));
    yield i; // kirim satu nilai ke pendengar
  }
}

// Pura-pura membaca sensor suhu ruangan setiap setengah detik.
Stream<int> bacaSensorSuhu() async* {
  List<int> pembacaan = [27, 29, 31, 28, 33];
  for (int suhu in pembacaan) {
    await Future.delayed(Duration(milliseconds: 500));
    yield suhu;
  }
}

Future<void> main() async {
  // 1) await for: ikuti aliran sampai selesai, satu nilai setiap putaran.
  print('Peluncuran roket dimulai!');
  await for (int detik in hitungMundur(3)) {
    print('$detik...');
  }
  print('Meluncur!');

  // 2) where (saring) dan map (ubah) juga bisa dipakai pada stream.
  print('Peringatan suhu panas:');
  Stream<String> peringatan = bacaSensorSuhu()
      .where((int suhu) => suhu > 30)
      .map((int suhu) => 'Suhu $suhu derajat, nyalakan AC!');
  await for (String pesan in peringatan) {
    print(pesan);
  }

  // 3) listen: "berlangganan" stream, seperti berlangganan notifikasi.
  //    onDone dipanggil ketika aliran sudah selesai.
  hitungMundur(2).listen(
    (int sisa) => print('Notifikasi: tinggal $sisa'),
    onDone: () => print('Stream selesai.'),
  );
  print('Baris ini muncul duluan, karena listen tidak menunggu.');
}

// OUTPUT:
// Peluncuran roket dimulai!
// 3...
// 2...
// 1...
// Meluncur!
// Peringatan suhu panas:
// Suhu 31 derajat, nyalakan AC!
// Suhu 33 derajat, nyalakan AC!
// Baris ini muncul duluan, karena listen tidak menunggu.
// Notifikasi: tinggal 2
// Notifikasi: tinggal 1
// Stream selesai.

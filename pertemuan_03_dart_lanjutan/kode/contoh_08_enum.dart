// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 03: DART LANJUTAN
// CONTOH 08: Enum
// Topik: Daftar pilihan yang pasti, enum dengan properti, dan switch.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_08_enum.dart
// =====================================================================

// 1) Enum sederhana: daftar nilai yang PASTI dan terbatas.
//    Lebih aman daripada String, karena salah ketik langsung ketahuan.
enum Hari { senin, selasa, rabu, kamis, jumat, sabtu, minggu }

// 2) Enum dengan properti (enhanced enum): setiap nilai membawa data.
enum StatusPesanan {
  menunggu('Menunggu konfirmasi'),
  diproses('Sedang dimasak'),
  siap('Siap diambil'),
  selesai('Pesanan selesai');

  const StatusPesanan(this.label); // constructor enum selalu const
  final String label;

  // Getter di dalam enum.
  bool get bisaDibatalkan => this == StatusPesanan.menunggu;
}

// switch ekspresi pada enum: Dart memeriksa apakah SEMUA kemungkinan sudah
// ditangani. Jika ada status baru yang lupa ditulis, muncul error.
String saranUntukPembeli(StatusPesanan status) {
  return switch (status) {
    StatusPesanan.menunggu => 'Mohon tunggu sebentar.',
    StatusPesanan.diproses => 'Pesanan sedang dibuat.',
    StatusPesanan.siap => 'Silakan ambil di loket.',
    StatusPesanan.selesai => 'Terima kasih sudah memesan!',
  };
}

void main() {
  Hari hariIni = Hari.jumat;
  print('Hari ini: $hariIni');
  print('Nama: ${hariIni.name}, urutan ke-${hariIni.index}');
  print('Libur? ${hariIni == Hari.sabtu || hariIni == Hari.minggu}');

  // values = daftar semua nilai enum, sesuai urutan penulisannya.
  print('Jumlah status pesanan: ${StatusPesanan.values.length}');
  for (StatusPesanan status in StatusPesanan.values) {
    print('- ${status.label} (bisa dibatalkan: ${status.bisaDibatalkan})');
  }

  StatusPesanan pesananSaya = StatusPesanan.siap;
  print(saranUntukPembeli(pesananSaya));
}

// OUTPUT:
// Hari ini: Hari.jumat
// Nama: jumat, urutan ke-4
// Libur? false
// Jumlah status pesanan: 4
// - Menunggu konfirmasi (bisa dibatalkan: true)
// - Sedang dimasak (bisa dibatalkan: false)
// - Siap diambil (bisa dibatalkan: false)
// - Pesanan selesai (bisa dibatalkan: false)
// Silakan ambil di loket.

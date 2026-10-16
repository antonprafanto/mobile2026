// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 12: CLEAN ARCHITECTURE
// CONTOH 02: Lapisan Domain: Entitas dan Aturan Bisnis dalam Dart Murni
// Topik: Inti aplikasi Pinjam Ruang ditulis TANPA Flutter, tanpa
//        internet, dan tanpa database:
//        1. entitas Ruang dan objek nilai RentangWaktu: semua field
//           final (immutable), dan dua rentang yang jamnya sama dianggap
//           sama (operator ==);
//        2. aturan bisnis periksaPengajuan() mengembalikan alasan
//           penolakan, atau null jika pengajuan wajar;
//        3. jam "sekarang" diterima sebagai PARAMETER (disuntikkan),
//           sehingga hasil pemeriksaan selalu sama kapan pun dijalankan.
//        Karena Dart murni, berkas ini bisa dijalankan tanpa Flutter.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_02_domain_dart_murni.dart
// =====================================================================

// Ini program konsol, jadi print() boleh dipakai. Di aplikasi Flutter
// kita tetap memakai debugPrint(), karena itu aturan avoid_print hanya
// dimatikan untuk berkas ini.
// ignore_for_file: avoid_print

// ----------------------------- ENTITAS -----------------------------

class Ruang {
  const Ruang({
    required this.kode,
    required this.nama,
    required this.kapasitas,
  });

  final String kode;
  final String nama;
  final int kapasitas;
}

// Objek nilai: dikenali dari ISINYA (jam mulai dan selesai), bukan dari
// alamatnya di memori.
class RentangWaktu {
  const RentangWaktu({required this.mulai, required this.selesai});

  final DateTime mulai;
  final DateTime selesai;

  Duration get durasi => selesai.difference(mulai);

  // Objek tidak diubah; yang dibuat adalah objek BARU.
  RentangWaktu geser(Duration selisih) {
    return RentangWaktu(
      mulai: mulai.add(selisih),
      selesai: selesai.add(selisih),
    );
  }

  bool bertumpukDengan(RentangWaktu lain) {
    return mulai.isBefore(lain.selesai) && lain.mulai.isBefore(selesai);
  }

  String get teksJam => '${_jam(mulai)}-${_jam(selesai)}';

  static String _jam(DateTime t) {
    return '${t.hour.toString().padLeft(2, '0')}.'
        '${t.minute.toString().padLeft(2, '0')}';
  }

  @override
  bool operator ==(Object other) {
    return other is RentangWaktu &&
        other.mulai == mulai &&
        other.selesai == selesai;
  }

  @override
  int get hashCode => Object.hash(mulai, selesai);
}

class PengajuanPeminjaman {
  const PengajuanPeminjaman({
    required this.keperluan,
    required this.jumlahPeserta,
    required this.waktu,
  });

  final String keperluan;
  final int jumlahPeserta;
  final RentangWaktu waktu;
}

// --------------------------- ATURAN BISNIS ---------------------------

const int jamBuka = 7; // 07.00
const int jamTutup = 21; // 21.00
const Duration durasiMinimal = Duration(minutes: 30);
const Duration durasiMaksimal = Duration(hours: 3);

bool hariKerja(DateTime tanggal) => tanggal.weekday <= DateTime.friday;

// Mengembalikan alasan penolakan, atau null jika pengajuan wajar.
String? periksaPengajuan(
  PengajuanPeminjaman pengajuan, {
  required Ruang ruang,
  required DateTime sekarang,
}) {
  final RentangWaktu waktu = pengajuan.waktu;
  if (pengajuan.keperluan.trim().isEmpty) {
    return 'Keperluan wajib diisi.';
  }
  if (pengajuan.jumlahPeserta < 1) {
    return 'Jumlah peserta minimal 1 orang.';
  }
  if (pengajuan.jumlahPeserta > ruang.kapasitas) {
    return 'Peserta (${pengajuan.jumlahPeserta}) melebihi kapasitas '
        '${ruang.nama} (${ruang.kapasitas} orang).';
  }
  if (!waktu.selesai.isAfter(waktu.mulai)) {
    return 'Jam selesai harus setelah jam mulai.';
  }
  if (waktu.durasi < durasiMinimal || waktu.durasi > durasiMaksimal) {
    return 'Lama peminjaman harus 30 menit sampai 3 jam.';
  }
  if (!hariKerja(waktu.mulai)) {
    return 'Ruang hanya bisa dipinjam Senin sampai Jumat.';
  }
  final DateTime buka = DateTime(
    waktu.mulai.year,
    waktu.mulai.month,
    waktu.mulai.day,
    jamBuka,
  );
  final DateTime tutup = DateTime(
    waktu.mulai.year,
    waktu.mulai.month,
    waktu.mulai.day,
    jamTutup,
  );
  if (waktu.mulai.isBefore(buka) || waktu.selesai.isAfter(tutup)) {
    return 'Ruang hanya bisa dipinjam pukul 07.00 sampai 21.00.';
  }
  if (!waktu.mulai.isAfter(sekarang)) {
    return 'Waktu mulai sudah lewat. Pilih jam yang akan datang.';
  }
  return null;
}

// ------------------------------ PROGRAM ------------------------------

RentangWaktu rentang(int bulan, int tanggal, int jam, int menit) {
  final DateTime mulai = DateTime(2026, bulan, tanggal, jam);
  return RentangWaktu(
    mulai: mulai,
    selesai: mulai.add(Duration(minutes: menit)),
  );
}

void main() {
  print('=== 1. Entitas dan objek nilai ===');
  final RentangWaktu pagi = rentang(10, 19, 9, 120);
  print('Senin pagi: ${pagi.teksJam}, lama ${pagi.durasi.inMinutes} menit');
  final RentangWaktu siang = pagi.geser(const Duration(hours: 2));
  print('Digeser 2 jam: ${siang.teksJam} (yang lama tetap ${pagi.teksJam})');
  print(
    'Bertumpuk dengan 10.00-12.00? '
    '${pagi.bertumpukDengan(rentang(10, 19, 10, 120))}',
  );
  print('Bertumpuk dengan 11.00-13.00? ${pagi.bertumpukDengan(siang)}');
  print(
    'Sama dengan rentang 09.00-11.00 yang lain? '
    '${pagi == rentang(10, 19, 9, 120)}',
  );
  print('');

  print('=== 2. Aturan bisnis ===');
  const Ruang diskusi = Ruang(
    kode: 'C-110',
    nama: 'Ruang Diskusi C.110',
    kapasitas: 12,
  );
  final DateTime jumatPagi = DateTime(2026, 10, 16, 10); // Jumat 10.00
  final List<PengajuanPeminjaman> daftar = [
    PengajuanPeminjaman(
      keperluan: 'Diskusi kelompok',
      jumlahPeserta: 8,
      waktu: rentang(10, 19, 13, 90),
    ),
    PengajuanPeminjaman(
      keperluan: 'Rapat angkatan',
      jumlahPeserta: 30,
      waktu: rentang(10, 19, 13, 60),
    ),
    PengajuanPeminjaman(
      keperluan: 'Belajar bersama',
      jumlahPeserta: 6,
      waktu: rentang(10, 17, 9, 60),
    ),
    PengajuanPeminjaman(
      keperluan: 'Latihan presentasi',
      jumlahPeserta: 5,
      waktu: rentang(10, 19, 20, 120),
    ),
    PengajuanPeminjaman(
      keperluan: '   ',
      jumlahPeserta: 5,
      waktu: rentang(10, 19, 9, 60),
    ),
  ];
  for (final PengajuanPeminjaman p in daftar) {
    final String? alasan = periksaPengajuan(
      p,
      ruang: diskusi,
      sekarang: jumatPagi,
    );
    print('"${p.keperluan}" ${p.waktu.teksJam} -> ${alasan ?? 'LOLOS'}');
  }
  print('');

  print('=== 3. Jam disuntikkan ===');
  // Pengajuan yang sama diperiksa pada dua "waktu sekarang" berbeda.
  final PengajuanPeminjaman diskusiSenin = daftar.first;
  for (final DateTime sekarang in [jumatPagi, DateTime(2026, 10, 19, 14)]) {
    final String? alasan = periksaPengajuan(
      diskusiSenin,
      ruang: diskusi,
      sekarang: sekarang,
    );
    print(
      'Diperiksa ${sekarang.day}/${sekarang.month} pukul ${sekarang.hour}.00 '
      '-> ${alasan ?? 'LOLOS'}',
    );
  }
}

// OUTPUT:
// === 1. Entitas dan objek nilai ===
// Senin pagi: 09.00-11.00, lama 120 menit
// Digeser 2 jam: 11.00-13.00 (yang lama tetap 09.00-11.00)
// Bertumpuk dengan 10.00-12.00? true
// Bertumpuk dengan 11.00-13.00? false
// Sama dengan rentang 09.00-11.00 yang lain? true
//
// === 2. Aturan bisnis ===
// "Diskusi kelompok" 13.00-14.30 -> LOLOS
// "Rapat angkatan" 13.00-14.00 -> Peserta (30) melebihi kapasitas Ruang Diskusi C.110 (12 orang).
// "Belajar bersama" 09.00-10.00 -> Ruang hanya bisa dipinjam Senin sampai Jumat.
// "Latihan presentasi" 20.00-22.00 -> Ruang hanya bisa dipinjam pukul 07.00 sampai 21.00.
// "   " 09.00-10.00 -> Keperluan wajib diisi.
//
// === 3. Jam disuntikkan ===
// Diperiksa 16/10 pukul 10.00 -> LOLOS
// Diperiksa 19/10 pukul 14.00 -> Waktu mulai sudah lewat. Pilih jam yang akan datang.

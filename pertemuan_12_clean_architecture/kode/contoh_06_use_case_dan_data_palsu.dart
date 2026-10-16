// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 12: CLEAN ARCHITECTURE
// CONTOH 06: Use Case AjukanPeminjaman dan Pengujian dengan Data Palsu
// Topik: Mengajukan peminjaman ruang butuh DUA repository (ruang untuk
//        kapasitas, peminjaman untuk jadwal dan kuota) ditambah jam
//        saat ini. Logika gabungan seperti ini ditulis sebagai USE CASE,
//        bukan di ViewModel. Program konsol ini:
//        A. menjalankan use case dengan repository palsu (di memori) dan
//           jam tetap (Jumat, 16 Oktober 2026 pukul 10.00);
//        B. mengujinya secara otomatis. Repository palsu juga mencatat
//           berapa kali simpan() dipanggil, sehingga bisa dibuktikan
//           bahwa pengajuan yang ditolak TIDAK pernah disimpan.
//        Semuanya Dart murni: tanpa Flutter, tanpa internet.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_06_use_case_dan_data_palsu.dart
// =====================================================================

// Ini program konsol, jadi print() boleh dipakai. Di aplikasi Flutter
// kita tetap memakai debugPrint(), karena itu aturan avoid_print hanya
// dimatikan untuk berkas ini.
// ignore_for_file: avoid_print

// ============================== DOMAIN ==============================

sealed class Hasil<T> {
  const Hasil();
}

final class Berhasil<T> extends Hasil<T> {
  const Berhasil(this.nilai);

  final T nilai;
}

final class Gagal<T> extends Hasil<T> {
  const Gagal(this.kegagalan);

  final Kegagalan kegagalan;
}

sealed class Kegagalan {
  const Kegagalan();
}

final class TanpaKoneksi extends Kegagalan {
  const TanpaKoneksi();
}

final class AturanDilanggar extends Kegagalan {
  const AturanDilanggar(this.alasan);

  final String alasan;
}

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

class Pengguna {
  const Pengguna({required this.nim, required this.nama});

  final String nim;
  final String nama;
}

class RentangWaktu {
  const RentangWaktu({required this.mulai, required this.selesai});

  final DateTime mulai;
  final DateTime selesai;

  Duration get durasi => selesai.difference(mulai);

  bool bertumpukDengan(RentangWaktu lain) {
    return mulai.isBefore(lain.selesai) && lain.mulai.isBefore(selesai);
  }

  String get teksJam => '${_jam(mulai)}-${_jam(selesai)}';

  static String _jam(DateTime t) {
    return '${t.hour.toString().padLeft(2, '0')}.'
        '${t.minute.toString().padLeft(2, '0')}';
  }
}

class Peminjaman {
  const Peminjaman({
    required this.id,
    required this.kodeRuang,
    required this.peminjam,
    required this.keperluan,
    required this.jumlahPeserta,
    required this.waktu,
  });

  final String id;
  final String kodeRuang;
  final Pengguna peminjam;
  final String keperluan;
  final int jumlahPeserta;
  final RentangWaktu waktu;
}

class PengajuanPeminjaman {
  const PengajuanPeminjaman({
    required this.kodeRuang,
    required this.keperluan,
    required this.jumlahPeserta,
    required this.waktu,
  });

  final String kodeRuang;
  final String keperluan;
  final int jumlahPeserta;
  final RentangWaktu waktu;
}

// Aturan yang cukup dilihat dari pengajuannya sendiri (sama dengan
// Contoh 02).

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

// Kontrak: domain hanya menyebut apa yang dibutuhkannya.
abstract class RepositoriRuang {
  Future<Hasil<List<Ruang>>> semuaRuang();
}

abstract class RepositoriPeminjaman {
  Future<Hasil<List<Peminjaman>>> milikRuang(String kodeRuang);

  Future<Hasil<List<Peminjaman>>> milikPengguna(String nim);

  Future<Hasil<Peminjaman>> simpan(
    PengajuanPeminjaman pengajuan,
    Pengguna peminjam,
  );
}

// USE CASE: satu tindakan pengguna, lengkap dengan aturannya. Ia
// menggabungkan dua repository dan jam saat ini.
class AjukanPeminjaman {
  // sekarang disuntikkan agar pengujian bisa memakai jam tetap.
  AjukanPeminjaman({
    required this._ruang,
    required this._peminjaman,
    DateTime Function()? sekarang,
  }) : _sekarang = sekarang ?? DateTime.now;

  static const int batasPeminjamanAktif = 2;

  final RepositoriRuang _ruang;
  final RepositoriPeminjaman _peminjaman;
  final DateTime Function() _sekarang;

  Future<Hasil<Peminjaman>> jalankan(
    PengajuanPeminjaman pengajuan,
    Pengguna peminjam,
  ) async {
    final DateTime sekarang = _sekarang();

    // 1. Data ruang dibutuhkan untuk memeriksa kapasitas.
    final Hasil<List<Ruang>> hasilRuang = await _ruang.semuaRuang();
    final List<Ruang> semuaRuang;
    switch (hasilRuang) {
      case Gagal():
        return Gagal(hasilRuang.kegagalan);
      case Berhasil():
        semuaRuang = hasilRuang.nilai;
    }
    final Ruang? ruang = semuaRuang
        .where((Ruang r) => r.kode == pengajuan.kodeRuang)
        .firstOrNull;
    if (ruang == null) {
      return const Gagal(AturanDilanggar('Ruang tidak ditemukan.'));
    }

    // 2. Aturan yang cukup dilihat dari pengajuannya sendiri.
    final String? masalah = periksaPengajuan(
      pengajuan,
      ruang: ruang,
      sekarang: sekarang,
    );
    if (masalah != null) {
      return Gagal(AturanDilanggar(masalah));
    }

    // 3. Tidak boleh bentrok dengan peminjaman lain di ruang yang sama.
    final Hasil<List<Peminjaman>> hasilRuangIni = await _peminjaman.milikRuang(
      ruang.kode,
    );
    switch (hasilRuangIni) {
      case Gagal():
        return Gagal(hasilRuangIni.kegagalan);
      case Berhasil():
        for (final Peminjaman lain in hasilRuangIni.nilai) {
          if (lain.waktu.bertumpukDengan(pengajuan.waktu)) {
            return Gagal(
              AturanDilanggar(
                'Bentrok dengan "${lain.keperluan}" '
                'pukul ${lain.waktu.teksJam}.',
              ),
            );
          }
        }
    }

    // 4. Satu orang paling banyak punya 2 peminjaman yang belum selesai.
    final Hasil<List<Peminjaman>> hasilMilikku = await _peminjaman
        .milikPengguna(peminjam.nim);
    switch (hasilMilikku) {
      case Gagal():
        return Gagal(hasilMilikku.kegagalan);
      case Berhasil():
        final int aktif = hasilMilikku.nilai
            .where((Peminjaman p) => p.waktu.selesai.isAfter(sekarang))
            .length;
        if (aktif >= batasPeminjamanAktif) {
          return const Gagal(
            AturanDilanggar(
              'Anda sudah punya 2 peminjaman aktif. '
              'Batalkan salah satu dulu.',
            ),
          );
        }
    }

    // 5. Semua aturan terpenuhi: simpan.
    return _peminjaman.simpan(pengajuan, peminjam);
  }
}

// =========================== DATA PALSU ===========================
// Implementasi kontrak yang menyimpan data di memori. Dipakai untuk
// pengembangan dan pengujian, tanpa internet dan tanpa database.

class RepositoriRuangPalsu implements RepositoriRuang {
  bool putus = false; // true = pura-pura internet mati

  @override
  Future<Hasil<List<Ruang>>> semuaRuang() async {
    if (putus) return const Gagal(TanpaKoneksi());
    return const Berhasil([
      Ruang(kode: 'C-105', nama: 'Ruang Seminar C.105', kapasitas: 80),
      Ruang(kode: 'C-110', nama: 'Ruang Diskusi C.110', kapasitas: 12),
      Ruang(kode: 'LAB-1', nama: 'Laboratorium Komputer 1', kapasitas: 40),
    ]);
  }
}

class RepositoriPeminjamanPalsu implements RepositoriPeminjaman {
  RepositoriPeminjamanPalsu(this._data);

  final List<Peminjaman> _data;
  int jumlahSimpan = 0; // mata-mata (spy): berapa kali simpan dipanggil

  @override
  Future<Hasil<List<Peminjaman>>> milikRuang(String kodeRuang) async {
    return Berhasil(
      _data.where((Peminjaman p) => p.kodeRuang == kodeRuang).toList(),
    );
  }

  @override
  Future<Hasil<List<Peminjaman>>> milikPengguna(String nim) async {
    return Berhasil(
      _data.where((Peminjaman p) => p.peminjam.nim == nim).toList(),
    );
  }

  @override
  Future<Hasil<Peminjaman>> simpan(
    PengajuanPeminjaman pengajuan,
    Pengguna peminjam,
  ) async {
    jumlahSimpan++;
    final Peminjaman baru = Peminjaman(
      id: 'PJ-${(_data.length + 1).toString().padLeft(3, '0')}',
      kodeRuang: pengajuan.kodeRuang,
      peminjam: peminjam,
      keperluan: pengajuan.keperluan,
      jumlahPeserta: pengajuan.jumlahPeserta,
      waktu: pengajuan.waktu,
    );
    _data.add(baru);
    return Berhasil(baru);
  }
}

// ============================= PROGRAM =============================

const Pengguna budi = Pengguna(nim: '2609106001', nama: 'Budi Santoso');
const Pengguna hima = Pengguna(nim: 'HIMA-IF', nama: 'HIMA Informatika');

DateTime jumatPagi() => DateTime(2026, 10, 16, 10); // jam tetap

RentangWaktu senin(int jam, int menit) {
  final DateTime mulai = DateTime(2026, 10, 19, jam);
  return RentangWaktu(
    mulai: mulai,
    selesai: mulai.add(Duration(minutes: menit)),
  );
}

List<Peminjaman> dataAwal() => [
  Peminjaman(
    id: 'PJ-001',
    kodeRuang: 'C-105',
    peminjam: hima,
    keperluan: 'Seminar Proposal Skripsi',
    jumlahPeserta: 60,
    waktu: senin(9, 120),
  ),
  Peminjaman(
    id: 'PJ-002',
    kodeRuang: 'LAB-1',
    peminjam: budi,
    keperluan: 'Belajar kelompok',
    jumlahPeserta: 8,
    waktu: senin(15, 90),
  ),
];

PengajuanPeminjaman pengajuan(String kode, int peserta, RentangWaktu waktu) {
  return PengajuanPeminjaman(
    kodeRuang: kode,
    keperluan: 'Rapat panitia',
    jumlahPeserta: peserta,
    waktu: waktu,
  );
}

String teks(Hasil<Peminjaman> hasil) {
  return switch (hasil) {
    Berhasil(:final Peminjaman nilai) => 'Berhasil: ${nilai.id} tersimpan',
    Gagal(kegagalan: AturanDilanggar(:final String alasan)) =>
      'Ditolak: $alasan',
    Gagal(kegagalan: TanpaKoneksi()) => 'Gagal: tidak ada koneksi',
  };
}

int lulus = 0;
int jumlahUji = 0;

void uji(String nama, Object? didapat, Object? diharapkan) {
  jumlahUji++;
  if (didapat == diharapkan) {
    lulus++;
    print('LULUS  $nama');
  } else {
    print('GAGAL  $nama: diharapkan $diharapkan, hasilnya $didapat');
  }
}

Future<void> main() async {
  print('=== A. Budi mengajukan peminjaman (jam tetap: Jumat 16/10 10.00) ===');
  final AjukanPeminjaman ajukan = AjukanPeminjaman(
    ruang: RepositoriRuangPalsu(),
    peminjaman: RepositoriPeminjamanPalsu(dataAwal()),
    sekarang: jumatPagi,
  );
  final Map<String, PengajuanPeminjaman> skenario = {
    'C-105 Senin 10.00-11.00': pengajuan('C-105', 25, senin(10, 60)),
    'C-105 Senin 11.00-12.00': pengajuan('C-105', 25, senin(11, 60)),
    'C-110 Senin 13.00-14.00, 20 orang': pengajuan('C-110', 20, senin(13, 60)),
    'LAB-1 Senin 08.00-09.00': pengajuan('LAB-1', 10, senin(8, 60)),
  };
  for (final MapEntry<String, PengajuanPeminjaman> s in skenario.entries) {
    print('${s.key} -> ${teks(await ajukan.jalankan(s.value, budi))}');
  }
  print('');

  print('=== B. Pengujian otomatis dengan data palsu ===');
  final RepositoriRuangPalsu ruang = RepositoriRuangPalsu();
  final RepositoriPeminjamanPalsu peminjaman = RepositoriPeminjamanPalsu(
    dataAwal(),
  );
  final AjukanPeminjaman useCase = AjukanPeminjaman(
    ruang: ruang,
    peminjaman: peminjaman,
    sekarang: jumatPagi,
  );
  uji(
    'Bentrok ditolak',
    teks(await useCase.jalankan(pengajuan('C-105', 25, senin(10, 60)), budi)),
    'Ditolak: Bentrok dengan "Seminar Proposal Skripsi" pukul 09.00-11.00.',
  );
  uji('Pengajuan yang ditolak tidak disimpan', peminjaman.jumlahSimpan, 0);
  uji(
    'Jam bersambung (11.00-12.00) diterima',
    teks(await useCase.jalankan(pengajuan('C-105', 25, senin(11, 60)), budi)),
    'Berhasil: PJ-003 tersimpan',
  );
  uji('Disimpan tepat satu kali', peminjaman.jumlahSimpan, 1);
  ruang.putus = true;
  uji(
    'Internet mati -> Gagal(TanpaKoneksi), bukan exception',
    teks(await useCase.jalankan(pengajuan('C-110', 5, senin(13, 60)), budi)),
    'Gagal: tidak ada koneksi',
  );
  print('Ringkasan: $lulus dari $jumlahUji uji lulus');
}

// OUTPUT:
// === A. Budi mengajukan peminjaman (jam tetap: Jumat 16/10 10.00) ===
// C-105 Senin 10.00-11.00 -> Ditolak: Bentrok dengan "Seminar Proposal Skripsi" pukul 09.00-11.00.
// C-105 Senin 11.00-12.00 -> Berhasil: PJ-003 tersimpan
// C-110 Senin 13.00-14.00, 20 orang -> Ditolak: Peserta (20) melebihi kapasitas Ruang Diskusi C.110 (12 orang).
// LAB-1 Senin 08.00-09.00 -> Ditolak: Anda sudah punya 2 peminjaman aktif. Batalkan salah satu dulu.
//
// === B. Pengujian otomatis dengan data palsu ===
// LULUS  Bentrok ditolak
// LULUS  Pengajuan yang ditolak tidak disimpan
// LULUS  Jam bersambung (11.00-12.00) diterima
// LULUS  Disimpan tepat satu kali
// LULUS  Internet mati -> Gagal(TanpaKoneksi), bukan exception
// Ringkasan: 5 dari 5 uji lulus

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 16: UJIAN AKHIR SEMESTER
// CONTOH 01: Menghitung Nilai Proyek Akhir (Dart Murni)
// Topik: Bagaimana NILAI TIM, nilai PRESENTASI setiap anggota, dan
//        FAKTOR INDIVIDU digabung menjadi nilai proyek akhir setiap
//        anggota (Panduan UAS Bagian 9). Program ini:
//        1. menyimpan bobot setiap komponen di satu enum;
//        2. menghitung nilai tim (maksimal 85);
//        3. menghitung nilai proyek akhir setiap anggota (maksimal 100);
//        4. memperlihatkan pengaruh faktor individu;
//        5. menolak skor yang salah isi;
//        6. menghitung sumbangan proyek akhir (40%) pada nilai akhir
//           mata kuliah.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_01_hitung_nilai_proyek_akhir_dart_murni.dart
// =====================================================================

// Ini program konsol, jadi print() boleh dipakai.
// ignore_for_file: avoid_print

// ---------------------------- KOMPONEN -----------------------------

/// Komponen nilai proyek akhir beserta bobot maksimalnya.
/// Jumlah semua bobot = 100 (Panduan Proyek Akhir Bagian 9).
enum Komponen {
  proposal('Proposal (P9)', 5),
  kemajuan('Laporan kemajuan (P12)', 10),
  fungsionalitas('Fungsionalitas', 25),
  arsitektur('Arsitektur dan kualitas kode', 15),
  uiUx('UI/UX', 10),
  pengujian('Pengujian', 10),
  repositori('Repositori, rilis, dokumentasi', 10),
  // Satu-satunya komponen yang dinilai untuk SETIAP anggota.
  presentasi('Presentasi dan tanya jawab', 15, perOrang: true);

  const Komponen(this.label, this.bobot, {this.perOrang = false});

  final String label;
  final int bobot;
  final bool perOrang; // false = satu skor untuk seluruh tim
}

/// Faktor individu: seberapa jauh seorang anggota MEMAHAMI dan IKUT
/// MEMBANGUN aplikasi timnya. Buktinya dari tanya jawab dan riwayat
/// commit. Nilainya ditulis dalam persen agar perhitungannya tepat.
enum FaktorIndividu {
  penuh(100, 'menjelaskan bagiannya dengan benar, kontribusi jelas'),
  sebagian(80, 'sebagian penjelasan kurang tepat, atau kontribusi kecil'),
  lemah(50, 'banyak bagian tidak bisa dijelaskan'),
  nol(0, 'tidak bisa menjelaskan sama sekali, atau tidak berkontribusi');

  const FaktorIndividu(this.persen, this.arti);

  final int persen;
  final String arti;

  /// Ditampilkan sebagai 1,0 / 0,8 / 0,5 / 0,0 (gaya penulisan Indonesia).
  String get teks => (persen / 100).toStringAsFixed(1).replaceAll('.', ',');
}

/// Dilempar jika skor yang dimasukkan tidak masuk akal.
class SkorTidakSah implements Exception {
  const SkorTidakSah(this.pesan);

  final String pesan;

  @override
  String toString() => pesan;
}

// ---------------------------- PERHITUNGAN ----------------------------

/// Bobot maksimal nilai tim: semua komponen yang bukan per orang (85).
final int bobotTim = Komponen.values
    .where((Komponen k) => !k.perOrang)
    .fold(0, (int jumlah, Komponen k) => jumlah + k.bobot);

/// Menjumlahkan skor tim setelah memeriksa SETIAP komponen tim:
/// harus ada, dan harus berada di rentang 0 sampai bobotnya.
int hitungNilaiTim(Map<Komponen, int> skor) {
  int jumlah = 0;
  for (final Komponen k in Komponen.values) {
    if (k.perOrang) {
      if (skor.containsKey(k)) {
        throw SkorTidakSah('${k.label} dinilai per orang, bukan per tim');
      }
      continue;
    }
    final int? nilai = skor[k];
    if (nilai == null) {
      throw SkorTidakSah('komponen ${k.label} belum dinilai');
    }
    if (nilai < 0 || nilai > k.bobot) {
      throw SkorTidakSah('skor ${k.label} $nilai di luar rentang 0-${k.bobot}');
    }
    jumlah += nilai;
  }
  return jumlah;
}

/// Seorang anggota tim beserta nilai yang khusus miliknya.
class Anggota {
  const Anggota(
    this.nama, {
    required this.peran,
    required this.presentasi,
    required this.faktor,
  });

  final String nama;
  final String peran;
  final int presentasi; // 0-15
  final FaktorIndividu faktor;
}

/// Nilai proyek akhir seorang anggota, dalam PERSEPULUHAN poin
/// (674 berarti 67,4). Bilangan bulat dipakai agar tidak ada galat
/// pembulatan seperti 58.400000000000006.
///
///   nilai = nilai tim x faktor individu + nilai presentasi
int nilaiProyekPersepuluhan(int nilaiTim, Anggota anggota) {
  final int maks = Komponen.presentasi.bobot;
  if (anggota.presentasi < 0 || anggota.presentasi > maks) {
    throw SkorTidakSah(
      'skor presentasi ${anggota.nama} ${anggota.presentasi} '
      'di luar rentang 0-$maks',
    );
  }
  // nilaiTim x persen / 100, lalu x 10 agar menjadi persepuluhan.
  return nilaiTim * anggota.faktor.persen ~/ 10 + anggota.presentasi * 10;
}

/// 674 -> "67,4"
String persepuluhan(int nilai) => '${nilai ~/ 10},${nilai % 10}';

/// 2696 -> "26,96"
String perseratusan(int nilai) =>
    '${nilai ~/ 100},${(nilai % 100).toString().padLeft(2, '0')}';

// ------------------------------- DATA -------------------------------

const String namaTim = 'Resep Hemat Anak Kos';

/// Skor tim dari dosen. Proposal dan laporan kemajuan sudah dinilai di
/// Pertemuan 9 dan 12; sisanya dinilai saat UAS.
const Map<Komponen, int> skorTim = <Komponen, int>{
  Komponen.proposal: 5,
  Komponen.kemajuan: 8,
  Komponen.fungsionalitas: 22,
  Komponen.arsitektur: 12,
  Komponen.uiUx: 9,
  Komponen.pengujian: 8,
  Komponen.repositori: 9,
};

const List<Anggota> anggotaTim = <Anggota>[
  Anggota(
    'Rina',
    peran: 'View dan tema',
    presentasi: 14,
    faktor: FaktorIndividu.penuh,
  ),
  Anggota(
    'Bima',
    peran: 'Repository dan API',
    presentasi: 12,
    faktor: FaktorIndividu.penuh,
  ),
  Anggota(
    'Sari',
    peran: 'ViewModel dan tes',
    presentasi: 9,
    faktor: FaktorIndividu.sebagian,
  ),
];

// ------------------------------- MAIN -------------------------------

void main() {
  print('=== 1. Komponen dan bobotnya ===');
  for (final Komponen k in Komponen.values) {
    final String cara = k.perOrang ? 'per orang' : 'per tim';
    print('${k.label.padRight(31)} ${k.bobot.toString().padLeft(2)}  ($cara)');
  }
  final int total = Komponen.values.fold(
    0,
    (int jumlah, Komponen k) => jumlah + k.bobot,
  );
  print('Jumlah semua bobot: $total (nilai tim maksimal $bobotTim)');

  print('');
  print('=== 2. Nilai tim "$namaTim" ===');
  final int nilaiTim = hitungNilaiTim(skorTim);
  for (final MapEntry<Komponen, int> isian in skorTim.entries) {
    final Komponen k = isian.key;
    print(
      '${k.label.padRight(31)} ${isian.value.toString().padLeft(2)} / ${k.bobot}',
    );
  }
  print('Nilai tim: $nilaiTim / $bobotTim');

  print('');
  print('=== 3. Nilai proyek akhir setiap anggota ===');
  print('Rumus: nilai tim x faktor individu + nilai presentasi');
  for (final Anggota a in anggotaTim) {
    final int nilai = nilaiProyekPersepuluhan(nilaiTim, a);
    print(
      '${a.nama.padRight(5)} ($nilaiTim x ${a.faktor.teks}) + '
      '${a.presentasi.toString().padLeft(2)} = ${persepuluhan(nilai)}',
    );
  }

  print('');
  print('=== 4. Pengaruh faktor individu (nilai tim $nilaiTim) ===');
  // Anggota yang sama (presentasi 12), dengan faktor berbeda-beda.
  for (final FaktorIndividu f in FaktorIndividu.values) {
    final Anggota contoh = Anggota(
      'Contoh',
      peran: '-',
      presentasi: 12,
      faktor: f,
    );
    final int nilai = nilaiProyekPersepuluhan(nilaiTim, contoh);
    print('${f.teks} -> ${persepuluhan(nilai).padLeft(4)}  ${f.arti}');
  }

  print('');
  print('=== 5. Skor yang ditolak ===');
  final List<Map<Komponen, int>> skorKeliru = <Map<Komponen, int>>[
    // Fungsionalitas berbobot 25, tetapi diisi 30.
    <Komponen, int>{...skorTim, Komponen.fungsionalitas: 30},
    // Komponen Pengujian terlupa.
    <Komponen, int>{...skorTim}..remove(Komponen.pengujian),
    // Presentasi seharusnya dinilai per orang.
    <Komponen, int>{...skorTim, Komponen.presentasi: 13},
  ];
  for (final Map<Komponen, int> skor in skorKeliru) {
    try {
      hitungNilaiTim(skor);
      print('diterima');
    } on SkorTidakSah catch (galat) {
      print('DITOLAK: $galat');
    }
  }
  try {
    nilaiProyekPersepuluhan(
      nilaiTim,
      const Anggota(
        'Dodi',
        peran: 'Rilis',
        presentasi: 16,
        faktor: FaktorIndividu.penuh,
      ),
    );
  } on SkorTidakSah catch (galat) {
    print('DITOLAK: $galat');
  }

  print('');
  print('=== 6. Sumbangan pada nilai akhir mata kuliah (Rina) ===');
  // Bobot mata kuliah (Silabus Bagian 6), dalam persen.
  final int proyekRina = nilaiProyekPersepuluhan(nilaiTim, anggotaTim[0]);
  final List<(String, int, int)> komponenKuliah = <(String, int, int)>[
    // (nama, nilai dalam persepuluhan, bobot persen)
    ('Praktikum', 880, 25),
    ('Kuis', 800, 10),
    ('UTS', 780, 25),
    ('Proyek akhir + UAS', proyekRina, 40),
  ];
  int nilaiAkhir = 0; // dalam perseratusan (persepuluhan x persen / 10)
  for (final (String nama, int nilai, int bobot) in komponenKuliah) {
    final int sumbangan = nilai * bobot ~/ 10;
    nilaiAkhir += sumbangan;
    print(
      '${nama.padRight(18)} ${persepuluhan(nilai).padLeft(4)} x $bobot% '
      '= ${perseratusan(sumbangan).padLeft(5)}',
    );
  }
  print('Nilai akhir mata kuliah: ${perseratusan(nilaiAkhir)}');
}

// OUTPUT:
// === 1. Komponen dan bobotnya ===
// Proposal (P9)                    5  (per tim)
// Laporan kemajuan (P12)          10  (per tim)
// Fungsionalitas                  25  (per tim)
// Arsitektur dan kualitas kode    15  (per tim)
// UI/UX                           10  (per tim)
// Pengujian                       10  (per tim)
// Repositori, rilis, dokumentasi  10  (per tim)
// Presentasi dan tanya jawab      15  (per orang)
// Jumlah semua bobot: 100 (nilai tim maksimal 85)
//
// === 2. Nilai tim "Resep Hemat Anak Kos" ===
// Proposal (P9)                    5 / 5
// Laporan kemajuan (P12)           8 / 10
// Fungsionalitas                  22 / 25
// Arsitektur dan kualitas kode    12 / 15
// UI/UX                            9 / 10
// Pengujian                        8 / 10
// Repositori, rilis, dokumentasi   9 / 10
// Nilai tim: 73 / 85
//
// === 3. Nilai proyek akhir setiap anggota ===
// Rumus: nilai tim x faktor individu + nilai presentasi
// Rina  (73 x 1,0) + 14 = 87,0
// Bima  (73 x 1,0) + 12 = 85,0
// Sari  (73 x 0,8) +  9 = 67,4
//
// === 4. Pengaruh faktor individu (nilai tim 73) ===
// 1,0 -> 85,0  menjelaskan bagiannya dengan benar, kontribusi jelas
// 0,8 -> 70,4  sebagian penjelasan kurang tepat, atau kontribusi kecil
// 0,5 -> 48,5  banyak bagian tidak bisa dijelaskan
// 0,0 -> 12,0  tidak bisa menjelaskan sama sekali, atau tidak berkontribusi
//
// === 5. Skor yang ditolak ===
// DITOLAK: skor Fungsionalitas 30 di luar rentang 0-25
// DITOLAK: komponen Pengujian belum dinilai
// DITOLAK: Presentasi dan tanya jawab dinilai per orang, bukan per tim
// DITOLAK: skor presentasi Dodi 16 di luar rentang 0-15
//
// === 6. Sumbangan pada nilai akhir mata kuliah (Rina) ===
// Praktikum          88,0 x 25% = 22,00
// Kuis               80,0 x 10% =  8,00
// UTS                78,0 x 25% = 19,50
// Proyek akhir + UAS 87,0 x 40% = 34,80
// Nilai akhir mata kuliah: 84,30

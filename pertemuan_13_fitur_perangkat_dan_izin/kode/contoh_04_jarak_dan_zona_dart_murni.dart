// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 13: FITUR PERANGKAT & IZIN
// CONTOH 04: Jarak, Arah, dan Zona (Dart Murni)
// Topik: Setelah aplikasi mendapat koordinat dari GPS, biasanya ada
//        pertanyaan lanjutan: "seberapa jauh dari kampus?" dan "apakah
//        sudah berada di dalam area presensi?". Di sini kita jawab
//        dengan matematika biasa:
//        1. koordinat = lintang (latitude) dan bujur (longitude), dalam
//           derajat;
//        2. jarakMeter() memakai rumus HAVERSINE dengan jari-jari bumi
//           6.378.137 m, sama seperti Geolocator.distanceBetween();
//        3. arahDerajat() dan namaArah(): arah dari satu titik ke titik
//           lain (utara, timur laut, ...), seperti
//           Geolocator.bearingBetween();
//        4. periksaZona(): aturan presensi yang memperhitungkan
//           akurasi GPS dan lokasi palsu.
//        Karena Dart murni, aturan ini mudah diuji tanpa HP.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_04_jarak_dan_zona_dart_murni.dart
// =====================================================================

// Ini program konsol, jadi print() boleh dipakai.
// ignore_for_file: avoid_print

import 'dart:math';

// ------------------------------ KOORDINAT ------------------------------

class Koordinat {
  const Koordinat(this.lintang, this.bujur);

  /// Latitude: -90 (kutub selatan) sampai 90 (kutub utara).
  final double lintang;

  /// Longitude: -180 sampai 180 (positif = sebelah timur Greenwich).
  final double bujur;
}

const double jariJariBumiMeter = 6378137.0;

double _keRadian(double derajat) => derajat * pi / 180;

/// Jarak "garis lurus di permukaan bumi" antara dua titik, dalam meter.
double jarakMeter(Koordinat a, Koordinat b) {
  final double dLintang = _keRadian(b.lintang - a.lintang);
  final double dBujur = _keRadian(b.bujur - a.bujur);
  final double h =
      pow(sin(dLintang / 2), 2) +
      pow(sin(dBujur / 2), 2) *
          cos(_keRadian(a.lintang)) *
          cos(_keRadian(b.lintang));
  return jariJariBumiMeter * 2 * asin(sqrt(h));
}

/// Arah dari [a] ke [b] dalam derajat: 0 = utara, 90 = timur, dan
/// seterusnya searah jarum jam (0 sampai kurang dari 360).
double arahDerajat(Koordinat a, Koordinat b) {
  final double l1 = _keRadian(a.lintang);
  final double l2 = _keRadian(b.lintang);
  final double dBujur = _keRadian(b.bujur - a.bujur);
  final double y = sin(dBujur) * cos(l2);
  final double x = cos(l1) * sin(l2) - sin(l1) * cos(l2) * cos(dBujur);
  final double derajat = atan2(y, x) * 180 / pi; // -180 sampai 180
  return (derajat + 360) % 360;
}

String namaArah(double derajat) {
  const List<String> nama = [
    'utara',
    'timur laut',
    'timur',
    'tenggara',
    'selatan',
    'barat daya',
    'barat',
    'barat laut',
  ];
  // Satu arah mencakup 45 derajat, berpusat pada sudutnya (utara: -22,5
  // sampai 22,5 derajat).
  return nama[((derajat + 22.5) ~/ 45) % 8];
}

/// 850 m, 1,2 km, dan seterusnya (koma sebagai pemisah desimal).
String teksJarak(double meter) {
  if (meter < 1000) return '${meter.round()} m';
  return '${(meter / 1000).toStringAsFixed(1).replaceAll('.', ',')} km';
}

// ------------------------------- ZONA -------------------------------

enum HasilZona {
  diDalam('boleh presensi'),
  diLuar('di luar area'),
  kurangAkurat('lokasi kurang akurat'),
  lokasiPalsu('lokasi palsu terdeteksi');

  const HasilZona(this.keterangan);
  final String keterangan;
}

/// Aturan presensi. Urutan pemeriksaan disengaja:
/// 1. lokasi palsu (aplikasi pemalsu GPS) langsung ditolak;
/// 2. GPS dengan akurasi buruk (lingkaran ketidakpastiannya lebar)
///    belum bisa dipercaya, apa pun jaraknya;
/// 3. baru jaraknya dibandingkan dengan radius.
HasilZona periksaZona({
  required Koordinat posisi,
  required double akurasiMeter,
  required bool palsu,
  required Koordinat pusat,
  double radiusMeter = 100,
  double akurasiMaksimal = 50,
}) {
  if (palsu) return HasilZona.lokasiPalsu;
  if (akurasiMeter > akurasiMaksimal) return HasilZona.kurangAkurat;
  if (jarakMeter(posisi, pusat) > radiusMeter) return HasilZona.diLuar;
  return HasilZona.diDalam;
}

// ------------------------------ PROGRAM ------------------------------

void main() {
  print('=== 1. Satu derajat itu sejauh apa? ===');
  const List<(String, Koordinat, Koordinat)> ukuran = [
    ('1 derajat lintang', Koordinat(0, 0), Koordinat(1, 0)),
    ('1 derajat bujur (khatulistiwa)', Koordinat(0, 0), Koordinat(0, 1)),
    ('1 derajat bujur (lintang 60)', Koordinat(60, 0), Koordinat(60, 1)),
    ('0,0001 derajat lintang', Koordinat(0, 0), Koordinat(0.0001, 0)),
    ('0,00001 derajat lintang', Koordinat(0, 0), Koordinat(0.00001, 0)),
  ];
  for (final (String nama, Koordinat a, Koordinat b) in ukuran) {
    print('${nama.padRight(32)}${teksJarak(jarakMeter(a, b))}');
  }
  print('');

  // Koordinat CONTOH. Ganti dengan koordinat kampus Anda sendiri.
  const Koordinat lab = Koordinat(-0.4700, 117.1580);
  print('=== 2. Jarak dan arah dari lab ===');
  const Map<String, Koordinat> tempat = {
    'Depan pintu lab': Koordinat(-0.4702, 117.1581),
    'Kantin': Koordinat(-0.4709, 117.1593),
    'Gerbang kampus': Koordinat(-0.4741, 117.1552),
    'Rumah kos': Koordinat(-0.4855, 117.1468),
  };
  for (final MapEntry<String, Koordinat> e in tempat.entries) {
    final double jarak = jarakMeter(lab, e.value);
    final double arah = arahDerajat(lab, e.value);
    print(
      '${e.key.padRight(16)}${teksJarak(jarak).padLeft(7)}  '
      'arah ${arah.round()} derajat (${namaArah(arah)})',
    );
  }
  print('');

  print('=== 3. Aturan zona presensi (radius 100 m, akurasi maks 50 m) ===');
  final List<(String, Koordinat, double, bool)> kasus = [
    ('Di depan pintu, akurasi 8 m', tempat['Depan pintu lab']!, 8, false),
    ('Di kantin, akurasi 12 m', tempat['Kantin']!, 12, false),
    ('Di dalam lab, akurasi 120 m', lab, 120, false),
    ('Di dalam lab, pemalsu GPS', lab, 5, true),
    ('Hampir 100 m dari lab', const Koordinat(-0.470898, 117.1580), 10, false),
    ('Sedikit lewat 100 m', const Koordinat(-0.470907, 117.1580), 10, false),
  ];
  for (final (String nama, Koordinat posisi, double akurasi, bool palsu)
      in kasus) {
    final HasilZona hasil = periksaZona(
      posisi: posisi,
      akurasiMeter: akurasi,
      palsu: palsu,
      pusat: lab,
    );
    final String jarak = teksJarak(jarakMeter(lab, posisi));
    print('${nama.padRight(30)}$jarak -> ${hasil.keterangan}');
  }
}

// OUTPUT:
// === 1. Satu derajat itu sejauh apa? ===
// 1 derajat lintang               111,3 km
// 1 derajat bujur (khatulistiwa)  111,3 km
// 1 derajat bujur (lintang 60)    55,7 km
// 0,0001 derajat lintang          11 m
// 0,00001 derajat lintang         1 m
//
// === 2. Jarak dan arah dari lab ===
// Depan pintu lab    25 m  arah 153 derajat (tenggara)
// Kantin            176 m  arah 125 derajat (tenggara)
// Gerbang kampus    553 m  arah 214 derajat (barat daya)
// Rumah kos        2,1 km  arah 216 derajat (barat daya)
//
// === 3. Aturan zona presensi (radius 100 m, akurasi maks 50 m) ===
// Di depan pintu, akurasi 8 m   25 m -> boleh presensi
// Di kantin, akurasi 12 m       176 m -> di luar area
// Di dalam lab, akurasi 120 m   0 m -> lokasi kurang akurat
// Di dalam lab, pemalsu GPS     0 m -> lokasi palsu terdeteksi
// Hampir 100 m dari lab         100 m -> boleh presensi
// Sedikit lewat 100 m           101 m -> di luar area

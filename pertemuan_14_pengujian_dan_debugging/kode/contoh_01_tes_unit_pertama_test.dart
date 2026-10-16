// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 14: PENGUJIAN & DEBUGGING
// CONTOH 01: Tes Unit Pertama
// Topik: Menguji fungsi hitungNilaiAkhir() dan nilaiHuruf() dari studi
//        kasus Pertemuan 2 dengan test() dan expect().
//        Tes di nilai BATAS (tepat 85, 70, 55, dan 40) menemukan bug
//        yang selama ini tersembunyi: komputer menghitung
//        60 x 0,3 + 82 x 0,3 + 31 x 0,4 sebagai 54.99999999999999,
//        sehingga hurufnya D, padahal seharusnya C (tepat 55).
//        Kode di berkas ini SUDAH diperbaiki: nilai akhir dibulatkan dua
//        angka di belakang koma. Modul Bagian 2 menceritakan cara bug
//        ini ditemukan.
//        Judul "BERKAS: ..." menunjukkan letak setiap bagian di proyek
//        Flutter sungguhan.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
//    Hasil tes tampil di panel Console.
// B. Terminal, dari folder utama repositori:
//    flutter test pertemuan_14_pengujian_dan_debugging/kode/contoh_01_tes_unit_pertama_test.dart
// =====================================================================

import 'package:flutter_test/flutter_test.dart';

// ======================= BERKAS: lib/nilai.dart =======================

/// Nilai akhir = 30% tugas + 30% UTS + 40% UAS, dibulatkan dua angka di
/// belakang koma.
double hitungNilaiAkhir({
  required int tugas,
  required int uts,
  required int uas,
}) {
  final double akhir = tugas * 0.3 + uts * 0.3 + uas * 0.4;
  // PERBAIKAN: tanpa pembulatan, nilai 60, 82, 31 menghasilkan
  // 54.99999999999999, bukan 55. Penyebabnya: komputer menyimpan 0,3 dan
  // 0,4 dalam bilangan biner yang sedikit meleset (modul Bagian 2.6).
  return (akhir * 100).round() / 100;
}

String nilaiHuruf(double angka) {
  if (angka >= 85) {
    return 'A';
  } else if (angka >= 70) {
    return 'B';
  } else if (angka >= 55) {
    return 'C';
  } else if (angka >= 40) {
    return 'D';
  }
  return 'E';
}

// ==================== BERKAS: test/nilai_test.dart ====================
// Di proyek sungguhan, baris pertama berkas ini adalah:
//   import 'package:nama_proyek/nilai.dart';
// agar tes bisa memakai fungsi dari folder lib/.

void main() {
  // test('kalimat', () { ... }) = SATU tes. Kalimatnya menjelaskan
  // perilaku yang diharapkan, sehingga mudah dibaca saat tes gagal.
  test('nilai 90 mendapat huruf A', () {
    // 1. SIAPKAN data masukan.
    const double nilai = 90;

    // 2. LAKUKAN hal yang diuji.
    final String huruf = nilaiHuruf(nilai);

    // 3. PERIKSA hasilnya: expect(hasil sebenarnya, hasil yang diharapkan).
    expect(huruf, 'A');
  });

  test('nilai akhir memakai bobot 30%, 30%, dan 40%', () {
    expect(hitungNilaiAkhir(tugas: 80, uts: 70, uas: 90), 81);
  });

  // Nilai BATAS: tepat di garis pemisah, dan satu langkah di bawahnya.
  // Dengan nilai bulat, nilai akhir selalu berkelipatan 0,1, jadi satu
  // langkah di bawah 85 adalah 84,9.
  test('tepat 85 mendapat A, 84,9 mendapat B', () {
    expect(nilaiHuruf(85), 'A');
    expect(nilaiHuruf(84.9), 'B');
  });

  test('tepat 70 mendapat B, 69,9 mendapat C', () {
    expect(nilaiHuruf(70), 'B');
    expect(nilaiHuruf(69.9), 'C');
  });

  test('tepat 55 mendapat C, 54,9 mendapat D', () {
    expect(nilaiHuruf(55), 'C');
    expect(nilaiHuruf(54.9), 'D');
  });

  test('tepat 40 mendapat D, 39,9 mendapat E', () {
    expect(nilaiHuruf(40), 'D');
    expect(nilaiHuruf(39.9), 'E');
  });

  // Tes ini GAGAL pada kode Pertemuan 2, dan berhasil setelah perbaikan.
  test('nilai 60, 82, 31 tepat 55, jadi hurufnya C', () {
    final double akhir = hitungNilaiAkhir(tugas: 60, uts: 82, uas: 31);
    expect(akhir, 55);
    expect(nilaiHuruf(akhir), 'C');
  });

  test('nilai 15, 97, 16 tepat 40, jadi hurufnya D', () {
    final double akhir = hitungNilaiAkhir(tugas: 15, uts: 97, uas: 16);
    expect(akhir, 40);
    expect(nilaiHuruf(akhir), 'D');
  });

  // Perbaikan tidak boleh merusak hasil lama: Andi (Pertemuan 2) tetap B.
  test('Andi (85, 78, 90) tetap 84,9 dan mendapat B', () {
    final double akhir = hitungNilaiAkhir(tugas: 85, uts: 78, uas: 90);
    expect(akhir, 84.9);
    expect(nilaiHuruf(akhir), 'B');
  });
}

// HASIL di DartPad (panel Console):
// 00:00 +0: nilai 90 mendapat huruf A
// 00:00 +1: nilai akhir memakai bobot 30%, 30%, dan 40%
// 00:00 +2: tepat 85 mendapat A, 84,9 mendapat B
// 00:00 +3: tepat 70 mendapat B, 69,9 mendapat C
// 00:00 +4: tepat 55 mendapat C, 54,9 mendapat D
// 00:00 +5: tepat 40 mendapat D, 39,9 mendapat E
// 00:00 +6: nilai 60, 82, 31 tepat 55, jadi hurufnya C
// 00:00 +7: nilai 15, 97, 16 tepat 40, jadi hurufnya D
// 00:00 +8: Andi (85, 78, 90) tetap 84,9 dan mendapat B
// 00:00 +9: All tests passed!

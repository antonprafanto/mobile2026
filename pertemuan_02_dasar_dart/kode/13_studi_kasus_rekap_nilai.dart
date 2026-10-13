// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 02: DASAR PEMROGRAMAN DART
// CONTOH 13: Studi Kasus - Rekap Nilai Satu Kelas
// Topik: Menggabungkan fungsi, Map, List, perulangan, percabangan,
//        dan null safety dalam satu program utuh.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run 13_studi_kasus_rekap_nilai.dart
// =====================================================================

// Nilai akhir = 30% tugas + 30% UTS + 40% UAS
double hitungNilaiAkhir({
  required int tugas,
  required int uts,
  required int uas,
}) {
  return tugas * 0.3 + uts * 0.3 + uas * 0.4;
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

void main() {
  // Kunci = nama mahasiswa, nilai = [tugas, UTS, UAS]
  Map<String, List<int>> kelas = {
    'Andi': [85, 78, 90],
    'Budi': [60, 55, 48],
    'Citra': [95, 88, 92],
    'Dewi': [70, 65, 40],
  };

  int jumlahLulus = 0;
  double totalNilai = 0;
  String? namaTerbaik; // belum diketahui, jadi masih null
  double nilaiTerbaik = 0;

  print('NAMA     AKHIR  HURUF  STATUS');
  for (MapEntry<String, List<int>> data in kelas.entries) {
    List<int> n = data.value;
    double akhir = hitungNilaiAkhir(tugas: n[0], uts: n[1], uas: n[2]);
    String huruf = nilaiHuruf(akhir);
    bool lulus = huruf == 'A' || huruf == 'B' || huruf == 'C';

    if (lulus) {
      jumlahLulus++;
    }
    if (akhir > nilaiTerbaik) {
      nilaiTerbaik = akhir;
      namaTerbaik = data.key;
    }
    totalNilai += akhir;

    String nama = data.key.padRight(8); // rapikan menjadi 8 karakter
    String skor = akhir.toStringAsFixed(1).padLeft(5);
    String status = lulus ? 'Lulus' : 'Mengulang';
    print('$nama $skor  $huruf      $status');
  }

  double rataRata = totalNilai / kelas.length;
  print('--------------------------------');
  print('Rata-rata kelas : ${rataRata.toStringAsFixed(2)}');
  print('Jumlah lulus    : $jumlahLulus dari ${kelas.length} mahasiswa');
  print('Nilai tertinggi : ${namaTerbaik ?? '-'}');
}

// OUTPUT:
// NAMA     AKHIR  HURUF  STATUS
// Andi      84.9  B      Lulus
// Budi      53.7  D      Mengulang
// Citra     91.7  A      Lulus
// Dewi      56.5  C      Lulus
// --------------------------------
// Rata-rata kelas : 71.70
// Jumlah lulus    : 3 dari 4 mahasiswa
// Nilai tertinggi : Citra

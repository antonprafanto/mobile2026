// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 08: OOP & NAMED PARAMETERS
// TOPIK: Class, Constructor, Kata Kunci required, & Default Values
// =====================================================================
// CARA MENJALANKAN:
// 1. Lewat Terminal: dart run slide_08_oop_named_parameters.dart
// 2. Lewat Browser : salin ke https://dartpad.dev lalu klik "Run"
// =====================================================================

class Mahasiswa {
  final String nim;
  final String nama;
  final String jurusan;
  final int semester;
  final bool isAktif;

  Mahasiswa({
    required this.nim,
    required this.nama,
    required this.jurusan,
    this.semester = 1,
    this.isAktif = true,
  });

  void cetakKTM() {
    print('----------------------------------------');
    print('KARTU TANDA MAHASISWA DIGITAL (KTM)');
    print('----------------------------------------');
    print('NIM      : $nim');
    print('Nama     : $nama');
    print('Jurusan  : $jurusan');
    print('Semester : $semester');
    print('Status   : ${isAktif ? "AKTIF KULIAH" : "CUTI AKADEMIK"}');
    print('----------------------------------------');
  }
}

void main() {
  print('=== DEMO OOP MODERN DART: NAMED PARAMETERS ===');

  final mhs1 = Mahasiswa(
    nama: 'Annisa Putri',
    nim: '2210511044',
    jurusan: 'Teknik Informatika',
    semester: 4,
  );

  final mhs2 = Mahasiswa(
    jurusan: 'Sistem Informasi',
    nim: '2210512019',
    nama: 'Rizky Pratama',
  );

  mhs1.cetakKTM();
  print('');
  mhs2.cetakKTM();
  print('');
  print('💡 KORELASI DENGAN FLUTTER:');
  print('Seluruh komponen UI di Flutter dibuat menggunakan pola ini:');
  print('Container(width: 100, height: 50, color: Colors.blue)');
}

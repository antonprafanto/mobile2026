// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 02: DASAR PEMROGRAMAN DART
// CONTOH 11: List (Daftar)
// Topik: Membuat, mengakses, mengubah, menyaring, dan mengurutkan List.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_11_list.dart
// =====================================================================

void main() {
  // 1) List = daftar berurutan. <String> = isinya wajib teks.
  List<String> mataKuliah = ['Basis Data', 'Jaringan', 'Mobile'];
  print(mataKuliah);
  print('Jumlah: ${mataKuliah.length}');

  // 2) Mengakses isi memakai indeks. Indeks SELALU dimulai dari 0!
  print('Pertama: ${mataKuliah[0]}');
  print('Terakhir: ${mataKuliah.last}');

  // 3) Menambah, mengubah, dan menghapus isi
  mataKuliah.add('Kecerdasan Buatan'); // tambah di akhir
  mataKuliah[1] = 'Jaringan Komputer'; // ubah isi indeks 1
  mataKuliah.remove('Basis Data'); // hapus berdasarkan isinya
  print(mataKuliah);

  // 4) Mengecek isi
  print('Ada Mobile? ${mataKuliah.contains('Mobile')}');
  print('Kosong? ${mataKuliah.isEmpty}');

  // 5) Mengolah semua isi dengan for-in
  List<int> nilai = [80, 65, 92, 47, 75];
  int total = 0;
  for (int n in nilai) {
    total += n;
  }
  print('Total: $total, rata-rata: ${total / nilai.length}');

  // 6) where = menyaring, map = mengubah setiap isi. Akhiri dengan toList().
  List<int> nilaiLulus = nilai.where((int n) => n >= 60).toList();
  List<String> label = nilai.map((int n) => 'Nilai $n').toList();
  print('Yang lulus: $nilaiLulus');
  print(label);

  // 7) Mengurutkan dari kecil ke besar (isi list asli ikut berubah)
  nilai.sort();
  print('Setelah diurutkan: $nilai');
}

// OUTPUT:
// [Basis Data, Jaringan, Mobile]
// Jumlah: 3
// Pertama: Basis Data
// Terakhir: Mobile
// [Jaringan Komputer, Mobile, Kecerdasan Buatan]
// Ada Mobile? true
// Kosong? false
// Total: 359, rata-rata: 71.8
// Yang lulus: [80, 65, 92, 75]
// [Nilai 80, Nilai 65, Nilai 92, Nilai 47, Nilai 75]
// Setelah diurutkan: [47, 65, 75, 80, 92]

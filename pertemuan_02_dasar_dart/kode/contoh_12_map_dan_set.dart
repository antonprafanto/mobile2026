// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 02: DASAR PEMROGRAMAN DART
// CONTOH 12: Map dan Set
// Topik: Pasangan kunci-nilai (Map) dan kumpulan nilai unik (Set).
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_12_map_dan_set.dart
// =====================================================================

void main() {
  // ===== MAP: pasangan kunci -> nilai, seperti kamus =====
  Map<String, int> stokBuah = {'Apel': 12, 'Mangga': 5, 'Durian': 2};
  print('Stok mangga: ${stokBuah['Mangga']}');

  stokBuah['Jeruk'] = 20; // kunci baru -> pasangan baru ditambahkan
  stokBuah['Apel'] = 10; // kunci lama -> nilainya diganti
  stokBuah.remove('Durian'); // hapus pasangan
  print(stokBuah);

  // Kunci yang tidak ada menghasilkan null, jadi siapkan nilai cadangan.
  print('Stok salak: ${stokBuah['Salak'] ?? 0}');
  print('Ada Jeruk? ${stokBuah.containsKey('Jeruk')}');

  // Menelusuri semua pasangan kunci-nilai
  for (MapEntry<String, int> item in stokBuah.entries) {
    print('${item.key} tersisa ${item.value} buah');
  }

  // Map dengan nilai beragam tipe. Bentuk seperti ini akan sering kita
  // temui saat mengambil data dari internet (format JSON) di Pertemuan 10.
  Map<String, Object> mahasiswa = {
    'nama': 'Laila',
    'semester': 3,
    'aktif': true,
  };
  print('${mahasiswa['nama']} semester ${mahasiswa['semester']}');

  // ===== SET: kumpulan nilai UNIK (tidak ada yang kembar) =====
  List<String> daftarIsian = ['Andi', 'Budi', 'Andi', 'Citra'];
  Set<String> peminat = daftarIsian.toSet(); // nama kembar otomatis dibuang
  print(peminat);
  peminat.add('Dewi');
  peminat.add('Budi'); // diabaikan karena sudah ada
  print('Jumlah peminat unik: ${peminat.length}');
}

// OUTPUT:
// Stok mangga: 5
// {Apel: 10, Mangga: 5, Jeruk: 20}
// Stok salak: 0
// Ada Jeruk? true
// Apel tersisa 10 buah
// Mangga tersisa 5 buah
// Jeruk tersisa 20 buah
// Laila semester 3
// {Andi, Budi, Citra}
// Jumlah peminat unik: 4

// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 11: TIGA KOLEKSI DATA UTAMA DART
// TOPIK: Memahami Kapan Menggunakan List<T>, Set<T>, dan Map<K, V>
// =====================================================================
// CARA MENJALANKAN:
// 1. Lewat Terminal: dart run slide_11_collections_list_map_set.dart
// 2. Lewat Browser : salin ke https://dartpad.dev lalu klik "Run"
// =====================================================================

void main() {
  print('=== TIGA KOLEKSI DATA UTAMA DART ===');
  print('');

  // 1. LIST<T>: Berurutan, memiliki indeks (0, 1, 2), boleh ada duplikat
  final List<String> riwayatPesanan = [
    'Kopi Latte',
    'Roti Bakar',
    'Kopi Latte',
  ];
  riwayatPesanan.add('Es Teh Manis');

  print('1. LIST<String> (Berurutan & Ada Duplikat):');
  print('• Total item : ${riwayatPesanan.length}');
  print('• Isi daftar : $riwayatPesanan');
  print('• Item ke-0  : ${riwayatPesanan[0]}');
  print('');

  // 2. SET<T>: Tidak berurutan, DIJAMIN UNIK (duplikat otomatis dibuang)
  final Set<String> tagMinatMahasiswa = {'Mobile', 'Web', 'AI'};
  tagMinatMahasiswa.add('Cybersecurity');
  tagMinatMahasiswa.add('Mobile'); // Otomatis diabaikan karena sudah ada!

  print('2. SET<String> (Dijamin Unik Tanpa Duplikasi):');
  print('• Total tag unik : ${tagMinatMahasiswa.length}');
  print('• Isi himpunan   : $tagMinatMahasiswa');
  print('');

  // 3. MAP<K, V>: Pasangan Kunci & Nilai (Key-Value ala JSON)
  final Map<String, dynamic> profilPengguna = {
    'id': 101,
    'username': 'andi_mobile',
    'namaLengkap': 'Andi Setiawan',
    'isVerified': true,
    'saldoDompet': 250000,
  };

  print('3. MAP<String, dynamic> (Format JSON REST API):');
  print('• ID Pengguna   : ${profilPengguna['id']}');
  print('• Nama Lengkap  : ${profilPengguna['namaLengkap']}');
  print(
    '• Status Akun   : ${profilPengguna['isVerified'] ? "Terverifikasi" : "Belum"}',
  );
  print('• Saldo E-Money : Rp ${profilPengguna['saldoDompet']}');
}

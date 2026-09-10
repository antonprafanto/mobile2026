// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 12: OPERASI REAKTIF .WHERE() & .MAP()
// TOPIK: Memanipulasi & Mengubah Koleksi Data Secara Fungsional Elegan
// =====================================================================
// CARA MENJALANKAN:
// 1. Lewat Terminal: dart run slide_12_reactive_collections.dart
// 2. Lewat Browser : salin ke https://dartpad.dev lalu klik "Run"
// =====================================================================

class MenuKafe {
  final String nama;
  final int harga;
  final bool isFavorit;

  MenuKafe({required this.nama, required this.harga, this.isFavorit = false});

  @override
  String toString() => '$nama (Rp $harga)';
}

void main() {
  print('=== OPERASI KOLEKSI REAKTIF: .WHERE() & .MAP() ===');
  print('');

  final List<MenuKafe> daftarMenu = [
    MenuKafe(nama: 'Kopi Tubruk', harga: 8000),
    MenuKafe(nama: 'Caramel Macchiato', harga: 28000, isFavorit: true),
    MenuKafe(nama: 'Americano', harga: 15000),
    MenuKafe(nama: 'Matcha Latte', harga: 25000, isFavorit: true),
    MenuKafe(nama: 'Teh Hangat', harga: 5000),
  ];

  print('Daftar Seluruh Menu Asli (${daftarMenu.length} item):');
  for (var m in daftarMenu) {
    print('• $m');
  }
  print('');

  // 1. METODE .where() -> Menyaring (Filter) Berdasarkan Kondisi
  final menuHemat = daftarMenu.where((item) => item.harga < 20000).toList();

  print('1. Hasil Filter .where() (Harga < Rp 20.000):');
  print('• Ditemukan ${menuHemat.length} menu hemat: $menuHemat');
  print('');

  // 2. METODE .map() -> Mengubah (Transformasi) Bentuk Objek
  final daftarLabelVisual = menuHemat.map((item) {
    return '☕ [PROMO] ${item.nama.toUpperCase()} HANYA Rp ${item.harga},-';
  }).toList();

  print('2. Hasil Transformasi .map() (Siap Ditampilkan di Layar):');
  for (var label in daftarLabelVisual) {
    print('  $label');
  }
  print('');
  print('💡 MENGAPA INI PENTING DI FLUTTER?');
  print(
    'Di Minggu ke-3, kita akan mengubah daftar data mentah menjadi Widget visual:',
  );
  print('Column(children: daftarMenu.map((m) => CardMenu(m)).toList())');
}

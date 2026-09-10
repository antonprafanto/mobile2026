// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 03: MINDSET PEMULA & PENGOLAHAN LOGIKA
// TOPIK: Mengapa Logika Dart Lebih Utama Sebelum Merancang UI Flutter?
// =====================================================================
// CARA MENJALANKAN:
// 1. Lewat Terminal: dart run slide_03_mindset_dart_logika.dart
// 2. Lewat Browser : salin ke https://dartpad.dev lalu klik "Run"
// =====================================================================

void main() {
  print('=== SIMULASI SISTEM KASIR KAFE KAMPUS ===');

  // Data masukan pesanan:
  final String namaItem = 'Kopi Susu Gula Aren';
  final int hargaSatuan = 24000;
  final int jumlahBeli = 3;
  final double persentaseDiskon = 0.15; // Diskon 15% mahasiswa

  // 1. Hitung subtotal kotor
  final int subtotal = hargaSatuan * jumlahBeli;

  // 2. Hitung potongan diskon (konversi ke double lalu bulatkan)
  final double nominalPotongan = subtotal * persentaseDiskon;

  // 3. Hitung total akhir yang wajib dibayar di kasir
  final double totalBayar = subtotal - nominalPotongan;

  // Cetak struk rincian:
  print('Item Pesanan       : $namaItem');
  print('Harga Satuan       : Rp $hargaSatuan');
  print('Jumlah             : $jumlahBeli gelas');
  print('Subtotal           : Rp $subtotal');
  print('Diskon Mahasiswa   : 15% (- Rp ${nominalPotongan.toInt()})');
  print('-----------------------------------------');
  print('TOTAL AKHIR BAYAR  : Rp ${totalBayar.toInt()}');
  print('-----------------------------------------');
  print('💡 CATATAN:');
  print('Tombol UI di Flutter hanyalah cangkang visual.');
  print('Logika perhitungan di atas 100% diproses oleh bahasa Dart!');
}

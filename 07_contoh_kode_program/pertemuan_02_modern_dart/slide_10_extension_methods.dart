// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 10: EXTENSION METHODS
// TOPIK: Menambahkan Kemampuan Baru ke Class Bawaan Tanpa Ubah Source Code
// =====================================================================
// CARA MENJALANKAN:
// 1. Lewat Terminal: dart run slide_10_extension_methods.dart
// 2. Lewat Browser : salin ke https://dartpad.dev lalu klik "Run"
// =====================================================================

extension FormatRupiahExtension on int {
  String toRupiah() {
    final str = toString();
    final buffer = StringBuffer('Rp ');
    final length = str.length;
    for (int i = 0; i < length; i++) {
      if (i > 0 && (length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(str[i]);
    }
    return buffer.toString();
  }
}

extension EmailKampusExtension on String {
  bool get isEmailKampusValid {
    return endsWith('@mhs.kampus.ac.id') || endsWith('@kampus.ac.id');
  }

  String get kapitalAwal {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

void main() {
  print('=== DEMO EXTENSION METHODS DART ===');

  final int hargaLaptop = 14500000;
  final int uangJajan = 25000;

  print('Format Angka Biasa ke Rupiah:');
  print('• Harga Laptop : ${hargaLaptop.toRupiah()}');
  print('• Uang Saku    : ${uangJajan.toRupiah()}');
  print('');

  final email1 = 'ahmad.fauzi@mhs.kampus.ac.id';
  final email2 = 'budi_gamer@gmail.com';

  print('Validasi Email Kampus:');
  print(
    '• $email1 -> ${email1.isEmailKampusValid ? "VALID (Email Resmi)" : "DITOLAK"}',
  );
  print(
    '• $email2 -> ${email2.isEmailKampusValid ? "VALID (Email Resmi)" : "DITOLAK (Wajib Email Kampus)"}',
  );
  print('');

  final kata = 'flutter';
  print('Ubah Kapital Awal: "$kata" -> "${kata.kapitalAwal}"');
  print('');
  print('💡 DI FLUTTER:');
  print('Banyak developer membuat extension pada BuildContext, misalnya:');
  print(
    'context.lebarLayar (menggantikan MediaQuery.of(context).size.width yang panjang).',
  );
}

// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 16: SOLUSI MASTER LAB QUEST MODUL 02
// TOPIK: Simulasi Antrean Cerdas Kafe Kampus, Validasi Null, & Stream
// =====================================================================
// CARA MENJALANKAN:
// 1. Lewat Terminal: dart run slide_16_lab_quest_tugas_02.dart
// 2. Lewat Browser : salin ke https://dartpad.dev lalu klik "Run"
// 3. Tunjukkan output terminal kepada Dosen/Asisten Lab untuk penilaian Modul 2!
// =====================================================================

class PesananKopi {
  final String namaPemesan;
  final String namaKopi;
  final int harga;
  final String? catatanKhusus;

  PesananKopi({
    required this.namaPemesan,
    required this.namaKopi,
    required this.harga,
    this.catatanKhusus,
  });

  String get infoCatatan => catatanKhusus ?? 'Standar Normal (Tanpa Catatan)';

  void cetakStruk() {
    print('========================================');
    print('STRUK PESANAN KAFE KAMPUS 2026');
    print('========================================');
    print('Nama Pemesan : $namaPemesan');
    print('Menu Kopi    : $namaKopi');
    print('Harga        : Rp $harga');
    print('Catatan      : $infoCatatan');
    print('========================================');
  }
}

Future<bool> prosesPembayaran(PesananKopi p) async {
  print('⏳ Sedang memproses transaksi pembayaran untuk ${p.namaPemesan}...');
  await Future.delayed(const Duration(milliseconds: 1000));

  if (p.harga <= 0) {
    throw Exception('GAGAL: Harga pesanan tidak valid (Rp ${p.harga})!');
  }

  return true;
}

Stream<String> lacakPembuatanKopi(String namaKopi) async* {
  final tahapan = [
    '1. Menimbang biji kopi arabika pilihan...',
    '2. Menggiling biji kopi dengan grinder halus...',
    '3. Ekstraksi espresso & memanaskan susu segar...',
    '4. Menuangkan latte art ke cangkir...',
    '5. Pesanan $namaKopi SIAP DIAMBIL!',
  ];

  for (var tahap in tahapan) {
    await Future.delayed(const Duration(milliseconds: 700));
    yield tahap;
  }
}

Future<void> main() async {
  print('✦ PROGRAM SISTEM ANTREAN CERDAS KAFE KAMPUS ✦');
  print('');

  final pesanan1 = PesananKopi(
    namaPemesan: 'Ahmad Fauzan (Mahasiswa)',
    namaKopi: 'Iced Vanilla Caramel Latte',
    harga: 28000,
    catatanKhusus: 'Kurangi gula (less sugar 50%) & es sedikit',
  );

  final pesanan2 = PesananKopi(
    namaPemesan: 'Dina Marlina (Dosen)',
    namaKopi: 'Espresso Double Shot',
    harga: 18000,
  );

  pesanan1.cetakStruk();
  print('');
  pesanan2.cetakStruk();
  print('');

  try {
    final bayarSukses = await prosesPembayaran(pesanan1);
    if (bayarSukses) {
      print('✅ Pembayaran Berhasil Dikonfirmasi!');
      print('');
      print('☕ MEMULAI PROSES DI DAPUR BARISTA:');

      await for (String statusDapur in lacakPembuatanKopi(pesanan1.namaKopi)) {
        print('   $statusDapur');
      }
    }
  } catch (e) {
    print('🚨 Terjadi Galat: $e');
  }

  print('');
  print('----------------------------------------');
  print('🎉 PRAKTIKUM PERTEMUAN 02 BERHASIL DISELESAIKAN!');
  print('Tunjukkan hasil ini ke Dosen / Asisten Lab.');
  print('----------------------------------------');
}

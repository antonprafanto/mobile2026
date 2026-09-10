// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 13: SINKRON VS ASINKRON
// TOPIK: Mengapa Layar Ponsel Tidak Boleh Membeku (Freezing / ANR)?
// =====================================================================
// CARA MENJALANKAN:
// 1. Lewat Terminal: dart run slide_13_dilema_sync_vs_async.dart
// 2. Lewat Browser : salin ke https://dartpad.dev lalu klik "Run"
// =====================================================================

void simulasiAsinkronKasir() {
  print('--- SIMULASI PROSES ASINKRON DIMULAI ---');
  print('[00.00 detik] 1. Pelanggan A memesan Cappuccino Panas.');
  print('[00.00 detik] 2. Kasir mencatat pesanan & memberikan nomor antrean.');

  // Proses di latar belakang:
  Future.delayed(const Duration(seconds: 2), () {
    print('');
    print(
      '[02.00 detik] 🔔 LONCENG BERBUNYI: Cappuccino Pelanggan A selesai diseduh!',
    );
    print('               Pelanggan A mengambil pesanannya di konter.');
  });

  print(
    '[00.01 detik] 3. Kasir langsung menyapa Pelanggan B ("Mau pesan apa, Kak?").',
  );
  print('[00.02 detik] 4. Pelanggan B memesan Donat Cokelat.');
  print('[00.03 detik] 5. Antarmuka aplikasi tetap lancar 120 FPS bebas lag!');
}

void main() {
  print('=== ANALOGI SINKRON VS ASINKRON (KASIR KAFE) ===');
  print('');
  simulasiAsinkronKasir();
  print('');
  print('💡 PERHATIKAN URUTAN LOG TERMINAL DI ATAS:');
  print('Langkah 1, 2, 3, 4, 5 berjalan instan tanpa menunggu 2 detik.');
  print('Setelah 2 detik berlalu, lonceng matang baru berbunyi!');
}

// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 09: MIXINS (KATA KUNCI 'WITH')
// TOPIK: Berbagi Kemampuan Modular Lintas Class Tanpa Warisan Kaku
// =====================================================================
// CARA MENJALANKAN:
// 1. Lewat Terminal: dart run slide_09_mixins_with_keyword.dart
// 2. Lewat Browser : salin ke https://dartpad.dev lalu klik "Run"
// =====================================================================

mixin LoggerMixin {
  void logInfo(String pesan) {
    final waktu = DateTime.now().toIso8601String().substring(11, 19);
    print('[$waktu | INFO]  $pesan');
  }

  void logError(String galat) {
    print('🚨 [ERROR LOG] Terjadi kesalahan: $galat');
  }
}

mixin ValidatorKeamanan {
  bool cekPinTransaksi(String pin) =>
      pin.length == 6 && int.tryParse(pin) != null;
}

class LayananDompetDigital with LoggerMixin, ValidatorKeamanan {
  final String namaPengguna;
  int saldo;

  LayananDompetDigital({required this.namaPengguna, required this.saldo});

  void transfer(int nominal, String pin) {
    logInfo(
      'Mencoba transfer dana sebesar Rp $nominal untuk akun: $namaPengguna',
    );

    if (!cekPinTransaksi(pin)) {
      logError('PIN Keamanan tidak valid! Harus 6 digit angka.');
      return;
    }

    if (nominal > saldo) {
      logError('Saldo tidak mencukupi! Saldo saat ini: Rp $saldo');
      return;
    }

    saldo -= nominal;
    logInfo('Transfer sukses! Sisa saldo akun $namaPengguna: Rp $saldo');
  }
}

void main() {
  print('=== DEMO DART MIXINS ("with") ===');

  final akun = LayananDompetDigital(namaPengguna: 'fauzan_2026', saldo: 150000);

  // Uji coba 1: PIN Salah
  akun.transfer(50000, '1234');
  print('');

  // Uji coba 2: Saldo Kurang
  akun.transfer(200000, '123456');
  print('');

  // Uji coba 3: Berhasil
  akun.transfer(75000, '654321');
  print('');
  print('💡 DI FLUTTER:');
  print('Anda akan menggunakan mixin "SingleTickerProviderStateMixin"');
  print('saat membuat animasi halus 60-120 FPS di layar!');
}

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 14: PENGUJIAN & DEBUGGING
// CONTOH 02: Matcher, setUp, dan group
// Topik: Menguji "Keranjang Kantin" dan fungsi rupiah() dengan:
//        - matcher: isTrue, isEmpty, hasLength, contains, equals,
//          closeTo, isA<...>().having(...);
//        - pengecualian (exception): throwsArgumentError, throwsStateError,
//          dan throwsA(...);
//        - setUp(): keranjang baru untuk SETIAP tes;
//        - group(): mengelompokkan tes yang berhubungan;
//        - tabel kasus: banyak pasangan masukan-harapan dalam satu Map;
//        - nilai batas diskon: Rp49.000 belum, Rp50.000 sudah.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
//    Hasil tes tampil di panel Console.
// B. Terminal, dari folder utama repositori:
//    flutter test pertemuan_14_pengujian_dan_debugging/kode/contoh_02_matcher_setup_dan_group_test.dart
// =====================================================================

import 'package:flutter_test/flutter_test.dart';

// ================== BERKAS: lib/domain/keranjang.dart ==================

class Menu {
  const Menu(this.nama, this.harga);

  final String nama;
  final int harga; // dalam rupiah
}

/// 12500 -> 'Rp12.500'. Bilangan negatif diberi tanda minus di depan.
String rupiah(int angka) {
  final String digit = angka.abs().toString();
  final StringBuffer hasil = StringBuffer();
  for (int i = 0; i < digit.length; i++) {
    // Titik dipasang setiap tiga angka, dihitung dari belakang.
    if (i > 0 && (digit.length - i) % 3 == 0) {
      hasil.write('.');
    }
    hasil.write(digit[i]);
  }
  return '${angka < 0 ? '-' : ''}Rp$hasil';
}

class Keranjang {
  /// Belanja mulai Rp50.000 mendapat diskon 10%.
  static const int batasDiskon = 50000;

  /// Satu menu paling banyak 10 porsi.
  static const int maksimalPorsi = 10;

  // Kunci = nama menu. Map menjaga urutan menu sesuai urutan ditambahkan.
  final Map<String, Menu> _menu = {};
  final Map<String, int> _porsi = {};

  bool get kosong => _porsi.isEmpty;

  int get jumlahPorsi => _porsi.values.fold(0, (int a, int b) => a + b);

  int porsiDari(Menu menu) => _porsi[menu.nama] ?? 0;

  int get subtotal {
    int total = 0;
    for (final String nama in _porsi.keys) {
      total += _menu[nama]!.harga * _porsi[nama]!;
    }
    return total;
  }

  int get diskon => subtotal >= batasDiskon ? subtotal ~/ 10 : 0;

  int get total => subtotal - diskon;

  /// Harga rata-rata per porsi (bilangan desimal).
  double get rataRataPerPorsi => kosong ? 0 : subtotal / jumlahPorsi;

  /// Contoh: ['2 x Nasi goreng = Rp24.000', '1 x Es teh = Rp4.000'].
  List<String> get rincian => [
    for (final String nama in _porsi.keys)
      '${_porsi[nama]} x $nama = ${rupiah(_menu[nama]!.harga * _porsi[nama]!)}',
  ];

  void tambah(Menu menu, {int jumlah = 1}) {
    if (jumlah < 1) {
      // ArgumentError: ISI argumennya salah.
      throw ArgumentError.value(jumlah, 'jumlah', 'minimal 1');
    }
    final int baru = porsiDari(menu) + jumlah;
    if (baru > maksimalPorsi) {
      // StateError: argumennya wajar, tetapi KEADAAN keranjang menolak.
      throw StateError(
        'Paling banyak $maksimalPorsi porsi ${menu.nama} sekali pesan.',
      );
    }
    _menu[menu.nama] = menu;
    _porsi[menu.nama] = baru;
  }

  void kurangi(Menu menu) {
    final int sekarang = porsiDari(menu);
    if (sekarang == 0) {
      throw StateError('${menu.nama} tidak ada di keranjang.');
    }
    if (sekarang == 1) {
      _menu.remove(menu.nama);
      _porsi.remove(menu.nama);
    } else {
      _porsi[menu.nama] = sekarang - 1;
    }
  }

  void kosongkan() {
    _menu.clear();
    _porsi.clear();
  }
}

// ================== BERKAS: test/domain/keranjang_test.dart ==================

void main() {
  // group('nama', () { ... }) mengelompokkan tes. Nama kelompok ikut
  // tertulis di depan nama setiap tes di dalamnya.
  group('rupiah()', () {
    // TABEL KASUS: setiap baris = satu masukan dan hasil yang diharapkan.
    // Menambah kasus cukup menambah satu baris.
    const Map<int, String> kasus = {
      0: 'Rp0',
      500: 'Rp500',
      1000: 'Rp1.000',
      12500: 'Rp12.500',
      150000: 'Rp150.000',
      1000000: 'Rp1.000.000',
      -2500: '-Rp2.500',
    };
    kasus.forEach((int angka, String harapan) {
      test('$angka menjadi $harapan', () {
        expect(rupiah(angka), harapan);
      });
    });
  });

  group('Keranjang', () {
    const Menu nasiGoreng = Menu('Nasi goreng', 12000);
    const Menu ayamGeprek = Menu('Ayam geprek', 15000);
    const Menu esTeh = Menu('Es teh', 4000);

    // late: diisi di setUp, sebelum dipakai.
    late Keranjang keranjang;

    // setUp() dijalankan SEBELUM SETIAP tes di kelompok ini. Setiap tes
    // mendapat keranjang baru yang kosong, sehingga tes tidak saling
    // memengaruhi dan urutannya boleh diacak.
    setUp(() {
      keranjang = Keranjang();
    });

    test('keranjang baru masih kosong', () {
      expect(keranjang.kosong, isTrue);
      expect(keranjang.rincian, isEmpty);
      expect(keranjang.total, 0);
    });

    test('menu yang sama ditambah lagi: porsinya dijumlahkan', () {
      keranjang.tambah(nasiGoreng);
      keranjang.tambah(nasiGoreng, jumlah: 2);

      expect(keranjang.porsiDari(nasiGoreng), 3);
      expect(keranjang.rincian, hasLength(1));
      expect(keranjang.rincian, contains('3 x Nasi goreng = Rp36.000'));
    });

    test('rincian berurutan sesuai urutan menambah', () {
      keranjang
        ..tambah(esTeh, jumlah: 2)
        ..tambah(nasiGoreng);

      expect(
        keranjang.rincian,
        equals(['2 x Es teh = Rp8.000', '1 x Nasi goreng = Rp12.000']),
      );
    });

    test('mengurangi porsi terakhir menghapus barisnya', () {
      keranjang.tambah(esTeh);
      keranjang.kurangi(esTeh);

      expect(keranjang.kosong, isTrue);
    });

    test('rata-rata harga per porsi', () {
      keranjang
        ..tambah(nasiGoreng)
        ..tambah(esTeh, jumlah: 2);

      // 20000 / 3 = 6666,666... Bilangan desimal dibandingkan dengan
      // closeTo(nilai, toleransi), bukan dengan sama persis.
      expect(keranjang.rataRataPerPorsi, closeTo(6666.67, 0.01));
    });

    // Kelompok di dalam kelompok: nilai BATAS diskon.
    group('diskon 10% mulai Rp50.000', () {
      test('Rp49.000 belum mendapat diskon', () {
        keranjang
          ..tambah(ayamGeprek, jumlah: 3) // 45.000
          ..tambah(esTeh); // 4.000

        expect(keranjang.subtotal, 49000);
        expect(keranjang.diskon, 0);
        expect(keranjang.total, 49000);
      });

      test('tepat Rp50.000 mendapat diskon Rp5.000', () {
        keranjang
          ..tambah(ayamGeprek, jumlah: 2) // 30.000
          ..tambah(esTeh, jumlah: 5); // 20.000

        expect(keranjang.subtotal, 50000);
        expect(keranjang.diskon, 5000);
        expect(keranjang.total, 45000);
      });
    });

    group('pesanan yang ditolak', () {
      test('jumlah 0 ditolak dengan ArgumentError', () {
        // Kode yang DIHARAPKAN melempar exception dibungkus fungsi () =>,
        // agar expect sendiri yang menjalankan dan menangkapnya.
        expect(() => keranjang.tambah(esTeh, jumlah: 0), throwsArgumentError);
        // Pesanan yang ditolak tidak boleh mengubah isi keranjang.
        expect(keranjang.kosong, isTrue);
      });

      test('porsi ke-11 ditolak dan pesannya jelas', () {
        keranjang.tambah(esTeh, jumlah: 10);

        expect(
          () => keranjang.tambah(esTeh),
          throwsA(
            isA<StateError>().having(
              (StateError e) => e.message,
              'message',
              contains('Paling banyak 10 porsi Es teh'),
            ),
          ),
        );
        expect(keranjang.porsiDari(esTeh), 10);
      });

      test('mengurangi menu yang tidak ada ditolak', () {
        expect(() => keranjang.kurangi(nasiGoreng), throwsStateError);
      });
    });
  });
}

// HASIL di DartPad (panel Console), diringkas:
// 00:00 +0: rupiah() 0 menjadi Rp0
// 00:00 +1: rupiah() 500 menjadi Rp500
// ...
// 00:00 +7: Keranjang keranjang baru masih kosong
// ...
// 00:00 +13: Keranjang diskon 10% mulai Rp50.000 tepat Rp50.000 mendapat diskon Rp5.000
// ...
// 00:00 +17: All tests passed!

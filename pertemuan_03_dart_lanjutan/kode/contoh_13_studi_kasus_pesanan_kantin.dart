// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 03: DART LANJUTAN
// CONTOH 13: Studi Kasus - Sistem Pesanan Kantin
// Topik: Menggabungkan class, enum, exception, Future, dan Stream dalam
//        satu program utuh.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_13_studi_kasus_pesanan_kantin.dart
// =====================================================================

// Tahapan sebuah pesanan, dari awal sampai siap diambil.
enum StatusPesanan {
  diterima('Pesanan diterima'),
  dimasak('Sedang dimasak'),
  siap('Siap diambil');

  const StatusPesanan(this.label);
  final String label;
}

class Menu {
  final String nama;
  final int harga;
  int stok;

  Menu(this.nama, this.harga, this.stok);
}

class StokHabisException implements Exception {
  final String namaMenu;

  StokHabisException(this.namaMenu);

  @override
  String toString() => 'Maaf, $namaMenu sudah habis.';
}

class Kantin {
  final Map<String, Menu> _daftarMenu = {
    'Nasi Goreng': Menu('Nasi Goreng', 15000, 5),
    'Es Teh': Menu('Es Teh', 4000, 1),
  };
  int _nomorTerakhir = 0;

  // Mengirim pesanan ke "dapur". Butuh waktu, jadi mengembalikan Future.
  Future<int> pesan(String namaMenu) async {
    await Future.delayed(Duration(milliseconds: 300));
    Menu? menu = _daftarMenu[namaMenu];
    if (menu == null) {
      throw Exception('Menu $namaMenu tidak tersedia di kantin ini.');
    }
    if (menu.stok == 0) {
      throw StokHabisException(namaMenu);
    }
    menu.stok--;
    _nomorTerakhir++;
    return _nomorTerakhir;
  }

  // Memantau status pesanan. Statusnya berubah beberapa kali -> Stream.
  // (Di aplikasi sungguhan, nomor dipakai untuk menanyakan status pesanan
  // tersebut ke server. Di sini perubahan statusnya hanya disimulasikan.)
  Stream<StatusPesanan> pantauStatus(int nomor) async* {
    for (StatusPesanan status in StatusPesanan.values) {
      await Future.delayed(Duration(milliseconds: 400));
      yield status;
    }
  }
}

Future<void> main() async {
  Kantin kantin = Kantin();
  List<String> antreanPesanan = ['Nasi Goreng', 'Es Teh', 'Es Teh', 'Sate'];

  for (String namaMenu in antreanPesanan) {
    try {
      int nomor = await kantin.pesan(namaMenu);
      print('Pesanan #$nomor: $namaMenu');
      await for (StatusPesanan status in kantin.pantauStatus(nomor)) {
        print('  #$nomor -> ${status.label}');
      }
    } on StokHabisException catch (e) {
      print('Gagal memesan: $e Silakan pilih menu lain.');
    } catch (e) {
      print('Gagal memesan: $e');
    }
  }
  print('Kantin tutup. Terima kasih!');
}

// OUTPUT:
// Pesanan #1: Nasi Goreng
//   #1 -> Pesanan diterima
//   #1 -> Sedang dimasak
//   #1 -> Siap diambil
// Pesanan #2: Es Teh
//   #2 -> Pesanan diterima
//   #2 -> Sedang dimasak
//   #2 -> Siap diambil
// Gagal memesan: Maaf, Es Teh sudah habis. Silakan pilih menu lain.
// Gagal memesan: Exception: Menu Sate tidak tersedia di kantin ini.
// Kantin tutup. Terima kasih!

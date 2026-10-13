// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 03: DART LANJUTAN
// CONTOH 04: Enkapsulasi dengan Getter dan Setter
// Topik: Properti privat (_), getter, setter, dan validasi data.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_04_enkapsulasi.dart
// =====================================================================

class RekeningTabungan {
  final String pemilik;

  // Garis bawah (_) di depan nama = PRIVAT. Dari berkas lain, properti ini
  // tidak bisa disentuh langsung; perubahannya wajib lewat method resmi.
  int _saldo = 0;
  final List<String> _riwayat = [];

  RekeningTabungan(this.pemilik);

  // Getter: "jendela" untuk MELIHAT saldo tanpa bisa mengubahnya.
  int get saldo => _saldo;

  // Getter terhitung: nilainya dihitung setiap kali diminta.
  bool get kosong => _saldo == 0;

  // Mengembalikan salinan yang tidak bisa diubah, supaya riwayat aman.
  List<String> get riwayat => List.unmodifiable(_riwayat);

  void setor(int jumlah) {
    if (jumlah <= 0) {
      print('Setoran Rp$jumlah ditolak: jumlah harus lebih dari 0.');
      return;
    }
    _saldo += jumlah;
    _riwayat.add('setor $jumlah');
  }

  void tarik(int jumlah) {
    if (jumlah > _saldo) {
      print('Penarikan Rp$jumlah ditolak: saldo tidak cukup.');
      return;
    }
    _saldo -= jumlah;
    _riwayat.add('tarik $jumlah');
  }
}

class ProfilMahasiswa {
  final String nama;
  double _ipk = 0;

  ProfilMahasiswa(this.nama);

  double get ipk => _ipk;

  // Setter: dipanggil saat kita menulis profil.ipk = ...
  // Di sinilah kita menjaga agar data yang masuk selalu masuk akal.
  set ipk(double nilai) {
    if (nilai < 0 || nilai > 4) {
      print('IPK $nilai tidak valid. Harus di antara 0 dan 4.');
      return;
    }
    _ipk = nilai;
  }
}

void main() {
  RekeningTabungan rekening = RekeningTabungan('Dewi');
  print('Rekening kosong? ${rekening.kosong}');
  rekening.setor(150000);
  rekening.setor(-5000);
  rekening.tarik(200000);
  rekening.tarik(50000);
  print('Saldo ${rekening.pemilik}: Rp${rekening.saldo}');
  print('Riwayat: ${rekening.riwayat}');
  // rekening.saldo = 1000000; // ERROR: saldo hanya punya getter

  ProfilMahasiswa profil = ProfilMahasiswa('Dewi');
  profil.ipk = 3.65; // memanggil setter
  profil.ipk = 4.5; // ditolak oleh validasi di setter
  print('IPK ${profil.nama}: ${profil.ipk}');
}

// OUTPUT:
// Rekening kosong? true
// Setoran Rp-5000 ditolak: jumlah harus lebih dari 0.
// Penarikan Rp200000 ditolak: saldo tidak cukup.
// Saldo Dewi: Rp100000
// Riwayat: [setor 150000, tarik 50000]
// IPK 4.5 tidak valid. Harus di antara 0 dan 4.
// IPK Dewi: 3.65

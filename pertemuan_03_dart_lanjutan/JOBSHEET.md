# 🧪 Jobsheet Pertemuan 3 — Dart Lanjutan: OOP & Pemrograman Asinkron

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [✍️ Latihan](LATIHAN.md) · [💻 Kode Contoh](kode/)

| Informasi | Keterangan |
| :--- | :--- |
| Mata kuliah | Pemrograman Piranti Bergerak |
| Pertemuan | 3 — Dart Lanjutan: OOP & Pemrograman Asinkron |
| Bentuk kegiatan | Praktikum individu |
| Estimasi waktu | 120–150 menit |
| Alat | Browser (DartPad) **atau** terminal dengan perintah `dart run` |
| Hasil akhir | Program "Laundry Kampus" yang memakai *class*, *enum*, *exception*, `Future`, dan `Stream` |

---

## 🎯 Tujuan Praktikum

Setelah menyelesaikan jobsheet ini, Anda mampu:

1. Membuat *class* lengkap dengan properti, *constructor*, dan *method*, lalu membuat beberapa objek darinya.
2. Melindungi data dengan anggota privat, *getter*, dan validasi (enkapsulasi).
3. Menyusun hierarki *class* dengan *abstract class*, `extends`, `@override`, dan *mixin*.
4. Memakai *enum* berproperti dan menangani error dengan *exception* buatan sendiri.
5. Menulis kode asinkron dengan `Future`, `async`/`await`, `Future.wait`, dan `Stream`.

## 📌 Petunjuk Umum

> [!IMPORTANT]
> 1. Setiap praktikum diawali **kode terbimbing**. **Ketik sendiri** kodenya; jangan menyalin-tempel. Mengetik melatih tangan dan mata Anda mengenali sintaks.
> 2. Jalankan, lalu cocokkan hasilnya dengan bagian **✅ Hasil yang diharapkan**.
> 3. Kerjakan **🔧 Modifikasi** di setiap praktikum. Bagian inilah yang menguji pemahaman Anda.
> 4. Simpan setiap praktikum sebagai berkas terpisah: `praktikum1.dart`, `praktikum2.dart`, dan seterusnya.
> 5. Di DartPad, tekan tombol **Format** sebelum menyimpan. Di VS Code, tekan `Shift` + `Alt` + `F`.

<details>
<summary>❓ Lupa cara menjalankan kode Dart?</summary>

- **DartPad:** buka <https://dartpad.dev>, tempelkan kode, klik **Run**. Simpan hasilnya dengan menyalin kode ke berkas `.dart` di komputer Anda.
- **Terminal:** simpan kode sebagai `praktikum1.dart`, lalu jalankan `dart run praktikum1.dart` dari folder tempat berkas itu berada.

Penjelasan lengkap ada di [Modul Pertemuan 2, Bagian 2](../pertemuan_02_dasar_dart/README.md#2-cara-menjalankan-kode-dart).
</details>

> [!TIP]
> Praktikum 5 dan tugas mandiri memakai `Future.delayed`, sehingga hasilnya muncul **bertahap**, bukan sekaligus. Itu normal. Tunggu sampai program benar-benar selesai.

---

## Praktikum 1 — Ponsel dan Baterai

**Konsep:** *class*, objek, *constructor*, *method*, properti yang berubah. ([Modul Bagian 2](README.md#2-class-dan-objek))

```dart
class Ponsel {
  String merek;
  int baterai; // dalam persen

  Ponsel(this.merek, this.baterai);

  void pakai(int menit) {
    // Setiap 10 menit pemakaian menghabiskan 5% baterai.
    baterai -= menit ~/ 10 * 5;
    if (baterai < 0) {
      baterai = 0;
    }
    print('$merek dipakai $menit menit, baterai tinggal $baterai%');
  }

  void isiDaya(int menit) {
    // Setiap 10 menit pengisian menambah 10% baterai.
    baterai += menit ~/ 10 * 10;
    if (baterai > 100) {
      baterai = 100;
    }
    print('$merek diisi $menit menit, baterai menjadi $baterai%');
  }
}

void main() {
  Ponsel milikRina = Ponsel('Nusa X1', 80);
  Ponsel milikBudi = Ponsel('Borneo Pro', 35);

  milikRina.pakai(60);
  milikBudi.pakai(90);
  milikBudi.isiDaya(50);
  milikRina.isiDaya(120);
}
```

✅ **Hasil yang diharapkan:**

```text
Nusa X1 dipakai 60 menit, baterai tinggal 50%
Borneo Pro dipakai 90 menit, baterai tinggal 0%
Borneo Pro diisi 50 menit, baterai menjadi 50%
Nusa X1 diisi 120 menit, baterai menjadi 100%
```

> [!NOTE]
> Perhatikan `milikBudi`: pemakaian 90 menit seharusnya menghabiskan 45%, padahal baterainya hanya 35%. Pemeriksaan `if (baterai < 0)` menjaga agar baterai tidak bernilai negatif. Inilah contoh kecil **menjaga data tetap masuk akal** di dalam *method*.

🔧 **Modifikasi:**

1. Tambahkan properti `String pemilik`, lalu tampilkan pemiliknya di setiap pesan, misalnya `Ponsel Rina (Nusa X1) dipakai 60 menit, ...`.
2. Tambahkan *getter* `bool get bateraiLemah` yang bernilai `true` jika baterai di bawah 20%. Setelah `pakai()`, cetak `PERINGATAN: baterai lemah, segera isi daya!` jika baterai lemah.
3. Ubah *constructor* menjadi **parameter bernama** dengan baterai bawaan 100: `Ponsel({required this.merek, required this.pemilik, this.baterai = 100})`. Sesuaikan cara membuat objeknya.
4. Buat satu objek ponsel **milik Anda sendiri** (tanpa mengisi `baterai`), lalu panggil `pakai()` dan `isiDaya()` masing-masing minimal sekali.

---

## Praktikum 2 — Dompet Digital

**Konsep:** enkapsulasi (anggota privat dan *getter*), *named constructor*, validasi. ([Modul Bagian 3.3](README.md#33-named-constructor-lebih-dari-satu-cara-membuat-objek) dan [Bagian 4](README.md#4-enkapsulasi-menjaga-data-tetap-aman))

```dart
class DompetDigital {
  final String pemilik;
  int _saldo = 0;
  final List<String> _riwayat = [];

  DompetDigital(this.pemilik);

  // Named constructor: pengguna baru langsung mendapat bonus Rp10.000.
  DompetDigital.penggunaBaru(this.pemilik) {
    _saldo = 10000;
    _riwayat.add('Bonus pengguna baru +10000');
  }

  int get saldo => _saldo;

  List<String> get riwayat => List.unmodifiable(_riwayat);

  void isiSaldo(int jumlah) {
    if (jumlah < 10000) {
      print('Isi saldo Rp$jumlah ditolak: minimal Rp10000.');
      return;
    }
    _saldo += jumlah;
    _riwayat.add('Isi saldo +$jumlah');
  }

  void bayar(String keperluan, int jumlah) {
    if (jumlah > _saldo) {
      print('Pembayaran $keperluan gagal: saldo tidak cukup.');
      return;
    }
    _saldo -= jumlah;
    _riwayat.add('$keperluan -$jumlah');
  }
}

void main() {
  DompetDigital dompet = DompetDigital.penggunaBaru('Rina');
  dompet.isiSaldo(5000);
  dompet.isiSaldo(50000);
  dompet.bayar('Parkir', 2000);
  dompet.bayar('Tiket konser', 150000);
  dompet.bayar('Pulsa', 25000);

  print('Saldo ${dompet.pemilik}: Rp${dompet.saldo}');
  print('Riwayat transaksi:');
  for (String catatan in dompet.riwayat) {
    print('- $catatan');
  }
}
```

✅ **Hasil yang diharapkan:**

```text
Isi saldo Rp5000 ditolak: minimal Rp10000.
Pembayaran Tiket konser gagal: saldo tidak cukup.
Saldo Rina: Rp33000
Riwayat transaksi:
- Bonus pengguna baru +10000
- Isi saldo +50000
- Parkir -2000
- Pulsa -25000
```

🔧 **Modifikasi:**

1. Tolak pengisian saldo **di atas Rp2.000.000** per transaksi, dengan pesan yang jelas.
2. Tambahkan *getter* `int get jumlahTransaksi` yang menghitung banyaknya catatan di riwayat, lalu tampilkan di akhir program.
3. Tambahkan *method* `void transfer(DompetDigital tujuan, int jumlah)`. Saldo pengirim berkurang, saldo penerima bertambah, dan **keduanya** mencatat riwayat, misalnya `Transfer ke Budi -20000` dan `Transfer dari Rina +20000`. Tolak transfer jika saldo tidak cukup. Uji dengan membuat dompet kedua milik `Budi`.
4. Tulis `dompet._saldo = 999999;` di dalam `main()`. Apakah editor menolaknya? Jelaskan alasannya dalam komentar, lalu hapus kembali baris tersebut. (Petunjuk: baca kotak **IMPORTANT** di [Modul Bagian 4.2](README.md#42-anggota-privat-diawali-garis-bawah-_).)

---

## Praktikum 3 — Layanan Ojek Online

**Konsep:** *abstract class*, pewarisan, `@override`, polimorfisme, *mixin*, operator `is`. ([Modul Bagian 5–7](README.md#5-pewarisan-dan-polimorfisme))

```dart
abstract class Layanan {
  final String namaPelanggan;
  final int jarakKm;

  Layanan(this.namaPelanggan, this.jarakKm);

  String get jenis; // abstrak
  int hitungTarif(); // abstrak

  void cetakStruk() {
    print('[$jenis] $namaPelanggan, $jarakKm km: Rp${hitungTarif()}');
  }
}

// Kemampuan tambahan: hanya layanan tertentu yang boleh memakai promo.
mixin BisaPakaiPromo on Layanan {
  int potonganPromo = 3000;

  int tarifSetelahPromo() {
    int hasil = hitungTarif() - potonganPromo;
    return hasil < 0 ? 0 : hasil;
  }
}

class OjekMotor extends Layanan with BisaPakaiPromo {
  OjekMotor(super.namaPelanggan, super.jarakKm);

  @override
  String get jenis => 'Motor';

  @override
  int hitungTarif() => 5000 + jarakKm * 2500;
}

class TaksiMobil extends Layanan {
  TaksiMobil(super.namaPelanggan, super.jarakKm);

  @override
  String get jenis => 'Mobil';

  @override
  int hitungTarif() {
    int tarif = 8000 + jarakKm * 4500;
    return tarif < 20000 ? 20000 : tarif; // tarif minimal Rp20.000
  }
}

class KirimBarang extends Layanan with BisaPakaiPromo {
  final int beratKg;

  KirimBarang(super.namaPelanggan, super.jarakKm, this.beratKg);

  @override
  String get jenis => 'Kirim Barang';

  @override
  int hitungTarif() => 7000 + jarakKm * 2000 + beratKg * 1000;
}

void main() {
  List<Layanan> pesananHariIni = [
    OjekMotor('Andi', 4),
    TaksiMobil('Sari', 2),
    KirimBarang('Toko Amanah', 6, 3),
  ];

  int totalTarif = 0;
  for (Layanan pesanan in pesananHariIni) {
    pesanan.cetakStruk();
    if (pesanan is BisaPakaiPromo) {
      print('  Pakai promo, cukup bayar Rp${pesanan.tarifSetelahPromo()}');
    }
    totalTarif += pesanan.hitungTarif();
  }
  print('Total tarif sebelum promo: Rp$totalTarif');
}
```

✅ **Hasil yang diharapkan:**

```text
[Motor] Andi, 4 km: Rp15000
  Pakai promo, cukup bayar Rp12000
[Mobil] Sari, 2 km: Rp20000
[Kirim Barang] Toko Amanah, 6 km: Rp22000
  Pakai promo, cukup bayar Rp19000
Total tarif sebelum promo: Rp57000
```

> [!NOTE]
> Perhatikan perulangan di `main()`. Kita cukup memanggil `pesanan.cetakStruk()` untuk **semua** jenis layanan, dan setiap layanan menghitung tarifnya dengan caranya sendiri. Itulah **polimorfisme**. Lalu `pesanan is BisaPakaiPromo` memeriksa apakah layanan tersebut memakai *mixin* promo, sebelum memanggil `tarifSetelahPromo()`.

🔧 **Modifikasi:**

1. Tambahkan layanan `AntarMakanan` dengan tarif Rp6.000 + Rp2.000 per km, yang **juga bisa memakai promo**. Masukkan satu pesanan `AntarMakanan` ke daftar.
2. Tambahkan properti `bool malam` (bawaan `false`, berupa parameter bernama) pada `TaksiMobil`. Pada malam hari, tarifnya naik 20% **setelah** aturan tarif minimal diterapkan. (Petunjuk: `tarif * 12 ~/ 10`.) Uji dengan satu pesanan taksi malam.
3. Selain total tarif sebelum promo, hitung juga **total yang benar-benar dibayar pelanggan**, yaitu memakai tarif setelah promo untuk layanan yang bisa promo.
4. Tulis `Layanan('Uji', 1);` di dalam `main()`. Catat pesan error-nya, jelaskan penyebabnya dalam komentar, lalu hapus kembali baris tersebut.

---

## Praktikum 4 — Perpustakaan Kampus

**Konsep:** *enum* berproperti, `switch` ekspresi, *exception* buatan sendiri, `try`–`on`–`catch`–`finally`. ([Modul Bagian 8–9](README.md#8-enum-pilihan-yang-pasti))

```dart
enum JenisAnggota {
  mahasiswa(maksPinjam: 3, lamaHari: 7),
  dosen(maksPinjam: 10, lamaHari: 30),
  umum(maksPinjam: 1, lamaHari: 3);

  const JenisAnggota({required this.maksPinjam, required this.lamaHari});

  final int maksPinjam;
  final int lamaHari;
}

String warnaKartu(JenisAnggota jenis) {
  return switch (jenis) {
    JenisAnggota.mahasiswa => 'Biru',
    JenisAnggota.dosen => 'Emas',
    JenisAnggota.umum => 'Hijau',
  };
}

class BatasPinjamException implements Exception {
  final int maks;

  BatasPinjamException(this.maks);

  @override
  String toString() => 'Batas pinjam terlampaui (maksimal $maks buku).';
}

class Anggota {
  final String nama;
  final JenisAnggota jenis;
  final List<String> _dipinjam = [];

  Anggota(this.nama, this.jenis);

  void pinjam(String judul) {
    if (_dipinjam.length >= jenis.maksPinjam) {
      throw BatasPinjamException(jenis.maksPinjam);
    }
    _dipinjam.add(judul);
    print('$nama meminjam "$judul" selama ${jenis.lamaHari} hari.');
  }
}

int hitungDenda(int hariTerlambat) {
  if (hariTerlambat < 0) {
    throw Exception('Hari terlambat tidak boleh negatif');
  }
  return hariTerlambat * 1000;
}

void main() {
  // 1) Enum dengan properti dan switch
  for (JenisAnggota jenis in JenisAnggota.values) {
    print(
      '${jenis.name}: maks ${jenis.maksPinjam} buku, '
      '${jenis.lamaHari} hari, kartu ${warnaKartu(jenis)}',
    );
  }

  // 2) Exception buatan sendiri + finally
  Anggota rina = Anggota('Rina', JenisAnggota.umum);
  try {
    rina.pinjam('Dasar Flutter');
    rina.pinjam('Belajar Dart');
    print('Baris ini tidak akan dicetak.');
  } on BatasPinjamException catch (e) {
    print('Gagal: $e');
  } finally {
    print('Transaksi ${rina.nama} selesai.');
  }

  // 3) Menangkap Exception umum
  for (int hari in [3, -1]) {
    try {
      print('Denda $hari hari: Rp${hitungDenda(hari)}');
    } on Exception catch (e) {
      print('Input salah: $e');
    }
  }
}
```

✅ **Hasil yang diharapkan:**

```text
mahasiswa: maks 3 buku, 7 hari, kartu Biru
dosen: maks 10 buku, 30 hari, kartu Emas
umum: maks 1 buku, 3 hari, kartu Hijau
Rina meminjam "Dasar Flutter" selama 3 hari.
Gagal: Batas pinjam terlampaui (maksimal 1 buku).
Transaksi Rina selesai.
Denda 3 hari: Rp3000
Input salah: Exception: Hari terlambat tidak boleh negatif
```

> [!NOTE]
> Dua potong teks yang ditulis berdampingan tanpa tanda apa pun, seperti `'... buku, '` lalu `'${jenis.lamaHari} hari ...'` di dalam `print(...)`, otomatis digabung menjadi satu teks oleh Dart. Cara ini berguna untuk memecah teks yang terlalu panjang menjadi beberapa baris.

🔧 **Modifikasi:**

1. Tambahkan jenis anggota `alumni` (maksimal 2 buku, 14 hari). **Sebelum** menambah cabangnya di `warnaKartu()`, perhatikan error yang muncul dan catat pesannya dalam komentar. Setelah itu, beri alumni kartu berwarna `Perak`.
2. Tambahkan *exception* `BukuTidakDipinjamException` dan *method* `void kembalikan(String judul)` pada `Anggota`. *Method* ini menghapus judul dari daftar pinjaman, atau melempar `BukuTidakDipinjamException` jika buku tersebut tidak sedang dipinjam anggota itu. Uji keduanya dengan `try`–`on`–`catch`.
3. Buat anggota bertipe `mahasiswa`, lalu pinjam **4 buku** dengan perulangan `for` di dalam satu blok `try`. Pastikan peminjaman ke-4 ditolak dengan pesan yang rapi.

---

## Praktikum 5 — Unduh Materi Kuliah

**Konsep:** `Future`, `async`/`await`, `Future.wait`, penanganan error asinkron, `Stream`. ([Modul Bagian 10–11](README.md#10-pemrograman-asinkron-dengan-future))

```dart
// Pura-pura mengunduh berkas. detik = lama unduhan.
Future<String> unduhBerkas(String nama, int detik) async {
  await Future.delayed(Duration(seconds: detik));
  if (nama.endsWith('.exe')) {
    throw Exception('Berkas $nama diblokir demi keamanan');
  }
  return '$nama selesai diunduh';
}

// Mengalirkan persentase progres unduhan: 0, 25, 50, 75, 100.
Stream<int> progresUnduhan() async* {
  for (int persen = 0; persen <= 100; persen += 25) {
    await Future.delayed(Duration(milliseconds: 300));
    yield persen;
  }
}

Future<void> main() async {
  // A. Satu berkas, ditunggu dengan await
  print(await unduhBerkas('modul_p3.pdf', 1));

  // B. Tiga berkas sekaligus dengan Future.wait
  Stopwatch stopwatch = Stopwatch()..start();
  List<String> hasil = await Future.wait([
    unduhBerkas('slide_p3.pptx', 1),
    unduhBerkas('jobsheet_p3.md', 2),
    unduhBerkas('kode_p3.zip', 1),
  ]);
  for (String pesan in hasil) {
    print(pesan);
  }
  print('Tiga berkas selesai dalam ${stopwatch.elapsed.inSeconds} detik');

  // C. Menangani unduhan yang gagal
  try {
    print(await unduhBerkas('hadiah.exe', 1));
  } catch (e) {
    print('Gagal: $e');
  }

  // D. Memantau progres dengan Stream
  await for (int persen in progresUnduhan()) {
    int isi = persen ~/ 25;
    String batang = '${'#' * isi}${'-' * (4 - isi)}';
    print('[$batang] $persen%');
  }
  print('Semua selesai!');
}
```

✅ **Hasil yang diharapkan** (muncul bertahap, total sekitar 5–6 detik):

```text
modul_p3.pdf selesai diunduh
slide_p3.pptx selesai diunduh
jobsheet_p3.md selesai diunduh
kode_p3.zip selesai diunduh
Tiga berkas selesai dalam 2 detik
Gagal: Exception: Berkas hadiah.exe diblokir demi keamanan
[----] 0%
[#---] 25%
[##--] 50%
[###-] 75%
[####] 100%
Semua selesai!
```

> [!NOTE]
> Dua hal menarik di sini. Pertama, `'#' * 3` menghasilkan `###`: teks yang dikalikan bilangan akan diulang. Kedua, `jobsheet_p3.md` butuh 2 detik, tetapi tetap dicetak di urutan kedua. Hasil `Future.wait` selalu mengikuti **urutan daftar yang diberikan**, bukan urutan selesainya.

🔧 **Modifikasi:**

1. Tambahkan berkas keempat ke `Future.wait` dengan lama unduhan 3 detik. Berapa total waktunya sekarang? Jelaskan dalam komentar mengapa hasilnya bukan 1 + 2 + 1 + 3 = 7 detik.
2. Salin bagian B menjadi bagian B2 yang mengunduh **berkas yang sama satu per satu** dengan `await` (tanpa `Future.wait`). Cetak waktunya, lalu bandingkan dengan bagian B.
3. Ubah `progresUnduhan()` agar naik **10%** setiap langkah, dengan batang progres sepanjang **10 karakter**, misalnya `[###-------] 30%`.
4. Tambahkan blok `finally` pada bagian C yang mencetak `Koneksi ditutup.`.

---

## 🏆 Tugas Mandiri — Laundry Kampus

Buat **satu program utuh** bernama `p03_nim_namapanggilan.dart` (huruf kecil semua, misalnya `p03_2609106001_rina.dart`) untuk usaha laundry di dekat kampus, dengan ketentuan berikut:

1. **`enum JenisLayanan`** minimal 3 nilai. Setiap nilai punya properti `label` dan `hargaPerKg`. Contoh: cuci kering Rp7.000/kg, cuci setrika Rp10.000/kg, setrika saja Rp6.000/kg.
2. **`enum StatusCucian`** minimal 4 tahap, masing-masing punya `label`. Contoh: diterima, dicuci, disetrika, siap diambil.
3. **Pewarisan:** *class* `Pelanggan` (properti `nama` dan *getter* `persenDiskon` bernilai `0`) serta *class* `PelangganMember extends Pelanggan` yang meng-*override* `persenDiskon` menjadi `10`.
4. ***Class* `Pesanan`** berisi nomor, pelanggan, jenis layanan, dan berat cucian (`double`, dalam kg). Simpan berat sebagai **properti privat** yang dibaca lewat *getter*. Sediakan *getter* `int get totalBayar`: harga per kg × berat, dikurangi diskon pelanggan, lalu dibulatkan ke bilangan bulat terdekat dengan `.round()`.
5. ***Exception*** `BeratTidakValidException` yang dilempar jika berat ≤ 0 atau lebih dari 20 kg.
6. **`Future<Pesanan> terimaPesanan(...)`** dengan jeda 1 detik (pura-pura kasir mencatat), yang melempar `BeratTidakValidException` jika beratnya tidak valid.
7. **`Stream<StatusCucian> pantauCucian(Pesanan pesanan)`** yang mengalirkan setiap status dengan jeda 500 milidetik.
8. **`main()`** memproses minimal **3 pesanan**, salah satunya dengan berat tidak valid. Cetak nota untuk setiap pesanan yang berhasil, pantau status **minimal satu** pesanan dengan `await for`, tangani kegagalan dengan `try`–`on`–`catch`, lalu cetak **total pendapatan**.
9. Kode rapi: penamaan sesuai aturan, sudah diformat, dan tidak ada tanda peringatan di editor.

> [!TIP]
> - Tampilkan berat dengan `berat.toStringAsFixed(1)`, misalnya `3.5 kg` atau `25.0 kg`. Tanpa itu, DartPad menampilkan `25.0` sebagai `25` ([alasannya ada di Modul Pertemuan 2](../pertemuan_02_dasar_dart/README.md#2-cara-menjalankan-kode-dart)).
> - Mengapa `.round()` dan bukan `.ceil()` (bulatkan ke atas)? Komputer menyimpan bilangan desimal dengan sedikit "pembulatan tersembunyi". Contohnya, `7000 * 1.1` menghasilkan `7700.000000000001`, sehingga `.ceil()` memberi `7701`, padahal seharusnya `7700`. Coba sendiri di DartPad!

Contoh tampilan (boleh dikreasikan):

```text
Menerima pesanan Rina...
============== NOTA #1 ==============
Pelanggan : Rina (diskon 10%)
Layanan   : Cuci setrika
Berat     : 3.5 kg
Total     : Rp31500
=====================================
Menerima pesanan Budi...
Pesanan ditolak: Berat 25.0 kg tidak valid (harus lebih dari 0 dan maksimal 20 kg).
...
Status cucian #1:
- Diterima
- Dicuci
- Disetrika
- Siap diambil
Total pendapatan: Rp...
```

---

## 📤 Pengumpulan

Kumpulkan melalui tempat yang ditentukan dosen:

1. Berkas `praktikum1.dart` sampai `praktikum5.dart` yang **sudah berisi modifikasi**, termasuk jawaban berupa komentar.
2. Berkas tugas mandiri `p03_nim_namapanggilan.dart`.
3. *Screenshot* *output* tugas mandiri dari awal sampai akhir.

## 📊 Kriteria Penilaian

| Aspek | Indikator | Skor maks. |
| :--- | :--- | :---: |
| Praktikum 1–5 | Semua modifikasi dikerjakan dan berjalan benar (masing-masing 8 poin) | 40 |
| Tugas mandiri: OOP | *Enum* berproperti, pewarisan dan *override*, properti privat dengan *getter*, `totalBayar` benar | 20 |
| Tugas mandiri: *exception* dan asinkron | *Exception* buatan sendiri, `Future` dengan jeda, `Stream` + `await for`, penanganan error yang tepat | 25 |
| Kerapian | Penamaan bermakna, kode terformat, tanpa peringatan *analyzer* | 15 |
| **Total** | | **100** |

## 💭 Refleksi

1. Dari tugas mandiri Anda, sebutkan satu hubungan "**adalah**" (pewarisan) dan jelaskan mengapa hubungan itu cocok memakai `extends`.
2. Kapan Anda memilih `Future`, dan kapan memilih `Stream`? Berikan satu contoh dari aplikasi yang sering Anda pakai.
3. Mengapa `try`–`catch` tidak bisa menangkap error dari sebuah `Future` yang tidak di-`await`?

---

[⬅️ Kembali ke Modul](README.md) · [✍️ Lanjut ke Latihan](LATIHAN.md) · [🏠 Beranda](../README.md)

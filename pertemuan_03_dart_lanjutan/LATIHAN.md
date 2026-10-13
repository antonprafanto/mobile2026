# ✍️ Latihan Pertemuan 3 — Dart Lanjutan: OOP & Pemrograman Asinkron

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md)

Kerjakan **tanpa membuka modul dan tanpa menjalankan kode** terlebih dahulu. Setelah selesai, buktikan jawaban Anda dengan menjalankan kodenya di [DartPad](https://dartpad.dev). Cara belajar seperti ini sangat efektif melatih kemampuan "membaca" kode.

> [!NOTE]
> Kunci jawaban tidak dipublikasikan. Petunjuk (💡) menunjukkan **bagian modul** yang relevan. Pembahasan lengkap dilakukan bersama dosen di kelas.

---

## A. Pilihan Ganda

**1.** Analogi yang paling tepat untuk hubungan *class* dan objek adalah ...

- a. Resep dan juru masaknya
- b. Cetakan kue dan kue hasil cetakannya
- c. Rumah dan alamatnya
- d. Buku dan perpustakaannya

**2.** Properti bernama `_saldo` di dalam sebuah *class* bersifat ...

- a. Konstan, sehingga tidak bisa diubah sama sekali
- b. Privat, sehingga tidak terlihat dari berkas lain
- c. Dimiliki bersama oleh semua objek
- d. Wajib diisi lewat *constructor*

**3.** Diketahui *constructor* `Buku({required this.judul, this.halaman = 100})`. Pemanggilan yang **benar** adalah ...

- a. `Buku('Dasar Dart')`
- b. `Buku(halaman: 200)`
- c. `Buku(judul: 'Dasar Dart')`
- d. `Buku.judul('Dasar Dart')`

**4.** Kata kunci untuk membuat *class* yang **mewarisi** isi *class* lain adalah ...

- a. `implements`
- b. `with`
- c. `extends`
- d. `super`

**5.** Pernyataan yang **benar** tentang *abstract class* adalah ...

- a. Semua *method* di dalamnya wajib tanpa isi
- b. Tidak bisa dibuat objeknya secara langsung
- c. Hanya boleh memiliki satu *class* anak
- d. Tidak boleh memiliki properti

**6.** Fungsi penanda `@override` adalah ...

- a. Membuat *method* menjadi privat
- b. Menandai bahwa *method* tersebut sengaja mengganti *method* milik induk
- c. Membuat *method* berjalan lebih cepat
- d. Mewajibkan *class* anak menulis ulang *method* tersebut

**7.** Sebuah *class* ingin mendapat kemampuan berenang dan terbang dari dua "paket kemampuan" yang berbeda. Kata kunci yang dipakai adalah ...

- a. `extends`
- b. `with`
- c. `on`
- d. `enum`

**8.** Keuntungan utama memakai *enum* dibanding `String` untuk menyimpan status pesanan adalah ...

- a. Program berjalan lebih cepat
- b. Teksnya otomatis ditulis dengan huruf kapital
- c. Salah ketik dan nilai yang terlupa di `switch` langsung ketahuan oleh editor
- d. Isi *enum* bisa ditambah saat program berjalan

**9.** Blok yang **selalu** dijalankan, baik terjadi error maupun tidak, adalah ...

- a. `try`
- b. `catch`
- c. `on`
- d. `finally`

**10.** Diketahui fungsi `Future<int> hitungStok() async { ... }`. Di dalam fungsi `async` lain, cara mengambil nilai `int`-nya adalah ...

- a. `int stok = hitungStok();`
- b. `int stok = await hitungStok();`
- c. `int stok = hitungStok().value;`
- d. `int stok = async hitungStok();`

**11.** Pilihan yang paling tepat untuk menampilkan **progres unduhan** yang terus berubah dari 0% sampai 100% adalah ...

- a. `Future`
- b. `Stream`
- c. `enum`
- d. `Exception`

**12.** Tiga `Future` yang masing-masing membutuhkan 2 detik dijalankan bersama dengan `Future.wait`. Total waktunya kira-kira ...

- a. 2 detik
- b. 3 detik
- c. 6 detik
- d. 8 detik

<details>
<summary>💡 Petunjuk Bagian A</summary>

Soal 1 → Bagian 2.1 · Soal 2 → Bagian 4.2 · Soal 3 → Bagian 3.2 · Soal 4 dan 6 → Bagian 5.2 · Soal 5 → Bagian 6.1 · Soal 7 → Bagian 7 · Soal 8 → Bagian 8 · Soal 9 → Bagian 9.2 · Soal 10 → Bagian 10.2 · Soal 11 → Bagian 11.1 · Soal 12 → Bagian 10.4
</details>

---

## B. Tebak Output

Tuliskan **persis** apa yang akan tampil di konsol.

**B1.**

```dart
class Lampu {
  final String ruangan;
  bool menyala;

  Lampu(this.ruangan, {this.menyala = false});

  void tekanSaklar() {
    menyala = !menyala;
  }

  @override
  String toString() => 'Lampu $ruangan: ${menyala ? 'ON' : 'OFF'}';
}

void main() {
  Lampu a = Lampu('Kelas');
  Lampu b = Lampu('Lab', menyala: true);
  a.tekanSaklar();
  b.tekanSaklar();
  b.tekanSaklar();
  print(a);
  print(b);
}
```

**B2.**

```dart
class Kendaraan {
  void info() {
    print('Kendaraan darat');
  }
}

class Motor extends Kendaraan {
  @override
  void info() {
    print('Motor roda dua');
    super.info();
  }
}

class MotorListrik extends Motor {
  @override
  void info() {
    super.info();
    print('Tanpa bensin');
  }
}

void main() {
  Kendaraan k = MotorListrik();
  k.info();
}
```

**B3.**

```dart
int bagi(int a, int b) {
  if (b == 0) {
    throw Exception('Pembagi nol');
  }
  return a ~/ b;
}

void main() {
  for (int pembagi in [2, 0]) {
    try {
      print('Hasil: ${bagi(10, pembagi)}');
    } catch (e) {
      print('Error: $e');
    } finally {
      print('Selesai ($pembagi)');
    }
  }
}
```

**B4.** (perhatikan baik-baik mana yang memakai `await`)

```dart
Future<void> tugas(String nama, int ms) async {
  await Future.delayed(Duration(milliseconds: ms));
  print('$nama selesai');
}

Future<void> main() async {
  print('A');
  tugas('Unduh', 300);
  print('B');
  await tugas('Simpan', 100);
  print('C');
  await Future.delayed(Duration(milliseconds: 500));
  print('D');
}
```

**B5.**

```dart
enum Lampu { merah, kuning, hijau }

Stream<Lampu> siklus() async* {
  for (Lampu l in Lampu.values.reversed) {
    yield l;
  }
}

Future<void> main() async {
  await for (Lampu l in siklus()) {
    print('${l.index}: ${l.name}');
  }
  print(Lampu.values.length);
}
```

<details>
<summary>💡 Petunjuk Bagian B</summary>

- B1: `!menyala` membalik nilai `true`/`false`. Perhatikan nilai bawaan `menyala` untuk lampu `a`.
- B2: telusuri setiap `super.info()` satu per satu, dimulai dari *class* paling bawah (Bagian 5.2).
- B3: `finally` tetap dijalankan di **setiap** putaran (Bagian 9.2).
- B4: gambarkan garis waktunya seperti tabel di Bagian 10.3. Kapan `Unduh` dimulai, dan kapan ia selesai?
- B5: `values.reversed` membalik urutan, sedangkan `index` dimulai dari 0 (Bagian 8.2).
</details>

---

## C. Temukan dan Perbaiki Kesalahannya

Setiap kode berikut mengandung **dua** kesalahan. Jelaskan **penyebabnya** dan tuliskan **perbaikannya**.

**C1.**

```dart
class Produk {
  String nama;
  int harga;

  Produk({required this.nama});
}

void main() {
  Produk p = Produk();
  print(p.nama);
}
```

**C2.**

```dart
class Hewan {
  final String nama;

  Hewan(this.nama);
}

class Ikan extends Hewan {
  Ikan();

  void berenang() {
    print('$nama berenang');
  }
}

void main() {
  Hewan koki = Ikan();
  koki.berenang();
}
```

**C3.**

```dart
Future<int> hitungStok() async {
  await Future.delayed(Duration(seconds: 1));
  return 12;
}

void main() {
  int stok = hitungStok();
  int stokBaru = await hitungStok();
  print(stok + stokBaru);
}
```

<details>
<summary>💡 Petunjuk Bagian C</summary>

Tempelkan setiap kode ke DartPad atau VS Code, lalu **baca pesan error-nya**. Cocokkan dengan tabel di [Modul Bagian 14](README.md#14-kesalahan-umum-pemula-dan-solusinya). Untuk C2, ingat bahwa *constructor* anak harus "mengirimkan" data yang dibutuhkan induknya.
</details>

---

## D. Menulis Program

**D1 — Bangun Datar.** Buat *abstract class* `BangunDatar` dengan *getter* abstrak `String get nama`, `double get luas`, dan `double get keliling`. Turunkan menjadi tiga *class*:

- `Lingkaran` (jari-jari), dengan luas = π × r² dan keliling = 2 × π × r;
- `PersegiPanjang` (panjang dan lebar);
- `Persegi` (sisi), yang **mewarisi `PersegiPanjang`** sehingga tidak perlu menulis ulang rumus luas dan kelilingnya.

Masukkan satu objek dari setiap *class* ke `List<BangunDatar>`, tampilkan nama, luas, dan keliling masing-masing dengan 2 angka di belakang koma, lalu tampilkan bangun datar yang **luasnya paling besar**.

<details>
<summary>💡 Petunjuk D1</summary>

Tambahkan `import 'dart:math';` di baris paling atas untuk memakai konstanta `pi`. *Constructor* `Persegi` bisa meneruskan sisinya ke induk dua kali: `Persegi(double sisi) : super(sisi, sisi);`. Untuk nama, `Persegi` cukup meng-*override* *getter* `nama`.
</details>

**D2 — Validasi Pendaftaran Akun.** Buat *exception* `PendaftaranGagalException` yang menyimpan alasan kegagalan. Buat fungsi `void daftarAkun(String username, String password, int umur)` yang melempar *exception* tersebut jika:

- *username* kurang dari 5 karakter **atau** mengandung spasi;
- *password* kurang dari 8 karakter **atau** tidak mengandung angka sama sekali;
- umur di bawah 17 tahun.

Jika semua syarat terpenuhi, cetak `Akun <username> berhasil dibuat.` Di `main()`, uji minimal **4 data** (satu berhasil, tiga gagal dengan alasan berbeda), dan pastikan program **tidak berhenti** di tengah jalan.

<details>
<summary>💡 Petunjuk D2</summary>

Gunakan `username.contains(' ')` untuk memeriksa spasi. Untuk memeriksa angka, periksa setiap karakter *password* satu per satu dengan perulangan `for`, atau pakai `password.contains(RegExp(r'[0-9]'))`.
</details>

**D3 — Lampu Lalu Lintas.** Buat `enum LampuLaluLintas` dengan properti `durasi` (dalam detik) dan `aksi`: merah (5 detik, `Berhenti`), kuning (2 detik, `Hati-hati`), dan hijau (4 detik, `Jalan`). Buat `Stream<LampuLaluLintas> nyalakan(int putaran)` yang mengalirkan urutan **merah → hijau → kuning** sebanyak `putaran` kali. Agar tidak terlalu lama, anggap 1 detik = 100 milidetik. Di `main()`, dengarkan *stream* untuk 2 putaran dengan `await for`, cetak baris seperti `Lampu MERAH menyala 5 detik: Berhenti`, lalu cetak **total durasi** seluruh lampu.

<details>
<summary>💡 Petunjuk D3</summary>

Urutan menyala (merah → hijau → kuning) berbeda dengan urutan penulisan *enum*, jadi buat sendiri daftar urutannya, misalnya `List<LampuLaluLintas> urutan = [...]`. Nama lampu dalam huruf kapital bisa didapat dengan `lampu.name.toUpperCase()`.
</details>

---

[⬅️ Kembali ke Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md) · [🏠 Beranda](../README.md)

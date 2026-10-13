# 🧪 Jobsheet Pertemuan 2 — Dasar Pemrograman Dart

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [✍️ Latihan](LATIHAN.md) · [💻 Kode Contoh](kode/)

| Informasi | Keterangan |
| :--- | :--- |
| Mata kuliah | Pemrograman Piranti Bergerak |
| Pertemuan | 2 — Dasar Pemrograman Dart |
| Bentuk kegiatan | Praktikum individu |
| Estimasi waktu | 100–120 menit |
| Alat | Browser (DartPad) **atau** terminal dengan perintah `dart run` |
| Hasil akhir | Program "Kasir Kantin Kampus" yang mencetak struk belanja |

---

## 🎯 Tujuan Praktikum

Setelah menyelesaikan jobsheet ini, Anda mampu:

1. Menyimpan dan menampilkan data memakai variabel, tipe data, dan interpolasi.
2. Membuat fungsi yang menerima parameter dan mengembalikan nilai.
3. Menentukan keputusan program dengan `if` dan `switch`.
4. Mengulang proses dengan `for` dan `while`.
5. Mengolah data dengan `List` dan `Map` secara aman dari `null`.

## 📌 Petunjuk Umum

> [!IMPORTANT]
> 1. Setiap praktikum diawali **kode terbimbing**. **Ketik sendiri** kodenya; jangan menyalin-tempel. Mengetik melatih tangan dan mata Anda mengenali sintaks.
> 2. Jalankan, lalu cocokkan hasilnya dengan bagian **✅ Hasil yang diharapkan**.
> 3. Kerjakan **🔧 Modifikasi** di setiap praktikum. Bagian inilah yang menguji pemahaman Anda.
> 4. Simpan setiap praktikum sebagai berkas terpisah: `praktikum1.dart`, `praktikum2.dart`, dan seterusnya.
> 5. Di DartPad, tekan tombol **Format** sebelum menyimpan. Di VS Code, tekan `Shift` + `Alt` + `F`.

<details>
<summary>❓ Belum tahu cara menjalankan kode Dart?</summary>

- **DartPad:** buka <https://dartpad.dev>, tempelkan kode, klik **Run**. Simpan hasilnya dengan menyalin kode ke berkas `.dart` di komputer Anda.
- **Terminal:** buat folder `latihan_dart`, simpan kode sebagai `praktikum1.dart`, lalu jalankan `dart run praktikum1.dart` dari dalam folder tersebut.

Penjelasan lengkap ada di [Modul Bagian 2](README.md#2-cara-menjalankan-kode-dart).
</details>

---

## Praktikum 1 — Biodata Mahasiswa

**Konsep:** variabel, tipe data, interpolasi, method `String`.

```dart
void main() {
  String nama = 'Nama Anda';
  String nim = '2026000000';
  int angkatan = 2026;
  double tinggiBadan = 165.5;
  bool punyaLaptop = true;

  int tahunSekarang = DateTime.now().year;
  int tahunKe = tahunSekarang - angkatan + 1;

  print('===== BIODATA MAHASISWA =====');
  print('Nama          : $nama');
  print('NIM           : $nim');
  print('Angkatan      : $angkatan (tahun ke-$tahunKe)');
  print('Tinggi badan  : $tinggiBadan cm');
  print('Punya laptop  : $punyaLaptop');
  print('Nama (kapital): ${nama.toUpperCase()}');
}
```

✅ **Hasil yang diharapkan** (jika dijalankan pada tahun 2026):

```text
===== BIODATA MAHASISWA =====
Nama          : Nama Anda
NIM           : 2026000000
Angkatan      : 2026 (tahun ke-1)
Tinggi badan  : 165.5 cm
Punya laptop  : true
Nama (kapital): NAMA ANDA
```

🔧 **Modifikasi:**

1. Ganti semua data dengan **data diri Anda**.
2. Tambahkan variabel `String kotaAsal` dan tampilkan.
3. Tampilkan jumlah huruf nama Anda memakai `.length`.
4. Tambahkan variabel `final DateTime waktuCetak = DateTime.now();` dan tampilkan jam pencetakan biodata (`waktuCetak.hour` dan `waktuCetak.minute`).

---

## Praktikum 2 — Konversi Suhu

**Konsep:** fungsi dengan nilai kembali, fungsi panah, `toStringAsFixed`.

```dart
double keFahrenheit(double celsius) => celsius * 9 / 5 + 32;

double keReamur(double celsius) => celsius * 4 / 5;

double keKelvin(double celsius) => celsius + 273.15;

void main() {
  double suhu = 30;
  print('Suhu ${suhu.toStringAsFixed(1)} °C sama dengan:');
  print('- ${keFahrenheit(suhu).toStringAsFixed(1)} °F');
  print('- ${keReamur(suhu).toStringAsFixed(1)} °R');
  print('- ${keKelvin(suhu).toStringAsFixed(2)} K');
}
```

✅ **Hasil yang diharapkan:**

```text
Suhu 30.0 °C sama dengan:
- 86.0 °F
- 24.0 °R
- 303.15 K
```

🔧 **Modifikasi:**

1. Ubah nilai `suhu` menjadi `-10` dan `100`. Apakah hasilnya masuk akal?
2. Buat fungsi baru `double fahrenheitKeCelsius(double f)` dengan rumus `(f - 32) * 5 / 9`, lalu uji dengan nilai `98.6`.
3. Mengapa kita memakai `toStringAsFixed(1)` dan tidak langsung menampilkan hasilnya? (Petunjuk: baca catatan di [Modul Bagian 2](README.md#2-cara-menjalankan-kode-dart).)

---

## Praktikum 3 — Tarif Parkir Kampus

**Konsep:** `switch` ekspresi, `if`–`else`, fungsi dengan dua parameter.

Aturan tarif: **motor** Rp2.000 untuk 2 jam pertama, lalu Rp1.000 per jam berikutnya. **Mobil** Rp5.000 untuk 2 jam pertama, lalu Rp2.000 per jam berikutnya.

```dart
int hitungTarifParkir(String jenis, int lamaJam) {
  int tarifAwal = switch (jenis) {
    'motor' => 2000,
    'mobil' => 5000,
    _ => 0,
  };
  int tarifPerJam = switch (jenis) {
    'motor' => 1000,
    'mobil' => 2000,
    _ => 0,
  };

  if (lamaJam <= 2) {
    return tarifAwal;
  }
  return tarifAwal + (lamaJam - 2) * tarifPerJam;
}

void main() {
  print('Motor 1 jam : Rp${hitungTarifParkir('motor', 1)}');
  print('Motor 5 jam : Rp${hitungTarifParkir('motor', 5)}');
  print('Mobil 3 jam : Rp${hitungTarifParkir('mobil', 3)}');
  print('Sepeda 2 jam: Rp${hitungTarifParkir('sepeda', 2)}');
}
```

✅ **Hasil yang diharapkan:**

```text
Motor 1 jam : Rp2000
Motor 5 jam : Rp5000
Mobil 3 jam : Rp7000
Sepeda 2 jam: Rp0
```

🔧 **Modifikasi:**

1. Tambahkan jenis kendaraan **`'bus'`** dengan tarif awal Rp10.000 dan Rp5.000 per jam berikutnya.
2. Kampus menetapkan **tarif maksimal Rp20.000** untuk semua jenis kendaraan. Tambahkan aturan ini memakai `if`.
3. Uji fungsi Anda: mobil parkir 12 jam seharusnya membayar Rp20.000, bukan Rp25.000.

---

## Praktikum 4 — Tabel Perkalian dan Target Tabungan

**Konsep:** `for` dan `while`.

```dart
void main() {
  // A. Tabel perkalian dengan for
  int angka = 7;
  for (int i = 1; i <= 10; i++) {
    print('$angka x $i = ${angka * i}');
  }

  // B. Menabung dengan while
  int target = 1500000;
  int tabunganPerBulan = 200000;
  int saldo = 0;
  int bulan = 0;
  while (saldo < target) {
    saldo += tabunganPerBulan;
    bulan++;
  }
  print('Target tercapai dalam $bulan bulan, saldo Rp$saldo');
}
```

✅ **Hasil yang diharapkan:** sepuluh baris tabel perkalian 7 (dari `7 x 1 = 7` sampai `7 x 10 = 70`), lalu:

```text
Target tercapai dalam 8 bulan, saldo Rp1600000
```

🔧 **Modifikasi:**

1. Ubah bagian A agar hanya menampilkan baris yang **hasilnya genap**. (Petunjuk: `continue` dan operator `%`.)
2. Ubah bagian B: setiap bulan, tabungan bertambah Rp200.000 **ditambah bunga 1% dari saldo** (bunga dibulatkan ke bawah dengan `~/`). Berapa bulan sekarang?
3. Apa yang terjadi jika `tabunganPerBulan` diubah menjadi `0`? Jangan dijalankan dulu; jelaskan dengan kata-kata Anda sendiri, lalu baca bagian *infinite loop* di [Modul Bagian 10](README.md#10-perulangan).

---

## Praktikum 5 — Keranjang Belanja Kantin

**Konsep:** `Map`, `List`, `for-in`, `continue`, *null safety*, `where`.

```dart
void main() {
  Map<String, int> daftarHarga = {
    'Nasi Goreng': 15000,
    'Mie Ayam': 12000,
    'Es Teh': 4000,
  };
  List<String> pesanan = ['Nasi Goreng', 'Es Teh', 'Es Teh', 'Sate'];

  int total = 0;
  for (String menu in pesanan) {
    int? harga = daftarHarga[menu];
    if (harga == null) {
      print('$menu tidak tersedia, dilewati');
      continue;
    }
    total += harga;
    print('$menu: Rp$harga');
  }
  print('TOTAL: Rp$total');

  int jumlahEs = pesanan.where((String m) => m.startsWith('Es')).length;
  print('Jumlah minuman es: $jumlahEs');
}
```

✅ **Hasil yang diharapkan:**

```text
Nasi Goreng: Rp15000
Es Teh: Rp4000
Es Teh: Rp4000
Sate tidak tersedia, dilewati
TOTAL: Rp23000
Jumlah minuman es: 2
```

> [!NOTE]
> Perhatikan `int? harga = daftarHarga[menu];`. Hasil membaca `Map` bertipe *nullable* karena menu yang dicari bisa saja tidak ada (seperti `'Sate'`). Setelah dicek `if (harga == null)`, Dart tahu bahwa di baris-baris berikutnya `harga` pasti berisi angka (*type promotion*).

🔧 **Modifikasi:**

1. Tambahkan dua menu baru ke `daftarHarga`, lalu pesan keduanya.
2. Tampilkan juga **menu termahal** yang dipesan.
3. Ubah `pesanan` agar **tidak memesan apa pun** (`[]`). Pastikan program menampilkan `TOTAL: Rp0` tanpa error.

---

## 🏆 Tugas Mandiri — Kasir Kantin Kampus

Buat **satu program utuh** bernama `p02_nim_namapanggilan.dart` (huruf kecil semua, misalnya `p02_2609106001_rina.dart`) dengan ketentuan berikut:

1. Daftar menu dan harga disimpan dalam `Map<String, int>`, **minimal 5 menu**.
2. Pesanan pelanggan disimpan dalam `List<String>`. Pesanan **wajib** mengandung minimal satu menu yang dipesan lebih dari sekali dan minimal satu menu yang **tidak tersedia**.
3. Buat fungsi `int hitungSubtotal(Map<String, int> menu, List<String> pesanan)` yang mengembalikan jumlah harga semua pesanan yang tersedia.
4. Buat fungsi `int hitungDiskon(int subtotal, {bool member = false})` dengan aturan:
   - Subtotal **≥ Rp50.000** mendapat diskon **10%**.
   - Pelanggan **member** mendapat potongan **tambahan Rp5.000**.
   - Diskon tidak boleh lebih besar dari subtotal.
5. Program mencetak **struk** yang rapi, minimal berisi: daftar item beserta harganya, item yang tidak tersedia, subtotal, diskon, dan total bayar.
6. Jalankan program **dua kali**: sekali untuk pelanggan biasa dan sekali untuk pelanggan member.
7. Kode rapi: penamaan *lowerCamelCase*, sudah diformat, dan tidak ada garis kuning/merah di editor.

Contoh tampilan struk (boleh dikreasikan):

```text
======= KANTIN INFORMATIKA =======
Nasi Goreng            Rp15000
Es Teh                 Rp4000
Es Teh                 Rp4000
(Sate tidak tersedia)
----------------------------------
Subtotal               Rp23000
Diskon                 Rp5000
TOTAL BAYAR            Rp18000
==================================
```

---

## 📤 Pengumpulan

Kumpulkan melalui tempat yang ditentukan dosen:

1. Berkas `praktikum1.dart` sampai `praktikum5.dart` yang **sudah berisi modifikasi**.
2. Berkas tugas mandiri `p02_nim_namapanggilan.dart`.
3. *Screenshot* output tugas mandiri untuk pelanggan biasa dan pelanggan member.

## 📊 Kriteria Penilaian

| Aspek | Indikator | Skor maks. |
| :--- | :--- | :---: |
| Praktikum 1–5 | Semua modifikasi dikerjakan dan berjalan benar (masing-masing 8 poin) | 40 |
| Tugas mandiri: logika | Subtotal, diskon, dan menu tidak tersedia ditangani dengan benar | 30 |
| Tugas mandiri: fungsi | Memakai dua fungsi sesuai spesifikasi, termasuk parameter bernama `member` | 15 |
| Kerapian | Penamaan bermakna, kode terformat, tanpa peringatan *analyzer* | 15 |
| **Total** | | **100** |

## 💭 Refleksi

1. Konsep apa yang paling membingungkan hari ini? Tuliskan satu contoh kode yang membantu Anda memahaminya.
2. Kapan Anda memilih `final` dan kapan memakai variabel biasa? Berikan contoh dari tugas Anda.
3. Mengapa membaca `daftarHarga[menu]` menghasilkan tipe `int?`, bukan `int`?

---

[⬅️ Kembali ke Modul](README.md) · [✍️ Lanjut ke Latihan](LATIHAN.md) · [🏠 Beranda](../README.md)

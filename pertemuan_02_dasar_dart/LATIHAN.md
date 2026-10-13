# ✍️ Latihan Pertemuan 2 — Dasar Pemrograman Dart

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md)

Kerjakan **tanpa membuka modul dan tanpa menjalankan kode** terlebih dahulu. Setelah selesai, buktikan jawaban Anda dengan menjalankan kodenya di [DartPad](https://dartpad.dev). Cara belajar seperti ini sangat efektif melatih kemampuan "membaca" kode.

> [!NOTE]
> Kunci jawaban tidak dipublikasikan. Petunjuk (💡) menunjukkan **bagian modul** yang relevan. Pembahasan lengkap dilakukan bersama dosen di kelas.

---

## A. Pilihan Ganda

**1.** Tipe data yang paling tepat untuk menyimpan IPK `3.75` adalah ...

- a. `int`
- b. `double`
- c. `String`
- d. `bool`

**2.** Hasil dari `17 ~/ 5` adalah ...

- a. `3.4`
- b. `2`
- c. `3`
- d. `85`

**3.** Deklarasi variabel yang **boleh** berisi `null` adalah ...

- a. `String nama;`
- b. `String? nama;`
- c. `String! nama;`
- d. `final String nama;`

**4.** Operator yang artinya "jika nilainya null, pakai nilai cadangan" adalah ...

- a. `?.`
- b. `!`
- c. `??`
- d. `==`

**5.** Pernyataan yang **benar** tentang `final` dan `const` adalah ...

- a. Nilai `final` boleh diubah, nilai `const` tidak boleh.
- b. Nilai `const` harus sudah diketahui sebelum program berjalan, sedangkan `final` boleh baru diketahui saat program berjalan.
- c. `final` hanya untuk angka, `const` hanya untuk teks.
- d. Keduanya sama persis, hanya berbeda nama.

**6.** Jika `String nama = 'budi';`, maka `print('Halo, ${nama.toUpperCase()}');` menampilkan ...

- a. `Halo, budi`
- b. `Halo, Budi`
- c. `Halo, BUDI`
- d. `Halo, ${nama.toUpperCase()}`

**7.** Jenis perulangan yang isinya **pasti dijalankan minimal satu kali** adalah ...

- a. `for`
- b. `for-in`
- c. `while`
- d. `do-while`

**8.** Indeks elemen **pertama** pada sebuah `List` adalah ...

- a. `0`
- b. `1`
- c. `-1`
- d. Tergantung panjang List

**9.** Koleksi yang otomatis membuang data kembar adalah ...

- a. `List`
- b. `Set`
- c. `Map`
- d. `String`

**10.** Diketahui fungsi `int hitungTotal({required int harga, int jumlah = 1})`. Pemanggilan yang **benar** adalah ...

- a. `hitungTotal(5000, 2)`
- b. `hitungTotal(jumlah: 2)`
- c. `hitungTotal(harga: 5000, jumlah: 2)`
- d. `hitungTotal{harga: 5000}`

<details>
<summary>💡 Petunjuk Bagian A</summary>

Soal 1 → Bagian 4.2 · Soal 2 → Bagian 8.1 · Soal 3–4 → Bagian 7 · Soal 5 → Bagian 6 · Soal 6 → Bagian 5.1 · Soal 7 → Bagian 10 · Soal 8–9 → Bagian 12 · Soal 10 → Bagian 11.2
</details>

---

## B. Tebak Output

Tuliskan **persis** apa yang akan tampil di konsol.

**B1.**

```dart
void main() {
  int a = 10;
  int b = 4;
  print(a / b);
  print(a ~/ b);
  print(a % b);
}
```

**B2.**

```dart
void main() {
  List<String> nama = ['Ana', 'Budi', 'Caca'];
  print(nama.length);
  print(nama[1]);
  nama.add('Dodi');
  nama.removeAt(0);
  print(nama);
}
```

**B3.**

```dart
void main() {
  for (int i = 1; i <= 10; i++) {
    if (i % 3 != 0) {
      continue;
    }
    print(i);
  }
}
```

**B4.**

```dart
String sapa(String nama, {String salam = 'Halo'}) => '$salam, $nama!';

void main() {
  print(sapa('Rina'));
  print(sapa('Rina', salam: 'Selamat pagi'));
}
```

**B5.**

```dart
void main() {
  Map<String, int> stok = {'pensil': 5, 'buku': 2};
  stok['pensil'] = stok['pensil']! - 1;
  print(stok['pensil']);
  print(stok['penghapus'] ?? 0);
  print(stok.length);
}
```

<details>
<summary>💡 Petunjuk Bagian B</summary>

- B1: ingat perbedaan `/`, `~/`, dan `%` (Bagian 8.1).
- B2: `removeAt(0)` menghapus isi pada **indeks** 0.
- B3: `continue` melewati sisa putaran (Bagian 10).
- B4: parameter bernama dengan nilai bawaan (Bagian 11.2).
- B5: membaca kunci yang tidak ada menghasilkan `null` (Bagian 12.2).
</details>

---

## C. Temukan dan Perbaiki Kesalahannya

Setiap kode berikut mengandung kesalahan. Jelaskan **penyebabnya** dan tuliskan **perbaikannya**.

**C1.** (dua kesalahan)

```dart
void main() {
  int jumlah = 10 / 2;
  print('Jumlah: ' + jumlah);
}
```

**C2.** (dua kesalahan: satu terdeteksi editor, satu baru muncul saat program berjalan)

```dart
void main() {
  String nama;
  print(nama.length);
  List<int> nilai = [80, 90];
  print(nilai[2]);
}
```

**C3.** (satu kesalahan; perhatikan pesan error-nya)

```dart
String predikat(int nilai) {
  if (nilai >= 60) {
    return 'Lulus';
  } else if (nilai < 60) {
    return 'Mengulang';
  }
}
```

<details>
<summary>💡 Petunjuk Bagian C</summary>

Tempelkan setiap kode ke DartPad atau VS Code, lalu **baca pesan error-nya**. Cocokkan dengan tabel di [Modul Bagian 15](README.md#15-kesalahan-umum-pemula-dan-solusinya). Untuk C3, tanyakan pada diri sendiri: "Apakah Dart bisa *yakin* bahwa salah satu `return` pasti dijalankan?"
</details>

---

## D. Menulis Program

**D1 — Palindrom.** Buat fungsi `bool apakahPalindrom(String kata)` yang mengembalikan `true` jika kata dibaca sama dari depan dan belakang, tanpa membedakan huruf besar/kecil. Uji dengan `'Katak'` (true), `'Kodok'` (true), dan `'Flutter'` (false).

<details>
<summary>💡 Petunjuk D1</summary>

Ubah kata menjadi huruf kecil dengan `toLowerCase()`. Untuk membalik teks, pecah menjadi daftar huruf dengan `split('')`, balik urutannya dengan `.reversed`, lalu gabungkan lagi dengan `.join()`.
</details>

**D2 — Statistik Nilai.** Diberikan `List<int> nilai = [78, 92, 65, 88, 70, 55];`. Tampilkan nilai **tertinggi**, **terendah**, **rata-rata** (2 angka di belakang koma), dan **jumlah nilai di atas rata-rata**. Kerjakan dengan perulangan `for-in`, tanpa memakai method `sort()`.

**D3 — Mobile-Flutter.** Tampilkan angka 1 sampai 20. Untuk kelipatan 3, tampilkan `Mobile` sebagai ganti angka. Untuk kelipatan 5, tampilkan `Flutter`. Untuk kelipatan 3 **dan** 5, tampilkan `MobileFlutter`.

<details>
<summary>💡 Petunjuk D3</summary>

Urutan pemeriksaan `if` sangat menentukan. Syarat mana yang harus diperiksa paling awal?
</details>

---

[⬅️ Kembali ke Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md) · [🏠 Beranda](../README.md)

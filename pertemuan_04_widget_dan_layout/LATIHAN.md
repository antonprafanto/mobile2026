# ✍️ Latihan Pertemuan 4 — Widget & Tata Letak (*Layout*)

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md)

Kerjakan **tanpa membuka modul dan tanpa menjalankan kode** terlebih dahulu. Setelah selesai, buktikan jawaban Anda dengan menjalankan kodenya di [DartPad](https://dartpad.dev). Untuk soal bagian B, tempelkan potongan kodenya sebagai `body` dari sebuah `Scaffold`.

> [!NOTE]
> Kunci jawaban tidak dipublikasikan. Petunjuk (💡) menunjukkan **bagian modul** yang relevan. Pembahasan lengkap dilakukan bersama dosen di kelas.

---

## A. Pilihan Ganda

**1.** Widget yang hanya boleh memiliki **satu** anak menuliskan anaknya lewat parameter ...

- a. `children`
- b. `body`
- c. `child`
- d. `items`

**2.** Kode yang tepat untuk memberi jarak 16 di **keempat sisi** sebuah teks adalah ...

- a. `Padding(padding: const EdgeInsets.all(16), child: Text('Halo'))`
- b. `SizedBox(height: 16, child: Text('Halo'))`
- c. `Align(alignment: Alignment(16, 16), child: Text('Halo'))`
- d. `Center(child: Text('Halo', padding: 16))`

**3.** Pada sebuah `Column`, properti yang mengatur posisi anak-anaknya ke **kiri atau kanan** adalah ...

- a. `mainAxisAlignment`
- b. `spacing`
- c. `mainAxisSize`
- d. `crossAxisAlignment`

**4.** Sebuah `Row` selebar 300 berisi `Expanded(flex: 2, ...)` dan `Expanded(flex: 1, ...)`. Lebar anak pertama adalah ...

- a. 100
- b. 150
- c. 200
- d. 300

**5.** Perbedaan `Expanded` dan `Flexible` yang **benar** adalah ...

- a. `Expanded` hanya bisa dipakai di dalam `Column`
- b. `Flexible` tidak memiliki parameter `flex`
- c. Keduanya sama persis, hanya namanya berbeda
- d. `Flexible` boleh lebih kecil dari jatahnya, sedangkan `Expanded` wajib memenuhi jatahnya

**6.** Pada `Stack(children: [A, B, C])`, widget yang tampil **paling depan** ketika ketiganya bertumpuk di tempat yang sama adalah ...

- a. A
- b. B
- c. Bergantung pada ukurannya
- d. C

**7.** Aturan dasar tata letak Flutter berbunyi ...

- a. Batasan turun ke anak, ukuran naik ke induk, induk menentukan posisi
- b. Ukuran turun ke anak, batasan naik ke induk, anak menentukan posisi
- c. Anak menentukan batasan, ukuran, dan posisinya sendiri
- d. Induk menentukan ukuran anak, anak menentukan posisinya sendiri

**8.** Batasan yang nilai minimum dan maksimumnya **sama** sehingga anak wajib berukuran tepat itu disebut batasan ...

- a. longgar (*loose*)
- b. ketat (*tight*)
- c. tak terbatas (*unbounded*)
- d. lentur (*flexible*)

**9.** Muncul pesan `A RenderFlex overflowed by 120 pixels on the bottom.` pada halaman berisi banyak kartu di dalam `Column`. Perbaikan yang paling tepat adalah ...

- a. Membungkus setiap kartu dengan `Expanded`
- b. Membungkus `Column` dengan `SingleChildScrollView`
- c. Mengganti `Column` dengan `Wrap`
- d. Mengganti `Column` dengan `Stack`

**10.** Deretan sepuluh `Chip` kategori di dalam sebuah `Row` meluber ke kanan pada layar sempit. Solusi yang paling tepat adalah ...

- a. Membungkus `Row` dengan `ClipRRect`
- b. Mengganti `Row` dengan `Wrap`
- c. Membungkus `Row` dengan `SingleChildScrollView` biasa (arah gulir ke bawah)
- d. Membungkus setiap `Chip` dengan `Positioned`

**11.** Pernyataan yang **benar** tentang `Container` adalah ...

- a. `color` dan `decoration` boleh diisi bersamaan
- b. `margin` adalah jarak di dalam kotak, `padding` adalah jarak di luar kotak
- c. `padding` adalah jarak di dalam kotak, `margin` adalah jarak di luar kotak
- d. `Container` wajib selalu memiliki anak

**12.** Berikut alasan memecah tampilan menjadi *class* widget sendiri, **kecuali** ...

- a. Membuat aplikasi otomatis bebas *overflow*
- b. Widget bisa ditandai `const` sehingga tidak perlu dibangun ulang
- c. Widget memiliki `context` sendiri
- d. Widget muncul dengan namanya sendiri di Flutter Inspector

<details>
<summary>💡 Petunjuk Bagian A</summary>

Soal 1 → Bagian 1.2 · Soal 2 → Bagian 3.2 · Soal 3 → Bagian 5.3 · Soal 4 → Bagian 6.2 · Soal 5 → Bagian 6.4 · Soal 6 → Bagian 7.1 · Soal 7 → Bagian 8.1 · Soal 8 → Bagian 8.2 · Soal 9 dan 10 → Bagian 9 · Soal 11 → Bagian 4.1 · Soal 12 → Bagian 11.3
</details>

---

## B. Tebak Tampilan

Jawab pertanyaan pada setiap soal. Semua angka dalam piksel logis.

**B1.** Tiga kotak bernama A, B, dan C masing-masing selebar 60.

```dart
SizedBox(
  width: 300,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(width: 60, height: 40, child: ColoredBox(color: Colors.red)), // A
      SizedBox(width: 60, height: 40, child: ColoredBox(color: Colors.green)), // B
      SizedBox(width: 60, height: 40, child: ColoredBox(color: Colors.blue)), // C
    ],
  ),
)
```

a. Berapa jarak kosong antara kotak A dan kotak B?
b. Jika `spaceBetween` diganti `spaceEvenly`, berapa jarak antara tepi kiri `Row` dan kotak A?

**B2.** Berapa lebar masing-masing kotak merah, hijau, dan biru?

```dart
SizedBox(
  width: 400,
  child: Row(
    children: [
      SizedBox(width: 100, height: 30, child: ColoredBox(color: Colors.red)),
      Expanded(child: SizedBox(height: 30, child: ColoredBox(color: Colors.green))),
      Expanded(flex: 2, child: SizedBox(height: 30, child: ColoredBox(color: Colors.blue))),
    ],
  ),
)
```

**B3.**

```dart
SizedBox(
  width: 328,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Container(width: 50, height: 50, color: Colors.orange), // kotak oranye
      Align(
        alignment: Alignment.centerLeft,
        child: Container(width: 50, height: 50, color: Colors.purple), // ungu
      ),
    ],
  ),
)
```

a. Berapa ukuran (lebar × tinggi) kotak oranye?
b. Berapa ukuran kotak ungu? Mengapa berbeda dengan kotak oranye?

**B4.** Tuliskan teks yang tampil pada masing-masing kotak.

```dart
class InfoLebar extends StatelessWidget {
  const InfoLebar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints batasan) {
        String minimum = batasan.minWidth.toStringAsFixed(0);
        String maksimum = batasan.maxWidth.toStringAsFixed(0);
        return Text('min $minimum, max $maksimum');
      },
    );
  }
}

// Kotak pertama:
const SizedBox(width: 200, height: 100, child: Center(child: InfoLebar())),

// Kotak kedua:
const SizedBox(width: 200, height: 100, child: InfoLebar()),
```

**B5.** Lima kotak, masing-masing selebar 100, disusun dengan `Wrap`. Ada berapa baris, dan berapa kotak di baris terakhir?

```dart
SizedBox(
  width: 328,
  child: Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      for (int i = 1; i <= 5; i++)
        const SizedBox(width: 100, height: 40, child: ColoredBox(color: Colors.teal)),
    ],
  ),
)
```

**B6.** Tuliskan pesan error yang muncul di konsol, **lengkap dengan angkanya**.

```dart
SizedBox(
  width: 360,
  child: Row(
    children: [
      SizedBox(width: 200, height: 50, child: ColoredBox(color: Colors.red)),
      SizedBox(width: 200, height: 50, child: ColoredBox(color: Colors.blue)),
    ],
  ),
)
```

<details>
<summary>💡 Petunjuk Bagian B</summary>

- B1: hitung dulu sisa ruangnya (lebar `Row` dikurangi lebar semua kotak), lalu lihat tabel di Bagian 5.2.
- B2: anak berukuran pasti diberi tempat lebih dulu, baru sisanya dibagi menurut `flex` (Bagian 6.3).
- B3 dan B4: ingat batasan ketat dan longgar, serta peran `Align`/`Center` (Bagian 8.2 dan 8.3).
- B5: jumlahkan lebar kotak beserta `spacing`-nya untuk satu baris.
- B6: `Row` tidak pernah memperkecil anak yang ukurannya pasti (Bagian 9.1).
</details>

---

## C. Temukan dan Perbaiki Kesalahannya

Setiap kode berikut mengandung **dua** kesalahan. Jelaskan **penyebabnya** dan tuliskan **perbaikannya**.

**C1.**

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Scaffold(body: KartuNama())));
}

class KartuNama extends StatelessWidget {
  const KartuNama({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: 16,
        child: Column(
          child: [
            Text('Rina Amelia'),
            Text('Informatika 2026'),
          ],
        ),
      ),
    );
  }
}
```

**C2.**

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Scaffold(body: JudulHarga())));
}

class JudulHarga extends StatelessWidget {
  const JudulHarga({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Row(
      spacing: 12,
      children: [
        const Text('Nasi Goreng', style: TextStyle(color: warna.primary)),
        Text(
          'Rp18.000',
          style: gayaTeks.titleLarge.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
```

**C3.** Kode ini tidak ditolak editor, tetapi saat dijalankan pada ukuran layar ponsel (misalnya 360 × 640) muncul beberapa pesan error di konsol. Temukan **dua** kesalahan yang menjadi penyebabnya.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: HalamanInfo()));
}

class HalamanInfo extends StatelessWidget {
  const HalamanInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Info Kampus')),
      body: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.campaign),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Expanded(
                  child: Text(
                    'Libur semester dimulai 22 Desember. Perkuliahan '
                    'dimulai kembali 5 Januari.',
                  ),
                ),
              ),
            ],
          ),
          for (int i = 1; i <= 15; i++)
            ListTile(
              leading: const Icon(Icons.article),
              title: Text('Pengumuman ke-$i'),
            ),
        ],
      ),
    );
  }
}
```

<details>
<summary>💡 Petunjuk Bagian C</summary>

Tempelkan setiap kode ke DartPad atau VS Code, lalu **baca pesan error-nya**. Cocokkan dengan tabel di [Modul Bagian 15](README.md#15-kesalahan-umum-pemula-dan-solusinya). Untuk C3, ingat bahwa `Expanded` punya syarat tentang **siapa induknya**, dan perhatikan berapa total tinggi lima belas `ListTile`.
</details>

---

## D. Menulis Program

Untuk setiap soal, buat satu aplikasi utuh. Semua warna dan gaya teks diambil dari tema, dan tampilannya harus bebas *overflow* pada lebar **320** dan **360**.

**D1 — Kartu Cuaca.** Buat halaman berisi satu kartu cuaca:

- Baris atas: ikon cuaca berukuran 64 di kiri; di sebelah kanannya nama kota, suhu (gaya `displaySmall`), dan keterangan cuaca yang bisa turun baris.
- Di bawahnya, tiga kotak kecil **sama lebar** untuk kelembapan, kecepatan angin, dan peluang hujan. Setiap kotak berisi ikon, nilai, dan label.
- Kotak kecil dibuat sebagai **widget sendiri** dengan tiga parameter.

<details>
<summary>💡 Petunjuk D1</summary>

Pakai `Card.filled` sebagai kartu. Tiga kotak sama lebar = tiga `Expanded` di dalam satu `Row`. Ikon yang cocok: `Icons.wb_cloudy`, `Icons.water_drop`, `Icons.air`, dan `Icons.umbrella`. Pada layar 320, pilih label yang pendek, misalnya "Lembap", "Angin", dan "Hujan".
</details>

**D2 — Kartu Produk Toko Online.** Tampilkan **dua kartu produk berdampingan** (sama lebar). Setiap kartu berisi:

- Area gambar setinggi 120 berupa `Stack`: latar berwarna dengan ikon produk, label diskon (misalnya `30%`) di pojok kiri atas, dan lingkaran berikon hati di pojok kanan atas.
- Nama produk paling banyak dua baris (sisanya *ellipsis*).
- Harga setelah diskon (tebal) dan harga asli yang **dicoret**.
- Baris rating, misalnya `4,8 · Terjual 1,2 rb`.

Kartu dibuat sebagai widget sendiri dan dipakai dua kali dengan data berbeda.

<details>
<summary>💡 Petunjuk D2</summary>

Teks dicoret dibuat dengan `TextStyle(decoration: TextDecoration.lineThrough)`. Di layar 320, setiap kartu hanya selebar kurang lebih 140, sehingga harga dan harga asli mungkin tidak muat bersebelahan. Susun keduanya dengan `Wrap` agar harga asli otomatis pindah baris jika tidak muat. Agar isi kartu ikut terpotong mengikuti sudut bulat, beri `Card` parameter `clipBehavior: Clip.antiAlias`.
</details>

**D3 — Jadwal Kuliah Mingguan.** Buat halaman jadwal kuliah:

- Deretan *chip* nama hari (Senin sampai Sabtu) yang otomatis pindah baris.
- Minimal **lima** kartu jadwal yang dibuat dengan **satu** widget buatan sendiri. Setiap kartu menampilkan jam mulai dan jam selesai di kotak kecil berwarna, nama mata kuliah, serta ruang dan nama dosen.
- Nama mata kuliah yang sangat panjang dipotong dengan *ellipsis*.
- Halaman bisa digulir.

<details>
<summary>💡 Petunjuk D3</summary>

Struktur satu kartu: `Card` → `Padding` → `Row` berisi [kotak jam, `Expanded` berisi `Column` (mata kuliah, ruang · dosen), ikon panah]. Tanpa `Expanded`, nama mata kuliah yang panjang akan menyebabkan *overflow*.
</details>

---

[⬅️ Kembali ke Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md) · [🏠 Beranda](../README.md)

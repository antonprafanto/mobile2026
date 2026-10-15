# 🎯 Simulasi UTS — Sewa Alat Mapala

[🏠 Beranda](../README.md) · [📝 Panduan UTS](README.md) · [✍️ Latihan Persiapan](LATIHAN.md) · [💻 Bahan Simulasi](kode/bahan_simulasi_sewa_alat.dart)

> [!IMPORTANT]
> Kerjakan simulasi ini **seperti ujian sungguhan**: pasang pengatur waktu **120 menit**, tanpa asisten AI, dan tanpa bertanya kepada teman. Boleh membuka modul dan berkas praktikum Anda sendiri. Setelah selesai, nilai hasil Anda dengan [daftar uji mandiri](#-daftar-uji-mandiri) dan [rubrik](README.md#8-rubrik-penilaian).

| Informasi | Keterangan |
| :--- | :--- |
| Bentuk | Simulasi ujian praktik individu (tidak dinilai, kecuali dosen mengumumkan lain) |
| Waktu | 120 menit |
| Bahan awal | [`kode/bahan_simulasi_sewa_alat.dart`](kode/bahan_simulasi_sewa_alat.dart) |
| Nama berkas jawaban | `simulasi_nim_namapanggilan.dart`, misalnya `simulasi_2609106001_rina.dart` |
| Hasil akhir | Aplikasi "Sewa Alat Mapala" dengan halaman daftar, detail, dan formulir |

---

## 📖 Skenario

Unit Kegiatan Mahasiswa Pecinta Alam (Mapala) menyewakan alat berkemah kepada mahasiswa. Selama ini pengurus mencatat semuanya di buku tulis, sehingga sering bingung alat mana yang sedang disewa dan berapa biayanya. Pengurus meminta Anda membuat aplikasi sederhana untuk:

- melihat dan mencari daftar alat,
- menandai alat yang sedang disewa,
- menambah alat baru, dan
- memperkirakan biaya sewa.

---

## 📦 Bahan Awal

Salin seluruh isi [`kode/bahan_simulasi_sewa_alat.dart`](kode/bahan_simulasi_sewa_alat.dart) ke `lib/main.dart` (atau DartPad), lalu jalankan. Jika muncul tulisan **"Bahan siap: 8 alat"**, bahan sudah terbaca. Bahan itu berisi:

| Nama | Isi |
| :--- | :--- |
| `enum JenisAlat` | `tenda`, `tas`, `masak`, `tidur`, masing-masing dengan `label` (misalnya `'Alat masak'`) dan `ikon` |
| `class Alat` | `id` (`int`), `nama`, `jenis` (`JenisAlat`), `hargaPerHari` (`int`), `keterangan` |
| `dataAwal` | `List<Alat>` `const` berisi 8 alat (tabel di bawah) |
| `formatRupiah(int)` | mengubah `35000` menjadi `"Rp35.000"` |

| id | Nama | Jenis | Harga per hari |
| :---: | :--- | :--- | ---: |
| 1 | Tenda Dome 4 Orang | Tenda | Rp35.000 |
| 2 | Tenda Ultralight 2 Orang | Tenda | Rp30.000 |
| 3 | Carrier 60 Liter | Tas | Rp20.000 |
| 4 | Daypack 25 Liter | Tas | Rp10.000 |
| 5 | Kompor Portabel | Alat masak | Rp15.000 |
| 6 | Nesting Set | Alat masak | Rp10.000 |
| 7 | Sleeping Bag | Alat tidur | Rp12.000 |
| 8 | Matras Gulung | Alat tidur | Rp5.000 |

> [!TIP]
> `dataAwal` adalah `List` **`const`** yang tidak bisa ditambah. Untuk ketentuan 5, buat salinannya di *state*, misalnya `List<Alat>.of(dataAwal)`.

---

## 📋 Ketentuan

### Inti (80 poin)

**1. Tema dan mode gelap — 10 poin**

- Judul aplikasi dan judul `AppBar`: **"Sewa Alat Mapala"**.
- `theme` dan `darkTheme` dibuat dari warna benih **`Colors.green`**.
- `IconButton` di `AppBar` untuk berganti mode: ikon `Icons.dark_mode` saat mode terang dan `Icons.light_mode` saat mode gelap, lengkap dengan `tooltip`.
- Pilihan mode disimpan di **akar aplikasi**. Di dalam halaman tidak ada `Colors.xxx` maupun `fontSize`.

**2. Halaman daftar — 15 poin**

- Tampilkan semua alat dengan `ListView.builder`.
- Setiap baris adalah ***class* widget sendiri** (misalnya `BarisAlat`) yang menampilkan:
  - ikon jenis di dalam lingkaran berlatar `primaryContainer` (ikon `onPrimaryContainer`),
  - nama alat dalam satu baris (terpotong rapi jika terlalu panjang),
  - tulisan seperti **"Rp35.000/hari · Tenda"**.
- Saat aplikasi dibuka, alat **id 1** dan **id 7** sedang disewa. Baris alat yang disewa menampilkan **label "Disewa"** (latar `tertiaryContainer`, tulisan `onTertiaryContainer`). Baris lainnya menampilkan ikon `Icons.chevron_right`.

**3. Pencarian dan saringan — 15 poin**

- `SearchBar` bertuliskan "Cari alat" yang mencari berdasarkan **nama**, tanpa membedakan huruf besar dan kecil ("TENDA" menemukan "Tenda Dome 4 Orang").
- Deretan `ChoiceChip`: **Semua**, lalu satu *chip* untuk setiap jenis alat (dibuat dari `JenisAlat.values`). Deretan ini boleh digulir ke samping.
- Pencarian dan saringan berlaku **bersamaan**. Hasilnya adalah **nilai turunan**, bukan variabel yang disimpan.
- Jika tidak ada yang cocok, tampilkan ikon dan tulisan **"Tidak ada alat yang cocok."**

**4. Detail dan perubahan status — 15 poin**

- Mengetuk baris membuka halaman **"Detail Alat"** dengan `Navigator.push`, membawa objek alat dan status sewanya.
- Halaman detail menampilkan ikon jenis berukuran besar, nama, jenis, harga per hari, dan keterangan.
- Tombol **"Sewa alat ini"** (`FilledButton`) untuk alat yang belum disewa, atau **"Batalkan sewa"** (`OutlinedButton`) untuk alat yang sedang disewa.
- Menekan tombol itu menutup halaman detail dengan hasil **`true`**. Halaman daftar lalu mengubah status alat tersebut dan menampilkan `SnackBar`, misalnya **"Matras Gulung disewa."** atau **"Matras Gulung batal disewa."**
- Kembali lewat tombol kembali **tidak** mengubah apa pun.

**5. Formulir tambah alat — 15 poin**

- `FloatingActionButton.extended` bertuliskan **"Tambah alat"** membuka halaman **"Tambah Alat"**.
- Isian dan aturan validasinya:

  | Isian | Widget | Aturan |
  | :--- | :--- | :--- |
  | Nama alat | `TextFormField` | wajib; minimal 3 huruf setelah spasi di awal dan akhir dibuang |
  | Jenis alat | `DropdownButtonFormField<JenisAlat>` | wajib dipilih |
  | Harga sewa per hari | `TextFormField` dengan keyboard angka | angka bulat 1000 sampai 500000 |
  | Keterangan | `TextFormField` tiga baris | boleh kosong; jika kosong, simpan "Belum ada keterangan." |

- Tombol **"Simpan"**: jika semua isian benar, kembali ke daftar sambil membawa objek `Alat` baru dengan **id = jumlah alat + 1**. Alat baru muncul di daftar dan `SnackBar` **"... ditambahkan."** tampil.
- Semua `TextEditingController` dibuang di `dispose`.

**6. Kualitas kode dan uji tampilan — 10 poin**

- Kode terformat, `const` dipakai di tempat yang memungkinkan, dan tidak ada peringatan di editor.
- Tidak ada garis kuning-hitam di lebar **320** dan **360**, di ketiga halaman.
- Semua teks terbaca di mode gelap.

### Pengayaan (20 poin)

**7. Ringkasan sewa — 5 poin.** Jika ada alat yang disewa, tampilkan kartu di atas pencarian (latar `primaryContainer`) berisi jumlah alat yang disewa dan total biaya per hari, misalnya **"2 alat disewa · Rp47.000/hari"**. Angkanya dihitung dari **seluruh** alat, tidak dipengaruhi pencarian dan saringan. Jika tidak ada alat yang disewa, kartu tidak tampil.

**8. Fitur khusus: lama sewa — 5 poin.** Di dalam kartu ringkasan, tambahkan `Slider` lama sewa **1–7 hari** (bilangan bulat) dan tulisan total biayanya, misalnya **"Total 3 hari: Rp141.000"**.

**9. Dua panel — 10 poin.** Mulai lebar jendela **840**:

- daftar (lebar 400) tampil di kiri dan detail di kanan;
- mengetuk baris hanya mengganti isi panel kanan, tidak membuka halaman baru, dan baris itu ditandai terpilih;
- sebelum ada yang dipilih, panel kanan bertuliskan **"Pilih alat di sebelah kiri."**;
- tombol sewa/batal di panel kanan langsung mengubah status;
- widget detail yang **sama** dipakai di halaman detail dan di panel kanan.

---

## 🖼️ Rancangan Tampilan

Susunan, ikon, dan jarak boleh berbeda selama ketentuan terpenuhi.

```text
Lebar < 840 (ponsel)                   Halaman "Detail Alat"
┌──────────────────────────────────┐   ┌──────────────────────────────────┐
│ Sewa Alat Mapala               ◐ │   │ ←  Detail Alat                   │
├──────────────────────────────────┤   ├──────────────────────────────────┤
│ ┌──────────────────────────────┐ │   │             ┌──────┐             │
│ │ 2 alat disewa · Rp47.000/hari│ │   │             │  ◉   │             │
│ │ Total 1 hari: Rp47.000       │ │   │             └──────┘             │
│ │ ●─────────────────────────── │ │   │ Matras Gulung                    │
│ └──────────────────────────────┘ │   │ (◉ Alat tidur)                   │
│ ( Cari alat                    ) │   │ Rp5.000 per hari                 │
│ [Semua] [Tenda] [Tas] [Alat ma…  │   │ Busa setebal 1 cm, ringan, ...   │
│ (◉) Tenda Dome 4 Orang  [Disewa] │   │                                  │
│     Rp35.000/hari · Tenda        │   │ [        Sewa alat ini        ]  │
│ (◉) Tenda Ultralight 2 Orang   › │   │                                  │
│     Rp30.000/hari · Tenda        │   └──────────────────────────────────┘
│ ...                              │
│                  [+ Tambah alat] │
└──────────────────────────────────┘

Lebar ≥ 840
┌───────────────────────────────────────────────────────────────────────┐
│ Sewa Alat Mapala                                                    ◐ │
├────────────────────────────────┬──────────────────────────────────────┤
│ ┌────────────────────────────┐ │               ┌──────┐               │
│ │ 2 alat disewa · Rp47.000/… │ │               │  ◉   │               │
│ └────────────────────────────┘ │               └──────┘               │
│ ( Cari alat                  ) │ Matras Gulung                        │
│ [Semua] [Tenda] [Tas] ...      │ (◉ Alat tidur)                       │
│ ...                            │ Rp5.000 per hari                     │
│ (◉) Matras Gulung  ← terpilih  │ ...                                  │
│                                │ [          Sewa alat ini          ]  │
│                                │                     [+ Tambah alat]  │
└────────────────────────────────┴──────────────────────────────────────┘
  daftar (lebar 400)                detail (widget yang sama)
```

---

## ✅ Daftar Uji Mandiri

Jalankan langkah berikut **berurutan** pada aplikasi Anda. Hasil yang diharapkan ditulis di kolom kanan.

| No | Langkah | Hasil yang diharapkan |
| :---: | :--- | :--- |
| 1 | Jalankan aplikasi | 8 alat tampil; Tenda Dome 4 Orang dan Sleeping Bag berlabel **Disewa**; ringkasan "2 alat disewa · Rp47.000/hari" |
| 2 | Ketik `TENDA` di pencarian | Hanya Tenda Dome 4 Orang dan Tenda Ultralight 2 Orang |
| 3 | Biarkan `TENDA`, pilih *chip* **Tas** | "Tidak ada alat yang cocok." |
| 4 | Hapus pencarian, pilih *chip* **Alat tidur** | Sleeping Bag (Disewa) dan Matras Gulung |
| 5 | Ketuk Matras Gulung, lalu tekan tombol **kembali** | Kembali ke daftar; tidak ada yang berubah, tidak ada `SnackBar` |
| 6 | Ketuk Matras Gulung, tekan **Sewa alat ini** | Kembali ke daftar; Matras Gulung berlabel Disewa; `SnackBar` "Matras Gulung disewa."; ringkasan "3 alat disewa · Rp52.000/hari" |
| 7 | Geser *slider* lama sewa ke 3 | "Total 3 hari: Rp156.000" |
| 8 | Buka **Tambah alat**, langsung tekan **Simpan** | Pesan *error* di nama, jenis, dan harga; tetap di halaman formulir |
| 9 | Isi nama `Ab`, harga `15.000`, tekan **Simpan** | Pesan *error* di nama (kurang dari 3 huruf) dan di harga (bukan angka bulat) |
| 10 | Isi nama `Hammock`, jenis Alat tidur, harga `8000`, keterangan kosong, **Simpan** | Kembali ke daftar; `SnackBar` "Hammock ditambahkan."; Hammock muncul saat *chip* Alat tidur dipilih; detailnya bertuliskan "Belum ada keterangan." |
| 11 | Tekan tombol mode gelap, periksa ketiga halaman | Semua teks terbaca; ikon tombol berganti menjadi matahari |
| 12 | Ubah lebar jendela menjadi **320**, lalu **360** | Tidak ada garis kuning-hitam di daftar, detail, dan formulir |
| 13 | Ubah lebar jendela menjadi **1000** | Dua panel; panel kanan "Pilih alat di sebelah kiri." |
| 14 | Ketuk Hammock, tekan **Sewa alat ini** di panel kanan | Tidak ada halaman baru; Hammock berlabel Disewa; ringkasan "4 alat disewa · Rp60.000/hari" |

> [!TIP]
> **Cara mengubah lebar jendela:** di Chrome, seret tepi jendela atau tekan `F12` lalu `Ctrl` + `Shift` + `M` dan ketik lebarnya. Di DartPad, perkecil atau perbesar jendela *browser*. Penjelasan lengkapnya di [Modul Pertemuan 7, Bagian 15](../pertemuan_07_material3_dan_responsif/README.md#15-cara-menguji-tampilan-responsif).

---

## 📊 Menilai Diri Sendiri

Isi tabel ini dengan jujur memakai [rubrik](README.md#8-rubrik-penilaian), lalu tuliskan bagian yang perlu Anda ulang.

| No | Ketentuan | Bobot | Skor saya | Catatan (apa yang belum berjalan?) |
| :---: | :--- | :---: | :---: | :--- |
| 1 | Tema dan mode gelap | 10 | | |
| 2 | Halaman daftar | 15 | | |
| 3 | Pencarian dan saringan | 15 | | |
| 4 | Detail dan perubahan status | 15 | | |
| 5 | Formulir tambah alat | 15 | | |
| 6 | Kualitas kode dan uji tampilan | 10 | | |
| 7 | Ringkasan sewa | 5 | | |
| 8 | Lama sewa | 5 | | |
| 9 | Dua panel | 10 | | |
| | **Total** | **100** | | |

**Catat juga:**

1. Pada menit ke berapa ketentuan inti (1–6) Anda selesai? Jika lebih dari 100 menit, bagian mana yang paling lama?
2. Bagian mana yang Anda salin dari modul? Bisakah Anda menjelaskan setiap barisnya kepada teman?
3. Kesalahan apa yang paling sering muncul, dan bagaimana Anda memperbaikinya?

> [!NOTE]
> Contoh jawaban simulasi dibahas bersama dosen di kelas. Belajarlah dari **perbedaan** antara kode Anda dan contoh jawaban, bukan dengan menghafal contoh jawabannya. Soal UTS memakai tema yang berbeda.

---

[⬅️ Kembali ke Panduan UTS](README.md) · [✍️ Lanjut ke Latihan Persiapan](LATIHAN.md) · [🏠 Beranda](../README.md)

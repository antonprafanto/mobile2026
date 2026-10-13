# Generator Slide Perkuliahan

Folder ini berisi skrip untuk **membuat ulang** slide `.pptx` setiap pertemuan.
Mahasiswa **tidak perlu** menjalankan apa pun di sini — slide jadi sudah tersedia
di folder `slide/` masing-masing pertemuan.

Slide dibuat dari kode (bukan disunting manual) agar:

- tampilan semua pertemuan **seragam** (warna, huruf, tata letak);
- isi slide **selalu sejalan** dengan modul dan kode contoh di repositori;
- setiap slide kode punya **tombol menuju berkas lengkapnya di GitHub**.

## Isi Folder

| Berkas / Folder | Fungsi |
|---|---|
| `buat_slide.js` | Program utama: membaca `konten/pNN.js`, lalu menulis `.pptx` ke `<folder pertemuan>/slide/` |
| `desain.js` | "Sistem desain": tema warna, tata letak, pewarnaan sintaks kode Dart, dan jenis-jenis slide |
| `konten/p01.js`, `konten/p02.js`, … | Isi slide per pertemuan (teks, poin, potongan kode, catatan pembicara) |
| `ikon/` | Ikon PNG putih (Material Design) yang dipakai di slide |
| `buat_ikon.js` | (Opsional) membuat ulang isi folder `ikon/` |

## Membuat Ulang Slide

Prasyarat: [Node.js](https://nodejs.org) versi 18 atau lebih baru.

```bash
cd tools/slide
npm ci                   # sekali saja: memasang pptxgenjs 4.0.1 sesuai package-lock.json
node buat_slide.js       # membuat slide SEMUA pertemuan
node buat_slide.js 02    # hanya Pertemuan 02
```

Hasilnya menimpa berkas lama, misalnya
`pertemuan_02_dasar_dart/slide/PERTEMUAN_02_Dasar_Dart.pptx`.
Folder `node_modules/` tidak ikut di-commit (sudah tercantum di `.gitignore`).

## Menambah Slide Pertemuan Baru

1. Salin `konten/p02.js` menjadi `konten/p03.js`.
2. Ubah bagian identitas di atas berkas:

   ```js
   module.exports = {
     nomor: '03',
     folder: 'pertemuan_03_dart_lanjutan',      // nama folder pertemuan
     namaBerkas: 'PERTEMUAN_03_Dart_Lanjutan',   // nama berkas .pptx
     topik: 'Dart Lanjutan',                     // tampil di kaki slide
     bangun(d) {
       // satu pemanggilan d.xxx({...}) = satu slide
     },
   };
   ```

3. Isi fungsi `bangun(d)` dengan jenis slide yang tersedia (lihat tabel di bawah).
4. Jalankan `node buat_slide.js 03`, lalu buka hasilnya untuk diperiksa.

### Jenis Slide yang Tersedia

| Pemanggilan | Kegunaan |
|---|---|
| `d.judul({ judul, subjudul })` | Slide sampul (latar gelap) |
| `d.tujuan({ pengantar, poin })` | Tujuan pembelajaran bernomor |
| `d.alur({ judul, langkah })` | Proses berurutan (kotak + panah); `langkah` berisi `{ ikon, judul, isi }` |
| `d.bagian({ label, judul, ikon })` | Pembatas antarbagian materi |
| `d.kartu({ judul, kolom, item })` | Kartu berikon; item boleh punya `kode` (potongan kode kecil) |
| `d.statistik({ judul, item, sumber })` | Angka besar + keterangan |
| `d.banding({ judul, kolom })` | Perbandingan 2–3 kolom; kolom boleh punya `tag`, `sorot`, `contoh` |
| `d.tabel({ judul, kepala, baris })` | Tabel; ukuran baris menyesuaikan ruang kosong |
| `d.kode({ judul, kode, berkas, poin })` | Potongan kode berwarna + penjelasan + tombol ke GitHub |
| `d.lapisan({ judul, lapisan })` | Diagram berlapis (misalnya arsitektur) |
| `d.ringkasan({ poin })` | Ringkasan akhir |
| `d.penutup({ judul, tautan })` | Slide penutup dengan tombol tautan |

Semua jenis slide menerima `catatan` — teks **catatan pembicara** (speaker notes)
untuk dosen. Contoh lengkap pemakaian setiap jenis ada di `konten/p01.js` dan
`konten/p02.js`.

> [!TIP]
> Tulis potongan kode di slide **pendek saja** (maksimal ±16 baris). Kode lengkap
> tetap tinggal di folder `kode/` — slide cukup menautkannya lewat `berkas`.

## Mengganti atau Menambah Ikon

Nama ikon yang dipakai di konten (misalnya `ikon: 'kilat'`) merujuk ke
`ikon/kilat.png`. Untuk menambah ikon baru:

1. Tambahkan pasangan `namaBerkas: 'NamaKomponenIkon'` pada `DAFTAR_IKON`
   di `buat_ikon.js` (nama komponen bisa dicari di
   [react-icons — Material Design](https://react-icons.github.io/react-icons/icons/md/)).
2. Jalankan:

   ```bash
   npm install --no-save react react-dom react-icons sharp
   node buat_ikon.js
   ```

## Catatan Teknis

- Ukuran slide 16:9 (13,33 × 7,5 inci), huruf Calibri (isi) dan Consolas (kode).
- Tema warna mengikuti Flutter (biru `0175C2`, biru muda `13B9FD`) dan ditulis
  ke berkas tema `.pptx`, sehingga bisa diubah sekaligus dari menu
  **Design → Variants** di PowerPoint.
- Tata letak (layout) yang dipakai: `JUDUL`, `BAGIAN`, `KONTEN`. Nomor slide dan
  kaki slide otomatis.
- Alamat repositori untuk tombol GitHub diatur oleh konstanta `REPO` dan `CABANG`
  di `desain.js`.

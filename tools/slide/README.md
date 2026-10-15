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

1. Salin konten pertemuan terakhir, misalnya `konten/p06.js` menjadi `konten/p07.js`.
2. Ubah bagian identitas di atas berkas:

   ```js
   module.exports = {
     nomor: '07',
     folder: 'pertemuan_07_material3_dan_responsif',   // nama folder pertemuan
     namaBerkas: 'PERTEMUAN_07_Material3_dan_Responsif', // nama berkas .pptx
     topik: 'Material 3 & UI Responsif',               // tampil di kaki slide
     bangun(d) {
       // satu pemanggilan d.xxx({...}) = satu slide
     },
   };
   ```

3. Isi fungsi `bangun(d)` dengan jenis slide yang tersedia (lihat tabel di bawah).
4. Jalankan `node buat_slide.js 07`, lalu buka hasilnya untuk diperiksa.

### Jenis Slide yang Tersedia

| Pemanggilan | Kegunaan |
|---|---|
| `d.judul({ judul, subjudul })` | Slide sampul (latar gelap) |
| `d.tujuan({ pengantar, poin })` | Tujuan pembelajaran bernomor |
| `d.alur({ judul, langkah })` | Proses berurutan (kotak + panah); `langkah` berisi `{ ikon, judul, isi }` |
| `d.bagian({ label, judul, ikon })` | Pembatas antarbagian materi |
| `d.kartu({ judul, kolom, item })` | Kartu berikon; item boleh punya `kode` (potongan kode kecil) |
| `d.statistik({ judul, item, sumber })` | Angka besar + keterangan |
| `d.banding({ judul, kolom })` | Perbandingan 2–3 kolom; kolom boleh punya `tag`, `sorot`, `contoh` (ukuran hurufnya diatur `ukuranContoh`) |
| `d.tabel({ judul, kepala, baris })` | Tabel; ukuran baris menyesuaikan ruang kosong |
| `d.kode({ judul, kode, berkas, poin })` | Potongan kode berwarna + penjelasan + tombol ke GitHub |
| `d.layar({ judul, gambar, kode, berkas, poin })` | Tangkapan layar aplikasi di kanan (satu berkas atau daftar berkas dari folder `gambar/` pertemuan), kode/tombol/poin di kiri; atur ukuran gambar dengan `tinggiGambar` dan `lebarMaks` |
| `d.lapisan({ judul, lapisan })` | Diagram berlapis (misalnya arsitektur) |
| `d.ringkasan({ poin })` | Ringkasan akhir |
| `d.penutup({ judul, tautan })` | Slide penutup dengan tombol tautan |

Semua jenis slide menerima `catatan` — teks **catatan pembicara** (speaker notes)
untuk dosen. Contoh lengkap pemakaian setiap jenis ada di `konten/p01.js` sampai
`konten/p11.js` (contoh `d.layar` ada di `konten/p04.js` sampai `konten/p11.js`, dan `d.lapisan` ada di `konten/p01.js`, `konten/p05.js`, `konten/p09.js`, `konten/p10.js`, dan `konten/p11.js`).

> [!TIP]
> Tulis potongan kode di slide **pendek saja** (maksimal ±16 baris, dan tidak
> lebih dari ±60 karakter per baris di samping tangkapan layar). Kode lengkap
> tetap tinggal di folder `kode/` — slide cukup menautkannya lewat `berkas`.
> Jika ruangnya sempit, tombol GitHub otomatis memakai label pendek
> ("Kode di GitHub · nama_berkas.dart"). Jika nama berkasnya sendiri masih
> terlalu panjang untuk satu baris, ukuran hurufnya dikecilkan sedikit.

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
- Setelah berkas ditulis, `desain.js` merapikan XML slide: warna tema ditulis ke
  `theme1.xml`, garis bawah tautan pada tombol dihapus, dan `<a:pPr>` ganda di
  tengah paragraf (bawaan pptxgenjs 4 untuk teks berwarna-warni) dibuang agar
  berkas tetap sesuai skema OOXML dan tidak memicu "perbaikan" di PowerPoint.

> [!NOTE]
> **Cara memakai templat ini** (hapus kotak ini setelah selesai):
>
> 1. Salin berkas ini ke folder utama proyek Anda dengan nama `README.md`.
> 2. Ganti semua teks di dalam kurung siku, misalnya `[NAMA APLIKASI]`, serta kata `AKUN` dan `REPOSITORI` di dalam tautan.
> 3. Hapus bagian yang tidak sesuai dengan aplikasi Anda. Panduan lengkapnya ada di [Modul Pertemuan 15, Bagian 17](https://github.com/antonprafanto/mobile2026/blob/main/pertemuan_15_build_rilis_dan_finalisasi/README.md#17-finalisasi-proyek-akhir).

# [NAMA APLIKASI]

[Deskripsi 2–3 kalimat: masalah apa yang diselesaikan aplikasi ini, dan untuk siapa. Contoh: "Tugas Kuliahku membantu mahasiswa mencatat tugas beserta tenggatnya. Daftar tugas tetap bisa dibaca tanpa internet."]

[![Tes](https://github.com/AKUN/REPOSITORI/actions/workflows/tes.yml/badge.svg)](https://github.com/AKUN/REPOSITORI/actions/workflows/tes.yml)

## Coba Sekarang

| | Tautan |
| :--- | :--- |
| 🌐 Versi web | [Buka di *browser*](https://AKUN.github.io/REPOSITORI/) |
| 📱 Android | [Unduh APK terbaru](https://github.com/AKUN/REPOSITORI/releases/latest) |

Saat memasang APK, HP mungkin meminta izin "Pasang aplikasi tidak dikenal" dan Google Play Protect bisa menampilkan peringatan. Hal ini wajar untuk aplikasi yang tidak berasal dari Play Store.

## Tangkapan Layar

<p align="center">
  <img src="docs/tangkapan_layar/beranda.jpg" width="200" alt="[Keterangan gambar: apa yang terlihat di layar beranda]">
  <img src="docs/tangkapan_layar/detail.jpg" width="200" alt="[Keterangan gambar halaman detail]">
  <img src="docs/tangkapan_layar/formulir.jpg" width="200" alt="[Keterangan gambar halaman formulir]">
</p>

## Fitur

- [Fitur 1, misalnya: daftar tugas yang diambil dari server]
- [Fitur 2, misalnya: menambah, mengubah, dan menghapus tugas]
- [Fitur 3, misalnya: data tetap bisa dibaca tanpa internet]
- Mode gelap dan tampilan yang menyesuaikan lebar layar
- Halaman Tentang berisi versi, sumber data, kebijakan privasi, dan lisensi

## Tim

| Nama | NIM | Peran |
| :--- | :--- | :--- |
| [Nama] | [NIM] | [Misalnya: tampilan dan navigasi] |
| [Nama] | [NIM] | [Misalnya: ViewModel dan tes] |
| [Nama] | [NIM] | [Misalnya: *repository*, API, dan penyimpanan lokal] |

## Sumber Data dan Atribusi

| Sumber | Dipakai untuk | Atribusi atau lisensi |
| :--- | :--- | :--- |
| [Nama API, misalnya DummyJSON] ([alamat situsnya]) | [Misalnya: daftar tugas] | [Misalnya: tidak ada syarat atribusi] |
| [Nama sumber lain] | [...] | [...] |

## Cara Menjalankan

**Prasyarat:** Flutter 3.47 (kanal *stable*) dan Google Chrome. Untuk menjalankan di HP: Android SDK dan HP Android dengan *USB debugging* aktif.

```bash
git clone https://github.com/AKUN/REPOSITORI.git
cd REPOSITORI
flutter pub get
flutter run -d chrome
```

[Hapus bagian berikut jika tidak memakai SQLite di Chrome.] Aplikasi ini memakai SQLite. Untuk menjalankannya di Chrome, siapkan dulu berkas pendukungnya:

```bash
dart run sqflite_common_ffi_web:setup
flutter run -d chrome --web-port=8080
```

[Hapus bagian berikut jika tidak ada lingkungan pengembangan.] Untuk menjalankan dengan data palsu, tanpa internet:

```bash
flutter run -d chrome --dart-define=LINGKUNGAN=pengembangan
```

## Pengujian

```bash
flutter test
```

| Berkas tes | Yang diuji |
| :--- | :--- |
| `test/[nama_berkas]_test.dart` | [Aturan yang diuji, termasuk nilai batasnya] |
| `test/[nama_berkas]_test.dart` | [...] |
| `test/[nama_berkas]_test.dart` | [...] |

## Struktur Folder

```text
lib/
├── main.dart
├── domain/
│   └── models/          ← model data
├── data/
│   ├── repositories/    ← kontrak dan implementasi repository
│   └── services/        ← pemanggil API dan database
└── ui/
    ├── core/            ← tema dan widget bersama
    └── [nama_fitur]/    ← view_models/ dan widgets/
test/                    ← tes unit dan tes widget
```

## Membuat Berkas Rilis

```bash
flutter build web          # hasil di build/web/
flutter build apk          # hasil di build/app/outputs/flutter-apk/
```

Versi web terbit otomatis ke GitHub Pages setiap *push* ke `main` (`.github/workflows/web.yml`). APK dibuat otomatis dan dilampirkan di halaman [Releases](https://github.com/AKUN/REPOSITORI/releases) setiap *tag* versi, misalnya `v1.0.0`, di-*push* (`.github/workflows/rilis.yml`).

## Riwayat Versi

Lihat [CHANGELOG.md](CHANGELOG.md).

## Privasi

Lihat [KEBIJAKAN_PRIVASI.md](KEBIJAKAN_PRIVASI.md).

## Lisensi

[Pilih salah satu, lalu hapus yang lain:]

- Hak cipta © 2026 [nama tim]. Semua hak dilindungi.
- Kode aplikasi ini dilisensikan dengan lisensi MIT. Lihat [LICENSE](LICENSE).

## Sumber Kode dan Bantuan AI

[Isi jika diminta dosen: potongan kode dari internet beserta sumbernya, dan bagian yang dibuat dengan bantuan AI.]

---

Proyek akhir mata kuliah Pemrograman Piranti Bergerak, [nama program studi], [nama perguruan tinggi], semester ganjil 2026/2027.

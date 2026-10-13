# ▶️ Panduan Menjalankan Kode Contoh

[🏠 Beranda](../README.md) · [📚 Daftar Panduan](01_cara_belajar.md#daftar-panduan)

Setiap berkas di folder `kode/` adalah **program utuh** yang bisa langsung dijalankan: ada `void main()`, ada `import` yang dibutuhkan, dan tidak bergantung pada berkas lain. Ada dua jenis berkas:

| Jenis | Ciri | Contoh | Cara menjalankan |
| :--- | :--- | :--- | :--- |
| **Dart murni** | Tidak ada `import 'package:flutter/...'`; hasilnya berupa tulisan di konsol | Pertemuan 2 | [Cara 1](#cara-1--dartpad) atau [Cara 3](#cara-3--dart-run-di-terminal) |
| **Aplikasi Flutter** | Ada `import 'package:flutter/material.dart';` dan `runApp(...)` | Pertemuan 1, 4, dan seterusnya | [Cara 1](#cara-1--dartpad) atau [Cara 2](#cara-2--proyek-latihan-flutter-di-komputer-sendiri) |

Bagian paling atas setiap berkas juga selalu berisi petunjuk **CARA MENJALANKAN**.

---

## Cara 1 — DartPad

Cocok untuk: **semua contoh Dart murni** dan **contoh Flutter sederhana** (yang tidak memakai paket tambahan di luar Flutter).

1. Buka <https://dartpad.dev>.
2. Hapus isi editor, lalu tempelkan seluruh isi berkas contoh.
3. Klik **Run**.
   - Program Dart murni: hasilnya muncul di panel konsol/*Output*.
   - Aplikasi Flutter: tampilannya muncul di panel sebelah kanan (atau di tab *Output* pada layar sempit).

> [!NOTE]
> DartPad hanya mendukung sebagian paket dari [pub.dev](https://pub.dev). Untuk contoh yang memakai paket tambahan (mulai pertengahan semester), gunakan Cara 2.

---

## Cara 2 — Proyek Latihan Flutter di Komputer Sendiri

Cocok untuk: **semua contoh Flutter**. Inilah cara yang paling sering kita pakai di lab.

### Langkah satu kali di awal semester

Buat **satu** proyek khusus untuk mencoba contoh-contoh kode:

```bash
cd C:\ppb
flutter create belajar_flutter
cd belajar_flutter
code .
```

### Setiap kali ingin mencoba sebuah contoh

1. Salin seluruh isi berkas contoh dari GitHub (tombol **Copy raw file**).
2. Di VS Code, buka `lib/main.dart`, hapus seluruh isinya, lalu tempelkan.
3. Jalankan:

```bash
flutter run -d chrome
```

4. Jika aplikasi **sudah berjalan** dan Anda mengganti isinya dengan contoh lain, lakukan ***hot restart*** (tekan `R` di terminal), bukan *hot reload*, karena isi fungsi `main()` ikut berubah.

> [!TIP]
> Ingin menyimpan banyak contoh sekaligus? Simpan setiap contoh sebagai berkas terpisah di folder `lib/`, misalnya `lib/contoh_03.dart`, lalu jalankan salah satunya dengan opsi `-t` (*target*):
>
> ```bash
> flutter run -d chrome -t lib/contoh_03.dart
> ```

### Menjalankan di HP Android

Sambungkan HP (lihat [Panduan Instalasi bagian 7](02_instalasi_flutter_windows.md#7-opsional-menyiapkan-android)), lalu jalankan:

```bash
flutter devices   # pastikan HP terdeteksi
flutter run       # pilih HP jika ada beberapa perangkat
```

Untuk menampilkan layar HP ke proyektor, gunakan [scrcpy](https://github.com/Genymobile/scrcpy).

---

## Cara 3 — `dart run` di Terminal

Cocok untuk: **contoh Dart murni**.

1. Simpan kode contoh sebagai berkas, misalnya `contoh_05_null_safety.dart`.
2. Dari folder tempat berkas itu berada, jalankan:

```bash
dart run contoh_05_null_safety.dart
```

> [!NOTE]
> Di terminal, bilangan desimal yang nilainya bulat ditampilkan lengkap dengan `.0` (misalnya `100.0`), sedangkan DartPad menampilkannya sebagai `100`. Nilainya sama; hanya tampilannya yang berbeda.

---

## Untuk yang Mengunduh Seluruh Repositori

Jika Anda meng-*clone* repositori ini dan membukanya di VS Code, jalankan perintah berikut **sekali** di folder utama repositori:

```bash
flutter pub get
```

Setelah itu VS Code dapat memeriksa semua contoh kode (garis merah/kuning akan muncul jika ada yang salah), dan contoh Dart murni bisa langsung dijalankan, misalnya:

```bash
dart run pertemuan_02_dasar_dart/kode/contoh_01_halo_dart.dart
```

> [!IMPORTANT]
> Repositori ini **bukan satu aplikasi utuh**. Berkas `pubspec.yaml` di folder utama hanya dipakai untuk pemeriksaan kualitas kode. Untuk menjalankan contoh Flutter, tetap gunakan proyek latihan Anda sendiri (Cara 2).

---

[🏠 Beranda](../README.md) · [🩺 Troubleshooting](04_troubleshooting.md)

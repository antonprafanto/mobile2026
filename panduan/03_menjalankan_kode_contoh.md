# ▶️ Panduan Menjalankan Kode Contoh

[🏠 Beranda](../README.md) · [📚 Daftar Panduan](01_cara_belajar.md#daftar-panduan)

Setiap berkas di folder `kode/` adalah **program utuh** yang bisa langsung dijalankan: ada `void main()`, ada `import` yang dibutuhkan, dan tidak bergantung pada berkas lain. Ada dua jenis berkas:

| Jenis | Ciri | Contoh | Cara menjalankan |
| :--- | :--- | :--- | :--- |
| **Dart murni** | Tidak ada `import 'package:flutter/...'`; hasilnya berupa tulisan di konsol | Pertemuan 2 dan 3 | [Cara 1](#cara-1--dartpad) atau [Cara 3](#cara-3--dart-run-di-terminal) |
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
> DartPad hanya mendukung sebagian paket dari [pub.dev](https://pub.dev). Paket `go_router` (Pertemuan 6), `provider` (Pertemuan 9), dan `http` (Pertemuan 10) sudah tersedia di DartPad. Paket `sqflite` (Pertemuan 11) **belum** tersedia, jadi contoh Pertemuan 11 dijalankan dengan Cara 2. Cara 2 juga lebih tepat untuk materi penyimpanan, karena Anda perlu membuktikan data tetap ada setelah aplikasi dihentikan lalu dijalankan lagi. Petunjuk **CARA MENJALANKAN** di setiap berkas selalu menyebutkan cara yang tepat.

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

### Contoh yang memakai paket tambahan

Beberapa contoh memakai paket dari luar Flutter. Tandanya ada baris `import 'package:...'` selain `package:flutter/...`, dan petunjuk **CARA MENJALANKAN** di berkasnya menyebutkan paket itu. Pasang paketnya **sekali** di proyek latihan Anda, dari terminal di folder proyek:

| Paket | Dipakai mulai | Cara memasang |
| :--- | :--- | :--- |
| `go_router` | [Pertemuan 6](../pertemuan_06_daftar_dan_navigasi/README.md#132-memasang-paket-go_router) | Tambahkan `go_router: ^17.5.0` di bawah `dependencies:` pada `pubspec.yaml`, simpan, lalu jalankan `flutter pub get` |
| `provider` | [Pertemuan 9](../pertemuan_09_state_dan_mvvm/README.md#63-memasang-paket) | `flutter pub add provider` |
| `http` | [Pertemuan 10](../pertemuan_10_async_dan_rest_api/README.md#41-memasang-paket) | `flutter pub add http` (untuk Android, tambahkan juga izin internet; lihat [Pertemuan 10 Bagian 14.2](../pertemuan_10_async_dan_rest_api/README.md#142-di-android-izin-internet)) |
| `shared_preferences` | [Pertemuan 11](../pertemuan_11_penyimpanan_lokal/README.md#21-memasang-paket) | `flutter pub add shared_preferences` |
| `sqflite` dan `sqflite_common_ffi_web` | [Pertemuan 11](../pertemuan_11_penyimpanan_lokal/README.md#54-memasang-sqflite) | `flutter pub add sqflite sqflite_common_ffi_web`. Khusus Chrome, jalankan juga **sekali** `dart run sqflite_common_ffi_web:setup` (butuh internet) |

Jika paket belum dipasang, VS Code menandai baris `import` dengan garis merah dan pesan `Target of URI doesn't exist`. Lihat [Troubleshooting](04_troubleshooting.md) bila masalahnya berlanjut.

> [!IMPORTANT]
> **Contoh yang menyimpan data (mulai Pertemuan 11):**
>
> - Paket `shared_preferences` dan `sqflite` membawa bagian asli (*plugin*). Jika paketnya dipasang saat aplikasi sedang berjalan, hentikan dulu aplikasinya (`q`), lalu jalankan lagi. *Hot restart* saja tidak cukup.
> - Di Chrome, jalankan selalu dengan *port* yang sama: `flutter run -d chrome --web-port=8080`. Chrome menyimpan data per alamat situs, termasuk nomor *port*-nya. Tanpa *port* tetap, data yang tersimpan seolah-olah hilang setiap kali aplikasi dijalankan ulang ([Pertemuan 11 Bagian 2.4](../pertemuan_11_penyimpanan_lokal/README.md#24-membuktikan-data-benar-benar-tersimpan)).

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

> [!NOTE]
> Sejak Pertemuan 11, `pubspec.yaml` repositori ini memuat paket SQLite yang membawa kode *native* (paket `sqlite3`). Karena itu, `dart run` dari folder utama repositori bisa lebih lama pada kali pertama, sebab Dart menyiapkan pustaka SQLite lebih dulu (butuh internet). Jika terasa lama atau gagal, salin berkas contohnya ke folder lain, lalu jalankan dari sana seperti [Cara 3](#cara-3--dart-run-di-terminal).

---

[🏠 Beranda](../README.md) · [🩺 Troubleshooting](04_troubleshooting.md)

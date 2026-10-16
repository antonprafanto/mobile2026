# ▶️ Panduan Menjalankan Kode Contoh

[🏠 Beranda](../README.md) · [📚 Daftar Panduan](01_cara_belajar.md#daftar-panduan)

Setiap berkas di folder `kode/` adalah **program utuh** yang bisa langsung dijalankan: ada `void main()`, ada `import` yang dibutuhkan, dan tidak bergantung pada berkas lain (kecuali dua berkas tes Pertemuan 14 yang menguji studi kasus Pertemuan 12 dan 13). Ada tiga jenis berkas:

| Jenis | Ciri | Contoh | Cara menjalankan |
| :--- | :--- | :--- | :--- |
| **Dart murni** | Tidak ada `import 'package:flutter/...'`; hasilnya berupa tulisan di konsol | Pertemuan 2 dan 3 | [Cara 1](#cara-1--dartpad) atau [Cara 3](#cara-3--dart-run-di-terminal) |
| **Aplikasi Flutter** | Ada `import 'package:flutter/material.dart';` dan `runApp(...)` | Pertemuan 1, 4, dan seterusnya | [Cara 1](#cara-1--dartpad) atau [Cara 2](#cara-2--proyek-latihan-flutter-di-komputer-sendiri) |
| **Berkas tes** | Nama berakhiran `_test.dart`; ada `import 'package:flutter_test/flutter_test.dart';` | Pertemuan 14 | [Cara 4](#cara-4--flutter-test-untuk-berkas-tes) (tes unit juga bisa di [Cara 1](#cara-1--dartpad)) |

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
> DartPad hanya mendukung sebagian paket dari [pub.dev](https://pub.dev). Paket `go_router` (Pertemuan 6), `provider` (Pertemuan 9), dan `http` (Pertemuan 10) sudah tersedia di DartPad. Paket `sqflite` (Pertemuan 11) **belum** tersedia. Paket `shared_preferences` (Pertemuan 11) memang tersedia, tetapi tidak bisa bekerja karena jendela hasil DartPad tidak diizinkan memakai penyimpanan *browser*. Jadi, semua contoh Pertemuan 11 dijalankan dengan Cara 2. Cara 2 juga lebih tepat untuk materi penyimpanan, karena Anda perlu membuktikan data tetap ada setelah aplikasi dihentikan lalu dijalankan lagi. Contoh Pertemuan 12 kembali bisa dijalankan di DartPad, karena hanya memakai `http` dan `provider`. Di Pertemuan 13, paket `image_picker` dan `geolocator` **tidak** tersedia di DartPad, jadi Contoh 02, 03, 06, dan 08 dijalankan dengan Cara 2; Contoh 01, 04, 05, dan 07 tetap bisa dijalankan di DartPad. Di Pertemuan 14, tes unit (Contoh 01–04) berjalan di DartPad, sedangkan tes widget (Contoh 05–08) hanya berjalan dengan `flutter test` ([Cara 4](#cara-4--flutter-test-untuk-berkas-tes)). Di Pertemuan 15, Contoh 01 dan 06 adalah program Dart murni, dan Contoh 02–05 serta 07 berjalan di DartPad. Paket `package_info_plus` **tidak** tersedia di DartPad, jadi Contoh 04 dan 07 menulis versinya sebagai konstanta. DartPad juga selalu memakai mode *debug* dan tidak bisa diberi `--dart-define`; keduanya dicoba dengan Cara 2 (lihat tip **Mode rilis dan `--dart-define`** di bawah). Di Pertemuan 16, Contoh 01 adalah program Dart murni, sedangkan Contoh 02 dan 03 berjalan di DartPad. Petunjuk **CARA MENJALANKAN** di setiap berkas selalu menyebutkan cara yang tepat.

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
| `image_picker` dan `geolocator` | [Pertemuan 13](../pertemuan_13_fitur_perangkat_dan_izin/README.md#31-menambah-paket) | `flutter pub add image_picker geolocator`. Untuk lokasi di Android, tambahkan juga izin lokasi di `AndroidManifest.xml`; untuk iOS, kalimat alasan di `Info.plist` ([Pertemuan 13 Bagian 3](../pertemuan_13_fitur_perangkat_dan_izin/README.md#3-menyiapkan-proyek-paket-dan-pengaturan-platform)) |
| `url_launcher` | [Pertemuan 13](../pertemuan_13_fitur_perangkat_dan_izin/README.md#13-paket-lain-dan-kapan-memakainya) (jobsheet) | `flutter pub add url_launcher` |
| `package_info_plus` | [Pertemuan 15](../pertemuan_15_build_rilis_dan_finalisasi/README.md#54-menampilkan-versi-di-dalam-aplikasi-package_info_plus) | `flutter pub add package_info_plus` |
| `flutter_launcher_icons` dan `flutter_native_splash` | [Pertemuan 15](../pertemuan_15_build_rilis_dan_finalisasi/README.md#62-membuat-semua-ukuran-ikon-dengan-flutter_launcher_icons) (jobsheet) | `flutter pub add dev:flutter_launcher_icons dev:flutter_native_splash`. Keduanya *dev dependency*: hanya dipakai saat pengembangan, tidak ikut ke dalam aplikasi |

Jika paket belum dipasang, VS Code menandai baris `import` dengan garis merah dan pesan `Target of URI doesn't exist`. Lihat [Troubleshooting](04_troubleshooting.md) bila masalahnya berlanjut.

> [!IMPORTANT]
> **Contoh yang menyimpan data (mulai Pertemuan 11):**
>
> - Paket `shared_preferences` dan `sqflite` membawa bagian asli (*plugin*). Jika paketnya dipasang saat aplikasi sedang berjalan, hentikan dulu aplikasinya (`q`), lalu jalankan lagi. *Hot restart* saja tidak cukup.
> - Di Chrome, jalankan selalu dengan *port* yang sama: `flutter run -d chrome --web-port=8080`. Chrome menyimpan data per alamat situs, termasuk nomor *port*-nya. Tanpa *port* tetap, data yang tersimpan seolah-olah hilang setiap kali aplikasi dijalankan ulang ([Pertemuan 11 Bagian 2.4](../pertemuan_11_penyimpanan_lokal/README.md#24-membuktikan-data-benar-benar-tersimpan)).

> [!TIP]
> **Proyek dengan dua titik masuk (mulai Pertemuan 12).** Pilih berkas `main` yang dijalankan dengan opsi `-t` (*target*), misalnya `flutter run -d chrome --web-port=8080 -t lib/main_pengembangan.dart` untuk versi data palsu. Tanpa `-t`, yang dijalankan adalah `lib/main.dart` ([Pertemuan 12 Bagian 10.3](../pertemuan_12_clean_architecture/README.md#103-dua-titik-masuk-maindart-dan-main_pengembangandart)).

> [!TIP]
> **Mode rilis dan `--dart-define` (mulai Pertemuan 15).** Tambahkan opsinya di perintah yang sama, misalnya `flutter run -d chrome --release` untuk mencoba rasa aplikasi rilis, atau `flutter run -d chrome --dart-define=LINGKUNGAN=pengembangan` untuk memberi pengaturan ([Pertemuan 15 Bagian 2](../pertemuan_15_build_rilis_dan_finalisasi/README.md#21-tiga-mode-tiga-tujuan) dan [Bagian 3](../pertemuan_15_build_rilis_dan_finalisasi/README.md#32-memberi-nilai-dengan---dart-define)). Nilai `--dart-define` ditanamkan saat kompilasi, jadi tidak berubah lewat *hot reload* maupun *hot restart*: hentikan aplikasinya (`q`), lalu jalankan lagi dengan nilai baru. Hasil `flutter build web` dicoba dengan *web server* kecil, `dhttpd --path build/web`, bukan dengan mengklik `index.html` ([Pertemuan 15 Bagian 9.2](../pertemuan_15_build_rilis_dan_finalisasi/README.md#92-mencoba-hasil-build-di-laptop)).

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

## Cara 4 — `flutter test` untuk Berkas Tes

Cocok untuk: **berkas tes** (mulai Pertemuan 14), yaitu berkas yang namanya berakhiran `_test.dart`.

**Di proyek Anda sendiri.** Simpan berkas tes di folder `test/`, lalu jalankan dari folder utama proyek:

```bash
flutter test                         # semua tes di folder test/
flutter test test/nilai_test.dart    # satu berkas saja
```

Perintah ini **tidak** membuka emulator maupun Chrome, jadi tetap ringan untuk laptop RAM 8 GB. Hasilnya berupa baris ringkasan seperti `00:02 +9: All tests passed!`. Cara membacanya ada di [Pertemuan 14, Bagian 2.3](../pertemuan_14_pengujian_dan_debugging/README.md#23-tiga-cara-menjalankan-tes).

**Contoh tes di repositori ini.** Contoh 07 dan 08 Pertemuan 14 mengimpor studi kasus Pertemuan 13 dan 12, jadi jalankan semua contoh tes dari folder utama repositori yang sudah di-*clone* (lihat bagian berikutnya):

```bash
flutter test pertemuan_14_pengujian_dan_debugging/kode/
```

> [!NOTE]
> Tes unit (Contoh 01–04 Pertemuan 14) juga bisa dijalankan di DartPad: tempel isinya, lalu klik **Run**; hasil tesnya tampil di panel **Console**. Tes widget (`testWidgets`) hanya berjalan dengan `flutter test` ([Pertemuan 14, Bagian 6.6](../pertemuan_14_pengujian_dan_debugging/README.md#66-mengapa-tes-widget-tidak-dijalankan-di-dartpad)).

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

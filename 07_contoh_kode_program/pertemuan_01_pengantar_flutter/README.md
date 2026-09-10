# 📱 PANDUAN KODE PROGRAM MANDIRI (PERTEMUAN 01)
## Pengantar Pemrograman Piranti Bergerak, Ekosistem Flutter, & Impeller Engine

Selamat datang di katalog kode program resmi **Pertemuan 01: Pengantar Flutter & Ekosistem Mobile Modern**. Folder ini berisi **17 berkas aplikasi Flutter mandiri (*fully runnable code*)** yang mendemonstrasikan pengenalan ekosistem, arsitektur grafis Impeller, diagnostik sistem, hingga alur kerja Hot Reload.

---

## 📁 Katalog 17 Berkas Kode Siap Run (Per-Slide)

Setiap berkas di bawah ini adalah **1 berkas aplikasi Flutter utuh** (`void main()`, `MaterialApp`, dan `Scaffold`). Cukup salin isinya ke berkas `lib/main.dart` di proyek Flutter lokal Anda untuk langsung menjalankannya!

| Nama Berkas | Topik Slide | Penjelasan Konsep & Manfaat |
| :--- | :---: | :--- |
| **`slide_02_roadmap_semester.dart`** | Slide 02 | Peta jalan pembelajaran 16 pertemuan: dari fondasi UI, arsitektur enterprise, hingga rilis produksi. |
| **`slide_03_relevansi_mobile.dart`** | Slide 03 | Relevansi industri & tren multi-platform mobile (Android, iOS, Web, Desktop) dalam 1 basis kode. |
| **`slide_04_dart_vs_flutter.dart`** | Slide 04 | Perbandingan peran: Dart sebagai bahasa pemrograman logika dan Flutter sebagai UI Toolkit reaktif. |
| **`slide_05_arsitektur_grafis.dart`** | Slide 05 | Lapisan arsitektur Flutter: Framework (Dart), Engine (C++), dan Embedder platform OS. |
| **`slide_06_impeller_engine_demo.dart`** | Slide 06 | Demonstrasi rendering Impeller engine: kompilasi shader AOT (*Ahead-of-Time*) anti-stutter 120 FPS. |
| **`slide_07_diagnostik_flutter_doctor.dart`** | Slide 07 | Simulator interaktif perintah terminal `flutter doctor` untuk verifikasi kesiapan SDK dan Android Studio. |
| **`slide_08_aturan_penamaan_proyek.dart`** | Slide 08 | Validasi penamaan package proyek (`lowercase_with_underscores`) sesuai konvensi Dart/Flutter. |
| **`slide_09_struktur_folder_proyek.dart`** | Slide 09 | Membedah tiga direktori krusial: `lib/` (kode aplikasi), `pubspec.yaml` (konfigurasi), dan platform folder. |
| **`slide_10_pubspec_yaml_simulator.dart`** | Slide 10 | Simulator analisis berkas `pubspec.yaml`: aturan indentasi 2 spasi, manajemen dependensi, dan aset. |
| **`slide_11_hot_reload_vs_restart.dart`** | Slide 11 | Komparasi Hot Reload (mempertahankan state) vs Hot Restart (reset penuh siklus hidup aplikasi). |
| **`slide_12_hello_flutter_minimal.dart`** | Slide 12 | Struktur minimal aplikasi Flutter: fungsi `main()`, `runApp()`, `MaterialApp`, dan widget `Text`. |
| **`slide_13_counter_app_deepdive.dart`** | Slide 13 | Bedah mendalam aplikasi bawaan Counter: peran `StatefulWidget`, method `build()`, dan `setState()`. |
| **`slide_14_chrome_preview_frame.dart`** | Slide 14 | Menjalankan preview Flutter di browser Chrome dengan bingkai mockup smartphone responsif. |
| **`slide_15_device_info_hardware.dart`** | Slide 15 | Menampilkan informasi perangkat, resolusi layar, pixel ratio, dan orientasi hardware secara langsung. |
| **`slide_16_vscode_shortcuts_guide.dart`** | Slide 16 | Panduan pintasan produktivitas VS Code (`Ctrl + ~`, `Alt + Enter`, `F5`) untuk efisiensi pemrograman. |
| **`slide_17_lab_quest_tugas_01.dart`** | Slide 17 | **Solusi Master Lab Quest 01**: Aplikasi kartu identitas pengembang mahasiswa pertama dengan interaktivitas tombol. |
| **`slide_18_preview_modern_dart.dart`** | Slide 18 | Pengantar materi pekan berikutnya: sistem tipe modern, Sound Null Safety, dan fungsi asinkron di Dart. |

---

## ⚡ Langkah Cepat Menjalankan Kode bagi Mahasiswa

Ikuti 3 langkah praktis ini untuk mencoba kode di laptop atau komputer lab:

### 1. Buat Proyek Baru di Terminal VS Code (`Ctrl + ~`)
```bash
flutter create praktikum_p1
cd praktikum_p1
```

### 2. Salin Kode & Jalankan di Chrome (Paling Ringan)
1. Buka berkas `lib/main.dart`.
2. Hapus seluruh isinya, lalu tempelkan (*paste*) kode dari salah satu berkas di atas (contoh: `slide_17_lab_quest_tugas_01.dart`).
3. Tekan **F5** atau ketik di terminal:
   ```bash
   flutter run -d chrome
   ```
*(Atau jalankan di ponsel fisik menggunakan kabel USB + aplikasi `scrcpy`)*.

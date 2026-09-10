# 🎨 PANDUAN KODE PROGRAM MANDIRI (PERTEMUAN 05)
## Material Design 3 & Antarmuka Responsif Lintas Platform

Selamat datang di katalog kode program resmi **Pertemuan 05: Material 3 & Responsive UI**. Folder ini berisi **17 berkas aplikasi Flutter mandiri (*fully runnable code*)** yang mendemonstrasikan desain adaptif, sistem warna dinamis M3, breakpoints, pola Master-Detail, hingga standarisasi komponen reusable.

---

## 📁 Katalog 17 Berkas Kode Siap Run (Per-Slide)

Setiap berkas di bawah ini adalah **1 berkas aplikasi Flutter utuh** (`void main()`, `MaterialApp`, dan `Scaffold`). Cukup salin isinya ke berkas `lib/main.dart` di proyek Flutter lokal Anda untuk langsung menjalankannya!

| Nama Berkas | Topik Slide | Penjelasan Konsep & Manfaat |
| :--- | :---: | :--- |
| **`slide_02_tools_dan_preview_responsif.dart`** | Slide 02 | Konfigurasi pengujian responsif menggunakan Chrome Resize dan Flutter Device Preview. |
| **`slide_03_filosofi_material3.dart`** | Slide 03 | Prinsip Material You: personal, adaptif, ekspresif, dan pengaktifan `useMaterial3: true`. |
| **`slide_04_color_scheme_seed.dart`** | Slide 04 | Palet warna harmonis otomatis menggunakan `ColorScheme.fromSeed()` dan aturan kontras warna. |
| **`slide_05_typography_text_theme.dart`** | Slide 05 | Hierarki tipografi resmi M3: 15 gaya teks (`display`, `headline`, `title`, `body`, `label`). |
| **`slide_06_dynamic_theme_light_dark.dart`** | Slide 06 | Sistem tema dinamis: beralih mulus antara Mode Terang (*Light*), Gelap (*Dark*), dan Sistem OS. |
| **`slide_07_mediaquery_dimensions.dart`** | Slide 07 | Membaca dimensi layar dan orientasi perangkat menggunakan `MediaQuery.sizeOf(context)`. |
| **`slide_08_layoutbuilder_constraints.dart`** | Slide 08 | Tata letak komponen adaptif berbasis batasan ruang induk menggunakan `LayoutBuilder`. |
| **`slide_09_breakpoints_helper.dart`** | Slide 09 | Standarisasi ukuran layar industri: batas sakral Ponsel (<600 dp), Tablet, dan Desktop. |
| **`slide_10_orientation_builder.dart`** | Slide 10 | Menyesuaikan tampilan saat perangkat diputar (*Portrait* vs *Landscape*) via `OrientationBuilder`. |
| **`slide_11_adaptive_navigation.dart`** | Slide 11 | Navigasi adaptif: `NavigationBar` di ponsel bawah otomatis bertransformasi menjadi `NavigationRail` di tablet. |
| **`slide_12_responsive_grid_layout.dart`** | Slide 12 | Grid responsif fleksibel: `maxCrossAxisExtent` untuk ukuran kartu konsisten di semua layar. |
| **`slide_13_master_detail_pattern.dart`** | Slide 13 | Pola Master-Detail: 1 kolom di HP dan 2 kolom berdampingan (*Split-Pane*) di tablet/PC. |
| **`slide_14_adaptive_widgets_native.dart`** | Slide 14 | Widget adaptif multi-platform (`Switch.adaptive`, `Slider.adaptive`) dengan nuansa native OS. |
| **`slide_15_reusable_component_kit.dart`** | Slide 15 | Membangun komponen UI modular yang dapat dipakai ulang (*Design System UI Kit*). |
| **`slide_16_fittedbox_scaling.dart`** | Slide 16 | Perlindungan teks dari font scaling sistem dan luapan kartu menggunakan `FittedBox`. |
| **`slide_17_checklist_responsive_ui.dart`** | Slide 17 | Checklist produksi: 5 aturan emas memastikan aplikasi lolos standar kualitas industri. |
| **`slide_18_lab_quest_dashboard_responsif.dart`** | Slide 18 | **Solusi Master Lab Quest 05**: Dashboard e-commerce responsif dengan tema dinamis & adaptive layout. |

---

## ⚡ Langkah Cepat Menjalankan Kode bagi Mahasiswa

```bash
flutter create praktikum_p5
cd praktikum_p5
flutter run -d chrome
```

# ⚡ PANDUAN KODE PROGRAM MANDIRI (PERTEMUAN 06)
## State Management Reaktif: Cubit & BLoC Pattern

Selamat datang di katalog kode program resmi **Pertemuan 06: State Management Reaktif (flutter_bloc)**. Folder ini berisi **17 berkas aplikasi Flutter mandiri (*fully runnable code*)** yang mendemonstrasikan pemisahan logika bisnis dari antarmuka, imutabilitas state, hingga pemantauan data global.

---

## 📁 Katalog 17 Berkas Kode Siap Run (Per-Slide)

Setiap berkas di bawah ini adalah **1 berkas aplikasi Flutter utuh** (`void main()`, `MaterialApp`, dan `Scaffold`). Cukup salin isinya ke berkas `lib/main.dart` di proyek Flutter lokal Anda untuk langsung menjalankannya!

| Nama Berkas | Topik Slide | Penjelasan Konsep & Manfaat |
| :--- | :---: | :--- |
| **`slide_02_tools_dan_setup_bloc.dart`** | Slide 02 | Instalasi pustaka `flutter_bloc` & `equatable` serta pemasangan ekstensi VS Code Bloc. |
| **`slide_03_ephemeral_vs_app_state.dart`** | Slide 03 | Pemilahan data: *Ephemeral State* (lokal widget) vs *App State* (global lintas halaman). |
| **`slide_04_keterbatasan_setstate.dart`** | Slide 04 | Analisis masalah *Prop Drilling* dan bahaya pemborosan rebuild seluruh layar dengan `setState`. |
| **`slide_05_mental_model_cubit.dart`** | Slide 05 | Mental model Cubit: fungsi aksi memancarkan (*emit*) status baru ke antarmuka secara terarah. |
| **`slide_06_immutability_equatable.dart`** | Slide 06 | Keamanan data tak terubahkan (*Immutable State*) dan perbandingan nilai objek via `Equatable`. |
| **`slide_07_anatomi_cubit_emit.dart`** | Slide 07 | Anatomi kelas Cubit: inisialisasi state awal, method pemanggil, dan fungsi resmi `emit()`. |
| **`slide_08_bloc_provider_context.dart`** | Slide 08 | Injeksi dependensi Cubit ke pohon widget menggunakan `BlocProvider` dan pembacaan `context.read`. |
| **`slide_09_bloc_builder_buildwhen.dart`** | Slide 09 | Merender ulang tampilan secara reaktif menggunakan `BlocBuilder` dan filter performa `buildWhen`. |
| **`slide_10_bloc_listener_side_effects.dart`** | Slide 10 | Menangani efek samping antarmuka (*Side Effects*: SnackBar, Dialog, Navigasi) via `BlocListener`. |
| **`slide_11_bloc_consumer_duo.dart`** | Slide 11 | Penggabungan aksi: `BlocConsumer` untuk kebutuhan render tampilan sekaligus mendengarkan efek samping. |
| **`slide_12_bloc_selector_opt.dart`** | Slide 12 | Optimasi performa ekstrem: `BlocSelector` untuk memfilter rebuild hanya saat field data tertentu berubah. |
| **`slide_13_arsitektur_4_status_ui.dart`** | Slide 13 | Pola standar arsitektur 4 status UI: *Initial*, *Loading*, *Success*, dan *Error* menggunakan sealed class. |
| **`slide_14_multi_bloc_provider.dart`** | Slide 14 | Mengelola banyak Cubit global secara rapi di pintu gerbang aplikasi via `MultiBlocProvider`. |
| **`slide_15_bloc_observer_cctv.dart`** | Slide 15 | Pemantau aliran data terpusat: `BlocObserver` untuk logging transisi state dan error debugging. |
| **`slide_16_refactoring_setstate_cubit.dart`** | Slide 16 | Panduan transformasi bertahap: memindahkan kode lama berbasis `setState()` menuju arsitektur Cubit. |
| **`slide_17_checklist_state_management.dart`** | Slide 17 | 5 Checklist kepatuhan state management sebelum evaluasi proyek tengah semester. |
| **`slide_18_lab_quest_cart_cubit.dart`** | Slide 18 | **Solusi Master Lab Quest 06**: Keranjang belanja interaktif berarsitektur Cubit lengkap dengan 4 status UI. |

---

## ⚡ Langkah Cepat Menjalankan Kode bagi Mahasiswa

```bash
flutter create praktikum_p6
cd praktikum_p6
flutter pub add flutter_bloc equatable
flutter run -d chrome
```

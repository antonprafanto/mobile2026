# PANDUAN KODE PROGRAM MANDIRI (PERTEMUAN 06)
## State Management Reaktif: Cubit & BLoC Pattern

Selamat datang di katalog kode program resmi **Pertemuan 06: State Management Reaktif (flutter_bloc)**. Folder ini berisi **18 berkas aplikasi Flutter mandiri (*fully runnable code*)** yang selaras 100% dengan **26 slide presentasi kuliah**, mendemonstrasikan pemisahan logika bisnis dari antarmuka, imutabilitas state, hingga pemantauan data global.

---

## Katalog 18 Berkas Kode Siap Run & 7 Slide Flowchart (Sinkron Slide 01-26)

Setiap berkas di bawah ini adalah **1 berkas aplikasi Flutter utuh** (`void main()`, `MaterialApp`, dan `Scaffold`). Cukup salin isinya ke berkas `lib/main.dart` di proyek Flutter lokal Anda untuk langsung menjalankannya!

| Slide | Jenis Materi | Nama Berkas Kode / Diagram | Topik & Konsep Kunci |
| :---: | :---: | :--- | :--- |
| **Slide 01** | Cover | `Cover Pertemuan 06` | Capaian Pembelajaran Sub-CPMK 06 & Orientasi Arsitektur |
| **Slide 02** | Kode | **`slide_02_tools_dan_setup_bloc.dart`** | Instalasi pustaka `flutter_bloc` & `equatable` serta shortcut VS Code. |
| **Slide 03** | Kode | **`slide_03_ephemeral_vs_app_state.dart`** | Pemilahan data: *Ephemeral State* (lokal widget) vs *App State* (global). |
| **Slide 04** | Flowchart | *`state-spectrum.png`* | **Diagram Mental Model 1:** Spektrum State Ephemeral vs App State. |
| **Slide 05** | Kode | **`slide_05_keterbatasan_setstate.dart`** | Analisis masalah *Prop Drilling* dan bahaya pemborosan rebuild dengan `setState`. |
| **Slide 06** | Flowchart | *`prop-drilling-vs-provider.png`* | **Diagram Arsitektur 2:** Rantai Prop Drilling vs Distribusi Terpusat. |
| **Slide 07** | Kode | **`slide_07_mental_model_cubit.dart`** | Mental model Cubit: stasiun radio memancarkan (*emit*) status baru ke UI. |
| **Slide 08** | Flowchart | *`cubit-vs-bloc.png`* | **Diagram Komparasi 3:** Alur Kerja Cubit (Fungsi) vs BLoC (Event-Driven). |
| **Slide 09** | Kode | **`slide_09_immutability_equatable.dart`** | Keamanan data tak terubahkan (*Immutable State*) dan peran `Equatable`. |
| **Slide 10** | Kode | **`slide_10_anatomi_cubit_emit.dart`** | Anatomi kelas Cubit: inisialisasi awal, method bisnis, dan proteksi `emit()`. |
| **Slide 11** | Flowchart | *`bloc-udf-flow.png`* | **Flowchart Kunci 4:** Siklus Tertutup *Unidirectional Data Flow* (UDF). |
| **Slide 12** | Kode | **`slide_12_bloc_provider_context.dart`** | Injeksi dependensi via `BlocProvider` dan pembacaan `context.read()`. |
| **Slide 13** | Flowchart | *`bloc-widgets-quadrant.png`* | **Matriks Keputusan 5:** Kuadran 4 Widget Konsumsi Utama BLoC. |
| **Slide 14** | Kode | **`slide_14_bloc_builder_buildwhen.dart`** | Merender ulang tampilan secara reaktif via `BlocBuilder` & filter `buildWhen`. |
| **Slide 15** | Kode | **`slide_15_bloc_listener_side_effects.dart`** | Efek samping UI (*Side Effects*: SnackBar, Dialog, Navigasi) via `BlocListener`. |
| **Slide 16** | Kode | **`slide_16_bloc_consumer_duo.dart`** | Penggabungan aksi: `BlocConsumer` untuk render tampilan sekaligus notifikasi. |
| **Slide 17** | Kode | **`slide_17_bloc_selector_opt.dart`** | Optimasi performa ekstrem: `BlocSelector` untuk filter rebuild field spesifik. |
| **Slide 18** | Kode | **`slide_18_arsitektur_4_status_ui.dart`** | Standar 4 status UI: *Initial*, *Loading*, *Success*, & *Error* via sealed class. |
| **Slide 19** | Kode | **`slide_19_bloc_concurrency.dart`** | Proteksi spam klik transaksi bank & debounce via `bloc_concurrency`. |
| **Slide 20** | Flowchart | *`bloc-concurrency-modes.png`* | **Diagram Konkurensi 6:** Alur Kerja `droppable()` vs `restartable()`. |
| **Slide 21** | Kode | **`slide_21_multi_bloc_provider.dart`** | Panel saklar terpusat: `MultiBlocProvider` di root aplikasi `main.dart`. |
| **Slide 22** | Kode | **`slide_22_bloc_observer_cctv.dart`** | CCTV pemantau global: `BlocObserver` pencatat jejak audit transisi data. |
| **Slide 23** | Kode | **`slide_23_refactoring_setstate_cubit.dart`** | Operasi bedah refactoring: migrasi kode lama `setState()` ke Cubit modular. |
| **Slide 24** | Flowchart | *`comparison-matrix-state.png`* | **Matriks Industri 7:** Peta Keputusan Provider vs Riverpod 2.x vs BLoC. |
| **Slide 25** | Kode | **`slide_25_checklist_state_management.dart`** | 5 Checklist kepatuhan state management sebelum evaluasi proyek UTS. |
| **Slide 26** | Kode | **`slide_26_lab_quest_cart_cubit.dart`** | **Solusi Master Lab Quest 06**: E-Commerce Cart & Wishlist dengan Cubit reaktif. |

---

## Langkah Cepat Menjalankan Kode bagi Mahasiswa

```bash
flutter create praktikum_p6
cd praktikum_p6
flutter pub add flutter_bloc equatable
flutter run -d chrome
```

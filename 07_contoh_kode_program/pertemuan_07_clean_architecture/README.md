# 🏛️ PANDUAN KODE PROGRAM MANDIRI (PERTEMUAN 07)
## Clean Architecture & Enterprise Project Structure (Design Pattern & DI)

Selamat datang di katalog kode program resmi **Pertemuan 07: Clean Architecture & Enterprise Project Structure**. Folder ini berisi **17 berkas aplikasi Flutter mandiri (*fully runnable code*)** yang mendemonstrasikan pemisahan kode berstandar enterprise tanpa membuat mahasiswa pemula bingung.

---

## 🗺️ Peta Konsep Tiga Lapisan (Clean Architecture)

```text
                     ┌──────────────────────────────────────┐
                     │          PRESENTATION LAYER          │
                     │   (Widget UI, Cubit/BLoC, UI States) │
                     └──────────────────┬───────────────────┘
                                        │ memanggil UseCase
                                        ▼
                     ┌──────────────────────────────────────┐
                     │             DOMAIN LAYER             │
                     │  (Entities, Use Cases, Repos Contract│
                     │   *Pure Dart - Bebas UI & Lib Luar*  │
                     └──────────────────▲───────────────────┘
                                        │ diimplementasikan oleh
                                        │ (Dependency Inversion)
                     ┌──────────────────┴───────────────────┐
                     │              DATA LAYER              │
                     │ (Models/DTOs, DataSources, Repo Impl)│
                     └──────────────────────────────────────┘
```

---

## 📁 Katalog 17 Berkas Kode Siap Run (Per-Slide)

Setiap berkas di bawah ini adalah **1 berkas aplikasi Flutter utuh** (`void main()`, `MaterialApp`, dan `Scaffold`). Cukup salin isinya ke berkas `lib/main.dart` di proyek Flutter lokal Anda untuk langsung menjalankannya!

| Nama Berkas | Topik Slide | Penjelasan Konsep & Manfaat |
| :--- | :---: | :--- |
| **`slide_02_tools_dan_setup_di.dart`** | Slide 02 | Cara instalasi paket `get_it`, `equatable`, dan `flutter_bloc` serta mental model Service Locator. |
| **`slide_03_separation_of_concerns.dart`** | Slide 03 | Prinsip *Separation of Concerns*: memisahkan logika hitung bisnis (`TaxCalculator`) dari widget tampilan. |
| **`slide_04_tiga_lapisan_clean_arch.dart`** | Slide 04 | Peta visual 3 lapisan konsentris: Domain (inti), Data (tengah), dan Presentation (luar). |
| **`slide_05_feature_first_structure.dart`** | Slide 05 | Hierarki folder standar industri *Feature-First* (`features/auth/`, `features/product/`) anti konflik Git tim. |
| **`slide_06_domain_entity.dart`** | Slide 06 | Entitas bisnis sejati (*Pure Entity*) yang murni dan dilarang memiliki method JSON parser. |
| **`slide_07_domain_repository_contract.dart`** | Slide 07 | Perjanjian kerja sama (*Repository Contract Interface*) yang mendikte kebutuhan data tanpa tahu sumbernya. |
| **`slide_08_domain_usecase.dart`** | Slide 08 | Interactor / Use Case dengan fungsi tunggal (*Single Responsibility*) yang dapat diuji mandiri dalam 0.1 detik. |
| **`slide_09_data_model_dto.dart`** | Slide 09 | Kelas Model / DTO yang mewarisi Entity dengan kemampuan parsing data mentah API (`fromJson` & `toJson`). |
| **`slide_10_data_sources.dart`** | Slide 10 | Demonstrasi komparasi *Remote Data Source* (Cloud API) vs *Local Data Source* (Offline Cache Storage). |
| **`slide_11_data_repository_impl.dart`** | Slide 11 | Implementasi konkret dari kontrak Domain yang bertugas memanggil DataSource dan mengembalikan Entity murni. |
| **`slide_12_dependency_inversion.dart`** | Slide 12 | Prinsip SOLID *Dependency Inversion* (DIP): menghubungkan modul via interface abstraksi universal. |
| **`slide_13_get_it_service_locator.dart`** | Slide 13 | Mengambil dependensi secara instan di mana saja via `sl<T>()` tanpa prop-drilling parameter widget. |
| **`slide_14_factory_vs_singleton.dart`** | Slide 14 | Kapan menggunakan `registerLazySingleton` (Repo/Dio) dan kapan menggunakan `registerFactory` (Cubit). |
| **`slide_15_presentation_cubit_usecase.dart`** | Slide 15 | Menghubungkan Cubit dengan Use Case: Cubit dilarang menyentuh Repository secara langsung! |
| **`slide_16_end_to_end_clean_flow.dart`** | Slide 16 | Alur data utuh: Tombol UI $\rightarrow$ Cubit $\rightarrow$ UseCase $\rightarrow$ Repo Contract $\rightarrow$ Repo Impl $\rightarrow$ Data. |
| **`slide_17_checklist_clean_architecture.dart`** | Slide 17 | 5 Aturan emas dan pantangan arsitektur enterprise untuk meraih nilai 100 pada evaluasi UTS. |
| **`slide_18_lab_quest_clean_architecture.dart`** | Slide 18 | **Solusi Master Lab Quest 07**: Katalog E-Commerce dengan 3 layer murni, GetIt DI, 4 status UI, dan tombol simulasi error server. |

---

## ⚡ Langkah Cepat Menjalankan Kode bagi Mahasiswa

Ikuti 3 langkah praktis ini untuk mencoba kode di laptop atau komputer lab:

### 1. Buat Proyek Baru di Terminal VS Code (`Ctrl + ~`)
```bash
flutter create praktikum_p7
cd praktikum_p7
```

### 2. Pasang Paket Standar Arsitektur Enterprise 2026
```bash
flutter pub add flutter_bloc equatable get_it
```

### 3. Salin Kode & Jalankan di Chrome (Paling Ringan)
1. Buka berkas `lib/main.dart`.
2. Hapus seluruh isinya, lalu tempelkan (*paste*) kode dari salah satu berkas di atas (contoh: `slide_18_lab_quest_clean_architecture.dart`).
3. Tekan **F5** atau ketik di terminal:
   ```bash
   flutter run -d chrome
   ```
*(Atau jalankan di ponsel fisik menggunakan kabel USB + aplikasi `scrcpy`)*.

---

## 🛡️ 5 Aturan Emas Bersih (Persiapan Evaluasi UTS)

1. **Domain Layer 100% Bebas Flutter:** Folder `domain/` dilarang mengimpor `package:flutter/material.dart`.
2. **Satu Use Case = Satu Tugas:** Hindari Use Case raksasa; gunakan satu kelas per aksi (misal: `GetProductsUseCase`).
3. **Cubit Dilarang Panggil Repository:** Cubit di Presentation Layer hanya boleh memanggil Use Case.
4. **Model Mewarisi Entity:** `class ProductModel extends Product` agar data mentah API terisolasi di Data Layer.
5. **GetIt Terpusat:** Seluruh pendaftaran Service Locator dipusatkan di fungsi `setupLocator()` sebelum `runApp()`.

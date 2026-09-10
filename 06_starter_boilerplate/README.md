# Mobile Course Starter Template (Flutter 2026)
## Repositori Resmi Praktikum Pemrograman Piranti Bergerak

Repositori ini adalah fondasi standar industri (*Clean Architecture & Feature-First*) yang digunakan mahasiswa selama satu semester.

---

## 1. Struktur Folder (*Feature-First Architecture*)

```text
lib/
├── core/                       # Komponen global yang dibagi lintas fitur
│   ├── constants/              # Token warna, gaya teks, aset
│   ├── network/                # Klien HTTP Dio, interceptors, error mapper
│   ├── theme/                  # Konfigurasi Material 3 (Light & Dark mode)
│   └── utils/                  # BLoC observer, validator, helpers
├── features/                   # Modul fitur mandiri (scopable)
│   ├── auth/                   # Contoh: Fitur Autentikasi
│   │   ├── data/               # Models, Remote/Local Data Sources, Repositories Impl
│   │   ├── domain/             # Entities, Use Cases, Repositories Contract
│   │   └── presentation/       # Pages, Widgets, Cubit/BLoC State
│   └── counter_example/        # Contoh referensi State Management Cubit
└── main.dart                   # Entry point aplikasi & GoRouter config
```

---

## 2. Cara Memulai (Getting Started)

1. Gandakan repositori ini ke komputer lokal Anda:
   ```bash
   git clone <URL_REPOSITORI_ANDA>
   cd mobile_starter_2026
   ```

2. Buat berkas `.env` dari contoh template:
   ```bash
   cp .env.example .env
   ```

3. Pasang dependensi (Gunakan flag `--offline` jika di lab komputer):
   ```bash
   flutter pub get
   ```

4. Jalankan analisis statis untuk memastikan tidak ada kesalahan:
   ```bash
   flutter analyze
   ```

5. Jalankan aplikasi di perangkat fisik Anda atau target desktop:
   ```bash
   flutter run
   ```

---

## 3. Peraturan Kualitas Kode (Code Quality Rules)

* Seluruh kode wajib lolos uji `flutter analyze` dengan nol kesalahan dan nol peringatan.
* Dilarang menggunakan fungsi `print()` langsung. Gunakan `debugPrint()` atau biarkan dicatat oleh `AppBlocObserver`.
* Selalu gunakan kata kunci `const` pada widget yang bersifat statis untuk mengoptimalkan memori rendering widget tree.

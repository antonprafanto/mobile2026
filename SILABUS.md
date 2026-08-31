# Silabus Fullstack Mobile Developer dengan Flutter™ SDK

Kurikulum pembelajaran terstruktur, komprehensif, dan siap industri untuk menjadi **Fullstack Mobile Developer** menggunakan **Flutter & Dart**. 

Silabus ini disusun mengacu pada standar global **[roadmap.sh/flutter](https://roadmap.sh/flutter)** dengan penekanan kuat pada integrasi arsitektur nyata: **Frontend (Flutter UI & State Management)**, **Backend Services & API (REST, BaaS, Realtime)**, **Penyimpanan Data (Lokal & Cloud)**, hingga **Testing & Rilis ke Store**.

---

## 🗺️ Peta Alur Belajar (Learning Path)

```
[ 01. Fondasi Dart & Async ] ➔ [ 02. Flutter UI & Layout ] ➔ [ 03. Navigasi & Form ]
                                                                       │
                                                                       ▼
[ 06. Data Lokal & Offline ] ◄── [ 05. REST API & Networking ] ◄── [ 04. State Management ]
            │
            ▼
[ 07. BaaS (Firebase & Supabase) ] ➔ [ 08. Fitur Device & Hardware ] ➔ [ 09. Clean Architecture ]
                                                                                   │
                                                                                   ▼
[ 12. Capstone Project Fullstack ] ◄── [ 11. CI/CD & Rilis Store ] ◄── [ 10. Testing & Optimasi ]
```

---

## 📚 Rincian Modul Pembelajaran

### Modul 01: Fondasi Bahasa Dart & Asynchronous Programming
Memahami bahasa Dart secara mendalam sebagai pilar logika utama Flutter.

- **Sintaks Dasar & Sistem Tipe**: Variables (`var`, `final`, `const`, `late`), Primitive types, Null Safety (`?`, `!`, `??`, `?.`).
- **Struktur Kontrol & Collections**: If/else, Switch-case (Pattern Matching), Loop, `List`, `Map`, `Set`, serta *collection methods* (`map`, `where`, `reduce`, `fold`).
- **Object-Oriented Programming (OOP)**: Class, Constructor (Named, Factory), Inheritance, Abstract Class, Interface, Mixin, dan Extension Methods.
- **Asynchronous Programming**:
  - Event Loop, Microtask vs Event Queue.
  - `Future`, `async`, `await`, error handling dengan `try-catch-finally`.
  - `Stream`, `StreamController`, `async*`, dan `yield`.

---

### Modul 02: Flutter Foundation & Desain UI Modern
Memahami arsitektur internal Flutter dan membangun antarmuka pengguna yang adaptif dan responsif.

- **Arsitektur Internal Flutter**: Widget Tree, Element Tree, dan RenderObject Tree.
- **Stateless vs. Stateful Widget**: Siklus hidup (*Lifecycle*) widget (`initState`, `didUpdateWidget`, `dispose`).
- **Layouting & Positioning**:
  - `Container`, `Padding`, `Margin`, `Center`, `Align`, `SizedBox`.
  - `Row`, `Column`, `Flex`, `Expanded`, `Flexible`, `Spacer`.
  - `Stack`, `Positioned`, `IndexedStack`.
- **Komponen Tampilan Berulang**: `ListView`, `ListView.builder`, `GridView.builder`, `SingleChildScrollView`.
- **Desain Sistem & Adaptabilitas**: Material Design 3, Cupertino Widget (iOS style), `ThemeData`, Dark Mode / Light Mode, `MediaQuery`, dan `LayoutBuilder`.

---

### Modul 03: Navigasi, Routing, dan Form Interaktif
Menghubungkan antar layar aplikasi dan menangani input pengguna dengan aman.

- **Navigasi Dasar**: `Navigator.push`, `Navigator.pop`, *Named Routes*.
- **Deklaratif Routing Modern (`go_router`)**:
  - Route configuration, Path Parameters, Query Parameters.
  - Nested Navigation (*ShellRoute / Bottom Navigation Bar*).
  - Route Guards & Authentication Redirection.
  - Deep Linking (buka layar spesifik via tautan URL/Web).
- **Penanganan Input & Formulir**:
  - `TextFormField`, `TextEditingController`, `FocusNode`.
  - Validasi Input (*Form Validation* & Regular Expressions).
  - Interaksi Feedback: `SnackBar`, `AlertDialog`, `BottomSheet`, `DatePicker`.

---

### Modul 04: Manajemen State (State Management)
Mengelola data aplikasi yang dinamis dari tingkat lokal hingga global dengan standar industri.

- **Konsep Dasar State**: Ephemeral (UI) State vs App (Shared) State.
- **Pendekatan Dasar**: `setState`, `InheritedWidget`, `ValueNotifier`.
- **Provider & ChangeNotifier**:
  - `ChangeNotifierProvider`, `MultiProvider`, `Consumer`, `context.watch()` vs `context.read()`.
- **Riverpod (Modern & Type-Safe)**:
  - `ProviderScope`, `ConsumerWidget`, `StateProvider`, `NotifierProvider`, `AsyncNotifierProvider`.
- **BLoC / Cubit (Enterprise Standard)**:
  - Konsep Event-Driven & Streams.
  - `BlocProvider`, `BlocBuilder`, `BlocListener`, `BlocConsumer`.
  - Perbandingan kapan menggunakan Provider, Riverpod, atau BLoC.

---

### Modul 05: Integrasi REST API & Networking
Menghubungkan aplikasi mobile ke backend server, mengambil data JSON, dan autentikasi token.

- **Komunikasi HTTP**:
  - Metode HTTP: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`.
  - Penggunaan paket `http` dan paket `dio`.
- **Manajemen Request Lanjutan dengan Dio**:
  - BaseOptions, Request/Response Interceptors, Logging, Token Header Injection.
- **Serialisasi JSON**:
  - Manual Parsing (`jsonDecode`, `Map<String, dynamic>`).
  - Automated Generation: `json_serializable`, `build_runner`, dan `freezed` (Immutability).
- **Autentikasi & Keamanan Jaringan**:
  - Flow Login JWT (Access Token & Refresh Token Auto-Refresh).
  - Penanganan Error: Timeout, No Internet, 401 Unauthorized, 500 Server Error.

---

### Modul 06: Penyimpanan Data Lokal & Offline Support
Menyimpan konfigurasi, sesi, cache, dan basis data relasional pada perangkat.

- **Penyimpanan Nilai Sederhana**: `shared_preferences` (Settings & Flags).
- **Penyimpanan Aman**: `flutter_secure_storage` (Menyimpan Token JWT / API Keys).
- **Basis Data Lokal**:
  - Relasional (SQL): `sqflite` / `drift` (Tabel, Relasi, Migrasi Skema).
  - NoSQL (Key-Value/Document): `hive` / `isar` (Cepat, Type-safe).
- **Strategi Offline-First & Caching**:
  - Pola Cache-Then-Network / Single Source of Truth.
  - Sinkronisasi antrean data offline ke server saat koneksi kembali online.

---

### Modul 07: Backend-as-a-Service (Firebase & Supabase)
Membangun backend tanpa mengelola server sendiri untuk mempercepat pengembangan.

- **Ekosistem Firebase**:
  - Firebase Authentication (Email/Password, Google Sign-In).
  - Cloud Firestore (NoSQL, Realtime Listener, Security Rules).
  - Firebase Cloud Storage (Upload & Download file/gambar).
  - Firebase Cloud Messaging (FCM) untuk Push Notification.
- **Ekosistem Supabase (Alternatif Open-Source Postgres)**:
  - Supabase Auth & Row Level Security (RLS).
  - Database PostgreSQL & Supabase Storage.
  - Realtime Subscriptions (Broadcast & Database Changes).

---

### Modul 08: Integrasi Fitur Hardware & Perangkat
Memanfaatkan sensor dan kemampuan native smartphone Android & iOS.

- **Izin Aplikasi (*Permission Handling*)**: `permission_handler` (Runtime Permissions Android & iOS).
- **Kamera & Galeri**: `image_picker`, kompresi gambar, dan cropping.
- **Lokasi & Peta**: `geolocator` (GPS coordinates) & `google_maps_flutter` (Menampilkan peta, marker, polyline).
- **Keamanan Biometrik**: `local_auth` (Fingerprint / Face Unlock di HP).
- **Fitur Perangkat Lainnya**: URL Launcher, Share Sheet, QR Code Scanner (`mobile_scanner`).

---

### Modul 09: Arsitektur Aplikasi & Clean Code
Menata struktur kode agar mudah dirawat, diuji, dan dikembangkan dalam tim besar.

- **Prinsip SOLID & Design Patterns**: Single Responsibility, Dependency Inversion, Singleton, Factory.
- **Pola Arsitektur**:
  - *Clean Architecture* (Presentation Layer, Domain Layer, Data Layer).
  - *Feature-First vs Layer-First Organization*.
  - *Repository Pattern* untuk abstraksi sumber data (Remote vs Local).
- **Dependency Injection**:
  - Service Locator menggunakan `get_it` & `injectable`.

---

### Modul 10: Animasi, Custom UI, & UX Polish
Membuat aplikasi terasa responsif, interaktif, dan berstandar profesional.

- **Implicit Animations**: `AnimatedContainer`, `AnimatedOpacity`, `AnimatedCrossFade`, `AnimatedAlign`.
- **Explicit Animations**: `AnimationController`, `CurvedAnimation`, `Tween`, `AnimatedBuilder`.
- **Transisi Antar Layar**: `Hero` animations dan Page Transitions kustom.
- **Animasi Vektor & Lottie**: Integrasi file animasi JSON Lottie.
- **Grafis Kustom**: `CustomPainter` dan `Canvas` (Menggambar grafik, diagram, atau bentuk khusus).

---

### Modul 11: Testing, Debugging, & Optimasi Performa
Memastikan aplikasi stabil, bebas bug, dan memiliki performa 60/120 FPS tanpa lag.

- **Pengujian Otomatis (*Automated Testing*)**:
  - **Unit Testing**: Menguji logika bisnis, model, dan usecase (`test`, `mocktail`).
  - **Widget Testing**: Menguji komponen UI secara terisolasi (`flutter_test`).
  - **Integration Testing**: Menguji alur aplikasi dari awal hingga akhir (`integration_test`).
- **Debugging & Profiling**:
  - Flutter DevTools (Memory Profiler, Network Tab, Widget Inspector).
  - Mengatasi UI Jank (*Dropped Frames*) & Rebuild berlebihan dengan `const` constructor dan selector.
  - Mengidentifikasi Memory Leaks.

---

### Modul 12: CI/CD, Keamanan, & Rilis Aplikasi (Play Store & App Store)
Mempersiapkan aplikasi siap produksi dan otomatisasi alur publikasi.

- **Keamanan Aplikasi**:
  - Obfuscation kode (`--obfuscate --split-debug-info`).
  - Penyembunyian Secrets & API Keys menggunakan Environment Variables (`.env`).
  - Network Security Configuration (SSL Pinning / HTTPS).
- **Persiapan Rilis Android**:
  - Konfigurasi `build.gradle`, App Icon (`flutter_launcher_icons`), Splash Screen (`flutter_native_splash`).
  - Pembuatan Android Keystore (Signing Key) & Android App Bundle (`.aab`).
- **Persiapan Rilis iOS**:
  - Pengenalan Apple Developer Account, Provisioning Profile, dan Sertifikat.
- **Otomatisasi CI/CD**:
  - GitHub Actions untuk automated lint (`flutter analyze`), testing, dan build artifact.
- **Panduan Google Play Console**:
  - Kebijakan Privasi, Data Safety Form, Target API level, dan rilis ke Internal Testing / Production.

---

### 🏆 Capstone Project: Membangun Aplikasi Fullstack End-to-End
Proyek portofolio lengkap yang menggabungkan seluruh konsep dari Modul 01 hingga 12.

**Contoh Studi Kasus Pilihan**:
1. **E-Commerce / Food Delivery App**:
   - Autentikasi (JWT / Firebase Auth).
   - Katalog produk, pencarian realtime, filter kategori.
   - Keranjang belanja lokal (Offline-First dengan SQLite/Hive).
   - Integrasi REST API Backend + Upload bukti transaksi.
   - Pelacakan lokasi kurir di Google Maps.
   - Push Notification saat status pesanan berubah.
2. **Task & Team Collaboration / POS Kasir App**:
   - Multi-user authentication & Role Access.
   - Sinkronisasi data realtime (Firestore / Supabase).
   - Fitur offline mode & sync on reconnect.
   - Export laporan PDF & Cetak Struk via Bluetooth.

---

## ⏱️ Estimasi Waktu Belajar

| Tingkat | Modul | Estimasi Waktu (Jam Belajar) |
| --- | --- | --- |
| **Dasar (Beginner)** | Modul 01 – 03 | 30 – 40 Jam |
| **Menengah (Intermediate)** | Modul 04 – 07 | 45 – 60 Jam |
| **Lanjutan (Advanced)** | Modul 08 – 11 | 40 – 50 Jam |
| **Produksi & Portofolio** | Modul 12 & Capstone | 35 – 50 Jam |
| **Total Keseluruhan** | **12 Modul + Capstone** | **~150 – 200 Jam (~12-16 Minggu)** |

---

## 📖 Sumber Daya & Dokumentasi Resmi

- **Flutter Official Documentation**: [docs.flutter.dev](https://docs.flutter.dev)
- **Dart Language Tour**: [dart.dev/guides](https://dart.dev/guides)
- **Pub.dev Package Repository**: [pub.dev](https://pub.dev)
- **Roadmap.sh Flutter Path**: [roadmap.sh/flutter](https://roadmap.sh/flutter)
- **Material 3 Design Guidelines**: [m3.material.io](https://m3.material.io)

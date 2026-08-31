# Master Silabus Fullstack Mobile Developer dengan Flutter™ SDK (2026 Edition)

Kurikulum standar industri terlengkap dan berorientasi produksi untuk mencetak **Fullstack Mobile Engineer** profesional menggunakan **Flutter & Dart**. 

Silabus ini mengintegrasikan seluruh domain dari standar global **[roadmap.sh/flutter](https://roadmap.sh/flutter)** dengan penambahan sisi **Backend Services, Database, Native Interoperability, Keamanan, CI/CD Otomatis, hingga Pemantauan Produksi**.

---

## 🗺️ Matriks Kurikulum & Alur Belajar

```
┌──────────────────────────────────────────────────────────────────────────────────┐
│ FASE 1: DASAR & INTERFACE (Foundations & UI Engineering)                        │
│ 01. Dart 3+ & Concurrency ➔ 02. Flutter UI & Slivers ➔ 03. Routing & Form System│
└────────────────────────────────────────┬─────────────────────────────────────────┘
                                         │
┌────────────────────────────────────────▼─────────────────────────────────────────┐
│ FASE 2: STATE, NETWORKING & DATA (Architecture & Communication)                  │
│ 04. State Management (Bloc/Riverpod) ➔ 05. REST, WS, GraphQL ➔ 06. Data Lokal & SSOT│
└────────────────────────────────────────┬─────────────────────────────────────────┘
                                         │
┌────────────────────────────────────────▼─────────────────────────────────────────┐
│ FASE 3: FULLSTACK SERVICES & HARDWARE (Backend, Cloud & Device)                  │
│ 07. Backend (Dart Frog/Supabase) ➔ 08. Hardware & Sensor ➔ 09. Platform Channels│
└────────────────────────────────────────┬─────────────────────────────────────────┘
                                         │
┌────────────────────────────────────────▼─────────────────────────────────────────┐
│ FASE 4: ENTERPRISE, POLISH & QUALITY (Scale & UX)                                │
│ 10. Clean Architecture ➔ 11. i18n & a11y ➔ 12. Animasi & Shaders ➔ 13. Testing   │
└────────────────────────────────────────┬─────────────────────────────────────────┘
                                         │
┌────────────────────────────────────────▼─────────────────────────────────────────┐
│ FASE 5: DEVOPS, SECURITY & PRODUCTION (Delivery & Monitoring)                    │
│ 14. Keamanan & Crashlytics ➔ 15. CI/CD, Fastlane & OTA ➔ 🏆 CAPSTONE FULLSTACK   │
└──────────────────────────────────────────────────────────────────────────────────┘
```

---

## 📚 Rincian Lengkap Modul Pembelajaran

---

### 🔹 FASE 1: DASAR & INTERFACE (Foundations & UI Engineering)

#### 📘 Modul 01: Fondasi Dart 3+, OOP, & Concurrency (Isolates)
Menguasai bahasa Dart modern secara mendalam untuk menangani logika aplikasi tanpa lag pada UI.

* **Fitur Modern Dart 3+**:
  - Null Safety fundamental (`?`, `!`, `late`, `??`, `?.`, `??=`).
  - Records & Tuples: Pengembalian multiple value tanpa membuat class baru.
  - Pattern Matching & Destructuring pada Switch Expression, If-case, dan Object Patterns.
  - Class Modifiers: `sealed`, `abstract`, `base`, `interface`, `final`, dan `mixin class`.
* **Object-Oriented Programming (OOP) Lanjutan**:
  - Constructor types: Generative, Named, Factory, Const, dan Redirecting.
  - Generics & Type constraints.
  - Extension Methods & Extension Types.
* **Asynchronous Programming**:
  - Event Loop, Microtask Queue vs Event Queue.
  - `Future`, `async`/`await`, `Future.wait`, `Future.any`, timeout handling.
  - `Stream`, `StreamController`, `async*`, `yield`, transformator stream.
* **Concurrency & Isolates**:
  - Konsep Single-Threaded Event Loop di Dart.
  - Heavy Computation di background thread dengan `compute()`.
  - Komunikasi antar Isolate menggunakan `Isolate.spawn()`, `ReceivePort`, dan `SendPort`.
* **Deliverable / Mini Project**:
  - *CLI High-Performance JSON & Image Matrix Parser* berbasis Isolates multi-thread.

---

#### 📘 Modul 02: Flutter UI Mastery, Slivers, & Desain Adaptif Material 3
Memahami mekanisme render internal Flutter dan membangun antarmuka kelas dunia.

* **Arsitektur Internal & Rendering Pipeline**:
  - Konsep 3 Pohon: **Widget Tree**, **Element Tree**, dan **RenderObject Tree**.
  - Pipeline Render: Build, Layout, Paint, Compositing, Rasterize.
  - Mengoptimalkan repaint dengan `RepaintBoundary`.
* **Lifecycle & State Dasar**:
  - `StatelessWidget` vs `StatefulWidget`.
  - State Lifecycle: `initState`, `didChangeDependencies`, `didUpdateWidget`, `dispose`.
  - App Lifecycle: `AppLifecycleListener` (Deteksi aplikasi paused, resumed, inactive).
* **Advanced Layout & Slivers System**:
  - Box Model: `Container`, `Padding`, `Align`, `SizedBox`, `FractionallySizedBox`.
  - Flexbox Layout: `Row`, `Column`, `Flex`, `Expanded`, `Flexible`, `Spacer`.
  - `Stack`, `Positioned`, `IndexedStack`.
  - Slivers: `CustomScrollView`, `SliverAppBar` (collapsing/pinned/floating), `SliverPersistentHeader`, `SliverList`, `SliverGrid`, `SliverFillRemaining`.
* **Design Systems & Adaptabilitas**:
  - Material Design 3 (M3): ColorScheme, Dynamic Color, Typography, Material Symbols.
  - Cupertino Widgets (iOS Native Style).
  - Multi-theme: Dark Mode, Light Mode, System Theme, dan `ThemeExtension` kustom.
  - Adaptive & Responsive UI: `LayoutBuilder`, `MediaQuery`, `OrientationBuilder`, breakpoint tablet dan layar lipat.
* **Deliverable / Mini Project**:
  - *Spotify / Netflix Home Screen Replica* dengan collapsing dynamic sliver header, carousel, dan adaptive layout.

---

#### 📘 Modul 03: Navigasi Deklaratif (go_router), Deep Linking, & Form System
Membangun alur navigasi yang tangguh serta penanganan data input pengguna yang aman.

* **Routing Deklaratif Modern dengan `go_router`**:
  - Konfigurasi Router, Path Parameters, Query Parameters, dan Extra Data.
  - Nested Navigation dengan `ShellRoute` / `StatefulShellRoute` (Persistent Bottom Navigation Bar & Drawer).
  - Redirection & Route Guards (Proteksi halaman autentikasi/role-based).
  - Error Handling: Halaman 404 kustom dan fallback redirect.
* **Deep Linking & Universal Links**:
  - Pengenalan URI Scheme vs Android App Links (`assetlinks.json`) & iOS Universal Links (`apple-app-site-association`).
  - Konfigurasi menangani klik tautan web langsung menuju halaman produk/layanan di aplikasi.
* **Form & Input Validation System**:
  - `Form`, `FormField`, `TextFormField`, `TextEditingController`, `FocusNode`.
  - Validasi multi-rule (Regex email, password strength, match validation).
  - Custom Input Formatters (Format otomatis nomor HP, NPWP/KTP, dan Rupiah).
  - Feedback UI: `SnackBar`, `AlertDialog`, `ModalBottomSheet`, `DatePicker`, `TimePicker`.
* **Deliverable / Mini Project**:
  - *Multi-Step Onboarding & Checkout Flow* dengan Deep Linking dan Persistent Bottom Navigation.

---

### 🔹 FASE 2: STATE, NETWORKING & DATA (Architecture & Communication)

#### 📘 Modul 04: Manajemen State Kelas Industri (Provider, Riverpod, & BLoC)
Mengelola status data aplikasi dari skala kecil hingga aplikasi enterprise bernilai jutaan transaksi.

* **Fondasi Teori State**:
  - Ephemeral (UI) State vs App (Shared) State.
  - Unidirectional Data Flow (UDF) & Immutability.
* **Provider (Standar Resmi Flutter)**:
  - `ChangeNotifierProvider`, `MultiProvider`, `Consumer`, `Selector`.
  - Membedakan `context.watch()`, `context.read()`, dan `context.select()`.
* **Riverpod 2+ (Modern, Compile-Safe, Zero-Context)**:
  - Konsep `ProviderScope` dan `ConsumerWidget` / `ConsumerStatefulWidget`.
  - Generator Syntax (`@riverpod` & `riverpod_generator`).
  - `NotifierProvider`, `AsyncNotifierProvider` (Penanganan Loading, Data, Error otomatis).
  - Provider Modifiers: `.autoDispose` dan `.family` (Parameterized providers).
* **BLoC & Cubit (Standar Korporat & Enterprise)**:
  - Event-Driven Architecture: Event -> BLoC -> State.
  - Cubit untuk state sederhana berbasis function.
  - `BlocProvider`, `BlocBuilder`, `BlocListener`, `BlocConsumer`, `BlocSelector`.
  - `HydratedBloc` (Auto-persisting state ke storage lokal).
  - Mengelola concurrency event dengan `bloc_concurrency` (`droppable`, `restartable`).
* **Deliverable / Mini Project**:
  - *E-Commerce Cart, Wishlist, & Filter State Engine* yang diimplementasikan dengan BLoC & Riverpod.

---

#### 📘 Modul 05: Networking, REST API, WebSockets, & GraphQL
Menghubungkan aplikasi ke dunia luar dengan protokol komunikasi modern yang aman.

* **Komunikasi REST API dengan Dio**:
  - Setup Client, `BaseOptions`, Timeout, Query Params, Form Data.
  - Dio Interceptors:
    - *Logging Interceptor* untuk debugging.
    - *Auth Token Header Injection*.
    - *Automatic Token Refresh Interceptor* (Menangani 401 Unauthorized secara silent dengan refresh token).
    - *Retry Interceptor* dengan Exponential Backoff saat koneksi putus-nyambung.
  - Pembatalan request menggunakan `CancelToken`.
* **Serialisasi Data & Immutability**:
  - `json_serializable` & `build_runner` (Pembuatan otomatis `fromJson` / `toJson`).
  - `freezed` & `equatable`: Immutability, `copyWith`, Union/Sealed classes untuk State jaringan.
* **Realtime Communication**:
  - WebSockets (`web_socket_channel`): Koneksi bidirectional untuk chat dan live streaming data.
  - Server-Sent Events (SSE) untuk push data satu arah dari server.
* **GraphQL**:
  - Client setup dengan `graphql_flutter`.
  - Query, Mutation, dan Realtime Subscription.
* **Deliverable / Mini Project**:
  - *Realtime Crypto/Stock Ticker & Live Chat Client* dengan auto-refresh token dan WebSocket.

---

#### 📘 Modul 06: Data Lokal, Offline-First, & Database Relasional
Membangun aplikasi yang tetap berjalan lancar meski tanpa koneksi internet (Offline-First).

* **Penyimpanan Nilai Sederhana & Enkripsi**:
  - `shared_preferences` untuk preferensi pengguna dan flags aplikasi.
  - `flutter_secure_storage`: Menyimpan credential, private key, dan token JWT di Android Keystore / iOS Keychain.
* **Basis Data Relasional (SQL)**:
  - `sqflite` vs `drift` (ORM Type-Safe untuk Dart).
  - Skema tabel, Foreign Keys, Indexing, Transaksi, dan Migrasi Skema Versi Database.
  - Relasi One-to-Many dan Many-to-Many.
* **Basis Data NoSQL Berkecepatan Tinggi**:
  - `hive` / `isar`: Key-value & Document store embedded dengan performa tinggi.
* **Arsitektur Offline-First & Pola Sinkronisasi**:
  - Single Source of Truth (SSOT): UI selalu membaca dari Database Lokal, Database Lokal disinkronkan dari Remote API.
  - Cache Invalidation Strategies (Time-To-Live / ETag).
  - Offline Sync Queue: Menyimpan mutasi data (create, update, delete) saat offline dan mengeksekusinya otomatis saat online.
* **Deliverable / Mini Project**:
  - *Offline-First Note & Task Manager with Background Sync Queue*.

---

### 🔹 FASE 3: FULLSTACK SERVICES & HARDWARE (Backend, Cloud & Device)

#### 📘 Modul 07: Sisi Backend untuk Mobile (Dart Frog, Supabase, & Firebase)
Memenuhi peran "Fullstack" sejati dengan merancang, membangun, dan mengelola backend dan cloud service.

* **Membangun Backend Sendiri dengan Dart Frog / Node.js**:
  - Pengenalan Dart Frog (Fullstack Dart dari Frontend ke Backend).
  - Pembuatan RESTful Endpoints (`GET`, `POST`, `PUT`, `DELETE`).
  - Middleware: CORS, Logging, JWT Verification.
  - Koneksi Database PostgreSQL dari backend.
* **Firebase Backend-as-a-Service (BaaS)**:
  - Firebase Authentication: Email/Password, Google Sign-In, Apple Sign-In, Phone OTP.
  - Cloud Firestore: NoSQL Data Modeling, Compound Queries, Subcollections, dan Realtime Snapshots.
  - Firestore Security Rules: Autentikasi, validasi data, dan hak akses dokumen.
  - Firebase Cloud Storage: Upload gambar/video dengan progress bar dan metadata.
* **Supabase (Open-Source PostgreSQL BaaS)**:
  - Supabase Auth, Table Editor, dan Relational Postgres.
  - Row Level Security (RLS) Policies.
  - Realtime Subscriptions pada perubahan tabel database.
  - Supabase Edge Functions (Deno/TypeScript) untuk webhook pembayaran dan komputasi aman.
* **Deliverable / Mini Project**:
  - *Fullstack Micro-Service Backend & Admin Dashboard* terhubung langsung ke aplikasi mobile.

---

#### 📘 Modul 08: Integrasi Fitur Hardware, Sensor, & Background Tasks
Memanfaatkan seluruh sensor dan kapabilitas smartphone Android & iOS.

* **Manajemen Izin (*Permission Handling*)**:
  - `permission_handler`: Mengelola izin kamera, lokasi, mikrofon, penyimpanan di runtime Android 13+ & iOS.
* **Kamera, Galeri, & Media Processing**:
  - `image_picker` & `camera`: Pengambilan foto/video real-time.
  - Kompresi gambar sebelum upload (`flutter_image_compress`), cropping foto profil.
* **Geolokasi & Pemetaan (Maps)**:
  - `geolocator`: Mendapatkan koordinat GPS (Foreground & Background), perhitungan jarak (Haversine formula).
  - `google_maps_flutter`: Peta interaktif, Custom Markers, Polylines rute perjalanan, Geocoding (Alamat <-> Koordinat).
* **Keamanan Biometrik**:
  - `local_auth`: Otentikasi Sidik Jari (Fingerprint) dan Face ID dengan PIN fallback.
* **Background Tasks & Local Notifications**:
  - `flutter_local_notifications`: Notifikasi lokal terjadwal, reminder alarm, rich notifications dengan gambar.
  - `workmanager`: Menjalankan background task terjadwal saat aplikasi ditutup/terminated.
* **Fitur Tambahan**: URL Launcher, Share Sheet, QR Code Scanner (`mobile_scanner`).
* **Deliverable / Mini Project**:
  - *Smart Attendance & Field Tracking App* (Validasi Geofencing GPS, Foto Wajah/Kamera, Biometrik, & Background Sync).

---

#### 📘 Modul 09: Native Platform Channels, Pigeon, & Dart FFI
Menembus batas framework Flutter untuk berkomunikasi langsung dengan OS native Kotlin/Swift/C++.

* **Arsitektur Komunikasi Native Flutter**:
  - `MethodChannel`: Komunikasi request-response asinkron ke Android/iOS.
  - `EventChannel`: Streaming data native berkelanjutan (misal: sensor accelerometer/giroskop).
  - `BasicMessageChannel`: Pertukaran pesan string/biner.
* **Menulis Kode Native**:
  - Android (Kotlin) implementation & iOS (Swift) implementation.
  - Mengakses API OS yang belum tersedia di package pub.dev (misal: Battery Health, MDM Lock, System Settings).
* **Type-Safe Platform Channels dengan Pigeon**:
  - Menghilangkan resiko *runtime string error* dengan generator skema native type-safe.
* **Dart FFI (Foreign Function Interface)**:
  - Memanggil library C / C++ / Rust langsung dari Dart untuk komputasi performa ultra-tinggi atau modul kriptografi.
* **Deliverable / Mini Project**:
  - *Custom Native Device Hardware Inspector Plugin* menggunakan Kotlin, Swift, dan Pigeon.

---

### 🔹 FASE 4: ENTERPRISE, POLISH & QUALITY (Scale & UX)

#### 📘 Modul 10: Arsitektur Skala Besar, Clean Architecture, & Modularization
Menata kode agar terstruktur rapi, *testable*, dan siap dikerjakan oleh puluhan developer sekaligus.

* **Prinsip Desain & OOP**:
  - SOLID Principles dalam ekosistem Flutter & Dart.
  - Design Patterns: Repository Pattern, Factory, Singleton, Observer, Decorator.
* **Clean Architecture (Uncle Bob Pattern)**:
  - **Domain Layer** (Independen, murni Dart): Entities, Value Objects, UseCases / Interactors, Repository Interfaces.
  - **Data Layer**: Models (DTOs), Data Sources (Remote API, Local DB), Repository Implementations.
  - **Presentation Layer**: State Management (BLoC/Riverpod), UI Widgets, Pages.
* **Dependency Injection (DI) & Service Locator**:
  - `get_it` & `injectable`: Injeksi dependensi otomatis dengan anotasi `@injectable`, `@lazySingleton`.
* **Modularization & Multi-Package Architecture**:
  - Memecah monolith app menjadi beberapa internal packages/modules (Core, Auth, Product, Cart, Common UI).
  - Manajemen monorepo dengan **Melos**.
* **Deliverable / Mini Project**:
  - *Enterprise Banking / Fintech Multi-Module Architecture Skeleton*.

---

#### 📘 Modul 11: Internationalization (i18n), Aksesibilitas (a11y), & Desain Adaptif
Menjadikan aplikasi ramah bagi pengguna global dan pengguna dengan kebutuhan khusus.

* **Lokalisasi & Multi-Bahasa (i18n)**:
  - `flutter_localizations` & `intl`.
  - Format file ARB (`app_en.arb`, `app_id.arb`), auto-generating localization classes.
  - Parameter dinamis, Pluralization (jamak/tunggal), dan Gender formatting.
  - Format Angka, Mata Uang (Rupiah `IDR`, Dollar `USD`), dan Tanggal/Waktu lokal.
* **Aksesibilitas (a11y / Accessibility)**:
  - `Semantics` widget untuk mendukung Screen Reader (TalkBack di Android & VoiceOver di iOS).
  - Penyesuaian Dynamic Text Scaling & Contrast ratio standar WCAG.
  - Keyboard navigation & Focus traversal.
* **Deliverable / Mini Project**:
  - *Multi-Lingual Global Booking Portal* dengan full screen-reader accessibility & locale switcher.

---

#### 📘 Modul 12: Animasi Lanjutan, Custom Painter, Shaders, & UX Polish
Menciptakan antarmuka yang memukau, interaktif, dan berkesan profesional.

* **Implicit Animations**:
  - `AnimatedContainer`, `AnimatedOpacity`, `AnimatedPadding`, `AnimatedPositioned`, `AnimatedCrossFade`, `TweenAnimationBuilder`.
* **Explicit Animations**:
  - `AnimationController`, `CurvedAnimation`, `Tween`, `TweenSequence`.
  - `AnimatedBuilder` & `AnimatedWidget` untuk animasi performa tinggi tanpa rebuild widget induk.
  - *Staggered Animations* (Animasi beruntun berurutan).
* **Transisi Antar Halaman & Hero**:
  - `Hero` animations (transisi gambar/elemen mulus antar layar).
  - Custom Page Route Transitions (Slide, Fade, Scale, Shared Axis transition).
* **Grafis Kustom & Shaders**:
  - `CustomPainter` & `Canvas` API: Menggambar shape kustom, path, dan diagram interaktif.
  - Pengenalan Fragment Shaders (GLSL) di Flutter untuk visual effect modern.
* **Animasi Vektor Interaktif**:
  - Integrasi **Lottie** (JSON animations) dan **Rive** (State machine animations).
* **Deliverable / Mini Project**:
  - *Interactive Financial Analytics Dashboard* dengan custom animated charts, particle effects, dan Rive interactive button.

---

#### 📘 Modul 13: Testing Komprehensif, Debugging, & Optimasi Performa
Menjamin aplikasi bebas bug, stabil di berbagai perangkat, dan berjalan mulus 60/120 FPS.

* **Piramida Pengujian Otomatis (*Automated Testing*)**:
  - **Unit Testing**: Menguji logika bisnis murni, UseCases, Repository, dan Model (`test`, `mocktail`).
  - **Widget Testing**: Menguji interaksi UI, input form, rendering komponen, dan pump frames (`flutter_test`).
  - **Integration Testing**: Menguji skenario end-to-end langsung di emulator/perangkat sungguhan (`integration_test`).
  - **Golden UI Tests**: Menguji kesesuaian pixel tampilan dengan *snapshot rendering*.
* **Flutter DevTools & Profiling Mendalam**:
  - Memory Profiler: Mendeteksi Memory Leaks dan retensi objek.
  - CPU Profiler & Timeline: Mengidentifikasi bottleneck dan Frame Dropping (UI Jank).
  - Network Inspector: Mengamati lalu lintas HTTP/WS.
  - Widget Inspector: Mengecek layout constraints dan rebuild count.
* **Teknik Optimasi Performa**:
  - Mencegah rebuild liar: Penggunaan `const` constructor, pemisahan widget kecil, dan selector state.
  - Image Caching (`cached_network_image`), kompresi asset, dan deferred component loading.
* **Deliverable / Mini Project**:
  - *Comprehensive Test Suite (Unit + Widget + Integration)* dengan code coverage > 85% dan Laporan Audit Profiling.

---

### 🔹 FASE 5: DEVOPS, SECURITY & PRODUCTION (Delivery & Monitoring)

#### 📘 Modul 14: Keamanan Aplikasi, Kepatuhan (Compliance), & Crash Reporting
Melindungi data pengguna, memitigasi serangan keamanan, dan memantau kesehatan aplikasi di produksi.

* **Keamanan & Hardening Aplikasi**:
  - Code Obfuscation & Symbol Stripping (`--obfuscate --split-debug-info`).
  - Menyembunyikan Secrets / API Keys via Compile-Time Environment Variables (`--dart-define-from-file`).
  - Network Security: SSL/TLS Certificate Pinning untuk mencegah serangan *Man-In-The-Middle (MITM)*.
  - Root & Jailbreak Detection (`flutter_jailbreak_detection`).
  - Anti-Screen Capture / Blur overlay saat aplikasi di app switcher (Privasi Fintech).
* **Crash Reporting & Error Monitoring**:
  - Integrasi **Firebase Crashlytics** & **Sentry**.
  - Menangkap Uncaught Exceptions, Flutter Errors, dan Platform Errors.
  - Menambahkan Custom Logs, Breadcrumbs, dan User Identity Tagging.
* **Analytics & Telemetry**:
  - Firebase Analytics & PostHog / Mixpanel: Event Tracking, User Funnel, dan Conversion Rate.
* **Regulasi & Kepatuhan Privasi**:
  - Kepatuhan **UU Perlindungan Data Pribadi (UU PDP Indonesia)** & **GDPR**.
  - Alur Consent pengguna, Kebijakan Privasi, dan fitur wajib *Delete Account*.
* **Deliverable / Mini Project**:
  - *Hardened Secure Banking App Shell* dengan Sentry logging, SSL Pinning, dan Anti-Tampering.

---

#### 📘 Modul 15: CI/CD Otomatis, Fastlane, OTA CodePush, & Rilis Store
Otomatisasi penuh dari kode di git hingga terbit di Google Play Store & Apple App Store.

* **Persiapan Rilis Native**:
  - Android: Pembuatan Java Keystore (JKS/PKCS12), signing config di `build.gradle`, konfigurasi Android App Bundle (`.aab`).
  - iOS: Apple Developer Program, Certificates, App Identifiers, Provisioning Profiles, dan Export `.ipa`.
  - App Icon otomatis (`flutter_launcher_icons`) & Splash Screen native (`flutter_native_splash`).
* **Otomatisasi Deployment dengan Fastlane**:
  - Setup Fastlane untuk Android & iOS.
  - Match untuk sinkronisasi sertifikat iOS dalam tim.
  - Distribusi Beta otomatis ke Firebase App Distribution & Apple TestFlight.
* **Continuous Integration & Delivery (CI/CD)**:
  - Setup **GitHub Actions Pipeline**:
    - Step 1: Linting (`flutter analyze`) & Format check.
    - Step 2: Running Automated Unit & Widget Tests.
    - Step 3: Auto Build Release AAB / IPA.
    - Step 4: Auto Deploy ke Google Play Internal Testing & TestFlight.
* **Over-The-Air (OTA) Updates dengan Shorebird**:
  - Konsep CodePush untuk Flutter: Memperbaiki bug kritis secara instan tanpa perlu menunggu review App Store / Play Store.
* **Manajemen Google Play Console & App Store Connect**:
  - Pengisian Data Safety Form, Financial Services Declaration, Content Rating, dan Store Listing (Screenshots, Deskripsi, Video Preview).
* **Deliverable / Mini Project**:
  - *End-to-End Automated CI/CD Pipeline* yang menerbitkan build baru ke Store pada saat git tag di-push.

---

## 🏆 Capstone Project: Enterprise-Grade Fullstack Mobile Application

Siswa merancang, membangun, menguji, dan menerbitkan satu produk aplikasi nyata berskala produksi yang mengintegrasikan seluruh materi Modul 01 – 15.

### Pilihan Studi Kasus Capstone:

#### 🌟 Pilihan 1: Omnichannel Quick-Commerce & Food Delivery SuperApp
* **Frontend Mobile (Flutter)**: Clean Architecture + BLoC/Riverpod, Slivers dynamic home, live tracking maps dengan custom polyline marker, offline cart caching, multi-language.
* **Backend API & BaaS**: Dart Frog / Node.js API + PostgreSQL, Supabase/Firebase Realtime untuk update status order.
* **Hardware & Sensor**: GPS tracking lokasi kurir secara berkala, kamera untuk foto bukti penerimaan barang, push notification FCM saat pesanan diproses.
* **Pembayaran**: Integrasi Payment Gateway (Midtrans / Xendit / Stripe) dengan webhook verifikasi otomatis.
* **DevOps & QA**: Unit & Integration testing coverage > 80%, GitHub Actions CI/CD pipeline, dan rilis APK/AAB siap pasang.

#### 🌟 Pilihan 2: B2B Enterprise POS Kasir & Multi-Outlet Inventory Management
* **Frontend Mobile/Tablet (Flutter)**: Adaptive UI (HP & Tablet), cetak struk Bluetooth thermal printer via Native Platform Channel, export laporan Excel & PDF.
* **Fitur Offline-First**: Database lokal (Drift/SQLite) dengan sinkronisasi antrean otomatis saat kasir terhubung kembali ke internet.
* **Keamanan & Compliance**: Autentikasi biometrik kasir, Role-Based Access Control (Admin, Supervisor, Kasir), audit log perubahan harga.
* **DevOps**: Automated test suite, Sentry error monitoring, dan Fastlane release.

---

## 📑 Lampiran Spesialisasi Tambahan (Appendices)

* **Lampiran A: Integrasi Payment Gateway (Midtrans, Xendit, Stripe)**  
  Snap token, callback URL, webhook handling di backend, dan keamanan transaksi tanpa menyimpan kartu di aplikasi.
* **Lampiran B: In-App Purchase & Subscription (RevenueCat & StoreKit/Play Billing)**  
  Monetisasi aplikasi berbayar, paywall, pengelolaan tier langganan (Monthly/Annual), dan validasi server-to-server receipt.
* **Lampiran C: Audio/Video Streaming & WebRTC**  
  Video player kustom, audio background playback service, dan panggilan video 1-on-1 dengan WebRTC.
* **Lampiran D: Bluetooth Low Energy (BLE) & Integrasi IoT / Thermal Printer**  
  Scan device BLE, koneksi GATT server, dan pengiriman raw ESC/POS byte data ke printer thermal kasir.
* **Lampiran E: On-Device AI & Gemini LLM Integration**  
  Menjalankan model AI lokal ringan di HP dan integrasi Google Gemini API untuk fitur asisten cerdas di dalam Flutter.

---

## ⏱️ Estimasi Waktu & Timeline Belajar

| Fase | Cakupan Modul | Estimasi Jam Belajar | Durasi Rekomendasi |
|---|---|---|---|
| **Fase 1: Foundations & UI** | Modul 01 – 03 | 35 – 45 Jam | Minggu 1 – 3 |
| **Fase 2: State & Data** | Modul 04 – 06 | 45 – 55 Jam | Minggu 4 – 7 |
| **Fase 3: Backend & Hardware**| Modul 07 – 09 | 40 – 50 Jam | Minggu 8 – 10 |
| **Fase 4: Architecture & Polish** | Modul 10 – 13 | 45 – 55 Jam | Minggu 11 – 14 |
| **Fase 5: DevOps & Capstone** | Modul 14 – 15 + Capstone | 50 – 70 Jam | Minggu 15 – 18 |
| **TOTAL** | **15 Modul + Capstone + 5 Lampiran** | **~220 – 275 Jam** | **~16 – 18 Minggu** |

---

## 📖 Sumber Daya & Dokumentasi Resmi

- **Flutter Official Documentation**: [docs.flutter.dev](https://docs.flutter.dev)
- **Dart Language Tour & Specifications**: [dart.dev/guides](https://dart.dev/guides)
- **Roadmap.sh Flutter Path**: [roadmap.sh/flutter](https://roadmap.sh/flutter)
- **Material 3 Design Guidelines**: [m3.material.io](https://m3.material.io)
- **Pub.dev Official Package Repository**: [pub.dev](https://pub.dev)
- **Shorebird CodePush**: [shorebird.dev](https://shorebird.dev)
- **Fastlane Mobile Automation**: [docs.fastlane.tools](https://docs.fastlane.tools)

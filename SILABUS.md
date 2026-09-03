# Master Silabus Fullstack Mobile Developer dengan Flutter™ SDK (2026 Edition)

Kurikulum standar industri terlengkap, berbobot tinggi, dan berorientasi produksi untuk mencetak **Fullstack Mobile Engineer** profesional menggunakan **Flutter & Dart**. 

Silabus ini mengintegrasikan seluruh domain dari standar global **[roadmap.sh/flutter](https://roadmap.sh/flutter)** dengan penambahan sisi **Backend Services, Database, Native Interoperability, Keamanan, CI/CD Otomatis, hingga Pemantauan Produksi**.

---

## 🗺️ Matriks Kurikulum & Alur Belajar

<p align="center">
  <img src="docs/images/roadmap-infographic.jpg" alt="Fullstack Flutter Developer 2026 Roadmap" width="650">
</p>

---

## 📚 Rincian Lengkap Modul Pembelajaran

---

### 🔹 FASE 0: TOOLING & ENVIRONMENT SETUP

#### 📘 Modul 00: Setup Lingkungan Kerja & Tooling Modern 2026
Mempersiapkan alat tempur dan lingkungan pengembangan profesional tanpa hambatan konfigurasi.

* **1.1 Instalasi & Konfigurasi SDK**:
  - Instalasi Flutter SDK (Channel Stable 3.x+) dan Dart SDK.
  - Setup Environment Variables (PATH di Windows/macOS/Linux).
  - Konfigurasi Android Studio, Android SDK Platform-Tools, Command-line Tools, dan Build-Tools.
  - Setup JDK (Java Development Kit) 17 / 21 dan konfigurasi Gradle.
* **1.2 Emulator & Perangkat Fisik**:
  - Konfigurasi Android Virtual Device (AVD) dengan akselerasi hardware (Hyper-V / HAXM).
  - Setup HP Fisik Android: Developer Options, USB Debugging, dan Wireless ADB.
  - Setup iOS Simulator & Xcode (Khusus pengguna macOS).
* **1.3 Editor & Ekstensi Esensial**:
  - VS Code Extensions: Flutter, Dart, Error Lens, Flutter Riverpod Snippets, Bloc, Pubspec Assist, Pretty JSON.
  - Menguasai perintah diagnosa: `flutter doctor -v`, `flutter devices`, `flutter clean`, `flutter pub get`.
* **Deliverable / Hands-on Lab**:
  - Menjalankan `flutter doctor -v` dengan status 100% centang hijau dan menjalankan project *Hello World* pertama di HP/Emulator.

---

### 🔹 FASE 1: DASAR & INTERFACE (Foundations & UI Engineering)

#### 📘 Modul 01: Fondasi Dart 3+, OOP, & Concurrency (Isolates)
Menguasai bahasa Dart modern secara mendalam untuk menangani logika aplikasi yang cepat dan bebas lag.

* **1.1 Sistem Tipe & Null Safety**:
  - Variables (`var`, `final`, `const`, `late`), Type Inference, String Interpolation.
  - Sound Null Safety fundamental (`?`, `!`, `late`, `??`, `?.`, `??=`, `List<String?>` vs `List<String>?`).
* **1.2 Fitur Modern Dart 3+**:
  - Records & Tuples: Mengembalikan multiple values bertipe kuat tanpa membuat class model sementara.
  - Pattern Matching & Destructuring pada Switch Expression, If-Case, dan Object Patterns.
  - Class Modifiers: `sealed` (Exhaustive checking), `abstract`, `base`, `interface`, `final`, dan `mixin class`.
* **1.3 Koleksi & Functional Programming**:
  - `List`, `Map`, `Set`, `Queue`.
  - Spread Operator (`...`, `...?`), Collection-If, Collection-For.
  - Functional methods: `map`, `where`, `reduce`, `fold`, `any`, `every`, `take`, `skip`.
* **1.4 Object-Oriented Programming (OOP) Mendalam**:
  - Constructor types: Generative, Named, Factory (Singleton & Caching), Const, Redirecting, Initializer Lists.
  - Generics & Type constraints (`<T extends Object>`).
  - Extension Methods & Extension Types (Dart 3.3+ zero-cost wrappers).
* **1.5 Asynchronous Programming**:
  - Event Loop: Microtask Queue vs Event Queue.
  - `Future`, `async`/`await`, `Future.wait`, `Future.any`, `Future.delayed`, Timeout Handling, `try-catch-finally`.
  - `Stream`, `StreamController`, `async*`, `yield`, `yield*`, StreamTransformer, Broadcast Streams.
* **1.6 Concurrency & Isolates**:
  - Perbedaan Single-Threaded Event Loop vs Multi-Threading.
  - Background task dengan `compute()`.
  - Heavy Isolate management: `Isolate.spawn()`, komunikasi dua arah via `ReceivePort` dan `SendPort`.
* **Deliverable / Mini Project**:
  - *CLI High-Performance Image Matrix & JSON Parser* multi-thread berbasis Dart Isolates.

---

#### 📘 Modul 02A: Fondasi Flutter UI, Layouting, & Scrolling Dasar
Membangun pemahaman visual pemula dari nol, konsep widget, tata letak kotak & flexbox, serta penanganan daftar data gulir efisien.

* **2A.1 Mental Model & Interaktivitas Dasar**:
  - Konsep *"Everything is a Widget"* dan dekonstruksi anatomi Widget Tree (Analogi Balok LEGO).
  - `StatelessWidget` vs `StatefulWidget`: Kapan tampilan statis dan kapan dinamis.
  - Memahami siklus pembaruan tampilan interaktif dengan `setState()`.
* **2A.2 Kotak Pembangun Tampilan (Box Model)**:
  - `Container` (Dekorasi warna, radius, border, bayangan, margin, padding).
  - `Padding` (Memberi nafas pada komponen), `SizedBox` (Pemisah jarak dimensi pasti), dan `Center`.
* **2A.3 Flexbox Layouting & Alignment**:
  - `Row` (Horizontal) dan `Column` (Vertikal): Mengatur `mainAxisAlignment` & `crossAxisAlignment`.
  - Mengisi ruang kosong dengan `Expanded` dan `Spacer`.
* **2A.4 Menaklukkan Error Keramat Pemula**:
  - Memahami penyebab garis belang kuning-hitam (**RenderFlex Overflow**).
  - 4 Solusi ampuh: `SingleChildScrollView`, `Expanded`, `Wrap` (pilihan turun baris otomatis), dan `FittedBox`.
* **2A.5 Menumpuk Elemen (Layering)**:
  - `Stack` dan `Positioned`: Membuat badge diskon produk, status online avatar, dan overlay.
* **2A.6 Daftar Data Gulir Dinamis**:
  - Mengapa Column dilarang untuk data banyak: Konsep *lazy loading* / daur ulang memori.
  - `ListView.builder`: Menampilkan daftar vertikal efisien.
  - `GridView.builder`: Menampilkan katalog produk 2 kolom responsif.
* **Deliverable / Hands-on Lab**:
  - *TokoKita Mini Profile & Product Catalog App* yang rapi, interaktif, dan bebas overflow.

---

#### 📘 Modul 02B: Advanced Slivers, Theming Material 3, & Arsitektur Mesin Render
Meningkatkan antarmuka ke standar enterprise dengan efek paralaks, custom design token, serta membedah jeroan mesin grafis Flutter.

* **2B.1 Paradigma Slivers & CustomScrollView**:
  - Keterbatasan ListView biasa vs fleksibilitas viewport Slivers.
  - `SliverAppBar`: Efek `pinned`, `floating`, `snap`, dan `stretch` (overscroll header).
  - Mengintegrasikan berbagai sliver: `SliverList`, `SliverGrid`, `SliverToBoxAdapter`, dan `SliverFillRemaining`.
  - Sticky Tab Header kustom dengan `SliverPersistentHeaderDelegate`.
* **2B.2 Material Design 3 (M3) & Enterprise Design System**:
  - Pewarnaan otomatis matematis via `ColorScheme.fromSeed(seedColor: ...)`.
  - Sinkronisasi Light Mode, Dark Mode, dan System Theme.
  - Custom brand design tokens dengan `ThemeExtension` (`copyWith` & `lerp`).
* **2B.3 Desain Adaptif & Multi-Density Retina Tree**:
  - `LayoutBuilder` vs `MediaQuery`: Breakpoint smartphone, tablet, dan foldable.
  - Struktur aset gambar multi-density (`1x`, `2.0x`, `3.0x`) untuk layar retina bebas buram.
* **2B.4 Arsitektur Internal Mesin Flutter (Under the Hood)**:
  - Konsep 3 Pohon: **Widget Tree** (cetak biru), **Element Tree** (pengait), dan **RenderObject Tree** (pekerja komputasi).
  - Pipeline Render 5 Tahap: Build -> Layout -> Paint -> Compositing -> Rasterizing.
  - Evolusi Rendering: Skia vs **Impeller Engine** (Anti-Jank, Vulkan/Metal backend).
  - Mengisolasi area repaint animasi berat menggunakan `RepaintBoundary`.
* **Deliverable / Mini Project**:
  - *TokoKita E-Commerce Parallax Sliver Store Page* dengan dynamic collapsing header, custom brand token, dan adaptive layout.

---

#### 📘 Modul 03A: Navigasi Deklaratif Modern (go_router) & Deep Linking
Membangun alur navigasi aplikasi standar industri yang tangguh, multiplatform, dan terproteksi.

* **3A.1 Routing Deklaratif Modern dengan `go_router`**:
  - Perbandingan Navigasi Imperative (1.0) vs Deklaratif (2.0).
  - Setup Router, Path Parameters (`:id`), Query Parameters (`?q=`), Extra Object passing.
  - Perbedaan `context.go()`, `context.push()`, dan `context.pop()`.
  - Nested Navigation dengan `StatefulShellRoute.indexedStack` (Mempertahankan state scroll antar tab).
  - Redirection & Route Guards terpusat (Proteksi halaman autentikasi/login).
  - Error Handling: Halaman 404 kustom dan fallback redirect.
* **3A.2 Deep Linking & Universal Links**:
  - Konsep Custom URL Scheme vs Android App Links (`assetlinks.json`) & iOS Universal Links (`apple-app-site-association`).
  - Konfigurasi intent filter dan penanganan tautan URL langsung membuka produk spesifik di dalam aplikasi.
* **Deliverable / Mini Project**:
  - *TokoKita Multi-Tab Portal & Detail App* dengan Deep Linking dan Persistent Bottom Navigation.

---

#### 📘 Modul 03B: Form System, Input, Validasi Interaktif, & Penanganan Layar Mundur (PopScope)
Membangun sistem formulir pengumpulan data pengguna yang aman, tervalidasi seketika, dan terlindungi dari kehilangan data.

* **3B.1 Anatomi Form & Validasi Deklaratif**:
  - `Form`, `FormField`, `TextFormField`, `FormState`, `GlobalKey<FormState>`.
  - Fungsi validasi bertipe kuat (Regex email, panjang minimum sandi, teks wajib).
  - Mode validasi interaktif: `AutovalidateMode.onUserInteraction`.
* **3B.2 Pengelolaan State Input & Anti-Bocor Memori**:
  - Siklus hidup `TextEditingController` dan `FocusNode` serta kewajiban `dispose()`.
  - Alur kursor otomatis tombol keyboard Next via `FocusScope.of(context).requestFocus()`.
  - Integrasi pengisi sandi/alamat otomatis OS (`AutofillGroup` & `AutofillHints`).
* **3B.3 Format Mata Uang Otomatis & UI Feedback**:
  - Custom `TextInputFormatter` dengan `intl` (format otomatis nominal Rupiah `Rp 150.000`).
  - Feedback UI: `DatePicker`, `TimePicker`, `ModalBottomSheet`, dan `AlertDialog`.
* **3B.4 Proteksi Layar Mundur Modern (`PopScope`)**:
  - Penggantian resmi `WillPopScope` ke `PopScope` untuk standar Android 14+ Predictive Back.
  - Mencegah kehilangan data formulir saat pengguna menekan tombol Back secara tidak sengaja.
* **Deliverable / Mini Project**:
  - *Checkout Super App 2026* dengan validasi bertahap, format Rupiah otomatis, bottom sheet kurir, dan dialog proteksi batal via `PopScope`.

---

### 🔹 FASE 2: STATE, NETWORKING & DATA (Architecture & Communication)

#### 📘 Modul 04: Manajemen State Kelas Industri (Provider, Riverpod, & BLoC)
Mengelola status data aplikasi dari skala kecil hingga aplikasi enterprise bernilai jutaan transaksi.

* **4.1 Fondasi Teori State**:
  - Ephemeral (UI) State vs App (Shared) State.
  - Unidirectional Data Flow (UDF) & Immutability.
* **4.2 State Bawaan**:
  - `setState`, `InheritedWidget`, `InheritedModel`, `ValueNotifier`, `ValueListenableBuilder`.
* **4.3 Provider (Standar Resmi Flutter)**:
  - `ChangeNotifierProvider`, `MultiProvider`, `Consumer`, `Selector`.
  - Membedakan `context.watch()`, `context.read()`, dan `context.select()`.
* **4.4 Riverpod 2+ (Modern, Compile-Safe, Zero-Context)**:
  - Konsep `ProviderScope` dan `ConsumerWidget` / `ConsumerStatefulWidget`.
  - Generator Syntax (`@riverpod` & `riverpod_generator`).
  - `NotifierProvider`, `AsyncNotifierProvider` (Penanganan Loading, Data, Error otomatis).
  - Provider Modifiers: `.autoDispose` dan `.family` (Parameterized providers).
* **4.5 BLoC & Cubit (Standar Korporat & Enterprise)**:
  - Event-Driven Architecture: Event -> BLoC -> State.
  - Cubit untuk state sederhana berbasis function.
  - `BlocProvider`, `MultiBlocProvider`, `BlocBuilder`, `BlocListener`, `BlocConsumer`, `BlocSelector`.
  - `HydratedBloc` (Auto-persisting state ke storage lokal).
  - Concurrency Transformers: `bloc_concurrency` (`droppable`, `restartable`, `concurrent`, `sequential`).
* **4.6 Matriks Keputusan Industri**:
  - Panduan kapan memilih Provider, Riverpod, atau BLoC di dunia kerja.
* **Deliverable / Mini Project**:
  - *E-Commerce Cart, Wishlist, & Multi-Filter State Engine* yang diimplementasikan dengan BLoC & Riverpod.

---

#### 📘 Modul 05: Networking, REST API (Dio), WebSockets, GraphQL & Freezed
Menghubungkan aplikasi ke dunia luar dengan protokol komunikasi modern yang aman dan andal.

* **5.1 Komunikasi REST API Lanjutan dengan `Dio`**:
  - Setup Client, `BaseOptions`, Timeout, Query Params, Form Data File Upload.
  - Dio Interceptors:
    - *Logging Interceptor* untuk debugging visual.
    - *Auth Token Header Injection*.
    - *Automatic Token Refresh Interceptor* (Menangani 401 Unauthorized secara silent dengan refresh token).
    - *Retry Interceptor* dengan Exponential Backoff saat koneksi internet terputus.
  - Pembatalan request menggunakan `CancelToken`.
* **5.2 Serialisasi Data & Immutability**:
  - `json_serializable` & `build_runner` (Pembuatan otomatis `fromJson` / `toJson`).
  - `freezed` & `equatable`: Immutability, `copyWith`, Union/Sealed classes untuk State jaringan (`Initial`, `Loading`, `Success`, `Error`).
* **5.3 Realtime Communication (WebSockets & SSE)**:
  - WebSockets (`web_socket_channel`): Koneksi bidirectional untuk chat dan live market ticker, heartbeat, auto-reconnect.
  - Server-Sent Events (SSE) untuk push data satu arah dari server.
* **5.4 GraphQL Integration**:
  - Client setup dengan `graphql_flutter`.
  - Query, Mutation, dan Realtime Subscription.
* **5.5 Keamanan Jaringan**:
  - SSL/TLS Certificate Pinning pada Dio untuk memblokir serangan MITM.
* **Deliverable / Mini Project**:
  - *Realtime Crypto/Stock Market Ticker & Live Chat Client* dengan auto-refresh token, Freezed, dan WebSockets.

---

#### 📘 Modul 06: Data Lokal, Offline-First, & Database Relasional (Drift)
Membangun aplikasi yang tetap berjalan lancar meski tanpa koneksi internet (Offline-First).

* **6.1 Penyimpanan Nilai Sederhana & Enkripsi**:
  - `shared_preferences` untuk preferensi pengguna dan flags aplikasi.
  - `flutter_secure_storage`: Menyimpan credential, private key, dan token JWT di Android Keystore / iOS Keychain.
* **6.2 Basis Data Relasional (SQL)**:
  - `sqflite` vs `drift` (ORM Type-Safe untuk Dart).
  - Skema tabel, Foreign Keys, Indexing, Transaksi, Type Converters.
  - Auto-Migrations antar versi schema database tanpa kehilangan data pengguna.
  - Relasi One-to-Many dan Many-to-Many.
* **6.3 Basis Data NoSQL Berkecepatan Tinggi**:
  - `hive` / `isar`: Key-value & Document store embedded dengan performa ultra-cepat.
* **6.4 File System & Image Caching**:
  - `path_provider`, Image caching (`cached_network_image`), file I/O operations.
* **6.5 Arsitektur Offline-First & Pola Sinkronisasi**:
  - Single Source of Truth (SSOT): UI selalu membaca dari Database Lokal, Database Lokal disinkronkan dari Remote API.
  - Cache Invalidation Strategies (Time-To-Live / ETag).
  - Offline Sync Queue: Menyimpan mutasi data (create, update, delete) saat offline dan mengeksekusinya otomatis saat online.
* **Deliverable / Mini Project**:
  - *Offline-First Note & Task Manager with Drift ORM and Background Sync Queue*.

---

### 🔹 FASE 3: FULLSTACK SERVICES & HARDWARE (Backend, Cloud & Device)

#### 📘 Modul 07: Sisi Backend untuk Mobile (Dart Frog, Supabase, & Firebase)
Memenuhi peran "Fullstack" sejati dengan merancang, membangun, dan mengelola backend dan cloud service.

* **7.1 Membangun Backend Sendiri dengan Dart Frog / Node.js**:
  - Pengenalan Dart Frog (Fullstack Dart dari Frontend ke Backend).
  - Pembuatan RESTful Endpoints (`GET`, `POST`, `PUT`, `DELETE`).
  - Middleware: CORS, Logging, JWT Verification.
  - Koneksi Database PostgreSQL dari backend.
* **7.2 Firebase Backend-as-a-Service (BaaS)**:
  - Firebase Authentication: Email/Password, Google Sign-In, Apple Sign-In, Phone OTP.
  - Cloud Firestore: NoSQL Data Modeling, Compound Queries, Subcollections, dan Realtime Snapshots.
  - Firestore Security Rules: Autentikasi, validasi data, dan hak akses dokumen.
  - Firebase Cloud Storage: Upload gambar/video dengan progress bar dan metadata.
  - Firebase Cloud Messaging (FCM) untuk Push Notification ke perangkat.
* **7.3 Supabase (Open-Source PostgreSQL BaaS)**:
  - Supabase Auth, Table Editor, dan Relational Postgres.
  - Row Level Security (RLS) Policies.
  - Realtime Subscriptions pada perubahan tabel database.
  - Supabase Edge Functions (Deno/TypeScript) untuk webhook pembayaran dan komputasi aman.
* **Deliverable / Mini Project**:
  - *Fullstack Micro-Service Backend (Dart Frog) + Supabase BaaS & Admin Dashboard* terhubung ke aplikasi mobile.

---

#### 📘 Modul 08: Integrasi Fitur Hardware, Sensor, & Background Tasks
Memanfaatkan seluruh sensor dan kapabilitas smartphone Android & iOS.

* **8.1 Manajemen Izin (*Permission Handling*)**:
  - `permission_handler`: Mengelola izin kamera, lokasi, mikrofon, penyimpanan di runtime Android 13/14+ & iOS.
* **8.2 Kamera, Galeri, & Media Processing**:
  - `image_picker` & `camera`: Pengambilan foto/video real-time.
  - Kompresi gambar sebelum upload (`flutter_image_compress`), cropping foto profil.
* **8.3 Geolokasi & Pemetaan (Maps)**:
  - `geolocator`: Mendapatkan koordinat GPS (Foreground & Background), perhitungan jarak (Haversine formula).
  - `google_maps_flutter`: Peta interaktif, Custom Markers, Polylines rute perjalanan, Geocoding (Alamat <-> Koordinat).
* **8.4 Keamanan Biometrik**:
  - `local_auth`: Otentikasi Sidik Jari (Fingerprint) dan Face ID dengan PIN fallback.
* **8.5 Background Tasks & Local Notifications**:
  - `flutter_local_notifications`: Notifikasi lokal terjadwal, reminder alarm, rich notifications dengan gambar.
  - `workmanager`: Menjalankan background task terjadwal saat aplikasi ditutup/terminated.
* **8.6 Fitur Perangkat Lainnya**:
  - `sensors_plus` (Accelerometer, Gyroscope), QR/Barcode Scanner (`mobile_scanner`), `url_launcher`, `share_plus`.
* **Deliverable / Mini Project**:
  - *Smart Attendance & Field Tracking App* (Validasi Geofencing GPS, Foto Wajah/Kamera, Biometrik, & Background Sync).

---

#### 📘 Modul 09: Native Platform Channels, Pigeon, & Dart FFI
Menembus batas framework Flutter untuk berkomunikasi langsung dengan OS native Kotlin/Swift/C++.

* **9.1 Arsitektur Komunikasi Native Flutter**:
  - `MethodChannel`: Komunikasi request-response asinkron ke Android/iOS.
  - `EventChannel`: Streaming data native berkelanjutan (misal: sensor accelerometer/giroskop).
  - `BasicMessageChannel`: Pertukaran pesan string/biner.
* **9.2 Menulis Kode Native**:
  - Android (Kotlin) implementation & iOS (Swift) implementation.
  - Mengakses API OS yang belum tersedia di package pub.dev (misal: Battery Health, MDM Lock, System Settings).
* **9.3 Type-Safe Platform Channels dengan Pigeon**:
  - Menghilangkan resiko *runtime string error* dengan generator skema native type-safe.
* **9.4 Dart FFI (Foreign Function Interface)**:
  - Memanggil library C / C++ / Rust langsung dari Dart untuk komputasi performa ultra-tinggi atau modul kriptografi.
* **Deliverable / Mini Project**:
  - *Custom Native Device Hardware Inspector Plugin* menggunakan Kotlin, Swift, dan Pigeon.

---

### 🔹 FASE 4: ENTERPRISE, POLISH & QUALITY (Scale & UX)

#### 📘 Modul 10: Arsitektur Skala Besar, Clean Architecture, & Modularization
Menata kode agar terstruktur rapi, *testable*, dan siap dikerjakan oleh puluhan developer sekaligus.

* **10.1 Prinsip Desain & OOP**:
  - SOLID Principles dalam ekosistem Flutter & Dart.
  - Design Patterns: Repository Pattern, Factory, Singleton, Observer, Decorator.
* **10.2 Clean Architecture (Uncle Bob Pattern)**:
  - **Domain Layer** (Independen, murni Dart): Entities, Value Objects, UseCases / Interactors, Repository Interfaces.
  - **Data Layer**: Models (DTOs), Data Sources (Remote API, Local DB), Repository Implementations.
  - **Presentation Layer**: State Management (BLoC/Riverpod), UI Widgets, Pages.
* **10.3 Dependency Injection (DI) & Service Locator**:
  - `get_it` & `injectable`: Injeksi dependensi otomatis dengan anotasi `@injectable`, `@lazySingleton`.
* **10.4 Modularization & Multi-Package Architecture**:
  - Memecah monolith app menjadi beberapa internal packages/modules (Core, Auth, Product, Cart, Common UI).
  - Manajemen monorepo dengan **Melos**.
* **Deliverable / Mini Project**:
  - *Enterprise Banking / Fintech Multi-Module Architecture Skeleton with Melos*.

---

#### 📘 Modul 11: Internationalization (i18n), Aksesibilitas (a11y), & Desain Adaptif
Menjadikan aplikasi ramah bagi pengguna global dan pengguna dengan kebutuhan khusus.

* **11.1 Lokalisasi & Multi-Bahasa (i18n)**:
  - `flutter_localizations` & `intl`.
  - Format file ARB (`app_en.arb`, `app_id.arb`), auto-generating localization classes.
  - Parameter dinamis, Pluralization (jamak/tunggal), dan Gender formatting.
  - Format Angka, Mata Uang (Rupiah `IDR`, Dollar `USD`), dan Tanggal/Waktu lokal.
* **11.2 Aksesibilitas (a11y / Accessibility)**:
  - `Semantics` widget untuk mendukung Screen Reader (TalkBack di Android & VoiceOver di iOS).
  - Penyesuaian Dynamic Text Scaling & Contrast ratio standar WCAG.
  - Keyboard navigation & Focus traversal.
* **11.3 Adaptive & Foldable UI**:
  - Menangani layar lipat (foldables), dual-screen, tablet, dan desktop breakpoints.
* **Deliverable / Mini Project**:
  - *Multi-Lingual Global Booking Portal* dengan full screen-reader accessibility & locale switcher.

---

#### 📘 Modul 12: Animasi Lanjutan, Custom Painter, Shaders, & UX Polish
Menciptakan antarmuka yang memukau, interaktif, dan berkesan profesional.

* **12.1 Implicit Animations**:
  - `AnimatedContainer`, `AnimatedOpacity`, `AnimatedPadding`, `AnimatedPositioned`, `AnimatedCrossFade`, `TweenAnimationBuilder`.
* **12.2 Explicit Animations**:
  - `AnimationController`, `CurvedAnimation`, `Tween`, `TweenSequence`.
  - `AnimatedBuilder` & `AnimatedWidget` untuk animasi performa tinggi tanpa rebuild widget induk.
  - *Staggered Animations* (Animasi beruntun berurutan).
* **12.3 Transisi Antar Halaman & Hero**:
  - `Hero` animations (transisi gambar/elemen mulus antar layar).
  - Custom Page Route Transitions (Slide, Fade, Scale, Shared Axis transition).
* **12.4 Grafis Kustom & Shaders**:
  - `CustomPainter` & `Canvas` API: Menggambar shape kustom, path, bezier curves, dan diagram interaktif.
  - Pengenalan Fragment Shaders (GLSL) di Flutter untuk visual effect modern.
* **12.5 Animasi Vektor Interaktif**:
  - Integrasi **Lottie** (JSON animations) dan **Rive** (State machine animations).
* **Deliverable / Mini Project**:
  - *Interactive Financial Analytics Dashboard* dengan custom animated charts, particle effects, dan Rive interactive button.

---

#### 📘 Modul 13: Testing Komprehensif, Debugging, & Optimasi Performa
Menjamin aplikasi bebas bug, stabil di berbagai perangkat, dan berjalan mulus 60/120 FPS.

* **13.1 Piramida Pengujian Otomatis (*Automated Testing*)**:
  - **Unit Testing**: Menguji logika bisnis murni, UseCases, Repository, dan Model (`test`, `mocktail`).
  - **Widget Testing**: Menguji interaksi UI, input form, rendering komponen, dan pump frames (`flutter_test`).
  - **Integration Testing**: Menguji skenario end-to-end langsung di emulator/perangkat sungguhan (`integration_test`).
  - **Golden UI Tests**: Menguji kesesuaian pixel tampilan dengan *snapshot rendering*.
* **13.2 Flutter DevTools & Profiling Mendalam**:
  - Memory Profiler: Mendeteksi Memory Leaks dan retensi objek.
  - CPU Profiler & Timeline: Mengidentifikasi bottleneck dan Frame Dropping (UI Jank).
  - Network Inspector: Mengamati lalu lintas HTTP/WS.
  - Widget Inspector: Mengecek layout constraints dan rebuild count.
* **13.3 Teknik Optimasi Performa**:
  - Mencegah rebuild liar: Penggunaan `const` constructor, pemisahan widget kecil, dan selector state.
  - Image Caching (`cached_network_image`), kompresi asset, dan deferred component loading.
* **Deliverable / Mini Project**:
  - *Comprehensive Test Suite (Unit + Widget + Integration)* dengan code coverage > 85% dan Laporan Audit Profiling.

---

### 🔹 FASE 5: DEVOPS, SECURITY & PRODUCTION (Delivery & Monitoring)

#### 📘 Modul 14: Keamanan Aplikasi, Kepatuhan (Compliance), & Crash Reporting
Melindungi data pengguna, memitigasi serangan keamanan, dan memantau kesehatan aplikasi di produksi.

* **14.1 Keamanan & Hardening Aplikasi**:
  - Code Obfuscation & Symbol Stripping (`--obfuscate --split-debug-info`).
  - Menyembunyikan Secrets / API Keys via Compile-Time Environment Variables (`--dart-define-from-file`).
  - Network Security: SSL/TLS Certificate Pinning untuk mencegah serangan *Man-In-The-Middle (MITM)*.
  - Root & Jailbreak Detection (`flutter_jailbreak_detection`).
  - Anti-Screen Capture / Blur overlay saat aplikasi di app switcher (Privasi Fintech).
* **14.2 Crash Reporting & Error Monitoring**:
  - Integrasi **Firebase Crashlytics** & **Sentry**.
  - Menangkap Uncaught Exceptions, Flutter Errors, dan Platform Errors.
  - Menambahkan Custom Logs, Breadcrumbs, dan User Identity Tagging.
* **14.3 Analytics & Telemetry**:
  - Firebase Analytics & PostHog / Mixpanel: Event Tracking, User Funnel, dan Conversion Rate.
* **14.4 Regulasi & Kepatuhan Privasi**:
  - Kepatuhan **UU Perlindungan Data Pribadi (UU PDP Indonesia)** & **GDPR**.
  - Alur Consent pengguna, Kebijakan Privasi, dan fitur wajib *Delete Account*.
* **Deliverable / Mini Project**:
  - *Hardened Secure Banking App Shell* dengan Sentry logging, SSL Pinning, dan Anti-Tampering.

---

#### 📘 Modul 15: CI/CD Otomatis, Fastlane, OTA CodePush, & Rilis Store
Otomatisasi penuh dari kode di git hingga terbit di Google Play Store & Apple App Store.

* **15.1 Persiapan Rilis Native**:
  - Android: Pembuatan Java Keystore (JKS/PKCS12), signing config di `build.gradle`, konfigurasi Android App Bundle (`.aab`).
  - iOS: Apple Developer Program, Certificates, App Identifiers, Provisioning Profiles, dan Export `.ipa`.
  - App Icon otomatis (`flutter_launcher_icons`) & Splash Screen native (`flutter_native_splash`).
* **15.2 Otomatisasi Deployment dengan Fastlane**:
  - Setup Fastlane untuk Android & iOS.
  - Match untuk sinkronisasi sertifikat iOS dalam tim.
  - Distribusi Beta otomatis ke Firebase App Distribution & Apple TestFlight.
* **15.3 Continuous Integration & Delivery (CI/CD)**:
  - Setup **GitHub Actions Pipeline**:
    - Step 1: Linting (`flutter analyze`) & Format check.
    - Step 2: Running Automated Unit & Widget Tests.
    - Step 3: Auto Build Release AAB / IPA.
    - Step 4: Auto Deploy ke Google Play Internal Testing & TestFlight.
* **15.4 Over-The-Air (OTA) Updates dengan Shorebird**:
  - Konsep CodePush untuk Flutter: Memperbaiki bug kritis secara instan tanpa perlu menunggu review App Store / Play Store.
* **15.5 Manajemen Google Play Console & App Store Connect**:
  - Pengisian Data Safety Form, Financial Services Declaration, Content Rating, dan Store Listing (Screenshots, Deskripsi, Video Preview).
* **Deliverable / Mini Project**:
  - *End-to-End Automated CI/CD Pipeline* yang menerbitkan build baru ke Store pada saat git tag di-push.

---

## 🏆 Capstone Project: Enterprise-Grade Fullstack Mobile Application

Siswa merancang, membangun, menguji, dan menerbitkan satu produk aplikasi nyata berskala produksi yang mengintegrasikan seluruh materi Modul 00 – 15.

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
* **Lampiran D: Bluetooth Low Energy (BLE) & Integrasi Thermal Printer**  
  Scan device BLE, koneksi GATT server, dan pengiriman raw ESC/POS byte data ke printer thermal kasir.
* **Lampiran E: On-Device AI & Gemini LLM Integration**  
  Menjalankan model AI lokal ringan di HP dan integrasi Google Gemini API untuk fitur asisten cerdas di dalam Flutter.

---

## ⏱️ Estimasi Waktu & Timeline Belajar

| Fase | Cakupan Modul | Estimasi Jam Belajar | Durasi Rekomendasi |
|---|---|---|---|
| **Fase 0: Tooling & Setup** | Modul 00 | 10 – 15 Jam | Minggu 1 |
| **Fase 1: Foundations & UI** | Modul 01 – 03 | 35 – 45 Jam | Minggu 2 – 4 |
| **Fase 2: State & Data** | Modul 04 – 06 | 45 – 55 Jam | Minggu 5 – 8 |
| **Fase 3: Backend & Hardware**| Modul 07 – 09 | 40 – 50 Jam | Minggu 9 – 11 |
| **Fase 4: Architecture & Polish** | Modul 10 – 13 | 45 – 55 Jam | Minggu 12 – 15 |
| **Fase 5: DevOps & Capstone** | Modul 14 – 15 + Capstone | 50 – 70 Jam | Minggu 16 – 19 |
| **TOTAL** | **16 Modul (00-15) + Capstone + 5 Lampiran** | **~225 – 290 Jam** | **~18 – 20 Minggu** |

---

## 📖 Sumber Daya & Dokumentasi Resmi

- **Flutter Official Documentation**: [docs.flutter.dev](https://docs.flutter.dev)
- **Dart Language Tour & Specifications**: [dart.dev/guides](https://dart.dev/guides)
- **Roadmap.sh Flutter Path**: [roadmap.sh/flutter](https://roadmap.sh/flutter)
- **Material 3 Design Guidelines**: [m3.material.io](https://m3.material.io)
- **Pub.dev Official Package Repository**: [pub.dev](https://pub.dev)
- **Shorebird CodePush**: [shorebird.dev](https://shorebird.dev)
- **Fastlane Mobile Automation**: [docs.fastlane.tools](https://docs.fastlane.tools)

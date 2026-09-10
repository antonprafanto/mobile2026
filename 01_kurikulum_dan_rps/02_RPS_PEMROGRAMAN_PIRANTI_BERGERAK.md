# RENCANA PEMBELAJARAN SEMESTER (RPS)
## PROGRAM STUDI TEKNIK INFORMATIKA

| Aspek | Keterangan |
| :--- | :--- |
| **Mata Kuliah (MK)** | Pemrograman Piranti Bergerak (*Mobile Application Development*) |
| **Kode MK / SKS** | IF3205 / 3 SKS (1 SKS Teori = 50 mnt, 2 SKS Praktikum = 2 x 170 mnt) |
| **Rumpun MK** | Rekayasa Perangkat Lunak & Sistem Terdistribusi |
| **Semester** | V (Ganjil) / VI (Genap) |
| **Prasyarat** | Pemrograman Berorientasi Objek (PBO), Basis Data |
| **Dosen Pengampu** | Tim Dosen Pemrograman Piranti Bergerak |

---

## 1. Deskripsi Singkat Mata Kuliah
Mata kuliah ini membekali mahasiswa dengan kompetensi perancangan, pengembangan, pengujian, dan rilis aplikasi perangkat bergerak (*mobile apps*) modern lintas platform (*cross-platform*) menggunakan kerangka kerja **Flutter** dan bahasa pemrograman **Dart**. Mahasiswa mempelajari prinsip dasar ekosistem piranti bergerak, rekayasa antarmuka adaptif (Material 3), arsitektur perangkat lunak bersih (*Clean Architecture*), manajemen status (*State Management: BLoC/Cubit*), integrasi layanan jaringan *RESTful API*, persistensi data luring (*offline-first*), akses sensor perangkat keras (*hardware integration*), pengamanan data & kunci rahasia (*security & secret management*), serta penerapan pengujian otomatis (*automated testing*) dan *deployment* aplikasi. Metode pembelajaran mengedepankan *Project-Based Learning* (PBL) dan *Collaborative Learning* menggunakan alur kerja standar industri berbasis Git.

---

## 2. Pustaka & Sumber Belajar
### Pustaka Utama:
1. Google LLC. (2026). *Flutter Documentation & Official Guides*. https://docs.flutter.dev/
2. Google LLC. (2026). *Dart Programming Language Specification & Effective Dart*. https://dart.dev/guides
3. Angelov, V. (2023). *Flutter Clean Architecture and BLoC Pattern*. Packt Publishing.
4. Martin, R. C. (2018). *Clean Architecture: A Craftsman's Guide to Software Structure and Design*. Prentice Hall.

### Pustaka Pendukung & Tools:
1. Bloc State Management Library Documentation: https://bloclibrary.dev/
2. GoRouter Declarative Routing Documentation: https://pub.dev/packages/go_router
3. Google ML Kit for Flutter: https://developers.google.com/ml-kit
4. GitHub Classroom & GitHub Actions CI/CD.

---

## 3. Matriks Rencana Pembelajaran 16 Minggu

| Mgg | Sub-CPMK | Bahan Kajian (Materi Pokok) | Bentuk & Metode Pembelajaran | Estimasi Waktu | Pengalaman Belajar Mahasiswa | Kriteria & Bentuk Penilaian | Bobot (%) |
| :---: | :--- | :--- | :--- | :---: | :--- | :--- | :---: |
| **1** | Mampu mengonfigurasi *environment* & memahami arsitektur Flutter | - Pengenalan Ekosistem Mobile<br>- Native vs Hybrid vs Cross-Platform<br>- Flutter Engine, Skia/Impeller, Dart VM<br>- Setup Flutter SDK, VS Code, Android Toolchain | Kuliah Interaktif + Hands-on Lab Setup | TM: 1x50'<br>P: 2x170' | - Menjalankan `flutter doctor`<br>- Konfigurasi USB Debugging & Scrcpy<br>- Eksekusi demo app pada real device | Checklist kesiapan lab & Kuis 1 (Arsitektur Engine) | 2% |
| **2** | Mampu memecahkan masalah logika dengan Dart modern | - Dart Type System, Sound Null Safety<br>- Collections (List, Map, Set) & High-Order Functions<br>- OOP: Class, Mixins, Extension Methods<br>- Async: Future, async/await, Streams | Kuliah Interaktif + Live Coding + Latihan Mandiri | TM: 1x50'<br>P: 2x170' | - Menyelesaikan tantangan logika asynchronous Dart<br>- Membuat simulasi fetching data bertingkat dengan Stream | Rubrik Penilaian Tugas Kode Dart Async | 4% |
| **3** | Mampu menyusun hierarki antarmuka widget Flutter | - "Everything is a Widget"<br>- Widget Tree vs Element Tree vs Render Object<br>- Stateless vs Stateful Widget & Lifecycle<br>- Layout: Container, Row, Column, Stack, Flex | Kuliah Interaktif + Studio Praktikum UI | TM: 1x50'<br>P: 2x170' | - Membedah desain UI Figma ke dalam susunan widget tree<br>- Membangun halaman profil dan dashboard dinamis | Rubrik Penilaian Kelengkapan & Kerapihan UI | 4% |
| **4** | Mampu membuat form interaktif dan navigasi terstruktur | - Input & Form: TextFormField, Controller, Validasi<br>- Gestures & InkWell<br>- Navigasi Deklaratif menggunakan GoRouter<br>- Passing Arguments & Deep Linking dasar | Kuliah Interaktif + Praktikum Terpandu | TM: 1x50'<br>P: 2x170' | - Membangun alur login-register dengan validasi regex<br>- Mengonfigurasi rute bersarang (*nested routes*) dengan GoRouter | Tugas Praktikum 4 (Form & Router) | 4% |
| **5** | Mampu mengimplementasikan Material 3 & UI responsif | - Material Design 3 Specs (Color Roles, Typography)<br>- Theming Dinamis (Light, Dark, System)<br>- Responsive UI: MediaQuery, LayoutBuilder, OrientationBuilder<br>- Reusable Component Kit | Kuliah Interaktif + Review Desain Tim | TM: 1x50'<br>P: 2x170' | - Membangun design system aplikasi kelompok<br>- Menguji UI pada berbagai rasio layar smartphone & tablet | Milestone 1 Proyek (UI Kit & Responsiveness) | 5% |
| **6** | Mampu memecahkan problem state dengan Cubit/BLoC | - The State Problem: Ephemeral vs App State<br>- Keterbatasan setState & Prop Drilling<br>- Konsep Streams & Reactive Programming<br>- Implementasi Cubit: State, Emit, BlocBuilder, BlocListener | Kuliah Interaktif + Live Debugging | TM: 1x50'<br>P: 2x170' | - Refactoring aplikasi counter/cart dari setState ke Cubit<br>- Menggunakan BlocObserver untuk memantau transisi state | Latihan Praktikum State Cubit | 5% |
| **7** | Mampu merancang arsitektur aplikasi (Clean Architecture) | - Prinsip Separation of Concerns (SoC)<br>- Feature-First vs Layer-First<br>- Layer Presentation, Domain (Use Cases), Data (Repositories)<br>- Service Locator / Dependency Injection (GetIt) | Kuliah Interaktif + Case Study Arsitektur | TM: 1x50'<br>P: 2x170' | - Menyusun struktur folder proyek standar industri<br>- Mengisolasi logika bisnis dari dependensi UI | Penilaian Struktur Repositori Tim di GitHub | 6% |
| **8** | **UJIAN TENGAH SEMESTER (UTS)** | **Milestone 1 Sprint Review: UI/UX, Navigation, & Local State Architecture** | Presentasi Kelompok + Live Code Walkthrough | TM: 1x50'<br>P: 2x170' | - Mempresentasikan produk aplikasi (Fase UI + State)<br>- Mempertanggungjawabkan kode dan kontribusi Git individu | Rubrik UTS: UI Quality (40%), Arsitektur (40%), Kolaborasi Git (20%) | 20% |
| **9** | Mampu mengintegrasikan layanan RESTful API | - Protokol HTTP & REST standards<br>- Library Dio: Interceptors, BaseOptions, Error Handling<br>- JSON Serialization otomatis (freezed / json_serializable)<br>- Pattern UI State: Initial, Loading, Success, Failure | Kuliah Interaktif + Praktikum API Client | TM: 1x50'<br>P: 2x170' | - Menghubungkan aplikasi Flutter ke REST API publik / Mock Server<br>- Mengimplementasikan Pull-to-Refresh dan Infinite Scroll pagination | Tugas Praktikum 9 (Networking) | 5% |
| **10** | Mampu menerapkan strategi persistensi data luring (Offline-First) | - Kebutuhan Caching & Akses Luring<br>- Key-Value: SharedPreferences<br>- Embedded NoSQL/SQL: Isar / Drift / Hive<br>- Pola Repository: Cache-then-Network & Sinkronisasi | Kuliah Interaktif + Lab Case Study | TM: 1x50'<br>P: 2x170' | - Membuat fitur bookmark/favorite yang tersimpan permanen<br>- Menangani kondisi transisi online/offline secara transparan | Tugas Praktikum 10 (Local DB) | 5% |
| **11** | Mampu mengintegrasikan Backend-as-a-Service (BaaS) | - Pengantar Cloud BaaS (Firebase & Supabase)<br>- Autentikasi Pengguna (Email/Password, OAuth)<br>- Realtime Cloud Database / Firestore<br>- Cloud Storage untuk upload berkas/gambar | Kuliah Interaktif + Hands-on Cloud Setup | TM: 1x50'<br>P: 2x170' | - Mengonfigurasi Firebase CLI & `flutterfire configure`<br>- Membangun fitur autentikasi terpusat & sinkronisasi data cloud | Tugas Praktikum 11 (BaaS) | 5% |
| **12** | Mampu mengintegrasikan fitur hardware piranti bergerak | - Manajemen Runtime Permissions (OS Android/iOS)<br>- Kamera & Image Picker<br>- Geolocation & Integrasi Peta (Google Maps / OpenStreetMap)<br>- Notifikasi Lokal & Push Notification (FCM) | Kuliah Interaktif + Lab Hardware Integration | TM: 1x50'<br>P: 2x170' | - Mengambil gambar kamera dan mendeteksi koordinat GPS pengguna<br>- Menerima payload push notification saat aplikasi di latar belakang | Tugas Praktikum 12 (Device Features) | 5% |
| **13** | Mampu mengimplementasikan keamanan & fitur cerdas (AI) | - **Security:** Secret Management (.env, flutter_secure_storage), SSL Pinning basics<br>- **AI On-Device:** Google ML Kit (Text Recognition/OCR & Barcode)<br>- Integrasi Generative AI (Gemini API) untuk fitur pintar | Kuliah Interaktif + Studi Kasus Keamanan & AI | TM: 1x50'<br>P: 2x170' | - Mengamankan token autentikasi & API keys dari dekompilasi<br>- Mengimplementasikan fitur scan barcode / asisten cerdas pada aplikasi | Tugas Praktikum 13 (Security & AI) | 4% |
| **14** | Mampu melakukan automated testing & profiling | - Piramida Testing di Flutter<br>- Unit Testing (Testing Cubit/Repositories dengan mocktail)<br>- Widget Testing (Finders, WidgetTester, Pump)<br>- Flutter DevTools: Memory Leaks, Frame Rendering Profiler | Kuliah Interaktif + Hands-on QA Lab | TM: 1x50'<br>P: 2x170' | - Menulis test suite otomatis untuk memverifikasi logika aplikasi<br>- Mengaudit performa UI agar berjalan stabil pada 60 fps | Tugas Praktikum 14 (Automated Tests) | 5% |
| **15** | Mampu melakukan rilis, obfuscation, & CI/CD deployment | - Icon Generator & Native Splash Screen<br>- App Hardening: ProGuard/R8, Code Obfuscation<br>- Keystore Creation, Android App Bundle (.aab) & Release APK<br>- Otomasi CI/CD menggunakan GitHub Actions | Kuliah Interaktif + Workshop Release Prep | TM: 1x50'<br>P: 2x170' | - Membangun bundle produksi yang telah di-sign dan diobfuscate<br>- Mengonfigurasi workflow GitHub Actions untuk auto-build APK | Verifikasi Berkas Rilis & Checklist Deployment | 3% |
| **16** | **UJIAN AKHIR SEMESTER (UAS)** | **"Mobile App Expo / Demo Day" & Live Code Defense** | Pameran Proyek Terbuka + Ujian Lisan Individu | TM: 1x50'<br>P: 2x170' | - Mendemokan aplikasi produk akhir yang berjalan sempurna<br>- Mempertanggungjawabkan kode secara lisan per individu<br>- Publikasi repository, release binary, dan showcase portfolio | Rubrik UAS: Fungsionalitas & Kompleksitas (30%), Arsitektur & Clean Code (30%), Live Defense Individu (25%), Dokumentasi & UI/UX (15%) | 25% |

---

## 4. Evaluasi dan Nilai Akhir Mahasiswa

Rentang nilai akhir mengacu pada peraturan akademik universitas:

$$\text{Nilai Akhir} = (0.25 \times \text{Tugas Lab}) + (0.20 \times \text{UTS}) + (0.25 \times \text{UAS}) + (0.15 \times \text{Kuis/Aktivitas}) + (0.15 \times \text{Peer Review})$$

| Rentang Nilai Angka | Nilai Huruf | Bobot | Kualifikasi Standar |
| :---: | :---: | :---: | :--- |
| $\ge 85.00$ | **A** | 4.00 | Sangat Istimewa (Standar Industri Enterprise) |
| $80.00 - 84.99$ | **A-** | 3.75 | Istimewa |
| $75.00 - 79.99$ | **B+** | 3.25 | Sangat Baik |
| $70.00 - 74.99$ | **B** | 3.00 | Baik (Memenuhi seluruh capaian minimum) |
| $65.00 - 69.99$ | **B-** | 2.75 | Cukup Baik |
| $60.00 - 64.99$ | **C+** | 2.25 | Cukup |
| $55.00 - 59.99$ | **C** | 2.00 | Kurang |
| $40.00 - 54.99$ | **D** | 1.00 | Sangat Kurang |
| $< 40.00$ | **E** | 0.00 | Tidak Lulus |

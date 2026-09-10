# PAKET MASTER PEMROGRAMAN PIRANTI BERGERAK (FLUTTER 2026)
## Kurikulum Berbasis OBE (LAM INFOKOM / IABEE) & Standar Rekayasa Industri

Selamat datang di repositori induk master perkuliahan **Pemrograman Piranti Bergerak (Mobile Application Development)**. Seluruh materi, dokumen silabus resmi, modul laboratorium praktikum, slide presentasi, panduan asisten, instrumen evaluasi, hingga kode boilerplate siap pakai telah terstruktur lengkap di repositori ini.

---

## 🗺️ Peta Direktori & Struktur Repositori

```text
mobile2026_v2/
├── 📁 01_kurikulum_dan_rps/           # Dokumen Regulasi Akademik & Kurikulum OBE
│   ├── 01_PEMETAAN_CPL_CPMK.md         # Pemetaan CPL -> CPMK -> Sub-CPMK standar LAM INFOKOM
│   ├── 02_RPS_PEMROGRAMAN_PIRANTI...  # RPS resmi 16 minggu lengkap
│   ├── 03_KONTRAK_KULIAH_DAN_ETIKA...  # Kontrak kuliah & aturan penggunaan Generative AI
│   └── 04_RUBRIK_PENILAIAN_OBE.md      # Rubrik analitik deskriptif & formula peer-review
│
├── 📁 02_infrastruktur_dan_lab/       # Panduan Teknis & Mitigasi Kendala Hardware
│   ├── 01_PANDUAN_SPESIFIKASI_DAN...   # Spek minimum (RAM 8GB vs 16GB) & setup VS Code
│   ├── 02_SOLUSI_LOW_SPEC_SCRCPY...   # Panduan Real Device USB Debugging & Scrcpy (Ringan)
│   ├── 03_OFFLINE_CACHE_DAN_DISTR...  # Solusi anti-bandwidth choke & skrip PowerShell cache
│   └── 04_SETUP_GITHUB_CLASSROOM...   # Otomasi pengumpulan tugas & GitHub Actions CI
│
├── 📁 03_slide_presentasi/            # Bahan Tayang Kuliah (Format 16:9 Anti-Boring)
│   ├── 00_MASTER_SLIDE_DESIGN_GUI...  # Pedoman desain, warna M3, dan aturan visual 30-40-30
│   ├── DECK_01_TO_05_FONDASI_DAN_UI...# Slide M1 - M5 (Engine, Dart Async, Widgets, M3)
│   ├── DECK_06_TO_08_STATE_DAN_AR...  # Slide M6 - M8 (State Problem, Clean Arch, UTS Prep)
│   ├── DECK_09_TO_12_DATA_DAN_INT...  # Slide M9 - M12 (Dio REST API, Offline DB, BaaS, GPS)
│   └── DECK_13_TO_16_SECURITY_TES...  # Slide M13 - M16 (Security, Testing, Release, UAS)
│
├── 📁 04_modul_praktikum/             # Lembar Kerja Mahasiswa (Jobsheet Lab) & Asprak
│   ├── MODUL_01_SETUP_DAN_DART_AS...  # Praktikum 1: Setup, Scrcpy, & Dart Async Future/Stream
│   ├── MODUL_02_WIDGET_LAYOUT_DAN...  # Praktikum 2: Anti-overflow UI, Form, & GoRouter
│   ├── MODUL_03_STATE_MANAGEMENT_...  # Praktikum 3: Cubit, BlocConsumer, & Wishlist/Cart
│   ├── MODUL_04_REST_API_DIO_DAN_...  # Praktikum 4: Networking Dio & Offline-first Caching
│   ├── MODUL_05_BAAS_FIREBASE_DAN...  # Praktikum 5: Firebase BaaS, Kamera, & Geolocator GPS
│   ├── MODUL_06_SECURITY_TESTING_...  # Praktikum 6: Secret .env, Unit Test, & Release Obfuscation
│   └── PANDUAN_ASISTEN_DAN_KUNCI_...  # SOP Asisten Lab, matriks 5 error populer, & kunci jawaban
│
├── 📁 05_proyek_dan_evaluasi/         # Evaluasi Tengah & Akhir Semester
│   ├── 01_PANDUAN_TUGAS_PROYEK_UTS.md # Spesifikasi teknis & deliverables Sprint 1
│   ├── 02_PANDUAN_TUGAS_PROYEK_UAS.md # Spesifikasi teknis & panduan Mobile App Expo
│   ├── 03_INSTRUMEN_EVALUASI_DAN_...  # Form Live Code Defense & kuesioner anti free-rider
│   └── 04_TEMPLATE_SHOWCASE_PORTF...  # Template README.md profesional portofolio mahasiswa
│
├── 📁 06_starter_boilerplate/         # Repositori Contoh Siap Pakai (Production-Grade)
│   ├── lib/                            # Feature-First Clean Architecture code
│   ├── pubspec.yaml                    # Dependensi standar industri
│   ├── analysis_options.yaml           # Aturan linter ketat
│   ├── .env.example                    # Secret management template
│   └── README.md                       # Petunjuk cloning & kontribusi
│
└── 📁 07_contoh_kode_program/         # Repositori Kode Lengkap Siap Run (Per Slide & Full Apps)
    └── 📁 pertemuan_04_form_dan_gorouter/
        ├── 📄 slide_03_textfield_vs_textformfield.dart
        ├── 📄 slide_04_controller_lifecycle.dart
        ├── 📄 ... (17 Berkas Standalone Per-Slide)
        ├── 📄 slide_19_lab_quest_portal_ktm.dart
        ├── 📄 01_form_registrasi_lengkap.dart
        ├── 📄 02_gorouter_navigasi_dan_passing_data.dart
        ├── 📄 03_gorouter_bottom_nav_shell.dart
        └── 📄 04_lab_quest_04_solusi_portal_ktm.dart
```

---

## 🚀 Akses Cepat Materi Kuliah untuk Mahasiswa

| Topik Perkuliahan | Slide Presentasi (.pptx) | Modul Praktikum / Jobsheet | Contoh Kode Program Siap Run |
| :--- | :---: | :---: | :---: |
| **Pertemuan 01:** Fondasi & Ekosistem Flutter | [Lihat Slide M01](03_slide_presentasi/PERTEMUAN_01_Pengantar_Flutter_dan_Ekosistem.pptx) | [Modul 01](04_modul_praktikum/MODUL_01_SETUP_DAN_DART_ASYNC.md) | - |
| **Pertemuan 02:** Modern Dart (Null Safety & Async) | [Lihat Slide M02](03_slide_presentasi/PERTEMUAN_02_Modern_Dart_Programming.pptx) | [Modul 01](04_modul_praktikum/MODUL_01_SETUP_DAN_DART_ASYNC.md) | - |
| **Pertemuan 03:** Everything is a Widget (Layout) | [Lihat Slide M03](03_slide_presentasi/PERTEMUAN_03_Widget_Tree_dan_Layouting.pptx) | [Modul 02](04_modul_praktikum/MODUL_02_WIDGET_LAYOUT_DAN_NAVIGATION.md) | - |
| **Pertemuan 04:** Form Handling & GoRouter | [Lihat Slide M04](03_slide_presentasi/PERTEMUAN_04_Form_Handling_dan_GoRouter.pptx) | [Modul 02](04_modul_praktikum/MODUL_02_WIDGET_LAYOUT_DAN_NAVIGATION.md) | [17 Kode Standalone & 4 Aplikasi](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/) |
| **Pertemuan 06:** State Management (Cubit & BLoC) | [Lihat Slide M06](03_slide_presentasi/PERTEMUAN_06_State_Management_Cubit_dan_BLoC.pptx) | [Modul 03](04_modul_praktikum/MODUL_03_STATE_MANAGEMENT_CUBIT.md) | - |
| **Pertemuan 09:** Networking & REST API (Dio) | [Lihat Slide M09](03_slide_presentasi/PERTEMUAN_09_Networking_REST_API_dan_Dio.pptx) | [Modul 04](04_modul_praktikum/MODUL_04_REST_API_DIO_DAN_OFFLINE_STORAGE.md) | - |
| **Pertemuan 11:** BaaS Firebase, Kamera & GPS | [Lihat Slide M11](03_slide_presentasi/PERTEMUAN_11_Backend_as_a_Service_Firebase.pptx) | [Modul 05](04_modul_praktikum/MODUL_05_BAAS_FIREBASE_DAN_HARDWARE.md) | - |
| **Pertemuan 14:** Automated Testing & Profiling | [Lihat Slide M14](03_slide_presentasi/PERTEMUAN_14_Automated_Testing_dan_Profiling.pptx) | [Modul 06](04_modul_praktikum/MODUL_06_SECURITY_TESTING_RELEASE.md) | - |

---

## 🎯 Sorotan Utama Keunggulan Kurikulum Ini

1. **Pedagogi Anti-Bingung (1 Slide = 1 Berkas Standalone):** Mahasiswa yang sedang mempelajari konsep tertentu di slide (misalnya Slide 06: *Toggle Intip Sandi*) dapat langsung membuka tautan berkas mandiri `slide_06_password_toggle_demo.dart` di GitHub yang sudah dilengkapi `void main()`, `MaterialApp`, dan `Scaffold` siap di-run langsung di browser Chrome atau HP fisik!
2. **Anti-Free-Rider Protocol:** Dilengkapi instrumen evaluasi sejawat (*Peer Review*) rahasia dengan faktor pengali nilai, audit *Pull Request* GitHub, serta ujian lisan individu (*Live Code Defense*) di mana mahasiswa wajib memodifikasi kode di depan penguji dalam 5 menit.
3. **Mitigasi PC Lab Spek Terbatas (RAM 8 GB):** Mengeliminasi kebutuhan Android Emulator yang boros memori dengan mengombinasikan **VS Code + Real Device + Scrcpy** (konsumsi RAM PC hanya $\approx 70\text{ MB}$) atau kompilasi kilat **Flutter Web Chrome** (~5 detik).
4. **Mitigasi Bandwidth Kampus:** Tersedia strategi *Pre-Warmed Gradle & Pub Offline Cache* dengan skrip PowerShell otomatis agar mahasiswa tidak perlu mengunduh puluhan GB data secara serentak di lab.
5. **Kesiapan Industri 2026:** Mahasiswa langsung diajarkan arsitektur modular (*Feature-First*), manajemen rahasia (`.env`), *automated unit/widget testing*, *offline-first caching*, dan fitur cerdas berbasis AI/ML Kit.

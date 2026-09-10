# 📱 BAHAN KULIAH PEMROGRAMAN PIRANTI BERGERAK (FLUTTER 2026)
Selamat datang di repositori resmi materi perkuliahan **Pemrograman Piranti Bergerak (Mobile Application Development)**. Repositori ini didedikasikan bagi mahasiswa untuk mengakses **Slide Presentasi Perkuliahan (.pptx)** dan **Contoh Kode Program Mandiri** yang siap dijalankan langsung di VS Code, browser Chrome, maupun smartphone fisik.

---

## 🗺️ Struktur Repositori

```text
mobile2026/
├── 📁 03_slide_presentasi/            # Berkas Slide Presentasi (.pptx) & Panduan
│   ├── 📊 PERTEMUAN_01_Pengantar_Flutter_dan_Ekosistem.pptx
│   ├── 📊 PERTEMUAN_02_Modern_Dart_Programming.pptx
│   ├── 📊 PERTEMUAN_03_Widget_Tree_dan_Layouting.pptx
│   ├── 📊 PERTEMUAN_04_Form_Handling_dan_GoRouter.pptx
│   ├── 📊 PERTEMUAN_06_State_Management_Cubit_dan_BLoC.pptx
│   ├── 📊 PERTEMUAN_09_Networking_REST_API_dan_Dio.pptx
│   ├── 📊 PERTEMUAN_11_Backend_as_a_Service_Firebase.pptx
│   └── 📊 PERTEMUAN_14_Automated_Testing_dan_Profiling.pptx
│
└── 📁 07_contoh_kode_program/         # Kode Program Lengkap Siap Run (1 Slide = 1 File)
    └── 📁 pertemuan_04_form_dan_gorouter/
        ├── 📄 slide_03_textfield_vs_textformfield.dart
        ├── 📄 slide_04_controller_lifecycle.dart
        ├── 📄 slide_05_input_decoration_ux.dart
        ├── 📄 slide_06_password_toggle_demo.dart
        ├── 📄 slide_07_keyboard_focus_control.dart
        ├── 📄 slide_08_dropdown_form_field.dart
        ├── 📄 slide_09_form_architecture.dart
        ├── 📄 slide_10_validator_regex.dart
        ├── 📄 slide_11_snackbar_feedback.dart
        ├── 📄 slide_12_inkwell_gestures.dart
        ├── 📄 slide_13_why_gorouter.dart
        ├── 📄 slide_14_app_router_config.dart
        ├── 📄 slide_15_navigation_actions.dart
        ├── 📄 slide_16_path_parameters.dart
        ├── 📄 slide_17_query_and_extra.dart
        ├── 📄 slide_18_nested_and_shell_routes.dart
        ├── 📄 slide_19_lab_quest_portal_ktm.dart
        ├── 📄 01_form_registrasi_lengkap.dart
        ├── 📄 02_gorouter_navigasi_dan_passing_data.dart
        ├── 📄 03_gorouter_bottom_nav_shell.dart
        └── 📄 04_lab_quest_04_solusi_portal_ktm.dart
```

---

## 📊 Daftar Slide Presentasi Kuliah (.pptx)

| Pertemuan | Topik Materi | Unduh / Buka Slide PPTX |
| :---: | :--- | :---: |
| **01** | Pengantar Mobile, Ekosistem Flutter & Impeller Engine | [📥 Buka Slide M01](03_slide_presentasi/PERTEMUAN_01_Pengantar_Flutter_dan_Ekosistem.pptx) |
| **02** | Modern Dart Programming (Null Safety & Concurrency) | [📥 Buka Slide M02](03_slide_presentasi/PERTEMUAN_02_Modern_Dart_Programming.pptx) |
| **03** | Everything is a Widget (Widget Tree & Layout Anti-Overflow) | [📥 Buka Slide M03](03_slide_presentasi/PERTEMUAN_03_Widget_Tree_dan_Layouting.pptx) |
| **04** | Form Handling, Validasi Masukan & Navigasi GoRouter | [📥 Buka Slide M04](03_slide_presentasi/PERTEMUAN_04_Form_Handling_dan_GoRouter.pptx) |
| **06** | State Management Reaktif (Cubit & BLoC Pattern) | [📥 Buka Slide M06](03_slide_presentasi/PERTEMUAN_06_State_Management_Cubit_dan_BLoC.pptx) |
| **09** | Networking, REST API Client Dio & Error Handling | [📥 Buka Slide M09](03_slide_presentasi/PERTEMUAN_09_Networking_REST_API_dan_Dio.pptx) |
| **11** | Backend-as-a-Service Firebase, Kamera & Geolocation GPS | [📥 Buka Slide M11](03_slide_presentasi/PERTEMUAN_11_Backend_as_a_Service_Firebase.pptx) |
| **14** | Automated Unit/Widget Testing & DevTools Profiling | [📥 Buka Slide M14](03_slide_presentasi/PERTEMUAN_14_Automated_Testing_dan_Profiling.pptx) |

---

## 🚀 Katalog Contoh Kode Mandiri Per-Slide (Siap Run)

Setiap berkas di bawah ini adalah **1-file aplikasi Flutter utuh** (`void main()`, `MaterialApp`, & `Scaffold`). Mahasiswa cukup menyalin isinya ke berkas `lib/main.dart` pada proyek Flutter lokal untuk langsung mencobanya!

| Slide | Konsep Materi yang Dibahas | Tautan Berkas Kode di GitHub |
| :---: | :--- | :--- |
| **Slide 03** | `TextField` vs `TextFormField` | [slide_03_textfield_vs_textformfield.dart](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/slide_03_textfield_vs_textformfield.dart) |
| **Slide 04** | `TextEditingController` & `dispose()` | [slide_04_controller_lifecycle.dart](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/slide_04_controller_lifecycle.dart) |
| **Slide 05** | `InputDecoration`, Hint & Tipe Keyboard HP | [slide_05_input_decoration_ux.dart](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/slide_05_input_decoration_ux.dart) |
| **Slide 06** | Toggle Intip Password Nyata (`_isObscure`) | [slide_06_password_toggle_demo.dart](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/slide_06_password_toggle_demo.dart) |
| **Slide 07** | Menutup Keyboard HP (`FocusScope.unfocus`) | [slide_07_keyboard_focus_control.dart](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/slide_07_keyboard_focus_control.dart) |
| **Slide 08** | Input Pilihan `DropdownButtonFormField` | [slide_08_dropdown_form_field.dart](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/slide_08_dropdown_form_field.dart) |
| **Slide 09** | Arsitektur Form & `GlobalKey<FormState>` | [slide_09_form_architecture.dart](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/slide_09_form_architecture.dart) |
| **Slide 10** | Logika Validator & Regex Email Kampus | [slide_10_validator_regex.dart](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/slide_10_validator_regex.dart) |
| **Slide 11** | Floating `SnackBar` & `ScaffoldMessenger` | [slide_11_snackbar_feedback.dart](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/slide_11_snackbar_feedback.dart) |
| **Slide 12** | `GestureDetector` vs `InkWell` Riak Air | [slide_12_inkwell_gestures.dart](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/slide_12_inkwell_gestures.dart) |
| **Slide 13** | Mengapa GoRouter? (Deklaratif vs Imperatif) | [slide_13_why_gorouter.dart](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/slide_13_why_gorouter.dart) |
| **Slide 14** | Konfigurasi GoRouter & Halaman Error 404 | [slide_14_app_router_config.dart](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/slide_14_app_router_config.dart) |
| **Slide 15** | Pindah Rute: `.go()` vs `.push()` vs `.pop()` | [slide_15_navigation_actions.dart](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/slide_15_navigation_actions.dart) |
| **Slide 16** | Kirim Data 1: Path Parameters (`/buku/:id`) | [slide_16_path_parameters.dart](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/slide_16_path_parameters.dart) |
| **Slide 17** | Kirim Data 2: Query (`?q=`) & Objek `extra` | [slide_17_query_and_extra.dart](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/slide_17_query_and_extra.dart) |
| **Slide 18** | Rute Bersarang & `StatefulShellRoute` Tab | [slide_18_nested_and_shell_routes.dart](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/slide_18_nested_and_shell_routes.dart) |
| **Slide 19** | Solusi Master Lab Quest: Portal KTM Digital | [slide_19_lab_quest_portal_ktm.dart](07_contoh_kode_program/pertemuan_04_form_dan_gorouter/slide_19_lab_quest_portal_ktm.dart) |

---

## 💡 Panduan Cepat Menjalankan Kode bagi Mahasiswa Awam

1. **Buka Terminal di VS Code:**
   Tekan kombinasi tombol `Ctrl + ~` (Control + Backtick).
2. **Pasang Paket Navigasi Resmi:**
   ```bash
   flutter pub add go_router
   ```
3. **Salin Kode Contoh:**
   Pilih salah satu berkas di atas, klik tombol **"Copy raw file"** di GitHub, lalu tempelkan (*paste*) seluruhnya menggantikan isi `lib/main.dart` pada proyek Anda.
4. **Jalankan Aplikasi:**
   - **Paling Ringan & Instan (Rekomendasi Lab):**
     ```bash
     flutter run -d chrome
     ```
   - **Smartphone Fisik Asli:**
     Hubungkan kabel data USB, buka aplikasi `scrcpy`, lalu ketik:
     ```bash
     flutter run
     ```


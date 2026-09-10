# 📋 PANDUAN KODE PROGRAM MANDIRI (PERTEMUAN 04)
## Form Handling, Input Validation, & Navigasi Deklaratif GoRouter

Selamat datang di katalog kode program resmi **Pertemuan 04: Form Handling & GoRouter**. Folder ini berisi **18 berkas aplikasi per-slide mandiri** ditambah **4 aplikasi master komprehensif** yang mendemonstrasikan siklus hidup controller, validasi regex terpusat, hingga arsitektur navigasi URL multi-platform.

---

## 📁 Katalog 18 Berkas Kode Per-Slide Siap Run

Setiap berkas di bawah ini adalah **1 berkas aplikasi Flutter utuh** (`void main()`, `MaterialApp`, dan `Scaffold`). Cukup salin isinya ke berkas `lib/main.dart` di proyek Flutter lokal Anda untuk langsung menjalankannya!

| Nama Berkas | Topik Slide | Penjelasan Konsep & Manfaat |
| :--- | :---: | :--- |
| **`slide_02_persiapan_tools_dan_gorouter.dart`** | Slide 02 | Instalasi pustaka `go_router` via terminal dan konfigurasi rute dasar. |
| **`slide_03_textfield_vs_textformfield.dart`** | Slide 03 | Komparasi `TextField` (input bebas) vs `TextFormField` (input tervalidasi). |
| **`slide_04_controller_lifecycle.dart`** | Slide 04 | Siklus hidup `TextEditingController` dan kewajiban `dispose()` pencegah memory leak. |
| **`slide_05_input_decoration_ux.dart`** | Slide 05 | Desain pengalaman input: `labelText`, `hintText`, `prefixIcon`, dan pemilihan `keyboardType`. |
| **`slide_06_password_toggle_demo.dart`** | Slide 06 | Fitur interaktif intip kata sandi (*Password Visibility Toggle*) via boolean `_isObscure`. |
| **`slide_07_keyboard_focus_control.dart`** | Slide 07 | Mengatur fokus input: menutup keyboard via `unfocus()` dan navigasi `TextInputAction.next`. |
| **`slide_08_dropdown_form_field.dart`** | Slide 08 | Input pilihan terintegrasi formulir: `DropdownButtonFormField` dengan validator. |
| **`slide_09_form_architecture.dart`** | Slide 09 | Arsitektur widget `Form` terpusat dan validasi serentak via `GlobalKey<FormState>`. |
| **`slide_10_validator_regex.dart`** | Slide 10 | Aturan validasi: nilai kembalian `null` vs string galat, sanitasi `.trim()`, dan regex email kampus. |
| **`slide_11_snackbar_feedback.dart`** | Slide 11 | Umpan balik pengguna: bilah notifikasi mengambang `ScaffoldMessenger` & `SnackBar`. |
| **`slide_12_inkwell_gestures.dart`** | Slide 12 | Interaksi sentuh: perbandingan `GestureDetector` polos vs efek riak air `InkWell`. |
| **`slide_13_why_gorouter.dart`** | Slide 13 | Mengapa beralih ke GoRouter: perbandingan navigasi imperatif vs deklaratif berbasis URL. |
| **`slide_14_app_router_config.dart`** | Slide 14 | Konfigurasi utama `GoRouter`: `initialLocation`, daftar `routes`, dan halaman penyelamat 404. |
| **`slide_15_navigation_actions.dart`** | Slide 15 | Metode perpindahan rute: kapan memakai `context.go()`, `context.push()`, dan `context.pop()`. |
| **`slide_16_path_parameters.dart`** | Slide 16 | Mengirim ID entitas spesifik melalui URL (*Path Parameters*: `/buku/:id`). |
| **`slide_17_query_and_extra.dart`** | Slide 17 | Filter pencarian (*Query Parameters*: `?keyword=`) dan transfer objek data utuh via `extra`. |
| **`slide_18_nested_and_shell_routes.dart`** | Slide 18 | Rute bersarang (*Sub-Routes*) dan navigasi tab bawah via `StatefulShellRoute.indexedStack`. |
| **`slide_19_lab_quest_portal_ktm.dart`** | Slide 19 | **Solusi Master Lab Quest 04**: Portal registrasi mahasiswa terintegrasi kartu KTM digital. |

---

## 🌟 Aplikasi Komprehensif Tambahan (Master Demos)

Selain 18 berkas per-slide di atas, folder ini menyediakan 4 berkas demonstrasi skala penuh:

1. **`01_form_registrasi_lengkap.dart`**: Formulir registrasi mahasiswa terintegrasi regex, dropdown, dan feedback visual.
2. **`02_gorouter_navigasi_dan_passing_data.dart`**: Navigasi multi-halaman katalog buku dengan parameter dan penanganan 404.
3. **`03_gorouter_bottom_nav_shell.dart`**: Tab navigasi bawah persisten (*IndexedStack*) anti-reset scroll.
4. **`04_lab_quest_04_solusi_portal_ktm.dart`**: Solusi tugas terpadu dari pengisian form hingga penerbitan kartu digital.

---

## ⚡ Langkah Cepat Menjalankan Kode bagi Mahasiswa

```bash
flutter create praktikum_p4
cd praktikum_p4
flutter pub add go_router
flutter run -d chrome
```

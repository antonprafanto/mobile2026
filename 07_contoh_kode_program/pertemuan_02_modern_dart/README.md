# 🎯 PANDUAN KODE PROGRAM MANDIRI (PERTEMUAN 02)
## Modern Dart Programming: Logika, Sound Null Safety, & Asinkron

Selamat datang di katalog kode program resmi **Pertemuan 02: Modern Dart Programming**. Folder ini berisi **15 berkas kode Dart mandiri (*runnable code*)** yang mencakup sistem tipe data kuat (*strong typing*), operator penjinak null, rekayasa OOP konstruktor, hingga manipulasi data asinkron (*Future* & *Stream*).

---

## 📁 Katalog 15 Berkas Kode Siap Run (Per-Slide)

Berkas kode pada folder ini dapat langsung dijalankan di terminal menggunakan perintah `dart run <nama_berkas>.dart` atau disalin ke situs **dartpad.dev**!

| Nama Berkas | Topik Slide | Penjelasan Konsep & Manfaat |
| :--- | :---: | :--- |
| **`slide_02_tools_dan_environment.dart`** | Slide 02 | Panduan eksekusi cepat menggunakan DartPad online dan terminal Dart SDK lokal. |
| **`slide_03_mindset_dart_logika.dart`** | Slide 03 | Mindset pemrograman modern: pemisahan logika murni (*Pure Logic*) dari UI antarmuka. |
| **`slide_04_variabel_dan_tipe_data.dart`** | Slide 04 | Deklarasi variabel: `var`, `final`, `const`, penentuan tipe data statis, dan type inference. |
| **`slide_05_sound_null_safety.dart`** | Slide 05 | Filosofi Sound Null Safety: sistem penjamin anti *NullPointerException* sejak masa kompilasi. |
| **`slide_06_operator_penjinak_null.dart`** | Slide 06 | Empat operator pengaman null: `?` (nullable), `??` (default fallback), `?.` (safe navigation), dan `!` (assertion). |
| **`slide_07_fat_arrow_functions.dart`** | Slide 07 | Sintaks ekspresi ringkas *Fat Arrow* (`=>`), parameter opsional, dan fungsi tingkat pertama (*First-Class Functions*). |
| **`slide_08_oop_named_parameters.dart`** | Slide 08 | Rekayasa kelas modern: Named Parameters (`{required this.field}`), encapsulation, dan imutabilitas. |
| **`slide_09_mixins_with_keyword.dart`** | Slide 09 | Komposisi modular menggunakan keyword `mixin` dan `with` untuk penggunaan ulang kode tanpa pewarisan berganda. |
| **`slide_10_extension_methods.dart`** | Slide 10 | Menambahkan fungsi kustom ke tipe data bawaan (`String`, `DateTime`) tanpa memodifikasi kelas aslinya. |
| **`slide_11_collections_list_map_set.dart`** | Slide 11 | Struktur data koleksi dasar: `List` (berurutan), `Map` (pasangan key-value), dan `Set` (elemen unik). |
| **`slide_12_reactive_collections.dart`** | Slide 12 | Manipulasi data fungsional deklaratif: `.map()`, `.where()`, `.reduce()`, Spread Operator (`...`), dan Collection-If. |
| **`slide_13_dilema_sync_vs_async.dart`** | Slide 13 | Mengapa komputasi mobile wajib asinkron: mencegah antarmuka grafis *freeze* / macet (*Event Loop & Microtask*). |
| **`slide_14_future_async_await.dart`** | Slide 14 | Operasi satu kali selesai di masa depan (*One-time Future*): menangani latensi HTTP API dengan `async` & `await`. |
| **`slide_15_stream_reactive_data.dart`** | Slide 15 | Aliran data berkelanjutan (*Continuous Stream*): simulasi sensor GPS, WebSockets, dan data reaktif `StreamController`. |
| **`slide_16_lab_quest_tugas_02.dart`** | Slide 16 | **Solusi Master Lab Quest 02**: Simulasi sistem antrean cerdas kafe kampus dengan pemrosesan order asinkron & Stream. |

---

## ⚡ Langkah Cepat Menjalankan Kode bagi Mahasiswa

### Opsi A: Melalui Terminal Lokal (Paling Cepat)
Cukup jalankan berkas langsung via Dart CLI:
```bash
dart run slide_06_operator_penjinak_null.dart
```

### Opsi B: Melalui Browser di DartPad (Tanpa Instalasi)
1. Buka browser dan kunjungi [dartpad.dev](https://dartpad.dev).
2. Salin isi berkas (misal: `slide_16_lab_quest_tugas_02.dart`).
3. Tempelkan ke editor DartPad, lalu tekan tombol **Run**.

# 🎨 PANDUAN KODE PROGRAM MANDIRI (PERTEMUAN 03)
## Everything is a Widget: Layouting & Penanganan Overflow

Selamat datang di katalog kode program resmi **Pertemuan 03: Widget Tree & Layouting**. Folder ini berisi **23 berkas aplikasi Flutter mandiri (*fully runnable code*)** yang mendemonstrasikan hierarki widget, tata letak *Single-Child* & *Multi-Child*, hukum *Box Constraints*, hingga jurus mengatasi galat *Overflow*.

---

## 📁 Katalog 23 Berkas Kode Siap Run (Per-Slide)

Setiap berkas di bawah ini adalah **1 berkas aplikasi Flutter utuh** (`void main()`, `MaterialApp`, dan `Scaffold`). Cukup salin isinya ke berkas `lib/main.dart` di proyek Flutter lokal Anda untuk langsung menjalankannya!

| Nama Berkas | Topik Slide | Penjelasan Konsep & Manfaat |
| :--- | :---: | :--- |
| **`slide_02_panduan_tools_dan_workflow.dart`** | Slide 02 | Lingkungan pengujian tata letak: Chrome, Flutter Inspector, dan Toggle Widget Mode. |
| **`slide_03_filosofi_everything_is_widget.dart`** | Slide 03 | Filosofi deklaratif Flutter: antarmuka dibangun dari komposisi hierarki widget pohon (*Widget Tree*). |
| **`slide_04_materialapp_dan_scaffold.dart`** | Slide 04 | Fondasi kanvas: peran `MaterialApp` sebagai pembungkus tema dan `Scaffold` sebagai struktur layout standar. |
| **`slide_05_arsitektur_the_three_trees.dart`** | Slide 05 | Arsitektur 3 Pohon Flutter: *Widget Tree* (konfigurasi), *Element Tree* (manajer), dan *RenderObject Tree* (piksel). |
| **`slide_06_stateless_vs_stateful.dart`** | Slide 06 | Komparasi `StatelessWidget` (tampilan statis) vs `StatefulWidget` (tampilan dinamis reaktif). |
| **`slide_07_siklus_hidup_stateful.dart`** | Slide 07 | Tiga fase siklus hidup `State`: inisialisasi (`initState`), perenderan (`build`), dan pembersihan (`dispose`). |
| **`slide_08_hukum_box_constraints.dart`** | Slide 08 | Hukum emas tata letak: *"Constraints Go Down, Sizes Go Up, Parent Sets Position"*. |
| **`slide_09_penyelamat_layar_safearea.dart`** | Slide 09 | Adaptasi hardware: widget `SafeArea` pelindung konten dari poni (*notch*) dan bilah navigasi HP. |
| **`slide_10_single_child_layout.dart`** | Slide 10 | Tata letak anak tunggal: perbandingan peran `Container`, `Padding`, dan `Center`. |
| **`slide_11_jebakan_color_vs_decoration.dart`** | Slide 11 | Penjelasan dan solusi galat kompilasi: *"Cannot provide both a color and a decoration"*. |
| **`slide_12_multi_child_row_column.dart`** | Slide 12 | Penataan multi-anak: `Row` (sumbu horizontal) dan `Column` (sumbu vertikal) beserta `mainAxisAlignment`. |
| **`slide_13_trik_spasi_sizedbox_spacer.dart`** | Slide 13 | Tiga teknik memberi jarak antarelemen: `SizedBox`, `Spacer`, dan `Padding`. |
| **`slide_14_flexible_vs_expanded.dart`** | Slide 14 | Mengatur pembagian ruang dinamis: `Expanded` (ruang ketat) vs `Flexible` (ruang longgar proporsional). |
| **`slide_15_layout_menumpuk_stack.dart`** | Slide 15 | Penataan bertumpuk ala lapisan grafik menggunakan kombinasi `Stack` dan `Positioned`. |
| **`slide_16_penyelamat_kategori_wrap.dart`** | Slide 16 | Pemecah baris otomatis: widget `Wrap` untuk menampilkan daftar chip tag dan kategori dinamis. |
| **`slide_17_scrollable_singlechildscrollview.dart`** | Slide 17 | Membuat tata letak halaman formulir dapat digulir dan bebas overflow menggunakan `SingleChildScrollView`. |
| **`slide_18_scrollable_listview_builder.dart`** | Slide 18 | Efisiensi memori tingkat tinggi: merender 10.000 data menggunakan mekanisme on-demand `ListView.builder`. |
| **`slide_19_scrollable_gridview_builder.dart`** | Slide 19 | Katalog kisi responsif multi-kolom menggunakan `GridView.builder` dan `SliverGridDelegate`. |
| **`slide_20_solusi_renderflex_overflow.dart`** | Slide 20 | Analisis dan solusi tuntas pembasmian garis kuning-hitam (*RenderFlex Overflow Error*). |
| **`slide_21_solusi_unbounded_height.dart`** | Slide 21 | Penanganan galat klasik: *"Vertical viewport was given unbounded height"* pada ListView di dalam Column. |
| **`slide_22_trik_koma_ajaib_trailing.dart`** | Slide 22 | Standar format kode industri: teknik tanda koma penutup (*Trailing Comma*) untuk auto-formatting rapi. |
| **`slide_23_shortcut_refactor_inspector.dart`** | Slide 23 | Pintasan efisiensi pemrograman: kombinasi `Alt + Enter` dan Flutter DevTools Widget Inspector. |
| **`slide_24_lab_quest_dashboard_profil.dart`** | Slide 24 | **Solusi Master Lab Quest 03**: Dashboard Kartu Tanda Mahasiswa (KTM) digital & grid menu kampus bergaya modern. |

---

## ⚡ Langkah Cepat Menjalankan Kode bagi Mahasiswa

1. Buka proyek Flutter Anda di VS Code.
2. Buka berkas `lib/main.dart`, lalu tempelkan salah satu berkas di atas (contoh: `slide_24_lab_quest_dashboard_profil.dart`).
3. Jalankan aplikasi via terminal:
   ```bash
   flutter run -d chrome
   ```

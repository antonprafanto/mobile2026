# 📘 KERANGKA KERJA COURSEWARE BERBASIS GITHUB
## *The Zero-Friction Courseware Framework: Pedoman Pengembangan Materi Perkuliahan Pemrograman Bebas Hambatan Kognitif*

> **Dokumen Panduan Standar Dosen & Pengembang Kurikulum**  
> Disusun berdasarkan evaluasi empiris perkuliahan pemrograman dan praktikum laboratorium komputer. Panduan ini dirancang **universal dan agnostik**, sehingga dapat diterapkan pada mata kuliah apa pun: Pemrograman Mobile, Pemrograman Web, PBO (Java/C++), Python Data Science, Backend API, maupun Basis Data.

---

## 1. Latar Belakang & Filosofi Inti

### 1.1 Masalah Klasik Pembelajaran Pemrograman di Kampus
Dalam perkuliahan pemrograman konvensional, mahasiswa pemula (*novice programmers*) sering kali mengalami **kegagalan kognitif (*cognitive overload*)** bukan karena sulitnya logika algoritma, melainkan akibat hambatan teknis non-esensial (*accidental complexity*):
1. **Kebingungan Lokasi Kode (*Lost in Codebase*):** Dosen memberikan satu proyek besar (*monolithic repo*) berisi ratusan berkas. Saat slide membahas satu konsep kecil (misal: validasi formulir), mahasiswa tidak tahu potongan kode tersebut terletak di berkas dan baris yang mana.
2. **Distraksi Desain Visual (*Styling Overhead*):** Contoh kode dipenuhi styling dekoratif yang rumit (bayangan, border tebal, manipulasi warna hex, CSS bertingkat). Mahasiswa pemula kesulitan membedakan mana logika inti bahasa dan mana yang sekadar dekorasi visual.
3. **Kendala Spesifikasi Komputer Lab (*Hardware Choke*):** Komputer laboratorium kampus atau laptop mahasiswa umumnya memiliki RAM terbatas (8GB). Membuka IDE berat, browser, dan emulator sekaligus membuat perangkat macet (*hang*).
4. **Slide Pasif Tanpa Interaktivitas:** Slide PDF/PPTX berdiri sendiri tanpa tautan langsung ke kode sumber yang siap dijalankan, memaksa mahasiswa mengetik ulang secara manual dari gambar yang rentan salah ketik (*typo*).

### 1.2 Filosofi: *The Zero-Friction Courseware*
Kerangka kerja ini memangkas seluruh hambatan di atas dengan prinsip:
> **"Dari Slide ke Running Code dalam Kurang dari 5 Detik, Tanpa Distraksi Desain, dan Ramah Komputer RAM 8GB."**

---

## 2. Enam Pilar Utama Kerangka Kerja

```
                      THE ZERO-FRICTION COURSEWARE
 ┌───────────────────────────────────┬───────────────────────────────────┐
 │ 1. Student-Facing Hub             │ 2. One-Slide, One-Runnable-File   │
 │    Repositori Git bersih & fokus  │    1 konsep slide = 1 file utuh   │
 ├───────────────────────────────────┼───────────────────────────────────┤
 │ 3. Anti-Design Overhead           │ 4. Two-Way Hyperlink Integration  │
 │    Bebas styling dekoratif rumit  │    Slide PPTX ⇄ Repositori GitHub │
 ├───────────────────────────────────┼───────────────────────────────────┤
 │ 5. Zero-Warning Quality Gate      │ 6. Low-Spec & Zero-Barrier Lab    │
 │    Linter ketat, 0 issue analyze  │    Web preview & no emulator lag  │
 └───────────────────────────────────┴───────────────────────────────────┘
```

---

### PILAR 1: Repositori *Student-Facing Hub* (Sederhana & Terfokus)

Repositori publik mahasiswa tidak boleh dicampuradukkan dengan arsip administrasi dosen, kunci jawaban tugas, atau instrumen asesmen rahasia.

**Struktur Direktori Repositori Publik:**
```text
nama_matakuliah_2026/
├── 📁 03_slide_presentasi/            # Berkas asli bahan tayang kuliah (.pptx / .pdf)
│   ├── 📊 PERTEMUAN_01_Pengantar.pptx
│   ├── 📊 PERTEMUAN_02_Dasar_Bahasa.pptx
│   └── ...
│
├── 📁 07_contoh_kode_program/         # Koleksi berkas kode mandiri siap salin
│   ├── 📁 pertemuan_01_pengantar/
│   │   ├── 📄 slide_02_arsitektur.dart
│   │   ├── 📄 slide_03_hello_world.dart
│   │   └── ...
│   ├── 📁 pertemuan_02_dasar_bahasa/
│   └── ...
│
└── 📄 README.md                      # Portal navigasi perkuliahan (Pintu Masuk Utama)
```

**Fungsi `README.md` sebagai Portal Digital:**
* Menampilkan ringkasan mata kuliah dan petunjuk memulai (*quick-start*).
* Menyediakan tabel katalog pertemuan dengan **tautan langsung unduh otomatis slide** dan **tautan ke setiap berkas kode**.
* Panduan eksekusi kilat (terminal vs browser vs real device).

---

### PILAR 2: Prinsip *"One-Slide, One-Runnable-File"* (Atomik)

Setiap slide presentasi yang memuat contoh teknis/koding **WAJIB** memiliki satu berkas kode program yang berdiri sendiri (*standalone*) dan lengkap dari awal hingga akhir:

* **Tidak Boleh Parsial:** Jangan pernah hanya mengunggah cuplikan 5 baris fungsi yang tidak bisa di-*run*.
* **Struktur Utuh:** Berkas harus memiliki titik masuk program (misal: `void main()`, `App()`, deklarasi impor lengkap).
* **Alur Penggunaan Mahasiswa:**
  1. Mahasiswa membuka berkas di GitHub.
  2. Klik tombol **"Copy raw file"**.
  3. Tempelkan (*paste*) seluruhnya menggantikan berkas utama lokal (misal: `lib/main.dart` atau `index.js`).
  4. Aplikasi langsung berjalan tanpa perlu konfigurasi tambahan.

---

### PILAR 3: Prinsip *"Anti-Design Overhead"* (Fokus Pedagogis)

Contoh kode untuk pengajaran konsep dasar **dilarang keras memuat dekorasi visual berlebihan**:

| Aspek | ❌ DILARANG (Beban Kognitif) | ✅ WAJIB DIGUNAKAN (Fokus Pedagogis) |
| :--- | :--- | :--- |
| **Styling** | `BoxDecoration`, `boxShadow`, border kustom tebal, radius kompleks. | Komponen standar framework bawaan (`Card`, `ListTile`, `Container` polos). |
| **Warna** | Warna heksadesimal custom (`#FFE600`, `#FAF8F5`, `#1E293B`). | Warna tema default bawaan (`Colors.blue`, `Colors.teal`, `ThemeData`). |
| **Panjang Berkas** | > 150 baris dengan fungsi wrapper berlapis (`_buildHeaderCard()`). | **35 s.d. 65 baris** langsung pada fungsi `build()`. |
| **Komentar Kode** | Komentar formal basa-basi (`// Ini adalah fungsi build`). | Komentar edukatif mengapa baris itu penting (`// WAJIB: dispose() controller agar RAM tidak bocor!`). |

---

### PILAR 4: Integrasi Hyperlink Dua Arah (Slide ⇄ GitHub)

Slide dan repositori GitHub harus terhubung secara organik:

#### A. Tombol Fisik di Setiap Slide PPTX
Setiap slide materi disematkan tombol aksi di bawah kartu kode:
```text
┌────────────────────────────────────────────────────────┐
│ ▶ BUKA KODE LENGKAP DI GITHUB (slide_04_controller.dart)│
└────────────────────────────────────────────────────────┘
```
Tautan tombol diarahkan ke alamat GitHub:
`https://github.com/[username]/[repo]/blob/main/07_contoh_kode_program/[pertemuan]/[nama_file]`

#### B. Rumus URL Unduh Otomatis Slide (.pptx)
Agar mahasiswa tidak terjebak pada halaman preview biner GitHub yang lambat, gunakan URL Raw GitHub:
```text
https://raw.githubusercontent.com/[username]/[repo]/main/03_slide_presentasi/[NAMA_FILE].pptx
```
*(Saat link ini diklik di browser atau portal LMS, berkas `.pptx` langsung terunduh secara otomatis).*

#### C. Rumus URL Penampil Web Tanpa Microsoft PowerPoint
Untuk mahasiswa yang mengakses materi dari smartphone atau tidak memiliki lisensi Office di laptop:
```text
https://view.officeapps.live.com/op/view.aspx?src=[ENCODED_RAW_URL]
```

---

### PILAR 5: *Zero-Warning Quality Gate* & Otomasi

Materi dosen harus menjadi teladan mutu kode (*Clean Code*):

1. **Compiler & Linter Gate:**
   Setiap berkas kode wajib melewati pemeriksaan linter resmi bahasa tanpa toleransi:
   * **Flutter/Dart:** `dart format .` dan `dart analyze .` wajib **0 issues, 0 warnings, 0 deprecations**.
   * **Python:** `black .` dan `flake8 .` atau `pylint`.
   * **JavaScript/TypeScript:** `prettier --write` dan `eslint`.
2. **Generasi Slide Berbasis Skrip (Otomatisasi):**
   Gunakan skrip generator (misal pustaka `python-pptx`) untuk menyusun deck slide. Keuntungannya:
   * Rasio layar pasti 16:9 modern.
   * Ukuran font, margin, dan posisi tombol link GitHub selalu presisi 100%.
   * Jika ada perubahan URL repositori, cukup ubah satu baris variabel dan jalankan skrip dalam 2 detik.
3. **Pengujian Tautan Daring Jarak Jauh:**
   Setelah melakukan `git push`, selalu lakukan verifikasi HTTP:
   ```bash
   curl -I https://raw.githubusercontent.com/[username]/[repo]/main/07_contoh_kode_program/...
   # Wajib memastikan status keluaran: HTTP/1.1 200 OK
   ```

---

### PILAR 6: Mitigasi Lingkungan Lab Kampus (*Low-Spec Friendly*)

Kerangka kerja harus menjamin praktikum berjalan lancar di laboratorium berkapasitas 40–50 PC:
* **Hindari Ketergantungan Emulator:** Emulator Android/iOS memakan RAM 2GB–4GB dan menyebabkan PC lab RAM 8GB macet total.
* **Alternatif Ringan Standar:**
  1. **Web Target (Chrome):** Memakan RAM < 150MB, Hot Reload instan (< 1 detik).
  2. **Online Playground:** [DartPad](https://dartpad.dev), [CodeSandbox](https://codesandbox.io), [Google Colab](https://colab.research.google.com).
  3. **Smartphone Fisik Asli:** Sambungkan kabel USB, aktifkan USB Debugging, gunakan aplikasi mirroring gratisan super ringan seperti `scrcpy` (~70MB RAM).
* **Solusi Paket Jaringan:** Berikan instruksi perintah terminal seperti `flutter pub add [package]` atau `npm install [package]` agar mahasiswa terhindar dari galat sintaks/indentasi saat mengedit berkas konfigurasi manual.

---

## 3. Prosedur Operasional Standar (SOP) Pembuatan Pertemuan Baru

Ikuti 7 langkah standar ini setiap kali Anda menyusun materi pertemuan baru:

```
[Langkah 1]  Pilih Sub-CPMK & Rumuskan 12 - 18 Konsep Atomik
     ↓
[Langkah 2]  Buat Berkas Kode Mandiri untuk Setiap Konsep (Fokus Pedagogis, 40-60 baris)
     ↓
[Langkah 3]  Uji Seluruh Berkas dengan Linter Resmi (Wajib 0 Issue, 0 Warning)
     ↓
[Langkah 4]  Susun / Generate Slide PPTX (Sematkan tombol link GitHub ke file kode)
     ↓
[Langkah 5]  Perbarui Tabel Katalog di README.md Repositori
     ↓
[Langkah 6]  Git Commit & Push ke GitHub
     ↓
[Langkah 7]  Verifikasi Akses Daring dengan curl -I (Pastikan HTTP 200 OK)
```

---

## 4. Panduan Adaptasi untuk Mata Kuliah Lain

Kerangka kerja ini dapat langsung diaplikasikan ke bidang studi lain dengan penyesuaian alat sebagai berikut:

### A. Pemrograman Web (HTML, CSS, JavaScript, React)
* **Aturan Kode:** Setiap slide memiliki satu berkas `index.html` mandiri yang sudah memuat `<script>` internal atau komponen React utuh via CDN / StackBlitz.
* **Trik Ringan:** Mahasiswa cukup klik dua kali berkas HTML untuk membuka di browser, atau gunakan ekstensi VS Code *Live Server*.
* **Playground Online:** [CodePen.io](https://codepen.io) atau [StackBlitz.com](https://stackblitz.com).

### B. Pemrograman Berorientasi Objek (Java / C++)
* **Aturan Kode:** 1 slide = 1 berkas `Main.java` lengkap dengan `public static void main(String[] args)` atau `main.cpp`. Hindari memecah file class menjadi puluhan berkas terpisah di pertemuan-pertemuan awal.
* **Eksekusi Kilat:**
  ```bash
  javac Main.java && java Main
  # atau
  g++ main.cpp -o app && ./app
  ```
* **Playground Online:** [Replit.com](https://replit.com) atau [Programiz](https://www.programiz.com/java-programming/online-compiler/).

### C. Python, Sains Data, & Machine Learning
* **Aturan Kode:** 1 slide = 1 berkas script `slide_XX.py` mandiri atau 1 tautan notebook [Google Colab](https://colab.research.google.com).
* **Bebas Masalah Environment:** Berikan petunjuk eksekusi via virtual environment atau Google Colab agar mahasiswa tidak terkendala versi dependensi pustaka (*dependency conflict*).

### D. Rekayasa Basis Data & SQL
* **Aturan Kode:** 1 slide = 1 skrip `slide_XX.sql` mandiri yang diawali dengan pembuatan tabel tiruan sederhana (*dummy table*), pengisian sampel data (*seed*), dan kueri analisisnya.
* **Playground Online:** [DB-Fiddle.com](https://www.db-fiddle.com) atau [SQLLiteOnline](https://sqliteonline.com).

---

## 5. Template Standar Berkas Kode Mandiri

Gunakan format header berikut pada setiap berkas kode contoh yang Anda buat:

```dart
// =====================================================================
// NAMA MATA KULIAH - PERTEMUAN XX: [TOPIK BESAR]
// SLIDE YY: [JUDUL KONSEP SLIDE]
// Topik: [Penjelasan 1 baris mengenai apa yang dipelajari]
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev)
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const ContohAplikasi());
}

class ContohAplikasi extends StatelessWidget {
  const ContohAplikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contoh Slide YY',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const LayarUtama(),
    );
  }
}

class LayarUtama extends StatelessWidget {
  const LayarUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slide YY: Judul Konsep')),
      body: const Center(
        child: Text('Fokus pada materi, bebas distraksi desain!'),
      ),
    );
  }
}
```

---

## 6. Kesimpulan & Manfaat bagi Dosen dan Mahasiswa

1. **Bagi Mahasiswa:**
   * Waktu persiapan (*setup time*) terpangkas dari 15 menit menjadi di bawah 10 detik.
   * Kepercayaan diri meningkat karena setiap contoh kode dijamin langsung berhasil dijalankan (*instant gratification*).
   * Tidak terbebani oleh laptop yang lambat atau panas.
2. **Bagi Dosen:**
   * Mengurangi waktu habis untuk menangani keluhan error teknis sepele di ruang praktikum.
   * Materi perkuliahan tersimpan rapi, berstandar industri, dan dapat diperbarui (*maintainable*) secara otomatis dari tahun ke tahun.
   * Portofolio repositori publik dosen di GitHub menjadi rujukan bereputasi tinggi.

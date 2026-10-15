# 📋 Silabus Pemrograman Piranti Bergerak

> **Program Studi Informatika (S1)** · Semester Ganjil 2026/2027
> Teknologi utama: **Flutter 3.47** (kanal *stable*) dan **Dart 3.13**

[🏠 Kembali ke Beranda](README.md)

---

## 1. Identitas Mata Kuliah

| Komponen | Keterangan |
| :--- | :--- |
| Nama mata kuliah | Pemrograman Piranti Bergerak (*Mobile Application Development*) |
| Jumlah pertemuan | 16 kali (14 pertemuan materi + UTS + UAS) |
| Bentuk pembelajaran | Kuliah (penjelasan konsep) + praktikum (jobsheet di laboratorium) |
| Prasyarat yang disarankan | Algoritma & Pemrograman. Materi tetap disusun **dari nol**, jadi Anda tidak perlu pernah membuat aplikasi sebelumnya. |
| Bahasa pemrograman | Dart |
| Framework | Flutter (satu kode untuk Android, iOS, web, dan desktop) |
| Perangkat lunak | Git, Visual Studio Code + ekstensi Flutter, Flutter SDK, Google Chrome. Android Studio bersifat opsional (untuk menjalankan di HP Android). |

## 2. Deskripsi Singkat

Mata kuliah ini membimbing Anda membangun aplikasi untuk perangkat bergerak (*smartphone* dan tablet) memakai Flutter. Kita mulai dari hal paling dasar, yaitu memasang alat dan mengenal bahasa Dart. Setelah itu kita belajar menyusun tampilan, membuat aplikasi yang bisa berinteraksi dengan pengguna, mengambil data dari internet, menyimpan data di perangkat, sampai menata aplikasi dengan arsitektur yang rapi dan teruji. Di akhir semester, Anda akan memiliki satu **proyek aplikasi utuh** yang layak dimasukkan ke portofolio.

## 3. Capaian Pembelajaran Mata Kuliah (CPMK)

| Kode | Setelah mengikuti mata kuliah ini, mahasiswa mampu ... |
| :---: | :--- |
| **CPMK-1** | menjelaskan siklus hidup (*lifecycle*) aplikasi mobile, menerapkan arsitektur perangkat lunak (MVVM dan *Clean Architecture*), serta mengelola *state* aplikasi. |
| **CPMK-2** | merancang dan membangun antarmuka (UI/UX) yang responsif sesuai pedoman **Material Design 3**. |
| **CPMK-3** | mengintegrasikan RESTful API, penyimpanan lokal, dan pemrograman asinkron (*asynchronous programming*) ke dalam aplikasi. |
| **CPMK-4** | menerapkan praktik terbaik pengembangan: penulisan *clean code*, pengujian dasar (*unit test*), dan *debugging*. |

## 4. Rencana Pembelajaran Mingguan

Setiap pertemuan memiliki folder sendiri berisi **modul bacaan**, **contoh kode siap jalan**, **jobsheet praktikum**, **latihan**, dan **slide presentasi**.

| Pertemuan | Topik | Kemampuan akhir yang diharapkan | CPMK | Status |
| :---: | :--- | :--- | :---: | :---: |
| **1** | [Pengenalan Pemrograman Piranti Bergerak & Flutter](pertemuan_01_pengenalan_flutter/README.md) | Menjelaskan ekosistem dan pendekatan pengembangan aplikasi mobile serta siklus hidup aplikasi; menyiapkan lingkungan kerja; menjalankan dan memodifikasi aplikasi Flutter pertama. | 1 | ✅ Tersedia |
| **2** | [Dasar Pemrograman Dart](pertemuan_02_dasar_dart/README.md) | Menulis program Dart memakai variabel, tipe data, *null safety*, operator, percabangan, perulangan, fungsi, dan koleksi data dengan gaya penulisan yang rapi. | 4 | ✅ Tersedia |
| **3** | [Dart Lanjutan: OOP & Pemrograman Asinkron](pertemuan_03_dart_lanjutan/README.md) | Menerapkan *class*, *constructor*, pewarisan, *mixin*, *enum*, penanganan *error*, serta `Future`, `async`/`await`, dan `Stream`. | 3 | ✅ Tersedia |
| **4** | [Widget & Tata Letak (*Layout*)](pertemuan_04_widget_dan_layout/README.md) | Menyusun tampilan memakai widget dasar dan widget tata letak (`Row`, `Column`, `Stack`, `Expanded`), memahami *constraints*, dan mengatasi *overflow*. | 2 | ✅ Tersedia |
| **5** | [Interaksi Pengguna & *State* Lokal](pertemuan_05_interaksi_dan_state/README.md) | Membuat tampilan interaktif dengan `StatefulWidget` dan `setState`, memahami siklus hidup widget, serta membuat formulir beserta validasinya. | 1, 2 | ✅ Tersedia |
| **6** | Daftar Data & Navigasi Antarhalaman | Menampilkan data dengan `ListView`/`GridView` dan berpindah halaman sambil mengirim data (`Navigator` dan `go_router`). | 2 | 🔜 Segera |
| **7** | Material Design 3 & UI Responsif | Menerapkan tema Material 3 (warna, tipografi, mode gelap) dan tata letak yang menyesuaikan ukuran layar. | 2 | 🔜 Segera |
| **8** | **Ujian Tengah Semester (UTS)** | Ujian praktik: membangun aplikasi multi-halaman sesuai spesifikasi. | 2 | — |
| **9** | Manajemen State & Pola MVVM | Mengelola *state* aplikasi dengan `ChangeNotifier` dan `provider`, serta memisahkan *View* dan *ViewModel*. | 1 | 🔜 Segera |
| **10** | Asinkron & Integrasi REST API | Mengambil dan mengirim data ke REST API (paket `http`, JSON, model data) serta menangani kondisi *loading* dan *error*. | 3 | 🔜 Segera |
| **11** | Penyimpanan Lokal | Menyimpan data di perangkat (`shared_preferences` dan SQLite) serta menerapkan *cache* sederhana. | 3 | 🔜 Segera |
| **12** | Arsitektur Aplikasi: *Clean Architecture* | Menata aplikasi berlapis (UI, *domain*, data) dengan *repository pattern* dan *dependency injection*. | 1 | 🔜 Segera |
| **13** | Fitur Perangkat & Izin Akses | Mengakses kamera/galeri dan lokasi, serta menangani izin (*permission*) dengan benar. | 3 | 🔜 Segera |
| **14** | Pengujian & *Debugging* | Menulis *unit test* dan *widget test*, serta memakai Flutter DevTools untuk mencari dan memperbaiki masalah. | 4 | 🔜 Segera |
| **15** | *Build*, Rilis & Finalisasi Proyek | Menyiapkan identitas aplikasi, membuat berkas rilis (APK/AAB/web), dan memeriksa kesiapan rilis. | 4 | 🔜 Segera |
| **16** | **Ujian Akhir Semester (UAS)** | Presentasi dan demo proyek akhir. | 1–4 | — |

> [!NOTE]
> Urutan materi disusun **berjenjang**: setiap pertemuan memakai bekal dari pertemuan sebelumnya. Jika Anda tertinggal satu pertemuan, kejar dulu materi tersebut sebelum lanjut.

## 5. Proyek Akhir

Mulai Pertemuan 9, Anda mengerjakan satu aplikasi berbasis **kasus nyata** (individu atau kelompok kecil, mengikuti arahan dosen). Contoh tema: katalog produk UMKM, presensi kegiatan organisasi, pencatat keuangan mahasiswa, atau informasi jadwal kuliah.

**Syarat minimal aplikasi:**

1. Minimal tiga halaman dengan navigasi yang jelas.
2. Tampilan mengikuti Material Design 3 dan nyaman dipakai di ukuran layar berbeda.
3. Mengambil data dari REST API **dan** menyimpan sebagian data di perangkat.
4. Kode tertata dengan pola MVVM atau *Clean Architecture*.
5. Memiliki minimal tiga *unit test* yang lulus.
6. Disimpan di repositori Git dengan riwayat *commit* yang rapi dan `README.md` yang menjelaskan cara menjalankannya.

| Tahap | Waktu | Yang dikumpulkan |
| :--- | :---: | :--- |
| Proposal | Pertemuan 9 | Ide aplikasi, sumber data (API), dan sketsa tampilan |
| Kemajuan | Pertemuan 12 | Demo fitur utama yang sudah berjalan |
| Finalisasi | Pertemuan 15 | Aplikasi lengkap, *test*, dan berkas rilis |
| Presentasi | Pertemuan 16 | Demo langsung dan tanya jawab |

## 6. Komponen Penilaian

| Komponen | Bobot | Keterangan |
| :--- | :---: | :--- |
| Praktikum (jobsheet) | 25% | Dikumpulkan setiap pertemuan sesuai petunjuk di jobsheet |
| Kuis | 10% | Pemahaman konsep, mengacu pada berkas latihan setiap pertemuan |
| UTS | 25% | Ujian praktik membangun antarmuka aplikasi |
| Proyek akhir + UAS | 40% | Kualitas aplikasi, kode, repositori Git, dan presentasi |

## 7. Lingkungan Belajar yang Disarankan

| Kebutuhan | Minimal | Disarankan |
| :--- | :--- | :--- |
| Sistem operasi | Windows 10/11 64-bit, macOS, atau Linux | Windows 11 / macOS terbaru |
| RAM | 8 GB (jalankan aplikasi di **Chrome**) | 16 GB (jika ingin memakai emulator Android) |
| Ruang penyimpanan kosong | sekitar 10 GB | sekitar 25 GB (jika memasang Android Studio dan emulator) |
| Perangkat uji | Google Chrome | Ditambah HP Android + kabel data USB |

> [!TIP]
> **Laptop Anda RAM 8 GB?** Tidak masalah. Hampir semua contoh bisa dijalankan di **Google Chrome** yang jauh lebih ringan daripada emulator. Jika punya HP Android, Anda juga bisa menjalankan aplikasi langsung di HP lewat kabel USB.
>
> Sebagian kecil fitur di Pertemuan 11 dan 13 (misalnya SQLite, kamera, dan izin akses) paling baik dicoba di HP Android. Modul pertemuan tersebut akan menjelaskan alternatifnya bila Anda tidak memiliki HP Android.

## 8. Referensi Utama

1. Dokumentasi resmi Flutter — <https://docs.flutter.dev>
2. Dokumentasi resmi Dart — <https://dart.dev/guides>
3. Katalog API Flutter — <https://api.flutter.dev>
4. Pedoman Material Design 3 — <https://m3.material.io>
5. Panduan arsitektur aplikasi Flutter — <https://docs.flutter.dev/app-architecture>
6. DartPad (editor Dart & Flutter daring) — <https://dartpad.dev>

---

[🏠 Kembali ke Beranda](README.md) · [➡️ Mulai Pertemuan 1](pertemuan_01_pengenalan_flutter/README.md)

# RUBRIK PENILAIAN ANALITIK OBE (LAM INFOKOM)
## Mata Kuliah: Pemrograman Piranti Bergerak (Mobile Application Development)

---

## 1. Rubrik Penilaian Tugas Praktikum Mingguan (Bobot: 25%)

Digunakan oleh Dosen dan Asisten Praktikum (Asprak) untuk menilai jobsheet lab mingguan di GitHub Classroom.

| Kriteria / Dimensi | Sangat Baik (85 - 100) | Baik (70 - 84) | Cukup (55 - 69) | Kurang (< 55) | Bobot |
| :--- | :--- | :--- | :--- | :--- | :---: |
| **Kebenaran Fungsionalitas & Output** | Program berjalan 100% tanpa error, semua skenario kasus uji berhasil ditangani dengan benar. | Program berjalan baik, ada 1 *edge-case minor* yang terlewat namun tidak menyebabkan aplikasi crash. | Program berjalan sebagian, terdapat bug yang menyebabkan fungsionalitas utama terganggu. | Program gagal kompilasi (*compile error*) atau crash saat dijalankan. | 35% |
| **Penerapan Konsep & Best Practice Dart/Flutter** | Menerapkan *effective Dart*, *sound null safety*, penamaan konvensional, widget tree modular (tidak ada widget monolitik raksasa). | Menerapkan *null safety* dengan baik, modularisasi widget cukup rapi dengan sedikit duplikasi kode. | Terdapat penggunaan operator *force unwrap* (`!`) berlebihan, pemecahan widget kurang terstruktur. | Kode tidak terstruktur (*spaghetti code*), mengabaikan peringatan linter (`flutter analyze` gagal). | 25% |
| **Manajemen State & Pemisahan Logika** | Logika bisnis terpisah sempurna dari antarmuka (menggunakan Cubit/BLoC/Controller yang sesuai). | Logika bisnis sebagian besar terpisah, hanya ada interaksi data sederhana di dalam widget UI. | Logika bisnis bercampur baur di dalam class widget UI (overuse `setState` di tempat yang tidak semestinya). | Tidak memahami konsep state, logika dan UI disatukan dalam satu file monolitik. | 25% |
| **Disiplin Version Control (Git)** | Commit teratur dengan pesan bermakna (*conventional commits*), dikumpulkan tepat waktu sebelum batas deadline. | Memiliki beberapa commit yang relevan, dikumpulkan tepat waktu. | Hanya melakukan 1 kali commit ("final project" / "done"), dikumpulkan mendekati deadline. | Terlambat mengumpulkan tugas atau repositori tidak dapat diakses publik/dosen. | 15% |

---

## 2. Rubrik Penilaian Proyek Tengah Semester (UTS - Sprint 1) (Bobot: 20%)

Fokus: Arsitektur Dasar, Desain Antarmuka Adaptif, Navigasi Deklaratif, & State Management Lokal.

| Kriteria Penilaian | Kualifikasi A (85 - 100) | Kualifikasi B (70 - 84) | Kualifikasi C (55 - 69) | Kualifikasi D/E (< 55) | Bobot |
| :--- | :--- | :--- | :--- | :--- | :---: |
| **Kualitas Antarmuka (UI/UX) & Desain Sistem** | Menerapkan Material Design 3 secara konsisten, palet warna dan tipografi terstruktur, mendukung tema *Light & Dark*, tata letak responsif. | Desain UI rapi dan konsisten, tata letak adaptif di layar smartphone normal, tema warna cukup baik. | Desain UI kaku, terjadi *overflow error* (garis kuning-hitam) di beberapa ukuran layar, warna tidak harmonis. | Desain antarmuka berantakan, tidak estetis, banyak elemen teks terpotong dan tombol tidak dapat diklik. | 30% |
| **Arsitektur Proyek & Folder Structure** | Menerapkan *Feature-First* atau *Clean Architecture* modular, pemisahan folder `presentation`, `domain`, dan `data` sangat jelas. | Struktur folder rapi dan terorganisir dengan pemisahan komponen dan model data yang baik. | Struktur folder terlalu datar (*flat*), semua file diletakkan dalam satu atau dua direktori saja. | Tidak ada struktur folder, seluruh kode tercampur acak di direktori `lib/`. | 25% |
| **Navigasi & Routing** | Menggunakan *GoRouter* secara deklaratif, mendukung *nested navigation* (bottom navigation bar), dan *parameter passing* yang aman. | Menggunakan routing terpusat yang berjalan lancar saat berpindah antar halaman. | Navigasi masih menggunakan *imperative routing* tradisional yang bertumpuk tanpa struktur rute terpusat. | Navigasi rusak, tombol *back* menyebabkan layar kosong (*blank screen*) atau crash. | 20% |
| **State Management Lokal** | Implementasi Cubit/BLoC memisahkan state antarmuka secara reaktif, status loading/error/success ditangani elegan. | State management berjalan dengan baik untuk interaksi lokal antar halaman. | Penggunaan state manager kurang tepat (*state leaking* atau *rebuild widget* berlebihan yang tidak perlu). | Tidak ada arsitektur state management yang diterapkan. | 15% |
| **Kerjasama Tim & Git Hygiene** | Seluruh anggota memiliki kontribusi commit & pull request yang seimbang di repositori tim, dokumentasi `README.md` lengkap. | Kontribusi antar anggota terlihat di riwayat commit, dokumentasi proyek cukup informatif. | Kontribusi didominasi oleh satu orang saja, anggota lain hanya memiliki commit minor. | Hanya ada commit dari 1 orang mahasiswa (*one-man show*), tidak ada bukti kerja tim. | 10% |

---

## 3. Rubrik Penilaian Proyek Akhir (UAS - Demo Day & Code Defense) (Bobot: 25%)

Fokus: Kelengkapan Fungsionalitas, Integrasi Data Jaringan & Cloud, Fitur Cerdas/Hardware, Pengujian Otomatis, dan Penguasaan Kode Individu.

| Komponen | Bobot | Kriteria Penilaian Sangat Baik (85 - 100) |
| :--- | :---: | :--- |
| **Kelengkapan Fitur & Solusi Produk** | 25% | Aplikasi menyelesaikan masalah nyata (*problem-solving*), memiliki alur pengguna (*user flow*) yang lengkap dari onboarding, autentikasi, transaksi/kegiatan utama, hingga pengaturan profil. |
| **Integrasi API, Caching, & BaaS** | 20% | Menggunakan `dio` dengan interceptor, serialisasi otomatis, strategi *offline-first* (aplikasi tetap dapat dibuka dan menampilkan data lokal saat luring), dan autentikasi aman melalui Firebase/Supabase. |
| **Hardware & Fitur Cerdas (AI / Sensor)** | 15% | Berhasil mengintegrasikan kamera/GPS secara mulus dengan penanganan *runtime permissions* yang ramah pengguna, serta memiliki fitur cerdas (ML Kit OCR/Barcode atau AI API). |
| **Security, Testing, & Build Release** | 15% | API keys tersimpan aman di `.env` (tidak masuk git), memiliki *unit tests* untuk logika bisnis inti, serta berkas rilis `.apk`/`.aab` berhasil di-sign dengan ukuran teroptimasi. |
| **Live Code Defense (Ujian Lisan Individu)** | 25% | **Penilaian Individu:** Setiap anggota tim mampu menjawab pertanyaan teknis secara mendalam tentang kode yang dibuatnya dan mampu melakukan *live coding modification* di hadapan dosen penguji. |

---

## 4. Formulir Evaluasi Rekan Sejawat (*Peer-Evaluation Form*)

Formulir ini diisi secara rahasia oleh setiap mahasiswa pada akhir periode UTS dan UAS melalui Google Form / LMS internal.

### Skala Penilaian Rekan (1 - 5):
1. **Kehadiran & Komunikasi:** Apakah rekan Anda menghadiri pertemuan tim dan merespons diskusi di grup secara tepat waktu?
2. **Tanggung Jawab Tugas:** Apakah rekan Anda menyelesaikan tugas modul/fitur yang menjadi porsinya sesuai tenggat waktu yang disepakati?
3. **Kualitas Kode:** Apakah kode yang ditulis oleh rekan Anda berkualitas, mematuhi standar tim, dan tidak membebani anggota lain untuk memperbaikinya?
4. **Inisiatif & Pemecahan Masalah:** Sejauh mana inisiatif rekan Anda saat tim menghadapi kendala bug atau tantangan teknis?

### Formula Perhitungan Pengali Nilai Akhir:
$$\text{Rata-rata Skor Rekan} = \frac{\sum \text{Skor dari Seluruh Rekan Tim}}{\text{Jumlah Rekan}}$$

$$\text{Faktor Kontribusi } (F) = \begin{cases} 
1.10 & \text{jika Skor Rata-rata} \ge 4.8 \text{ (Kontribusi Luar Biasa)} \\
1.00 & \text{jika } 4.0 \le \text{Skor Rata-rata} < 4.8 \text{ (Kontribusi Standar)} \\
0.75 & \text{jika } 3.0 \le \text{Skor Rata-rata} < 4.0 \text{ (Kontribusi Kurang)} \\
0.50 & \text{jika } 2.0 \le \text{Skor Rata-rata} < 3.0 \text{ (Kontribusi Sangat Rendah)} \\
0.00 & \text{jika Skor Rata-rata} < 2.0 \text{ (Free-Rider / Titip Nama Terbukti)}
\end{cases}$$

$$\text{Nilai Akhir Proyek Mahasiswa} = \min(100, \text{Nilai Kelompok} \times F)$$

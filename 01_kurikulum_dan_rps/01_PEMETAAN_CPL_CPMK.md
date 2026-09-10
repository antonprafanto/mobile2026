# Pemetaan CPL, CPMK, dan Sub-CPMK
## Mata Kuliah: Pemrograman Piranti Bergerak (Mobile Application Development)
**Program Studi:** Teknik Informatika / Ilmu Komputer  
**Bobot:** 3 SKS (1 SKS Teori, 2 SKS Praktikum)  
**Semester:** 5 / 6  
**Standar Akreditasi:** LAM INFOKOM / IABEE (Outcome-Based Education)

---

## 1. Capaian Pembelajaran Lulusan (CPL) yang Dibebankan pada Mata Kuliah

| Kode CPL | Kategori | Deskripsi Capaian Pembelajaran Lulusan |
| :--- | :--- | :--- |
| **CPL-01** | Keterampilan Khusus | Mampu merancang, mengimplementasikan, dan mengevaluasi perangkat lunak bergerak (*mobile software*) yang aman, adaptif, dan berkinerja tinggi menggunakan metodologi rekayasa perangkat lunak modern. |
| **CPL-02** | Pengetahuan | Menguasai konsep teoritis arsitektur sistem operasi piranti bergerak, siklus hidup aplikasi, manajemen *state*, komunikasi jaringan client-server, dan persistensi data lokal. |
| **CPL-03** | Keterampilan Umum | Mampu bekerja sama secara efektif dalam tim multidisiplin dengan memanfaatkan sistem kendali versi (*version control system*) dan standar kolaborasi industri. |
| **CPL-04** | Sikap & Etika | Menunjukkan sikap bertanggung jawab dan beretika dalam pemanfaatan alat bantu kecerdasan buatan (*Generative AI*), integritas akademik, dan perlindungan privasi data pengguna. |

---

## 2. Capaian Pembelajaran Mata Kuliah (CPMK)

Berdasarkan CPL di atas, dirumuskan 4 (empat) CPMK utama:

* **CPMK-1 (Kognitif & Arsitektur):** Mahasiswa mampu menganalisis dan merancang arsitektur aplikasi mobile berbasis Flutter dengan menerapkan prinsip pemisahan logika (*Separation of Concerns*) dan *State Management* modern. (Mendukung **CPL-01**, **CPL-02**)
* **CPMK-2 (Keterampilan Teknis & Integrasi):** Mahasiswa mampu mengimplementasikan antarmuka adaptif, mengintegrasikan *RESTful API*, persistensi data lokal (offline-first), serta fitur native perangkat keras (*sensor/kamera/lokasi*). (Mendukung **CPL-01**, **CPL-02**)
* **CPMK-3 (Kualitas, Pengujian, & Rilis):** Mahasiswa mampu melakukan *unit testing*, *widget testing*, *code analysis*, pengamanan kunci rahasia (*secret management*), dan menghasilkan paket rilis siap edar (*APK/AAB*) berstandar industri. (Mendukung **CPL-01**)
* **CPMK-4 (Kolaborasi & Komunikasi):** Mahasiswa mampu membangun produk aplikasi secara berkelompok menggunakan Git, mempresentasikan hasil karya, dan mempertanggungjawabkan kode yang ditulis secara lisan (*code defense*). (Mendukung **CPL-03**, **CPL-04**)

---

## 3. Matriks Pemetaan Sub-CPMK ke CPMK (16 Pertemuan)

| Pertemuan | Sub-CPMK (Kemampuan Akhir Tiap Tahap Pembelajaran) | CPMK Terkait | Bentuk Asesmen |
| :---: | :--- | :---: | :--- |
| **M1** | Mampu mengonfigurasi *development environment* Flutter dan menganalisis perbedaan arsitektur native vs cross-platform. | CPMK-1 | Kuis 1 & Checklist Lab Setup |
| **M2** | Mampu memecahkan masalah logika menggunakan sintaks modern Dart (null safety, asynchronous `Future`/`Stream`, OOP). | CPMK-1 | Tugas Pemrograman Dart Async |
| **M3** | Mampu membedah dan menyusun hierarki antarmuka menggunakan komposisi *Stateless* dan *Stateful Widgets*. | CPMK-2 | Latihan Praktikum UI Layout |
| **M4** | Mampu membuat form interaktif dengan validasi input serta mengonfigurasi navigasi deklaratif (*GoRouter*). | CPMK-2 | Tugas Praktikum Form & Routing |
| **M5** | Mampu mengimplementasikan Material Design 3, tema adaptif (*Dark/Light*), dan tata letak responsif lintas ukuran layar. | CPMK-2 | Milestone UI Tim |
| **M6** | Mampu menganalisis keterbatasan `setState()` dan menerapkan manajemen state berbasis *Cubit / BLoC* dasar. | CPMK-1 | Latihan Praktikum Cubit Counter/Cart |
| **M7** | Mampu merancang struktur proyek berskala enterprise menggunakan *Clean Architecture / Feature-First* dan Dependency Injection. | CPMK-1 | Review Arsitektur Kode Kelompok |
| **M8** | **UJIAN TENGAH SEMESTER (UTS):** Mampu mendemokan prototipe aplikasi mobile interaktif dengan arsitektur dan *state* terstruktur. | CPMK-1, CPMK-4 | Presentasi & Live Demo Sprint 1 |
| **M9** | Mampu menghubungkan aplikasi dengan layanan *RESTful API* menggunakan `dio`, serialisasi JSON otomatis, dan error handling. | CPMK-2 | Tugas Integrasi API Publik/Lokal |
| **M10** | Mampu menerapkan strategi *offline-first* menggunakan basis data lokal (*Isar/Drift/Hive*) dan *caching*. | CPMK-2 | Praktikum Offline Persistence |
| **M11** | Mampu mengintegrasikan layanan *Backend-as-a-Service* (Firebase/Supabase) untuk autentikasi dan penyimpanan *cloud*. | CPMK-2 | Praktikum Cloud Auth & Storage |
| **M12** | Mampu mengakses perangkat keras piranti bergerak (*camera/image picker*, *GPS/geolocation*, *runtime permissions*). | CPMK-2 | Praktikum Hardware & Geolocation |
| **M13** | Mampu menerapkan *secret management* (.env, secure storage) dan integrasi fitur cerdas (*Google ML Kit / AI API*). | CPMK-2, CPMK-3 | Praktikum Security & AI Feature |
| **M14** | Mampu menulis *Unit Test* logika bisnis, *Widget Test* UI, dan mendiagnosis performa render menggunakan Flutter DevTools. | CPMK-3 | Praktikum Automated Testing |
| **M15** | Mampu melakukan *app hardening*, *obfuscation*, *signing keystore*, dan membangun berkas rilis `.apk` dan `.aab`. | CPMK-3 | Verifikasi Build Release & CI |
| **M16** | **UJIAN AKHIR SEMESTER (UAS):** Mampu mempublikasikan dan mempertanggungjawabkan produk aplikasi utuh pada *Demo Day*. | CPMK-1, CPMK-2, CPMK-3, CPMK-4 | Demo Day, Git Audit & Code Defense |

---

## 4. Distribusi Bobot Asesmen Berdasarkan CPMK

Untuk memenuhi kualifikasi portofolio akreditasi OBE:

$$\begin{aligned}
\text{Total Nilai} = &(20\% \times \text{CPMK-1}) + (35\% \times \text{CPMK-2}) \\
&+ (25\% \times \text{CPMK-3}) + (20\% \times \text{CPMK-4}) = 100\%
\end{aligned}$$

* **Tugas Praktikum Mandiri/Mingguan (Sub-CPMK M1-M7, M9-M15):** 25%
* **Proyek Tengah Semester (UTS - Milestone Sprint 1):** 25%
* **Proyek Akhir Semester (UAS - Product Demo & Code Defense):** 35%
* **Partisipasi Aktif, Kuis, & Peer-Review Kontribusi Tim:** 15%

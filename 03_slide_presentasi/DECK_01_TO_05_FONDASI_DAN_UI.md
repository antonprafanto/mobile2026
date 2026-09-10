# SLIDE DECK MATERI AJAR: PERTEMUAN 01 - 05
## Fase 1: Fondasi, Bahasa Dart, & Rekayasa Antarmuka (UI/UX)

---

# PERTEMUAN 01: Pengantar Pemrograman Piranti Bergerak & Ekosistem Flutter Modern

### Slide 1: Cover & Orientasi Kelas
* **Judul:** Pengantar Pemrograman Piranti Bergerak & Ekosistem Flutter Modern.
* **Subjudul:** Fondasi arsitektur mobile, revolusi single-codebase, konfigurasi alat kerja lab, dan langkah perdana menjadi mobile software engineer profesional.

### Slide 2: The Big Picture (Roadmap 16 Minggu & Output Nyata)
* **Tujuan Pedagogis:** Memberikan kejelasan arah belajar sejak hari pertama.
* **4 Fase Milestone:**
  1. *Fase 1 (M1–M5):* Fondasi Dart, Rekayasa UI, Navigasi GoRouter, & Material 3.
  2. *Fase 2 (M6–M8):* State Management Cubit & Clean Architecture (UTS Sprint 1).
  3. *Fase 3 (M9–M12):* Integrasi RESTful API (Dio), Database Luring (Offline-First), & Firebase Cloud.
  4. *Fase 4 (M13–M16):* Sensor Kamera/GPS, Automated Testing, Keystore Signing, & Demo Day (UAS Expo).

### Slide 3: Mengapa Mobile Development di 2026?
* **Fakta Industri:**
  1. *Mobile-First Era:* Lebih dari 70% konsumsi internet global lewat smartphone.
  2. *Efisiensi Single Codebase:* 1 basis kode Flutter menggantikan 2 tim terpisah (Android & iOS).
  3. *Peluang Kerja:* Kebutuhan developer mobile tinggi di perbankan, startup, maupun peluang membangun produk mandiri (Indie SaaS).

### Slide 4: Membedah Konsep Mendasar: Dart vs Flutter
* **Dart (Bahan Baku / Bahasa):** Mesin penggerak, kabel transmisi, dan logika otak program buatan Google dengan Sound Null Safety.
* **Flutter (Framework / UI Toolkit):** Kotak perkakas Lego berisi ratusan komponen visual siap pakai dan mesin perender GPU.

### Slide 5: Tiga Cara Membangun Aplikasi Mobile (Komparasi Arsitektur)
* **Native Murni (Kotlin/Swift):** Cepat, tapi biaya ganda dan harus merawat 2 basis kode berbeda.
* **Hybrid WebView (Cordova/Ionic):** Membungkus web ke dalam app, getar dan performa patah-patah.
* **Canvas Engine (Flutter):** Menggambar piksel mandiri langsung ke GPU dengan performa 60–120 FPS di semua perangkat.

### Slide 6: Di Balik Layar: Engine Impeller & Skia (Filosofi Game Engine)
* **Konsep:** Flutter bekerja layaknya game engine (Unity), merender grafis secara mandiri.
* **Impeller Engine (2026 Standard):** Menghilangkan *shader compilation jank* dengan pre-compiling shader sebelum aplikasi berjalan.

### Slide 7: Diagnostik Instalasi: Membedah 'flutter doctor'
* **Pemeriksaan SDK:** Menjalankan `flutter doctor -v` untuk memeriksa kesehatan toolchain.
* **Lisensi Android:** Cara menyetujui lisensi dengan `flutter doctor --android-licenses`.

### Slide 8: Membuat Proyek Perdana: 'flutter create'
* **Perintah Terminal:** `flutter create halo_flutter` dan standar penamaan proyek (huruf kecil dan underscore, tanpa spasi/strip).

### Slide 9: Membedah Struktur Tiga Folder Utama Proyek
* **Peta Navigasi File:**
  * `lib/`: Tempat ngoding 99% waktu kita (berkas utama: `lib/main.dart`).
  * `pubspec.yaml`: "KTP" aplikasi dan daftar belanja paket pustaka/gambar.
  * `android/` & `ios/`: Pembungkus native (jangan diubah jika belum mahir).

### Slide 10: Membedah Berkas 'pubspec.yaml'
* **Manajemen Dependensi:** Mendaftarkan paket pustaka (`google_fonts`) dan aset gambar lokal.
* **Peringatan Kritis:** Format YAML wajib menggunakan tepat 2 spasi (dilarang menggunakan tombol Tab!).

### Slide 11: Sihir Hot Reload vs Hot Restart vs Full Build
* **Tabel Komparasi:**
  * *Hot Reload (`r` / `Ctrl+S`):* Perbarui UI dalam < 1 detik tanpa reset state/angka.
  * *Hot Restart (`R`):* Reset state kembali ke 0 dalam 1–2 detik.
  * *Full Build:* Hentikan dan bangun ulang saat menambah dependensi di `pubspec.yaml`.

### Slide 12: Anatomi Kode Perdana: 'lib/main.dart'
* **Bedah Baris per Baris:** `void main()`, `runApp()`, `MaterialApp`, `Scaffold`, dan `Center(child: Text(...))`.

### Slide 13: Membedah Default Counter App Bawaan Flutter
* **Interaktivitas Pertama:** Bagaimana variabel `int _counter` bertambah nilainya saat tombol `FloatingActionButton` ditekan melalui fungsi `setState()`.

### Slide 14: Solusi Kilat Lab: Kompilasi Chrome 5 Detik (Hemat RAM)
* **Mitigasi RAM 8GB:** Menjalankan target browser `flutter run -d chrome` yang hanya memakan RAM ~150MB dan selesai dalam 5 detik tanpa beban emulator Android SDK.

### Slide 15: Solusi HP Fisik: USB Debugging & Scrcpy (RAM < 80MB)
* **Pengujian Nyata:** Mengaktifkan USB Debugging (ketuk Build Number 7x), mencerminkan layar dengan Scrcpy, dan menjalankan `flutter run`.

### Slide 16: Setup VS Code: Ekstensi & Shortcut Wajib
* **Alat Kerja:** Ekstensi Flutter & Dart, `editor.formatOnSave: true`, dan `dart.previewFlutterUiGuides: true` di `settings.json`.

### Slide 17: Lab Quest Praktikum Mandiri (First Win)
* **Tantangan 45 Menit:**
  1. Verifikasi `flutter doctor`.
  2. Buat proyek `flutter create tugas_pertemuan_01`.
  3. Jalankan di Chrome atau HP fisik.
  4. Ubah teks nama mahasiswa, NIM, dan warna tema `seedColor`.
  5. Buktikan Hot Reload (`Ctrl+S`) mengubah layar seketika!

### Slide 18: Jembatan Menuju Pertemuan 02 (Deep Dive Dart)
* **Bocoran Materi:** Sound Null Safety (`String` vs `String?`), Operator penjinak null (`??`), dan Asinkronus (`Future`, `async/await`).

---

# PERTEMUAN 02: Pemrograman Modern Dart (Logika, Null Safety, OOP, & Asinkron)

### Slide 1: Cover & Orientasi Sesi
* **Judul:** Pemrograman Modern Dart: Logika, Null Safety, & Asinkron.
* **Subjudul:** Menyelami bahasa di balik Flutter: sistem tipe data modern, menjinakkan galat null pointer, rekayasa OOP konstruktor, dan aliran data reaktif Future & Stream.

### Slide 2: Panduan Alat (Tools) Tempat Menguji Kode
* **Opsi 1 (Instan tanpa instalasi):** Akses **DartPad** di `dartpad.dev` via browser.
* **Opsi 2 (Lokal):** Buka VS Code, buat berkas `latihan.dart`, jalankan di terminal: `dart run latihan.dart`.
* **Tips Dosen:** Pasang ekstensi 'Dart' di VS Code, klik tombol sakti "Run" kecil di atas fungsi `void main()`.

### Slide 3: Mindset: Mengapa Harus Paham Dart Dulu?
* **Analogi Kendaraan:** Flutter adalah bodi mobil, jok empuk, dan cat menawan; Dart adalah mesin bensin, aki, dan kabel transmisinya.
* **Fakta:** 90% bug aplikasi mobile disebabkan oleh kesalahan logika data, bukan karena salah memilih tombol UI!

### Slide 4: Variabel & Tipe Data Modern: var, final, dan const
* **Tipe Primitif:** `int`, `double`, `String`, `bool`, `var` (type inference).
* **Perbedaan Krusial:**
  * `final`: Nilainya dikunci satu kali saat program berjalan (runtime).
  * `const`: Nilainya sudah mutlak diketahui sejak sebelum kompilasi (compile-time). Menggunakan `const` pada widget statis menghemat RAM aplikasi!

### Slide 5: Sound Null Safety (Analogi Kotak Kado)
* **Konsep:** Memecahkan "Billion-Dollar Mistake" (Tony Hoare, 1965).
* **Non-nullable (`String nama`):** Kotak yang WAJIB ada isinya. Kompilator menolak nilai null.
* **Nullable (`String? catatan`):** Kotak yang BOLEH kosong/null menggunakan tanda tanya `?`.

### Slide 6: Operator Sakti Penjinak Null (`?.`, `??`, `!`, dan `late`)
* **Operator `?.` (Safe Navigation):** Mengakses properti hanya jika datanya tidak null (anti crash).
* **Operator `??` (Default Fallback):** Memberi nilai pengganti otomatis jika variabel null.
* **Operator `!` (Force Unwrap):** Memaksa program percaya bahwa data pasti ada (peringatan: bahaya crash!).
* **Kata Kunci `late`:** Janji kepada Dart bahwa variabel akan diisi nilainya sebelum dipakai.

### Slide 7: Sintaks Ringkas: Fat Arrow Functions (`=>`)
* **Konsep:** Singkatan resmi dari `{ return ...; }` untuk fungsi satu baris.
* **Penggunaan:** Sangat populer di seluruh widget Flutter (`void main() => runApp(...)` atau transformasi data).

### Slide 8: OOP Modern 1: Class, Constructor, & Named Parameters ({ })
* **Mengapa Named Parameters ({ }) Penting?**
  * Membungkus parameter dengan `{required this.nama, this.harga}`.
  * Parameter pemanggilan tidak akan pernah tertukar posisinya. Pola ini dipakai oleh 100% widget di Flutter!

### Slide 9: OOP Modern 2: Mixins (`with`)
* **Konsep:** Menggabungkan sekeranjang kemampuan tambahan ke dalam class tanpa pewarisan bertingkat yang kaku (*multiple inheritance alternative*).
* **Di Flutter:** Wajib digunakan saat membuat animasi (`SingleTickerProviderStateMixin`).

### Slide 10: OOP Modern 3: Extension Methods
* **Konsep:** Menambahkan method/fungsi baru pada class yang sudah ada (misal: `int.toRupiah()`) tanpa mengubah kode sumber aslinya.
* **Di Flutter:** Memudahkan pembuatan helper seperti `context.lebarLayar`.

### Slide 11: Koleksi Data 1: List, Map, dan Set
* **List<T>:** Daftar berurutan dan boleh duplikat (keranjang belanja/feed).
* **Map<K, V>:** Pasangan Key-Value (standar respon JSON dari REST API).
* **Set<T>:** Kumpulan data unik yang otomatis membuang nilai duplikat (kategori terpilih).

### Slide 12: Koleksi Data 2: Operasi Reaktif (`.map()` & `.where()`)
* **`.where()`:** Menyaring (filter) data berdasarkan kondisi tertentu.
* **`.map()`:** Mentransformasi setiap elemen data mentah menjadi bentuk baru (fondasi membentuk daftar widget).

### Slide 13: Sinkron vs Asinkron (Analogi Kasir Kafe)
* **Masalah Sinkron:** Kasir diam mematung menunggu kopi matang $\rightarrow$ antrean macet $\rightarrow$ aplikasi HP *freeze* (*Application Not Responding* / ANR).
* **Solusi Asinkron:** Kasir mencatat pesanan, memberi nomor antrean (`Future`), lalu langsung melayani pelanggan berikutnya tanpa jeda.

### Slide 14: Membedah Future dan async/await
* **`Future<T>`:** Bukti tanda terima bahwa data akan tiba beberapa saat lagi.
* **`async` & `await`:** Menunggu data server di latar belakang tanpa membekukan thread antarmuka.
* **`try-catch`:** Menangkap galat jika koneksi internet terputus secara aman (*graceful error handling*).

### Slide 15: Stream: Aliran Data Tanpa Henti (`async*` & `yield`)
* **Perbedaan Krusial:**
  * `Future`: Kurir paket belanja (datang 1 kali, tugas selesai).
  * `Stream`: Air keran / Siaran radio FM (data mengalir berkali-kali sepanjang waktu, misal: sensor GPS atau chat realtime).
  * Sintaks: Menggunakan `async*` dan kata kunci `yield`.

### Slide 16: Lab Quest Pertemuan 2 (Tantangan Praktikum 45 Menit)
* **Studi Kasus:** "Simulasi Antrean Cerdas Kafe Kampus & Stream Data".
* **Kriteria Sukses:**
  1. Class `Pesanan` dengan named parameters & fallback `??`.
  2. Fungsi asinkron `ambilResep()` dengan `Future.delayed(2 detik)`.
  3. Validasi harga dengan `Exception` dan penanganan `try-catch`.
  4. Stream data lacak pembuatan kopi dengan `async*` dan `yield`.
  5. Tunjukkan eksekusi di DartPad/VS Code tanpa crash!

---

# PERTEMUAN 03: Everything is a Widget (Seni Menyusun Layout & Tiga Pohon Flutter)

### Slide 1: Cover & Orientasi Sesi
* **Judul:** Everything is a Widget: Mastering Layout & Tiga Pohon Flutter.
* **Subjudul:** Membedah anatomi kanvas mobile, hierarki widget, box constraints, dan jurus membasmi galat overflow selamanya demi aplikasi responsif 120 FPS.

### Slide 2: Panduan Alat (Tools) Pengujian Hari Ini
* **Tujuan Pedagogis:** Mahasiswa langsung diarahkan ke target pengujian paling ringan tanpa membebani RAM PC lab.
* **Opsi A (Tercepat & Ringan):** `flutter run -d chrome` (Kompilasi kilat 5–10 detik via browser).
* **Opsi B (Sensasi HP Nyata):** Sambungkan kabel USB data smartphone, jalankan `scrcpy` dan `flutter run`.
* **Tips Hot Reload:** Cukup ubah kode di `lib/main.dart`, tekan `Ctrl + S`, layar langsung berganti dalam waktu $< 1$ detik!

### Slide 3: Filosofi "Everything is a Widget" (Analogi Balok Lego)
* **Widget Kasat Mata:** `Text()`, `ElevatedButton()`, `Image()`, `Icon()`.
* **Widget Tata Letak:** `SizedBox()`, `Padding()`, `Center()`, `Row()`, `Column()`.
* **Analogi Lego:** Aplikasi secanggih Gojek atau Tokopedia hanyalah gabungan ratusan balok Lego widget kecil yang disusun bertingkat ke dalam satu **Widget Tree**.

### Slide 4: Pondasi Kanvas: Mengapa Wajib Ada MaterialApp & Scaffold?
* **Peringatan Visual:** Menulis `Text()` langsung tanpa Scaffold menghasilkan layar hitam dengan teks bergaris bawah kuning ganda (*double yellow underlines*).
* **MaterialApp:** Gerbang utama yang mengatur arah teks (LTR), palet tema Material, dan rute.
* **Scaffold:** Kanvas dasar putih standar Android penyedia AppBar, Body, FloatingActionButton, dan Drawer.

### Slide 5: Di Balik Layar: Tiga Pohon Internal Flutter (The Three Trees Architecture)
* *Sitasi Resmi:* Google Flutter Architecture Overview (*flutter.dev/docs/resources/architectural-overview*).
* **1. Widget Tree:** Cetak biru (blueprint) immutabel yang murah dan dibuat ulang saat Hot Reload.
* **2. Element Tree:** Manajer siklus hidup yang mempertahankan identitas data (*state*).
* **3. RenderObject Tree:** Tukang gambar fisik yang menghitung ukuran piksel dan menggambarnya ke GPU.

### Slide 6: StatelessWidget vs StatefulWidget
* **StatelessWidget (Pasif/Hemat RAM):** Komponen diam yang tidak pernah berubah sendiri (contoh: kartu profil, judul, logo).
* **StatefulWidget (Dinamis/Reaktif):** Komponen hidup yang berubah wujud saat disentuh pengguna (contoh: sakelar Switch Dark Mode, input form, tombol counter belanjaan). Menggunakan `setState()`.

### Slide 7: Siklus Hidup StatefulWidget (Widget Lifecycle)
* **1. `initState()`:** Dipanggil 1 kali saat widget lahir. Tempat inisialisasi controller dan data awal. Dilarang memanggil API di dalam `build()`, taruh di sini!
* **2. `build()`:** Menggambar visual ke layar setiap kali data berubah (`setState`).
* **3. `dispose()`:** Dipanggil saat halaman ditutup. Wajib membersihkan controller agar terhindar dari *memory leak*.

### Slide 8: Hukum Emas Tata Letak Flutter (Box Constraints)
* *Aturan Resmi Flutter:*
  1. *Batasan (Constraints) turun dari Induk ke Anak.*
  2. *Ukuran (Sizes) naik dari Anak ke Induk.*
  3. *Induk menentukan Posisi (Position) Anak di layar.*

### Slide 9: Penyelamat Layar HP Berponi: Widget SafeArea
* **Masalah Fisik HP:** Smartphone modern memiliki notch kamera tompel dan bilah navigasi gesture. Tanpa SafeArea, konten antarmuka akan tertusuk kamera atau tertutup jam OS.
* **Solusi Instan:** Bungkus isi Scaffold body dengan widget `SafeArea()`.

### Slide 10: Single-Child Layout: Container, Padding, & Center
* **Center:** Menempatkan anak tepat di tengah.
* **Padding:** Hanya memberi jarak tepi tanpa beban komputasi berat.
* **Container:** Kotak serbaguna dengan margin, padding, warna, dan border tebal.

### Slide 11: Jebakan Klasik Lab: Error 'color' vs 'decoration'
* **Kesalahan Kompilasi Umum:** *"Cannot provide both a color and a decoration"*.
* **Aturan Emas:** Jika menggunakan `decoration: BoxDecoration()`, properti warna WAJIB dipindahkan ke dalam `BoxDecoration(color: ...)`.

### Slide 12: Multi-Child Layout: Row & Column (Sumbu Utama vs Sumbu Silang)
* **Row (Mendatar):** Sumbu Utama horizontal (X), Sumbu Silang vertikal (Y).
* **Column (Menurun):** Sumbu Utama vertikal (Y), Sumbu Silang horizontal (X).
* **Distribusi Spasi:** `MainAxisAlignment.spaceBetween`, `center`, `spaceAround`.

### Slide 13: Trik Spasi: SizedBox vs Spacer vs Expanded
* **1. `SizedBox(height: 16)`:** Spasi jeda statis tetap (seperti spasi ketukan keyboard).
* **2. `Spacer()`:** Pegas elastis yang mendorong elemen ke ujung berlawanan (misal: judul di kiri, tombol 'Lihat Semua' di kanan).
* **3. `Expanded(child: ...)`:** Membungkus widget agar mengisi sisa ruang yang tersedia tanpa memicu garis kuning overflow.

### Slide 14: Fleksibilitas Ukuran: Flexible vs Expanded
* **Expanded (Ketat / Tight):** Memaksa anak mengisi SELURUH sisa ruang yang tersedia tanpa ampun.
* **Flexible (Longgar / Loose):** Mengizinkan anak menyesuaikan ukurannya sendiri maksimal sebesar sisa ruang. `Expanded` sejatinya adalah `Flexible(fit: FlexFit.tight)`.

### Slide 15: Tata Letak Menumpuk: Stack & Positioned (Layering Ala Photoshop)
* **Stack:** Menumpuk elemen dari lapisan terbawah ke teratas.
* **Positioned:** Menempelkan elemen anak persis pada koordinat piksel tertentu (`top`, `right`, `bottom`, `left`).

### Slide 16: Penyelamat Kategori: Widget Wrap
* **Masalah:** Deretan tombol tag/kategori di dalam `Row` pasti memicu overflow ke kanan.
* **Solusi:** Widget `Wrap` yang otomatis menurunkan elemen ke baris baru seperti teks di Word.

### Slide 17: Scrollable 1: SingleChildScrollView (Anti Layar Macet)
* **Masalah:** `Column` statis tidak bisa digulir saat keyboard virtual HP muncul.
* **Solusi:** Bungkus `Column` dengan `SingleChildScrollView` agar formulir bisa digeser naik-turun.

### Slide 18: Scrollable 2: ListView.builder (Efisiensi 10.000 Data)
* **Bahaya Column:** Me-render seluruh 1.000 item sekaligus di RAM $\rightarrow$ HP panas dan OOM crash.
* **Solusi ListView.builder:** Menerapkan *Lazy Loading* (hanya menggambar yang tampak di layar). RAM tetap dingin di 120 FPS!

### Slide 19: Scrollable 3: GridView.builder (Katalog 2 Kolom Responsif)
* **Katalog Produk:** Menggunakan `SliverGridDelegateWithFixedCrossAxisCount` untuk membentuk grid 2 kolom dengan jarak `spacing` dan proporsi `childAspectRatio` yang rapi.

### Slide 20: Membasmi Mimpi Buruk 1: "RenderFlex Overflowed by X Pixels"
* **Penyebab:** Teks atau konten melebihi batas piksel fisik layar smartphone.
* **Solusi:** Bungkus teks dengan `Expanded` dan tambahkan `overflow: TextOverflow.ellipsis` agar terpotong anggun dengan tanda titik-titik `...`.

### Slide 21: Membasmi Bencana 2: "Vertical viewport was given unbounded height"
* **Penyebab:** Memasukkan `ListView` langsung ke dalam `Column` tanpa batas tinggi.
* **Solusi:** Bungkus `ListView` dengan `Expanded` agar mengisi sisa ruang secara pasti, atau pasang `shrinkWrap: true`.

### Slide 22: Rahasia Koding Cepat 1: Trik Koma Ajaib (Trailing Comma)
* **Masalah:** Kode memanjang ke kanan hingga ratusan karakter (*Bracket Hell* `))))`).
* **Solusi:** Selalu pasang koma `,` di setiap kurung penutup widget, lalu simpan (`Ctrl + S`). VS Code otomatis merapikannya menjadi pohon vertikal yang indah!

### Slide 23: Rahasia Koding Cepat 2: Shortcut 'Alt + Enter' & Flutter Inspector
* **Alt + Enter:** Refactor cepat instan tanpa pusing kurung buka/tutup (*Wrap with Padding*, *Row*, dsb.).
* **Flutter Inspector:** Mode "Penglihatan X-Ray" untuk memeriksa garis tepi biru (*Debug Paint*) langsung di atas layar ponsel.

### Slide 24: Lab Quest Pertemuan 3 (Tantangan Praktikum 60 Menit)
* **Studi Kasus:** "Membangun KTM Digital & Grid Menu Kampus".
* **Kriteria Sukses:**
  1. Terbungkus `SafeArea` rapi aman dari poni HP.
  2. Kartu KTM kuning Canary dengan border hitam Neo-Brutalism (0 radius).
  3. Badge stiker status aktif menggunakan `Stack & Positioned`.
  4. Teks nama panjang terbungkus `Expanded` + `TextOverflow.ellipsis` anti-overflow.
  5. Deretan tag keahlian terbungkus `Wrap`.
  6. Menu 4 ubin kampus menggunakan `GridView.builder` 2 kolom.
  7. Kode diformat rapi dengan trik *Trailing Comma* dan `Alt + Enter`.

---

# PERTEMUAN 04: Form Handling, Input Validation, & Navigasi Deklaratif GoRouter

### Slide 1: Cover & Orientasi Sesi
* **Judul:** Form Handling, Input Validation, & Navigasi Deklaratif GoRouter.
* **Subjudul:** Membangun Formulir Interaktif Bebas Kebocoran Memori, Validasi Regex Otomatis, dan Navigasi URL Modern Standar Industri 2026.
* **Capaian (Sub-CPMK 4):** Mahasiswa mampu membuat form interaktif dengan validasi masukan regex serta merancang arsitektur navigasi deklaratif menggunakan package `go_router`.

### Slide 2: Panduan Alat (Tools) & Persiapan Hari Ini (Persiapan Praktikum)
* **Buka Terminal VS Code:** Tekan shortcut `Ctrl + ~` (Control + Backtick).
* **Instalasi Otomatis:** Ketik `flutter pub add go_router` lalu tekan Enter. Pustaka terpasang otomatis tanpa risiko salah indentasi di `pubspec.yaml`.
* **Target Pengujian Cepat:** Ketik `flutter run -d chrome` untuk menjalankan di Google Chrome (hemat RAM lab & kompilasi instan 5 detik). URL browser langsung berganti secara visual saat navigasi berpindah.
* **Alternatif Smartphone Fisik:** Sambungkan kabel USB data smartphone, lalu jalankan `scrcpy` untuk sensasi papan ketik HP asli.
* **Kode Terminal & pubspec.yaml:**
  ```bash
  # 1. Buka terminal di VS Code (Ctrl + ~)
  # 2. Pasang library GoRouter versi resmi terbaru:
  flutter pub add go_router

  # 3. Jalankan aplikasi di browser Chrome (Paling ringan lab PC):
  flutter run -d chrome
  ```
* **Tips Praktikum:** Gunakan selalu `flutter pub add` di terminal daripada menyalin teks manual ke `pubspec.yaml` agar terhindar dari galat indentasi 2 spasi!

### Slide 3: Dua Jenis Input Teks: TextField vs TextFormField
* **Kapan Menggunakan `TextField`?** Sangat cocok untuk input mandiri tanpa validasi (misal: kolom pencarian *Search Bar* di AppBar).
* **Kapan Menggunakan `TextFormField`?** Wajib digunakan di formulir pendaftaran/login yang butuh pengecekan data sebelum dikirim.
* **Keunggulan `TextFormField`:** Jika isian salah, teks peringatan merah (*error text*) otomatis muncul tepat di bawah kotak input tanpa perlu `setState()` manual.
* **Terintegrasi dengan `Form`:** Mendukung fungsi pengecekan `validator`, penyimpanan `onSaved`, dan dapat divalidasi serentak lewat tombol Submit via `_formKey.currentState!.validate()`.
* **Contoh Kode:**
  ```dart
  // 1. TextField Sederhana (Untuk Kolom Pencarian):
  TextField(
    decoration: const InputDecoration(
      hintText: 'Cari nama mahasiswa...',
      prefixIcon: Icon(Icons.search),
    ),
    onChanged: (text) => print('Mencari: $text'),
  );

  // 2. TextFormField Cerdas (Untuk Formulir Validasi):
  TextFormField(
    decoration: const InputDecoration(labelText: 'Email Kampus'),
    validator: (val) {
      if (val == null || val.isEmpty) return 'Email wajib diisi!';
      return null; // Valid!
    },
  );
  ```
* **Tips Praktikum:** Jika ada tombol *Submit* atau *Kirim Data*, selalu gunakan `TextFormField`!

### Slide 4: Mengendalikan Input: TextEditingController (Anti-Bocor Memori)
* **Peran Controller:** Bertindak sebagai *remote control* untuk membaca isi teks (`_ctrl.text`), mengubah teks dari kode, atau mengosongkan kolom (`_ctrl.clear()`).
* **Penempatan:** Wajib dideklarasikan di dalam `StatefulWidget` pada level variabel kelas `State`.
* **Peringatan Bahaya Kebocoran Memori (*Memory Leak*):** Controller WAJIB dimatikan menggunakan `_ctrl.dispose()` di dalam blok `dispose()`. Jika lupa, objek controller akan tertinggal terus di RAM HP mahasiswa.
* **Contoh Kode:**
  ```dart
  class InputDemoState extends State<InputDemo> {
    // 1. Deklarasi Controller di awal kelas State:
    final _namaCtrl = TextEditingController();

    @override
    void dispose() {
      // 2. WAJIB dibersihkan saat halaman ditutup:
      _namaCtrl.dispose();
      super.dispose();
    }

    void _bacaInput() {
      // 3. Baca teks yang diketik pengguna:
      print('Nama yang diketik: ${_namaCtrl.text}');
    }
  }
  ```
* **Tips Praktikum:** Hafalkan aturan emas: Setiap `TextEditingController` yang Anda buat, WAJIB di-`dispose()`!

### Slide 5: Desain UX Input: InputDecoration, Hint, & Tipe Keyboard HP
* **`labelText`:** Label teks mengambang yang naik ke atas saat pengguna mulai mengetik.
* **`hintText`:** Contoh isian samar penunjuk format (misal: `'nama@mhs.kampus.ac.id'`).
* **`prefixIcon`:** Ikon pemanis di awal kolom (amplop untuk email, gembok untuk sandi).
* **`border`:** `OutlineInputBorder()` untuk memberi batas kotak tegas bergaya modern.
* **`keyboardType`:** Menyesuaikan papan ketik HP pengguna (angka murni, email dengan tombol `@`, atau telepon).
* **Contoh Kode:**
  ```dart
  TextFormField(
    controller: _emailCtrl,
    keyboardType: TextInputType.emailAddress, // Papan ketik ber-simbol @
    decoration: const InputDecoration(
      labelText: 'Email Mahasiswa',
      hintText: 'nama@mhs.kampus.ac.id',
      prefixIcon: Icon(Icons.email_outlined),
      border: OutlineInputBorder(), // Border kotak tegas
    ),
  );
  ```
* **Tips Praktikum:** Menyesuaikan `keyboardType` secara tepat menghindarkan pengguna HP dari kerumitan mencari simbol `@`!

### Slide 6: Interaktivitas Sandi: Fitur Intip Password Nyata (_isObscure)
* **Tantangan Implementasi:** Menghubungkan properti `obscureText` dengan tombol aksi interaktif untuk toggle visibilitas kata sandi.
* **Solusi Interaktif:** Buat variabel boolean `bool _isObscure = true;` di kelas State.
* **`suffixIcon`:** Pasang `IconButton` dengan ikon kondisional `_isObscure ? Icons.visibility : Icons.visibility_off`.
* **Aksi Sentuh:** Panggil `setState(() => _isObscure = !_isObscure);` saat ikon mata diklik.
* **Contoh Kode:**
  ```dart
  class _PasswordInputState extends State<PasswordInput> {
    bool _isObscure = true; // Status awal tersembunyi

    @override
    Widget build(BuildContext context) {
      return TextFormField(
        obscureText: _isObscure, // Dikendalikan boolean
        decoration: InputDecoration(
          labelText: 'Kata Sandi',
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() => _isObscure = !_isObscure); // Toggle bolak-balik
            },
          ),
        ),
      );
    }
  }
  ```
* **Tips Praktikum:** Fitur toggle intip sandi adalah standar wajib pada semua formulir login komersial modern!

### Slide 7: Menjinakkan Keyboard HP: Unfocus & Pindah Kolom Otomatis
* **Keluhan Populer Mahasiswa:** *"Pak, setelah saya klik Submit, kenapa keyboard virtual HP tetap muncul dan menutupi tombol/SnackBar?"*
* **Solusi Menutup Keyboard:** Panggil `FocusScope.of(context).unfocus()` tepat sebelum logika submit dijalankan.
* **Pindah Kolom Otomatis:** Pasang `textInputAction: TextInputAction.next` pada kolom awal agar tombol Enter di keyboard HP berubah menjadi panah 'Next'.
* **Contoh Kode:**
  ```dart
  // 1. Pindah otomatis ke kolom berikutnya saat tekan Enter HP:
  TextFormField(
    textInputAction: TextInputAction.next, // Ikon 'Next'
    decoration: const InputDecoration(labelText: 'Nama Lengkap'),
  );

  // 2. Tutup keyboard saat tombol Submit ditekan:
  void _onSubmit() {
    // Sembunyikan keyboard virtual seketika:
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      // Lanjutkan proses pendaftaran...
    }
  }
  ```
* **Tips Praktikum:** Selalu panggil `FocusScope.of(context).unfocus()` agar SnackBar dan tombol tidak terhalang keyboard virtual!

### Slide 8: Input Pilihan Form: DropdownButtonFormField
* **Kebutuhan Form:** Formulir pendaftaran tidak hanya teks, tapi juga pilihan pasti (misal: Program Studi, Jalur Masuk).
* **`DropdownButtonFormField<T>`:** Widget dropdown bawaan Flutter yang sudah terintegrasi langsung dengan ekosistem validasi `Form`.
* **Dukungan Validator:** Mendukung `validator` layaknya `TextFormField` dan otomatis menampilkan garis batas merah jika belum ada item terpilih.
* **Contoh Kode:**
  ```dart
  String? _selectedProdi;
  final List<String> _daftarProdi = ['Informatika', 'Sistem Informasi', 'Teknik Komputer'];

  DropdownButtonFormField<String>(
    value: _selectedProdi,
    decoration: const InputDecoration(labelText: 'Program Studi'),
    items: _daftarProdi.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
    onChanged: (val) => setState(() => _selectedProdi = val),
    validator: (val) {
      if (val == null || val.isEmpty) return 'Pilih Program Studi Anda!';
      return null; // Valid!
    },
  );
  ```
* **Tips Praktikum:** `DropdownButtonFormField` menghindarkan pengguna dari salah ketik nama jurusan/program studi!

### Slide 9: Pondasi Keamanan: Form Widget & GlobalKey<FormState>
* **Analogi Membumi:** Bayangkan widget `Form` adalah Map Berkas yang menampung seluruh formulir kertas.
* **`GlobalKey<FormState>`:** Stempel Legalisir di Meja Registrasi.
* **Satu Perintah Validasi:** Cukup panggil `_formKey.currentState!.validate()`, Flutter secara otomatis memeriksa SELURUH kolom di dalam map berkas sekaligus!
* **Perilaku:** Jika ada satu saja kolom yang salah atau kosong, proses submit dibatalkan dan teks teguran merah muncul seketika di bawah kolom tersebut.
* **Contoh Kode:**
  ```dart
  class RegistrasiPage extends StatefulWidget { ... }
  class _RegistrasiPageState extends State<RegistrasiPage> {
    // Stempel Kunci Form Terpusat:
    final _formKey = GlobalKey<FormState>();

    void _kirimFormulir() {
      // Periksa keabsahan seluruh kolom sekaligus:
      if (_formKey.currentState!.validate()) {
        print('Formulir LULUS validasi! Siap kirim ke server.');
      }
    }

    @override
    Widget build(BuildContext context) {
      return Form(
        key: _formKey, // Pasang kunci stempel di sini
        child: Column(children: [ ... ]),
      );
    }
  }
  ```
* **Tips Praktikum:** Selalu simpan `GlobalKey<FormState>` sebagai variabel `final` di kelas `State`.

### Slide 10: Logika Validator & Sanitasi Regex (Email & Sandi Kuat)
* **Aturan Nilai Kembalian:**
  * Jika masukan **VALID**: Fungsi wajib mengembalikan `null` (artinya tidak ada galat, lolos!).
  * Jika masukan **SALAH**: Fungsi mengembalikan `String` pesan teguran (otomatis tercetak merah di bawah input).
* **Regex Email Kampus:** Memastikan masukan menggunakan domain resmi `@mhs.kampus.ac.id`.
* **Pembersihan Spasi:** Gunakan `.trim()` sebelum validasi agar spasi yang tidak sengaja tertekan di awal/akhir tidak merusak data.
* **Contoh Kode:**
  ```dart
  TextFormField(
    controller: _emailCtrl,
    decoration: const InputDecoration(labelText: 'Email Kampus'),
    validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return 'Email tidak boleh kosong!';
      }
      // Regex pola email resmi mahasiswa kampus:
      final regex = RegExp(r'^[\w\.-]+@mhs\.kampus\.ac\.id$');
      if (!regex.hasMatch(value.trim())) {
        return 'Gunakan domain resmi: @mhs.kampus.ac.id';
      }
      return null; // LULUS VALIDASI!
    },
  );
  ```
* **Tips Praktikum:** Uji coba logika validator dengan memasukkan teks kosong dan format acak saat praktikum berlangsung!

### Slide 11: Umpan Balik Pengguna: SnackBar & ScaffoldMessenger
* **Prinsip Umpan Balik Pengguna:** Berikan konfirmasi visual seketika setelah pengguna menekan tombol aksi untuk kepastian status interaksi.
* **`ScaffoldMessenger.of(context).showSnackBar()`:** Menampilkan bilah notifikasi melayang di dasar layar ponsel.
* **Durasi Wajar:** Pasang `Duration(seconds: 2)` agar pengguna sempat membaca tanpa merasa terganggu.
* **Warna Komunikatif:** Hijau Mint untuk aksi sukses, dan Merah Coral untuk kegagalan koneksi / galat.
* **Contoh Kode:**
  ```dart
  void tampilkanSukses(BuildContext context, String nama) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.black),
            const SizedBox(width: 10),
            Text('Selamat Datang, $nama!',
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: const Color(0xFF4ADE80), // Hijau Mint Neo-Brutal
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
  ```
* **Tips Praktikum:** Pasang properti `behavior: SnackBarBehavior.floating` agar SnackBar melayang rapi di atas bilah bawah ponsel.

### Slide 12: Interaksi Sentuhan: GestureDetector vs InkWell
* **`GestureDetector`:** Pendeteksi sentuhan serbaguna (tap, double tap, drag, long press), namun bekerja secara mentah tanpa feedback visual bawaan.
* **`InkWell`:** Pendeteksi sentuhan khas Material Design yang memancarkan animasi riak air (*Ripple Splash Effect*).
* **Syarat Wajib `InkWell`:** Harus ditaruh di atas widget `Material` agar animasi riaknya terlihat jelas.
* **Sangat Cocok:** Untuk membuat tombol atau kartu interaktif berdesain Neo-Brutalism!
* **Contoh Kode:**
  ```dart
  // Kartu Interaktif Berdesain Neo-Brutalism:
  Material(
    color: const Color(0xFFFFE600), // Kuning Canary
    child: InkWell(
      onTap: () {
        print('Kartu pendaftaran diklik!');
      },
      splashColor: Colors.black26, // Efek riak air
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Text(
          'SUBMIT PENDAFTARAN',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    ),
  );
  ```
* **Tips Praktikum:** Selalu utamakan `InkWell` pada tombol dan kartu agar pengguna merasakan umpan balik sentuhan yang nyata.

### Slide 13: Mengapa Meninggalkan Navigator 1.0? (Imperative vs Declarative)
* **Keterbatasan Navigator 1.0 (Tradisional):** `Navigator.push()` mengelola tumpukan riwayat secara imperatif tertutup (*Imperative Stack*). Sangat sulit sinkron dengan URL web, rentan bentrok tombol *Back*, dan tidak mendukung penanganan *Deep Linking* secara langsung.
* **Solusi GoRouter (Standar Industri 2026):** Navigasi deklaratif berbasis URL yang terpusat (`/`, `/login`, `/buku/:id`).
* **Multi-Platform Bersatu:** Satu basis kode navigasi bekerja serentak di Android, iOS, Web, dan Desktop.
* **Sitasi Resmi:** Google Flutter Navigation Guide (*docs.flutter.dev/ui/navigation*).
* **Perbandingan Kode:**
  ```dart
  // CARA LAMA (NAVIGATOR 1.0 - IMPERATIF):
  // Navigator.push(context, MaterialPageRoute(builder: (ctx) => DetailPage()));
  // Kelemahan: URL web tidak sinkron, sulit Deep Linking!

  // CARA MODERN 2026 (GOROUTER - DEKLARATIF):
  // Rute didefinisikan terpusat berbasis alamat URL:
  // /           -> Beranda
  // /login      -> Halaman Masuk
  // /buku/:id   -> Detail Buku Spesifik

  // Berpindah semudah:
  context.go('/login'); // URL otomatis sinkron di browser!
  ```
* **Tips Praktikum:** Industri modern mewajibkan deklaratif routing agar aplikasi siap dirilis ke Web dan mendukung tautan promosi!

### Slide 14: Konfigurasi GoRouter & MaterialApp.router
* **Definisi Terpusat:** Buat variabel `final GoRouter appRouter = GoRouter(...)`.
* **`initialLocation`:** Alamat URL awal saat aplikasi pertama kali dibuka (biasanya `'/'`).
* **`routes`:** Daftar pasangan alamat `path` dengan widget tampilan `builder`.
* **`MaterialApp.router`:** Pasang `routerConfig: appRouter` menggantikan properti `home:` lama.
* **`errorBuilder`:** Halaman penyelamat 404 jika pengguna membuka URL yang salah atau rusak.
* **Contoh Kode:**
  ```dart
  final appRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(path: '/daftar', builder: (context, state) => const FormPage()),
    ],
    // Penanganan Galat Halaman 404 Terstruktur:
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('404: Rute ${state.uri} Tidak Ditemukan!')),
    ),
  );

  void main() {
    // Hubungkan router ke aplikasi utama:
    runApp(MaterialApp.router(routerConfig: appRouter));
  }
  ```
* **Tips Praktikum:** Halaman `errorBuilder` wajib dipasang agar aplikasi tidak mengalami layar abu-abu *crash* saat salah mengetikkan URL!

### Slide 15: Cara Berpindah Halaman: context.go() vs context.push()
* **`context.go('/rute')`:** Mengarahkan langsung ke URL tujuan dan merombak tumpukan rute (Cocok untuk: Selesai Login $\rightarrow$ Masuk Beranda, atau Ganti Tab Menu Bawah).
* **`context.push('/rute')`:** Menumpuk layar baru di atas layar saat ini (Cocok untuk: Buka Detail Transaksi atau Form Edit). Tombol panah kembali (*Back*) di AppBar otomatis aktif!
* **`context.pop()`:** Menutup layar aktif dan kembali ke layar sebelumnya.
* **Contoh Kode:**
  ```dart
  // Kasus 1: Selesai Login -> Masuk Beranda (Ganti Rute):
  void masukBeranda(BuildContext context) {
    context.go('/dashboard'); // Tidak bisa tekan 'Back' ke Login!
  }

  // Kasus 2: Klik Produk -> Buka Detail (Menumpuk Layar):
  void bukaDetail(BuildContext context) {
    context.push('/detail'); // Ada tombol panah 'Back' di AppBar
  }

  // Kasus 3: Tombol Tutup / Selesai:
  void kembali(BuildContext context) {
    context.pop(); // Menutup layar aktif saat ini
  }
  ```
* **Tips Praktikum:** Ingat rumus mudahnya: Ingin ada tombol panah *Back* otomatis di pojok kiri atas? Gunakan `context.push()`!

### Slide 16: Mengirim Data 1: Path Parameters (/buku/:id)
* **Format URL RESTful:** Gunakan tanda titik dua `/:id` pada path rute (contoh: `'/buku/:id'`).
* **Cara Berpindah:** Panggil `context.push('/buku/42')`.
* **Cara Membaca di Layar Tujuan:** Ambil nilai ID melalui `state.pathParameters['id']!`.
* **Tipe Data:** Nilai yang diterima selalu bertipe `String`. Jika membutuhkan angka, konversikan dengan `int.parse()`.
* **Contoh Kode:**
  ```dart
  // 1. Daftarkan rute dengan placeholder ':id':
  GoRoute(
    path: '/buku/:id',
    builder: (context, state) {
      // Ambil ID dari URL:
      final bookId = state.pathParameters['id']!;
      return DetailBukuScreen(idBuku: bookId);
    },
  );

  // 2. Berpindah dari layar katalog buku:
  void pilihBuku(BuildContext context, String id) {
    context.push('/buku/$id'); // Menuju '/buku/101'
  }
  ```
* **Tips Praktikum:** *Path Parameters* sangat ideal untuk *identifier* unik seperti NIM, ID Produk, atau Nomor Transaksi!

### Slide 17: Mengirim Data 2: Query Parameters & Extra Object
* **Query Parameters (`?keyword=`):** Menyematkan filter pencarian opsional pada URL (misal: `'/cari?keyword=flutter'`). Dibaca lewat `state.uri.queryParameters['keyword']`.
* **Extra Object (`extra`):** Mengirim objek class Dart utuh (misal: objek `Mahasiswa` dengan 10 atribut) tanpa repot dipecah menjadi string URL.
* **Cara Membaca:** Dibaca di halaman tujuan dengan: `state.extra as NamaModel`.
* **Contoh Kode:**
  ```dart
  // Mengirim objek Mahasiswa secara utuh:
  context.push(
    '/profil',
    extra: Mahasiswa(nim: '23001', nama: 'Adit', ipk: 3.85),
  );

  // Membaca objek di definisi rute GoRouter:
  GoRoute(
    path: '/profil',
    builder: (context, state) {
      final mhs = state.extra as Mahasiswa;
      return ProfilScreen(mahasiswa: mhs);
    },
  );
  ```
* **Tips Praktikum:** Gunakan `extra` saat Anda ingin mengirim objek data kompleks tanpa mengotori alamat URL browser!

### Slide 18: Rute Bersarang (Nested Routes) & StatefulShellRoute
* **Rute Bersarang (*Nested Routes*):** Menempatkan sub-rute di dalam properti `routes: [...]` milik parent `GoRoute` (`/katalog` $\rightarrow$ `detail/:id`).
* **URL Bersih:** URL browser otomatis menjadi hierarkis: `/katalog/detail/42`.
* **`StatefulShellRoute.indexedStack`:** Menjaga status tumpukan memori masing-masing tab Bottom Navigation Bar agar tidak ter-reset saat pengguna berpindah tab.
* **Contoh Kode:**
  ```dart
  // 1. Rute Bersarang (Nested Routes):
  GoRoute(
    path: '/katalog',
    builder: (ctx, state) => const KatalogScreen(),
    routes: [
      GoRoute(
        path: 'detail/:id', // URL menjadi: '/katalog/detail/42'
        builder: (ctx, state) => DetailScreen(id: state.pathParameters['id']!),
      ),
    ],
  );

  // 2. Navigasi Tab Bawah: StatefulShellRoute.indexedStack(...)
  ```
* **Tips Praktikum:** Gunakan nested routes agar struktur rute Anda mencerminkan susunan hierarki halaman aplikasi secara alami!

### Slide 19: Lab Quest Mandiri Pertemuan 04 (Tantangan 60 Menit)
* **Studi Kasus:** "Portal Registrasi Mahasiswa & Detail KTM Ber-GoRouter".
* **Alokasi Waktu:** 60 Menit.
* **Target Uji:** Browser Chrome (`flutter run -d chrome`) atau Smartphone Fisik.
* **Langkah Kerja & Spesifikasi Tugas:**
  1. Buka terminal di VS Code, pasang library: `flutter pub add go_router`.
  2. Buat Halaman Formulir Registrasi (`/daftar`) dibungkus widget `Form` dan `GlobalKey<FormState>`.
  3. Sediakan kolom: Nama Lengkap, Email Kampus (`@mhs.kampus.ac.id`), Sandi dengan toggle intip mata (`_isObscure`), dan Dropdown Program Studi.
  4. Pasang `TextEditingController` dan pastikan seluruh controller dibersihkan pada method `dispose()`.
  5. Tutup keyboard virtual dengan `FocusScope.of(context).unfocus()` saat tombol submit ditekan.
  6. Ketika submit sukses: Tampilkan SnackBar hijau dan navigasi ke `/ktm/:nim` menggunakan `context.push()` dengan membawa parameter NIM dan extra objek Mahasiswa.
  7. Halaman KTM (`/ktm/:nim`): Menampilkan kartu KTM digital bergaya Neo-Brutalism dengan tombol 'Kembali' menggunakan `context.pop()`.
  8. Tantangan Tambahan: Tambahkan penanganan galat `errorBuilder` halaman 404 jika ada URL yang sengaja diketik salah!
* **Target Selesai:** Alur pendaftaran berjalan mulus dari form ke kartu KTM, tervalidasi regex, bebas kebocoran memori (dispose aktif), keyboard menutup anggun, dan navigasi GoRouter bekerja sempurna di browser Chrome atau Smartphone!

---

# PERTEMUAN 05: Material Design 3 & Antarmuka Responsif Lintas Platform

---

### Slide 1: Cover Utama & Sub-CPMK 5
* **Mata Kuliah:** Pemrograman Piranti Bergerak (Flutter & Dart 2026).
* **Capaian Sub-CPMK 5:** Mahasiswa mampu mengimplementasikan sistem desain Material 3 dan merekayasa antarmuka responsif adaptif multi-layar (Smartphone, Tablet, Desktop Web).
* **Fokus Praktikum:** `colorSchemeSeed`, Dynamic Theming (Light/Dark/System), `LayoutBuilder`, Breakpoints resmi Google, dan Master-Detail Pattern.
* **Tautan Kode Sumber:** Tersedia 17 berkas mandiri siap run di folder `07_contoh_kode_program/pertemuan_05_material3_dan_responsive/`.

### Slide 2: Setup & Alat Uji: Menguji UI Responsif di Chrome (Hemat RAM & Anti-Lag)
* **💡 Analogi Simulator:** Daripada menyiksa laptop lab dengan emulator Android Studio yang berat bak helikopter, gunakan Google Chrome sebagai simulator instan yang super ringan!
* **Konsumsi Memori Rendah:** Cukup jalankan `flutter run -d chrome`. Konsumsi RAM <150MB sehingga perangkat laboratorium dengan spesifikasi standar tetap bekerja optimal.
* **↔️ Efek Karet Gelang:** Cukup tarik tepi kanan jendela peramban Chrome untuk menyimulasikan layar ponsel (<600dp), tablet (600–840dp), hingga layar monitor (>840dp).
* **⚡ Hot Reload Instan (<1 detik):** Memungkinkan iterasi desain responsif secara real-time tanpa restart emulator.
* **Contoh Kode:**
  ```dart
  // Membaca lebar layar peramban saat jendela di-resize:
  final screenWidth = MediaQuery.sizeOf(context).width;
  final isMobile = screenWidth < 600;
  print(isMobile ? 'Mode: Layar Ponsel' : 'Mode: Layar Tablet/PC');
  ```
* **Tips Praktikum:** Selalu gunakan browser Chrome selama merancang layout responsif untuk menghemat baterai laptop dan memori PC laboratorium!

### Slide 3: Desain Sistem M3: Filosofi Material 3 (Sudut Alami, Tombol, & 3 Varian Kartu)
* **🛋️ Analogi Furnitur Skandinavia:** M3 hadir layaknya sofa modern minimalis—tanpa sudut siku tajam menusuk, bayangan halus, dan warna menyejukkan.
* **🔘 Evolusi Tombol M3:** Gunakan `FilledButton` (aksi utama kontras), `FilledButton.tonal` (aksi sekunder lembut), dan `OutlinedButton`.
* **🃏 3 Varian Kartu M3:**
  1. `Card()`: Kartu melayang halus dengan elevasi bayangan (*Elevated*).
  2. `Card.filled()`: Kartu rata bernuansa warna tonal latar (*Filled*).
  3. `Card.outlined()`: Kartu rata dengan garis batas tepi halus (*Outlined*).
* **⚙️ Syarat Wajib:** Selalu aktifkan `useMaterial3: true` di dalam `ThemeData` agar seluruh komponen otomatis beralih ke standar modern 2026.
* **Contoh Kode:**
  ```dart
  MaterialApp(
    theme: ThemeData(
      useMaterial3: true, // Wajib diaktifkan!
      colorSchemeSeed: Colors.indigo,
    ),
    home: Scaffold(
      body: Column(
        children: [
          FilledButton(onPressed: () {}, child: const Text('Tombol Utama')),
          const Card(child: Text('Elevated Card')),
          Card.outlined(child: const Text('Outlined Card')),
        ],
      ),
    ),
  );
  ```
* **Tips Praktikum:** Gunakan `Card.outlined` untuk tampilan daftar data yang padat dan bersih, serta `FilledButton` untuk aksi simpan formulir!

### Slide 4: Palet Warna Dinamis: ColorScheme Seed & Aturan Kaus-Sablon (Prefix 'on')
* **🌱 Analogi Pohon Warna:** Cukup tanam 1 biji benih warna (`colorSchemeSeed: Colors.teal`), Google otomatis menumbuhkan 30+ paduan warna daun, dahan, bunga, dan bayangan yang serasi tanpa pusing memilih kode HEX manual.
* **👕 Aturan Kaus & Sablon (Prefix 'on'):** Kata `'on'` artinya 'di atas permukaan'. Jika kausnya berwarna gelap (`primary`), tinta sablon tulisan di atasnya wajib `onPrimary` (putih). Jangan pernah menyablon tulisan gelap di atas kaus gelap!
* **📦 Pasangan Kontainer:** Wadah warna kotak `primaryContainer` wajib dipadukan dengan warna teks `onPrimaryContainer`.
* **🎯 Panggilan Terpusat:** Ambil seluruh palet aktif di widget mana saja melalui `Theme.of(context).colorScheme`.
* **Contoh Kode:**
  ```dart
  final colors = Theme.of(context).colorScheme;

  Card(
    color: colors.primaryContainer, // Warna kotak kaus
    child: Text(
      'Teks Kontras Otomatis',
      style: TextStyle(color: colors.onPrimaryContainer), // Warna sablon
    ),
  );
  ```
* **Tips Praktikum:** Hukum Emas Kontras: Wadah warna `xyzContainer` WAJIB dipasangkan dengan teks `onXyzContainer` agar tulisan selalu terbaca jelas!

### Slide 5: Hirarki Tipografi: Skala TextTheme M3 (Anti-Hardcode & Peduli Lansia)
* **📰 Analogi Koran & Majalah:** Desain punya susunan rapi—Display (baliho depan), Headline (judul bab), Title (judul kartu), Body (isi bacaan).
* **🚫 Dilarang Keras:** Hindari menulis `fontSize: 24` manual! Ukuran kaku membuat teks tidak fleksibel terhadap setelan HP pengguna.
* **👓 Peduli Aksesibilitas:** Saat kakek/nenek memperbesar ukuran font HP (150%), `TextTheme` otomatis menyesuaikan diri tanpa merusak tampilan mata mereka.
* **📖 Standar Default:** Standar paragraf utama aplikasi Flutter adalah `bodyMedium` (14sp), nyaman dibaca di segala kerapatan piksel layar.
* **Contoh Kode:**
  ```dart
  final textTheme = Theme.of(context).textTheme;

  Text('Judul Layar', style: textTheme.titleLarge);
  Text('Judul Kartu', style: textTheme.titleMedium);
  Text('Isi Paragraf', style: textTheme.bodyMedium);
  Text('Keterangan Kecil', style: textTheme.labelSmall);
  ```
* **Tips Praktikum:** Selalu gunakan `Theme.of(context).textTheme` agar aplikasi Anda otomatis ramah bagi pengguna lansia!

### Slide 6: Theme Mode: Tema Dinamis Kacamata Transitions (Light, Dark, System)
* **🕶️ Analogi Lensa Transitions:** Bening saat di dalam ruangan, otomatis gelap sejuk saat di luar terik matahari. Begitu pula tema terang dan gelap.
* **🌙 Manfaat Mode Gelap:** Mengistirahatkan mata pengguna di malam hari dan menghemat konsumsi daya baterai layar OLED/AMOLED smartphone.
* **⚙️ Tiga Pasak Utama:** `MaterialApp` memiliki properti `theme` (terang), `darkTheme` (gelap), dan pengatur saklar `themeMode`.
* **🔄 Ikut Setelan HP:** `ThemeMode.system` akan otomatis mendeteksi apakah smartphone pengguna sedang mode gelap tanpa perlu tombol manual.
* **Contoh Kode:**
  ```dart
  MaterialApp(
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
      brightness: Brightness.light,
    ),
    darkTheme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
      brightness: Brightness.dark,
    ),
    themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
  );
  ```
* **Tips Praktikum:** Gunakan `SegmentedButton` untuk memberikan pilihan fleksibel: Mode Terang, Mode Gelap, atau Mengikuti Sistem OS!

### Slide 7: Responsif 1: MediaQuery (Sertifikat Luas Layar Global & Safe Area)
* **📐 Analogi Luas Tanah Rumah:** MediaQuery mengukur luas total seluruh bentang kaca layar HP dari ujung kiri atas ke kanan bawah.
* **📏 Membaca Dimensi:** `MediaQuery.sizeOf(context).width` dan `.height` mengembalikan lebar & tinggi total dalam satuan dp (*density-independent pixel*).
* **📱 Deteksi Poni & Keyboard:** MediaQuery juga mengetahui area terpotong kamera depan (Safe Area / `paddingOf`) dan kemunculan keyboard virtual.
* **⚠️ Batasan:** MediaQuery mengukur SELURUH layar fisik, bukan ruang sempit di dalam kartu atau dialog pop-up.
* **Contoh Kode:**
  ```dart
  // Membaca ukuran layar total:
  final size = MediaQuery.sizeOf(context);
  final isPortrait = MediaQuery.orientationOf(context) == Orientation.portrait;

  print('Lebar Layar Total: ${size.width} dp');
  ```
* **Tips Praktikum:** Gunakan `MediaQuery.sizeOf(context)` alih-alih `MediaQuery.of(context).size` untuk mencegah widget rebuild yang tidak perlu!

### Slide 8: Responsif 2: LayoutBuilder (Ruang Kosong Sudut Kamar untuk Lemari)
* **🚪 Analogi Lemari Sudut Kamar:** Lemari tidak peduli luas seluruh rumah (MediaQuery), yang penting berapa ruang kosong di sudut kamar!
* **📦 BoxConstraints:** LayoutBuilder memberikan `constraints.maxWidth`—lebar maksimum yang disiapkan oleh widget induk (*parent*).
* **🧩 Senjata Komponen Modular:** Satu kartu yang sama bisa otomatis tampil vertikal (Column) jika sempit, atau horizontal (Row) jika lapang.
* **👑 Hukum Emas Widget:** Jika Anda membangun widget modular/reusable, selalu gunakan LayoutBuilder, BUKAN MediaQuery!
* **Contoh Kode:**
  ```dart
  LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth < 500) {
        return const Column(children: [...]); // Vertikal
      } else {
        return const Row(children: [...]);    // Horizontal
      }
    },
  );
  ```
* **Tips Praktikum:** LayoutBuilder membuat komponen antarmuka Anda luwes ditempatkan di mana saja: di HP penuh, di tablet split-pane, maupun di pop-up modal!

### Slide 9: Breakpoints: Standar Ambang Layar Google (Ukuran Baju S, M, L)
* **👕 Analogi Ukuran Baju:** Tubuh punya ukuran baju S, M, L. Layar digital pun memiliki 3 klasifikasi standar industri resmi Google:
  1. **📱 S - Compact (< 600 dp):** Mayoritas smartphone posisi tegak (*portrait*). Tata letak 1 kolom sederhana.
  2. **📖 M - Medium (600 s.d. 840 dp):** Tablet kecil, HP lipat (*foldable*), atau HP miring (*landscape*). Tata letak 2 kolom.
  3. **🖥️ L - Expanded (> 840 dp):** Tablet besar, laptop, dan monitor desktop. Tata letak multi-kolom berdampingan.
* **Contoh Kode:**
  ```dart
  enum WindowSize { compact, medium, expanded }

  WindowSize getSizeClass(double width) {
    if (width < 600) return WindowSize.compact;  // Ukuran S (HP)
    if (width < 840) return WindowSize.medium;   // Ukuran M (Tablet)
    return WindowSize.expanded;                  // Ukuran L (Desktop)
  }
  ```
* **Tips Praktikum:** Nilai ambang batas standar: **600 dp** adalah garis pemisah antara tata letak Ponsel dan Tablet!

### Slide 10: Orientasi Layar: OrientationBuilder (Memutar Buku Sketsa Tegak vs Miring)
* **🎨 Analogi Buku Gambar:** Saat buku tegak kita menggambar ke bawah; saat dimiringkan kita menggambar melebar ke samping.
* **🔄 Reaksi Rotasi Layar:** `OrientationBuilder` mendengarkan perputaran HP secara instan dan membangun ulang antarmuka yang cocok.
* **📊 Adaptasi Grid Cerdas:** Ubah daftar dari 2 kolom (saat portrait) menjadi 4 kolom (saat landscape) agar ruang tidak terbuang sia-sia.
* **⌨️ Anti-Terpotong Keyboard:** Pada posisi landscape, tinggi layar sangat terbatas, pastikan elemen formulir dibungkus `SingleChildScrollView`.
* **Contoh Kode:**
  ```dart
  OrientationBuilder(
    builder: (context, orientation) {
      final isPortrait = orientation == Orientation.portrait;
      return GridView.count(
        crossAxisCount: isPortrait ? 2 : 4, // 2 kolom tegak, 4 kolom miring
        children: [...],
      );
    },
  );
  ```
* **Tips Praktikum:** Uji rotasi layar dengan shortcut Ctrl+F11 di emulator atau perkecil tinggi jendela browser Chrome!

### Slide 11: Navigasi Adaptif: Ergonomi Jangkauan Jempol (NavigationBar vs NavigationRail)
* **👍 Analogi Jangkauan Jempol:** Saat memegang HP satu tangan, jempol berada di bawah. Saat memegang tablet dua tangan di pinggir, jempol berada di sisi samping layar!
* **📱 Layar Ponsel (<600dp):** Gunakan `NavigationBar` di dasar layar agar navigasi mudah dijangkau satu tangan pengguna.
* **🖥️ Layar Tablet (>=600dp):** Pindahkan ke `NavigationRail` di sisi kiri layar untuk menghemat ruang vertikal yang sangat berharga.
* **🤝 Berbagi Halaman:** Keduanya berbagi `selectedIndex` dan daftar tujuan yang sama sehingga logika navigasi tidak perlu ditulis ulang.
* **Contoh Kode:**
  ```dart
  Scaffold(
    body: Row(
      children: [
        if (isTablet)
          NavigationRail( // Samping kiri di tablet
            selectedIndex: _idx,
            destinations: [...],
          ),
        Expanded(child: _pages[_idx]),
      ],
    ),
    bottomNavigationBar: isTablet ? null : NavigationBar(...), // Bawah di HP
  );
  ```
* **Tips Praktikum:** `NavigationRail` di sisi kiri membuat antarmuka tablet terlihat berkelas seperti aplikasi profesional iPad/Android Tablet!

### Slide 12: Layout Grid: Grid Responsif Dinamis (Rak Pajangan Toko Fleksibel)
* **🏪 Analogi Rak Toko:** Rak sempit memuat 2 produk, rak lebar memuat 4 hingga 6 produk tanpa membuat kemasan produk melar gepeng.
* **🚫 Jebakan Desain (Anti-Pattern):** Menulis `crossAxisCount: 2` secara statis. Pada layar tablet yang lebar, kartu produk akan meregang secara tidak proporsional!
* **🧮 Solusi Rumus Adaptif:** Tentukan jumlah kolom lewat rumus lebar: lebar <600 (1–2 kolom), <900 (3 kolom), >900 (4–6 kolom).
* **✨ Opsi Otomatis:** Atau gunakan `SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 220)`—Flutter yang menghitungkan kolomnya secara otomatis!
* **Contoh Kode:**
  ```dart
  int calculateColumns(double width) {
    if (width < 600) return 1; // Ponsel (1 kolom)
    if (width < 900) return 2; // Tablet (2 kolom)
    return 3;                  // Desktop (3 kolom)
  }

  GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: calculateColumns(constraints.maxWidth),
    ),
    itemBuilder: (ctx, i) => Card(...),
  );
  ```
* **Tips Praktikum:** Gunakan `maxCrossAxisExtent` jika Anda ingin ukuran kartu selalu konsisten di segala resolusi layar!

### Slide 13: Pola Arsitektur UI: Master-Detail (WhatsApp HP vs WhatsApp Web di Laptop)
* **💬 Analogi WhatsApp & Gmail:** Di HP, kita ketuk nama teman -> tumpukan layar ganti ke chat -> tekan tombol Back untuk kembali.
* **💻 Di Laptop/Tablet:** Daftar kontak (Master) di sisi kiri dan obrolan pesan (Detail) di sisi kanan tampil berdampingan dalam satu layar (*Split-Pane*).
* **⚡ Efisiensi 2x Lipat:** Pengguna tablet tidak perlu lelah bolak-balik menekan tombol 'Back' hanya untuk membaca rincian data.
* **🏛️ Standar Industri:** Pola arsitektur wajib untuk aplikasi e-commerce, portal berita, email, dan catatan transaksi keuangan.
* **Contoh Kode:**
  ```dart
  if (isTablet)
    Row(
      children: [
        SizedBox(width: 300, child: MasterList()), // Kiri: Daftar
        Expanded(child: DetailView(selectedItem)),  // Kanan: Rincian
      ],
    )
  else
    MasterList(); // Di ponsel: push() ke layar rincian baru
  ```
* **Tips Praktikum:** Pola Master-Detail meningkatkan produktivitas pengguna tablet hingga dua kali lipat!

### Slide 14: Widget Adaptif: Komponen .adaptive() (Colokan Adaptor Universal)
* **🔌 Analogi Steker Adaptor:** Satu colokan charger yang otomatis cocok di stopkontak Indonesia maupun stopkontak luar negeri tanpa adaptor tambahan.
* **🔄 Konstruktor '.adaptive()':** Flutter menyediakan komponen yang otomatis berubah bentuk mengikuti gaya asli sistem operasi perangkat.
* **🟢 `Switch.adaptive()`:** Tampil saklar Material 3 di Android/Web, dan saklar bulat hijau lonjong khas iOS di perangkat iPhone/iPad.
* **⏳ `CircularProgressIndicator.adaptive()`:** Berputar gaya Material di Android dan animasi pemintal abu-abu khas Cupertino di Apple iOS.
* **Contoh Kode:**
  ```dart
  // Saklar otomatis menyesuaikan Android / iOS:
  Switch.adaptive(
    value: _isActive,
    onChanged: (val) => setState(() => _isActive = val),
  );

  // Loading spinner otomatis bergaya native OS:
  CircularProgressIndicator.adaptive();
  ```
* **Tips Praktikum:** Gunakan `Switch.adaptive()` dan `Slider.adaptive()` agar aplikasi Anda berasa native di Android dan iPhone!

### Slide 15: Reusable Component: Reusable Component Kit (Balok LEGO Standar Berkualitas)
* **🧱 Analogi Balok LEGO:** Membangun istana megah dari balok LEGO standar yang rapi, bukan mencetak ulang cetakan plastik dari nol setiap saat!
* **🚫 Prinsip DRY (*Don't Repeat Yourself*):** Jangan menduplikasi kode kartu statistik berulang kali di berbagai berkas layar.
* **📦 Buat Widget Kustom:** Bungkus pola UI yang sering dipakai ke dalam `StatelessWidget` tersendiri (misal: `StatCard`).
* **🎨 Desain Token Terpusat:** Selalu ambil warna dari `Theme.of(context).colorScheme` agar kartu otomatis berubah saat tema berganti.
* **Contoh Kode:**
  ```dart
  class StatCard extends StatelessWidget {
    final String title;
    final String value;
    final IconData icon;

    const StatCard({
      super.key,
      required this.title,
      required this.value,
      required this.icon,
    });

    @override
    Widget build(BuildContext context) {
      return Card(child: ListTile(...));
    }
  }
  ```
* **Tips Praktikum:** Komponen reusable yang bersih memudahkan pembagian tugas antar anggota kelompok proyek!

### Slide 16: Aksesibilitas & Font: FittedBox Scaling (Koper Pakaian Berkemasan Vakum)
* **🧳 Analogi Koper Vakum:** Saat baju terlalu tebal, kantong vakum mengempiskannya agar tetap muat rapi di dalam koper tanpa merusak resleting.
* **💥 Masalah Nyata:** Kakek/nenek menyetel pembesaran font HP 150% -> angka saldo bank `Rp 999.999.999,-` meledak memicu overflow garis kuning-hitam!
* **🛡️ Solusi Anggun:** Bungkus teks dengan widget sakti: `FittedBox(fit: BoxFit.scaleDown)`.
* **✨ Menyusut Otomatis:** Teks akan otomatis menyusut anggun jika ruang terbatas, dan tetap berukuran normal jika ruang tersedia cukup.
* **Contoh Kode:**
  ```dart
  Container(
    width: 200,
    child: FittedBox(
      fit: BoxFit.scaleDown, // Otomatis menyusut jika kepanjangan
      child: Text(
        'Rp 999.999.999,-',
        style: TextStyle(fontSize: 32),
      ),
    ),
  );
  ```
* **Tips Praktikum:** Wajib pasang FittedBox pada label harga, saldo dompet, nomor rekening, dan kartu identitas!

### Slide 17: Checklist Produksi: 5 Aturan Emas Desain UI Responsif (Checklist Penilaian UTS)
* **1. Dilarang Hardcode Dimensi:** Hindari menulis `width: 380`, gunakan Expanded, Flexible, atau LayoutBuilder.
* **2. Hormati Breakpoint Sakral 600dp:** Bedakan tata letak 1 kolom untuk ponsel dan multi-kolom untuk tablet.
* **3. Navigasi Adaptif Ergonomis:** Bottom NavigationBar di ponsel, Side NavigationRail di tablet.
* **4. Lolos Uji Rotasi Layar:** Pastikan antarmuka tidak terpotong saat layar dimiringkan horizontal.
* **5. Kontras Warna Sempurna:** Pastikan teks terbaca jelas di Tema Terang maupun Tema Gelap.
* **Contoh Kode:**
  ```dart
  // Checklist Uji Praktikum Responsif Standar 2026:
  // [✓] Tampilan bebas dari overflow garis kuning-hitam
  // [✓] Navigasi pindah ke samping saat layar melebihi 600dp
  // [✓] Tombol dan kartu menggunakan token warna Material 3
  // [✓] Berjalan mulus di Chrome Web & Smartphone Fisik
  ```
* **Tips Praktikum:** Jadikan kelima checklist ini sebagai acuan penilaian proyek UTS kelompok Anda agar meraih nilai A!

### Slide 18: Lab Quest Mandiri: Dashboard Akademik Responsif 60 Menit
* **🎯 Misi:** Bangun Dashboard Mahasiswa yang otomatis beradaptasi saat diuji di Chrome (lebar <600dp ponsel vs >=600dp tablet).
* **🧭 Navigasi Adaptif:** Tampilkan `NavigationBar` di bawah untuk ponsel, dan `NavigationRail` di samping kiri untuk tablet.
* **🌓 Toggle Tema Instan:** Sediakan tombol di AppBar untuk beralih antara Mode Terang dan Mode Gelap secara instan.
* **📊 Grid Akademik:** Tampilkan kartu menu KRS, Nilai, Jadwal, dan Presensi dalam 2 kolom (ponsel) dan 4 kolom (tablet).
* **📏 Indikator Layar Real-time:** Tampilkan lebar layar aktif saat ini dalam satuan dp menggunakan `MediaQuery.sizeOf(context)`.
* **🚀 Cara Uji:** Jalankan `flutter run -d chrome` lalu tarik pinggir jendela browser untuk melihat keajaiban antarmuka adaptif!
* **Contoh Kode:** Tersedia lengkap di `slide_18_lab_quest_dashboard_responsif.dart`.
* **Tips Praktikum:** Klik tombol kuning di slide presentasi untuk membuka kode lengkap Lab Quest di GitHub!

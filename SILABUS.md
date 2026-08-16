# Silabus Fullstack Mobile Developer dengan Flutter™ SDK

Tiap bab mulai dari *mengapa* dulu, baru *bagaimana*, lalu latihan kecil. Istilah teknis tetap ditulis dalam bahasa aslinya, lalu dijelaskan.

Targetnya: nanti Anda bisa merancang, membangun, dan menerbitkan aplikasi mobile yang punya **tampilan (frontend)** dan **server/data (backend)**.

Flutter and the related logo are trademarks of Google LLC. We are not endorsed by or affiliated with Google LLC.

---

## Status penulisan

| Modul | Berkas | Status |
| --- | --- | --- |
| 00 Persiapan | [modul-00-persiapan/README.md](modul-00-persiapan/README.md) | Selesai |
| 01 Dart | [modul-01-dart/README.md](modul-01-dart/README.md) | Selesai |
| 02 Flutter UI | [modul-02-ui/README.md](modul-02-ui/README.md) | Selesai |
| 03 Interaksi & form | [modul-03-interaksi/README.md](modul-03-interaksi/README.md) | Selesai |
| 04 State (Provider) | [modul-04-state/README.md](modul-04-state/README.md) | Selesai |
| 05 Data lokal | [modul-05-data-lokal/README.md](modul-05-data-lokal/README.md) | Selesai |
| 06 Firebase | [modul-06-firebase/README.md](modul-06-firebase/README.md) | Selesai |
| 07 REST API | [modul-07-rest/README.md](modul-07-rest/README.md) | Selesai |
| 08 Fitur app | [modul-08-fitur/README.md](modul-08-fitur/README.md) | Selesai |
| 09 Kualitas | [modul-09-kualitas/README.md](modul-09-kualitas/README.md) | Selesai |
| 10 Rilis | [modul-10-rilis/README.md](modul-10-rilis/README.md) | Selesai |
| 11 Capstone | [modul-11-capstone/README.md](modul-11-capstone/README.md) | Selesai |
| L1 Lokasi & peta | [lampiran/l1-lokasi-peta/README.md](lampiran/l1-lokasi-peta/README.md) | Selesai |
| L2 Pembayaran | [lampiran/l2-pembayaran/README.md](lampiran/l2-pembayaran/README.md) | Selesai |
| L3–L9 | — | Menyusul, urut silabus |

Diperbarui: 16 Agustus 2026.

---

## Pola yang selalu ada di tiap modul

Supaya tidak perlu menebak alat, tiap modul memakai pola yang sama:

1. **Tabel "Buka alat ini dulu"** di bagian atas.
2. Setiap perintah punya kotak: buka apa, ketik apa, apa tanda berhasil.
3. Sintaks Dart diuji di [DartPad](https://dartpad.dev) dulu, kecuali topik itu memang membutuhkan emulator atau HP.
4. Perintah `flutter` / `git` / `dart` lokal diketik di **Terminal VS Code** (`Ctrl + J`), bukan di DartPad, bukan di pencarian Windows.
5. Sumber gambar dicantumkan di akhir modul dan di [docs/SUMBER-GAMBAR.md](docs/SUMBER-GAMBAR.md).
6. Nada percakapan, sapaan **Anda**, ejaan *silakan*.
7. Kode yang diuji di DartPad ditulis sebagai **berkas lengkap**. Potongan tanpa `main()` ditandai **cuplikan**.

---

## Jawaban jujur soal "apakah ada yang kurang?"

**Tidak ada silabus yang pernah 100% lengkap.** Flutter, Play Store, dan paket berubah setiap tahun. Yang bisa dijamin hanya ini:

> Gelombang pertama menutup skill yang sering bikin proyek macet, dan skill yang wajib ada agar hasilnya pantas disebut fullstack mobile.

Audit kedua (setelah revisi pertama) masih menemukan lubang **wajib**. Lubang itu sudah dimasukkan ke modul di bawah. Setelah file ini, **daftar modul wajib dibekukan**. Topik baru masuk lampiran atau gelombang 2, kecuali kebijakan Play/Flutter mengubah syarat rilis.

| Status | Artinya |
| --- | --- |
| Wajib | Tanpa ini, alur kerja macet atau hasilnya bolong |
| Lampiran | Sering muncul di kerjaan, bukan syarat lulus |
| Ditunda | Sengaja tidak diajarkan sekarang |
| Ekor panjang | Tidak akan dimasukkan: maps lanjutan, ML, IAP dalam, CI penuh, iOS dari Windows, dst. |

---

## Cara baca silabus ini

| Istilah | Artinya |
| --- | --- |
| **Frontend** | Tampilan aplikasi yang disentuh orang: tombol, halaman, animasi |
| **Backend** | "Dapur" aplikasi: data, login, penyimpanan, aturan bisnis |
| **Fullstack mobile** | Anda mengerjakan keduanya: UI Flutter + layanan data di belakangnya |
| **Mini project** | Latihan singkat di akhir modul |
| **Capstone** | Proyek akhir yang menggabungkan semua modul |
| **Lampiran** | Boleh dilewati di gelombang pertama, tetap ada di repo |

Estimasi total: **14–18 minggu** jika belajar 8–10 jam per minggu. Boleh lebih lambat. Yang penting selesai berurutan.

---

## Peta belajar (urutan wajib)

```
0. Persiapan alat + Git + cara belajar
1. Dart (bahasa)
2. Flutter UI
3. Navigasi & form
4. State management
5. Data lokal & kondisi HP
6. Backend dengan Firebase
7. REST API (client–server)
8. Auth, izin, file, notifikasi
9. Kualitas: UX, error, testing
10. Rilis ke Play Store
11. Proyek akhir
```

Lampiran (tidak wajib urut): lokasi/peta, pembayaran, Supabase, Crashlytics, update paksa, biometrik, QR.

Jangan loncat modul wajib. Flutter terasa mudah kalau fondasinya urut.

---

## Modul 0 — Persiapan: buka "bengkel" dulu

**Tujuan:** komputer siap, arahnya jelas, dan error instalasi bisa ditelusuri sendiri.

1. Apa itu mobile app, dan bedanya dengan website
2. Kenapa Flutter: satu kode untuk Android + iOS
3. **Penting untuk Windows:** dari Windows Anda bisa build Android. Build iOS butuh Mac. Materi ini tetap mengajarkan konsep iOS, tapi praktik rilis fokus ke Play Store
4. Instalasi: Git, VS Code, Flutter SDK, Android Studio / command-line tools, emulator
5. Perintah pertama: `flutter doctor` sampai semua hijau + cara baca pesan merah
6. USB debugging di HP fisik (mode developer)
7. Hot reload vs hot restart vs full rebuild (kapan pakai yang mana)
8. Struktur folder proyek Flutter (yang mana yang boleh diubah)
9. `pubspec.yaml`: nama paket, aset, dan cara menambah package (`flutter pub add`)
10. Git dasar: `clone`, `status`, `add`, `commit`, `push` (karena materi ini memang akan masuk GitHub)
11. Git cukup sampai di situ dulu: kerja di `main`. Branch dibahas 1 halaman, tidak dipaksa
12. Cara baca dokumentasi Flutter/Dart (jangan hapal, belajar mencari)
13. Analogi internet 2 menit: HP = tamu, server = dapur, JSON = nota pesanan (detail di Modul 7)

**Mini project:** aplikasi "Halo, namaku ..." lalu di-commit dan di-push ke repo latihan.

**Hasil:** lingkungan kerja jalan, Git tidak asing, error instalasi bisa Anda telusuri sendiri.

---

## Modul 1 — Dart: bahasa yang dipakai Flutter

**Tujuan:** bisa menulis logika sederhana, dan **bisa membaca** kode Flutter sungguhan.

1. Variabel, tipe data, dan kenapa tipe itu penting
2. Kondisi (`if`) dan perulangan (`for`)
3. Fungsi: named vs positional parameter
4. List, Map, Set — data "sekumpulan"
5. **Generics singkat:** kenapa tertulis `List<String>` dan `Future<User>` (tanpa ini, dokumentasi terasa bahasa alien)
6. **Spread & collection-if:** `...` dan `if` di dalam list (sering muncul di widget)
7. Null safety: cara Dart mencegah data kosong merusak app
8. Class & object: cetakan vs barang jadi (analogi kue)
9. Enum: pilihan terbatas (contoh: status pesanan)
10. `import`: meminjam kode dari file / package lain
11. `try/catch`: ketika sesuatu gagal, app tidak langsung "meledak"
12. `async` / `await`: menunggu data tanpa membuat app macet
13. **DateTime:** lokal vs UTC — sumber bug "jamnya geser 7 jam"

**Mini project:** program kasir mini di terminal (hitung total belanja + diskon + error jika input bukan angka).

**Hasil:** Anda bisa baca kode Dart, menulis fungsi, dan menangani kesalahan sederhana.

---

## Modul 2 — Flutter UI: merakit tampilan

**Tujuan:** paham bahwa di Flutter **semua adalah widget**.

1. Widget = lego. `Text`, `Image`, `Container`, `Icon`
2. `StatelessWidget` vs `StatefulWidget` (diam vs bisa berubah)
3. Layout: `Row`, `Column`, `Stack`, `Padding`, `Expanded`
4. **SafeArea & MediaQuery** — biar konten tidak ketutup notch / status bar
5. **Keyboard overflow** — penyebab klasik layar "kuning-hitam" saat form dibuka
6. Material Design 3: AppBar, Scaffold, tombol, kartu, **Drawer**
7. Warna, font, tema, **mode gelap** (`ThemeMode`)
8. Font kustom / `google_fonts` (1 contoh, tidak koleksi 20 font)
9. **Skalasi teks:** HP dengan huruf besar tidak boleh merusak layout
10. List: **`ListView.builder`** (wajib) vs `ListView(children: ...)` (hanya untuk list pendek)
11. `Key` pada item list: biar Flutter tidak tertukar baris saat data berubah
12. `const` constructor: hemat rebuild, kebiasaan sejak awal
13. Animasi implisit 1 contoh: `AnimatedContainer` (cukup, bukan animation controller)
14. Aset: gambar, ikon, splash sederhana
15. Widget Inspector: melihat "pohon" widget saat debug

**Mini project:** kartu profil (foto, nama, bio, 3 tombol sosial) yang tidak pecah di HP kecil dan tetap terbaca saat font sistem dibesarkan.

**Hasil:** Anda bisa merakit halaman statis yang rapi dan tidak takut error layout.

---

## Modul 3 — Interaksi, form, dan pindah halaman

**Tujuan:** app bereaksi saat disentuh.

1. Gesture: tap, long press, swipe. `InkWell` vs `GestureDetector`
2. Form: `TextField`, validasi, keyboard type, scroll saat keyboard muncul
3. **Widget form yang sering terlewat:** Dropdown, Checkbox, Switch, DatePicker, TimePicker
4. **FocusNode:** pindah ke input berikutnya, tombol "selesai" di keyboard
5. **TextInputFormatter:** angka, nomor HP, tidak bisa ketik huruf di kolom harga
6. Dialog, SnackBar, BottomSheet (cara "bicara" ke user)
7. `Dismissible`: geser untuk hapus (pola daftar catatan / chat)
8. Navigasi dasar: `Navigator` (konsep dulu, supaya tidak misterius)
9. **go_router** sebagai cara yang dipakai di sisa materi (pola modern, dalam, back button)
10. **PopScope:** tombol back Android (jangan keluar app tanpa sengaja)
11. Mengirim data antar halaman (contoh: daftar → detail)
12. Bottom navigation & tab (pola app modern)
13. Splash singkat + onboarding 2–3 layar (pola produk, bukan animasi rumit)

**Mini project:** app catatan 2 halaman (daftar + form tambah + tanggal + geser-untuk-hapus) memakai go_router.

**Hasil:** alur halaman terasa seperti aplikasi sungguhan.

---

## Modul 4 — State management: siapa yang ingat data?

**Tujuan:** data tidak "hilang" saat pindah halaman, kode tidak berantakan.

1. Apa itu state (ingatan aplikasi saat ini)
2. `setState` — cukup untuk app kecil, kapan harus berhenti
3. Lift state up: data naik ke widget induk
4. **FutureBuilder & StreamBuilder** — menampilkan data yang masih loading
5. Provider (pilihan utama materi ini: API-nya lurus, cukup untuk pola yang diajarkan)
6. `context.read` / `watch` / `Consumer` / `Selector` — biar tidak seluruh layar ikut rebuild
7. Sekilas Riverpod & Bloc: kapan dipakai, tanpa memaksa
8. **Peringatan audiens Indonesia:** banyak tutorial memakai GetX. Materi ini **tidak** memakai GetX sebagai standar (alasan dijelaskan di modul, bukan dicela tanpa alasan)
9. Folder architecture sederhana: `ui / data / services`
10. Aturan: UI tidak memanggil internet / database secara langsung

**Mini project:** keranjang belanja (tambah, kurang, total selalu benar) + status loading palsu.

**Hasil:** Anda punya pola menyimpan data yang bisa dipakai di proyek besar.

---

## Modul 5 — Data lokal & kondisi HP

**Tujuan:** app tetap ingat data, dan tetap sopan saat sinyal hilang.

1. Dua jenis "ingatan": pengaturan kecil vs database vs rahasia
2. SharedPreferences: pengaturan kecil (tema gelap, flag onboarding) — **bukan untuk token/password**
3. **`flutter_secure_storage`:** tempat token login (keystore / Keychain)
4. `path_provider`: di mana file boleh disimpan di HP
5. File lokal: simpan gambar / JSON
6. SQLite / Drift: database mini di dalam HP
7. **Migrasi singkat:** kalau tabel berubah, data lama jangan hilang
8. Kapan pakai mana (aturan praktis, bukan teori berat)
9. Model data: dari `Map` ke class (`fromJson` / `toJson`)
10. **Koneksi internet:** deteksi online/offline, tampilan "tidak ada sinyal"
11. Siklus hidup app singkat: pause / resume (contoh: jeda dulu, lanjut lagi)

**Mini project:** to-do list yang tetap ada setelah app ditutup, plus banner jika offline.

**Hasil:** app offline-first untuk fitur dasar, tanpa menyimpan rahasia di tempat yang salah.

---

## Modul 6 — Backend pertama: Firebase

**Tujuan:** punya "dapur" tanpa harus sewa server sendiri dulu.

Kenapa Firebase dulu? Jalan tercepat merasakan fullstack: login, database, file, tanpa operasi server sendiri.

1. Apa itu BaaS (Backend as a Service)
2. **SQL vs NoSQL** dalam 1 analogi (Excel rapi vs lemari map) — baru kemudian Firestore
3. Firebase project: Android app, `google-services.json`
4. Firestore: koleksi & dokumen (analogi lemari → map → kertas)
5. CRUD: Create, Read, Update, Delete dari Flutter
6. Query sederhana: `where`, `orderBy`, limit (dan kenapa kadang butuh index)
7. **Transaksi & batch:** stok/kasir tidak boleh "lomba" sampai angka rusak
8. Rules keamanan dasar: jangan biarkan data publik
9. Storage: unggah foto profil
10. Listener realtime + StreamBuilder: data berubah, UI ikut berubah
11. Offline persistence Firestore (konsep: app masih bisa baca cache)
12. Biaya singkat: kenapa jangan "dengarkan seluruh koleksi" tanpa batas
13. **Aturan fullstack:** harga, stok, hak admin **tidak boleh hanya dicek di HP**. Pengenalan Cloud Functions (1 fungsi "halo", bukan arsitektur besar)
14. Jangan ajarkan Dynamic Links (sudah deprecated)

**Mini project:** buku tamu online (tulis, daftar realtime, aturan: hanya pemilik yang boleh hapus).

**Hasil:** app terhubung ke cloud, bukan hanya data di HP.

---

## Modul 7 — REST API: bahasa universal client–server

**Tujuan:** Anda tidak tergantung Firebase saja. Paham cara app bicara ke server mana pun.

1. HTTP: GET, POST, PUT, DELETE (pesan yang sopan ke server)
2. JSON: format "surat" antara app dan backend
3. Status code: 200, 401, 404, 429, 500 (arti untuk pengguna)
4. Package `dio` (+ interceptor singkat)
5. **Token JWT / Bearer:** menaruh "tanda pengenal" di header, disimpan di secure storage
6. **401:** token kedaluwarsa — konsep refresh, tanpa membuat sistem auth bank
7. Repository pattern: UI tidak boleh "teriak" langsung ke internet
8. Error handling: timeout, tidak ada sinyal, data rusak
9. **Pagination:** jangan unduh 10.000 data sekaligus
10. Multipart: kirim file ke API
11. `.env` / `--dart-define`: kunci API tidak ditulis telanjang di kode
12. CORS & HTTPS: kenapa kadang "di browser boleh, di HP tidak" (konsep, tidak dalam-dalam)
13. **Tes API di luar app** (Thunder Client / Postman): buktikan server benar sebelum menyalahkan Flutter
14. Validasi harus ada di server, bukan hanya di form HP
15. Backend sendiri, tetap terfokus: **satu resource CRUD lengkap** (bukan cuma 1 endpoint) — contoh: Node.js + Express + daftar catatan
16. **Deploy 1 kali:** unggah backend mini ke layanan gratis/murah (Render / Railway) supaya HP fisik bisa mengakses, bukan hanya `localhost`

**Mini project:** app daftar film/berita dari API publik + halaman berikutnya (pagination). Latihan bonus: CRUD catatan ke backend mini yang sudah di-deploy.

**Hasil:** Anda bisa menyambungkan Flutter ke API apa saja, menguji API tanpa app, dan paham isi "dapur" sederhana yang hidup di internet.

---

## Modul 8 — Fitur "app sungguhan"

**Tujuan:** login, hak akses, izin HP, file, dan pemberitahuan.

1. Autentikasi: email/password, Google Sign-In
2. **Verifikasi email + reset password** (tanpa ini, login belum lengkap)
3. Session: siapa yang sedang login, kapan harus logout (token di secure storage)
4. Role sederhana: user vs admin (dicek juga di rules / server, bukan hanya di UI)
5. **Izin HP:** kamera, galeri, notifikasi — `permission_handler` + AndroidManifest / penjelasan Info.plist
6. Unggah & tampilkan gambar (kamera + galeri)
7. Kompres gambar sebelum unggah (hemat kuota & uang storage)
8. Tampilkan gambar jaringan dengan cache (`cached_network_image`)
9. **Dua jenis notifikasi:** lokal (pengingat di HP) vs push (FCM dari server)
10. FCM: beda perilaku saat app terbuka / di belakang / ditutup + **notification channel** Android
11. Deep link singkat: buka halaman tertentu dari luar app (App Link konsep, bukan Dynamic Links)
12. (Opsional Indonesia) OTP / nomor HP: dikenalkan, tidak wajib dikuasai

**Mini project:** app komunitas mini (daftar, verifikasi, login, posting teks + foto, 1 pengingat lokal, logout).

**Hasil:** Anda menguasai alur yang dipakai hampir semua produk mobile.

---

## Modul 9 — Kualitas: biar tidak cuma "jalan di HP saya"

**Tujuan:** app terasa profesional, tidak mudah rusak.

1. UX mobile: ukuran sentuh, loading, empty state, error state
2. Responsif: HP kecil vs tablet (tanpa over-engineering)
3. Loading & skeleton, pull-to-refresh, infinite scroll sederhana
4. Format lokal Indonesia: **Rupiah** dan **tanggal** (`intl`), termasuk zona waktu
5. Logging sederhana dan cara baca error merah / stack trace
6. `dart format`, lints, dan aturan penamaan file/variabel
7. Unit test & widget test (cukup yang penting, bukan 100% coverage)
8. Mock repository: tes logika tanpa internet
9. Satu integration test: alur login palsu atau tambah item
10. Build mode: debug vs release
11. Keamanan dasar: jangan simpan rahasia di kode, HTTPS, rules Firebase, `.gitignore`, token hanya di secure storage
12. Privasi singkat: **UU PDP** — data pengguna bukan milik kita untuk disebar

**Mini project:** rapikan 1 app lama: empty state + error + loading + harga dalam Rupiah.

**Hasil:** Anda mulai berpikir seperti developer yang merilis produk, bukan hanya demo.

---

## Modul 10 — Rilis: dari laptop ke Play Store

**Tujuan:** orang lain bisa mengunduh app-mu, dan lolos kebijakan toko saat ini.

1. App icon, nama, package name, versioning (`1.0.0+1`)
2. Signing key (keystore) — simpan baik-baik
3. **Play App Signing** vs upload key (penyebab klasik "key tidak cocok")
4. Build App Bundle (`.aab`)
5. Shrink / obfuscation singkat (app lebih kecil, kode tidak telanjang)
6. Play Console: listing, screenshot, privacy policy
7. **Privacy policy harus punya URL** (bisa GitHub Pages / repo `docs/`)
8. **Data safety form** + **akun pengguna bisa menghapus datanya** (syarat Play yang sering bikin reject)
9. Catatan teknis yang sering mengejutkan: target SDK terbaru, **16 KB page size**, tampilan edge-to-edge
10. Internal testing → production
11. (Opsional) App Store iOS: overview syarat Apple Developer — praktik penuh ditunda jika belum ada Mac

**Mini project:** unggah 1 app ke internal testing (boleh app modul sebelumnya).

**Hasil:** siklus "kode → build → rilis" Anda pahami end-to-end.

---

## Modul 11 — Capstone: satu produk utuh

Pilih **satu** proyek. Jangan tiga sekaligus.

### Opsi A — Catatan kuliah cloud (disarankan sebagai proyek pertama)

- Daftar, verifikasi email, login, logout
- CRUD catatan (judul, isi, mata kuliah, tanggal)
- Foto lampiran (izin + kompres)
- Sinkron ke Firestore
- Mode gelap
- Empty / loading / error / offline
- Penghapusan akun

### Opsi B — Kasir UMKM offline-first

- Daftar produk (harga Rupiah)
- Transaksi
- Stok (pakai transaksi, jangan sampai minus karena double-tap)
- Laporan harian
- Data lokal + backup cloud
- Perilaku saat sinyal putus (jangan korupsi stok)

### Opsi C — Komunitas / forum mini

- Auth lengkap (termasuk reset password)
- Feed posting + pagination
- Komentar
- Notifikasi (lokal + 1 push)
- Admin hapus konten (dicek di server/rules)
- Penghapusan akun (sesuai syarat Play)

**Syarat lulus capstone:**

- [ ] Ada alur daftar → login → fitur inti → logout
- [ ] Data tersimpan (lokal dan/atau cloud)
- [ ] Error, loading, empty, dan offline ditangani
- [ ] Token/rahasia tidak ada di SharedPreferences atau di dalam kode
- [ ] README berisi cara menjalankan
- [ ] Screenshot + 1 menit rekaman demo

---

## Lampiran (boleh belakangan)

Topik ini sering muncul di kerjaan nyata, tapi **bukan syarat lulus gelombang pertama**:

| Lampiran | Isi singkat | Kapan dibuka |
| --- | --- | --- |
| L1. Lokasi & peta | GPS, izin lokasi, tampilkan titik di peta | Setelah Modul 8 |
| L2. Pembayaran | Konsep gateway (Midtrans/Xendit), jangan simpan nomor kartu | Setelah capstone |
| L3. Supabase | Alternatif Firebase (Postgres + auth) | Setelah Modul 6–7 |
| L4. Crashlytics / Analytics | Tahu app rusak di HP orang | Setelah Modul 10 |
| L5. GitHub Actions mini | `flutter analyze` otomatis saat push | Setelah Modul 0 + 9 |
| L6. Share, URL, WhatsApp | `share_plus`, `url_launcher`, tautan `wa.me` | Kapan saja setelah Modul 3 |
| L7. Update paksa | Pola "versi lama harus update" | Setelah Modul 10 |
| L8. Biometrik | Sidik jari / wajah untuk buka app | Setelah Modul 8 |
| L9. QR | Scan/tampilkan QR (kasir, tiket) | Setelah Modul 8 |

---

## Yang sengaja tidak dimasukkan di gelombang pertama

Supaya jalur wajib tetap terfokus, topik ini **tetap ditunda**:

- Microservices, Kubernetes, DevOps berat
- Bloc/Riverpod mendalam (cukup dikenalkan)
- GetX sebagai standar (hanya peringatan, bukan kurikulum)
- CI/CD kompleks (Actions mini ada di lampiran, bukan pipeline penuh)
- Animasi custom / `AnimationController` tingkat lanjut
- Clean Architecture / DDD penuh (kita pakai folder sederhana dulu)
- GraphQL, WebSocket mendalam, isolate berat
- Flavor (dev/staging/prod) penuh — konsep disebut, praktik ditunda
- Monetisasi IAP / iklan (bisa menyusul setelah L2)
- Flutter Web / Desktop sebagai target utama
- Build iOS dari Windows (tidak didukung)
- ML Kit, home widget, platform channel, FFI

---

## Paket yang akan dipakai berulang (supaya tidak ganti-ganti)

Satu set paket dipakai berulang, supaya tidak ganti-ganti setiap bab:

| Kebutuhan | Pilihan |
| --- | --- |
| Routing | `go_router` |
| State | `provider` |
| HTTP | `dio` |
| Tes API di luar app | Thunder Client / Postman |
| Lokal key-value | `shared_preferences` |
| Rahasia / token | `flutter_secure_storage` |
| Database lokal | Drift (SQLite) |
| Backend pertama | Firebase (Auth, Firestore, Storage, FCM) |
| Izin | `permission_handler` |
| Gambar | `image_picker` + `cached_network_image` |
| Format ID | `intl` |
| Font | `google_fonts` (opsional) |
| Env | `--dart-define` / `flutter_dotenv` |

---

## Struktur file repo

```
README.md
SILABUS.md
.gitignore
modul-00-persiapan/
  README.md
  images/
modul-01-dart/
  README.md
  images/
modul-02-ui/
  README.md
  images/
modul-03-interaksi/
  README.md
  images/
modul-04-state/
  README.md
  images/
modul-05-data-lokal/
  README.md
  images/
modul-06-firebase/ … modul-11-capstone/
lampiran/
  l1-lokasi-peta/
  l2-pembayaran/                    ← L3–L9 menyusul
docs/
  SUMBER-GAMBAR.md
proyek-contoh/                      ← menyusul, seiring mini proyek
```

Setiap `README.md` modul berisi: tabel alat, tujuan, analogi, langkah, kode, kesalahan yang sering terjadi, latihan, kuis, sitasi gambar.

---

## Prinsip penulisan materi

1. Bahasa Indonesia yang enak dibaca, tetap EYD: *silakan*, *Anda*, imbuhan *di-* dirangkai, preposisi *di* dipisah. Bukan nada dokumen resmi.
2. Jangan menempel label kemampuan pada pembaca; langsung ke isinya
3. Analogi dulu, kode kemudian
4. Satu konsep = satu contoh = satu latihan
5. Tiap modul bisa selesai dalam 1–2 sesi (modul 7–8 boleh 3 sesi)
6. Kode selalu bisa disalin dan dijalankan di alat yang disebutkan
7. Bagian "Kesalahan yang sering terjadi" wajib ada
8. Setiap modul menyebut apa yang *belum* dibahas, supaya cakupan jelas
9. Setiap perintah menyebut alat yang harus dibuka dulu

---

## Beku: apa yang tidak akan ditambah lagi ke jalur wajib

Kalau ditambah terus, ini tidak pernah selesai. Jalur wajib **berhenti di 12 modul + 9 lampiran**.

Permintaan berikutnya seperti "tambah ML", "tambah Kubernetes", "tambah iOS dari Windows" masuk **gelombang 2**, bukan disisipkan diam-diam ke sini.

---

## Keputusan yang dipakai di gelombang ini

Penulisan materi memakai empat keputusan ini:

1. **Backend utama:** Firebase (Modul 06), REST API + backend mini CRUD + satu kali deploy (Modul 07)
2. **State management:** `provider` sebagai standar; Riverpod/Bloc hanya pengenalan; GetX tidak dipakai sebagai standar
3. **Bahasa:** seluruh materi Bahasa Indonesia (EYD), nada percakapan
4. **Target praktik rilis:** Android / Play Store (dari Windows tidak bisa membangun iOS)

Jalur wajib 12 modul **sudah tertulis**. Lampiran: **L1 dan L2 selesai**. Berikutnya L3–L9, hanya jika diminta.

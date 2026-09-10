# SLIDE DECK MATERI AJAR: PERTEMUAN 13 - 16
## Fase 4: Keamanan, Fitur Cerdas (AI), Pengujian, & Rilis Produksi

---

# PERTEMUAN 13: Keamanan Mobile (Security) & Fitur Cerdas (AI On-Device)

### Slide 1: Bahaya "Hardcoded Secrets" di Aplikasi Mobile
* **Fakta:** File APK Android dapat dengan mudah didekompilasi menggunakan tools seperti *JADX-GUI*.
* **Kasus Fatal:** Mahasiswa menaruh `apiKey = "sk-abcdef123..."` langsung di dalam kode dart. Dalam hitungan detik, hacker dapat mencuri kunci API dan menguras saldo tagihan cloud.
* **Solusi Industri:**
  * Gunakan berkas `.env` dan masukkan ke dalam `.gitignore`.
  * Gunakan `flutter_secure_storage` (KeyStore di Android / Keychain di iOS) untuk menyimpan token sesi pengguna.

### Slide 2: AI On-Device Menggunakan Google ML Kit
* **Mengapa On-Device?** Sangat cepat, bebas biaya kuota API, dan bekerja saat perangkat luring (*offline*).
* **Fitur Praktikum:**
  * Text Recognition (OCR): Memindai nomor rekening atau kartu identitas secara instan dari kamera.
  * Barcode & QR Code Scanning.
* **Integrasi Generative AI:** Menghubungkan chatbot cerdas atau ringkasan dokumen menggunakan Gemini API.

---

# PERTEMUAN 14: Automated Testing & DevTools Profiling

### Slide 1: Piramida Pengujian di Flutter (Testing Pyramid)
* **1. Unit Tests (Dasar & Cepat):** Menguji fungsi matematika, validasi form, dan transisi state Cubit/BLoC menggunakan package `test` dan `bloc_test`.
* **2. Widget Tests (Menengah):** Menguji interaksi komponen visual tanpa perlu emulator fisik (`tester.pumpWidget`, `tester.tap()`, `expect(find.text('Login'), findsOneWidget)`).
* **3. Integration Tests (Puncak):** Menjalankan skenario alur pengguna utuh dari awal sampai akhir di perangkat nyata.

### Slide 2: Profiling Menggunakan Flutter DevTools
* **Mendeteksi "Jank" (Patah-patah):** Target 60 fps (waktu render frame $< 16.6\text{ ms}$) atau 120 fps ($< 8.3\text{ ms}$).
* **Memory Tab:** Memantau alokasi memori dan mendeteksi kebocoran memori (*memory leaks*) akibat lupa menutup `StreamController` atau `TextEditingController.dispose()`.

---

# PERTEMUAN 15: App Hardening, Keystore Signing, & CI/CD Deployment

### Slide 1: Anatomi Berkas Rilis Produksi
* **Debug APK vs Release App Bundle (.aab):**
  * Debug APK berukuran 50–100 MB karena memuat Dart VM dan JIT compiler.
  * Release AAB dioptimasi menggunakan kompilasi *Ahead-of-Time (AOT)* sehingga ukuran menyusut menjadi 15–25 MB.

### Slide 2: Code Obfuscation & Keystore
* **Menghasilkan Kunci Produksi (Keystore):**
  ```bash
  keytool -genkey -v -keystore release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias my-alias
  ```
* **Kompilasi dengan Obfuscation (Pengacakan Nama Variabel/Class):**
  ```bash
  flutter build appbundle --obfuscate --split-debug-info=./debug_symbols
  ```

---

# PERTEMUAN 16: UJIAN AKHIR SEMESTER (UAS) - APP EXPO & DEFENSE

### Slide 1: Prosedur "Mobile App Expo"
* Setiap tim mendapatkan meja pameran mini atau slot presentasi di layar utama.
* Wajib membawa:
  1. Smartphone fisik yang sudah terinstal aplikasi versi Release.
  2. Laptop yang menampilkan dashboard backend (Firebase Console / API Server).
  3. Repositori GitHub dengan riwayat commit yang rapi.

### Slide 2: Format Live Code Defense Individu (15 Menit)
1. **Pitching Produk (3 menit):** Masalah apa yang diselesaikan aplikasi ini?
2. **Feature Walkthrough (4 menit):** Demonstrasi fitur utama, offline capability, dan integrasi hardware.
3. **Architecture & Code Defense (8 menit):** Dosen menunjuk kode secara acak untuk menguji penguasaan setiap individu anggota tim.

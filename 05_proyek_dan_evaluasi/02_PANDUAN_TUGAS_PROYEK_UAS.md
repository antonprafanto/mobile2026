# PANDUAN TUGAS PROYEK AKHIR SEMESTER (UAS - PRODUCTION READY)
## "Mobile App Expo & Demo Day 2026"

---

## 1. Deskripsi Proyek Akhir
Proyek Akhir Semester (UAS) adalah kulminasi seluruh materi kuliah. Tim mahasiswa menyempurnakan prototipe UTS menjadi **produk aplikasi piranti bergerak yang utuh, tangguh, aman, dan siap rilis ke publik**.

---

## 2. Fitur & Standar Teknis Wajib (Checklist Persyaratan)

- [ ] **1. Cloud Backend & Autentikasi Nyata:**
  * Terintegrasi dengan layanan backend nyata (*Custom REST API* atau *Firebase/Supabase*).
  * Manajemen sesi pengguna yang aman (Token JWT disimpan di `flutter_secure_storage`).
- [ ] **2. Arsitektur Offline-First (Local Caching):**
  * Aplikasi tetap dapat dibuka dan menampilkan data lokal saat smartphone dalam mode pesawat (*No Internet Connection*).
- [ ] **3. Integrasi Perangkat Keras (Hardware Feature):**
  * Memanfaatkan minimal 1 sensor perangkat keras: Kamera (*Image Picker*), Lokasi GPS (*Geolocator*), atau Pemindai (*Google ML Kit OCR/Barcode*).
- [ ] **4. Keamanan & Secret Management:**
  * Tidak ada kunci rahasia (*API keys / Passwords*) yang di-*hardcode* di dalam kode Dart. Seluruh rahasia tersimpan di `.env` yang terabaikan dari Git.
- [ ] **5. Pengujian Otomatis (Automated Testing):**
  * Minimal memiliki 5 *Unit Test* untuk logika State Management Cubit dan 2 *Widget Test*.
- [ ] **6. Paket Rilis Produksi (Production Build):**
  * Membangun berkas `app-release.apk` atau `.aab` yang telah ditandatangani dengan *Keystore resmi* dan diproteksi dengan teknik *Code Obfuscation*.

---

## 3. Format Pelaksanaan "Mobile App Expo" (Pertemuan 16)

* **Konsep:** Pameran produk teknologi terbuka di aula/lab komputer yang dihadiri oleh seluruh mahasiswa, dosen pembina, dan dapat mengundang perwakilan industri/startup lokal.
* **Deliverables yang Dikumpulkan:**
  1. **Tautan Repositori GitHub:** Repositori privat GitHub Classroom dengan dokumentasi `README.md` berstandar portofolio profesional.
  2. **Tautan Video Demo Produk (YouTube / Google Drive):** Video berdurasi 3 menit menjelaskan latar belakang masalah, demo alur pengguna aplikasi, dan arsitektur kode.
  3. **Berkas Rilis APK:** Berkas APK versi release yang dapat langsung diunduh dan dipasang oleh pengunjung expo.

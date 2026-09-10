# PANDUAN TUGAS PROYEK TENGAH SEMESTER (UTS - SPRINT 1)
## Mata Kuliah: Pemrograman Piranti Bergerak (Flutter)

---

## 1. Deskripsi Proyek
Proyek Tengah Semester (UTS) adalah pembuktian kemampuan tim mahasiswa (2–3 orang) dalam merancang arsitektur aplikasi mobile yang bersih (*Clean Architecture*), antarmuka pengguna yang adaptif (*Material 3*), dan manajemen status terpusat (*State Management*) sebelum melangkah ke integrasi jaringan backend.

---

## 2. Kriteria & Ruang Lingkup Wajib (Deliverables)

1. **Tema Aplikasi (Bebas / Terarah):**
   * *Smart Campus / Academic Life*
   * *Health & Wellness Tracker*
   * *Community & Event Marketplace*
   * *Personal Finance & Budgeting*
2. **Kebutuhan Antarmuka (UI/UX):**
   * Minimal memiliki **4 Halaman Berbeda**:
     1. Layar *Splash / Onboarding*.
     2. Layar *Autentikasi (Login & Register Form)* dengan validasi lengkap.
     3. Layar *Dashboard / Home* dengan daftar konten dinamis.
     4. Layar *Detail Item* dan *Pengaturan Profil (Support Light/Dark Mode)*.
   * **Bebas dari Overflow Error:** Tampilan harus teruji rapi di berbagai rasio layar dan saat diputar ke posisi *Landscape*.
3. **Arsitektur & State Management:**
   * Menerapkan struktur folder *Feature-First*.
   * Menggunakan **Cubit / BLoC** untuk mengelola state lokal (contoh: status form, filter pencarian, cart/wishlist).
   * Dilarang menggunakan `setState()` untuk logika yang melibatkan lebih dari 1 file widget.
4. **Navigasi Deklaratif:**
   * Seluruh perpindahan halaman wajib dikendalikan menggunakan **GoRouter** terpusat.
5. **Standar Repositori Git:**
   * Setiap anggota tim **wajib** memiliki minimal 3 *Pull Request* yang disetujui (*merged*) oleh rekan tim.

---

## 3. Tata Cara Pelaksanaan Ujian (Demo Sprint 1)

* **Waktu:** Pertemuan ke-8 (Minggu UTS).
* **Durasi per Kelompok:** 12 Menit (6 menit presentasi demo aplikasi, 6 menit *Live Code Walkthrough* oleh dosen).
* **Alat:** Menampilkan aplikasi di proyektor kelas melalui **Scrcpy** atau perangkat smartphone fisik.

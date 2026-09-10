# PANDUAN MENJALANKAN KODE PROGRAM LENGKAP (PERTEMUAN 04)
## Form Handling, Input Validation, & Navigasi Deklaratif GoRouter

Seluruh kode program di dalam folder ini adalah **aplikasi Flutter lengkap (*fully runnable code*)**. Mahasiswa tidak perlu bingung menyusun fungsi `void main()`, `MaterialApp`, atau `Scaffold` dari awal karena setiap berkas sudah mandiri (*self-contained*).

---

### 1. Daftar Berkas Kode Program Siap Run

| Nama Berkas | Topik Pembahasan Slide | Deskripsi Fitur Aplikasi |
| :--- | :---: | :--- |
| **`01_form_registrasi_lengkap.dart`** | Slide 03 – 11 | Formulir pendaftaran akun mahasiswa lengkap: validasi regex email kampus (`@mhs.kampus.ac.id`), toggle intip password (`_isObscure`), dropdown program studi, penutup keyboard HP otomatis (`FocusScope.unfocus`), dan notifikasi SnackBar. |
| **`02_gorouter_navigasi_dan_passing_data.dart`** | Slide 12 – 17 | Demonstrasi navigasi GoRouter terpusat: katalog buku, detail buku via *Path Parameters* (`/buku/:id`), pencarian via *Query Parameters* (`/cari?keyword=`), pengiriman data model via `extra`, dan penanganan galat 404. |
| **`03_gorouter_bottom_nav_shell.dart`** | Slide 18 | Navigasi menu bawah modern (*Bottom Navigation Bar*) menggunakan `StatefulShellRoute.indexedStack`. Posisi scroll di tab Beranda tidak akan ter-reset saat pengguna berpindah tab. |
| **`04_lab_quest_04_solusi_portal_ktm.dart`** | Slide 19 (Lab Quest) | Solusi master praktikum: Alur lengkap dari pengisian formulir registrasi mahasiswa $\rightarrow$ validasi regex $\rightarrow$ navigasi GoRouter $\rightarrow$ penerbitan Kartu Tanda Mahasiswa (KTM) digital bergaya Neo-Brutalism. |

---

### 2. Langkah Cepat Menjalankan Kode (Khusus Mahasiswa Awam)

Ikuti 3 langkah mudah ini di komputer lab atau laptop pribadi:

#### Langkah 1: Siapkan Proyek Flutter
Buka terminal (atau VS Code Terminal dengan `Ctrl + ~`), lalu buat proyek baru:
```bash
flutter create latihan_p4
cd latihan_p4
```

#### Langkah 2: Pasang Dependensi GoRouter Resmi
Ketik perintah berikut di terminal (otomatis terpasang tanpa risiko salah spasi di `pubspec.yaml`):
```bash
flutter pub add go_router
```

#### Langkah 3: Salin Kode & Jalankan!
1. Buka berkas `lib/main.dart` di proyek Anda.
2. Hapus seluruh isinya, lalu **salin (*copy-paste*) salah satu berkas di atas** (misalnya `04_lab_quest_04_solusi_portal_ktm.dart`).
3. Jalankan di browser Chrome (paling ringan di PC lab, tidak membebani RAM):
   ```bash
   flutter run -d chrome
   ```
   *(Atau jalankan di smartphone fisik menggunakan kabel data + software `scrcpy`).*

---

> [!TIP]
> **Trik Menguji Navigasi di Browser Chrome:**
> Saat menjalankan di Google Chrome, perhatikan bilah alamat URL di atas peramban web (*Address Bar*). Saat Anda berpindah dari form registrasi ke KTM, alamat URL akan otomatis berubah menjadi:
> `http://localhost:port/#/ktm/2301092026`
> Ini membuktikan bahwa sistem navigasi deklaratif berbasis URL standar 2026 telah berjalan sempurna!

# PANDUAN SPESIFIKASI PERANGKAT & SETUP LABORATORIUM
## Mata Kuliah: Pemrograman Piranti Bergerak (Flutter)

---

## 1. Standar Kebutuhan Perangkat Keras (Hardware Specifications)

Tantangan terbesar dalam praktikum pemrograman mobile di perguruan tinggi adalah keterbatasan spesifikasi PC Laboratorium dan laptop mahasiswa.

| Komponen | Spesifikasi Minimum (Toleransi Rendah) | Spesifikasi Rekomendasi (Standar Industri) |
| :--- | :--- | :--- |
| **Prosesor (CPU)** | Intel Core i3 Gen 8 / AMD Ryzen 3 (4 Cores, $\ge 2.5\text{ GHz}$) | Intel Core i5/i7 Gen 11+ / AMD Ryzen 5/7 (6-8 Cores) atau Apple Silicon (M1/M2/M3) |
| **Memori (RAM)** | **8 GB DDR4** (*Wajib optimasi, dilarang menjalankan Android Emulator*) | **16 GB - 32 GB DDR4/DDR5** (*Mampu menjalankan IDE + Emulator + Browser bersamaan*) |
| **Penyimpanan** | 256 GB SSD (Minimal sisa ruang kosong 40 GB) | 512 GB NVMe SSD (Kecepatan baca/tulis $\ge 2000\text{ MB/s}$) |
| **Sistem Operasi** | Windows 10/11 64-bit, Ubuntu 22.04 LTS, atau macOS Monterey | Windows 11 64-bit / macOS Sonoma / Linux Fedora |
| **Perangkat Uji** | Smartphone Android Fisik (Android 9+) + Kabel Data USB | Android Device Fisik + Emulator Pixel dengan Google Play |

---

## 2. Pemilihan IDE: Mengapa VS Code Lebih Disukai untuk Praktikum?

Di lingkungan laboratorium kampus dengan PC berkapasitas RAM 8 GB:
* **Android Studio (Full IDE):** Membutuhkan alokasi RAM 2.5 GB – 4 GB hanya untuk IDE, belum termasuk Gradle daemon dan emulator. Menjalankan Android Studio di PC 8 GB sering mengakibatkan sistem *freeze* (*thrashing* swap memory).
* **Visual Studio Code (Lightweight Editor):** Membutuhkan alokasi RAM hanya ~400 MB – 800 MB.
* **Keputusan Dosen:** 
  > Seluruh modul perkuliahan menggunakan **Visual Studio Code** sebagai editor utama, sementara Android Studio hanya diinstal minimalis sebagai penyedia *Android SDK, Command-Line Tools, dan Build-Tools*.

---

## 3. Checklist Langkah Instalasi Lingkungan Kerja (Step-by-Step)

### Langkah 1: Instalasi Git & VS Code
1. Unduh dan pasang Git: `https://git-scm.com/`
2. Unduh dan pasang Visual Studio Code: `https://code.visualstudio.com/`
3. Pasang Extensions wajib di VS Code:
   * **Flutter** (Otomatis menyertakan ekstensi Dart)
   * **Dart Code Metrics / Flutter Lints**
   * **Bloc** (oleh Felix Angelov - untuk kemudahan generate Cubit/Bloc template)
   * **Pubspec Assist** (untuk pencarian package praktis)
   * **Error Lens** (menampilkan linter error langsung di baris kode)

### Langkah 2: Instalasi Flutter SDK
1. Ekstrak Flutter SDK ke direktori tanpa spasi dan tanpa hak akses administrator tinggi, misalnya:
   * Windows: `C:\src\flutter` (JANGAN letakkan di `C:\Program Files\`)
   * Linux/macOS: `~/development/flutter`
2. Tambahkan variabel lingkungan (*Environment Variables*) PATH:
   * Tambahkan `C:\src\flutter\bin` ke dalam variabel sistem `Path`.

### Langkah 3: Konfigurasi Android SDK Command-Line Tools
1. Buka Android Studio $\rightarrow$ **SDK Manager** $\rightarrow$ Tab **SDK Tools**.
2. Centang dan pasang:
   * `Android SDK Command-line Tools (latest)`
   * `Android SDK Platform-Tools`
   * `Android SDK Build-Tools`
3. Buka terminal (Command Prompt / PowerShell / Terminal), jalankan penerimaan lisensi:
   ```bash
   flutter doctor --android-licenses
   ```
   *(Tekan `y` pada semua konfirmasi lisensi)*.

### Langkah 4: Verifikasi Akhir
Jalankan perintah diagnosis di terminal:
```bash
flutter doctor -v
```
Pastikan status menunjukkan centang hijau pada:
- [x] Flutter SDK
- [x] Android toolchain - develop for Android devices
- [x] VS Code
- [x] Connected device (minimal 1 perangkat terdeteksi)

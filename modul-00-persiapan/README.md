# Modul 00: Setup Lingkungan Kerja & Tooling Modern 2026

Selamat datang di modul awal perjalanan **Fullstack Mobile Developer**! Sebelum kita menulis logika kode Dart dan antarmuka Flutter yang menawan, langkah paling krusial adalah memastikan "bengkel kerja" dan seluruh perkakas kita terpasang dengan sempurna.

Modul ini memandu Anda langkah demi langkah, mulai dari nol hingga seluruh indikator di `flutter doctor -v` berstatus **centang hijau (All Passed)** dan aplikasi perdana Anda menyala di HP/emulator.

---

## 🍳 Analogi: Dapur Restoran Bintang Lima

Membangun aplikasi mobile ibarat menyiapkan dapur restoran modern:

| Komponen di Flutter | Analogi di Dapur | Peran & Fungsi |
|---|---|---|
| **Dart SDK** | **Bahasa & Buku Resep** | Logika perhitungan, aturan alur, dan resep masakan yang dieksekusi. |
| **Flutter SDK** | **Peralatan Masak Modern** | Wajan, pisau, mixer, dan kompor cepat yang merender antarmuka pengguna (UI). |
| **Android SDK & JDK** | **Oven & Cetakan Khusus Android** | Mesin pencetak agar resep masakan bisa dikemas menjadi format resmi yang dipahami HP Android (`.apk` / `.aab`). |
| **VS Code / Editor** | **Meja Racik & Pisau Utama** | Tempat Anda menulis, menyusun bahan, merapikan bumbu, dan melihat kesalahan kode seketika. |
| **Emulator / HP Fisik** | **Piring Saji Pelanggan** | Tempat hidangan disajikan dan diuji coba persis seperti yang akan dinikmati pengguna asli. |

---

## 💻 1. Spesifikasi Perangkat yang Disarankan

Pastikan komputer/laptop Anda memenuhi standar berikut agar proses kompilasi dan emulator berjalan lancar tanpa macet:

* **Sistem Operasi**: Windows 10 / 11 (64-bit), macOS (v12+), atau Linux (Ubuntu 22.04+). *(Panduan di modul ini mengutamakan Windows & Android)*.
* **Prosesor (CPU)**: Minimal 4 Core (Intel Core i5 / AMD Ryzen 5 generasi modern dengan dukungan Virtualisasi **VT-x / AMD-V** aktif di BIOS).
* **RAM**: Minimal 8 GB *(Sangat direkomendasikan 16 GB jika ingin menjalankan emulator Android bersamaan dengan browser dan editor)*.
* **Penyimpanan**: Minimal ruang kosong 20–25 GB pada **SSD** (Solid State Drive).

---

## 🛠️ 2. Panduan Instalasi Langkah demi Langkah

### Langkah 1: Instalasi Git & Flutter SDK

1. **Instal Git untuk Windows**:
   - Unduh dari situs resmi: [git-scm.com](https://git-scm.com/download/win).
   - Jalankan installer, pilih konfigurasi standar *(default)* hingga selesai.

2. **Unduh Flutter SDK**:
   - Buka halaman resmi: [docs.flutter.dev/get-started/install/windows](https://docs.flutter.dev/get-started/install/windows).
   - Unduh berkas *bundle* zip Flutter SDK versi **Stable** terbaru (misal: `flutter_windows_3.x.x-stable.zip`).

3. **Ekstrak ke Folder yang Tepat**:
   - Ekstrak isi file zip tersebut ke direktori seperti `C:\src\flutter` atau `C:\flutter`.
   
   > [!CAUTION]
   > **JANGAN** mengekstrak Flutter ke folder `C:\Program Files\` atau folder yang memerlukan hak akses Administrator khusus, karena akan menyebabkan error izin akses saat kompilasi.

4. **Tambahkan Flutter ke Environment Variables (PATH Windows)**:
   - Tekan tombol **Windows**, ketik `env`, lalu pilih **Edit the system environment variables**.
   - Klik tombol **Environment Variables...** di kanan bawah.
   - Pada bagian **User variables** (atau *System variables*), cari variabel bernama `Path`, lalu klik **Edit**.
   - Klik tombol **New**, lalu tambahkan path folder `bin` dari Flutter Anda, contoh:
     ```text
     C:\src\flutter\bin
     ```
   - Klik **OK** pada seluruh jendela dialog.
   
5. **Uji Flutter di Terminal**:
   - Buka terminal baru (**PowerShell** atau **Command Prompt**), lalu ketik:
     ```bash
     flutter --version
     ```
   - Jika muncul versi Flutter dan Dart, instalasi awal Anda berhasil!

---

### Langkah 2: Instalasi JDK (Java Development Kit) & Setup `JAVA_HOME`

Proses kompilasi aplikasi Android menggunakan alat bernama **Gradle**, dan Gradle membutuhkan Java (JDK 17 atau JDK 21).

1. **Unduh JDK**:
   - Disarankan mengunduh **Eclipse Temurin OpenJDK 17 / 21** dari [adoptium.net](https://adoptium.net/) atau Oracle JDK.
   - Jalankan installer `.msi` dan pastikan mencentang opsi **"Set JAVA_HOME variable"**.

2. **Verifikasi `JAVA_HOME`**:
   - Buka terminal baru dan ketik:
     ```bash
     java -version
     echo $env:JAVA_HOME
     ```
   - Pastikan path mengarah ke instalasi Java Anda (contoh: `C:\Program Files\Eclipse Adoptium\jdk-17.x.x-hotspot\`).

---

### Langkah 3: Setup Android Studio & Android SDK Command-line Tools

1. **Unduh Android Studio**:
   - Unduh versi terbaru dari [developer.android.com/studio](https://developer.android.com/studio).
   - Jalankan setup installer hingga selesai, buka Android Studio.

2. **Instal Android SDK & Command-line Tools Wajib**:
   - Di layar pembuka Android Studio, klik **More Actions** ➔ **SDK Manager** (atau buka dari menu *Settings ➔ Languages & Frameworks ➔ Android SDK*).
   - Pada tab **SDK Platforms**:
     - Centang versi Android terbaru (misal: Android 14.0 "UpsideDownCake" / Android 15).
   - Pada tab **SDK Tools** *(Sangat Penting)*:
     - Centang **Android SDK Build-Tools**
     - Centang **Android SDK Command-line Tools (latest)** ➔ *(Sering terlewat oleh pemula!)*
     - Centang **Android Emulator**
     - Centang **Android SDK Platform-Tools**
   - Klik **Apply**, tunggu proses unduhan selesai, lalu klik **Finish**.

3. **Menyetujui Lisensi Android (Android Licenses)**:
   - Buka terminal PowerShell, lalu jalankan perintah:
     ```bash
     flutter doctor --android-licenses
     ```
   - Tekan tombol `y` lalu **Enter** untuk setiap pertanyaan persetujuan lisensi yang muncul hingga selesai (*All SDK package licenses accepted*).

---

### Langkah 4: Menyiapkan Perangkat Uji Coba (Emulator vs HP Fisik)

Anda bisa memilih menggunakan Emulator Virtual di laptop atau langsung menggunakan HP Android fisik Anda.

```
                  ┌──────────────────────────────────────────────┐
                  │          PILIHAN PERANGKAT DEBUG             │
                  └──────────────────────┬───────────────────────┘
                                         │
                 ┌───────────────────────┴───────────────────────┐
                 │                                               │
                 ▼                                               ▼
     ┌───────────────────────┐                       ┌───────────────────────┐
     │      EMULATOR AVD     │                       │     HP FISIK ANDROID  │
     ├───────────────────────┤                       ├───────────────────────┤
     │ • Tidak butuh kabel   │                       │ • Sangat ringan (0 RAM│
     │ • RAM laptop min 16GB │                       │   laptop untuk HP)    │
     │ • Mudah ganti ukuran  │                       │ • Uji sensor/kamera   │
     │   layar (HP / Tablet) │                       │   secara nyata        │
     └───────────────────────┘                       └───────────────────────┘
```

#### Opsi A: Setup Emulator Android (AVD)
1. Di Android Studio, klik **More Actions** ➔ **Virtual Device Manager** (Device Manager).
2. Klik tombol **Create Device**.
3. Pilih model perangkat dengan ikon Play Store (misal: **Pixel 7** atau **Pixel 8**), klik **Next**.
4. Pilih System Image release stabil terbaru (misal: **UpsideDownCake** / API 34 berarsitektur `x86_64`), klik tombol unduh jika belum ada, lalu klik **Next**.
5. Pada *Emulated Performance*, pilih Graphics: **Automatic** atau **Hardware - GLES 2.0**.
6. Klik **Finish**, lalu tekan tombol **Play (▶)** untuk menyalakan emulator.

#### Opsi B: Setup HP Android Fisik (Rekomendasi untuk Laptop RAM 8GB)
1. Buka menu **Pengaturan (Settings)** di HP Android Anda.
2. Masuk ke **Tentang Ponsel (About Phone)** ➔ Cari tulisan **Nomor Bentukan (Build Number)**.
3. Ketuk (tap) tulisan **Build Number sebanyak 7 kali berturut-turut** hingga muncul notifikasi: *"Anda sekarang adalah seorang pengembang!"*.
4. Kembali ke menu Pengaturan ➔ **Opsi Pengembang (Developer Options)**.
5. Aktifkan sakelar **Debugging USB (USB Debugging)**.
6. Hubungkan HP ke laptop via kabel USB data. Jika muncul dialog popup di layar HP: *"Izinkan USB Debugging dari komputer ini?"*, centang *"Selalu izinkan"* dan pilih **OK**.
7. Buka terminal dan cek apakah HP Anda terdeteksi:
   ```bash
   flutter devices
   ```

---

### Langkah 5: Setup Visual Studio Code & Ekstensi Produktif

1. **Unduh VS Code**: dari [code.visualstudio.com](https://code.visualstudio.com/).
2. **Pasang Ekstensi Esensial Flutter**:
   Buka VS Code, tekan `Ctrl + Shift + X` (menu Extensions), lalu cari dan pasang:
   - 🌟 **Flutter** (Otomatis memasang ekstensi Dart resmi).
   - 🔍 **Error Lens** (Menampilkan letak error dan typo langsung di baris kode tanpa harus hover).
   - ⚡ **Flutter Riverpod Snippets** / **Bloc** (Mempercepat pembuatan state management).
   - 📦 **Pubspec Assist** (Menambahkan package dari pub.dev langsung dari command palette).
   - 🎨 **Material Icon Theme** (Memberikan ikon visual cantik pada setiap file proyek).

3. **Shortcut Sakti Pengembang Flutter di VS Code**:

| Shortcut (Windows) | Fungsi & Kegunaan |
|---|---|
| `Ctrl + Shift + P` | Membuka **Command Palette** (Ketik `Flutter: New Project`, `Flutter: Run`, dll). |
| `Ctrl + .` / `Alt + Enter` | **Quick Fix & Refactor Widget** (Wrap with Padding, Column, Container, Remove Widget). |
| `F5` | Menjalankan aplikasi dengan mode **Debug**. |
| `Ctrl + F5` | Menjalankan aplikasi dengan mode **Run without Debugging** (Lebih ringan & cepat). |
| `r` (di terminal aktif) | **Hot Reload** (Memperbarui tampilan UI secara instan < 1 detik tanpa reset state). |
| `R` (di terminal aktif) | **Hot Restart** (Mengulang aplikasi dari fungsi `main()` awal). |

---

## 🩺 3. Uji Verifikasi Sistem (`flutter doctor -v`)

Sekarang saatnya menjalankan pemeriksaan kesehatan lingkungan kerja secara menyeluruh.

Buka terminal PowerShell, jalankan:
```bash
flutter doctor -v
```

### ✅ Target Output Sempurna:

```text
[✓] Flutter (Channel stable, 3.x.x, on Microsoft Windows, locale id-ID)
    • Flutter version 3.x.x on channel stable
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision xxxxxxxxx (stable)
    • Engine revision xxxxxxxxx
    • Dart version 3.x.x
    • DevTools version 2.x.x

[✓] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
    • Android SDK at C:\Users\Username\AppData\Local\Android\Sdk
    • Platform android-34, build-tools 34.0.0
    • Java binary at: C:\Program Files\Eclipse Adoptium\jdk-17.x.x\bin\java
    • Java version OpenJDK Runtime Environment (build 17.x.x)
    • All Android licenses accepted.

[✓] Chrome - develop for the web
    • Chrome at C:\Program Files\Google\Chrome\Application\chrome.exe

[✓] Android Studio (version 2024.x)
    • Android Studio at C:\Program Files\Android\Android Studio
    • Flutter plugin can be installed from Android Studio settings
    • Dart plugin can be installed from Android Studio settings
    • Java version OpenJDK Runtime Environment

[✓] VS Code (version 1.9x.x)
    • VS Code at C:\Users\Username\AppData\Local\Programs\Microsoft VS Code
    • Flutter extension version x.x.x

[✓] Connected device (2 available)
    • sdk gphone64 x86 64 (mobile) • emulator-5554 • android-x64 • Android 14 (API 34) (emulator)
    • Windows (desktop)            • windows       • windows-x64 • Microsoft Windows

[✓] Network resources
    • All expected network resources are available.

• No issues found!
```

> [!NOTE]
> Jika ada tanda seru kuning `[!]` atau silang merah `[✗]`, jangan panik! Lihat bagian **Jebakan Umum & Solusi** di bawah untuk memperbaikinya dalam hitungan menit.

---

## 🚀 4. Praktik Pertama: Membuat & Menjalankan Proyek Perdana

Mari kita buat aplikasi pertama untuk memastikan seluruh alur kompilasi berjalan mulus!

1. **Buka Terminal di folder workspace Anda**:
   ```bash
   cd c:\Users\anton\vibecoding\mobile2026
   ```

2. **Buat Proyek Flutter Baru**:
   ```bash
   flutter create proyek_pertama --org com.mobile2026
   ```

3. **Buka Proyek di VS Code**:
   ```bash
   code proyek_pertama
   ```

4. **Jalankan Aplikasi ke Perangkat**:
   - Pastikan Emulator menyala atau HP Android terhubung.
   - Buka file `lib/main.dart`.
   - Tekan `F5` atau jalankan via terminal:
     ```bash
     flutter run
     ```
5. **Coba Keajaiban "Hot Reload"**:
   - Buka `lib/main.dart`, cari teks `'Flutter Demo Home Page'`, ubah menjadi `'Halo Mobile 2026!'`.
   - Simpan file (`Ctrl + S`) atau tekan `r` di terminal.
   - **Tampilan di layar HP akan berubah secara instan dalam hitungan milidetik!**

---

## ⚠️ 5. Jebakan Umum (*Common Pitfalls*) & Solusi Kilat

Berikut adalah daftar kendala yang paling sering dialami pemula beserta solusinya:

### 1. Error: `cmdline-tools component is missing`
* **Gejala**: `flutter doctor` menampilkan silang merah pada Android toolchain.
* **Solusi**: Buka Android Studio ➔ **SDK Manager** ➔ tab **SDK Tools** ➔ centang **Android SDK Command-line Tools (latest)** ➔ klik **Apply**.

### 2. Error: `Android license status unknown`
* **Gejala**: `flutter doctor` meminta persetujuan lisensi SDK.
* **Solusi**: Jalankan perintah berikut di terminal dan tekan `y` untuk semua prompt:
  ```bash
  flutter doctor --android-licenses
  ```

### 3. Error: `'flutter' is not recognized as an internal or external command`
* **Gejala**: Terminal Windows tidak mengenali perintah `flutter`.
* **Solusi**: Path `C:\src\flutter\bin` belum dimasukkan ke Environment Variables `Path`, atau terminal belum di-restart setelah menambahkan path. Tutup semua jendela terminal, buka kembali terminal baru.

### 4. Error: Emulator Crash / `VT-x / AMD-V is disabled in BIOS`
* **Gejala**: Emulator Android tidak mau menyala atau laptop mendadak blue screen/hang.
* **Solusi**: Aktifkan fitur **Virtualization Technology (Intel VT-x atau AMD SVM)** di menu BIOS/UEFI motherboard komputer Anda. Di Windows 11, pastikan fitur *Windows Hypervisor Platform* juga aktif.

### 5. Error: `Unable to locate Android SDK`
* **Gejala**: Flutter tidak tahu di mana folder Android SDK berada.
* **Solusi**: Beritahu Flutter lokasi SDK Anda secara manual melalui perintah:
  ```bash
  flutter config --android-sdk "C:\Users\<NamaUserAnda>\AppData\Local\Android\Sdk"
  ```

---

## 📝 6. Kuis Pemahaman Modul 00

Uji pemahaman Anda sebelum melangkah ke Modul 01:

1. **Apa perbedaan antara Hot Reload (`r`) dan Hot Restart (`R`) di Flutter?**
   - *Jawaban*: Hot Reload menginjeksi kode UI baru langsung ke Dart Virtual Machine tanpa menghilangkan state data saat ini. Hot Restart mengatur ulang seluruh state aplikasi dari awal (`main()`).
2. **Mengapa kita tidak boleh menaruh folder Flutter SDK di dalam `C:\Program Files\`?**
   - *Jawaban*: Karena folder Program Files membutuhkan hak akses administrator Windows, yang dapat memblokir proses build otomatis dan pengunduhan package Dart.
3. **Komponen Android SDK apa yang wajib dicentang di SDK Manager agar `flutter doctor` tidak error?**
   - *Jawaban*: `Android SDK Command-line Tools (latest)`.

---

## 🎯 Rangkuman & Checklist Kesiapan

- [x] Flutter SDK Stable & Dart SDK terpasang di PATH sistem.
- [x] Java JDK 17/21 terpasang dan variabel `JAVA_HOME` aktif.
- [x] Android Studio, Android SDK, dan `cmdline-tools` terpasang.
- [x] Lisensi Android telah disetujui (`flutter doctor --android-licenses`).
- [x] Emulator AVD atau HP Fisik berhasil terdeteksi di `flutter devices`.
- [x] VS Code dan ekstensi Flutter/Dart siap digunakan.
- [x] `flutter doctor -v` menunjukkan status bebas masalah (*No issues found!*).

---

👉 **Langkah Selanjutnya**: Lingkungan kerja Anda kini 100% siap tempur! Mari melangkah ke **[Modul 01: Fondasi Dart 3+, OOP, & Concurrency](../modul-01-dart-dan-concurrency/README.md)** untuk menguasai logika pemrograman modern Dart.

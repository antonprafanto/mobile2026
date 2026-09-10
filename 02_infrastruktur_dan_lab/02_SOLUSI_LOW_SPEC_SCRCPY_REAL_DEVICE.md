# SOLUSI LAB LOW-SPEC: REAL DEVICE DEBUGGING, SCRCPY, & FAST TARGETS
## Mengatasi Kendala RAM 8 GB Tanpa Mengorbankan Pengalaman Belajar

---

## 1. Problem Statement: Mengapa Android Emulator Menjadi "Musuh Utama" Lab?

Android Virtual Device (AVD / Emulator) membutuhkan:
1. Alokasi RAM permanen: **2.0 GB - 3.5 GB**.
2. Virtualisasi CPU berat (VT-x / AMD-V) yang memicu panas berlebih pada laptop tipis.
3. Waktu *cold boot* emulator yang memakan waktu 3–5 menit saat awal kelas dimulai.

> **Dampaknya:** Pada komputer laboratorium dengan RAM 8 GB, membuka VS Code (1 GB) + OS Windows (3.5 GB) + Android Studio/Emulator (3.5 GB) = **Total 8 GB (100% RAM Usage)**. Akibatnya sistem mengalami *thrashing*, mouse patah-patah (*freezing*), dan aplikasi sering *force close*.

---

## 2. Solusi 1: Debugging pada Smartphone Fisik (Real Device)

Menggunakan smartphone Android fisik memindahkan seluruh beban eksekusi aplikasi dan RAM ke smartphone mahasiswa, sehingga komputer PC hanya bertugas mengkompilasi kode.

### Langkah Aktivasi USB Debugging di Smartphone:
1. Buka **Pengaturan (Settings)** $\rightarrow$ **Tentang Ponsel (About Phone)**.
2. Cari **Nomor Versi (Build Number)**, lalu **ketuk sebanyak 7 kali berturut-turut** hingga muncul notifikasi: *"Anda sekarang adalah seorang pengembang!"*.
3. Kembali ke Pengaturan $\rightarrow$ **Opsi Pengembang (Developer Options)**.
4. Aktifkan **Debugging USB (USB Debugging)**.
5. Hubungkan smartphone ke PC menggunakan kabel data USB berkualitas baik.
6. Pada pop-up layar smartphone: Centang *"Selalu izinkan dari komputer ini"* $\rightarrow$ Tekan **Izinkan (Allow)**.

### Verifikasi di Terminal:
```bash
adb devices
```
*Output yang benar:*
```text
List of devices attached
RF8M31ABCDE    device
```
*(Jika statusnya `unauthorized`, cek layar HP dan konfirmasi dialog otorisasi)*.

---

## 3. Solusi 2: Proyeksi Layar Menggunakan SCRCPY

Agar mahasiswa tidak perlu terus-menerus menunduk melihat HP fisik dan dosen/asisten dapat memantau pengerjaan langsung dari monitor, gunakan **Scrcpy** (*Screen Copy*).

* **Apa itu Scrcpy?** Aplikasi open-source berkinerja tinggi untuk menampilkan dan mengontrol smartphone Android di layar komputer melalui koneksi USB.
* **Keunggulan:** Konsumsi RAM komputer **hanya ~70 MB** (jauh lebih ringan dibanding emulator 3.5 GB), latensi sangat rendah (30–70 ms), dan mendukung input mouse & keyboard langsung dari PC.

### Cara Instalasi & Menjalankan Scrcpy:
1. **Windows (via Chocolatey atau Winget):**
   ```bash
   winget install Genymobile.scrcpy
   ```
   *Atau unduh file `.zip` portabel dari repositori resmi: `https://github.com/Genymobile/scrcpy/releases`*
2. **Menjalankan Scrcpy:**
   Setelah smartphone terhubung via USB Debugging, cukup ketik di terminal:
   ```bash
   scrcpy --max-size 1024 --video-bit-rate 4M
   ```
   *(Parameter batas resolusi 1024 dan bitrate 4M disarankan agar performa sangat mulus di PC spek rendah)*.
3. **Hasil:** Jendela layar smartphone akan muncul di monitor PC Anda secara instan layaknya emulator native!

---

## 4. Solusi 3: Wireless Debugging (Tanpa Kabel - Android 11+)

Jika kabel data lab terbatas atau longgar:
1. Pastikan PC dan Smartphone terhubung ke jaringan Wi-Fi laboratorium yang sama.
2. Di smartphone: Masuk ke **Opsi Pengembang** $\rightarrow$ Aktifkan **Debugging Nirkabel (Wireless Debugging)**.
3. Pilih **Sandingkan perangkat dengan kode penyandingan (Pair device with pairing code)**.
4. Di terminal PC, jalankan:
   ```bash
   adb pair 192.168.1.XX:PORT
   ```
   *(Masukkan kode 6-digit yang tertera di layar HP)*.
5. Setelah berhasil, sambungkan:
   ```bash
   adb connect 192.168.1.XX:PORT
   ```
6. Smartphone kini terdeteksi oleh `flutter devices` tanpa memerlukan kabel fisik.

---

## 5. Solusi 4: Trik Fast Iteration (Flutter Web / Windows Desktop)

Untuk modul pertemuan awal (**M1 hingga M5** yang berfokus murni pada layouting widget, theming, dan form):

* Menjalankan build Android pertama kali membutuhkan waktu **2–5 menit** untuk proses kompilasi Gradle.
* **Trik Dosen:** Instruksikan mahasiswa untuk menjalankan target **Chrome** atau **Windows Desktop**:
  ```bash
  flutter run -d chrome
  # atau
  flutter run -d windows
  ```
* **Keuntungan:** Waktu build awal hanya **5–15 detik**, hot reload bekerja sangat instan, dan tidak membutuhkan memori Android emulator sama sekali.
* Begitu masuk ke modul integrasi hardware (Materi Kamera/Sensor di M12), barulah beralih ke perangkat smartphone fisik.

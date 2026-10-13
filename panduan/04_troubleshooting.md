# 🩺 Panduan Troubleshooting (Mengatasi Masalah)

[🏠 Beranda](../README.md) · [📚 Daftar Panduan](01_cara_belajar.md#daftar-panduan)

Sebelum panik, ingat tiga langkah emas ini:

1. **Baca pesan error-nya** pelan-pelan, terutama baris pertama.
2. **Cari kata kunci pesan tersebut** di halaman ini (`Ctrl` + `F`).
3. Jika belum terpecahkan, **bertanyalah dengan format yang baik** (lihat [Cara Bertanya](01_cara_belajar.md#8-cara-bertanya-yang-baik)).

---

## A. Masalah Instalasi

### `'flutter' is not recognized as an internal or external command`

**Penyebab:** folder `flutter\bin` belum masuk PATH, atau terminal belum dibuka ulang setelah instalasi.
**Solusi:** tutup semua terminal dan VS Code, lalu buka kembali. Jika masih gagal, ikuti [Panduan Instalasi bagian 5](02_instalasi_flutter_windows.md#5-jika-perintah-flutter-tidak-dikenali).

### `The Flutter SDK is installed in a protected folder and may not function correctly.`

**Penyebab:** SDK dipasang di folder yang butuh hak administrator, misalnya `C:\Program Files\`.
**Solusi:** pindahkan folder `flutter` ke lokasi lain, misalnya `C:\Users\NamaAnda\develop\flutter`, lalu perbarui PATH.

### Berkas `flutter.bat` hilang dari folder `bin`

**Penyebab:** antivirus mengkarantina berkas tersebut.
**Solusi:** izinkan (*whitelist*) folder Flutter di pengaturan antivirus, lalu ekstrak atau unduh ulang SDK.

### `Invoke-Expression : You cannot call a method on a null-valued expression.`

**Penyebab:** pengaturan PowerShell di komputer Anda membatasi skrip.
**Solusi:** buka PowerShell **sebagai Administrator**, lalu jalankan:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### `Waiting for another flutter command to release the startup lock...`

**Penyebab:** ada perintah `flutter` lain yang masih berjalan, misalnya VS Code sedang menyiapkan proyek.
**Solusi:** tunggu sebentar. Jika tidak kunjung selesai, tutup VS Code dan semua terminal, lalu coba lagi.

### `Got TLS error trying to find package ... at https://pub.dev/` atau `exit code: 69`

**Penyebab:** masalah koneksi internet saat mengunduh paket.
**Solusi:** periksa koneksi, mulai ulang komputer dan perangkat jaringan, lalu coba lagi. Jika jaringan kampus memblokir akses, coba jaringan lain.

---

## B. Masalah Android

### `cmdline-tools component is missing`

**Solusi:** buka Android Studio → **More Actions → SDK Manager** → tab **SDK Tools** → centang **Android SDK Command-line Tools (latest)** → **Apply**.

### `Android license status unknown.`

**Solusi:** jalankan `flutter doctor --android-licenses`, lalu ketik `y` untuk setiap lisensi.

### HP Android tidak muncul di `flutter devices`

Periksa satu per satu:

1. Kabel yang dipakai adalah **kabel data**, bukan kabel yang hanya untuk mengisi daya. Coba kabel lain.
2. **Debugging USB** sudah aktif di **Opsi pengembang**.
3. Dialog *"Izinkan debugging USB?"* di HP sudah dijawab **Izinkan**. Jika tidak muncul, cabut lalu pasang kembali kabelnya.
4. Di Windows, beberapa merek HP membutuhkan *driver* USB khusus dari produsennya.

### `java.lang.UnsupportedClassVersionError ...`

**Penyebab:** ada beberapa versi Java di komputer Anda.
**Solusi:** jika tidak membutuhkannya, hapus JDK lain. Flutter otomatis memakai JDK bawaan Android Studio.

---

## C. Masalah Saat Menjalankan Aplikasi

### Chrome tidak muncul di daftar perangkat

Jika `flutter doctor` menampilkan `Cannot find Chrome. Try setting CHROME_EXECUTABLE to a Chrome executable.`:

1. Pasang Google Chrome dari <https://www.google.com/chrome>.
2. Jika Chrome terpasang di lokasi tidak biasa, buat *environment variable* bernama `CHROME_EXECUTABLE` yang berisi lokasi lengkap berkas `chrome.exe`.

### `Building with plugins requires symlink support.`

**Solusi:** aktifkan *Developer Mode* Windows. Jalankan `start ms-settings:developers`, lalu nyalakan **Developer Mode**.

### Perubahan kode tidak terlihat di aplikasi

| Kemungkinan | Solusi |
| :--- | :--- |
| Aplikasi dijalankan dari terminal | Setelah menyimpan, tekan `r` di terminal. |
| Yang diubah isi `main()` atau nilai awal variabel | Lakukan *hot restart*: tekan `R`. |
| Menambah paket baru di `pubspec.yaml` | Hentikan aplikasi (`q`), lalu jalankan ulang. |

### Layar merah bertuliskan `No Directionality widget found.`

**Penyebab:** widget teks dipakai tanpa `MaterialApp` dan tanpa `textDirection`.
**Solusi:** bungkus aplikasi dengan `MaterialApp` (lihat [Pertemuan 1, Contoh 02](../pertemuan_01_pengenalan_flutter/kode/contoh_02_materialapp_dan_scaffold.dart)).

---

## D. Masalah Penulisan Kode

### Garis merah di VS Code

Garis merah = **error** (kode tidak bisa dijalankan). Arahkan *mouse* ke garis tersebut untuk membaca pesannya. Penyebab paling umum:

- Lupa titik koma `;`.
- Kurung `(`, `[`, atau `{` tidak berpasangan.
- Salah ketik nama (ingat, huruf besar dan kecil dibedakan).

### Garis kuning atau biru di VS Code

Garis kuning = **peringatan** (*warning*); garis biru = **saran** (*info/lint*). Kode tetap bisa berjalan, tetapi sebaiknya diperbaiki agar kode bersih. Banyak saran bisa diperbaiki otomatis dengan menekan `Ctrl` + `.` (titik) pada baris tersebut.

### Error saat membaca `pubspec.yaml`

**Penyebab:** ada karakter Tab, atau indentasi tidak rata.
**Solusi:** gunakan **spasi** (2 spasi per tingkat), bukan Tab. Pastikan setiap tingkat sejajar dengan rapi.

### Kesalahan umum bahasa Dart

Lihat tabel lengkap di [Pertemuan 2, Bagian 15](../pertemuan_02_dasar_dart/README.md#15-kesalahan-umum-pemula-dan-solusinya).

---

## Masih Belum Terpecahkan?

1. Jalankan `flutter doctor -v` dan simpan hasilnya.
2. Cari pesan error Anda di [halaman troubleshooting resmi Flutter](https://docs.flutter.dev/install/troubleshoot).
3. Tanyakan ke dosen atau asisten dengan [format pertanyaan yang baik](01_cara_belajar.md#8-cara-bertanya-yang-baik), sertakan hasil `flutter doctor -v` dan *screenshot*.

[🏠 Beranda](../README.md)

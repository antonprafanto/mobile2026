# 🧪 Jobsheet Pertemuan 1 — Memasang Flutter & Membuat Aplikasi Pertama

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [✍️ Latihan](LATIHAN.md) · [💻 Kode Contoh](kode/)

| Informasi | Keterangan |
| :--- | :--- |
| Mata kuliah | Pemrograman Piranti Bergerak |
| Pertemuan | 1 — Pengenalan Flutter |
| Bentuk kegiatan | Praktikum individu |
| Estimasi waktu | 90–120 menit (bergantung kecepatan instalasi dan internet) |
| Hasil akhir | Aplikasi "Kartu Perkenalan" berjalan di Chrome |

---

## 🎯 Tujuan Praktikum

Setelah menyelesaikan jobsheet ini, Anda mampu:

1. Memeriksa kesiapan alat kerja Flutter memakai `flutter doctor`.
2. Membuat proyek Flutter baru dan menjalankannya di Google Chrome.
3. Membuktikan perbedaan *hot reload* dan *hot restart*.
4. Menyusun halaman sederhana dari beberapa widget siap pakai.

## 🧰 Alat dan Bahan

- Komputer/laptop dengan Git, VS Code + ekstensi Flutter, Flutter SDK, dan Google Chrome.
  Belum terpasang? Ikuti dulu **[Panduan Instalasi Flutter di Windows](../panduan/02_instalasi_flutter_windows.md)**.
- Koneksi internet (untuk perintah pertama kali).
- (Opsional) HP Android dan kabel data USB.

## 📌 Petunjuk Umum

> [!IMPORTANT]
> 1. Kerjakan **berurutan**. Setiap bagian memakai hasil bagian sebelumnya.
> 2. Setiap ada tanda **✅ Checkpoint**, cocokkan hasil Anda. Jangan lanjut sebelum hasilnya sesuai.
> 3. Jika muncul error, **baca pesan error-nya pelan-pelan** dan cocokkan dengan tabel [Kesalahan Umum](README.md#13-kesalahan-umum-pemula-dan-solusinya) sebelum bertanya.
> 4. Ambil *screenshot* di setiap checkpoint yang bertanda 📸. Anda membutuhkannya untuk pengumpulan.

---

## Bagian A — Memeriksa Alat Kerja

**Langkah A1.** Buka VS Code, lalu buka terminal lewat menu **Terminal → New Terminal** (atau tekan `` Ctrl + ` ``).

**Langkah A2.** Ketik perintah berikut, lalu tekan `Enter`:

```bash
flutter --version
```

Anda akan melihat versi Flutter dan Dart, kira-kira seperti ini (angkanya boleh sedikit berbeda):

```text
Flutter 3.47.x • channel stable • https://github.com/flutter/flutter.git
...
Tools • Dart 3.13.x • DevTools ...
```

**Langkah A3.** Jalankan pemeriksaan kesehatan alat:

```bash
flutter doctor
```

Tunggu sampai selesai (pertama kali bisa memakan waktu 1–2 menit).

> ### ✅ Checkpoint A 📸
> - Baris **Flutter** bertanda `[✓]`.
> - Baris **Chrome - develop for the web** bertanda `[✓]`.
> - Tanda `[✗]` pada *Android toolchain* atau *Visual Studio* **boleh diabaikan** untuk minggu ini.
>
> Ambil *screenshot* hasil `flutter doctor`.

<details>
<summary>❓ Muncul pesan <code>'flutter' is not recognized ...</code>?</summary>

Artinya terminal belum mengenal perintah `flutter`.

1. Tutup **semua** jendela terminal dan VS Code, lalu buka kembali.
2. Jika masih gagal, ikuti bagian *Menambahkan Flutter ke PATH* di [panduan instalasi](../panduan/02_instalasi_flutter_windows.md#5-jika-perintah-flutter-tidak-dikenali).
</details>

---

## Bagian B — Membuat dan Menjalankan Proyek

**Langkah B1.** Siapkan folder kerja khusus mata kuliah ini, misalnya `C:\ppb`. Hindari folder yang namanya mengandung spasi.

**Langkah B2.** Di terminal, masuk ke folder tersebut lalu buat proyek:

```bash
cd C:\ppb
flutter create halo_flutter
```

Tunggu sampai muncul pesan `All done!`.

**Langkah B3.** Buka proyek di VS Code:

```bash
cd halo_flutter
code .
```

> [!TIP]
> Jika VS Code menampilkan pertanyaan *"Do you trust the authors of the files in this folder?"*, pilih **Yes, I trust the authors**. Proyek ini buatan Anda sendiri.

**Langkah B4.** Di jendela VS Code yang baru, buka terminal lagi dan jalankan:

```bash
flutter run -d chrome
```

Atau, cara lainnya: buka `lib/main.dart`, pilih **Chrome** di pojok kanan bawah VS Code, lalu tekan `F5`.

> ### ✅ Checkpoint B 📸
> Jendela Chrome terbuka dan menampilkan aplikasi **Flutter Demo Home Page** berisi angka `0` dan tombol `+` di kanan bawah. Tekan tombol `+` dan pastikan angkanya bertambah. Ambil *screenshot*.

---

## Bagian C — Membuktikan Hot Reload dan Hot Restart

Biarkan aplikasi dari Bagian B tetap berjalan.

**Langkah C1.** Tekan tombol `+` sampai angka menjadi **5**.

**Langkah C2.** Buka `lib/main.dart`. Cari baris yang berisi `seedColor` (sekitar baris 31):

```dart
colorScheme: .fromSeed(seedColor: Colors.deepPurple),
```

Ganti `Colors.deepPurple` menjadi `Colors.green`, lalu simpan dengan `Ctrl` + `S`.

> [!NOTE]
> Jika Anda menjalankan aplikasi lewat **terminal**, menyimpan berkas saja tidak cukup. Klik terminal tempat `flutter run` berjalan, lalu tekan tombol **`r`** (huruf kecil).

**Langkah C3.** Amati aplikasi di Chrome. Tulis jawaban Anda:

- Apakah warna aplikasi berubah? ...........
- Berapa angka penghitung sekarang? ...........

**Langkah C4.** Sekarang lakukan *hot restart*: tekan **`R`** (huruf besar) di terminal, atau klik ikon 🔄 di VS Code.

- Berapa angka penghitung sekarang? ...........

> ### ✅ Checkpoint C
> Setelah *hot reload*, warna berubah **dan angka tetap 5**. Setelah *hot restart*, angka **kembali ke 0**. Jika hasil Anda berbeda, ulangi Bagian C dengan teliti.

**Langkah C5.** Masih di `lib/main.dart`, cari teks `'You have pushed the button this many times:'` (tekan `Ctrl` + `F` untuk mencari; letaknya sekitar baris 107). Ganti menjadi `'Tombol sudah ditekan sebanyak:'`, simpan, lalu amati hasilnya.

---

## Bagian D — Membuat Kartu Perkenalan (Langkah Terbimbing)

Sekarang kita membuat halaman sendiri dari nol. Kita akan **mengganti seluruh isi** `lib/main.dart`.

### Langkah D1 — Kerangka aplikasi

Hapus seluruh isi `lib/main.dart` (`Ctrl` + `A`, lalu `Delete`), kemudian ketik kode berikut. Usahakan **mengetik sendiri**, jangan menyalin, agar tangan Anda terbiasa.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiProfil());
}

class AplikasiProfil extends StatelessWidget {
  const AplikasiProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HalamanProfil(),
    );
  }
}

class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kartu Perkenalan')),
      body: const Center(child: Text('Isi profil akan muncul di sini')),
    );
  }
}
```

Karena isi `main()` berubah, lakukan ***hot restart*** (`R`).

> [!TIP]
> **Trik VS Code yang menghemat waktu:**
> - `Ctrl` + `Spasi`: memunculkan saran kode (*autocomplete*).
> - `Shift` + `Alt` + `F`: merapikan kode secara otomatis (*Format Document*).
> - Arahkan *mouse* ke nama widget untuk membaca penjelasannya.
> - Garis bawah merah = ada kesalahan. Arahkan *mouse* ke garis tersebut untuk membaca pesannya.

> ### ✅ Checkpoint D1
> Aplikasi menampilkan judul **Kartu Perkenalan** dan tulisan *Isi profil akan muncul di sini* di tengah layar.

### Langkah D2 — Foto profil, nama, dan NIM

Ganti seluruh fungsi `build()` milik `HalamanProfil` dengan kode berikut:

```dart
  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Kartu Perkenalan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(radius: 48, child: Icon(Icons.person, size: 48)),
          const SizedBox(height: 12),
          Text(
            'Nama Lengkap Anda',
            textAlign: TextAlign.center,
            style: gayaTeks.headlineSmall,
          ),
          const Text('NIM 2026000000', textAlign: TextAlign.center),
        ],
      ),
    );
  }
```

Simpan, lalu lakukan *hot reload*. Penjelasan widget baru:

| Widget / properti | Fungsi |
| :--- | :--- |
| `ListView` | Menyusun anak-anaknya dari atas ke bawah **dan bisa digulir**. Aman untuk layar HP yang pendek. |
| `padding: EdgeInsets.all(16)` | Memberi jarak 16 piksel di keempat sisi. |
| `CircleAvatar` | Lingkaran untuk foto profil. Untuk sementara diisi ikon orang. |
| `SizedBox(height: 12)` | Jarak kosong setinggi 12 piksel. |
| `textAlign: TextAlign.center` | Membuat tulisan rata tengah. |
| `gayaTeks.headlineSmall` | Gaya teks judul dari tema Material 3. |

> ### ✅ Checkpoint D2
> Muncul lingkaran berikon orang, nama (huruf besar), dan NIM di bawahnya.

### Langkah D3 — Kartu informasi

Tambahkan kode berikut **di dalam daftar `children`**, tepat setelah baris `const Text('NIM 2026000000', ...)`:

```dart
          const SizedBox(height: 16),
          const Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.school),
                  title: Text('Program Studi'),
                  subtitle: Text('Informatika'),
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email'),
                  subtitle: Text('nama@mahasiswa.kampus.ac.id'),
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Hobi'),
                  subtitle: Text('Membuat aplikasi mobile'),
                ),
              ],
            ),
          ),
```

Simpan dan lakukan *hot reload*.

| Widget | Fungsi |
| :--- | :--- |
| `Card` | Kartu bawaan Material 3 dengan sudut membulat dan warna latar yang serasi dengan tema. |
| `Column` | Menyusun anak-anaknya dari atas ke bawah (tanpa fitur gulir). |
| `ListTile` | Satu baris informasi yang rapi: ikon di kiri (`leading`), judul (`title`), dan keterangan (`subtitle`). |

> [!WARNING]
> **Error paling sering di langkah ini:** kurung atau koma yang tertinggal. Jika muncul garis merah, cek apakah setiap `(` punya pasangan `)` dan setiap `[` punya pasangan `]`. Tekan `Shift` + `Alt` + `F` untuk merapikan; jika perapian gagal, berarti masih ada kurung yang belum berpasangan.

### Langkah D4 — Isi dengan data Anda

Ganti *Nama Lengkap Anda*, NIM, program studi, email, dan hobi dengan **data Anda sendiri**. Simpan dan amati hasilnya.

> ### ✅ Checkpoint D 📸
> Halaman menampilkan avatar, nama, NIM, dan kartu berisi tiga baris informasi milik Anda. Bandingkan kode Anda dengan [kode/07_kartu_perkenalan.dart](kode/07_kartu_perkenalan.dart). Ambil *screenshot*.

---

## Bagian E — (Opsional) Menjalankan di HP Android

Kerjakan bagian ini jika Anda membawa HP Android dan Android Studio sudah terpasang.

1. Aktifkan **Opsi pengembang** dan **Debugging USB** di HP (lihat [Modul Bagian 9.2](README.md#92-di-hp-android-asli-opsional-butuh-android-studio)).
2. Sambungkan HP dengan kabel data, lalu ketuk **Izinkan** di HP.
3. Jalankan `flutter devices` dan pastikan HP Anda tercantum.
4. Jalankan `flutter run`. Jika ada beberapa perangkat, pilih nomor perangkat HP Anda.

Proses pertama kali bisa memakan waktu beberapa menit karena Flutter membangun aplikasi Android dari awal.

---

## Bagian F — Tugas Mandiri (Tantangan)

Kembangkan Kartu Perkenalan Anda dengan ketentuan berikut:

1. Seluruh data sudah memakai **data diri Anda** (nama, NIM, program studi, email kampus).
2. Tambahkan **minimal dua `ListTile` baru**, misalnya *Asal Kota* dan *Motto Hidup*, dengan ikon yang sesuai. Cari nama ikon di <https://fonts.google.com/icons> (contoh: `Icons.location_city`, `Icons.format_quote`).
3. Ganti warna benih tema (`seedColor`) dengan **warna favorit** Anda.
4. Ubah judul `AppBar` menjadi **`Profil <Nama Panggilan Anda>`**.
5. ⭐ **Nilai tambah:** aktifkan mode gelap dengan menambahkan `brightness: Brightness.dark` di dalam `ColorScheme.fromSeed(...)`. Bagaimana perubahan tampilannya?

---

## 📤 Pengumpulan

Kumpulkan melalui tempat yang ditentukan dosen (LMS/Google Classroom/lainnya):

1. Berkas `lib/main.dart` hasil **Bagian F**, diberi nama `P01_NIM_NamaPanggilan.dart`.
2. Tiga *screenshot*: hasil `flutter doctor` (Checkpoint A), aplikasi *counter* (Checkpoint B), dan Kartu Perkenalan hasil Bagian F.

## 📊 Kriteria Penilaian

| Aspek | Indikator | Skor maks. |
| :--- | :--- | :---: |
| Kesiapan alat | `flutter doctor` menunjukkan Flutter dan Chrome siap | 15 |
| Menjalankan proyek | Aplikasi *counter* berjalan di Chrome | 15 |
| Kartu perkenalan | Bagian D lengkap dan berjalan tanpa error | 30 |
| Tugas mandiri | Kelima poin Bagian F terpenuhi (poin 5 sebagai nilai tambah) | 30 |
| Kerapian kode | Kode dirapikan (`Shift` + `Alt` + `F`) dan tidak ada garis merah/kuning | 10 |
| **Total** | | **100** |

## 💭 Refleksi

Jawab singkat di bagian akhir laporan Anda:

1. Bagian mana yang paling sulit hari ini, dan bagaimana Anda mengatasinya?
2. Dengan kata-kata Anda sendiri, apa beda *hot reload* dan *hot restart*?
3. Jika aplikasi Kartu Perkenalan dibuka di layar HP yang sangat pendek, mengapa `ListView` lebih aman daripada `Column`?

---

[⬅️ Kembali ke Modul](README.md) · [✍️ Lanjut ke Latihan](LATIHAN.md) · [🏠 Beranda](../README.md)

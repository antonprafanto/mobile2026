# ✍️ Latihan Pertemuan 1 — Pengenalan Flutter

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md)

Latihan ini membantu Anda mengukur pemahaman sebelum kuis. Kerjakan **tanpa membuka modul** terlebih dahulu. Setelah selesai, cocokkan jawaban dengan membaca ulang bagian modul yang disebut di petunjuk.

> [!NOTE]
> Kunci jawaban tidak dipublikasikan. Petunjuk (💡) hanya menunjukkan **bagian modul** yang perlu dibaca ulang. Pembahasan lengkap dilakukan bersama dosen di kelas.

---

## A. Pilihan Ganda

**1.** Ciri khas perangkat mobile yang membuat aplikasi harus tetap "sopan" ketika sinyal hilang adalah ...

- a. Layar sentuh
- b. Koneksi internet yang naik-turun
- c. Baterai yang terbatas
- d. Banyaknya sensor

**2.** Berdasarkan data StatCounter September 2026, sistem operasi mobile dengan pangsa pasar terbesar di Indonesia adalah ...

- a. iOS
- b. Android
- c. HarmonyOS
- d. Windows

**3.** Pendekatan yang membuat dua aplikasi terpisah, masing-masing memakai bahasa resmi platformnya (Kotlin untuk Android, Swift untuk iOS), disebut ...

- a. Native
- b. Web/hibrida
- c. Lintas platform
- d. *Progressive Web App*

**4.** Cara Flutter menampilkan tombol di layar adalah ...

- a. Meminjam tombol bawaan sistem operasi
- b. Membungkus halaman web di dalam aplikasi
- c. Menggambar sendiri tombolnya memakai mesin grafis Flutter
- d. Mengubah kode Dart menjadi HTML

**5.** Status siklus hidup ketika aplikasi **masih terlihat tetapi tidak menerima input** (misalnya saat panel notifikasi ditarik) adalah ...

- a. `resumed`
- b. `inactive`
- c. `paused`
- d. `detached`

**6.** Perintah untuk memeriksa apakah alat-alat Flutter sudah terpasang dengan benar adalah ...

- a. `flutter check`
- b. `flutter run`
- c. `flutter doctor`
- d. `flutter create`

**7.** Manakah nama proyek Flutter yang **valid**?

- a. `Tugas PPB`
- b. `tugas-ppb`
- c. `01_tugas_ppb`
- d. `tugas_ppb_01`

**8.** Berkas yang berfungsi sebagai "kartu identitas" proyek dan mencatat daftar paket tambahan adalah ...

- a. `lib/main.dart`
- b. `pubspec.yaml`
- c. `analysis_options.yaml`
- d. `README.md`

**9.** Saat `flutter run` berjalan di terminal, menekan tombol `r` (huruf kecil) akan ...

- a. Menghentikan aplikasi
- b. Melakukan *hot restart*
- c. Melakukan *hot reload*
- d. Menampilkan daftar perangkat

**10.** Widget yang menyediakan kerangka satu halaman lengkap dengan `appBar` dan `body` adalah ...

- a. `MaterialApp`
- b. `Scaffold`
- c. `Center`
- d. `Text`

<details>
<summary>💡 Petunjuk Bagian A</summary>

Soal 1 → Bagian 1 · Soal 2 → Bagian 2 · Soal 3 → Bagian 3 · Soal 4 → Bagian 5 · Soal 5 → Bagian 6 · Soal 6 → Bagian 7 · Soal 7–8 → Bagian 8 · Soal 9 → Bagian 9.4 · Soal 10 → Bagian 10.3
</details>

---

## B. Benar atau Salah

Tulis **B** jika pernyataan benar dan **S** jika salah. Untuk pernyataan yang salah, tuliskan versi yang benar.

1. *Hot restart* mempertahankan nilai *state*, misalnya angka penghitung.
2. Flutter hanya dapat membuat aplikasi untuk Android dan iOS.
3. Folder `build/` pada proyek Flutter aman dihapus karena akan dibuat ulang secara otomatis.
4. Indentasi di berkas `pubspec.yaml` boleh memakai tombol Tab.
5. Data penting sebaiknya disimpan ketika aplikasi masuk status `paused`, bukan menunggu status `detached`.

<details>
<summary>💡 Petunjuk Bagian B</summary>

Pernyataan 1 → Bagian 11 · Pernyataan 2 → Bagian 4.1 · Pernyataan 3–4 → Bagian 8 · Pernyataan 5 → Bagian 6.2
</details>

---

## C. Uraian Singkat

1. Dengan **analogi Anda sendiri** (bukan analogi katering di modul), jelaskan perbedaan pendekatan *native* dan lintas platform. Dalam kondisi apa sebuah perusahaan lebih baik memilih *native*?
2. Sebuah aplikasi pemutar musik dan sebuah aplikasi kamera sama-sama masuk status `paused`. Apa yang **sebaiknya** dilakukan oleh masing-masing aplikasi? Jelaskan alasannya.
3. Mengapa menjalankan aplikasi di Google Chrome lebih disarankan daripada emulator untuk komputer lab dengan RAM 8 GB?

---

## D. Latihan Kode

### D1 — Modifikasi

Salin [`kode/contoh_02_materialapp_dan_scaffold.dart`](kode/contoh_02_materialapp_dan_scaffold.dart) ke `lib/main.dart`, lalu:

1. Ubah judul `AppBar` menjadi nama lengkap Anda.
2. Tambahkan tema dengan `ColorScheme.fromSeed` memakai warna `Colors.orange`.
   (Petunjuk: `MaterialApp` di contoh itu diawali `const`. Anda perlu menghapus `const` tersebut karena `ThemeData(...)` tidak bisa dibuat sebagai konstanta.)
3. Ganti isi `body` agar menampilkan **dua baris** tulisan di tengah layar: nama mata kuliah dan nama kampus Anda. (Petunjuk: lihat cara `Column` dipakai di [Contoh 03](kode/contoh_03_tema_warna_dan_teks.dart).)

### D2 — Tebak Hasilnya

Tanpa menjalankannya, tebak apa yang terjadi jika kode berikut dijalankan:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const Center(child: Text('Halo')));
}
```

1. Apa yang muncul di layar?
2. Sebutkan **dua cara** berbeda untuk memperbaikinya.

Setelah menebak, jalankan kodenya untuk membuktikan tebakan Anda.

<details>
<summary>💡 Petunjuk D2</summary>

Bandingkan dengan [Contoh 01](kode/contoh_01_aplikasi_pertama.dart) dan baca baris terakhir tabel di [Bagian 13](README.md#13-kesalahan-umum-pemula-dan-solusinya).
</details>

### D3 — Temukan Kesalahannya

Kode berikut memiliki **tiga kesalahan** sehingga tidak bisa dijalankan. Temukan dan perbaiki semuanya.

```dart
import 'package:flutter/material.dart'

void Main() {
  runApp(const AplikasiKu());
}

class AplikasiKu extends StatelessWidget {
  const AplikasiKu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Latihan')),
        body: const Center(child: Text('Halo'),
      ),
    );
  }
}
```

<details>
<summary>💡 Petunjuk D3</summary>

Periksa (1) akhir baris `import`, (2) nama fungsi pintu masuk program (huruf besar/kecil berpengaruh!), dan (3) pasangan tanda kurung pada baris `body`. Tempelkan kode ke VS Code; garis merah akan membantu Anda.
</details>

---

[⬅️ Kembali ke Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md) · [➡️ Pertemuan 2](../pertemuan_02_dasar_dart/README.md)

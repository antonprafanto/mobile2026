# MODUL PRAKTIKUM 01: LINGKUNGAN KERJA & PEMROGRAMAN DART MODERN
## Laboratorium Rekayasa Perangkat Lunak - Teknik Informatika

---

## 1. Tujuan Pembelajaran
1. Mahasiswa mampu mengonfigurasi Flutter SDK, VS Code, dan Android Toolchain pada mesin lokal/lab.
2. Mahasiswa mampu menghubungkan smartphone fisik Android via USB Debugging dan memproyeksikannya dengan Scrcpy.
3. Mahasiswa mampu memecahkan masalah logika menggunakan sintaks modern Dart: *Sound Null Safety*, *Collections*, dan operasi *Asynchronous (Future, async/await, Stream)*.

---

## 2. Alat dan Bahan
* Komputer Lab / Laptop (OS Windows 10/11 atau Linux/macOS).
* Smartphone Android fisik + Kabel data USB.
* Software terinstal: Git, VS Code, Flutter SDK, Scrcpy.

---

## 3. Langkah Kerja Terpandu

### Bagian A: Verifikasi Lingkungan & Eksekusi Perdana
1. Buka terminal VS Code, jalankan verifikasi:
   ```bash
   flutter doctor
   ```
2. Pastikan smartphone terdeteksi:
   ```bash
   flutter devices
   ```
3. Buka terminal baru, jalankan Scrcpy untuk memantau layar HP di monitor:
   ```bash
   scrcpy --max-size 1024
   ```
4. Buat proyek perdana di folder workspace:
   ```bash
   flutter create hello_mobile
   cd hello_mobile
   flutter run
   ```
5. Buka `lib/main.dart`, ubah `primarySwatch: Colors.blue` menjadi `Colors.deepOrange`, tekan tombol `r` di terminal untuk melakukan **Hot Reload**. Amati perubahan instan di layar.

---

### Bagian B: Eksplorasi Logika Asynchronous Dart
Buat berkas mandiri `dart_async_test.dart` untuk menguji pemahaman aliran asynchronous:

```dart
import 'dart:async';

// 1. Model Data
class Mahasiswa {
  final String nim;
  final String nama;

  Mahasiswa({required this.nim, required this.nama});

  @override
  String toString() => 'Mahasiswa(NIM: $nim, Nama: $nama)';
}

// 2. Fungsi Simulasi Fetch Data Jaringan (Future)
Future<Mahasiswa> fetchMahasiswaData(String nim) async {
  print('⏳ Mengambil data mahasiswa dari server...');
  await Future.delayed(const Duration(seconds: 2)); // Simulasi latensi jaringan
  
  if (nim.isEmpty) {
    throw Exception('NIM tidak boleh kosong!');
  }
  
  return Mahasiswa(nim: nim, nama: 'Anton Wibisono');
}

// 3. Fungsi Simulasi Sensor Suhu / Detak Jantung (Stream)
Stream<int> streamHeartRate() async* {
  int currentRate = 72;
  for (int i = 0; i < 5; i++) {
    await Future.delayed(const Duration(seconds: 1));
    currentRate += (i.isEven ? 2 : -1);
    yield currentRate; // Memancarkan data baru secara berkala
  }
}

Future<void> main() async {
  print('=== UJI COBA ASYNCHRONOUS DART ===');

  // Menguji Future
  try {
    final mhs = await fetchMahasiswaData('12345678');
    print('✅ Data Berhasil Diterima: $mhs');
  } catch (e) {
    print('❌ Error: $e');
  }

  // Menguji Stream
  print('\n⏳ Memulai pemantauan sensor reaktif (Stream):');
  await for (final bpm in streamHeartRate()) {
    print('💓 Detak Jantung Saat Ini: $bpm BPM');
  }
  print('🏁 Pemantauan sensor selesai.');
}
```

---

## 4. Tugas Latihan Mandiri (Graded Lab Task)

> **Tantangan Praktikum 1 (Batas Waktu: Akhir Sesi Lab):**
> 1. Buat fungsi asynchronous bernama `hitungNilaiAkhir(double tugas, double uts, double uas)` yang mengembalikan `Future<String>`.
> 2. Di dalam fungsi, buat simulasi proses kalkulasi selama 1.5 detik.
> 3. Terapkan validasi: jika ada nilai yang bernilai negatif ($< 0$) atau $> 100$, lemparkan *custom exception* `NilaiInvalidException`.
> 4. Nilai Akhir dihitung dengan bobot: Tugas 30%, UTS 30%, UAS 40%.
> 5. Kembalikan huruf mutu (A, B, C, D, atau E) sesuai standar akademik.
> 6. Commit seluruh kode ke repositori GitHub Classroom Anda dengan pesan: `feat: complete lab 01 async challenge`.

---

## 5. Lembar Penilaian Praktikum 01

| Komponen Penilaian | Bobot | Skor (0 - 100) |
| :--- | :---: | :---: |
| Kesiapan Environment & Keberhasilan Hot Reload di Real Device | 30% | |
| Ketepatan Penanganan Null Safety & Exception | 30% | |
| Kebenaran Logika Asynchronous Future/Stream | 30% | |
| Kerapihan Pesan Commit Git | 10% | |
| **Total Nilai Modul 01** | **100%** | |

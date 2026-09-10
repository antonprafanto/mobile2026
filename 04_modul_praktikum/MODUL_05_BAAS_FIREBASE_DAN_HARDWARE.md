# MODUL PRAKTIKUM 05: BACKEND-AS-A-SERVICE (FIREBASE) & HARDWARE INTEGRATION
## Laboratorium Rekayasa Perangkat Lunak - Teknik Informatika

---

## 1. Tujuan Pembelajaran
1. Mahasiswa mampu mengonfigurasi layanan **Firebase Authentication** dan **Cloud Firestore**.
2. Mahasiswa mampu mengakses fitur perangkat keras kamera/galeri menggunakan **ImagePicker**.
3. Mahasiswa mampu meminta persetujuan izin runtime (*Runtime Permissions*) dan mendapatkan koordinat GPS menggunakan **Geolocator**.

---

## 2. Langkah Kerja Terpandu

### Bagian A: Akses Lokasi GPS & Penanganan Izin
Konfigurasikan izin pada file `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.CAMERA" />
```

Kode Dart untuk memeriksa izin dan membaca koordinat:
```dart
import 'package:geolocator/geolocator.dart';

Future<Position> determineUserPosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Layanan GPS tidak aktif, silakan aktifkan lokasi perangkat Anda.');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Izin akses lokasi ditolak oleh pengguna.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('Izin lokasi ditolak permanen. Buka pengaturan aplikasi untuk mengizinkan.');
  }

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}
```

---

### Bagian B: Mengambil Gambar dengan Kamera
```dart
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MediaService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromCamera() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1024,
      imageQuality: 85, // Kompresi gambar agar hemat bandwidth saat diunggah
    );

    if (photo != null) {
      return File(photo.path);
    }
    return null;
  }
}
```

---

## 3. Tugas Latihan Mandiri (Graded Lab Task)

> **Tantangan Praktikum 5 (Fitur Absensi Presensi Lapangan):**
> 1. Buat halaman "Presensi Kehadiran Mahasiswa":
>    * Tombol 1: **"Ambil Foto Selfie"** (Membuka kamera native dan menampilkan preview foto di layar).
>    * Tombol 2: **"Deteksi Lokasi Saya"** (Membaca latitude dan longitude saat ini).
> 2. Tombol **"Kirim Presensi"**:
>    * Menyimpan data presensi (Nama Mahasiswa, Waktu Timestamp, Koordinat Lokasi, dan Status Kehadiran) ke dalam koleksi Cloud Firestore `presensi_mahasiswa`.
> 3. Tampilkan daftar riwayat presensi yang tersimpan secara *real-time* menggunakan widget `StreamBuilder` terhubung ke Firestore.

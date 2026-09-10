# SLIDE DECK MATERI AJAR: PERTEMUAN 09 - 12
## Fase 3: Integrasi Data Jaringan, Basis Data Lokal, BaaS, & Fitur Native

---

# PERTEMUAN 09: Networking & RESTful API dengan Dio

### Slide 1: Arsitektur Komunikasi Jaringan Klien-Server
* **Topik:** HTTP Verbs (GET, POST, PUT, DELETE), Status Codes (200 OK, 400 Bad Request, 401 Unauthorized, 500 Server Error).
* **Mengapa Dio Lebih Baik dari `package:http` bawaan?**
  * Memiliki dukungan *Interceptors* (menyisipkan header token otomatis).
  * Pengaturan batas waktu (*timeouts*) bawaan.
  * Pembatalan permintaan (*request cancellation* dengan `CancelToken`).

### Slide 2: Serialisasi JSON Otomatis (Code Generation)
* **Masalah:** Mengakses `json['user_name']` secara manual sangat rentan salah ketik (*typo-prone*) dan tidak *type-safe*.
* **Solusi Industri:** Menggunakan `json_serializable` / `freezed`:
  ```dart
  @JsonSerializable()
  class UserModel {
    final int id;
    final String name;
    final String email;

    UserModel({required this.id, required this.name, required this.email});
    factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  }
  ```

### Slide 3: Pola State Antarmuka Jaringan (The 4 UI States)
* Setiap pemanggilan API di UI wajib menangani 4 status:
  1. `Initial`: Tampilan awal sebelum pengguna memicu aksi.
  2. `Loading`: Indikator berputar (*CircularProgressIndicator / Shimmer*).
  3. `Success`: Menampilkan data daftar/konten.
  4. `Failure`: Menampilkan pesan error ramah pengguna dengan tombol *"Coba Lagi"*.

---

# PERTEMUAN 10: Local Persistence & Offline-First Strategy

### Slide 1: Mengapa Aplikasi Modern Harus "Offline-First"?
* **Realita Lapangan:** Koneksi internet di Indonesia fluktuatif (masuk lift, basement, sinyal lemah). Aplikasi tidak boleh menampilkan layar putih atau crash saat internet terputus.
* **Strategi Caching:**
  1. Cek penyimpanan lokal (Database internal / Cache).
  2. Tampilkan data lokal segera (*instant render*).
  3. Di latar belakang, lakukan fetch ke API.
  4. Perbarui data lokal dan perbarui tampilan (*Cache-then-Network pattern*).

### Slide 2: Opsi Database Lokal di Flutter
* **Pilihan 1: SharedPreferences:** Khusus data sederhana key-value (token login, preferensi tema, status onboarding).
* **Pilihan 2: SQLite (via Drift/sqflite):** Bagus untuk data relasional kompleks dengan tabel berelasi.
* **Pilihan 3: Isar / Hive (Embedded NoSQL):** Kecepatan baca/tulis ultra tinggi (10x lebih cepat dari SQLite) dan sintaks ramah Dart.

---

# PERTEMUAN 11: Backend-as-a-Service (Firebase Cloud Integration)

### Slide 1: Pengantar Cloud BaaS untuk Mobile
* **Konsep:** Membangun backend lengkap (Autentikasi, Database, File Storage, Push Notif) tanpa perlu mengelola server virtual sendiri.
* **Setup:** Menggunakan `flutterfire configure` untuk mengaitkan konfigurasi Android (`google-services.json`) dan iOS (`GoogleService-Info.plist`) secara otomatis.

### Slide 2: Autentikasi Pengguna & Realtime Stream
* **Implementasi:**
  ```dart
  // Mendengarkan perubahan status login pengguna secara reaktif
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      router.go('/login');
    } else {
      router.go('/home');
    }
  });
  ```

---

# PERTEMUAN 12: Device Hardware, Geolocation, & Push Notifications

### Slide 1: Mengelola Runtime Permissions (Android 13+ & iOS)
* **Aturan OS Modern:** Mengakses kamera atau lokasi tidak cukup hanya dideklarasikan di `AndroidManifest.xml`. Pengguna harus dimintai persetujuan saat runtime (*Permission Request Flow*).
* **Library:** `permission_handler`.

### Slide 2: Kamera & Geolocation
* **Kasus Penggunaan:**
  * `image_picker`: Mengambil foto bukti pembayaran atau mengganti foto profil.
  * `geolocator`: Mendapatkan latitude & longitude untuk layanan absensi atau toko terdekat.
* **Push Notifications (FCM):**
  * Penanganan notifikasi saat aplikasi berada di: *Foreground*, *Background*, dan *Terminated State*.

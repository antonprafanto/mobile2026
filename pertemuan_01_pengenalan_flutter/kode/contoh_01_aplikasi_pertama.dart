// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 01: PENGENALAN FLUTTER
// CONTOH 01: Aplikasi Flutter Paling Sederhana
// Topik: runApp() menampilkan satu widget teks di tengah layar.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

// Mengimpor "kotak perkakas" Flutter berisi widget siap pakai.
import 'package:flutter/material.dart';

// main() adalah pintu masuk. Program SELALU mulai dari sini.
void main() {
  // runApp() = "pasang widget ini sebagai seluruh tampilan aplikasi".
  runApp(
    // Center menaruh anaknya (child) tepat di tengah layar.
    const Center(
      child: Text(
        'Halo, Dunia Flutter!',
        // WAJIB di sini: tanpa MaterialApp, Flutter belum tahu arah
        // tulisan, jadi kita beri tahu "kiri ke kanan" (ltr).
        textDirection: TextDirection.ltr,
        style: TextStyle(fontSize: 32),
      ),
    ),
  );
}

// PERHATIKAN HASILNYA:
// Layar hitam polos dengan tulisan putih. Belum ada judul, tombol,
// atau warna tema. Di Contoh 02 kita "membungkusnya" dengan
// MaterialApp dan Scaffold agar tampil seperti aplikasi sungguhan.

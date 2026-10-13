// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 01: PENGENALAN FLUTTER
// CONTOH 05: Membedah Aplikasi Counter Bawaan "flutter create"
// Topik: Isi lib/main.dart bawaan, dijelaskan dalam bahasa Indonesia.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================
// CATATAN: Template asli menulis `.fromSeed(...)` dan `.center`.
// Itu "dot shorthand" (singkatan titik, fitur Dart 3.10) yang artinya
// SAMA dengan `ColorScheme.fromSeed(...)` dan `MainAxisAlignment.center`.
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Akar aplikasi: menyiapkan judul, tema, dan halaman pertama.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// Halaman "Stateful": punya data yang bisa berubah (angka hitungan).
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title; // judul dikirim dari MyApp

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Kelas State: tempat data & tampilan yang bisa berubah disimpan.
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // garis bawah (_) = privat, hanya dipakai di berkas ini

  void _incrementCounter() {
    // Tanpa setState(), angka berubah di memori TETAPI layar tidak
    // digambar ulang, sehingga pengguna tidak melihat perubahan apa pun.
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // build() dijalankan ulang SETIAP kali setState() dipanggil.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title), // "widget." = akses data milik MyHomePage
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, // fungsi yang dijalankan saat ditekan
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 13: MEMBEDAH DEFAULT COUNTER APP
// TOPIK: Penjelasan Anotasi Tiap Baris, setState(), Tambah, Kurang, & Reset
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide13CounterApp());
}

class Slide13CounterApp extends StatelessWidget {
  const Slide13CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 13 - Counter App Deep Dive',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF38BDF8),
      ),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  // 1. VARIABEL STATE DI MEMORI
  int _counter = 0;

  // 2. FUNGSI PENAMBAH DENGAN setState()
  void _incrementCounter() {
    setState(() {
      _counter++;
    }); // <- Flutter menggambar ulang Text di layar seketika!
  }

  // 3. FUNGSI PENGURANG
  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  // 4. FUNGSI RESET KE NOL
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('SLIDE 13: Bedah Counter App bawaan Flutter'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Kartu Display Angka
              Container(
                width: 280,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2.5),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(5, 5)),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'TOTAL KLIK SAAT INI:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '$_counter',
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Tiga Tombol Operasi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton.filled(
                          style: IconButton.filled(
                            backgroundColor: const Color(0xFFFB7185),
                          ),
                          onPressed: _decrementCounter,
                          icon: const Icon(Icons.remove, color: Colors.black),
                        ),
                        IconButton.filled(
                          style: IconButton.filled(
                            backgroundColor: const Color(0xFFE2E8F0),
                          ),
                          onPressed: _resetCounter,
                          icon: const Icon(Icons.refresh, color: Colors.black),
                        ),
                        IconButton.filled(
                          style: IconButton.filled(
                            backgroundColor: const Color(0xFF4ADE80),
                          ),
                          onPressed: _incrementCounter,
                          icon: const Icon(Icons.add, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Kotak Penjelasan Cara Kerja setState()
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(3, 3)),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '❓ MENGAPA TOMBOL BISA MENGUBAH LAYAR?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '1. Variabel int _counter = 0; adalah tempat menyimpan angka.\n2. Saat tombol ditekan, fungsi setState() dipanggil.\n3. setState() memberi sinyal ke mesin Flutter: "Tolong jalankan ulang fungsi build() karena datanya sudah berubah!"\n4. Flutter hanya menggambar ulang teks angka tersebut dengan kecepatan milidetik.',
                      style: TextStyle(fontSize: 12, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Floating Action Button standar Flutter
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        onPressed: _incrementCounter,
        tooltip: 'Tambah Angka',
        child: const Icon(Icons.add),
      ),
    );
  }
}

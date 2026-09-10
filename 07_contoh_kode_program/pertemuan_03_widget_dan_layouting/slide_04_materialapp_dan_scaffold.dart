// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 04: MATERIALAPP & SCAFFOLD
// TOPIK: Pondasi Kanvas Standar Mobile & Anatomi Slot Scaffold
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide04ScaffoldApp());

class Slide04ScaffoldApp extends StatefulWidget {
  const Slide04ScaffoldApp({super.key});

  @override
  State<Slide04ScaffoldApp> createState() => _Slide04ScaffoldAppState();
}

class _Slide04ScaffoldAppState extends State<Slide04ScaffoldApp> {
  bool _showRawError = false;

  @override
  Widget build(BuildContext context) {
    // Demonstrasi jika mahasiswa lupa memasang Scaffold:
    if (_showRawError) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'TANPA SCAFFOLD:\nLayar hitam legam & teks garis bawah kuning ganda!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => setState(() => _showRawError = false),
                child: const Text('KEMBALIKAN KE SCAFFOLD'),
              ),
            ],
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        // 1. Slot AppBar (Bilah Judul Atas)
        appBar: AppBar(
          title: const Text(
            'SLIDE 04 • ANATOMI SCAFFOLD',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color(0xFFFFE600),
          elevation: 0,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.5),
          ),
        ),

        // 2. Slot Drawer (Menu Samping Navigasi)
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFFFFE600)),
                child: Text(
                  'Menu Navigasi Drawer',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                ),
              ),
              ListTile(leading: Icon(Icons.home), title: Text('Beranda')),
              ListTile(leading: Icon(Icons.person), title: Text('Profil')),
            ],
          ),
        ),

        // 3. Slot Body (Kanvas Konten Utama)
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2.5),
              boxShadow: const [
                BoxShadow(color: Colors.black, offset: Offset(5, 5)),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Fungsi Scaffold Sebagai Kerangka Kanvas:',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
                const SizedBox(height: 10),
                const Text(
                  '• Menyediakan slot AppBar, Body, Drawer, dan FloatingActionButton.\n'
                  '• Memberikan latar belakang putih bersih standar smartphone.\n'
                  '• Mengatur tata letak agar keyboard tidak menimpa elemen penting.',
                  style: TextStyle(fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => setState(() => _showRawError = true),
                  icon: const Icon(Icons.warning_amber_rounded),
                  label: const Text('SIMULASI: JIKA TANPA SCAFFOLD'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFB7185),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    side: const BorderSide(color: Colors.black, width: 2),
                    shape: const RoundedRectangleBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),

        // 4. Slot FloatingActionButton (Tombol Aksi Mengambang)
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tombol FloatingActionButton ditekan!'),
                backgroundColor: Colors.black,
              ),
            );
          },
          backgroundColor: const Color(0xFF4ADE80),
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 2),
          ),
          child: const Icon(Icons.add, color: Colors.black),
        ),
      ),
    );
  }
}

// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 09: PENYELAMAT LAYAR SAFEAREA
// TOPIK: Mencegah Teks Tertusuk Kamera Tompel / Notch & Navigation Bar
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide09SafeAreaApp());

class Slide09SafeAreaApp extends StatefulWidget {
  const Slide09SafeAreaApp({super.key});

  @override
  State<Slide09SafeAreaApp> createState() => _Slide09SafeAreaAppState();
}

class _Slide09SafeAreaAppState extends State<Slide09SafeAreaApp> {
  bool _useSafeArea = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        body: _useSafeArea ? SafeArea(child: _buildContent()) : _buildContent(),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color(0xFFFFE600),
            border: Border(top: BorderSide(color: Colors.black, width: 2.5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status SafeArea: ${_useSafeArea ? "AKTIF (AMAN)" : "MATI (BAHAYA)"}',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
              ElevatedButton(
                onPressed: () => setState(() => _useSafeArea = !_useSafeArea),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _useSafeArea
                      ? const Color(0xFFFB7185)
                      : const Color(0xFF4ADE80),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  side: const BorderSide(color: Colors.black, width: 2),
                  shape: const RoundedRectangleBorder(),
                ),
                child: Text(
                  _useSafeArea ? 'MATIKAN SAFEAREA' : 'AKTIFKAN SAFEAREA',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        // Simulasi Notch Kamera Tompel di Pojok Atas Layar HP
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 140,
            height: 28,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: const Center(
              child: Text(
                'NOTCH KAMERA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        // Konten Halaman
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                color: const Color(0xFF38BDF8),
                child: const Text(
                  'JUDUL HALAMAN APLIKASI (HEADER)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _useSafeArea
                    ? '✓ DENGAN SAFEAREA: Teks otomatis bergeser ke bawah notch dan tidak tertabrak kamera ponsel.'
                    : '✗ TANPA SAFEAREA: Jika Anda buka di HP berponi, teks di atas akan tertusuk modul kamera!',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _useSafeArea ? Colors.green[800] : Colors.red[800],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'SafeArea membaca EdgeInsets bawaan MediaQuery perangkat (status bar atas & gesture pill bawah), '
                'sehingga tampilan Anda selalu adaptif di iPhone maupun Android terkini.',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

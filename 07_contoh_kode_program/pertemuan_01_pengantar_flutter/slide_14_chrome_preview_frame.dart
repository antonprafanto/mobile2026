// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 14: SIMULATOR LAYAR HP DI GOOGLE CHROME
// TOPIK: Solusi Komputer Lab RAM 8GB (Tanpa Emulator Android yang Berat)
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide14ChromeFrameApp());
}

class Slide14ChromeFrameApp extends StatelessWidget {
  const Slide14ChromeFrameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 14 - Chrome Phone Frame Simulator',
      theme: ThemeData(useMaterial3: true),
      home: const PhoneSimulatorScreen(),
    );
  }
}

class PhoneSimulatorScreen extends StatelessWidget {
  const PhoneSimulatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E293B), // Slate Dark Canvas
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  '💻 KOMPILASI GOOGLE CHROME: HEMAT RAM < 150MB',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              // Bingkai Smartphone Fisik Mockup
              Container(
                width: 340,
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.black, width: 8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Scaffold(
                    backgroundColor: const Color(0xFFFAF8F5),
                    appBar: AppBar(
                      title: const Text(
                        'Aplikasi Mobile Saya',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: const Color(0xFFFFE600),
                      foregroundColor: Colors.black,
                      centerTitle: true,
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            size: 50,
                            color: Colors.green,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Kompilasi Sukses 5 Detik!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Dengan menargetkan Chrome, komputer lab RAM 8GB tetap adem dan tidak macet/freeze!',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onPressed: () {},
                            child: const Text('Tombol Interaktif'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

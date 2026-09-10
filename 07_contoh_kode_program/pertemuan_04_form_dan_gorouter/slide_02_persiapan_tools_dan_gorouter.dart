// =====================================================================
// SLIDE 02: PERSIAPAN TOOLS & VERIFIKASI GOROUTER
// Topik: Uji Kesiapan Pustaka Navigasi Deklaratif Standar Industri
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// Catatan: Pastikan paket go_router sudah terpasang (flutter pub add go_router)
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const SetupVerificationApp());
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SetupHomeScreen()),
  ],
);

class SetupVerificationApp extends StatelessWidget {
  const SetupVerificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Slide 02 - Verifikasi GoRouter',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      routerConfig: _router,
    );
  }
}

class SetupHomeScreen extends StatelessWidget {
  const SetupHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 02: Verifikasi GoRouter'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 72,
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              const Text(
                'GoRouter Berhasil Dikonfigurasi!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Aplikasi ini menggunakan MaterialApp.router dengan konfigurasi GoRouter resmi.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Perintah Esensial Terminal:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('1. Pasang dependensi: flutter pub add go_router'),
                      Text('2. Jalankan di Chrome : flutter run -d chrome'),
                    ],
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

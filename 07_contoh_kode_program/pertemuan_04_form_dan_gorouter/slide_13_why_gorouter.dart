// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 13: MENGAPA GOROUTER?
// TOPIK: Navigasi deklaratif berbasis URL standar industri 2026
// =====================================================================
// CARA MENJALANKAN:
// 1. Pastikan package go_router sudah terpasang: flutter pub add go_router
// 2. Salin seluruh isi berkas ini ke: lib/main.dart
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Slide13HomeScreen(),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) => const Slide13DetailScreen(),
    ),
  ],
);

void main() {
  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routerConfig: router,
  ));
}

class Slide13HomeScreen extends StatelessWidget {
  const Slide13HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SLIDE 13: GoRouter Beranda')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/detail'),
          child: const Text('Pindah ke /detail via context.go()'),
        ),
      ),
    );
  }
}

class Slide13DetailScreen extends StatelessWidget {
  const Slide13DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SLIDE 13: Layar Detail')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Kembali ke Beranda via context.go()'),
        ),
      ),
    );
  }
}

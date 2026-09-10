// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 15: CONTEXT.GO() VS CONTEXT.PUSH()
// TOPIK: Perbedaan mengganti rute vs menumpuk layar dengan tombol panah Back
// =====================================================================
// CARA MENJALANKAN:
// 1. Pastikan package go_router sudah terpasang: flutter pub add go_router
// 2. Salin seluruh isi berkas ini ke: lib/main.dart
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final routerActions = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const ScreenA()),
    GoRoute(path: '/screen-b', builder: (context, state) => const ScreenB()),
    GoRoute(path: '/screen-c', builder: (context, state) => const ScreenC()),
  ],
);

void main() {
  runApp(MaterialApp.router(routerConfig: routerActions, debugShowCheckedModeBanner: false));
}

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LAYAR A (PANGKAL)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.push('/screen-b'),
              child: const Text('1. Buka B via context.push() (Ada tombol Back)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/screen-c'),
              child: const Text('2. Buka C via context.go() (Ganti Rute / No Back)'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LAYAR B (DITUMPUK PUSH)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Perhatikan pojok kiri atas AppBar: ada tombol panah kembali!'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () => context.pop(), child: const Text('Tutup via context.pop()')),
          ],
        ),
      ),
    );
  }
}

class ScreenC extends StatelessWidget {
  const ScreenC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LAYAR C (DIGANTI GO)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Tidak ada tombol panah Back otomatis di pojok kiri atas!'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () => context.go('/'), child: const Text('Kembali ke A via context.go()')),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 14: KONFIGURASI GOROUTER & ERROR 404
// TOPIK: Menghubungkan routerConfig dan menangani rute tidak terdaftar
// =====================================================================
// CARA MENJALANKAN:
// 1. Pastikan package go_router sudah terpasang: flutter pub add go_router
// 2. Salin seluruh isi berkas ini ke: lib/main.dart
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/daftar', builder: (context, state) => const DaftarScreen()),
  ],
  // Penanganan Halaman 404 jika mahasiswa mengetik URL sembarangan di browser:
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('404 NOT FOUND'), backgroundColor: Colors.red),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 70, color: Colors.red),
          const SizedBox(height: 10),
          Text('Alamat "${state.uri}" Tidak Ditemukan!'),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: () => context.go('/'), child: const Text('Kembali')),
        ],
      ),
    ),
  ),
);

void main() {
  runApp(MaterialApp.router(routerConfig: appRouter, debugShowCheckedModeBanner: false));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SLIDE 14: Konfigurasi Router')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () => context.push('/daftar'), child: const Text('Buka /daftar')),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: () => context.push('/halaman-rusak'), child: const Text('Uji Rute 404 (Sengaja Salah)')),
          ],
        ),
      ),
    );
  }
}

class DaftarScreen extends StatelessWidget {
  const DaftarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Daftar')),
      body: Center(child: ElevatedButton(onPressed: () => context.pop(), child: const Text('Kembali (context.pop)'))),
    );
  }
}

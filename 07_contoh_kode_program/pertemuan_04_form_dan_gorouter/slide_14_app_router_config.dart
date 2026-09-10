// =====================================================================
// SLIDE 14: KONFIGURASI GOROUTER & HALAMAN ERROR 404
// Topik: Menangani Rute Tak Dikenal dengan errorBuilder
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const RouterConfigDemoApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  // Menangani rute URL yang tidak terdaftar (Error 404)
  errorBuilder: (context, state) =>
      NotFoundScreen(error: state.error.toString()),
  routes: [
    GoRoute(path: '/', builder: (context, state) => const ConfigHomeScreen()),
  ],
);

class RouterConfigDemoApp extends StatelessWidget {
  const RouterConfigDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Slide 14 - Router Config & 404',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      routerConfig: _router,
    );
  }
}

class ConfigHomeScreen extends StatelessWidget {
  const ConfigHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 14: Router Config'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Pengujian Halaman Error 404',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tekan tombol di bawah untuk mencoba membuka URL yang tidak terdaftar.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  // Memicu navigasi ke rute liar yang belum didefinisikan
                  context.go('/halaman-fiktif-yang-tidak-ada');
                },
                icon: const Icon(Icons.warning_amber_rounded),
                label: const Text('Buka Rute Tidak Dikenal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  final String error;
  const NotFoundScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('404: Tidak Ditemukan'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 72, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Halaman Tidak Ditemukan!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => context.go('/'),
                icon: const Icon(Icons.home),
                label: const Text('Kembali ke Beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

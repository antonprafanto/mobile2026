// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 17: QUERY PARAMETERS & EXTRA OBJECT
// TOPIK: Mengirim kueri filter (?keyword=) dan objek model kompleks (extra)
// =====================================================================
// CARA MENJALANKAN:
// 1. Pastikan package go_router sudah terpasang: flutter pub add go_router
// 2. Salin seluruh isi berkas ini ke: lib/main.dart
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Mahasiswa {
  final String nim;
  final String nama;
  final double ipk;
  const Mahasiswa({required this.nim, required this.nama, required this.ipk});
}

final queryRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/cari',
      builder: (context, state) {
        final q = state.uri.queryParameters['q'] ?? 'Kosong';
        return SearchResultScreen(query: q);
      },
    ),
    GoRoute(
      path: '/profil',
      builder: (context, state) {
        final mhs = state.extra as Mahasiswa;
        return ProfileScreen(mahasiswa: mhs);
      },
    ),
  ],
);

void main() {
  runApp(MaterialApp.router(routerConfig: queryRouter, debugShowCheckedModeBanner: false));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SLIDE 17: Query & Extra Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.push('/cari?q=Flutter2026'),
              child: const Text('1. Kirim Query Parameter (?q=Flutter2026)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.push(
                  '/profil',
                  extra: const Mahasiswa(nim: '2301092026', nama: 'Budi Santoso', ipk: 3.88),
                );
              },
              child: const Text('2. Kirim Objek Mahasiswa Utuh (extra)'),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResultScreen extends StatelessWidget {
  final String query;
  const SearchResultScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Pencarian')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Kata kunci query: "$query"', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () => context.pop(), child: const Text('KEMBALI')),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final Mahasiswa mahasiswa;
  const ProfileScreen({super.key, required this.mahasiswa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Mahasiswa (Dari Extra)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('NIM  : ${mahasiswa.nim}', style: const TextStyle(fontSize: 16)),
            Text('Nama : ${mahasiswa.nama}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('IPK  : ${mahasiswa.ipk}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => context.pop(), child: const Text('KEMBALI')),
          ],
        ),
      ),
    );
  }
}

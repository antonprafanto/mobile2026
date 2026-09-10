// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 16: PATH PARAMETERS (:id)
// TOPIK: Mengirim dan membaca ID unik pada URL (/buku/:id)
// =====================================================================
// CARA MENJALANKAN:
// 1. Pastikan package go_router sudah terpasang: flutter pub add go_router
// 2. Salin seluruh isi berkas ini ke: lib/main.dart
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final pathRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const KatalogScreen(),
    ),
    // Definisi rute dengan placeholder :id
    GoRoute(
      path: '/buku/:id',
      builder: (context, state) {
        // Membaca nilai :id dari URL
        final id = state.pathParameters['id']!;
        return DetailBukuScreen(bukuId: id);
      },
    ),
  ],
);

void main() {
  runApp(MaterialApp.router(routerConfig: pathRouter, debugShowCheckedModeBanner: false));
}

class KatalogScreen extends StatelessWidget {
  const KatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KATALOG DENGAN PATH PARAMETER')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: const Text('Buku #101: Flutter Modern'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => context.push('/buku/101'),
          ),
          ListTile(
            title: const Text('Buku #202: Clean Architecture'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => context.push('/buku/202'),
          ),
          ListTile(
            title: const Text('Buku #303: Dart Asynchronous'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => context.push('/buku/303'),
          ),
        ],
      ),
    );
  }
}

class DetailBukuScreen extends StatelessWidget {
  final String bukuId;
  const DetailBukuScreen({super.key, required this.bukuId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DETAIL BUKU #$bukuId')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ID yang dibaca dari URL: $bukuId', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () => context.pop(), child: const Text('KEMBALI')),
          ],
        ),
      ),
    );
  }
}

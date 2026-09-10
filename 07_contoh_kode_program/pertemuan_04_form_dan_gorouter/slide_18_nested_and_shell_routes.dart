// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 18: RUTE BERSARANG & STATEFULSHELLROUTE
// TOPIK: Nested routes & Bottom Navigation Bar tanpa kehilangan scroll
// =====================================================================
// CARA MENJALANKAN:
// 1. Pastikan package go_router sudah terpasang: flutter pub add go_router
// 2. Salin seluruh isi berkas ini ke: lib/main.dart
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const ShellDemoApp());
}

final shellRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (idx) => navigationShell.goBranch(idx),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Beranda'),
              NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
            ],
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (ctx, state) => Scaffold(
                appBar: AppBar(title: const Text('Tab Beranda (Scroll Preserved)')),
                body: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (ctx, i) => ListTile(title: Text('Item Beranda #$i')),
                ),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (ctx, state) => Scaffold(
                appBar: AppBar(title: const Text('Tab Profil')),
                body: const Center(child: Text('Halaman Profil Pengguna')),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

class ShellDemoApp extends StatelessWidget {
  const ShellDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: shellRouter,
    );
  }
}

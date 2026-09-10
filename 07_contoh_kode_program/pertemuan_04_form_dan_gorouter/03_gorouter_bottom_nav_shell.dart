// =====================================================================
// CONTOH KODE LENGKAP & SIAP DIJALANKAN (RUNNABLE FLUTTER APP)
// PERTEMUAN 04: BOTTOM NAVIGATION DENGAN STATEFULSHELLROUTE (GOROUTER)
// =====================================================================
// Keunggulan Arsitektur:
// Masing-masing tab mempertahankan posisi scroll dan status data
// di memori tanpa perlu re-fetching saat berganti tab!
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const ShellRouteDemoApp());
}

// 1. Kunci Navigator Utama
final _rootNavigatorKey = GlobalKey<NavigatorState>();

// 2. Konfigurasi GoRouter dengan StatefulShellRoute
final GoRouter shellRouter = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    // StatefulShellRoute menaungi beberapa cabang navigasi independen
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        // Cabang 1: Beranda / Feed Produk
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const TabHomeScreen(),
            ),
          ],
        ),

        // Cabang 2: Riwayat Pesanan
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/orders',
              builder: (context, state) => const TabOrdersScreen(),
            ),
          ],
        ),

        // Cabang 3: Profil Pengguna
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const TabProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class ShellRouteDemoApp extends StatelessWidget {
  const ShellRouteDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'StatefulShellRoute Bottom Nav',
      debugShowCheckedModeBanner: false,
      routerConfig: shellRouter,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAF8F5),
      ),
    );
  }
}

// 3. Template Scaffold Penampung Shell (BottomNavigationBar)
class ScaffoldWithNestedNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNestedNavigation({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index) {
    // Berpindah tab menggunakan goBranch
    navigationShell.goBranch(
      index,
      // Jika tab yang sama diklik ulang, kembali ke halaman awal tab tersebut
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell, // Menampilkan halaman tab yang sedang aktif
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black, width: 2.5)),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onTap,
          backgroundColor: Colors.white,
          indicatorColor: const Color(0xFFFFE600), // Kuning Canary Neo-Brutal
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: Colors.black),
              label: 'Beranda',
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined),
              selectedIcon: Icon(Icons.receipt_long, color: Colors.black),
              label: 'Pesanan',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: Colors.black),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}

// 4. Halaman Tab 1: Beranda (Dengan 50 List Item untuk Uji Coba Scroll)
class TabHomeScreen extends StatelessWidget {
  const TabHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BERANDA KAMPUS (UJI SCROLL)',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
        shape: const Border(
          bottom: BorderSide(color: Colors.black, width: 2.5),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 40,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2),
              boxShadow: const [
                BoxShadow(color: Colors.black, offset: Offset(3, 3)),
              ],
            ),
            child: Text(
              'Item Beranda #$index - Coba scroll ke bawah lalu pindah tab!',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}

// 5. Halaman Tab 2: Riwayat Pesanan
class TabOrdersScreen extends StatelessWidget {
  const TabOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RIWAYAT PESANAN',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        backgroundColor: const Color(0xFF4ADE80),
        foregroundColor: Colors.black,
        shape: const Border(
          bottom: BorderSide(color: Colors.black, width: 2.5),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2.5),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(5, 5)),
            ],
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                size: 60,
                color: Color(0xFF4ADE80),
              ),
              SizedBox(height: 12),
              Text(
                'Belum Ada Pesanan Aktif',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                'Saat Anda kembali ke tab Beranda, posisi scroll tetap aman!',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 6. Halaman Tab 3: Profil
class TabProfileScreen extends StatelessWidget {
  const TabProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PROFIL PENGGUNA',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        backgroundColor: const Color(0xFF38BDF8),
        foregroundColor: Colors.black,
        shape: const Border(
          bottom: BorderSide(color: Colors.black, width: 2.5),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2.5),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(5, 5)),
            ],
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFFFFE600),
                foregroundColor: Colors.black,
                child: Icon(Icons.person, size: 50),
              ),
              SizedBox(height: 12),
              Text(
                'Mahasiswa Flutter 2026',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              Text('NIM: 2301092026', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

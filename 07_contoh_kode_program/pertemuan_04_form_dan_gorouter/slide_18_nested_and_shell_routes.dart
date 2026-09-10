// =====================================================================
// SLIDE 18: RUTE BERSARANG & STATEFULSHELLROUTE (TAB BAWAH)
// Topik: Navigasi Bilah Bawah Permanen Tanpa Kehilangan State Tab
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const ShellRouteApp());
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/beranda',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ShellScaffold(navigationShell: navigationShell);
      },
      branches: [
        // Cabang Tab 1: Beranda
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/beranda',
              builder: (context, state) => const TabContentScreen(
                title: 'Tab Beranda',
                icon: Icons.home,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        // Cabang Tab 2: Formulir
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/formulir',
              builder: (context, state) => const TabContentScreen(
                title: 'Tab Formulir Input',
                icon: Icons.edit_note,
                color: Colors.teal,
              ),
            ),
          ],
        ),
        // Cabang Tab 3: Pengaturan
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/pengaturan',
              builder: (context, state) => const TabContentScreen(
                title: 'Tab Pengaturan',
                icon: Icons.settings,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

class ShellRouteApp extends StatelessWidget {
  const ShellRouteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Slide 18 - Shell Route',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      routerConfig: _router,
    );
  }
}

class ShellScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const ShellScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.edit_note), label: 'Formulir'),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}

class TabContentScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const TabContentScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 72, color: color),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'State tab ini tetap terjaga saat berpindah ke tab lain.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

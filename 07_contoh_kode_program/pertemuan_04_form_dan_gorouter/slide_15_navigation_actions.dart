// =====================================================================
// SLIDE 15: AKSI NAVIGASI (CONTEXT.GO VS CONTEXT.PUSH VS CONTEXT.POP)
// Topik: Menumpuk Halaman (Stack) vs Mengganti Riwayat Navigasi
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const NavActionsApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const StepOneScreen()),
    GoRoute(
      path: '/langkah2',
      builder: (context, state) => const StepTwoScreen(),
    ),
  ],
);

class NavActionsApp extends StatelessWidget {
  const NavActionsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Slide 15 - Navigation Actions',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      routerConfig: _router,
    );
  }
}

class StepOneScreen extends StatelessWidget {
  const StepOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Langkah 1: Beranda'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Perbedaan .go() vs .push():',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => context.push('/langkah2'),
                icon: const Icon(Icons.layers),
                label: const Text('Gunakan context.push (Menumpuk)'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => context.go('/langkah2'),
                icon: const Icon(Icons.swap_horiz),
                label: const Text('Gunakan context.go (Mengganti)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StepTwoScreen extends StatelessWidget {
  const StepTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final canPop = context.canPop();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Langkah 2: Halaman Baru'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                canPop
                    ? 'Halaman ini ditumpuk di atas tumpukan (Stack)!'
                    : 'Halaman ini menggantikan riwayat tumpukan!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              if (canPop)
                ElevatedButton.icon(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Kembali via context.pop()'),
                )
              else
                FilledButton.icon(
                  onPressed: () => context.go('/'),
                  icon: const Icon(Icons.home),
                  label: const Text('Menuju Beranda via context.go("/")'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// SLIDE 12: MENYEDIAKAN CUBIT DENGAN BLOCPROVIDER
// Topik: Dependency Injection & Cara Mengakses Cubit via BuildContext
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeToggleCubit extends Cubit<bool> {
  ThemeToggleCubit() : super(false); // false = Light, true = Dark

  void toggle() => emit(!state);
}

void main() {
  runApp(
    // BlocProvider ditempatkan di root agar bisa diakses di semua halaman:
    BlocProvider(
      create: (context) => ThemeToggleCubit(),
      child: const BlocProviderApp(),
    ),
  );
}

class BlocProviderApp extends StatelessWidget {
  const BlocProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch() mendengarkan perubahan untuk membangun MaterialApp:
    final isDark = context.watch<ThemeToggleCubit>().state;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 12 - BlocProvider',
      theme: ThemeData(
        useMaterial3: true,
        brightness: isDark ? Brightness.dark : Brightness.light,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slide 12: BlocProvider & Context')),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Klik tombol untuk mengubah tema global:'),
                const SizedBox(height: 16),
                FilledButton.icon(
                  // context.read() digunakan di dalam callback aksi:
                  onPressed: () => context.read<ThemeToggleCubit>().toggle(),
                  icon: const Icon(Icons.brightness_6),
                  label: const Text('Toggle Tema (context.read)'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

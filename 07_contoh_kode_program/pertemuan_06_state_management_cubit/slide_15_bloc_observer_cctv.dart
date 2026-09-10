// =====================================================================
// SLIDE 15: PEMANTAUAN GLOBAL DENGAN BLOCOBSERVER
// Topik: CCTV Pemantau Seluruh Transisi & Kesalahan State di Terminal
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1. Kelas Pengawas Global (CCTV):
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // Tercetak otomatis di terminal setiap ada state berubah di seluruh aplikasi:
    debugPrint(
      '[BLOC LOG] ${bloc.runtimeType}: ${change.currentState} -> ${change.nextState}',
    );
  }
}

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  void inc() => emit(state + 1);
}

void main() {
  // 2. Pasang observer sebelum runApp:
  Bloc.observer = AppBlocObserver();
  runApp(const ObserverApp());
}

class ObserverApp extends StatelessWidget {
  const ObserverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 15 - BlocObserver',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: BlocProvider(
        create: (context) => CounterCubit(),
        child: const ObserverScreen(),
      ),
    );
  }
}

class ObserverScreen extends StatelessWidget {
  const ObserverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.watch<CounterCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('Slide 15: BlocObserver')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nilai: $count', style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            const Text(
              'Buka Terminal Console untuk melihat log transisi otomatis!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => context.read<CounterCubit>().inc(),
              child: const Text('Panggil emit() (Cek Log Terminal)'),
            ),
          ],
        ),
      ),
    );
  }
}

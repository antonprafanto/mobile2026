// =====================================================================
// SLIDE 14: REGISTRASI GET_IT: SINGLETON VS FACTORY
// Topik: Menentukan Kapan Objek Dipakai Bersama vs Kapan Dibuat Baru
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class CounterService {
  int value = 0;
}

void initDI() {
  if (!sl.isRegistered<CounterService>()) {
    // LazySingleton: Instance dibuat 1 kali saat pertama dipanggil, lalu dipakai terus
    sl.registerLazySingleton<CounterService>(() => CounterService());
  }
}

void main() {
  initDI();
  runApp(const FactoryVsSingletonApp());
}

class FactoryVsSingletonApp extends StatefulWidget {
  const FactoryVsSingletonApp({super.key});

  @override
  State<FactoryVsSingletonApp> createState() => _FactoryVsSingletonAppState();
}

class _FactoryVsSingletonAppState extends State<FactoryVsSingletonApp> {
  void _increment() {
    setState(() {
      sl<CounterService>().value++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentVal = sl<CounterService>().value;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 14 - Singleton vs Factory',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.purple),
      home: Scaffold(
        appBar: AppBar(title: const Text('Slide 14: LazySingleton GetIt')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Nilai Tersimpan di LazySingleton (Satu Objek):'),
              Text(
                '$currentVal',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _increment,
                icon: const Icon(Icons.add),
                label: const Text('Tambah Nilai di Singleton'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

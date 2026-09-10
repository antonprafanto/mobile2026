// =====================================================================
// SLIDE 13: SERVICE LOCATOR DENGAN GET_IT
// Topik: Pendaftaran & Pengambilan Objek Terpusat Tanpa Prop Drilling
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Inisialisasi Service Locator Global:
final sl = GetIt.instance;

class AppConfigService {
  final String appName = 'Aplikasi Kampus 2026';
  final String apiEndpoint = 'https://api.kampus.ac.id';
}

void setupLocator() {
  if (!sl.isRegistered<AppConfigService>()) {
    sl.registerSingleton<AppConfigService>(AppConfigService());
  }
}

void main() {
  setupLocator();
  runApp(const GetItDemoApp());
}

class GetItDemoApp extends StatelessWidget {
  const GetItDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil instance dari GetIt di widget mana saja tanpa parameter:
    final config = sl<AppConfigService>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 13 - GetIt',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber),
      home: Scaffold(
        appBar: AppBar(title: const Text('Slide 13: GetIt Service Locator')),
        body: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Objek Diambil dari GetIt sl<T>():'),
                  const SizedBox(height: 12),
                  Text(
                    'Nama App: ${config.appName}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Endpoint: ${config.apiEndpoint}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

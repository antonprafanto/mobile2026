// =====================================================================
// SLIDE 02: SETUP & PERSIAPAN DEPENDENCY INJECTION (GET_IT)
// Topik: Memasang get_it & Mengonfigurasi Service Locator
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const SetupDIApp());
}

class SetupDIApp extends StatelessWidget {
  const SetupDIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 02 - Setup DI',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Slide 02: Setup get_it & DI'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Card(
                child: ListTile(
                  leading: Icon(Icons.terminal, color: Colors.indigo),
                  title: Text('Perintah Terminal:'),
                  subtitle: Text(
                    'flutter pub add get_it equatable flutter_bloc',
                  ),
                ),
              ),
              SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: Icon(Icons.hub, color: Colors.teal),
                  title: Text('Peran get_it (Service Locator):'),
                  subtitle: Text(
                    'Penyedia objek terpusat untuk memutus ketergantungan antar kelas.',
                  ),
                ),
              ),
              SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                  ),
                  title: Text('Prinsip Utama:'),
                  subtitle: Text(
                    'Widget UI tidak boleh membuat objek Repository dengan kata kunci new / ()!',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

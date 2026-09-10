// =====================================================================
// SLIDE 04: MODEL TIGA LAPISAN (PRESENTATION, DOMAIN, DATA)
// Topik: Memahami Batas-Batas Arsitektur Bawang Bombay (Clean Arch)
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const CleanArchLayersApp());
}

class CleanArchLayersApp extends StatelessWidget {
  const CleanArchLayersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 04 - 3 Lapisan Clean Arch',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: Scaffold(
        appBar: AppBar(title: const Text('Slide 04: Tiga Lapisan Utama')),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: const [
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('1', style: TextStyle(color: Colors.white)),
                ),
                title: Text('Presentation Layer (Luar)'),
                subtitle: Text('Widget UI, Screen, BLoC/Cubit, State.'),
              ),
            ),
            SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Text('2', style: TextStyle(color: Colors.white)),
                ),
                title: Text('Domain Layer (Jantung / Inti)'),
                subtitle: Text(
                  'Entities, Use Cases, Repository Contracts. Murni Dart tanpa UI!',
                ),
              ),
            ),
            SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text('3', style: TextStyle(color: Colors.white)),
                ),
                title: Text('Data Layer (Infrastruktur)'),
                subtitle: Text(
                  'Data Sources (API/SQLite), Models/DTO, Repository Implementation.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

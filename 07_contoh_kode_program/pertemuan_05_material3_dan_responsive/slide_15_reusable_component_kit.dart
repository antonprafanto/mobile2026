// =====================================================================
// SLIDE 15: KOMPONEN DESAIN REUSABLE (COMPONENT KIT)
// Topik: Membangun Kartu Kustom yang Konsisten Sesuai Token Tema
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const ComponentKitApp());
}

class ComponentKitApp extends StatelessWidget {
  const ComponentKitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 15 - Component Kit',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const ComponentKitScreen(),
    );
  }
}

// Widget Reusable: Kartu Statistik Kuliah
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: colors.primaryContainer,
              foregroundColor: colors.onPrimaryContainer,
              child: Icon(icon),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(color: colors.outline, fontSize: 12),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ComponentKitScreen extends StatelessWidget {
  const ComponentKitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 15: Reusable Component Kit'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            StatCard(
              title: 'TOTAL SKS TEMPUH',
              value: '84 SKS',
              icon: Icons.school,
            ),
            SizedBox(height: 8),
            StatCard(
              title: 'INDEKS PRESTASI KUMULATIF',
              value: '3.88',
              icon: Icons.stars,
            ),
            SizedBox(height: 8),
            StatCard(
              title: 'KEHADIRAN PRAKTIKUM',
              value: '100%',
              icon: Icons.verified,
            ),
          ],
        ),
      ),
    );
  }
}

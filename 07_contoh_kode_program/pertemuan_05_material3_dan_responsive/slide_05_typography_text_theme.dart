// =====================================================================
// SLIDE 05: HIRARKI TIPOGRAFI & TEXTTHEME M3
// Topik: Menggunakan Skala Teks Resmi Google (Display, Headline, Title, Body)
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const TypographyDemoApp());
}

class TypographyDemoApp extends StatelessWidget {
  const TypographyDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 05 - TextTheme M3',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueGrey),
      home: const TypographyScreen(),
    );
  }
}

class TypographyScreen extends StatelessWidget {
  const TypographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 05: Skala Tipografi M3'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Text('headlineLarge (32sp)', style: textTheme.headlineLarge),
          const SizedBox(height: 8),
          Text(
            'titleLarge (22sp) - Judul Halaman',
            style: textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'titleMedium (16sp) - Judul Kartu / ListTile',
            style: textTheme.titleMedium,
          ),
          const Divider(height: 24),
          Text(
            'bodyLarge (16sp): Digunakan untuk paragraf teks utama aplikasi agar mudah dibaca di layar smartphone.',
            style: textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'bodyMedium (14sp): Standar teks default bawaan widget Text di seluruh aplikasi Flutter.',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'labelSmall (11sp) - Teks tombol, badge, & caption',
            style: textTheme.labelSmall,
          ),
          const SizedBox(height: 24),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '💡 Praktik Terbaik: Jangan hardcode fontSize (misal: fontSize: 24). '
                'Gunakan Theme.of(context).textTheme.titleLarge agar ukuran teks '
                'otomatis menyesuaikan standar sistem dan aksesibilitas!',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

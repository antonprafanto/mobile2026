// =====================================================================
// SLIDE 04: SISTEM WARNA & COLORSCHEME SEED
// Topik: Membangkitkan Palet Warna Harmonis dari Satu Benih Warna
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const ColorSchemeApp());
}

class ColorSchemeApp extends StatefulWidget {
  const ColorSchemeApp({super.key});

  @override
  State<ColorSchemeApp> createState() => _ColorSchemeAppState();
}

class _ColorSchemeAppState extends State<ColorSchemeApp> {
  Color _seedColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 04 - ColorScheme Seed',
      theme: ThemeData(
        useMaterial3: true,
        // Otomatis menghasilkan primary, secondary, surface, dsb. secara harmonis
        colorSchemeSeed: _seedColor,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Slide 04: ColorScheme Seed'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Pilih Benih Warna Utama (Seed Color):',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Teal'),
                    selected: _seedColor == Colors.teal,
                    onSelected: (_) => setState(() => _seedColor = Colors.teal),
                  ),
                  ChoiceChip(
                    label: const Text('Deep Purple'),
                    selected: _seedColor == Colors.deepPurple,
                    onSelected: (_) =>
                        setState(() => _seedColor = Colors.deepPurple),
                  ),
                  ChoiceChip(
                    label: const Text('Orange'),
                    selected: _seedColor == Colors.orange,
                    onSelected: (_) =>
                        setState(() => _seedColor = Colors.orange),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Builder(
                builder: (context) {
                  final colors = Theme.of(context).colorScheme;
                  return Column(
                    children: [
                      ListTile(
                        tileColor: colors.primaryContainer,
                        title: Text(
                          'primaryContainer',
                          style: TextStyle(
                            color: colors.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Warna wadah tombol/kartu utama',
                          style: TextStyle(color: colors.onPrimaryContainer),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        tileColor: colors.secondaryContainer,
                        title: Text(
                          'secondaryContainer',
                          style: TextStyle(
                            color: colors.onSecondaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Warna elemen pendukung / chip',
                          style: TextStyle(color: colors.onSecondaryContainer),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        tileColor: colors.surfaceContainerHighest,
                        title: Text(
                          'surfaceContainerHighest',
                          style: TextStyle(
                            color: colors.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Warna latar belakang kartu elevated',
                          style: TextStyle(color: colors.onSurface),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

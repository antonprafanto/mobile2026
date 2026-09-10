// =====================================================================
// SLIDE 12: GRID RESPONSIF DINAMIS (LAYOUTBUILDER + GRIDVIEW)
// Topik: Mengatur Jumlah Kolom Otomatis Sesuai Lebar Tersedia
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveGridApp());
}

class ResponsiveGridApp extends StatelessWidget {
  const ResponsiveGridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 12 - Responsive Grid',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const ResponsiveGridScreen(),
    );
  }
}

class ResponsiveGridScreen extends StatelessWidget {
  const ResponsiveGridScreen({super.key});

  int _calculateColumns(double width) {
    if (width < 600) return 1; // Ponsel: 1 kolom kartu lebar
    if (width < 900) return 2; // Tablet: 2 kolom
    return 3; // Desktop: 3 kolom
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 12: Grid Responsif'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columns = _calculateColumns(constraints.maxWidth);

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.2,
              ),
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text('Produk Modul ${index + 1}'),
                    subtitle: Text(
                      '$columns Kolom Aktif (${constraints.maxWidth.toInt()}dp)',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

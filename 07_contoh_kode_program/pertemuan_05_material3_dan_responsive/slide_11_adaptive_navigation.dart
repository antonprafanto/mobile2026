// =====================================================================
// SLIDE 11: NAVIGASI ADAPTIF (NAVIGATIONBAR VS NAVIGATIONRAIL)
// Topik: Menu Bawah di HP vs Bilah Rel Samping di Layar Lebar
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AdaptiveNavApp());
}

class AdaptiveNavApp extends StatelessWidget {
  const AdaptiveNavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 11 - Adaptive Nav',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const AdaptiveNavScreen(),
    );
  }
}

class AdaptiveNavScreen extends StatefulWidget {
  const AdaptiveNavScreen({super.key});

  @override
  State<AdaptiveNavScreen> createState() => _AdaptiveNavScreenState();
}

class _AdaptiveNavScreenState extends State<AdaptiveNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Center(child: Text('Halaman 1: Beranda', style: TextStyle(fontSize: 18))),
    Center(
      child: Text('Halaman 2: Formulir Data', style: TextStyle(fontSize: 18)),
    ),
    Center(
      child: Text('Halaman 3: Pengaturan Akun', style: TextStyle(fontSize: 18)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 11: Navigasi Adaptif'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          // Jika layar lebar (Tablet/Desktop), tampilkan NavigationRail di samping kiri
          if (isWide)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (idx) =>
                  setState(() => _selectedIndex = idx),
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Beranda'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.description),
                  label: Text('Formulir'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings),
                  label: Text('Pengaturan'),
                ),
              ],
            ),
          // Halaman konten utama
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
      // Jika layar ponsel (Compact), tampilkan NavigationBar di bawah
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (idx) =>
                  setState(() => _selectedIndex = idx),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Beranda'),
                NavigationDestination(
                  icon: Icon(Icons.description),
                  label: 'Formulir',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings),
                  label: 'Pengaturan',
                ),
              ],
            ),
    );
  }
}

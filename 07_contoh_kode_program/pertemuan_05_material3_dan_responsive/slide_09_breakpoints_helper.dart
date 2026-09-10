// =====================================================================
// SLIDE 09: STANDAR BREAKPOINTS INDUSTRI (MATERIAL 3)
// Topik: Memisahkan Logika Compact (<600dp), Medium (600-840dp), Expanded (>840dp)
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const BreakpointsDemoApp());
}

enum WindowSizeClass { compact, medium, expanded }

class BreakpointsDemoApp extends StatelessWidget {
  const BreakpointsDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 09 - Breakpoints',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const BreakpointsScreen(),
    );
  }
}

class BreakpointsScreen extends StatelessWidget {
  const BreakpointsScreen({super.key});

  WindowSizeClass _getSizeClass(double width) {
    if (width < 600) return WindowSizeClass.compact;
    if (width < 840) return WindowSizeClass.medium;
    return WindowSizeClass.expanded;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final sizeClass = _getSizeClass(width);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 09: Standar Breakpoints'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Lebar Saat Ini: ${width.toStringAsFixed(1)} dp',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),
              Chip(
                backgroundColor: sizeClass == WindowSizeClass.compact
                    ? Colors.orange.shade100
                    : sizeClass == WindowSizeClass.medium
                    ? Colors.blue.shade100
                    : Colors.green.shade100,
                label: Text(
                  sizeClass == WindowSizeClass.compact
                      ? 'COMPACT (<600dp: Ponsel Tegak)'
                      : sizeClass == WindowSizeClass.medium
                      ? 'MEDIUM (600-840dp: Tablet / Ponsel Miring)'
                      : 'EXPANDED (>840dp: Desktop / Tablet Besar)',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

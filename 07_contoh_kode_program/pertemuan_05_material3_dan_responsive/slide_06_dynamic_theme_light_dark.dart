// =====================================================================
// SLIDE 06: THEMING DINAMIS (LIGHT & DARK MODE)
// Topik: Mengatur themeMode: ThemeMode.light / dark / system
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const DynamicThemeApp());
}

class DynamicThemeApp extends StatefulWidget {
  const DynamicThemeApp({super.key});

  @override
  State<DynamicThemeApp> createState() => _DynamicThemeAppState();
}

class _DynamicThemeAppState extends State<DynamicThemeApp> {
  // Mode tema aktif saat ini
  ThemeMode _themeMode = ThemeMode.system;

  void _updateTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 06 - Dynamic Theme',
      // Tema Terang (Light)
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),
      // Tema Gelap (Dark)
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
      ),
      // Pengontrol mode aktif
      themeMode: _themeMode,
      home: ThemeHomeScreen(
        currentMode: _themeMode,
        onModeChanged: _updateTheme,
      ),
    );
  }
}

class ThemeHomeScreen extends StatelessWidget {
  final ThemeMode currentMode;
  final ValueChanged<ThemeMode> onModeChanged;

  const ThemeHomeScreen({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 06: Tema Terang & Gelap'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                size: 72,
                color: isDark ? Colors.amber : Colors.orange,
              ),
              const SizedBox(height: 16),
              Text(
                isDark
                    ? 'Mode Saat Ini: TEMA GELAP'
                    : 'Mode Saat Ini: TEMA TERANG',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              SegmentedButton<ThemeMode>(
                segments: const [
                  ButtonSegment(
                    value: ThemeMode.light,
                    icon: Icon(Icons.light_mode),
                    label: Text('Terang'),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    icon: Icon(Icons.dark_mode),
                    label: Text('Gelap'),
                  ),
                  ButtonSegment(
                    value: ThemeMode.system,
                    icon: Icon(Icons.settings_suggest),
                    label: Text('Sistem'),
                  ),
                ],
                selected: {currentMode},
                onSelectionChanged: (newSet) => onModeChanged(newSet.first),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

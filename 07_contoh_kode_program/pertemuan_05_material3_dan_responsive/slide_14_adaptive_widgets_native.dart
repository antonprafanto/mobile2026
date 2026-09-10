// =====================================================================
// SLIDE 14: WIDGET ADAPTIF BAWAAN FLUTTER (.ADAPTIVE)
// Topik: Komponen yang Otomatis Menyesuaikan Tampilan Android vs iOS
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AdaptiveWidgetsApp());
}

class AdaptiveWidgetsApp extends StatelessWidget {
  const AdaptiveWidgetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 14 - Adaptive Widgets',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const AdaptiveWidgetsScreen(),
    );
  }
}

class AdaptiveWidgetsScreen extends StatefulWidget {
  const AdaptiveWidgetsScreen({super.key});

  @override
  State<AdaptiveWidgetsScreen> createState() => _AdaptiveWidgetsScreenState();
}

class _AdaptiveWidgetsScreenState extends State<AdaptiveWidgetsScreen> {
  bool _switchVal = true;
  double _sliderVal = 0.6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 14: Widget .adaptive()'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // 1. Switch.adaptive
            Card(
              child: SwitchListTile.adaptive(
                title: const Text('Switch.adaptive()'),
                subtitle: const Text(
                  'Material di Android/Web, Cupertino di iPhone',
                ),
                value: _switchVal,
                onChanged: (val) => setState(() => _switchVal = val),
              ),
            ),
            const SizedBox(height: 12),

            // 2. Slider.adaptive
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Slider.adaptive()',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Slider.adaptive(
                      value: _sliderVal,
                      onChanged: (val) => setState(() => _sliderVal = val),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // 3. CircularProgressIndicator.adaptive
            const Card(
              child: ListTile(
                leading: CircularProgressIndicator.adaptive(),
                title: Text('CircularProgressIndicator.adaptive()'),
                subtitle: Text('Lingkaran M3 di Android, Spinner abu di iOS'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

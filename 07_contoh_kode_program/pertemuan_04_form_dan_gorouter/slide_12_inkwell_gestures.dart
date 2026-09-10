// =====================================================================
// SLIDE 12: RESPON SENTUHAN (GESTUREDETECTOR VS INKWELL)
// Topik: Membedakan Respon Hening vs Efek Riak Air Material (Ripple)
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const GestureComparisonApp());
}

class GestureComparisonApp extends StatelessWidget {
  const GestureComparisonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 12 - InkWell vs GestureDetector',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const GestureScreen(),
    );
  }
}

class GestureScreen extends StatefulWidget {
  const GestureScreen({super.key});

  @override
  State<GestureScreen> createState() => _GestureScreenState();
}

class _GestureScreenState extends State<GestureScreen> {
  String _lastAction = 'Belum ada elemen yang disentuh.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 12: GestureDetector vs InkWell'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. GestureDetector (Respon hening tanpa efek riak)
            GestureDetector(
              onTap: () {
                setState(() {
                  _lastAction =
                      'GestureDetector disentuh (Tanpa efek visual riak).';
                });
              },
              child: Card(
                color: Colors.blue.shade50,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(Icons.touch_app, color: Colors.blue),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '1. GestureDetector\nSentuhan hening tanpa efek riak.',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. InkWell (Membutuhkan Material ancestor untuk efek riak air)
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _lastAction =
                        'InkWell disentuh (Efek riak gelombang air Material 3 aktif!).';
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.water_drop_outlined,
                        color: Colors.indigo.shade600,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          '2. InkWell\nAda animasi riak gelombang air (Splash Ripple).',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status Sentuhan:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _lastAction,
                      style: const TextStyle(color: Colors.indigo),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 06: DEMO ENGINE IMPELLER (ANTI-JANK)
// TOPIK: Rendering Animasi Halus 60 FPS Tanpa Patah-Patah (Shader Jank)
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiDemoImpeller());
}

class AplikasiDemoImpeller extends StatefulWidget {
  const AplikasiDemoImpeller({super.key});

  @override
  State<AplikasiDemoImpeller> createState() => _AplikasiDemoImpellerState();
}

class _AplikasiDemoImpellerState extends State<AplikasiDemoImpeller>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Animasi perulangan terus-menerus
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Demo Render Halus 60 FPS'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    width: 100 + (_controller.value * 80),
                    height: 100 + (_controller.value * 80),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(
                        alpha: 0.3 + (_controller.value * 0.7),
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.speed, size: 40, color: Colors.white),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              const Text(
                'Animasi berdenyut ini berjalan sangat mulus di 60 FPS\n'
                'berkat Impeller Graphics Engine bawaan Flutter.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

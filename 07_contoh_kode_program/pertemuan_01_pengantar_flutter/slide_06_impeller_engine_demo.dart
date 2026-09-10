// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 06: DEMO ENGINE IMPELLER (ANTI-JANK)
// TOPIK: Pembuktian Render Animasi Partikel 60-120 FPS Mulus Tanpa Shader Jank
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const Slide06ImpellerApp());
}

class Slide06ImpellerApp extends StatelessWidget {
  const Slide06ImpellerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 06 - Impeller Demo',
      theme: ThemeData(useMaterial3: true),
      home: const ImpellerDemoScreen(),
    );
  }
}

class ImpellerDemoScreen extends StatefulWidget {
  const ImpellerDemoScreen({super.key});

  @override
  State<ImpellerDemoScreen> createState() => _ImpellerDemoScreenState();
}

class _ImpellerDemoScreenState extends State<ImpellerDemoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _random = Random();
  final int _particleCount = 60;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _initParticles();
  }

  void _initParticles() {
    _particles.clear();
    for (int i = 0; i < _particleCount; i++) {
      _particles.add(
        Particle(
          x: _random.nextDouble() * 320,
          y: _random.nextDouble() * 260,
          dx: (_random.nextDouble() - 0.5) * 4,
          dy: (_random.nextDouble() - 0.5) * 4,
          radius: _random.nextDouble() * 8 + 4,
          color: [
            const Color(0xFFFFE600), // Yellow
            const Color(0xFF38BDF8), // Cyan
            const Color(0xFF4ADE80), // Mint
            const Color(0xFFFB7185), // Coral
          ][_random.nextInt(4)],
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('SLIDE 06: Demo Performa Mulus Impeller'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Canvas GPU Rendering: 60 Partikel Mulus Bergerak Tanpa Lag',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Kotak Kanvas Partikel
            Container(
              width: 340,
              height: 280,
              decoration: BoxDecoration(
                color: const Color(0xFF121212),
                border: Border.all(color: Colors.black, width: 3),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(5, 5)),
                ],
              ),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  // Update pergerakan partikel
                  for (var p in _particles) {
                    p.x += p.dx;
                    p.y += p.dy;
                    if (p.x < 0 || p.x > 330) p.dx = -p.dx;
                    if (p.y < 0 || p.y > 270) p.dy = -p.dy;
                  }
                  return CustomPaint(painter: ParticlePainter(_particles));
                },
              ),
            ),
            const SizedBox(height: 20),

            // Penjelasan Impeller
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(3, 3)),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '⚡ RAHASIA ENGINE IMPELLER (2026):',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '1. Pre-compiled Shaders: Efek bayangan, gradasi, dan blur sudah dikompilasi sebelum app jalan, sehingga tidak ada lag pertama kali (zero shader jank).\n2. 120 FPS Ready: Mampu mengikuti layar refresh-rate tinggi smartphone masa kini.\n3. Diaktifkan otomatis di Flutter versi stabil terbaru!',
                    style: TextStyle(fontSize: 12, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Particle {
  double x, y, dx, dy, radius;
  Color color;
  Particle({
    required this.x,
    required this.y,
    required this.dx,
    required this.dy,
    required this.radius,
    required this.color,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      final paint = Paint()
        ..color = p.color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(p.x, p.y), p.radius, paint);

      // Stroke garis hitam khas Neo-Brutalist
      final strokePaint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      canvas.drawCircle(Offset(p.x, p.y), p.radius, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

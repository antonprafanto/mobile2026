// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 05: THE THREE TREES ARSITEKTUR
// TOPIK: Memahami Widget Tree, Element Tree, dan RenderObject Tree
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide05ThreeTreesApp());

class Slide05ThreeTreesApp extends StatefulWidget {
  const Slide05ThreeTreesApp({super.key});

  @override
  State<Slide05ThreeTreesApp> createState() => _Slide05ThreeTreesAppState();
}

class _Slide05ThreeTreesAppState extends State<Slide05ThreeTreesApp> {
  Color _boxColor = const Color(0xFF38BDF8);
  int _rebuildCount = 0;

  void _toggleColor() {
    setState(() {
      _rebuildCount++;
      _boxColor = _boxColor == const Color(0xFF38BDF8)
          ? const Color(0xFFFB7185)
          : const Color(0xFF38BDF8);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SLIDE 05 • THE THREE TREES ARSITEKTUR',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color(0xFF38BDF8),
          elevation: 0,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.5),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Visualisasi Tiga Pohon
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2.5),
                    boxShadow: const [
                      BoxShadow(color: Colors.black, offset: Offset(5, 5)),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Mengapa Hot Reload Flutter Begitu Kilat?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildTreeCard(
                        '1. Widget Tree (Cetak Biru)',
                        'Dibuat ulang setiap render. Ringan & murah.',
                        const Color(0xFFFFE600),
                      ),
                      const SizedBox(height: 8),
                      _buildTreeCard(
                        '2. Element Tree (Manajer State)',
                        'Menetap di memori, hanya membandingkan perubahan.',
                        const Color(0xFF4ADE80),
                      ),
                      const SizedBox(height: 8),
                      _buildTreeCard(
                        '3. RenderObject Tree (Pelukis Layar)',
                        'Hanya melukis ulang bagian piksel yang berubah warna.',
                        const Color(0xFFC084FC),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Komponen yang Diubah Warnanya
                Container(
                  width: 160,
                  height: 100,
                  decoration: BoxDecoration(
                    color: _boxColor,
                    border: Border.all(color: Colors.black, width: 3),
                    boxShadow: const [
                      BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Rebuild Ke: #$_rebuildCount',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                ElevatedButton.icon(
                  onPressed: _toggleColor,
                  icon: const Icon(Icons.palette),
                  label: const Text('UBAH WARNA (UJI PERFORMA REBUILD)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    side: const BorderSide(color: Colors.black, width: 2),
                    shape: const RoundedRectangleBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTreeCard(String title, String desc, Color col) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: col,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
          ),
          Text(desc, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}

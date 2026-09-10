// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 06: STATELESS VS STATEFUL WIDGET
// TOPIK: Komponen Statis (Hemat Memori) vs Komponen Dinamis (Interaktif)
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide06WidgetApp());

class Slide06WidgetApp extends StatelessWidget {
  const Slide06WidgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SLIDE 06 • STATELESS VS STATEFUL',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color(0xFFFB7185),
          elevation: 0,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.5),
          ),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Komponen StatelessWidget
              KartuProfilStateless(
                nama: 'Ahmad Fauzan',
                prodi: 'Teknik Informatika 2026',
              ),
              SizedBox(height: 24),

              // 2. Komponen StatefulWidget
              KartuInteraktifStateful(),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// CONTOH STATELESS WIDGET: Tampilan tidak pernah berubah
// -------------------------------------------------------------
class KartuProfilStateless extends StatelessWidget {
  final String nama;
  final String prodi;

  const KartuProfilStateless({
    super.key,
    required this.nama,
    required this.prodi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2.5),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: const Color(0xFF38BDF8),
            child: const Text(
              'STATELESS WIDGET (STATIS)',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 11),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            nama,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          Text(
            prodi,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          const Text(
            '💡 Widget ini hanya merender parameter sekali saja. Sangat hemat baterai & RAM!',
            style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// CONTOH STATEFUL WIDGET: Bisa berubah saat tombol ditekan
// -------------------------------------------------------------
class KartuInteraktifStateful extends StatefulWidget {
  const KartuInteraktifStateful({super.key});

  @override
  State<KartuInteraktifStateful> createState() =>
      _KartuInteraktifStatefulState();
}

class _KartuInteraktifStatefulState extends State<KartuInteraktifStateful> {
  int _likes = 0;
  bool _isDisukai = false;

  void _toggleLike() {
    setState(() {
      _isDisukai = !_isDisukai;
      _likes += _isDisukai ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE600),
        border: Border.all(color: Colors.black, width: 2.5),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.black,
            child: const Text(
              'STATEFUL WIDGET (DINAMIS)',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Portofolio Mobile Flutter 2026',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            'Jumlah Apresiasi: $_likes Disukai',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _toggleLike,
            icon: Icon(
              _isDisukai ? Icons.favorite : Icons.favorite_border,
              color: _isDisukai ? Colors.red : Colors.black,
            ),
            label: Text(_isDisukai ? 'BATALKAN SUKA' : 'BERIKAN BINTANG SUKA'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              side: const BorderSide(color: Colors.black, width: 2),
              shape: const RoundedRectangleBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

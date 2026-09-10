// =====================================================================
// SLIDE 03: SEPARATION OF CONCERNS (SoC)
// Topik: Memisahkan Tanggung Jawab Kode UI dari Logika Bisnis & Data
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

// Simulasi Layanan Perhitungan Bisnis Terpisah (Bukan di dalam Widget):
class TaxCalculator {
  double hitungPpn(double harga) => harga * 0.11; // PPN 11%
}

void main() {
  runApp(const SeparationOfConcernsApp());
}

class SeparationOfConcernsApp extends StatefulWidget {
  const SeparationOfConcernsApp({super.key});

  @override
  State<SeparationOfConcernsApp> createState() =>
      _SeparationOfConcernsAppState();
}

class _SeparationOfConcernsAppState extends State<SeparationOfConcernsApp> {
  final _calculator = TaxCalculator();
  final double _hargaBarang = 1000000;
  double _ppn = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 03 - Separation of Concerns',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(title: const Text('Slide 03: Prinsip SoC')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Harga Barang: Rp ${_hargaBarang.toInt()}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  'PPN 11%: Rp ${_ppn.toInt()}',
                  style: const TextStyle(fontSize: 18, color: Colors.green),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () {
                    // UI hanya memanggil kalkulator, bukan menghitung rumus sendiri:
                    setState(() => _ppn = _calculator.hitungPpn(_hargaBarang));
                  },
                  icon: const Icon(Icons.calculate),
                  label: const Text('Hitung via TaxCalculator'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

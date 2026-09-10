// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 04: DART VS FLUTTER
// TOPIK: Dart Sebagai Logika Otak & Flutter Sebagai Antarmuka Visual
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiDartVsFlutter());
}

class AplikasiDartVsFlutter extends StatefulWidget {
  const AplikasiDartVsFlutter({super.key});

  @override
  State<AplikasiDartVsFlutter> createState() => _AplikasiDartVsFlutterState();
}

class _AplikasiDartVsFlutterState extends State<AplikasiDartVsFlutter> {
  int _hargaKopi = 20000;
  double _persenDiskon = 0.20; // 20%
  int _totalBayar = 0;

  // 1. LOGIKA DART MURNI (Mesin Penghitung)
  int hitungTotalBayar(int harga, double diskon) {
    return (harga - (harga * diskon)).toInt();
  }

  @override
  void initState() {
    super.initState();
    _totalBayar = hitungTotalBayar(_hargaKopi, _persenDiskon);
  }

  @override
  Widget build(BuildContext context) {
    // 2. TAMPILAN FLUTTER (Bodi & Tombol Visual)
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dart (Logika) vs Flutter (UI)'),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Harga Kopi: Rp $_hargaKopi',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Diskon: ${(_persenDiskon * 100).toInt()}%',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Total Bayar di Kasir: Rp $_totalBayar',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _hargaKopi += 5000; // Ubah data logika
                    _totalBayar = hitungTotalBayar(_hargaKopi, _persenDiskon);
                  });
                },
                child: const Text('Tambah Ukuran (+ Rp 5.000)'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Analogi: Dart adalah mesin bensin yang menghitung harga, '
                'sedangkan Flutter adalah bodi speedometer yang menampilkan hasilnya di layar!',
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

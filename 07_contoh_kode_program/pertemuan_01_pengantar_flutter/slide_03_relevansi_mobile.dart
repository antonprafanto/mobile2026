// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 03: EFISIENSI SINGLE CODEBASE
// TOPIK: Mengapa Flutter Efisien? Satu Basis Kode untuk Android & iOS
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiKalkulatorEfisiensi());
}

class AplikasiKalkulatorEfisiensi extends StatefulWidget {
  const AplikasiKalkulatorEfisiensi({super.key});

  @override
  State<AplikasiKalkulatorEfisiensi> createState() =>
      _AplikasiKalkulatorEfisiensiState();
}

class _AplikasiKalkulatorEfisiensiState
    extends State<AplikasiKalkulatorEfisiensi> {
  double _jumlahFitur = 5;

  @override
  Widget build(BuildContext context) {
    final estimasiHariNative = (_jumlahFitur * 6)
        .toInt(); // 2 tim terpisah (Android + iOS)
    final estimasiHariFlutter = (_jumlahFitur * 3.2).toInt(); // 1 tim Flutter

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Simulasi Efisiensi Single Codebase'),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Geser Jumlah Fitur Aplikasi:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Slider(
                value: _jumlahFitur,
                min: 1,
                max: 15,
                divisions: 14,
                label: '${_jumlahFitur.toInt()} Fitur',
                onChanged: (val) => setState(() => _jumlahFitur = val),
              ),
              Text('Jumlah Fitur: ${_jumlahFitur.toInt()} Fitur'),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              // Perbandingan Waktu
              ListTile(
                leading: const Icon(Icons.people, color: Colors.orange),
                title: const Text('Pendekatan Dual Native (Kotlin + Swift)'),
                subtitle: Text(
                  'Estimasi pengerjaan: ~$estimasiHariNative hari (2 Tim Terpisah)',
                ),
              ),
              ListTile(
                leading: const Icon(Icons.flash_on, color: Colors.green),
                title: const Text('Pendekatan Flutter (Single Codebase)'),
                subtitle: Text(
                  'Estimasi pengerjaan: ~$estimasiHariFlutter hari (Hemat ~50% Waktu & Biaya)',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 10: PUBSPEC.YAML INDENTASI
// TOPIK: Aturan Wajib 2 Spasi (Dilarang Menggunakan Tombol Tab!)
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiPubspecSim());
}

class AplikasiPubspecSim extends StatelessWidget {
  const AplikasiPubspecSim({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Aturan Indentasi pubspec.yaml'),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Contoh Penulisan pubspec.yaml yang Benar:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.grey[200],
                child: const Text(
                  'dependencies:\n'
                  '  flutter:\n'
                  '    sdk: flutter\n'
                  '  # Gunakan tepat 2 spasi (bukan tombol TAB):\n'
                  '  dio: ^5.0.0\n'
                  '  go_router: ^14.0.0',
                  style: TextStyle(fontFamily: 'Consolas', fontSize: 13),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Peringatan Pemula:\n'
                'Format YAML membaca spasi sebagai struktur hierarki. '
                'Menekan tombol TAB akan memicu error "YamlException: Tabs are not allowed"!',
                style: TextStyle(color: Colors.red, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

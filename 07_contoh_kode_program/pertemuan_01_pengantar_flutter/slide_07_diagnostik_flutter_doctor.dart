// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 07: DIAGNOSTIK FLUTTER DOCTOR
// TOPIK: Memahami Hasil Perintah "flutter doctor" di Terminal
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiFlutterDoctor());
}

class AplikasiFlutterDoctor extends StatelessWidget {
  const AplikasiFlutterDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Simulasi Hasil flutter doctor'),
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: const [
            Text(
              'Jalankan perintah ini di terminal:\n\$ flutter doctor',
              style: TextStyle(
                fontFamily: 'Consolas',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('[✓] Flutter (Channel stable, 3.x)'),
              subtitle: Text('SDK Flutter terpasang dengan benar di laptop.'),
            ),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('[✓] Android toolchain'),
              subtitle: Text('Android SDK dan lisensi Java sudah disetujui.'),
            ),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('[✓] Chrome - develop for the web'),
              subtitle: Text(
                'Google Chrome siap digunakan untuk pengujian cepat.',
              ),
            ),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('[✓] VS Code (version 1.x)'),
              subtitle: Text('Ekstensi Flutter dan Dart sudah aktif.'),
            ),
          ],
        ),
      ),
    );
  }
}

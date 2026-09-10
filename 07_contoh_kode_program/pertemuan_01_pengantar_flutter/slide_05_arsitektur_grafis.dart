// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 05: ARSITEKTUR GRAFIS FLUTTER
// TOPIK: Mengapa Flutter Menggambar Piksel Langsung Tanpa Bridge?
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiArsitekturGrafis());
}

class AplikasiArsitekturGrafis extends StatelessWidget {
  const AplikasiArsitekturGrafis({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Arsitektur Grafis Flutter'),
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: const [
            ListTile(
              leading: Icon(Icons.phone_android, color: Colors.orange),
              title: Text('1. Native Klasik (Kotlin / Swift)'),
              subtitle: Text(
                'Menggunakan widget bawaan OS (OEM Widgets). Performa maksimal tetapi butuh dua kode program terpisah.',
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.web, color: Colors.red),
              title: Text('2. Hybrid Klasik (Cordova / Ionic)'),
              subtitle: Text(
                'Berjalan di dalam browser tersembunyi (WebView). Lambat karena ada jembatan penerjemah (Bridge).',
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.brush, color: Colors.green),
              title: Text('3. Flutter (Impeller Engine)'),
              subtitle: Text(
                'Menggambar piksel langsung ke layar GPU ponsel 60-120 FPS tanpa jembatan penerjemah!',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

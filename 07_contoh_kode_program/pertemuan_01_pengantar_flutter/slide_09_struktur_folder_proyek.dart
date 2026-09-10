// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 09: STRUKTUR FOLDER PROYEK
// TOPIK: Memahami Fungsi Folder lib/, android/, ios/, dan pubspec.yaml
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiStrukturFolder());
}

class AplikasiStrukturFolder extends StatelessWidget {
  const AplikasiStrukturFolder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Struktur Folder Proyek Flutter'),
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: const [
            ListTile(
              leading: Icon(Icons.folder, color: Colors.blue),
              title: Text('lib/'),
              subtitle: Text(
                'Folder terpenting! Tempat seluruh kode Dart dan tampilan aplikasi dibuat.',
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.description, color: Colors.orange),
              title: Text('pubspec.yaml'),
              subtitle: Text(
                'Buku resep proyek: mengatur nama aplikasi, gambar aset, dan library eksternal.',
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone_android, color: Colors.green),
              title: Text('android/ & ios/'),
              subtitle: Text(
                'Proyek pembungkus native otomatis dari Flutter untuk sistem operasi HP.',
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.build, color: Colors.grey),
              title: Text('.dart_tool/ & build/'),
              subtitle: Text(
                'Folder cache otomatis kompilasi (jangan pernah mengedit manual).',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

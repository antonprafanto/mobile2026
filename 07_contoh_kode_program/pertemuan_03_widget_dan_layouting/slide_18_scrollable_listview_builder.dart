// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 18: LISTVIEW.BUILDER
// TOPIK: Menampilkan Daftar Panjang Secara Efisien (Lazy Loading)
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HalamanListView(),
    ),
  );
}

class HalamanListView extends StatelessWidget {
  const HalamanListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListView.builder')),
      // ListView.builder hanya merender item yang sedang terlihat di layar
      body: ListView.builder(
        itemCount: 50, // 50 item data
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text('Mahasiswa Ke-${index + 1}'),
            subtitle: const Text('Teknik Informatika'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          );
        },
      ),
    );
  }
}

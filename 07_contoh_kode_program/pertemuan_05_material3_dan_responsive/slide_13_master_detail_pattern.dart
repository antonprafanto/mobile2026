// =====================================================================
// SLIDE 13: POLA ARSITEKTUR UI: MASTER-DETAIL PATTERN
// Topik: 1 Layar Pindah di Ponsel vs Layar Berdampingan (Split Pane) di Tablet
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const MasterDetailApp());
}

class MasterDetailApp extends StatelessWidget {
  const MasterDetailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 13 - Master Detail',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.purple),
      home: const MasterDetailScreen(),
    );
  }
}

class MasterDetailScreen extends StatefulWidget {
  const MasterDetailScreen({super.key});

  @override
  State<MasterDetailScreen> createState() => _MasterDetailScreenState();
}

class _MasterDetailScreenState extends State<MasterDetailScreen> {
  int _selectedItem = 1;

  final List<Map<String, String>> _items = List.generate(
    6,
    (i) => {
      'id': '${i + 1}',
      'title': 'Materi Kuliah ${i + 1}',
      'desc':
          'Deskripsi lengkap silabus dan bahan praktikum untuk materi ${i + 1}.',
    },
  );

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 700;

    final masterList = ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        final isSelected = _selectedItem == index + 1;

        return ListTile(
          selected: isWide && isSelected,
          leading: CircleAvatar(child: Text(item['id']!)),
          title: Text(item['title']!),
          onTap: () {
            setState(() => _selectedItem = index + 1);
            // Di ponsel (<700dp), buka halaman baru bertumpuk
            if (!isWide) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: Text(item['title']!)),
                    body: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          item['desc']!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );

    final detailView = Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Detail Terpilih: Materi $_selectedItem',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              _items[_selectedItem - 1]['desc']!,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 13: Master-Detail Pattern'),
        centerTitle: true,
      ),
      body: isWide
          ? Row(
              children: [
                SizedBox(width: 280, child: Card(child: masterList)),
                Expanded(child: Card(child: detailView)),
              ],
            )
          : masterList,
    );
  }
}

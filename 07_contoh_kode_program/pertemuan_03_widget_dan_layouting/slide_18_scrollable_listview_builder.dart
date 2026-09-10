// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 18: LISTVIEW.BUILDER EFISIEN
// TOPIK: Lazy Loading untuk Daftar Panjang 100+ Item Tanpa Membebani RAM
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide18ListViewApp());

class Slide18ListViewApp extends StatelessWidget {
  const Slide18ListViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SLIDE 18 • LISTVIEW.BUILDER',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color(0xFF38BDF8),
          elevation: 0,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.5),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 50, // 50 item data
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(3, 3)),
                ],
              ),
              child: ListTile(
                leading: Container(
                  width: 42,
                  height: 42,
                  color: index % 2 == 0
                      ? const Color(0xFFFFE600)
                      : const Color(0xFF4ADE80),
                  child: Center(
                    child: Text(
                      '#${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  'Modul Kuliah Mobile Pertemuan #${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  'Status Praktikum: ${index % 3 == 0 ? "Tuntas" : "Dalam Pengerjaan"}',
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.black),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Membuka detail modul #${index + 1}'),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

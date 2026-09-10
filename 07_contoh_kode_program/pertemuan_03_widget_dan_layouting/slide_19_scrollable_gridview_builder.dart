// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 19: GRIDVIEW.BUILDER
// TOPIK: Katalog Produk & Portofolio Berformat Grid 2 Kolom Responsif
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide19GridViewApp());

class Slide19GridViewApp extends StatelessWidget {
  const Slide19GridViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SLIDE 19 • GRIDVIEW.BUILDER',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color(0xFFFFE600),
          elevation: 0,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.5),
          ),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 kolom sejajar
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.85,
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2.5),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? const Color(0xFF38BDF8)
                          : const Color(0xFFFB7185),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: const Icon(Icons.code, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Proyek #${index + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Aplikasi Mobile Flutter',
                    style: TextStyle(fontSize: 11, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    color: const Color(0xFF4ADE80),
                    child: const Text(
                      '2026',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 22: TRIK KOMA AJAIB (TRAILING COMMA)
// TOPIK: Format Kode Otomatis Rapih di VS Code dengan Koma di Akhir
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide22TrailingCommaApp());

class Slide22TrailingCommaApp extends StatelessWidget {
  const Slide22TrailingCommaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SLIDE 22 • TRIK KOMA AJAIB',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color(0xFF4ADE80),
          elevation: 0,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.5),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 3.0),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(5.0, 5.0)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.format_indent_increase,
                    size: 48,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Koma Ajaib (Trailing Comma)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Perhatikan koma di setiap akhir kurung penutup widget ini!\n'
                    'Dengan menaruh koma (,), saat Anda tekan Shift+Alt+F di VS Code, '
                    'seluruh kode bertingkat otomatis disusun berurutan ke bawah secara indah.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

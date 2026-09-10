// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 10: SIMULATOR PUBSPEC.YAML
// TOPIK: Aturan Indentasi Ketat 2 Spasi vs Jebakan Tombol Tab
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide10PubspecApp());
}

class Slide10PubspecApp extends StatelessWidget {
  const Slide10PubspecApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 10 - Pubspec YAML Rules',
      theme: ThemeData(useMaterial3: true),
      home: const PubspecScreen(),
    );
  }
}

class PubspecScreen extends StatefulWidget {
  const PubspecScreen({super.key});

  @override
  State<PubspecScreen> createState() => _PubspecScreenState();
}

class _PubspecScreenState extends State<PubspecScreen> {
  bool _useTabIndentation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('SLIDE 10: Simulator pubspec.yaml'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Jebakan Klasik Pemula: Format YAML Sangat Sensitif Spasi!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 6),
            const Text(
              'Coba ubah tombol di bawah untuk melihat perbedaan antara indentasi 2 spasi yang benar vs tombol Tab yang memicu error fatal kompilasi:',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 14),

            // Saklar Toggle
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Simulasi Kesalahan: Menggunakan Tombol TAB',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Switch(
                    value: _useTabIndentation,
                    activeColor: Colors.red,
                    onChanged: (val) =>
                        setState(() => _useTabIndentation = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Kotak Kode YAML
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF121212),
                border: Border.all(
                  color: _useTabIndentation ? Colors.red : Colors.black,
                  width: 2.5,
                ),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _useTabIndentation
                        ? '❌ STATUS: ERROR KOMPILASI (TAB TERDETEKSI)'
                        : '✅ STATUS: VALID (TEPAT 2 SPASI)',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: _useTabIndentation
                          ? const Color(0xFFFB7185)
                          : const Color(0xFF4ADE80),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const Divider(color: Colors.white24, height: 16),
                  Text(
                    'name: halo_flutter\n'
                    'description: "Aplikasi mahasiswa Informatika"\n'
                    'version: 1.0.0+1\n\n'
                    'dependencies:\n'
                    '  flutter:\n'
                    '    sdk: flutter\n'
                    '${_useTabIndentation ? "\tgoogle_fonts: ^6.2.1   <- ERROR! Karakter TAB terlarang" : "  google_fonts: ^6.2.1   <- BENAR (2 Spasi)"}\n\n'
                    'flutter:\n'
                    '  uses-material-design: true',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: _useTabIndentation
                          ? const Color(0xFFFB7185)
                          : const Color(0xFFF5F5F5),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Tips Praktik
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2FE),
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: const Text(
                '💡 Tips Dosen:\nJika Anda menyalin baris dependensi dari situs pub.dev, pastikan indentasinya sejajar dengan "flutter:" (tepat 2 spasi dari tepi kiri). Jangan pernah menekan tombol Tab di berkas YAML!',
                style: TextStyle(fontSize: 12, height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

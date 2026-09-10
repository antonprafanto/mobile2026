// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 08: VALIDATOR ATURAN NAMA PROYEK
// TOPIK: Aturan Wajib snake_case, Tidak Boleh Spasi, Huruf Kapital, atau Strip (-)
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide08NamingApp());
}

class Slide08NamingApp extends StatelessWidget {
  const Slide08NamingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 08 - Penamaan Proyek Flutter',
      theme: ThemeData(useMaterial3: true),
      home: const NamingScreen(),
    );
  }
}

class NamingScreen extends StatefulWidget {
  const NamingScreen({super.key});

  @override
  State<NamingScreen> createState() => _NamingScreenState();
}

class _NamingScreenState extends State<NamingScreen> {
  final TextEditingController _controller = TextEditingController(
    text: 'tugas_pertemuan_01',
  );
  String _inputName = 'tugas_pertemuan_01';

  Map<String, dynamic> _validateName(String name) {
    if (name.isEmpty) {
      return {'valid': false, 'msg': 'Nama proyek tidak boleh kosong!'};
    }
    if (name.contains(' ')) {
      return {
        'valid': false,
        'msg':
            '❌ DILARANG menggunakan spasi! Gunakan garis bawah (_) sebagai pemisah.',
      };
    }
    if (name.contains('-')) {
      return {
        'valid': false,
        'msg':
            '❌ DILARANG menggunakan tanda hubung strip (-)! Gunakan garis bawah (_).',
      };
    }
    if (RegExp(r'[A-Z]').hasMatch(name)) {
      return {
        'valid': false,
        'msg':
            '❌ DILARANG huruf besar/kapital! Flutter mewajibkan huruf kecil semua (snake_case).',
      };
    }
    if (RegExp(r'^[0-9]').hasMatch(name)) {
      return {
        'valid': false,
        'msg': '❌ DILARANG diawali angka! Nama harus diawali huruf a-z.',
      };
    }
    if (!RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(name)) {
      return {
        'valid': false,
        'msg':
            '❌ Hanya boleh menggunakan huruf kecil a-z, angka 0-9, dan underscore (_).',
      };
    }
    return {
      'valid': true,
      'msg': '✅ NAMA VALID! Proyek siap dibuat dengan aman.',
    };
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result = _validateName(_inputName);
    final isValid = result['valid'] as bool;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('SLIDE 08: Validator Nama Proyek Flutter'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Uji Validitas Nama Proyek Anda Sebelum "flutter create":',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              onChanged: (val) => setState(() => _inputName = val),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Ketik Nama Proyek di Sini',
                hintText: 'Contoh: tugas_pertemuan_01',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: Colors.black, width: 2.5),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Hasil Validasi
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isValid
                    ? const Color(0xFFDCFCE7)
                    : const Color(0xFFFFE4E6),
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result['msg'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: isValid ? Colors.green[900] : Colors.red[900],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Perintah Terminal yang Dihasilkan:\nflutter create $_inputName',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Contoh Benar vs Salah
            const Text(
              '📋 Tabel Contoh Nama:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 8),
            _buildSampleRow(
              'Tugas-1',
              false,
              'Ada huruf kapital & tanda strip (-)',
            ),
            _buildSampleRow('tugas 01', false, 'Mengandung spasi'),
            _buildSampleRow('1tugas', false, 'Diawali angka'),
            _buildSampleRow(
              'tugas_01',
              true,
              'Huruf kecil & garis bawah (Sempurna)',
            ),
            _buildSampleRow(
              'portal_kampus_app',
              true,
              'Standar snake_case industri',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSampleRow(String name, bool valid, String reason) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            valid ? Icons.check_circle : Icons.cancel,
            color: valid ? Colors.green : Colors.red,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '($reason)',
              style: const TextStyle(fontSize: 11, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

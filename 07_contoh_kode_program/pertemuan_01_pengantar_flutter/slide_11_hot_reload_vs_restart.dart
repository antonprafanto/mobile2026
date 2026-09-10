// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 11: HOT RELOAD VS HOT RESTART
// TOPIK: Pembuktian Nyata Mempertahankan State vs Menyetel Ulang State
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide11ReloadApp());
}

class Slide11ReloadApp extends StatelessWidget {
  const Slide11ReloadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 11 - Hot Reload vs Hot Restart',
      theme: ThemeData(useMaterial3: true),
      home: const ReloadLabScreen(),
    );
  }
}

class ReloadLabScreen extends StatefulWidget {
  const ReloadLabScreen({super.key});

  @override
  State<ReloadLabScreen> createState() => _ReloadLabScreenState();
}

class _ReloadLabScreenState extends State<ReloadLabScreen> {
  int _counter = 15; // Angka state simulasi
  Color _themeColor = const Color(0xFFFFE600); // Kuning

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('SLIDE 11: Lab Hot Reload vs Hot Restart'),
        backgroundColor: _themeColor,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Kartu Bukti State
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2.5),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(5, 5)),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'ANGKA STATE SAAT INI DI MEMORI:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_counter',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () => setState(() => _counter++),
                    child: const Text('+ Tambah Angka (+1)'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Tombol Ganti Warna UI (Simulasi Hot Reload)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(3, 3)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '⚡ SIMULASI HOT RELOAD (Tekan Ctrl+S / Huruf "r"):',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Klik tombol warna di bawah. Tampilan visual langsung berubah seketika, namun perhatikan angka $_counter di atas TIDAK PERNAH HILANG!',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildColorBtn('Kuning', const Color(0xFFFFE600)),
                      _buildColorBtn('Cyan', const Color(0xFF38BDF8)),
                      _buildColorBtn('Coral', const Color(0xFFFB7185)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Tombol Reset (Simulasi Hot Restart)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE4E6),
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(3, 3)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🔄 SIMULASI HOT RESTART (Tekan Huruf "R"):',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Menyetel ulang seluruh aplikasi dari awal. State angka akan di-reset kembali ke nilai awal (0).',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _counter = 0;
                        _themeColor = const Color(0xFFFFE600);
                      });
                    },
                    child: const Text('Jalankan Hot Restart (Reset ke 0)'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorBtn(String label, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.black, width: 1.5),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      onPressed: () => setState(() => _themeColor = color),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
      ),
    );
  }
}

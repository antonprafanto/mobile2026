// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 07: SIKLUS HIDUP STATEFUL WIDGET
// TOPIK: Memahami initState(), build(), setState(), dan dispose()
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide07LifecycleApp());

class Slide07LifecycleApp extends StatelessWidget {
  const Slide07LifecycleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: const LifecyclePage(),
    );
  }
}

class LifecyclePage extends StatefulWidget {
  const LifecyclePage({super.key});

  @override
  State<LifecyclePage> createState() => _LifecyclePageState();
}

class _LifecyclePageState extends State<LifecyclePage> {
  final List<String> _eventLogs = [];
  late TextEditingController _textController;
  int _buildCount = 0;

  // 1. Fase Kelahiran (Berjalan TEPAT 1 KALI)
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _logEvent('initState(): Widget lahir & TextEditingController disiapkan.');
  }

  // 2. Fase Ketergantungan
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _logEvent('didChangeDependencies(): Konteks & tema siap.');
  }

  void _logEvent(String pesan) {
    _eventLogs.add(
      '${DateTime.now().toIso8601String().substring(11, 19)} - $pesan',
    );
  }

  // 3. Fase Kematian / Pembersihan
  @override
  void dispose() {
    _textController.dispose(); // Wajib agar memori RAM tidak bocor!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buildCount++;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SLIDE 07 • SIKLUS HIDUP STATEFUL',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        backgroundColor: const Color(0xFFC084FC),
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(color: Colors.black, width: 2.5),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2.5),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Statistik Eksekusi Fase:',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• build() telah dijalankan: $_buildCount kali',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Ketik sesuatu di sini...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: const BorderSide(width: 2),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(width: 2.5),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _logEvent('setState(): Teks berubah menjadi "$val"');
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Log Riwayat Aktivitas
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE600),
                border: Border.all(color: Colors.black, width: 2.5),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'LOG AKTIVITAS SIKLUS HIDUP:',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  for (final log in _eventLogs.reversed.take(6))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        '• $log',
                        style: const TextStyle(
                          fontFamily: 'Consolas',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

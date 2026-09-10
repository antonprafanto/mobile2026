// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 02: PANDUAN ALAT & WORKFLOW PENGUJIAN
// TOPIK: Menguji Widget Tree via Chrome (Web), HP Fisik, & Hot Reload
// =====================================================================
// CARA MENJALANKAN DI TERMINAL VS CODE:
// 1. Jalankan di Google Chrome (Paling Ringan & Instan di Lab):
//    $ flutter run -d chrome
// 2. Jalankan di Smartphone Fisik via Kabel Data USB:
//    $ flutter run
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide02ToolsApp());
}

class Slide02ToolsApp extends StatelessWidget {
  const Slide02ToolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 02 - Panduan Tools & Workflow',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAF8F5),
        fontFamily: 'Segoe UI',
      ),
      home: const WorkflowScreen(),
    );
  }
}

class WorkflowScreen extends StatefulWidget {
  const WorkflowScreen({super.key});

  @override
  State<WorkflowScreen> createState() => _WorkflowScreenState();
}

class _WorkflowScreenState extends State<WorkflowScreen> {
  int _counter = 0;
  String _targetDevice = 'Google Chrome (Web)';

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SLIDE 02 • WORKFLOW PRAKTIKUM LAB',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFFFE600),
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
            // Banner Neo-Brutalist
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    color: const Color(0xFF38BDF8),
                    child: const Text(
                      'PANDUAN ALAT UJI MINGGU KE-3',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Pilih Target Eksekusi Tercepat:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '1. Google Chrome (flutter run -d chrome): Kompilasi kilat ~5 detik, hemat RAM (<150MB).\n'
                    '2. HP Fisik via USB (flutter run): Menguji gesture sentuhan nyata tanpa beban emulator.\n'
                    '3. Hot Reload (r di terminal / Ctrl+S): Perubahan kode ter-update dalam 500 milidetik!',
                    style: TextStyle(fontSize: 13, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Selector Target Device
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        setState(() => _targetDevice = 'Google Chrome (Web)'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _targetDevice.contains('Chrome')
                          ? const Color(0xFF4ADE80)
                          : Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      side: const BorderSide(color: Colors.black, width: 2),
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: const Text(
                      'Target Chrome',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(
                      () => _targetDevice = 'Smartphone USB Real Device',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _targetDevice.contains('USB')
                          ? const Color(0xFFFB7185)
                          : Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      side: const BorderSide(color: Colors.black, width: 2),
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: const Text(
                      'Target HP Fisik',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Kotak Uji Hot Reload
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
                children: [
                  const Text(
                    'UJI KEAJAIBAN HOT RELOAD:',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nilai Counter: $_counter',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _increment,
                    icon: const Icon(Icons.touch_app),
                    label: const Text('TEKAN UNTUK UBAH STATE (+1)'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: const RoundedRectangleBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '💡 Tips: Saat angka bertambah, ubah teks judul di baris 48 kode ini lalu tekan Ctrl+S. '
                    'Nilai angka ini TIDAK AKAN HILANG berkat State Preservation Hot Reload!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
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

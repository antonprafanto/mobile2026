// =====================================================================
// SLIDE 18: PREVIEW MODERN DART (PERTEMUAN 02)
// Topik: Null Safety, Collections, dan Asynchronous (Future)
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const PreviewDartApp());
}

class PreviewDartApp extends StatelessWidget {
  const PreviewDartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 18 - Preview Modern Dart',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const PreviewDartScreen(),
    );
  }
}

class PreviewDartScreen extends StatefulWidget {
  const PreviewDartScreen({super.key});

  @override
  State<PreviewDartScreen> createState() => _PreviewDartScreenState();
}

class _PreviewDartScreenState extends State<PreviewDartScreen> {
  // 1. Null Safety: Variabel yang boleh bernilai null
  String? _pesanOpsional;

  // 2. Asynchronous: Status pengambilan data simulasi
  bool _isLoading = false;
  String _hasilData = 'Belum ada data.';

  Future<void> _ambilDataServer() async {
    setState(() {
      _isLoading = true;
      _hasilData = 'Menghubungi server...';
    });

    // Simulasi delay 2 detik
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _hasilData = 'Data berhasil diunduh dari cloud!';
      _pesanOpsional = 'Status: 200 OK (Koneksi Aman)';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 18: Preview Modern Dart'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.shield_outlined),
                title: const Text('1. Sound Null Safety'),
                subtitle: Text(
                  'Catatan Opsional: ${_pesanOpsional ?? "Kosong (null)"}',
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '2. Asynchronous (Future & async/await)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(_hasilData),
                    const SizedBox(height: 12),
                    if (_isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      ElevatedButton.icon(
                        onPressed: _ambilDataServer,
                        icon: const Icon(Icons.cloud_download),
                        label: const Text('Ambil Data (Delay 2 Detik)'),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

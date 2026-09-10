// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 15: DETEKSI PERANGKAT & UKURAN LAYAR
// TOPIK: Menguji Aplikasi di Smartphone Fisik via Kabel Data USB
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Tancapkan HP Android dengan USB Debugging aktif
// 3. Jalankan di terminal: flutter run
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide15DeviceInfoApp());
}

class Slide15DeviceInfoApp extends StatelessWidget {
  const Slide15DeviceInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 15 - Device Hardware Info',
      theme: ThemeData(useMaterial3: true),
      home: const DeviceInfoScreen(),
    );
  }
}

class DeviceInfoScreen extends StatelessWidget {
  const DeviceInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final orientation = media.orientation == Orientation.portrait
        ? 'Portrait (Tegak)'
        : 'Landscape (Miring)';

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('SLIDE 15: Detektor Layar Smartphone Fisik'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
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
                    '📱 INFORMASI DIMENSI LAYAR PERANGKAT INI:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const Divider(color: Colors.black, thickness: 1, height: 16),
                  _buildMetricRow(
                    'Lebar Layar (Width)',
                    '${media.size.width.toStringAsFixed(1)} dp',
                  ),
                  _buildMetricRow(
                    'Tinggi Layar (Height)',
                    '${media.size.height.toStringAsFixed(1)} dp',
                  ),
                  _buildMetricRow(
                    'Device Pixel Ratio',
                    '${media.devicePixelRatio}x',
                  ),
                  _buildMetricRow('Orientasi Saat Ini', orientation),
                  _buildMetricRow(
                    'Bilah Status Atas (Padding Top)',
                    '${media.padding.top.toStringAsFixed(1)} px',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Panduan Langkah USB Debugging
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(3, 3)),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🔌 3 LANGKAH HUBUNGKAN SMARTPHONE FISIK KE PC LAB:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1. Buka Pengaturan HP -> Tentang Ponsel -> Ketuk "Nomor Bentukan (Build Number)" 7 kali sampai Developer Options aktif.\n'
                    '2. Buka Opsi Pengembang -> Aktifkan "USB Debugging".\n'
                    '3. Sambungkan kabel data USB ke PC, lalu jalankan perintah di terminal:\n'
                    '   adb devices\n'
                    '   scrcpy (opsional: untuk memproyeksikan layar HP ke PC)\n'
                    '   flutter run',
                    style: TextStyle(fontSize: 12, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

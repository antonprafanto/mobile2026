// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 03: EVERYTHING IS A WIDGET
// TOPIK: Menyusun Widget Bertingkat Seperti Balok Lego
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiLegoWidget());
}

class AplikasiLegoWidget extends StatelessWidget {
  const AplikasiLegoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Everything is a Widget'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          // Center: Widget untuk memposisikan anak ke tengah
          child: Container(
            // Container: Widget kotak pembungkus
            padding: const EdgeInsets.all(20),
            color: Colors.blue[50],
            child: Column(
              // Column: Widget penyusun vertikal
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.widgets, size: 50, color: Colors.blue),
                const SizedBox(height: 10), // SizedBox: Widget pemberi spasi
                const Text(
                  'Semua Hal di Sini Adalah Widget',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Aksi saat tombol diklik
                  },
                  child: const Text('Ini Tombol (Widget)'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

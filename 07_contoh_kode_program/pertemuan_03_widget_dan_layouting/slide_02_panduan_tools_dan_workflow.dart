// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 02: PANDUAN TOOLS & WORKFLOW
// TOPIK: Menguji Perubahan dengan Hot Reload (r di terminal / Ctrl+S)
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiWorkflow());
}

class AplikasiWorkflow extends StatefulWidget {
  const AplikasiWorkflow({super.key});

  @override
  State<AplikasiWorkflow> createState() => _AplikasiWorkflowState();
}

class _AplikasiWorkflowState extends State<AplikasiWorkflow> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Uji Coba Hot Reload'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Tekan tombol + untuk menambah angka:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                '$_counter',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Tips: Coba ubah teks di kode atau warna AppBar menjadi Colors.green, '
                  'lalu tekan Ctrl+S (Simpan). Nilai angka di atas TIDAK akan reset '
                  'berkat fitur Hot Reload!',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _counter++;
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 21: SOLUSI UNBOUNDED HEIGHT ERROR
// TOPIK: Mengatasi Error "Vertical viewport was given unbounded height"
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide21UnboundedFixApp());

class Slide21UnboundedFixApp extends StatelessWidget {
  const Slide21UnboundedFixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SLIDE 21 • SOLUSI UNBOUNDED HEIGHT',
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
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Statis
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(3, 3)),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jebakan Maut: ListView di Dalam Column',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Column memberi tinggi tak hingga (infinity), sementara ListView ingin ruang tak hingga.\n'
                      'Akibatnya crash fatal: "Vertical viewport was given unbounded height".\n'
                      '✓ SOLUSI 1: Bungkus ListView dengan widget Expanded(child: ListView...)\n'
                      '✓ SOLUSI 2: Pasang shrinkWrap: true dan physics: NeverScrollableScrollPhysics().',
                      style: TextStyle(fontSize: 12, height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'Daftar Mahasiswa (Di Dalam Expanded):',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),

              // SOLUSI: Bungkus ListView dengan Expanded di dalam Column!
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE600),
                    border: Border.all(color: Colors.black, width: 2.5),
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: 15,
                    separatorBuilder: (ctx, i) =>
                        const Divider(color: Colors.black, height: 16),
                    itemBuilder: (ctx, i) {
                      return ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          child: Text('${i + 1}'),
                        ),
                        title: Text(
                          'Mahasiswa Informatika #${i + 1}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text('Status: Aktif Praktikum'),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 06: STATELESS VS STATEFUL WIDGET
// TOPIK: Komponen Statis (Diam) vs Komponen Dinamis (Interaktif)
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiStatelessStateful());
}

class AplikasiStatelessStateful extends StatelessWidget {
  const AplikasiStatelessStateful({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Stateless vs Stateful')),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. StatelessWidget: Tampilan tidak pernah berubah
              TeksStatis(judul: 'Ini StatelessWidget (Statis)'),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              // 2. StatefulWidget: Tampilan bisa berubah dengan setState()
              PenghitungStateful(),
            ],
          ),
        ),
      ),
    );
  }
}

// Komponen Statis (Stateless)
class TeksStatis extends StatelessWidget {
  final String judul;
  const TeksStatis({super.key, required this.judul});

  @override
  Widget build(BuildContext context) {
    return Text(
      judul,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

// Komponen Dinamis (Stateful)
class PenghitungStateful extends StatefulWidget {
  const PenghitungStateful({super.key});

  @override
  State<PenghitungStateful> createState() => _PenghitungStatefulState();
}

class _PenghitungStatefulState extends State<PenghitungStateful> {
  int _jumlahKlik = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ini StatefulWidget (Dinamis):',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text('Tombol sudah ditekan: $_jumlahKlik kali'),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _jumlahKlik++;
            });
          },
          child: const Text('Tambah Nilai'),
        ),
      ],
    );
  }
}

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 04: WIDGET & TATA LETAK
// CONTOH 07: Constraints (Batasan Ukuran)
// Topik: "Constraints turun, ukuran naik, induk menentukan posisi."
//        LayoutBuilder menampilkan batasan yang diterima sebuah widget.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiConstraints());
}

class AplikasiConstraints extends StatelessWidget {
  const AplikasiConstraints({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: const HalamanConstraints(),
    );
  }
}

class HalamanConstraints extends StatelessWidget {
  const HalamanConstraints({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Constraints')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          // start: anak Column boleh lebih sempit daripada layar
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1) Di dalam SizedBox 260 x 60: batasannya KETAT (tight).
            //    Minimum = maksimum, jadi anak WAJIB berukuran 260 x 60.
            SizedBox(
              width: 260,
              height: 60,
              child: ColoredBox(
                color: warna.primaryContainer,
                child: const InfoBatasan(judul: 'Di dalam SizedBox 260x60'),
              ),
            ),
            const SizedBox(height: 16),

            // 2) Di dalam Center: batasannya LONGGAR (loose).
            //    Anak boleh berukuran 0 sampai selebar ruang yang ada.
            SizedBox(
              height: 60,
              child: ColoredBox(
                color: warna.secondaryContainer,
                child: const Center(
                  child: InfoBatasan(judul: 'Di dalam Center'),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3) Di dalam Row: lebar TIDAK TERBATAS (maksimum = Infinity).
            //    Itulah sebabnya teks panjang di Row bisa "meluber" (overflow).
            ColoredBox(
              color: warna.tertiaryContainer,
              child: const Row(children: [InfoBatasan(judul: 'Di dalam Row')]),
            ),
            const SizedBox(height: 16),

            // 4) Container 100 x 100 di dalam Center: ukurannya dihormati.
            SizedBox(
              height: 140,
              child: ColoredBox(
                color: warna.surfaceContainerHighest,
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    color: warna.primary,
                    alignment: Alignment.center,
                    child: Text(
                      '100 x 100',
                      style: TextStyle(color: warna.onPrimary),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Menampilkan batasan lebar yang diterima dari induknya.
class InfoBatasan extends StatelessWidget {
  const InfoBatasan({super.key, required this.judul});

  final String judul;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints batasan) {
        String minimum = batasan.minWidth.toStringAsFixed(0);
        String maksimum = batasan.maxWidth.toStringAsFixed(0);
        return Text('$judul\nlebar minimum $minimum, maksimum $maksimum');
      },
    );
  }
}

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 05: INTERAKSI & STATE LOKAL
// CONTOH 06: Siklus Hidup State
// Topik: Urutan createState, initState, didChangeDependencies, build,
//        didUpdateWidget, deactivate, dan dispose, dilihat langsung
//        lewat catatan di konsol.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// 4. Buka konsol (panel "Console" di DartPad, atau terminal tempat
//    flutter run berjalan), lalu tekan tombol-tombolnya satu per satu.
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiSiklusHidup());
}

class AplikasiSiklusHidup extends StatelessWidget {
  const AplikasiSiklusHidup({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const HalamanSiklusHidup(),
    );
  }
}

// Halaman INDUK: bisa memunculkan/menghilangkan kartu dan mengirim judul
// baru kepadanya.
class HalamanSiklusHidup extends StatefulWidget {
  const HalamanSiklusHidup({super.key});

  @override
  State<HalamanSiklusHidup> createState() => _HalamanSiklusHidupState();
}

class _HalamanSiklusHidupState extends State<HalamanSiklusHidup> {
  bool _kartuTampil = true;
  int _versiJudul = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Siklus Hidup State')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            const Text(
              'Buka konsol, lalu tekan tombol di bawah ini satu per satu. '
              'Perhatikan urutan catatan yang muncul.',
            ),
            FilledButton.tonal(
              onPressed: () {
                setState(() {
                  _kartuTampil = !_kartuTampil;
                });
              },
              child: Text(
                _kartuTampil ? 'Sembunyikan kartu' : 'Tampilkan kartu',
              ),
            ),
            OutlinedButton(
              // Tombol ini hanya aktif selama kartu tampil.
              onPressed: _kartuTampil
                  ? () {
                      setState(() {
                        _versiJudul++;
                      });
                    }
                  : null,
              child: const Text('Kirim judul baru ke kartu'),
            ),
            // Kartu hanya ada di pohon widget jika _kartuTampil bernilai true.
            if (_kartuTampil)
              KartuPenghitung(judul: 'Kartu versi $_versiJudul'),
          ],
        ),
      ),
    );
  }
}

// Widget ANAK yang siklus hidupnya kita amati.
class KartuPenghitung extends StatefulWidget {
  const KartuPenghitung({super.key, required this.judul});

  final String judul;

  @override
  State<KartuPenghitung> createState() => _KartuPenghitungState();
}

class _KartuPenghitungState extends State<KartuPenghitung> {
  int _jumlah = 0;

  // Constructor ini hanya untuk demonstrasi: ia berjalan tepat saat
  // createState() membuat objek State. Biasanya State tidak perlu
  // constructor sendiri.
  _KartuPenghitungState() {
    debugPrint('1. createState(): objek State dibuat');
  }

  @override
  void initState() {
    super.initState(); // WAJIB dipanggil paling awal
    debugPrint('2. initState(): persiapan SEKALI (judul: ${widget.judul})');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint(
      '3. didChangeDependencies(): data dari atas (misalnya tema) siap',
    );
  }

  @override
  void didUpdateWidget(KartuPenghitung oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint(
      'didUpdateWidget(): judul "${oldWidget.judul}" -> "${widget.judul}"',
    );
  }

  @override
  void deactivate() {
    debugPrint('deactivate(): kartu dilepas dari pohon widget');
    super.deactivate();
  }

  @override
  void dispose() {
    debugPrint('dispose(): State dibuang selamanya (_jumlah ikut hilang)');
    super.dispose(); // WAJIB dipanggil paling akhir
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build(): menggambar kartu (_jumlah = $_jumlah)');
    return Card.outlined(
      child: ListTile(
        leading: const Icon(Icons.layers),
        title: Text(widget.judul),
        subtitle: Text('Tombol + sudah ditekan $_jumlah kali'),
        trailing: IconButton.filledTonal(
          tooltip: 'Tambah',
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              _jumlah++;
            });
          },
        ),
      ),
    );
  }
}

// CONTOH ISI KONSOL (urutan yang benar):
// --- saat aplikasi dibuka ---
// 1. createState(): objek State dibuat
// 2. initState(): persiapan SEKALI (judul: Kartu versi 1)
// 3. didChangeDependencies(): data dari atas (misalnya tema) siap
// build(): menggambar kartu (_jumlah = 0)
// --- tombol + ditekan ---
// build(): menggambar kartu (_jumlah = 1)
// --- "Kirim judul baru ke kartu" ditekan ---
// didUpdateWidget(): judul "Kartu versi 1" -> "Kartu versi 2"
// build(): menggambar kartu (_jumlah = 1)
// --- "Sembunyikan kartu" ditekan ---
// deactivate(): kartu dilepas dari pohon widget
// dispose(): State dibuang selamanya (_jumlah ikut hilang)
// --- "Tampilkan kartu" ditekan: semuanya mulai lagi dari nol ---
// 1. createState(): objek State dibuat
// 2. initState(): persiapan SEKALI (judul: Kartu versi 2)
// 3. didChangeDependencies(): data dari atas (misalnya tema) siap
// build(): menggambar kartu (_jumlah = 0)

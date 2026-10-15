// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 05: INTERAKSI & STATE LOKAL
// CONTOH 09: Dialog dan Bottom Sheet
// Topik: Meminta konfirmasi dengan AlertDialog, meminta pilihan dengan
//        bottom sheet, menunggu jawabannya dengan await, lalu memeriksa
//        mounted sebelum memakai context atau setState.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiDaftarTugas());
}

enum Prioritas {
  tinggi('Tinggi', Icons.keyboard_double_arrow_up),
  sedang('Sedang', Icons.drag_handle),
  rendah('Rendah', Icons.keyboard_double_arrow_down);

  const Prioritas(this.label, this.ikon);

  final String label;
  final IconData ikon;
}

class Tugas {
  Tugas(this.judul, this.prioritas);

  final String judul;
  Prioritas prioritas; // boleh berubah, jadi tidak final
}

class AplikasiDaftarTugas extends StatelessWidget {
  const AplikasiDaftarTugas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HalamanDaftarTugas(),
    );
  }
}

class HalamanDaftarTugas extends StatefulWidget {
  const HalamanDaftarTugas({super.key});

  @override
  State<HalamanDaftarTugas> createState() => _HalamanDaftarTugasState();
}

class _HalamanDaftarTugasState extends State<HalamanDaftarTugas> {
  final List<Tugas> _daftar = [
    Tugas('Laporan praktikum Pertemuan 4', Prioritas.tinggi),
    Tugas('Membaca modul Pertemuan 5', Prioritas.sedang),
    Tugas('Merapikan catatan kuliah', Prioritas.rendah),
  ];

  // ---------- 1) AlertDialog: meminta konfirmasi ----------
  // async karena kita MENUNGGU jawaban pengguna (Pertemuan 3).
  Future<void> _konfirmasiHapus(Tugas tugas) async {
    final bool? yakin = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.delete_outline),
          title: const Text('Hapus tugas?'),
          content: Text('"${tugas.judul}" akan dihapus dari daftar.'),
          actions: [
            // Navigator.pop menutup dialog sambil mengirim jawaban.
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    // Selama menunggu, halaman ini bisa saja sudah ditutup.
    // Periksa dulu sebelum memakai context atau setState.
    if (!mounted) return;
    // yakin bisa null jika dialog ditutup dengan mengetuk area gelap.
    if (yakin != true) return;

    setState(() {
      _daftar.remove(tugas);
    });
    final ScaffoldMessengerState pesan = ScaffoldMessenger.of(context);
    pesan.hideCurrentSnackBar(); // tutup pesan lama agar tidak antre
    pesan.showSnackBar(SnackBar(content: Text('"${tugas.judul}" dihapus.')));
  }

  // ---------- 2) Bottom sheet: meminta sebuah pilihan ----------
  Future<void> _pilihPrioritas(Tugas tugas) async {
    final Prioritas? pilihan = await showModalBottomSheet<Prioritas>(
      context: context,
      showDragHandle: true, // garis kecil di atas lembar
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min, // setinggi isinya saja
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Prioritas: ${tugas.judul}',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              for (Prioritas p in Prioritas.values)
                ListTile(
                  leading: Icon(p.ikon),
                  title: Text(p.label),
                  trailing: p == tugas.prioritas
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () => Navigator.pop(context, p),
                ),
            ],
          ),
        );
      },
    );

    if (!mounted) return;
    if (pilihan == null) return; // ditutup tanpa memilih

    setState(() {
      tugas.prioritas = pilihan;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Tugas Kuliah')),
      body: _daftar.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Icon(Icons.task_alt, size: 64, color: warna.primary),
                  const Text('Semua tugas sudah beres!'),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 8,
                children: [
                  const Text(
                    'Ketuk tugas untuk mengubah prioritas. '
                    'Tekan ikon tempat sampah untuk menghapus.',
                  ),
                  for (Tugas tugas in _daftar)
                    Card(
                      child: ListTile(
                        leading: Icon(
                          tugas.prioritas.ikon,
                          color: warna.primary,
                        ),
                        title: Text(tugas.judul),
                        subtitle: Text('Prioritas ${tugas.prioritas.label}'),
                        onTap: () => _pilihPrioritas(tugas),
                        trailing: IconButton(
                          tooltip: 'Hapus',
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => _konfirmasiHapus(tugas),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 09: MANAJEMEN STATE & MVVM
// CONTOH 03: ValueNotifier dan ValueListenableBuilder
// Topik: Untuk SATU nilai sederhana, Flutter menyediakan ValueNotifier.
//        Mengganti .value otomatis mengumumkan perubahan, tanpa perlu
//        menulis class sendiri. Jebakannya: mengubah ISI sebuah List
//        (misalnya dengan .add) TIDAK dianggap perubahan, karena objek
//        List-nya tetap sama. Coba tekan "Tambah (cara salah)" dua kali,
//        lalu "Tambah (cara benar)" sekali, dan perhatikan jumlahnya.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiTiket());
}

class AplikasiTiket extends StatelessWidget {
  const AplikasiTiket({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tiket Seminar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HalamanTiket(),
    );
  }
}

class HalamanTiket extends StatefulWidget {
  const HalamanTiket({super.key});

  @override
  State<HalamanTiket> createState() => _HalamanTiketState();
}

class _HalamanTiketState extends State<HalamanTiket> {
  // ValueNotifier<T> = ChangeNotifier siap pakai untuk satu nilai bertipe T.
  final ValueNotifier<int> _jumlahTiket = ValueNotifier<int>(1);
  final ValueNotifier<List<String>> _peserta = ValueNotifier<List<String>>([]);

  @override
  void dispose() {
    _jumlahTiket.dispose();
    _peserta.dispose();
    super.dispose();
  }

  // SALAH: isi List bertambah, tetapi .value masih objek yang SAMA,
  // jadi ValueNotifier tidak tahu ada perubahan.
  void _tambahCaraSalah() {
    _peserta.value.add('Peserta ${_peserta.value.length + 1}');
  }

  // BENAR: buat List BARU (salinan lama + satu nama), lalu ganti .value.
  void _tambahCaraBenar() {
    _peserta.value = [
      ..._peserta.value,
      'Peserta ${_peserta.value.length + 1}',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Tiket Seminar')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('1. Satu nilai: jumlah tiket', style: gayaTeks.titleMedium),
          const SizedBox(height: 8),
          // Builder menerima nilai terbaru sebagai parameter kedua.
          ValueListenableBuilder<int>(
            valueListenable: _jumlahTiket,
            builder: (BuildContext context, int jumlah, Widget? child) {
              return Row(
                children: [
                  IconButton.filledTonal(
                    onPressed: jumlah > 1 ? () => _jumlahTiket.value-- : null,
                    tooltip: 'Kurangi',
                    icon: const Icon(Icons.remove),
                  ),
                  Expanded(
                    child: Text(
                      '$jumlah tiket',
                      textAlign: TextAlign.center,
                      style: gayaTeks.headlineSmall,
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: jumlah < 5 ? () => _jumlahTiket.value++ : null,
                    tooltip: 'Tambah',
                    icon: const Icon(Icons.add),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 32),
          Text(
            '2. Jebakan: isi List berubah, objeknya tetap',
            style: gayaTeks.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton(
                onPressed: _tambahCaraSalah,
                child: const Text('Tambah (cara salah)'),
              ),
              FilledButton(
                onPressed: _tambahCaraBenar,
                child: const Text('Tambah (cara benar)'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<List<String>>(
            valueListenable: _peserta,
            builder:
                (BuildContext context, List<String> daftar, Widget? child) {
                  return Card.outlined(
                    child: ListTile(
                      leading: const Icon(Icons.groups),
                      title: Text('${daftar.length} peserta terdaftar'),
                      subtitle: Text(
                        daftar.isEmpty
                            ? 'Belum ada peserta.'
                            : daftar.join(', '),
                      ),
                    ),
                  );
                },
          ),
        ],
      ),
    );
  }
}

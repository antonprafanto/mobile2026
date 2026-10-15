// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 05: INTERAKSI & STATE LOKAL
// CONTOH 11: Studi Kasus - Memesan Menu Kantin
// Topik: Halaman detail menu dari Pertemuan 4 kini benar-benar bekerja:
//        porsi, level pedas, tambahan, catatan, jumlah, favorit, total
//        harga yang ikut berubah, dialog konfirmasi, dan SnackBar.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiPesanMenu());
}

const int hargaDasar = 18000;

enum Porsi {
  reguler('Reguler', 0),
  jumbo('Jumbo', 5000);

  const Porsi(this.label, this.tambahanHarga);

  final String label;
  final int tambahanHarga;
}

enum Tambahan {
  telur('Telur ceplok', 3000),
  kerupuk('Kerupuk', 2000),
  sateUsus('Sate usus', 4000);

  const Tambahan(this.label, this.harga);

  final String label;
  final int harga;
}

// Mengubah 18000 menjadi "Rp18.000".
String formatRupiah(int angka) {
  final String digit = angka.toString();
  String hasil = '';
  for (int i = 0; i < digit.length; i++) {
    final int sisaDiKanan = digit.length - i;
    if (i > 0 && sisaDiKanan % 3 == 0) {
      hasil += '.';
    }
    hasil += digit[i];
  }
  return 'Rp$hasil';
}

class AplikasiPesanMenu extends StatelessWidget {
  const AplikasiPesanMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const HalamanPesanMenu(),
    );
  }
}

class HalamanPesanMenu extends StatefulWidget {
  const HalamanPesanMenu({super.key});

  @override
  State<HalamanPesanMenu> createState() => _HalamanPesanMenuState();
}

class _HalamanPesanMenuState extends State<HalamanPesanMenu> {
  // ---------- STATE: semua hal yang bisa diubah pengguna ----------
  Porsi _porsi = Porsi.reguler;
  double _levelPedas = 2;
  final Set<Tambahan> _tambahan = {};
  int _jumlah = 1;
  bool _favorit = false;
  final TextEditingController _kontrolCatatan = TextEditingController();

  @override
  void dispose() {
    _kontrolCatatan.dispose();
    super.dispose();
  }

  // ---------- NILAI TURUNAN: dihitung dari state, tidak disimpan ----------
  int get _hargaSatuan {
    int harga = hargaDasar + _porsi.tambahanHarga;
    for (Tambahan tambahan in _tambahan) {
      harga += tambahan.harga;
    }
    return harga;
  }

  int get _totalHarga => _hargaSatuan * _jumlah;

  String get _keteranganPedas {
    // switch ekspresi (Pertemuan 2).
    return switch (_levelPedas.round()) {
      0 => 'Tidak pedas',
      1 => 'Sedikit pedas',
      2 => 'Pedas sedang',
      3 => 'Pedas',
      4 => 'Sangat pedas',
      _ => 'Pedas maksimal',
    };
  }

  Future<void> _pesan() async {
    final String catatan = _kontrolCatatan.text.trim();
    final String daftarTambahan = _tambahan.isEmpty
        ? 'Tanpa tambahan'
        : 'Tambahan: ${_tambahan.map((Tambahan t) => t.label).join(', ')}';

    final bool? jadiPesan = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi pesanan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text('$_jumlah x Nasi Goreng Kampung (${_porsi.label})'),
              Text('Level pedas ${_levelPedas.round()}: $_keteranganPedas'),
              Text(daftarTambahan),
              if (catatan.isNotEmpty) Text('Catatan: $catatan'),
              const Divider(),
              Text(
                'Total ${formatRupiah(_totalHarga)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Ubah lagi'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Pesan'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;
    if (jadiPesan != true) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Pesanan dikirim ke dapur. Total ${formatRupiah(_totalHarga)}.',
        ),
      ),
    );
    // Kembalikan pilihan ke keadaan awal untuk pesanan berikutnya.
    _kontrolCatatan.clear();
    setState(() {
      _porsi = Porsi.reguler;
      _levelPedas = 2;
      _tambahan.clear();
      _jumlah = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Pesan Menu')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const BannerMenu(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Expanded(
                        child: Text(
                          'Nasi Goreng Kampung',
                          style: gayaTeks.headlineSmall,
                        ),
                      ),
                      Text(
                        formatRupiah(hargaDasar),
                        style: gayaTeks.titleLarge?.copyWith(
                          color: warna.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Nasi goreng bumbu kampung dengan ayam suwir dan acar.',
                  ),
                  const Divider(),

                  // 1) Porsi: SegmentedButton
                  Text('Porsi', style: gayaTeks.titleMedium),
                  SegmentedButton<Porsi>(
                    segments: [
                      for (Porsi porsi in Porsi.values)
                        ButtonSegment<Porsi>(
                          value: porsi,
                          label: Text(
                            porsi.tambahanHarga == 0
                                ? porsi.label
                                : '${porsi.label} +${formatRupiah(porsi.tambahanHarga)}',
                          ),
                        ),
                    ],
                    selected: {_porsi},
                    onSelectionChanged: (Set<Porsi> pilihan) {
                      setState(() {
                        _porsi = pilihan.first;
                      });
                    },
                  ),

                  // 2) Level pedas: Slider
                  Row(
                    children: [
                      Expanded(
                        child: Text('Level pedas', style: gayaTeks.titleMedium),
                      ),
                      Text('${_levelPedas.round()} · $_keteranganPedas'),
                    ],
                  ),
                  Slider(
                    value: _levelPedas,
                    max: 5,
                    divisions: 5,
                    label: '${_levelPedas.round()}',
                    onChanged: (double nilaiBaru) {
                      setState(() {
                        _levelPedas = nilaiBaru;
                      });
                    },
                  ),

                  // 3) Tambahan: FilterChip (boleh lebih dari satu)
                  Text('Tambahan', style: gayaTeks.titleMedium),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (Tambahan tambahan in Tambahan.values)
                        FilterChip(
                          label: Text(
                            '${tambahan.label} +${formatRupiah(tambahan.harga)}',
                          ),
                          selected: _tambahan.contains(tambahan),
                          onSelected: (bool dipilih) {
                            setState(() {
                              if (dipilih) {
                                _tambahan.add(tambahan);
                              } else {
                                _tambahan.remove(tambahan);
                              }
                            });
                          },
                        ),
                    ],
                  ),

                  // 4) Catatan: TextField + controller
                  TextField(
                    controller: _kontrolCatatan,
                    maxLength: 50,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Catatan untuk penjual (opsional)',
                      hintText: 'misalnya: tanpa bawang',
                      prefixIcon: Icon(Icons.edit_note),
                      border: OutlineInputBorder(),
                    ),
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                  ),

                  // 5) Jumlah: widget TombolJumlah (state diangkat ke halaman)
                  Row(
                    children: [
                      Expanded(
                        child: Text('Jumlah', style: gayaTeks.titleMedium),
                      ),
                      TombolJumlah(
                        jumlah: _jumlah,
                        minimum: 1,
                        maksimum: 10,
                        onKurang: () {
                          setState(() {
                            _jumlah--;
                          });
                        },
                        onTambah: () {
                          setState(() {
                            _jumlah++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 12,
            children: [
              IconButton.outlined(
                isSelected: _favorit,
                tooltip: _favorit ? 'Hapus dari favorit' : 'Simpan ke favorit',
                icon: const Icon(Icons.favorite_border),
                selectedIcon: const Icon(Icons.favorite),
                onPressed: () {
                  setState(() {
                    _favorit = !_favorit;
                  });
                },
              ),
              // Label tombol ikut berubah setiap kali state berubah.
              Expanded(
                child: FilledButton.icon(
                  onPressed: _pesan,
                  icon: const Icon(Icons.add_shopping_cart),
                  label: Text('Pesan · ${formatRupiah(_totalHarga)}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Gambar utama + lencana (dari studi kasus Pertemuan 4).
class BannerMenu extends StatelessWidget {
  const BannerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Container(
          height: 160,
          color: warna.primaryContainer,
          child: Center(
            child: Icon(
              Icons.rice_bowl,
              size: 96,
              color: warna.onPrimaryContainer,
            ),
          ),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: warna.error,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('Terlaris', style: TextStyle(color: warna.onError)),
          ),
        ),
      ],
    );
  }
}

// TombolJumlah dari contoh 10, kini dengan batas minimum dan maksimum.
class TombolJumlah extends StatelessWidget {
  const TombolJumlah({
    super.key,
    required this.jumlah,
    required this.onTambah,
    required this.onKurang,
    this.minimum = 0,
    this.maksimum = 99,
  });

  final int jumlah;
  final VoidCallback onTambah;
  final VoidCallback onKurang;
  final int minimum;
  final int maksimum;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.outlined(
          tooltip: 'Kurangi',
          onPressed: jumlah > minimum ? onKurang : null,
          icon: const Icon(Icons.remove),
        ),
        SizedBox(
          width: 32,
          child: Text(
            '$jumlah',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        IconButton.filled(
          tooltip: 'Tambah',
          onPressed: jumlah < maksimum ? onTambah : null,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

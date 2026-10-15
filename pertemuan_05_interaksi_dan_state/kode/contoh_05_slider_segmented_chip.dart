// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 05: INTERAKSI & STATE LOKAL
// CONTOH 05: Slider, SegmentedButton, dan Chip
// Topik: Memilih angka dengan Slider, memilih satu pilihan dengan
//        SegmentedButton dan ChoiceChip, serta memilih banyak pilihan
//        dengan FilterChip.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiRacikMinuman());
}

enum UkuranGelas {
  kecil('Kecil'),
  sedang('Sedang'),
  besar('Besar');

  const UkuranGelas(this.label);

  final String label;
}

const List<String> daftarTopping = ['Boba', 'Jeli', 'Selasih', 'Krim keju'];

class AplikasiRacikMinuman extends StatelessWidget {
  const AplikasiRacikMinuman({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: const HalamanRacikMinuman(),
    );
  }
}

class HalamanRacikMinuman extends StatefulWidget {
  const HalamanRacikMinuman({super.key});

  @override
  State<HalamanRacikMinuman> createState() => _HalamanRacikMinumanState();
}

class _HalamanRacikMinumanState extends State<HalamanRacikMinuman> {
  UkuranGelas _ukuran = UkuranGelas.sedang;
  double _manis = 50; // persen gula: 0, 25, 50, 75, atau 100
  bool _dingin = true;
  // Set: kumpulan pilihan tanpa isi kembar (Pertemuan 2).
  final Set<String> _topping = {};

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    final String teksTopping = _topping.isEmpty
        ? 'tanpa topping'
        : 'topping ${_topping.join(', ')}';

    return Scaffold(
      appBar: AppBar(title: const Text('Racik Minuman')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            // ---------- 1) SegmentedButton: pilih SATU ----------
            Text('Ukuran gelas', style: gayaTeks.titleMedium),
            SegmentedButton<UkuranGelas>(
              segments: [
                for (UkuranGelas ukuran in UkuranGelas.values)
                  ButtonSegment<UkuranGelas>(
                    value: ukuran,
                    label: Text(ukuran.label),
                  ),
              ],
              // selected berupa Set karena SegmentedButton juga bisa
              // dipakai untuk memilih lebih dari satu.
              selected: {_ukuran},
              onSelectionChanged: (Set<UkuranGelas> pilihan) {
                setState(() {
                  _ukuran = pilihan.first;
                });
              },
              // Tanpa ikon centang agar label tetap muat di layar sempit.
              // Pilihan yang aktif tetap terlihat dari warnanya.
              showSelectedIcon: false,
            ),

            // ---------- 2) Slider: pilih angka dengan menggeser ----------
            Text(
              'Tingkat manis: ${_manis.round()}%',
              style: gayaTeks.titleMedium,
            ),
            Slider(
              value: _manis,
              max: 100, // min bawaan = 0
              divisions: 4, // berhenti di 0, 25, 50, 75, 100
              label: '${_manis.round()}%', // gelembung angka saat digeser
              onChanged: (double nilaiBaru) {
                setState(() {
                  _manis = nilaiBaru;
                });
              },
            ),

            // ---------- 3) ChoiceChip: pilih SATU, berbentuk chip ----------
            Text('Suhu', style: gayaTeks.titleMedium),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Dingin'),
                  selected: _dingin,
                  // (_) = nilai yang dikirim tidak kita pakai.
                  onSelected: (_) {
                    setState(() {
                      _dingin = true;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('Hangat'),
                  selected: !_dingin,
                  onSelected: (_) {
                    setState(() {
                      _dingin = false;
                    });
                  },
                ),
              ],
            ),

            // ---------- 4) FilterChip: boleh pilih BANYAK ----------
            Text(
              'Topping (boleh lebih dari satu)',
              style: gayaTeks.titleMedium,
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (String topping in daftarTopping)
                  FilterChip(
                    label: Text(topping),
                    selected: _topping.contains(topping),
                    onSelected: (bool dipilih) {
                      setState(() {
                        if (dipilih) {
                          _topping.add(topping);
                        } else {
                          _topping.remove(topping);
                        }
                      });
                    },
                  ),
              ],
            ),

            // ---------- Ringkasan pesanan ----------
            Card.filled(
              color: warna.tertiaryContainer,
              child: ListTile(
                // Isi di atas warna X memakai warna onX.
                iconColor: warna.onTertiaryContainer,
                textColor: warna.onTertiaryContainer,
                leading: Icon(_dingin ? Icons.local_drink : Icons.coffee),
                title: Text('Teh ${_ukuran.label.toLowerCase()}'),
                subtitle: Text(
                  'Manis ${_manis.round()}%, '
                  '${_dingin ? 'dingin' : 'hangat'}, $teksTopping.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

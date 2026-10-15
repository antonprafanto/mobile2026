// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 06: DAFTAR DATA & NAVIGASI
// CONTOH 06: Mencari dan Menyaring Daftar, serta Tampilan Hasil Kosong
// Topik: Data asli TIDAK pernah diubah. Yang disimpan di State hanya
//        kata kunci dan kategori pilihan. Daftar yang tampil dihitung
//        ulang dari keduanya (nilai turunan) setiap kali build().
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiUkm());
}

enum KategoriUkm {
  olahraga('Olahraga', Icons.sports_soccer),
  seni('Seni', Icons.palette),
  keilmuan('Keilmuan', Icons.science),
  sosial('Sosial', Icons.volunteer_activism);

  const KategoriUkm(this.label, this.ikon);

  final String label;
  final IconData ikon;
}

class Ukm {
  const Ukm(this.nama, this.kategori, this.jadwal);

  final String nama;
  final KategoriUkm kategori;
  final String jadwal;
}

const List<Ukm> semuaUkm = [
  Ukm('Futsal', KategoriUkm.olahraga, 'Selasa, 16.00'),
  Ukm('Bulu Tangkis', KategoriUkm.olahraga, 'Kamis, 16.00'),
  Ukm('Paduan Suara', KategoriUkm.seni, 'Rabu, 15.30'),
  Ukm('Teater Kampus', KategoriUkm.seni, 'Jumat, 19.00'),
  Ukm('Fotografi', KategoriUkm.seni, 'Kamis, 19.00'),
  Ukm('Kelompok Studi Robotika', KategoriUkm.keilmuan, 'Sabtu, 09.00'),
  Ukm('Klub Pemrograman', KategoriUkm.keilmuan, 'Rabu, 19.00'),
  Ukm('Korps Sukarela', KategoriUkm.sosial, 'Minggu, 08.00'),
  Ukm('Pecinta Alam', KategoriUkm.sosial, 'Sabtu, 07.00'),
];

class AplikasiUkm extends StatelessWidget {
  const AplikasiUkm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HalamanDirektori(),
    );
  }
}

class HalamanDirektori extends StatefulWidget {
  const HalamanDirektori({super.key});

  @override
  State<HalamanDirektori> createState() => _HalamanDirektoriState();
}

class _HalamanDirektoriState extends State<HalamanDirektori> {
  final TextEditingController _kontrolCari = TextEditingController();
  String _kataKunci = '';
  KategoriUkm? _kategori; // null artinya "Semua"

  // Nilai turunan: dihitung dari data asli + kata kunci + kategori.
  List<Ukm> get _hasil {
    final String kunci = _kataKunci.trim().toLowerCase();
    return semuaUkm.where((Ukm ukm) {
      final bool cocokNama = ukm.nama.toLowerCase().contains(kunci);
      final bool cocokKategori = _kategori == null || ukm.kategori == _kategori;
      return cocokNama && cocokKategori;
    }).toList();
  }

  // Kalimat untuk tampilan "hasil kosong", juga nilai turunan.
  String get _keteranganKosong {
    final KategoriUkm? kategori = _kategori;
    final String bagianKategori = kategori == null
        ? ''
        : ' di kategori ${kategori.label}';
    return 'Tidak ada UKM yang cocok dengan "${_kataKunci.trim()}"'
        '$bagianKategori.';
  }

  void _aturUlang() {
    // clear() tidak memanggil onChanged, jadi _kataKunci ikut
    // dikosongkan sendiri di dalam setState.
    _kontrolCari.clear();
    setState(() {
      _kataKunci = '';
      _kategori = null;
    });
  }

  @override
  void dispose() {
    _kontrolCari.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Ukm> hasil = _hasil; // hitung sekali, pakai berkali-kali

    return Scaffold(
      appBar: AppBar(title: const Text('Direktori UKM')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------- 1) Kotak pencarian Material 3 ----------
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: SearchBar(
              controller: _kontrolCari,
              hintText: 'Cari nama UKM',
              leading: const Icon(Icons.search),
              onChanged: (String teks) {
                setState(() {
                  _kataKunci = teks;
                });
              },
            ),
          ),
          // ---------- 2) Chip kategori, bisa digeser ke samping ----------
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Semua'),
                  selected: _kategori == null,
                  onSelected: (_) {
                    setState(() {
                      _kategori = null;
                    });
                  },
                ),
                for (final KategoriUkm kategori in KategoriUkm.values)
                  ChoiceChip(
                    label: Text(kategori.label),
                    selected: _kategori == kategori,
                    onSelected: (_) {
                      setState(() {
                        _kategori = kategori;
                      });
                    },
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text('${hasil.length} UKM ditemukan'),
          ),
          // ---------- 3) Hasil: daftar atau pesan "tidak ada" ----------
          Expanded(
            child: hasil.isEmpty
                ? HasilKosong(
                    keterangan: _keteranganKosong,
                    onAturUlang: _aturUlang,
                  )
                : ListView.builder(
                    itemCount: hasil.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Ukm ukm = hasil[index];
                      return ListTile(
                        leading: Icon(ukm.kategori.ikon),
                        title: Text(ukm.nama),
                        subtitle: Text(
                          '${ukm.kategori.label} · latihan ${ukm.jadwal}',
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class HasilKosong extends StatelessWidget {
  const HasilKosong({
    super.key,
    required this.keterangan,
    required this.onAturUlang,
  });

  final String keterangan;
  final VoidCallback onAturUlang;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off, size: 64),
            const SizedBox(height: 12),
            Text(keterangan, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onAturUlang,
              icon: const Icon(Icons.refresh),
              label: const Text('Tampilkan semua'),
            ),
          ],
        ),
      ),
    );
  }
}

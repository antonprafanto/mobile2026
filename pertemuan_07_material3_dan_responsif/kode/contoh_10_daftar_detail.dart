// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 07: MATERIAL 3 & UI RESPONSIF
// CONTOH 10: Pola Daftar-Detail (Satu Panel <-> Dua Panel)
// Topik: Di jendela sempit, mengetuk pesan membuka HALAMAN detail
//        (Navigator.push). Di jendela lebar (>= 840), daftar dan detail
//        tampil BERDAMPINGAN: mengetuk pesan hanya mengganti isi panel
//        kanan. Widget DetailPesan dipakai di kedua tata letak.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome, lalu coba di jendela
//    sempit dan jendela lebar.
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiPesan());
}

class AplikasiPesan extends StatelessWidget {
  const AplikasiPesan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HalamanPesan(),
    );
  }
}

// ---------- Data ----------
class Pesan {
  const Pesan({
    required this.id,
    required this.pengirim,
    required this.subjek,
    required this.isi,
    required this.waktu,
  });

  final int id;
  final String pengirim;
  final String subjek;
  final String isi;
  final String waktu;

  String get inisial => pengirim.substring(0, 1);
}

const List<Pesan> daftarPesan = [
  Pesan(
    id: 1,
    pengirim: 'Bagian Akademik',
    subjek: 'Jadwal UTS semester ganjil',
    isi:
        'Jadwal UTS sudah terbit. Silakan periksa ruang dan jam ujian di '
        'portal akademik. Bawa kartu ujian dan kartu mahasiswa.',
    waktu: '08.15',
  ),
  Pesan(
    id: 2,
    pengirim: 'Rina Kusuma',
    subjek: 'Revisi jobsheet Pertemuan 7',
    isi:
        'Jobsheet Pertemuan 7 dikumpulkan paling lambat Jumat pukul 23.59. '
        'Jangan lupa uji tampilan di lebar 360, 700, dan 1000.',
    waktu: '07.40',
  ),
  Pesan(
    id: 3,
    pengirim: 'Perpustakaan',
    subjek: 'Pengingat pengembalian buku',
    isi:
        'Buku "Basis Data Terapan" harus dikembalikan dalam 2 hari. '
        'Perpanjangan dapat dilakukan lewat aplikasi perpustakaan.',
    waktu: 'Kemarin',
  ),
  Pesan(
    id: 4,
    pengirim: 'Himpunan Mahasiswa',
    subjek: 'Undangan rapat kerja',
    isi:
        'Rapat kerja himpunan diadakan Sabtu pukul 09.00 di ruang B.204. '
        'Konsumsi disediakan panitia.',
    waktu: 'Kemarin',
  ),
  Pesan(
    id: 5,
    pengirim: 'Bayu Pratama',
    subjek: 'Pembagian kelompok proyek',
    isi:
        'Pembagian kelompok proyek akhir sudah diunggah. Setiap kelompok '
        'terdiri dari tiga orang dan memilih satu tema aplikasi.',
    waktu: 'Senin',
  ),
];

Pesan? cariPesan(int? id) {
  for (final Pesan pesan in daftarPesan) {
    if (pesan.id == id) {
      return pesan;
    }
  }
  return null;
}

// ---------- Halaman utama: memilih satu panel atau dua panel ----------
class HalamanPesan extends StatefulWidget {
  const HalamanPesan({super.key});

  @override
  State<HalamanPesan> createState() => _HalamanPesanState();
}

class _HalamanPesanState extends State<HalamanPesan> {
  int? _idTerpilih; // hanya dipakai pada tata letak dua panel

  void _bukaHalamanDetail(Pesan pesan) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => HalamanDetailPesan(pesan: pesan),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool duaPanel = MediaQuery.widthOf(context) >= 840;

    // Jendela sempit: hanya daftar. Detail dibuka sebagai halaman baru.
    if (!duaPanel) {
      return Scaffold(
        appBar: AppBar(title: const Text('Pesan Akademik')),
        body: DaftarPesan(idTerpilih: null, onPilih: _bukaHalamanDetail),
      );
    }

    // Jendela lebar: daftar di kiri, detail di kanan.
    final Pesan? terpilih = cariPesan(_idTerpilih);
    return Scaffold(
      appBar: AppBar(title: const Text('Pesan Akademik')),
      body: Row(
        children: [
          SizedBox(
            width: 360, // panel daftar selebar layar ponsel
            child: DaftarPesan(
              idTerpilih: _idTerpilih,
              onPilih: (Pesan pesan) {
                setState(() {
                  _idTerpilih = pesan.id;
                });
              },
            ),
          ),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(
            child: terpilih == null
                ? const PanelKosong()
                : DetailPesan(pesan: terpilih),
          ),
        ],
      ),
    );
  }
}

// ---------- Bagian-bagian yang dipakai ulang ----------
class DaftarPesan extends StatelessWidget {
  const DaftarPesan({
    super.key,
    required this.idTerpilih,
    required this.onPilih,
  });

  final int? idTerpilih;
  final ValueChanged<Pesan> onPilih;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return ListView.builder(
      itemCount: daftarPesan.length,
      itemBuilder: (BuildContext context, int index) {
        final Pesan pesan = daftarPesan[index];
        return ListTile(
          // selected: baris yang sedang tampil di panel kanan ditandai.
          selected: pesan.id == idTerpilih,
          selectedTileColor: warna.secondaryContainer,
          selectedColor: warna.onSecondaryContainer,
          leading: CircleAvatar(child: Text(pesan.inisial)),
          title: Text(pesan.pengirim),
          subtitle: Text(
            pesan.subjek,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(pesan.waktu),
          onTap: () => onPilih(pesan),
        );
      },
    );
  }
}

class DetailPesan extends StatelessWidget {
  const DetailPesan({super.key, required this.pesan});

  final Pesan pesan;

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    final ColorScheme warna = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(pesan.subjek, style: gayaTeks.headlineSmall),
        const SizedBox(height: 16),
        Row(
          children: [
            CircleAvatar(child: Text(pesan.inisial)),
            const SizedBox(width: 12),
            Expanded(child: Text(pesan.pengirim, style: gayaTeks.titleMedium)),
            Text(
              pesan.waktu,
              style: gayaTeks.labelMedium?.copyWith(
                color: warna.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const Divider(height: 32),
        Text(pesan.isi, style: gayaTeks.bodyLarge),
      ],
    );
  }
}

class HalamanDetailPesan extends StatelessWidget {
  const HalamanDetailPesan({super.key, required this.pesan});

  final Pesan pesan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pesan')),
      body: DetailPesan(pesan: pesan), // widget yang SAMA dengan panel kanan
    );
  }
}

class PanelKosong extends StatelessWidget {
  const PanelKosong({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.mark_email_unread, size: 64, color: warna.outline),
          const SizedBox(height: 12),
          Text(
            'Pilih pesan di sebelah kiri.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

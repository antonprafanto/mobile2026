// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 09: MANAJEMEN STATE & MVVM
// CONTOH 07: Pola MVVM (Model - View - ViewModel)
// Topik: Kode dibagi menjadi tiga peran:
//        - MODEL     : bentuk datanya (class Tugas, enum Prioritas).
//        - VIEWMODEL : state halaman dan SEMUA logikanya: mencari,
//                      menyaring, menghitung, menambah, mengubah status.
//        - VIEW      : widget yang hanya MENAMPILKAN isi ViewModel dan
//                      meneruskan ketukan pengguna ke ViewModel.
//        View tidak mengubah data tugas sendiri. State yang tetap tinggal
//        di View hanya isi formulir (kolom teks dan pilihan prioritas),
//        karena hanya dipakai oleh formulir itu.
// =====================================================================
// CARA MENJALANKAN:
// 1. Proyek Flutter: jalankan `flutter pub add provider` sekali.
//    (DartPad sudah menyediakan paket provider.)
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => DaftarTugasViewModel(),
      child: const AplikasiTugas(),
    ),
  );
}

// =========================== MODEL ===========================

enum Prioritas {
  rendah('Rendah'),
  sedang('Sedang'),
  tinggi('Tinggi');

  const Prioritas(this.label);

  final String label;
}

class Tugas {
  const Tugas({
    required this.id,
    required this.judul,
    required this.mataKuliah,
    required this.prioritas,
  });

  final int id;
  final String judul;
  final String mataKuliah;
  final Prioritas prioritas;
}

// ========================= VIEWMODEL =========================

class DaftarTugasViewModel extends ChangeNotifier {
  final List<Tugas> _semua = [
    const Tugas(
      id: 1,
      judul: 'Laporan praktikum MVVM',
      mataKuliah: 'Piranti Bergerak',
      prioritas: Prioritas.tinggi,
    ),
    const Tugas(
      id: 2,
      judul: 'Rancangan ERD perpustakaan',
      mataKuliah: 'Basis Data',
      prioritas: Prioritas.sedang,
    ),
    const Tugas(
      id: 3,
      judul: 'Ringkasan bab 4',
      mataKuliah: 'Etika Profesi',
      prioritas: Prioritas.rendah,
    ),
    const Tugas(
      id: 4,
      judul: 'Kuis algoritma graf',
      mataKuliah: 'Struktur Data',
      prioritas: Prioritas.tinggi,
    ),
  ];
  final Set<int> _selesai = {3};
  String _kataKunci = '';
  Prioritas? _saringan; // null = semua prioritas

  // ---------- Dibaca View ----------
  Prioritas? get saringan => _saringan;
  int get jumlahBelumSelesai => _semua.length - _selesai.length;

  List<Tugas> get tampil {
    final String kunci = _kataKunci.trim().toLowerCase();
    return _semua.where((Tugas tugas) {
      final bool cocokJudul = tugas.judul.toLowerCase().contains(kunci);
      final bool cocokPrioritas =
          _saringan == null || tugas.prioritas == _saringan;
      return cocokJudul && cocokPrioritas;
    }).toList();
  }

  bool sudahSelesai(Tugas tugas) => _selesai.contains(tugas.id);

  // ---------- Perintah yang dipanggil View ----------
  void cari(String teks) {
    _kataKunci = teks;
    notifyListeners();
  }

  void pilihSaringan(Prioritas? prioritas) {
    _saringan = prioritas;
    notifyListeners();
  }

  void ubahStatus(Tugas tugas) {
    if (_selesai.contains(tugas.id)) {
      _selesai.remove(tugas.id);
    } else {
      _selesai.add(tugas.id);
    }
    notifyListeners();
  }

  void tambah(String judul, String mataKuliah, Prioritas prioritas) {
    int idTerbesar = 0;
    for (final Tugas tugas in _semua) {
      if (tugas.id > idTerbesar) {
        idTerbesar = tugas.id;
      }
    }
    _semua.add(
      Tugas(
        id: idTerbesar + 1,
        judul: judul.trim(),
        mataKuliah: mataKuliah.trim(),
        prioritas: prioritas,
      ),
    );
    notifyListeners();
  }
}

// ============================ VIEW ============================

class AplikasiTugas extends StatelessWidget {
  const AplikasiTugas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Kuliahku',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HalamanTugas(),
    );
  }
}

class HalamanTugas extends StatelessWidget {
  const HalamanTugas({super.key});

  Future<void> _bukaFormulir(BuildContext context) async {
    final bool? tersimpan = await Navigator.push<bool>(
      context,
      MaterialPageRoute<bool>(
        builder: (BuildContext context) => const HalamanTambahTugas(),
      ),
    );
    if (!context.mounted) return;
    if (tersimpan == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Tugas ditambahkan.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // View hanya MEMBACA dari ViewModel...
    final DaftarTugasViewModel vm = context.watch<DaftarTugasViewModel>();
    final List<Tugas> tampil = vm.tampil;

    return Scaffold(
      appBar: AppBar(title: const Text('Tugas Kuliahku')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: SearchBar(
              hintText: 'Cari judul tugas',
              leading: const Icon(Icons.search),
              // ...dan meneruskan kejadian ke ViewModel.
              onChanged: (String teks) {
                context.read<DaftarTugasViewModel>().cari(teks);
              },
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Semua'),
                  selected: vm.saringan == null,
                  onSelected: (_) {
                    context.read<DaftarTugasViewModel>().pilihSaringan(null);
                  },
                ),
                for (final Prioritas prioritas in Prioritas.values)
                  ChoiceChip(
                    label: Text(prioritas.label),
                    selected: vm.saringan == prioritas,
                    onSelected: (_) {
                      context.read<DaftarTugasViewModel>().pilihSaringan(
                        prioritas,
                      );
                    },
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('${vm.jumlahBelumSelesai} tugas belum selesai'),
            ),
          ),
          Expanded(
            child: tampil.isEmpty
                ? const Center(child: Text('Tidak ada tugas yang cocok.'))
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 88),
                    itemCount: tampil.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Tugas tugas = tampil[index];
                      return BarisTugas(
                        tugas: tugas,
                        selesai: vm.sudahSelesai(tugas),
                        onUbah: () {
                          context.read<DaftarTugasViewModel>().ubahStatus(
                            tugas,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _bukaFormulir(context),
        icon: const Icon(Icons.add),
        label: const Text('Tambah tugas'),
      ),
    );
  }
}

class BarisTugas extends StatelessWidget {
  const BarisTugas({
    super.key,
    required this.tugas,
    required this.selesai,
    required this.onUbah,
  });

  final Tugas tugas;
  final bool selesai;
  final VoidCallback onUbah;

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return CheckboxListTile(
      value: selesai,
      onChanged: (_) => onUbah(),
      title: Text(
        tugas.judul,
        style: selesai
            ? gayaTeks.bodyLarge?.copyWith(
                decoration: TextDecoration.lineThrough,
              )
            : gayaTeks.bodyLarge,
      ),
      subtitle: Text('${tugas.mataKuliah} · ${tugas.prioritas.label}'),
    );
  }
}

class HalamanTambahTugas extends StatefulWidget {
  const HalamanTambahTugas({super.key});

  @override
  State<HalamanTambahTugas> createState() => _HalamanTambahTugasState();
}

class _HalamanTambahTugasState extends State<HalamanTambahTugas> {
  // State LOKAL formulir: hanya dipakai halaman ini.
  final GlobalKey<FormState> _kunciForm = GlobalKey<FormState>();
  final TextEditingController _kontrolJudul = TextEditingController();
  final TextEditingController _kontrolMatkul = TextEditingController();
  Prioritas _prioritas = Prioritas.sedang;

  @override
  void dispose() {
    _kontrolJudul.dispose();
    _kontrolMatkul.dispose();
    super.dispose();
  }

  String? _wajibDiisi(String? isi) {
    if ((isi ?? '').trim().isEmpty) {
      return 'Wajib diisi';
    }
    return null;
  }

  void _simpan() {
    if (!_kunciForm.currentState!.validate()) {
      return;
    }
    // Data aplikasi diubah lewat ViewModel, bukan disimpan di halaman ini.
    context.read<DaftarTugasViewModel>().tambah(
      _kontrolJudul.text,
      _kontrolMatkul.text,
      _prioritas,
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Tugas')),
      body: Form(
        key: _kunciForm,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _kontrolJudul,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Judul tugas',
                border: OutlineInputBorder(),
              ),
              validator: _wajibDiisi,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _kontrolMatkul,
              decoration: const InputDecoration(
                labelText: 'Mata kuliah',
                border: OutlineInputBorder(),
              ),
              validator: _wajibDiisi,
            ),
            const SizedBox(height: 16),
            SegmentedButton<Prioritas>(
              segments: [
                for (final Prioritas prioritas in Prioritas.values)
                  ButtonSegment(value: prioritas, label: Text(prioritas.label)),
              ],
              selected: {_prioritas},
              onSelectionChanged: (Set<Prioritas> pilihan) {
                setState(() {
                  _prioritas = pilihan.first;
                });
              },
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _simpan,
              icon: const Icon(Icons.save),
              label: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

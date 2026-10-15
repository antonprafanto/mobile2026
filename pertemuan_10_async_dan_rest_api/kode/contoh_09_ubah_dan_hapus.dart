// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 10: ASINKRON & REST API
// CONTOH 09: Mengubah (PATCH) dan Menghapus (DELETE) Data di Server
// Topik: Lima tugas diambil dari https://dummyjson.com/todos.
//        - Mencentang tugas mengirim PATCH /todos/{id} berisi
//          {"completed": true/false}: hanya kolom yang berubah.
//        - Ikon tempat sampah mengirim DELETE /todos/{id}.
//        Tampilan baru diubah SETELAH server menjawab berhasil. Selama
//        menunggu, baris itu menampilkan lingkaran kecil dan tidak bisa
//        diketuk lagi. Jika gagal, tampil SnackBar dan data tidak berubah.
//        Catatan: DummyJSON hanya MENSIMULASIKAN perubahan. Tekan muat
//        ulang dan data kembali seperti semula.
// =====================================================================
// CARA MENJALANKAN:
// 1. Proyek Flutter: jalankan `flutter pub add http` sekali.
//    (DartPad sudah menyediakan paket http.)
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
// 3. Jalankan di terminal: flutter run -d chrome
//    Butuh koneksi internet.
// =====================================================================

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const AplikasiUbahHapus());
}

class Tugas {
  const Tugas({required this.id, required this.judul, required this.selesai});

  final int id;
  final String judul;
  final bool selesai;

  // Model immutable: perubahan = objek baru (Pertemuan 9).
  Tugas salinDengan({bool? selesai}) =>
      Tugas(id: id, judul: judul, selesai: selesai ?? this.selesai);
}

class ApiException implements Exception {
  const ApiException(this.kodeStatus);

  final int kodeStatus;

  @override
  String toString() => 'ApiException: kode status $kodeStatus';
}

// Semua permintaan ke server dikumpulkan di satu class.
class LayananTugas {
  static const String _host = 'dummyjson.com';
  static const Map<String, String> _header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Map<String, dynamic> _baca(http.Response respons) {
    if (respons.statusCode < 200 || respons.statusCode >= 300) {
      throw ApiException(respons.statusCode);
    }
    return jsonDecode(respons.body) as Map<String, dynamic>;
  }

  Future<List<Tugas>> ambil() async {
    final http.Response respons = await http.get(
      Uri.https(_host, '/todos', {'limit': '5'}),
      headers: _header,
    );
    final List<dynamic> isi = _baca(respons)['todos'] as List<dynamic>;
    return [
      for (final dynamic item in isi)
        Tugas(
          id: item['id'] as int,
          judul: item['todo'] as String,
          selesai: item['completed'] as bool,
        ),
    ];
  }

  // PATCH: kirim HANYA kolom yang berubah.
  Future<void> ubahStatus(int id, bool selesai) async {
    final http.Response respons = await http.patch(
      Uri.https(_host, '/todos/$id'),
      headers: _header,
      body: jsonEncode({'completed': selesai}),
    );
    _baca(respons);
  }

  // DELETE: server menjawab dengan data yang dihapus + isDeleted.
  Future<void> hapus(int id) async {
    final http.Response respons = await http.delete(
      Uri.https(_host, '/todos/$id'),
      headers: _header,
    );
    final Map<String, dynamic> json = _baca(respons);
    if (json['isDeleted'] != true) {
      throw const FormatException('Server tidak mengonfirmasi penghapusan');
    }
  }
}

class AplikasiUbahHapus extends StatelessWidget {
  const AplikasiUbahHapus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ubah dan Hapus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      home: const HalamanTugas(),
    );
  }
}

class HalamanTugas extends StatefulWidget {
  const HalamanTugas({super.key});

  @override
  State<HalamanTugas> createState() => _HalamanTugasState();
}

class _HalamanTugasState extends State<HalamanTugas> {
  final LayananTugas _layanan = LayananTugas();
  List<Tugas> _daftar = [];
  bool _memuat = true;
  String? _galat;
  final Set<int> _diproses = {}; // id tugas yang sedang menunggu server

  @override
  void initState() {
    super.initState();
    _muat();
  }

  Future<void> _muat() async {
    setState(() {
      _memuat = true;
      _galat = null;
    });
    try {
      final List<Tugas> daftar = await _layanan.ambil();
      if (!mounted) return;
      setState(() => _daftar = daftar);
    } catch (galat) {
      debugPrint('Galat saat memuat: $galat');
      if (!mounted) return;
      setState(() => _galat = 'Tugas gagal dimuat.');
    } finally {
      if (mounted) {
        setState(() => _memuat = false);
      }
    }
  }

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(pesan)));
  }

  Future<void> _ubah(Tugas tugas, bool selesai) async {
    setState(() => _diproses.add(tugas.id));
    try {
      await _layanan.ubahStatus(tugas.id, selesai);
      if (!mounted) return;
      // Server sudah setuju: baru sekarang tampilan diubah.
      setState(() {
        _daftar = [
          for (final Tugas t in _daftar)
            t.id == tugas.id ? t.salinDengan(selesai: selesai) : t,
        ];
      });
      _tampilkanPesan('Status tugas #${tugas.id} diperbarui.');
    } catch (galat) {
      debugPrint('Galat saat mengubah: $galat');
      if (!mounted) return;
      _tampilkanPesan('Gagal mengubah tugas #${tugas.id}.');
    } finally {
      if (mounted) {
        setState(() => _diproses.remove(tugas.id));
      }
    }
  }

  Future<void> _hapus(Tugas tugas) async {
    setState(() => _diproses.add(tugas.id));
    try {
      await _layanan.hapus(tugas.id);
      if (!mounted) return;
      setState(() {
        _daftar = _daftar.where((Tugas t) => t.id != tugas.id).toList();
      });
      _tampilkanPesan('Tugas #${tugas.id} dihapus.');
    } catch (galat) {
      debugPrint('Galat saat menghapus: $galat');
      if (!mounted) return;
      _tampilkanPesan('Gagal menghapus tugas #${tugas.id}.');
    } finally {
      if (mounted) {
        setState(() => _diproses.remove(tugas.id));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget isi;
    if (_memuat) {
      isi = const Center(child: CircularProgressIndicator());
    } else if (_galat != null) {
      isi = Center(child: Text(_galat!));
    } else if (_daftar.isEmpty) {
      isi = const Center(child: Text('Semua tugas sudah dihapus.'));
    } else {
      isi = ListView(
        children: [
          for (final Tugas tugas in _daftar)
            _BarisTugas(
              tugas: tugas,
              diproses: _diproses.contains(tugas.id),
              onUbah: (bool selesai) => _ubah(tugas, selesai),
              onHapus: () => _hapus(tugas),
            ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah dan Hapus'),
        actions: [
          IconButton(
            onPressed: _memuat ? null : _muat,
            tooltip: 'Muat ulang',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: isi,
    );
  }
}

class _BarisTugas extends StatelessWidget {
  const _BarisTugas({
    required this.tugas,
    required this.diproses,
    required this.onUbah,
    required this.onHapus,
  });

  final Tugas tugas;
  final bool diproses;
  final ValueChanged<bool> onUbah;
  final VoidCallback onHapus;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: tugas.selesai,
      // Selama menunggu server, baris ini tidak bisa diubah lagi.
      onChanged: diproses ? null : (bool? nilai) => onUbah(nilai ?? false),
      title: Text(tugas.judul),
      subtitle: Text('Tugas #${tugas.id}'),
      controlAffinity: ListTileControlAffinity.leading,
      secondary: diproses
          ? const SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : IconButton(
              onPressed: onHapus,
              tooltip: 'Hapus',
              icon: const Icon(Icons.delete_outline),
            ),
    );
  }
}

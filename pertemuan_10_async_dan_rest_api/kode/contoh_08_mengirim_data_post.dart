// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 10: ASINKRON & REST API
// CONTOH 08: Mengirim Data ke Server dengan POST
// Topik: Formulir "Tambah Tugas" mengirim data ke
//        https://dummyjson.com/todos/add dengan metode POST:
//        - data diubah menjadi teks JSON dengan jsonEncode();
//        - header Content-Type: application/json memberi tahu server
//          bahwa isi permintaan berupa JSON;
//        - kode 200-299 berarti berhasil (201 = Created, data dibuat).
//        Layar menampilkan apa yang DIKIRIM dan apa yang DITERIMA.
//        Catatan: DummyJSON hanya MENSIMULASIKAN penyimpanan. Datanya
//        tidak benar-benar disimpan di server.
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
  runApp(const AplikasiKirim());
}

class ApiException implements Exception {
  const ApiException(this.kodeStatus);

  final int kodeStatus;

  @override
  String toString() => 'ApiException: kode status $kodeStatus';
}

// Hasil pengiriman: yang dikirim, kode status, dan jawaban server.
class HasilKirim {
  const HasilKirim({
    required this.dikirim,
    required this.kodeStatus,
    required this.diterima,
  });

  final String dikirim;
  final int kodeStatus;
  final Map<String, dynamic> diterima;
}

Future<HasilKirim> kirimTugas({
  required String judul,
  required bool selesai,
}) async {
  // 1. Data -> teks JSON.
  final String body = jsonEncode({
    'todo': judul,
    'completed': selesai,
    'userId': 1,
  });

  // 2. Kirim dengan POST, lengkap dengan header Content-Type.
  final http.Response respons = await http
      .post(
        Uri.parse('https://dummyjson.com/todos/add'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      )
      .timeout(const Duration(seconds: 10));

  // 3. Semua kode 2xx dianggap berhasil.
  if (respons.statusCode < 200 || respons.statusCode >= 300) {
    throw ApiException(respons.statusCode);
  }
  return HasilKirim(
    dikirim: body,
    kodeStatus: respons.statusCode,
    diterima: jsonDecode(respons.body) as Map<String, dynamic>,
  );
}

class AplikasiKirim extends StatelessWidget {
  const AplikasiKirim({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tambah Tugas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      home: const HalamanTambah(),
    );
  }
}

class HalamanTambah extends StatefulWidget {
  const HalamanTambah({super.key});

  @override
  State<HalamanTambah> createState() => _HalamanTambahState();
}

class _HalamanTambahState extends State<HalamanTambah> {
  final GlobalKey<FormState> _kunciForm = GlobalKey<FormState>();
  final TextEditingController _kontrolJudul = TextEditingController();
  bool _selesai = false;
  bool _mengirim = false;
  HasilKirim? _hasil;

  @override
  void dispose() {
    _kontrolJudul.dispose();
    super.dispose();
  }

  String? _cekJudul(String? isi) {
    final String teks = (isi ?? '').trim();
    if (teks.isEmpty) return 'Judul tugas wajib diisi';
    if (teks.length < 3) return 'Minimal 3 huruf';
    return null;
  }

  Future<void> _kirim() async {
    if (!_kunciForm.currentState!.validate()) return;
    FocusScope.of(context).unfocus(); // tutup keyboard

    setState(() => _mengirim = true);
    try {
      final HasilKirim hasil = await kirimTugas(
        judul: _kontrolJudul.text.trim(),
        selesai: _selesai,
      );
      if (!mounted) return;
      setState(() => _hasil = hasil);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Tugas terkirim. Server memberi id ${hasil.diterima['id']}.',
          ),
        ),
      );
    } catch (galat) {
      debugPrint('Galat saat mengirim: $galat');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengirim. Coba lagi.')),
      );
    } finally {
      if (mounted) {
        setState(() => _mengirim = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    // JsonEncoder dengan indentasi: JSON yang mudah dibaca manusia.
    const JsonEncoder rapi = JsonEncoder.withIndent('  ');

    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Tugas')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Form(
            key: _kunciForm,
            child: Column(
              children: [
                TextFormField(
                  controller: _kontrolJudul,
                  decoration: const InputDecoration(
                    labelText: 'Judul tugas',
                    border: OutlineInputBorder(),
                  ),
                  validator: _cekJudul,
                  enabled: !_mengirim,
                ),
                SwitchListTile(
                  title: const Text('Sudah selesai'),
                  value: _selesai,
                  onChanged: _mengirim
                      ? null
                      : (bool nilai) => setState(() => _selesai = nilai),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _mengirim ? null : _kirim,
                    icon: _mengirim
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send),
                    label: Text(_mengirim ? 'Mengirim...' : 'Kirim'),
                  ),
                ),
              ],
            ),
          ),
          if (_hasil != null) ...[
            const SizedBox(height: 24),
            Text('Yang dikirim (body permintaan):', style: gayaTeks.titleSmall),
            const SizedBox(height: 4),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(_hasil!.dikirim),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Yang diterima (kode ${_hasil!.kodeStatus}):',
              style: gayaTeks.titleSmall,
            ),
            const SizedBox(height: 4),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(rapi.convert(_hasil!.diterima)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

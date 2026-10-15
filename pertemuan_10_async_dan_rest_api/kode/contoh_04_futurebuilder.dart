// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 10: ASINKRON & REST API
// CONTOH 04: FutureBuilder dan Jebakannya
// Topik: FutureBuilder menampilkan tiga keadaan sebuah Future: masih
//        menunggu, gagal, atau berhasil. Data tugas diambil dari
//        https://dummyjson.com/todos.
//        JEBAKAN: Future harus dibuat SEKALI (di initState), bukan di
//        dalam build(). Nyalakan sakelar "Future dibuat di build()",
//        lalu tekan "Bangun ulang layar": setiap kali layar dibangun
//        ulang, permintaan baru dikirim dan lingkaran memuat muncul lagi.
//        Perhatikan angka "Permintaan terkirim" di atas daftar.
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
  runApp(const AplikasiTugas());
}

// ============================ MODEL ============================

class Tugas {
  const Tugas({required this.id, required this.judul, required this.selesai});

  factory Tugas.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'todo': String judul, 'completed': bool selesai} => Tugas(
        id: id,
        judul: judul,
        selesai: selesai,
      ),
      _ => throw const FormatException('Bentuk data tugas tidak sesuai'),
    };
  }

  final int id;
  final String judul;
  final bool selesai;
}

// Fungsi pengambil data: mengembalikan Future yang kelak berisi daftar.
Future<List<Tugas>> ambilTugas() async {
  final http.Response respons = await http.get(
    Uri.parse('https://dummyjson.com/todos?limit=10&delay=1000'),
    headers: {'Accept': 'application/json'},
  );
  if (respons.statusCode != 200) {
    throw Exception('Kode status ${respons.statusCode}');
  }
  final Map<String, dynamic> json =
      jsonDecode(respons.body) as Map<String, dynamic>;
  final List<dynamic> isi = json['todos'] as List<dynamic>;
  return isi
      .map((dynamic item) => Tugas.fromJson(item as Map<String, dynamic>))
      .toList();
}

// ============================ VIEW ============================

class AplikasiTugas extends StatelessWidget {
  const AplikasiTugas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas dari Internet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
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
  late Future<List<Tugas>> _tugas;
  int _jumlahPermintaan = 0;
  bool _dibuatDiBuild = false; // true = cara SALAH (untuk percobaan)
  int _jumlahBangunUlang = 0;

  Future<List<Tugas>> _kirimPermintaan() {
    _jumlahPermintaan++;
    debugPrint('Permintaan ke-$_jumlahPermintaan dikirim');
    return ambilTugas();
  }

  @override
  void initState() {
    super.initState();
    // BENAR: Future dibuat sekali, disimpan, lalu dipakai berulang kali.
    _tugas = _kirimPermintaan();
  }

  void _muatUlang() {
    // Meminta data baru = mengganti Future yang disimpan.
    setState(() {
      _tugas = _kirimPermintaan();
    });
  }

  @override
  Widget build(BuildContext context) {
    // SALAH: Future baru dibuat SETIAP KALI build() dijalankan.
    final Future<List<Tugas>> future = _dibuatDiBuild
        ? _kirimPermintaan()
        : _tugas;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas dari Internet'),
        actions: [
          IconButton(
            onPressed: _muatUlang,
            tooltip: 'Muat ulang',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Future dibuat di build() (cara salah)'),
            value: _dibuatDiBuild,
            onChanged: (bool nilai) => setState(() => _dibuatDiBuild = nilai),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Permintaan terkirim: $_jumlahPermintaan\n'
                    'Layar dibangun ulang: $_jumlahBangunUlang kali',
                  ),
                ),
                OutlinedButton(
                  onPressed: () => setState(() => _jumlahBangunUlang++),
                  child: const Text('Bangun ulang layar'),
                ),
              ],
            ),
          ),
          const Divider(height: 24),
          Expanded(
            child: FutureBuilder<List<Tugas>>(
              future: future,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Tugas>> snapshot) {
                    // 1. Masih menunggu jawaban.
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    // 2. Future selesai dengan error.
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Gagal memuat: ${snapshot.error}'),
                      );
                    }
                    // 3. Future selesai dengan data.
                    final List<Tugas> daftar = snapshot.data!;
                    return ListView.builder(
                      itemCount: daftar.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Tugas tugas = daftar[index];
                        return ListTile(
                          leading: Icon(
                            tugas.selesai
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                          ),
                          title: Text(tugas.judul),
                          subtitle: Text('Tugas #${tugas.id}'),
                        );
                      },
                    );
                  },
            ),
          ),
        ],
      ),
    );
  }
}

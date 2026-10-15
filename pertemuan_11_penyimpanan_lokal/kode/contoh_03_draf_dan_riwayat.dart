// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 11: PENYIMPANAN LOKAL
// CONTOH 03: Draf Otomatis dan Riwayat (objek sebagai JSON, List<String>)
// Topik: Formulir surat izin kuliah yang drafnya tersimpan sendiri.
//        - Objek (DrafIzin) tidak bisa disimpan langsung ke
//          shared_preferences. Objek diubah dulu menjadi teks JSON dengan
//          jsonEncode (Pertemuan 10), lalu disimpan sebagai String.
//          Saat dibaca, teks itu diubah kembali dengan jsonDecode.
//        - Penyimpanan ditunda 600 ms setelah pengguna berhenti mengetik
//          (debounce, Pertemuan 10), agar tidak menulis setiap huruf.
//        - Riwayat 5 surat terakhir disimpan sebagai List<String>.
//        Coba isi sebagian formulir, lalu hot restart (tekan R): isinya
//        kembali seperti semula.
// =====================================================================
// CARA MENJALANKAN:
// 1. Proyek Flutter: jalankan `flutter pub add shared_preferences` sekali.
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
// 3. Jalankan di terminal: flutter run -d chrome --web-port=8080
// =====================================================================

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const AplikasiIzin());
}

// ============================ MODEL ============================

enum JenisIzin {
  sakit('Sakit'),
  keluarga('Keperluan keluarga'),
  kegiatan('Kegiatan kampus');

  const JenisIzin(this.label);

  final String label;
}

class DrafIzin {
  const DrafIzin({
    required this.mataKuliah,
    required this.jenis,
    required this.alasan,
  });

  final String mataKuliah;
  final JenisIzin jenis;
  final String alasan;

  bool get kosong => mataKuliah.trim().isEmpty && alasan.trim().isEmpty;

  // Objek -> Map (siap diubah menjadi teks JSON).
  Map<String, Object?> keJson() {
    return {'mata_kuliah': mataKuliah, 'jenis': jenis.name, 'alasan': alasan};
  }

  // Map hasil jsonDecode -> objek. Bentuk yang tidak sesuai ditolak.
  factory DrafIzin.dariJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'mata_kuliah': final String mataKuliah,
        'jenis': final String jenis,
        'alasan': final String alasan,
      } =>
        DrafIzin(
          mataKuliah: mataKuliah,
          jenis: JenisIzin.values.asNameMap()[jenis] ?? JenisIzin.sakit,
          alasan: alasan,
        ),
      _ => throw const FormatException('Bentuk draf tidak sesuai'),
    };
  }
}

// ======================== PENYIMPANAN ========================
// Satu-satunya class yang tahu nama kunci dan cara menyimpannya.

class PenyimpananIzin {
  static const String _kunciDraf = 'draf_izin';
  static const String _kunciRiwayat = 'riwayat_izin';
  static const int batasRiwayat = 5;

  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  Future<DrafIzin?> bacaDraf() async {
    final String? teks = await _prefs.getString(_kunciDraf);
    if (teks == null) {
      return null; // belum ada draf
    }
    try {
      return switch (jsonDecode(teks)) {
        final Map<String, dynamic> json => DrafIzin.dariJson(json),
        _ => null,
      };
    } on FormatException catch (galat) {
      // Teks tersimpan rusak atau bentuknya lama: buang saja.
      debugPrint('Draf rusak, dihapus: $galat');
      await _prefs.remove(_kunciDraf);
      return null;
    }
  }

  Future<void> simpanDraf(DrafIzin draf) async {
    if (draf.kosong) {
      await _prefs.remove(_kunciDraf); // draf kosong tidak perlu disimpan
      return;
    }
    final String teks = jsonEncode(draf.keJson());
    debugPrint('Menyimpan draf: $teks');
    await _prefs.setString(_kunciDraf, teks);
  }

  Future<void> hapusDraf() => _prefs.remove(_kunciDraf);

  Future<List<String>> bacaRiwayat() async {
    return await _prefs.getStringList(_kunciRiwayat) ?? [];
  }

  // Entri terbaru di depan; hanya 5 entri yang disimpan.
  Future<List<String>> tambahRiwayat(String entri) async {
    final List<String> lama = await bacaRiwayat();
    final List<String> baru = [entri, ...lama].take(batasRiwayat).toList();
    await _prefs.setStringList(_kunciRiwayat, baru);
    return baru;
  }

  Future<void> hapusRiwayat() => _prefs.remove(_kunciRiwayat);
}

// ============================ VIEW ============================

class AplikasiIzin extends StatelessWidget {
  const AplikasiIzin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Surat Izin Kuliah',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const HalamanIzin(),
    );
  }
}

class HalamanIzin extends StatefulWidget {
  const HalamanIzin({super.key});

  @override
  State<HalamanIzin> createState() => _HalamanIzinState();
}

class _HalamanIzinState extends State<HalamanIzin> {
  final PenyimpananIzin _penyimpanan = PenyimpananIzin();
  final GlobalKey<FormState> _kunciForm = GlobalKey<FormState>();
  final TextEditingController _kontrolMatkul = TextEditingController();
  final TextEditingController _kontrolAlasan = TextEditingController();

  JenisIzin _jenis = JenisIzin.sakit;
  List<String> _riwayat = [];
  bool _memuat = true;
  DateTime? _terakhirDisimpan;
  Timer? _penunda;

  @override
  void initState() {
    super.initState();
    _muat();
  }

  Future<void> _muat() async {
    final DrafIzin? draf = await _penyimpanan.bacaDraf();
    final List<String> riwayat = await _penyimpanan.bacaRiwayat();
    if (!mounted) {
      return;
    }
    setState(() {
      if (draf != null) {
        _kontrolMatkul.text = draf.mataKuliah;
        _kontrolAlasan.text = draf.alasan;
        _jenis = draf.jenis;
      }
      _riwayat = riwayat;
      _memuat = false;
    });
    // Pendengar dipasang SETELAH isi draf dipulihkan, agar pemulihan itu
    // sendiri tidak dianggap sebagai ketikan baru.
    _kontrolMatkul.addListener(_jadwalkanSimpan);
    _kontrolAlasan.addListener(_jadwalkanSimpan);
    if (draf != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Draf terakhir dipulihkan.')),
      );
    }
  }

  DrafIzin _drafSekarang() {
    return DrafIzin(
      mataKuliah: _kontrolMatkul.text,
      jenis: _jenis,
      alasan: _kontrolAlasan.text,
    );
  }

  // Debounce: setiap ketikan membatalkan jadwal sebelumnya. Penyimpanan
  // baru terjadi 600 ms setelah pengguna berhenti mengetik.
  void _jadwalkanSimpan() {
    _penunda?.cancel();
    _penunda = Timer(const Duration(milliseconds: 600), _simpanSekarang);
  }

  Future<void> _simpanSekarang() async {
    await _penyimpanan.simpanDraf(_drafSekarang());
    if (!mounted) {
      return;
    }
    setState(() {
      _terakhirDisimpan = DateTime.now();
    });
  }

  void _pilihJenis(JenisIzin jenis) {
    setState(() {
      _jenis = jenis;
    });
    _jadwalkanSimpan();
  }

  Future<void> _kirim() async {
    if (!_kunciForm.currentState!.validate()) {
      return;
    }
    _penunda?.cancel();
    final DateTime sekarang = DateTime.now();
    // Di aplikasi sungguhan, di sinilah surat dikirim ke server.
    final String entri =
        '${duaDigit(sekarang.day)}/${duaDigit(sekarang.month)} '
        '${duaDigit(sekarang.hour)}.${duaDigit(sekarang.minute)} · '
        '${_kontrolMatkul.text.trim()} · ${_jenis.label}';
    final List<String> riwayat = await _penyimpanan.tambahRiwayat(entri);
    await _penyimpanan.hapusDraf();
    if (!mounted) {
      return;
    }
    // Kosongkan formulir tanpa memicu penyimpanan draf.
    _kontrolMatkul.removeListener(_jadwalkanSimpan);
    _kontrolAlasan.removeListener(_jadwalkanSimpan);
    _kontrolMatkul.clear();
    _kontrolAlasan.clear();
    _kontrolMatkul.addListener(_jadwalkanSimpan);
    _kontrolAlasan.addListener(_jadwalkanSimpan);
    setState(() {
      _jenis = JenisIzin.sakit;
      _riwayat = riwayat;
      _terakhirDisimpan = null;
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Surat izin terkirim.')));
  }

  Future<void> _hapusRiwayat() async {
    await _penyimpanan.hapusRiwayat();
    if (!mounted) {
      return;
    }
    setState(() {
      _riwayat = [];
    });
  }

  @override
  void dispose() {
    // Masih ada ketikan yang belum sempat disimpan? Simpan sekarang.
    if (_penunda?.isActive ?? false) {
      _penunda!.cancel();
      unawaited(_penyimpanan.simpanDraf(_drafSekarang()));
    }
    _kontrolMatkul.dispose();
    _kontrolAlasan.dispose();
    super.dispose();
  }

  String? _wajibDiisi(String? isi) {
    if ((isi ?? '').trim().isEmpty) {
      return 'Wajib diisi';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    final DateTime? disimpan = _terakhirDisimpan;

    if (_memuat) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Surat Izin Kuliah')),
      body: Form(
        key: _kunciForm,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Icon(
                  disimpan == null ? Icons.edit_note : Icons.cloud_done,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    disimpan == null
                        ? 'Draf akan tersimpan otomatis.'
                        : 'Draf tersimpan pukul ${duaDigit(disimpan.hour)}.'
                              '${duaDigit(disimpan.minute)}.'
                              '${duaDigit(disimpan.second)}',
                    style: gayaTeks.bodySmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _kontrolMatkul,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Mata kuliah',
                border: OutlineInputBorder(),
              ),
              validator: _wajibDiisi,
            ),
            const SizedBox(height: 16),
            Text('Jenis izin', style: gayaTeks.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final JenisIzin jenis in JenisIzin.values)
                  ChoiceChip(
                    label: Text(jenis.label),
                    selected: _jenis == jenis,
                    onSelected: (_) => _pilihJenis(jenis),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _kontrolAlasan,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Alasan',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              validator: _wajibDiisi,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _kirim,
              icon: const Icon(Icons.send),
              label: const Text('Kirim'),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Riwayat (${PenyimpananIzin.batasRiwayat} terakhir)',
                    style: gayaTeks.titleMedium,
                  ),
                ),
                TextButton(
                  onPressed: _riwayat.isEmpty ? null : _hapusRiwayat,
                  child: const Text('Hapus'),
                ),
              ],
            ),
            if (_riwayat.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('Belum ada surat yang dikirim.'),
              ),
            for (final String entri in _riwayat)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.mark_email_read_outlined),
                title: Text(entri),
              ),
          ],
        ),
      ),
    );
  }
}

String duaDigit(int angka) => angka.toString().padLeft(2, '0');

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 06: DAFTAR DATA & NAVIGASI
// CONTOH 10: PopScope, Menahan Tombol Kembali
// Topik: Jika catatan sudah diketik tetapi belum disimpan, tombol
//        kembali ditahan (canPop: false) lalu muncul dialog konfirmasi.
//        Catatan yang disimpan dikirim balik ke halaman pertama.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiCatatan());
}

class AplikasiCatatan extends StatelessWidget {
  const AplikasiCatatan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: const HalamanDaftarCatatan(),
    );
  }
}

// ---------- Halaman 1: daftar catatan ----------
class HalamanDaftarCatatan extends StatefulWidget {
  const HalamanDaftarCatatan({super.key});

  @override
  State<HalamanDaftarCatatan> createState() => _HalamanDaftarCatatanState();
}

class _HalamanDaftarCatatanState extends State<HalamanDaftarCatatan> {
  final List<String> _catatan = [];

  Future<void> _tulisBaru() async {
    final String? baru = await Navigator.push<String>(
      context,
      MaterialPageRoute<String>(
        builder: (BuildContext context) => const HalamanTulisCatatan(),
      ),
    );
    if (!mounted) return;
    if (baru == null) return; // kembali tanpa menyimpan

    setState(() {
      _catatan.insert(0, baru); // catatan terbaru di paling atas
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catatan (${_catatan.length})')),
      body: _catatan.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Belum ada catatan. Ketuk tombol Tulis untuk mulai.',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView.separated(
              itemCount: _catatan.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(height: 1);
              },
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.sticky_note_2),
                  title: Text(_catatan[index]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tulisBaru,
        icon: const Icon(Icons.edit),
        label: const Text('Tulis'),
      ),
    );
  }
}

// ---------- Halaman 2: menulis catatan ----------
class HalamanTulisCatatan extends StatefulWidget {
  const HalamanTulisCatatan({super.key});

  @override
  State<HalamanTulisCatatan> createState() => _HalamanTulisCatatanState();
}

class _HalamanTulisCatatanState extends State<HalamanTulisCatatan> {
  final TextEditingController _kontrol = TextEditingController();
  bool _adaIsi = false;

  @override
  void dispose() {
    _kontrol.dispose();
    super.dispose();
  }

  Future<bool> _tanyaBuang() async {
    final bool? buang = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Buang catatan?'),
          content: const Text('Tulisan yang belum disimpan akan hilang.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Lanjut menulis'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Buang'),
            ),
          ],
        );
      },
    );
    return buang == true; // null (ketuk area gelap) dianggap "tidak"
  }

  void _simpan() {
    // Navigator.pop langsung menutup halaman, tidak ditahan PopScope.
    Navigator.pop(context, _kontrol.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // canPop: false = tombol kembali DITAHAN. Ditahan hanya jika sudah
      // ada tulisan; jika masih kosong, halaman boleh langsung ditutup.
      canPop: !_adaIsi,
      // Dipanggil setiap kali ada usaha menutup halaman ini.
      onPopInvokedWithResult: (bool sudahTertutup, Object? hasil) async {
        // Sudah tertutup (canPop true, atau lewat _simpan): selesai.
        if (sudahTertutup) return;

        // Masih tertahan: tanyakan dulu kepada pengguna.
        final bool buang = await _tanyaBuang();
        if (!mounted) return;
        if (buang) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Catatan Baru'),
          actions: [
            IconButton(
              tooltip: 'Simpan',
              onPressed: _adaIsi ? _simpan : null,
              icon: const Icon(Icons.check),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _kontrol,
            autofocus: true,
            // expands + maxLines: null = kolom memenuhi sisa layar.
            expands: true,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            decoration: const InputDecoration(
              hintText: 'Tulis catatan di sini...',
              border: OutlineInputBorder(),
            ),
            onChanged: (String teks) {
              setState(() {
                _adaIsi = teks.trim().isNotEmpty;
              });
            },
          ),
        ),
      ),
    );
  }
}

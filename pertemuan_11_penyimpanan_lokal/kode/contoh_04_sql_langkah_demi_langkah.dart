// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 11: PENYIMPANAN LOKAL
// CONTOH 04: Lab SQL Mini: SQLite Langkah demi Langkah (sqflite)
// Topik: Tekan tombol "Jalankan" untuk menjalankan 11 langkah SQL pada
//        tabel mahasiswa, lalu baca hasil setiap langkah di layar (dan
//        di konsol). Yang dipelajari:
//        - execute  : menjalankan SQL apa adanya (CREATE TABLE);
//        - insert   : menambah baris, hasilnya id baris baru;
//        - query    : membaca baris (where + whereArgs, orderBy);
//        - update   : hasilnya JUMLAH baris yang berubah;
//        - delete   : hasilnya JUMLAH baris yang terhapus;
//        - rawQuery : SQL bebas, misalnya COUNT(*) dan AVG(...);
//        - DatabaseException: misalnya NIM kembar ditolak UNIQUE.
//        Database contoh ini dibuat di MEMORI (inMemoryDatabasePath),
//        sehingga setiap kali dijalankan hasilnya selalu sama. Contoh 05
//        memakai berkas database sungguhan.
// =====================================================================
// CARA MENJALANKAN (tidak bisa di DartPad):
// 1. Proyek Flutter: jalankan sekali
//      flutter pub add sqflite sqflite_common_ffi_web
// 2. Khusus Chrome, jalankan sekali juga (lihat modul Bagian 5.4):
//      dart run sqflite_common_ffi_web:setup
// 3. Salin seluruh isi berkas ini ke lib/main.dart.
// 4. Jalankan: flutter run -d chrome --web-port=8080
//    (di HP Android cukup: flutter run)
// =====================================================================

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() {
  // Di Chrome, sqflite memakai SQLite versi WebAssembly. Di Android
  // baris ini dilewati dan sqflite memakai SQLite bawaan HP.
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  runApp(const AplikasiLabSql());
}

// ============================ MODEL ============================

class Mahasiswa {
  const Mahasiswa({
    required this.id,
    required this.nim,
    required this.nama,
    required this.ipk,
  });

  final int id;
  final String nim;
  final String nama;
  final double ipk;

  // Satu baris hasil query berbentuk Map<String, Object?>, misalnya
  // {id: 1, nim: 2609106001, nama: Rina Kusuma, ipk: 3.75}.
  factory Mahasiswa.dariBaris(Map<String, Object?> baris) {
    return switch (baris) {
      {
        'id': final int id,
        'nim': final String nim,
        'nama': final String nama,
        'ipk': final num ipk,
      } =>
        Mahasiswa(id: id, nim: nim, nama: nama, ipk: ipk.toDouble()),
      _ => throw FormatException('Baris tidak sesuai: $baris'),
    };
  }

  @override
  String toString() => '   $id · $nama · $nim · IPK ${ipk.toStringAsFixed(2)}';
}

// ======================= LANGKAH-LANGKAH =======================

// Menjalankan seluruh langkah. Setiap hasil dilaporkan lewat [catat].
Future<void> jalankanLab(void Function(String baris) catat) async {
  // Database baru yang kosong, hanya hidup di memori.
  final Database db = await openDatabase(inMemoryDatabasePath);

  try {
    // ---- Langkah 1: membuat tabel ----
    await db.execute('''
      CREATE TABLE mahasiswa (
        id   INTEGER PRIMARY KEY AUTOINCREMENT,
        nim  TEXT NOT NULL UNIQUE,
        nama TEXT NOT NULL,
        ipk  REAL NOT NULL
      )
    ''');
    catat('Langkah 1 · CREATE TABLE: tabel mahasiswa dibuat');

    // ---- Langkah 2: menambah baris ----
    // Map: kunci = nama kolom, nilai = isinya. id tidak diisi, karena
    // AUTOINCREMENT mengisinya sendiri. Hasil insert = id baris baru.
    final int idRina = await db.insert('mahasiswa', {
      'nim': '2609106001',
      'nama': 'Rina Kusuma',
      'ipk': 3.75,
    });
    final int idBayu = await db.insert('mahasiswa', {
      'nim': '2609106002',
      'nama': 'Bayu Saputra',
      'ipk': 3.10,
    });
    final int idCitra = await db.insert('mahasiswa', {
      'nim': '2609106003',
      'nama': 'Citra Lestari',
      'ipk': 3.92,
    });
    catat(
      'Langkah 2 · INSERT: Rina -> id $idRina, Bayu -> id $idBayu, '
      'Citra -> id $idCitra',
    );

    // ---- Langkah 3: membaca semua baris, urut nama ----
    final List<Map<String, Object?>> urutNama = await db.query(
      'mahasiswa',
      orderBy: 'nama',
    );
    catat('Langkah 3 · SELECT semua (urut nama):');
    for (final Map<String, Object?> baris in urutNama) {
      catat(Mahasiswa.dariBaris(baris).toString());
    }

    // ---- Langkah 4: membaca dengan syarat ----
    // Tanda ? diisi dari whereArgs secara berurutan (aman, lihat modul).
    final List<Map<String, Object?>> berprestasi = await db.query(
      'mahasiswa',
      where: 'ipk >= ?',
      whereArgs: [3.5],
      orderBy: 'ipk DESC',
    );
    catat('Langkah 4 · SELECT IPK >= 3.50 (tertinggi dulu):');
    for (final Map<String, Object?> baris in berprestasi) {
      catat(Mahasiswa.dariBaris(baris).toString());
    }

    // ---- Langkah 5 dan 6: mengubah baris ----
    final int berubah = await db.update(
      'mahasiswa',
      {'ipk': 3.40},
      where: 'nim = ?',
      whereArgs: ['2609106002'],
    );
    catat('Langkah 5 · UPDATE IPK Bayu -> $berubah baris berubah');

    final int tidakAda = await db.update(
      'mahasiswa',
      {'ipk': 4.0},
      where: 'nim = ?',
      whereArgs: ['2609109999'],
    );
    catat('Langkah 6 · UPDATE NIM 2609109999 -> $tidakAda baris berubah');

    // ---- Langkah 7: menghitung dengan SQL bebas ----
    final int? jumlah = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM mahasiswa'),
    );
    final List<Map<String, Object?>> rata = await db.rawQuery(
      'SELECT AVG(ipk) AS rata_rata FROM mahasiswa',
    );
    final num rataRata = rata.first['rata_rata'] as num;
    catat(
      'Langkah 7 · COUNT -> $jumlah mahasiswa, '
      'rata-rata IPK ${rataRata.toStringAsFixed(2)}',
    );

    // ---- Langkah 8: menghapus baris ----
    final int terhapus = await db.delete(
      'mahasiswa',
      where: 'id = ?',
      whereArgs: [idCitra],
    );
    catat('Langkah 8 · DELETE id $idCitra -> $terhapus baris terhapus');

    // ---- Langkah 9: aturan UNIQUE menolak NIM kembar ----
    try {
      await db.insert('mahasiswa', {
        'nim': '2609106001', // sudah dipakai Rina
        'nama': 'Rina Palsu',
        'ipk': 4.0,
      });
      catat('Langkah 9 · INSERT NIM kembar -> berhasil (seharusnya tidak!)');
    } on DatabaseException catch (galat) {
      if (galat.isUniqueConstraintError()) {
        catat('Langkah 9 · INSERT NIM kembar -> ditolak (UNIQUE)');
      } else {
        rethrow;
      }
    }

    // ---- Langkah 10: id yang sudah dihapus tidak dipakai ulang ----
    final int idDewi = await db.insert('mahasiswa', {
      'nim': '2609106004',
      'nama': 'Dewi Anggraini',
      'ipk': 3.58,
    });
    catat(
      'Langkah 10 · INSERT Dewi -> id $idDewi '
      '(id $idCitra tidak dipakai lagi)',
    );

    // ---- Langkah 11: hasil akhir ----
    final List<Map<String, Object?>> akhir = await db.query(
      'mahasiswa',
      orderBy: 'id',
    );
    catat('Langkah 11 · SELECT semua (urut id):');
    for (final Map<String, Object?> baris in akhir) {
      catat(Mahasiswa.dariBaris(baris).toString());
    }
  } finally {
    // Menutup database di memori = membuangnya. Klik "Jalankan" lagi
    // untuk memulai dari database kosong.
    await db.close();
  }
}

// ============================ VIEW ============================

class AplikasiLabSql extends StatelessWidget {
  const AplikasiLabSql({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab SQL Mini',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HalamanLabSql(),
    );
  }
}

class HalamanLabSql extends StatefulWidget {
  const HalamanLabSql({super.key});

  @override
  State<HalamanLabSql> createState() => _HalamanLabSqlState();
}

class _HalamanLabSqlState extends State<HalamanLabSql> {
  final List<String> _catatan = [];
  bool _berjalan = false;

  Future<void> _jalankan() async {
    setState(() {
      _catatan.clear();
      _berjalan = true;
    });
    try {
      await jalankanLab((String baris) {
        debugPrint(baris);
        if (mounted) {
          setState(() => _catatan.add(baris));
        }
      });
    } catch (galat) {
      debugPrint('Galat: $galat');
      if (mounted) {
        setState(() => _catatan.add('GALAT: $galat'));
      }
    }
    if (mounted) {
      setState(() => _berjalan = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Lab SQL Mini')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton.icon(
              onPressed: _berjalan ? null : _jalankan,
              icon: const Icon(Icons.play_arrow),
              label: Text(_berjalan ? 'Sedang berjalan...' : 'Jalankan'),
            ),
          ),
          Expanded(
            child: _catatan.isEmpty
                ? const Center(child: Text('Tekan Jalankan untuk memulai.'))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: _catatan.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String baris = _catatan[index];
                      final bool judulLangkah = baris.startsWith('Langkah');
                      return Padding(
                        padding: EdgeInsets.only(top: judulLangkah ? 8 : 0),
                        child: Text(
                          baris,
                          style: judulLangkah
                              ? gayaTeks.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                )
                              : gayaTeks.bodyMedium?.copyWith(
                                  fontFamily: 'monospace',
                                ),
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

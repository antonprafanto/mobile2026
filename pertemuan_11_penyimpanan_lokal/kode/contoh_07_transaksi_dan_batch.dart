// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 11: PENYIMPANAN LOKAL
// CONTOH 07: Kas Kelas: Transaksi dan Batch
// Topik: Bendahara memindahkan uang dari "Kas Kelas" ke "Kas Study Tour".
//        Satu pemindahan = BEBERAPA perintah SQL (kurangi saldo asal,
//        catat mutasi, tambah saldo tujuan, catat mutasi). Jika aplikasi
//        gagal di tengah jalan, uang bisa "hilang".
//        - transaction : semua perintah di dalamnya berhasil SEMUA atau
//                        dibatalkan SEMUA (rollback);
//        - batch       : banyak perintah dikumpulkan lalu dikirim
//                        sekaligus (cepat), misalnya mencatat iuran
//                        12 mahasiswa;
//        - rawQuery dengan JOIN (nama dompet) dan SUM (total uang).
//        Coba nyalakan "Simulasikan gangguan", lalu pindahkan uang dengan
//        transaksi dan tanpa transaksi. Perhatikan TOTAL uang.
// =====================================================================
// CARA MENJALANKAN (tidak bisa di DartPad):
// 1. Proyek Flutter: jalankan sekali
//      flutter pub add sqflite sqflite_common_ffi_web provider
// 2. Khusus Chrome, jalankan sekali juga: dart run sqflite_common_ffi_web:setup
// 3. Salin seluruh isi berkas ini ke lib/main.dart.
// 4. Jalankan: flutter run -d chrome --web-port=8080
//    (di HP Android cukup: flutter run)
// =====================================================================

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  await jalankanUji();

  runApp(
    MultiProvider(
      providers: [
        Provider<LayananBasisData>(
          create: (BuildContext context) => LayananBasisData(),
          dispose: (BuildContext context, LayananBasisData layanan) =>
              layanan.tutup(),
        ),
        Provider<RepositoriKas>(
          create: (BuildContext context) =>
              RepositoriKasSqlite(layanan: context.read<LayananBasisData>()),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) =>
              KasViewModel(repositori: context.read<RepositoriKas>())..muat(),
        ),
      ],
      child: const AplikasiKas(),
    ),
  );
}

// ============================ MODEL ============================

const int idKasKelas = 1;
const int idKasStudyTour = 2;
const int saldoAwalKasKelas = 500000;

class Dompet {
  const Dompet({required this.id, required this.nama, required this.saldo});

  final int id;
  final String nama;
  final int saldo; // rupiah; uang disimpan sebagai bilangan BULAT

  factory Dompet.dariBaris(Map<String, Object?> baris) {
    return switch (baris) {
      {
        'id': final int id,
        'nama': final String nama,
        'saldo': final int saldo,
      } =>
        Dompet(id: id, nama: nama, saldo: saldo),
      _ => throw FormatException('Baris dompet tidak sesuai: $baris'),
    };
  }
}

class Mutasi {
  const Mutasi({
    required this.namaDompet,
    required this.jumlah,
    required this.keterangan,
  });

  final String namaDompet;
  final int jumlah; // positif = uang masuk, negatif = uang keluar
  final String keterangan;

  factory Mutasi.dariBaris(Map<String, Object?> baris) {
    return switch (baris) {
      {
        'nama_dompet': final String namaDompet,
        'jumlah': final int jumlah,
        'keterangan': final String keterangan,
      } =>
        Mutasi(namaDompet: namaDompet, jumlah: jumlah, keterangan: keterangan),
      _ => throw FormatException('Baris mutasi tidak sesuai: $baris'),
    };
  }
}

// Dilempar jika saldo dompet asal kurang.
class SaldoTidakCukup implements Exception {
  const SaldoTidakCukup();
}

// KHUSUS PERCOBAAN: berpura-pura aplikasi "mati" di tengah proses.
class GangguanSimulasi implements Exception {
  const GangguanSimulasi();

  @override
  String toString() => 'GangguanSimulasi: aplikasi berhenti di tengah proses';
}

// ===================== SERVICE (LAYANAN) =====================

class LayananBasisData {
  LayananBasisData({this.namaBerkas = 'kas_kelas.db'});

  final String namaBerkas;
  Future<Database>? _database;

  Future<Database> get database => _database ??= _buka();

  Future<Database> _buka() {
    return openDatabase(namaBerkas, version: 1, onCreate: _buatTabel);
  }

  // onCreate sudah berjalan di dalam transaksi, jadi cukup memakai batch:
  // dua tabel dan dua dompet awal dibuat dalam satu kali kirim.
  static Future<void> _buatTabel(Database db, int versi) async {
    final Batch batch = db.batch();
    batch.execute('''
      CREATE TABLE dompet (
        id    INTEGER PRIMARY KEY,
        nama  TEXT NOT NULL,
        saldo INTEGER NOT NULL CHECK (saldo >= 0)
      )
    ''');
    batch.execute('''
      CREATE TABLE mutasi (
        id         INTEGER PRIMARY KEY AUTOINCREMENT,
        dompet_id  INTEGER NOT NULL REFERENCES dompet (id),
        jumlah     INTEGER NOT NULL,
        keterangan TEXT NOT NULL,
        waktu      INTEGER NOT NULL
      )
    ''');
    batch.insert('dompet', {
      'id': idKasKelas,
      'nama': 'Kas Kelas',
      'saldo': saldoAwalKasKelas,
    });
    batch.insert('dompet', {
      'id': idKasStudyTour,
      'nama': 'Kas Study Tour',
      'saldo': 0,
    });
    // noResult: true = hasil tiap perintah tidak perlu dikembalikan.
    await batch.commit(noResult: true);
  }

  Future<void> tutup() async {
    final Future<Database>? database = _database;
    _database = null;
    if (database == null) {
      return;
    }
    final Database db = await database;
    await db.close();
  }
}

// ========================= REPOSITORY =========================

abstract class RepositoriKas {
  Future<List<Dompet>> ambilDompet();

  Future<List<Mutasi>> ambilMutasi({int batas = 20});

  // Jumlah saldo semua dompet, dihitung oleh SQL.
  Future<int> ambilTotalUang();

  // pakaiTransaksi dan gangguan hanya untuk PERCOBAAN di contoh ini.
  Future<void> pindahkan({
    required int dariId,
    required int keId,
    required int jumlah,
    required String keterangan,
    bool pakaiTransaksi = true,
    bool gangguan = false,
  });

  // Mengembalikan jumlah mutasi yang dicatat.
  Future<int> catatIuran(List<String> namaMahasiswa, int iuranPerOrang);

  Future<void> aturUlang();
}

class RepositoriKasSqlite implements RepositoriKas {
  RepositoriKasSqlite({required this._layanan});

  final LayananBasisData _layanan;

  @override
  Future<List<Dompet>> ambilDompet() async {
    final Database db = await _layanan.database;
    final List<Map<String, Object?>> baris = await db.query(
      'dompet',
      orderBy: 'id',
    );
    return baris.map(Dompet.dariBaris).toList();
  }

  @override
  Future<List<Mutasi>> ambilMutasi({int batas = 20}) async {
    final Database db = await _layanan.database;
    // JOIN: nama dompet diambil dari tabel dompet.
    final List<Map<String, Object?>> baris = await db.rawQuery(
      '''
      SELECT d.nama AS nama_dompet, m.jumlah, m.keterangan
      FROM mutasi m
      JOIN dompet d ON d.id = m.dompet_id
      ORDER BY m.id DESC
      LIMIT ?
      ''',
      [batas],
    );
    return baris.map(Mutasi.dariBaris).toList();
  }

  // SUM(saldo) menjumlahkan kolom saldo dari semua baris. Jika tabelnya
  // kosong, hasil SUM adalah NULL; COALESCE(..., 0) menggantinya dengan 0.
  @override
  Future<int> ambilTotalUang() async {
    final Database db = await _layanan.database;
    final int? total = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COALESCE(SUM(saldo), 0) FROM dompet'),
    );
    return total ?? 0;
  }

  @override
  Future<void> pindahkan({
    required int dariId,
    required int keId,
    required int jumlah,
    required String keterangan,
    bool pakaiTransaksi = true,
    bool gangguan = false,
  }) async {
    final Database db = await _layanan.database;
    if (pakaiTransaksi) {
      // Berhasil SEMUA, atau dibatalkan SEMUA jika ada yang melempar
      // exception. Di dalam blok ini, pakai txn, JANGAN db (bisa macet).
      await db.transaction((Transaction txn) async {
        await _langkahPindah(txn, dariId, keId, jumlah, keterangan, gangguan);
      });
    } else {
      // Tanpa transaksi: setiap perintah langsung tersimpan sendiri-sendiri.
      await _langkahPindah(db, dariId, keId, jumlah, keterangan, gangguan);
    }
  }

  // DatabaseExecutor = "apa pun yang bisa menjalankan SQL", yaitu Database
  // maupun Transaction. Jadi langkah yang sama bisa dipakai keduanya.
  Future<void> _langkahPindah(
    DatabaseExecutor sql,
    int dariId,
    int keId,
    int jumlah,
    String keterangan,
    bool gangguan,
  ) async {
    final int waktu = DateTime.now().millisecondsSinceEpoch;

    final int saldoAsal =
        Sqflite.firstIntValue(
          await sql.rawQuery('SELECT saldo FROM dompet WHERE id = ?', [dariId]),
        ) ??
        0;
    if (saldoAsal < jumlah) {
      throw const SaldoTidakCukup();
    }

    // 1. Uang keluar dari dompet asal.
    await sql.rawUpdate('UPDATE dompet SET saldo = saldo - ? WHERE id = ?', [
      jumlah,
      dariId,
    ]);
    await sql.insert('mutasi', {
      'dompet_id': dariId,
      'jumlah': -jumlah,
      'keterangan': keterangan,
      'waktu': waktu,
    });

    // 2. KHUSUS PERCOBAAN: aplikasi "mati" tepat di tengah proses.
    if (gangguan) {
      throw const GangguanSimulasi();
    }

    // 3. Uang masuk ke dompet tujuan.
    await sql.rawUpdate('UPDATE dompet SET saldo = saldo + ? WHERE id = ?', [
      jumlah,
      keId,
    ]);
    await sql.insert('mutasi', {
      'dompet_id': keId,
      'jumlah': jumlah,
      'keterangan': keterangan,
      'waktu': waktu,
    });
  }

  @override
  Future<int> catatIuran(List<String> namaMahasiswa, int iuranPerOrang) async {
    final Database db = await _layanan.database;
    final int waktu = DateTime.now().millisecondsSinceEpoch;
    await db.transaction((Transaction txn) async {
      // Batch: perintah dikumpulkan dulu, lalu dikirim SEKALIGUS.
      final Batch batch = txn.batch();
      for (final String nama in namaMahasiswa) {
        batch.insert('mutasi', {
          'dompet_id': idKasKelas,
          'jumlah': iuranPerOrang,
          'keterangan': 'Iuran $nama',
          'waktu': waktu,
        });
      }
      batch.rawUpdate('UPDATE dompet SET saldo = saldo + ? WHERE id = ?', [
        iuranPerOrang * namaMahasiswa.length,
        idKasKelas,
      ]);
      await batch.commit(noResult: true);
    });
    return namaMahasiswa.length;
  }

  @override
  Future<void> aturUlang() async {
    final Database db = await _layanan.database;
    await db.transaction((Transaction txn) async {
      await txn.delete('mutasi');
      await txn.update(
        'dompet',
        {'saldo': saldoAwalKasKelas},
        where: 'id = ?',
        whereArgs: [idKasKelas],
      );
      await txn.update(
        'dompet',
        {'saldo': 0},
        where: 'id = ?',
        whereArgs: [idKasStudyTour],
      );
    });
  }
}

// ========================= VIEWMODEL =========================

const List<String> daftarMahasiswa = [
  'Rina',
  'Bayu',
  'Citra',
  'Dewi',
  'Eka',
  'Fajar',
  'Gita',
  'Hadi',
  'Intan',
  'Joko',
  'Kirana',
  'Lukman',
];

class KasViewModel extends ChangeNotifier {
  KasViewModel({required this._repositori});

  final RepositoriKas _repositori;

  bool _memuat = true;
  bool _sibuk = false;
  List<Dompet> _dompet = [];
  List<Mutasi> _mutasi = [];
  int _totalUang = 0;
  int _jumlah = 50000;
  bool _pakaiTransaksi = true;
  bool _gangguan = false;
  bool _sudahDibuang = false;

  bool get memuat => _memuat;
  bool get sibuk => _sibuk;
  List<Dompet> get dompet => _dompet;
  List<Mutasi> get mutasi => _mutasi;
  int get jumlah => _jumlah;
  bool get pakaiTransaksi => _pakaiTransaksi;
  bool get gangguan => _gangguan;
  int get totalUang => _totalUang;

  Future<void> muat() async {
    try {
      final List<Dompet> dompet = await _repositori.ambilDompet();
      final List<Mutasi> mutasi = await _repositori.ambilMutasi();
      final int total = await _repositori.ambilTotalUang();
      if (_sudahDibuang) {
        return;
      }
      _dompet = dompet;
      _mutasi = mutasi;
      _totalUang = total;
    } catch (galat) {
      debugPrint('Galat saat membaca kas: $galat');
    }
    _memuat = false;
    if (!_sudahDibuang) {
      notifyListeners();
    }
  }

  void pilihJumlah(int jumlah) {
    _jumlah = jumlah;
    notifyListeners();
  }

  void aturTransaksi(bool nyala) {
    _pakaiTransaksi = nyala;
    notifyListeners();
  }

  void aturGangguan(bool nyala) {
    _gangguan = nyala;
    notifyListeners();
  }

  // Mengembalikan kalimat untuk ditampilkan di SnackBar.
  Future<String> pindahkan() async {
    _sibuk = true;
    notifyListeners();
    String pesan;
    try {
      await _repositori.pindahkan(
        dariId: idKasKelas,
        keId: idKasStudyTour,
        jumlah: _jumlah,
        keterangan: 'Pindah ke Study Tour',
        pakaiTransaksi: _pakaiTransaksi,
        gangguan: _gangguan,
      );
      pesan = '${formatRupiah(_jumlah)} berhasil dipindahkan.';
    } on SaldoTidakCukup {
      pesan = 'Saldo Kas Kelas tidak cukup. Tidak ada yang berubah.';
    } on GangguanSimulasi {
      pesan = _pakaiTransaksi
          ? 'Gangguan! Transaksi dibatalkan, semua saldo kembali seperti awal.'
          : 'Gangguan! Kas Kelas sudah berkurang, tetapi Kas Study Tour '
                'tidak bertambah. Uangnya hilang!';
    } catch (galat) {
      debugPrint('Galat saat memindahkan: $galat');
      pesan = 'Terjadi kesalahan saat menyimpan.';
    }
    _sibuk = false;
    await muat();
    return pesan;
  }

  Future<String> catatIuran() async {
    _sibuk = true;
    notifyListeners();
    String pesan;
    try {
      final int jumlah = await _repositori.catatIuran(daftarMahasiswa, 10000);
      pesan = '$jumlah iuran dicatat sekaligus dengan batch.';
    } catch (galat) {
      debugPrint('Galat saat mencatat iuran: $galat');
      pesan = 'Iuran gagal dicatat.';
    }
    _sibuk = false;
    await muat();
    return pesan;
  }

  Future<void> aturUlang() async {
    await _repositori.aturUlang();
    await muat();
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    super.dispose();
  }
}

// ============================ VIEW ============================

// 1500000 -> Rp1.500.000 ; -50000 -> -Rp50.000
String formatRupiah(int angka) {
  final String digit = angka.abs().toString();
  final StringBuffer hasil = StringBuffer();
  for (int i = 0; i < digit.length; i++) {
    if (i > 0 && (digit.length - i) % 3 == 0) {
      hasil.write('.');
    }
    hasil.write(digit[i]);
  }
  return '${angka < 0 ? '-' : ''}Rp$hasil';
}

// 50000 -> +Rp50.000 ; -50000 -> -Rp50.000
String rupiahBertanda(int angka) {
  return angka >= 0 ? '+${formatRupiah(angka)}' : formatRupiah(angka);
}

class AplikasiKas extends StatelessWidget {
  const AplikasiKas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kas Kelas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const HalamanKas(),
    );
  }
}

class HalamanKas extends StatelessWidget {
  const HalamanKas({super.key});

  // Menjalankan perintah ViewModel, lalu menampilkan kalimat hasilnya.
  Future<void> _jalankan(
    BuildContext context,
    Future<String> Function() perintah,
  ) async {
    final ScaffoldMessengerState pesan = ScaffoldMessenger.of(context);
    final String hasil = await perintah();
    pesan.hideCurrentSnackBar();
    pesan.showSnackBar(SnackBar(content: Text(hasil)));
  }

  @override
  Widget build(BuildContext context) {
    final KasViewModel vm = context.watch<KasViewModel>();
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    if (vm.memuat) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kas Kelas'),
        actions: [
          IconButton(
            onPressed: vm.sibuk
                ? null
                : () => context.read<KasViewModel>().aturUlang(),
            tooltip: 'Atur ulang',
            icon: const Icon(Icons.restart_alt),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              for (final Dompet dompet in vm.dompet)
                Expanded(child: KartuDompet(dompet: dompet)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Total uang di kedua dompet: ${formatRupiah(vm.totalUang)}',
            textAlign: TextAlign.center,
            style: gayaTeks.titleSmall,
          ),
          const SizedBox(height: 24),
          Text('Pindahkan ke Kas Study Tour', style: gayaTeks.titleMedium),
          const SizedBox(height: 8),
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 50000, label: Text('50 rb')),
              ButtonSegment(value: 200000, label: Text('200 rb')),
              ButtonSegment(value: 1000000, label: Text('1 juta')),
            ],
            selected: {vm.jumlah},
            onSelectionChanged: (Set<int> pilihan) {
              context.read<KasViewModel>().pilihJumlah(pilihan.first);
            },
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Pakai transaksi'),
            value: vm.pakaiTransaksi,
            onChanged: (bool nyala) {
              context.read<KasViewModel>().aturTransaksi(nyala);
            },
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Simulasikan gangguan di tengah proses'),
            value: vm.gangguan,
            onChanged: (bool nyala) {
              context.read<KasViewModel>().aturGangguan(nyala);
            },
          ),
          FilledButton.icon(
            onPressed: vm.sibuk ? null : () => _jalankan(context, vm.pindahkan),
            icon: const Icon(Icons.swap_horiz),
            label: const Text('Pindahkan'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: vm.sibuk
                ? null
                : () => _jalankan(context, vm.catatIuran),
            icon: const Icon(Icons.group_add),
            label: const Text('Catat iuran 12 mahasiswa (batch)'),
          ),
          const SizedBox(height: 24),
          Text('Mutasi terakhir', style: gayaTeks.titleMedium),
          if (vm.mutasi.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('Belum ada mutasi.'),
            ),
          for (final Mutasi mutasi in vm.mutasi)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                mutasi.jumlah >= 0 ? Icons.south_west : Icons.north_east,
              ),
              title: Text(mutasi.keterangan),
              subtitle: Text(mutasi.namaDompet),
              trailing: Text(rupiahBertanda(mutasi.jumlah)),
            ),
        ],
      ),
    );
  }
}

class KartuDompet extends StatelessWidget {
  const KartuDompet({super.key, required this.dompet});

  final Dompet dompet;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Card.filled(
      color: warna.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dompet.nama,
              style: gayaTeks.labelLarge?.copyWith(
                color: warna.onSecondaryContainer,
              ),
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                formatRupiah(dompet.saldo),
                style: gayaTeks.titleLarge?.copyWith(
                  color: warna.onSecondaryContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================= PEMERIKSAAN =======================

void periksa(String nama, Object? didapat, Object? diharapkan) {
  if (didapat == diharapkan) {
    debugPrint('LULUS  $nama');
  } else {
    debugPrint('GAGAL  $nama: diharapkan $diharapkan, hasilnya $didapat');
  }
}

Future<void> jalankanUji() async {
  final LayananBasisData layanan = LayananBasisData(
    namaBerkas: inMemoryDatabasePath,
  );
  final RepositoriKas repo = RepositoriKasSqlite(layanan: layanan);

  Future<List<int>> saldo() async {
    final List<Dompet> semua = await repo.ambilDompet();
    return [for (final Dompet dompet in semua) dompet.saldo];
  }

  try {
    periksa('Saldo awal', (await saldo()).join(' / '), '500000 / 0');

    await repo.pindahkan(
      dariId: idKasKelas,
      keId: idKasStudyTour,
      jumlah: 50000,
      keterangan: 'Uji',
    );
    periksa('Pindah 50 rb', (await saldo()).join(' / '), '450000 / 50000');
    periksa('Tercatat 2 mutasi', (await repo.ambilMutasi()).length, 2);

    try {
      await repo.pindahkan(
        dariId: idKasKelas,
        keId: idKasStudyTour,
        jumlah: 1000000,
        keterangan: 'Uji',
      );
      periksa('Saldo kurang ditolak', 'berhasil', 'SaldoTidakCukup');
    } on SaldoTidakCukup {
      periksa('Saldo kurang ditolak', 'SaldoTidakCukup', 'SaldoTidakCukup');
    }

    try {
      await repo.pindahkan(
        dariId: idKasKelas,
        keId: idKasStudyTour,
        jumlah: 50000,
        keterangan: 'Uji',
        gangguan: true,
      );
    } on GangguanSimulasi {
      // memang diharapkan
    }
    periksa(
      'Transaksi + gangguan: saldo utuh',
      (await saldo()).join(' / '),
      '450000 / 50000',
    );
    periksa(
      'Transaksi + gangguan: mutasi tidak bertambah',
      (await repo.ambilMutasi()).length,
      2,
    );

    try {
      await repo.pindahkan(
        dariId: idKasKelas,
        keId: idKasStudyTour,
        jumlah: 50000,
        keterangan: 'Uji',
        pakaiTransaksi: false,
        gangguan: true,
      );
    } on GangguanSimulasi {
      // memang diharapkan
    }
    periksa(
      'TANPA transaksi + gangguan: 50 rb hilang (inilah masalahnya)',
      (await saldo()).join(' / '),
      '400000 / 50000',
    );
    periksa('SUM: total tinggal 450 rb', await repo.ambilTotalUang(), 450000);

    final int jumlahIuran = await repo.catatIuran(daftarMahasiswa, 10000);
    periksa('Batch: 12 iuran dicatat', jumlahIuran, 12);
    periksa('Batch: saldo bertambah 120 rb', (await saldo()).first, 520000);

    await repo.aturUlang();
    periksa('Atur ulang', (await saldo()).join(' / '), '500000 / 0');
    periksa('Atur ulang: mutasi kosong', (await repo.ambilMutasi()).length, 0);
    periksa('formatRupiah', formatRupiah(1500000), 'Rp1.500.000');
  } catch (galat) {
    debugPrint('GAGAL  pemeriksaan berhenti: $galat');
  } finally {
    await layanan.tutup();
  }
}

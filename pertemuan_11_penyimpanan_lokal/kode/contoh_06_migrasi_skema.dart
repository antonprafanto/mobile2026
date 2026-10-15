// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 11: PENYIMPANAN LOKAL
// CONTOH 06: Mengubah Struktur Tabel: Versi dan Migrasi (onUpgrade)
// Topik: Lanjutan Contoh 05. Catatan kini bisa DISEMATKAN (pin) agar
//        selalu tampil paling atas, sehingga tabel catatan butuh kolom
//        baru: disematkan. Database pengguna yang sudah berisi catatan
//        TIDAK boleh dihapus, jadi:
//        - version dinaikkan dari 1 menjadi 2;
//        - onCreate membuat tabel versi TERBARU (untuk pengguna baru);
//        - onUpgrade menambah kolom untuk pengguna lama (versi 1 -> 2)
//          dengan ALTER TABLE, tanpa menyentuh catatan yang sudah ada.
//        Bagian yang berubah dari Contoh 05 ditandai [BARU].
//        Coba: jalankan Contoh 05, tambahkan beberapa catatan, hentikan
//        (tekan q), lalu jalankan contoh ini dengan port yang sama.
//        Catatan lama tetap ada, dan konsol menampilkan
//        "Migrasi database: versi 1 -> 2".
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
  // Wajib karena plugin (sqflite) dipakai sebelum runApp (oleh jalankanUji).
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb; // SQLite versi web
  }
  await jalankanUji();

  runApp(
    MultiProvider(
      providers: [
        // Layanan dibuat sekali, dan database ditutup saat aplikasi selesai.
        Provider<LayananBasisData>(
          create: (BuildContext context) => LayananBasisData(),
          dispose: (BuildContext context, LayananBasisData layanan) =>
              layanan.tutup(),
        ),
        Provider<RepositoriCatatan>(
          create: (BuildContext context) => RepositoriCatatanSqlite(
            layanan: context.read<LayananBasisData>(),
          ),
        ),
        // Dititipkan DI ATAS MaterialApp agar halaman formulir (rute baru)
        // juga bisa memakainya.
        ChangeNotifierProvider(
          create: (BuildContext context) =>
              CatatanViewModel(repositori: context.read<RepositoriCatatan>())
                ..muat(),
        ),
      ],
      child: const AplikasiCatatan(),
    ),
  );
}

// ============================ MODEL ============================

class Catatan {
  const Catatan({
    this.id,
    required this.judul,
    required this.isi,
    required this.diubah,
    this.disematkan = false, // [BARU]
  });

  final int? id; // null = belum pernah disimpan ke database
  final String judul;
  final String isi;
  final DateTime diubah;
  final bool disematkan; // [BARU]

  Catatan copyWith({
    int? id,
    String? judul,
    String? isi,
    DateTime? diubah,
    bool? disematkan,
  }) {
    return Catatan(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      isi: isi ?? this.isi,
      diubah: diubah ?? this.diubah,
      disematkan: disematkan ?? this.disematkan,
    );
  }

  Map<String, Object?> keBaris() {
    return {
      if (id != null) 'id': id,
      'judul': judul,
      'isi': isi,
      'diubah': diubah.millisecondsSinceEpoch,
      // [BARU] SQLite tidak punya tipe bool: true disimpan 1, false 0.
      'disematkan': disematkan ? 1 : 0,
    };
  }

  factory Catatan.dariBaris(Map<String, Object?> baris) {
    return switch (baris) {
      {
        'id': final int id,
        'judul': final String judul,
        'isi': final String isi,
        'diubah': final int diubah,
        'disematkan': final int disematkan, // [BARU]
      } =>
        Catatan(
          id: id,
          judul: judul,
          isi: isi,
          diubah: DateTime.fromMillisecondsSinceEpoch(diubah),
          disematkan: disematkan == 1,
        ),
      _ => throw FormatException('Baris catatan tidak sesuai: $baris'),
    };
  }
}

// ===================== SERVICE (LAYANAN) =====================

class LayananBasisData {
  LayananBasisData({this.namaBerkas = 'catatan_kuliah.db'});

  // Nama berkas saja sudah cukup: sqflite menyimpannya di folder database
  // milik aplikasi. inMemoryDatabasePath = database sementara di memori.
  final String namaBerkas;

  Future<Database>? _database;

  // Pemanggilan pertama membuka database. Pemanggilan berikutnya
  // mendapat Future yang SAMA, jadi database tidak dibuka berkali-kali.
  Future<Database> get database => _database ??= _buka();

  Future<Database> _buka() {
    return openDatabase(
      namaBerkas,
      version: 2, // [BARU] naik dari 1, karena struktur tabel berubah
      // Pengguna BARU (berkas belum ada): langsung tabel versi terbaru.
      onCreate: (Database db, int versi) async {
        await db.execute('''
          CREATE TABLE catatan (
            id         INTEGER PRIMARY KEY AUTOINCREMENT,
            judul      TEXT NOT NULL,
            isi        TEXT NOT NULL,
            diubah     INTEGER NOT NULL,
            disematkan INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
      // [BARU] Pengguna LAMA (berkas versi 1 sudah ada): ditingkatkan.
      onUpgrade: (Database db, int versiLama, int versiBaru) async {
        debugPrint('Migrasi database: versi $versiLama -> $versiBaru');
        await tingkatkanSkema(db, versiLama, versiBaru);
      },
    );
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

// [BARU] Dipanggil sqflite jika versi database di perangkat LEBIH RENDAH
// daripada version di openDatabase. Setiap blok if membawa database naik
// satu versi, sehingga pengguna yang melompat dari versi 1 ke versi 3
// pun tetap melewati semua langkah dengan urut.
// Ditulis sebagai fungsi tersendiri agar bisa diuji (lihat jalankanUji).
Future<void> tingkatkanSkema(Database db, int versiLama, int versiBaru) async {
  if (versiLama < 2) {
    // DEFAULT 0: semua catatan lama otomatis "tidak disematkan".
    try {
      await db.execute(
        'ALTER TABLE catatan ADD COLUMN disematkan INTEGER NOT NULL DEFAULT 0',
      );
    } on DatabaseException catch (galat) {
      // Pengaman khusus latihan: kolom ini sudah ada jika Contoh 05
      // (versi 1) sempat dijalankan lagi setelah contoh ini. Di aplikasi
      // sungguhan, versi database hanya pernah naik.
      if (!galat.isDuplicateColumnError('disematkan')) {
        rethrow;
      }
    }
  }
  // Perubahan berikutnya cukup menambah blok baru di sini, misalnya:
  // if (versiLama < 3) { ... }
}

// ========================= REPOSITORY =========================

abstract class RepositoriCatatan {
  Future<List<Catatan>> ambilSemua({String kataKunci = ''});

  Future<Catatan> tambah({required String judul, required String isi});

  Future<void> ubah(Catatan catatan);

  Future<void> hapus(int id);

  // Menyimpan kembali catatan yang baru dihapus (tombol "Urungkan").
  Future<void> pulihkan(Catatan catatan);

  Future<void> sematkan(int id, bool disematkan); // [BARU]
}

class RepositoriCatatanSqlite implements RepositoriCatatan {
  RepositoriCatatanSqlite({required LayananBasisData layanan})
    : _layanan = layanan;

  static const String _tabel = 'catatan';

  final LayananBasisData _layanan;

  @override
  Future<List<Catatan>> ambilSemua({String kataKunci = ''}) async {
    final Database db = await _layanan.database;
    final String kunci = kataKunci.trim();
    final List<Map<String, Object?>> baris = await db.query(
      _tabel,
      // LIKE '%kata%' = mengandung kata itu (huruf besar/kecil dianggap
      // sama). Nilainya dikirim lewat whereArgs, BUKAN ditempel ke SQL.
      where: kunci.isEmpty ? null : 'judul LIKE ? OR isi LIKE ?',
      whereArgs: kunci.isEmpty ? null : ['%$kunci%', '%$kunci%'],
      // [BARU] Yang disematkan (1) di atas yang tidak (0), lalu terbaru.
      orderBy: 'disematkan DESC, diubah DESC, id DESC',
    );
    return baris.map(Catatan.dariBaris).toList();
  }

  @override
  Future<Catatan> tambah({required String judul, required String isi}) async {
    final Database db = await _layanan.database;
    final Catatan baru = Catatan(
      judul: judul,
      isi: isi,
      diubah: DateTime.now(),
    );
    // insert mengembalikan id yang diberikan SQLite untuk baris baru.
    final int id = await db.insert(_tabel, baru.keBaris());
    return baru.copyWith(id: id);
  }

  @override
  Future<void> ubah(Catatan catatan) async {
    final Database db = await _layanan.database;
    final int berubah = await db.update(
      _tabel,
      catatan.keBaris(),
      where: 'id = ?',
      whereArgs: [catatan.id],
    );
    if (berubah == 0) {
      throw StateError('Catatan dengan id ${catatan.id} tidak ditemukan');
    }
  }

  @override
  Future<void> hapus(int id) async {
    final Database db = await _layanan.database;
    await db.delete(_tabel, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> pulihkan(Catatan catatan) async {
    final Database db = await _layanan.database;
    // keBaris() menyertakan id lama, jadi catatan kembali dengan id-nya.
    await db.insert(_tabel, catatan.keBaris());
  }

  // [BARU] Hanya kolom disematkan yang diubah; waktu diubah tetap.
  @override
  Future<void> sematkan(int id, bool disematkan) async {
    final Database db = await _layanan.database;
    await db.update(
      _tabel,
      {'disematkan': disematkan ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// ========================= VIEWMODEL =========================

enum StatusMuat { memuat, berhasil, gagal }

class CatatanViewModel extends ChangeNotifier {
  CatatanViewModel({required RepositoriCatatan repositori})
    : _repositori = repositori;

  final RepositoriCatatan _repositori;

  StatusMuat _status = StatusMuat.memuat;
  List<Catatan> _daftar = [];
  String _kataKunci = '';
  int _nomorPermintaan = 0;
  bool _sudahDibuang = false;

  StatusMuat get status => _status;
  List<Catatan> get daftar => _daftar;
  String get kataKunci => _kataKunci;

  Future<void> muat() async {
    // Penjaga jawaban terlambat (Pertemuan 10): saat pengguna mengetik
    // cepat, hanya hasil pencarian TERAKHIR yang dipakai.
    final int nomor = ++_nomorPermintaan;
    try {
      final List<Catatan> hasil = await _repositori.ambilSemua(
        kataKunci: _kataKunci,
      );
      if (_sudahDibuang || nomor != _nomorPermintaan) {
        return;
      }
      _daftar = hasil;
      _status = StatusMuat.berhasil;
    } catch (galat) {
      if (_sudahDibuang || nomor != _nomorPermintaan) {
        return;
      }
      debugPrint('Galat saat membaca catatan: $galat');
      _status = StatusMuat.gagal;
    }
    notifyListeners();
  }

  // Database ada di perangkat sendiri dan cepat, jadi pencarian langsung
  // dijalankan tanpa debounce.
  Future<void> cari(String teks) {
    _kataKunci = teks;
    return muat();
  }

  Future<bool> tambah(String judul, String isi) {
    return _tulis(
      () => _repositori.tambah(judul: judul.trim(), isi: isi.trim()),
    );
  }

  Future<bool> ubah(Catatan lama, String judul, String isi) {
    final Catatan baru = lama.copyWith(
      judul: judul.trim(),
      isi: isi.trim(),
      diubah: DateTime.now(),
    );
    return _tulis(() => _repositori.ubah(baru));
  }

  Future<bool> hapus(Catatan catatan) {
    // Dibuang dari daftar SEKARANG JUGA, karena Dismissible mewajibkan
    // barisnya langsung hilang. Database menyusul di _tulis.
    _daftar = _daftar.where((Catatan c) => c.id != catatan.id).toList();
    notifyListeners();
    return _tulis(() => _repositori.hapus(catatan.id!));
  }

  Future<bool> pulihkan(Catatan catatan) {
    return _tulis(() => _repositori.pulihkan(catatan));
  }

  // [BARU]
  Future<bool> alihkanSemat(Catatan catatan) {
    return _tulis(() => _repositori.sematkan(catatan.id!, !catatan.disematkan));
  }

  // Menjalankan satu perintah tulis, lalu SELALU membaca ulang daftar
  // dari database, baik berhasil maupun gagal. Dengan begitu tampilan
  // selalu sama dengan isi database (sumber kebenaran).
  Future<bool> _tulis(Future<void> Function() perintah) async {
    bool berhasil = true;
    try {
      await perintah();
    } catch (galat) {
      debugPrint('Galat saat menulis ke database: $galat');
      berhasil = false;
    }
    await muat();
    return berhasil;
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    super.dispose();
  }
}

// ============================ VIEW ============================

String duaDigit(int angka) => angka.toString().padLeft(2, '0');

String formatWaktu(DateTime waktu) {
  return '${duaDigit(waktu.day)}/${duaDigit(waktu.month)}/${waktu.year} '
      '${duaDigit(waktu.hour)}.${duaDigit(waktu.minute)}';
}

class AplikasiCatatan extends StatelessWidget {
  const AplikasiCatatan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catatan Kuliah',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.dark,
        ),
      ),
      home: const HalamanCatatan(),
    );
  }
}

class HalamanCatatan extends StatelessWidget {
  const HalamanCatatan({super.key});

  Future<void> _bukaFormulir(BuildContext context, {Catatan? catatan}) async {
    final bool? tersimpan = await Navigator.push<bool>(
      context,
      MaterialPageRoute<bool>(
        builder: (BuildContext context) => HalamanFormCatatan(catatan: catatan),
      ),
    );
    if (!context.mounted) {
      return;
    }
    if (tersimpan == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            catatan == null ? 'Catatan ditambahkan.' : 'Catatan diperbarui.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // select: halaman ini hanya perlu tahu statusnya.
    final StatusMuat status = context.select(
      (CatatanViewModel vm) => vm.status,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Catatan Kuliah')),
      body: switch (status) {
        StatusMuat.memuat => const Center(child: CircularProgressIndicator()),
        StatusMuat.gagal => const Center(
          child: Text('Catatan gagal dibaca dari penyimpanan.'),
        ),
        StatusMuat.berhasil => IsiCatatan(
          onBuka: (Catatan catatan) => _bukaFormulir(context, catatan: catatan),
        ),
      },
      floatingActionButton: FloatingActionButton.extended(
        onPressed: status == StatusMuat.berhasil
            ? () => _bukaFormulir(context)
            : null,
        icon: const Icon(Icons.note_add),
        label: const Text('Catatan baru'),
      ),
    );
  }
}

class IsiCatatan extends StatelessWidget {
  const IsiCatatan({super.key, required this.onBuka});

  final ValueChanged<Catatan> onBuka;

  Future<void> _hapus(BuildContext context, Catatan catatan) async {
    // Diambil SEBELUM await, karena context bisa sudah tidak berlaku
    // setelah menunggu.
    final CatatanViewModel vm = context.read<CatatanViewModel>();
    final ScaffoldMessengerState pesan = ScaffoldMessenger.of(context);

    final bool berhasil = await vm.hapus(catatan);
    pesan.hideCurrentSnackBar();
    pesan.showSnackBar(
      SnackBar(
        content: Text(
          berhasil
              ? 'Catatan "${catatan.judul}" dihapus.'
              : 'Catatan gagal dihapus.',
        ),
        action: berhasil
            ? SnackBarAction(
                label: 'Urungkan',
                onPressed: () => vm.pulihkan(catatan),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CatatanViewModel vm = context.watch<CatatanViewModel>();
    final List<Catatan> daftar = vm.daftar;
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: SearchBar(
            hintText: 'Cari judul atau isi',
            leading: const Icon(Icons.search),
            onChanged: (String teks) {
              context.read<CatatanViewModel>().cari(teks);
            },
          ),
        ),
        Expanded(
          child: daftar.isEmpty
              ? Center(
                  child: Text(
                    vm.kataKunci.trim().isEmpty
                        ? 'Belum ada catatan.\nTekan "Catatan baru".'
                        : 'Tidak ada catatan yang cocok.',
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 88),
                  itemCount: daftar.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Catatan catatan = daftar[index];
                    return Dismissible(
                      key: ValueKey<int>(catatan.id!),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: warna.errorContainer,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 24),
                        child: Icon(
                          Icons.delete,
                          color: warna.onErrorContainer,
                        ),
                      ),
                      onDismissed: (_) => _hapus(context, catatan),
                      child: ListTile(
                        title: Text(
                          catatan.judul,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          '${catatan.isi}\n'
                          'Diubah ${formatWaktu(catatan.diubah)}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        isThreeLine: true,
                        // [BARU] Tombol sematkan/lepas sematan.
                        trailing: IconButton(
                          onPressed: () {
                            context.read<CatatanViewModel>().alihkanSemat(
                              catatan,
                            );
                          },
                          tooltip: catatan.disematkan
                              ? 'Lepas sematan'
                              : 'Sematkan',
                          icon: Icon(
                            catatan.disematkan
                                ? Icons.push_pin
                                : Icons.push_pin_outlined,
                            color: catatan.disematkan ? warna.primary : null,
                          ),
                        ),
                        onTap: () => onBuka(catatan),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class HalamanFormCatatan extends StatefulWidget {
  const HalamanFormCatatan({super.key, this.catatan});

  final Catatan? catatan; // null = membuat catatan baru

  @override
  State<HalamanFormCatatan> createState() => _HalamanFormCatatanState();
}

class _HalamanFormCatatanState extends State<HalamanFormCatatan> {
  final GlobalKey<FormState> _kunciForm = GlobalKey<FormState>();
  late final TextEditingController _kontrolJudul;
  late final TextEditingController _kontrolIsi;
  bool _menyimpan = false;

  @override
  void initState() {
    super.initState();
    // Saat mengubah catatan, kolom langsung terisi isi lamanya.
    _kontrolJudul = TextEditingController(text: widget.catatan?.judul ?? '');
    _kontrolIsi = TextEditingController(text: widget.catatan?.isi ?? '');
  }

  @override
  void dispose() {
    _kontrolJudul.dispose();
    _kontrolIsi.dispose();
    super.dispose();
  }

  String? _wajibDiisi(String? isi) {
    if ((isi ?? '').trim().isEmpty) {
      return 'Wajib diisi';
    }
    return null;
  }

  Future<void> _simpan() async {
    if (!_kunciForm.currentState!.validate()) {
      return;
    }
    setState(() => _menyimpan = true);
    final CatatanViewModel vm = context.read<CatatanViewModel>();
    final Catatan? lama = widget.catatan;
    final bool berhasil = lama == null
        ? await vm.tambah(_kontrolJudul.text, _kontrolIsi.text)
        : await vm.ubah(lama, _kontrolJudul.text, _kontrolIsi.text);
    if (!mounted) {
      return;
    }
    if (berhasil) {
      Navigator.pop(context, true);
    } else {
      setState(() => _menyimpan = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Catatan gagal disimpan.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.catatan == null ? 'Catatan Baru' : 'Ubah Catatan'),
      ),
      body: Form(
        key: _kunciForm,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _kontrolJudul,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Judul',
                border: OutlineInputBorder(),
              ),
              validator: _wajibDiisi,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _kontrolIsi,
              minLines: 5,
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: 'Isi catatan',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              validator: _wajibDiisi,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _menyimpan ? null : _simpan,
              icon: _menyimpan
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save),
              label: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================= PEMERIKSAAN =======================
// Memakai database di MEMORI: data catatan Anda yang sebenarnya tidak
// tersentuh, dan setiap kali dijalankan dimulai dari database kosong.

void periksa(String nama, Object? didapat, Object? diharapkan) {
  if (didapat == diharapkan) {
    debugPrint('LULUS  $nama');
  } else {
    debugPrint('GAGAL  $nama: diharapkan $diharapkan, hasilnya $didapat');
  }
}

// Struktur tabel versi 1 (sama dengan Contoh 05), untuk menguji migrasi.
const String sqlTabelVersi1 = '''
  CREATE TABLE catatan (
    id     INTEGER PRIMARY KEY AUTOINCREMENT,
    judul  TEXT NOT NULL,
    isi    TEXT NOT NULL,
    diubah INTEGER NOT NULL
  )
''';

Future<void> jalankanUji() async {
  // ---- 1. Migrasi: database versi 1 yang sudah berisi data ----
  final Database lama = await openDatabase(inMemoryDatabasePath);
  try {
    await lama.execute(sqlTabelVersi1);
    await lama.insert('catatan', {
      'judul': 'Catatan lama',
      'isi': 'Dibuat saat aplikasi masih versi 1',
      'diubah': 0,
    });
    // Inilah yang dilakukan sqflite saat versi 1 bertemu version: 2.
    await tingkatkanSkema(lama, 1, 2);
    final List<Map<String, Object?>> baris = await lama.query('catatan');
    periksa('Migrasi: catatan lama tetap ada', baris.length, 1);
    periksa('Migrasi: kolom baru bernilai 0', baris.first['disematkan'], 0);
    periksa(
      'Migrasi: baris lama terbaca sebagai Model',
      Catatan.dariBaris(baris.first).disematkan,
      false,
    );
  } catch (galat) {
    debugPrint('GAGAL  uji migrasi berhenti: $galat');
  } finally {
    await lama.close();
  }

  // ---- 2. Repository versi 2: catatan yang disematkan di atas ----
  final LayananBasisData layanan = LayananBasisData(
    namaBerkas: inMemoryDatabasePath,
  );
  final RepositoriCatatan repo = RepositoriCatatanSqlite(layanan: layanan);
  try {
    final Catatan a = await repo.tambah(judul: 'Normalisasi', isi: '1NF-3NF');
    final Catatan b = await repo.tambah(judul: 'Widget', isi: 'Stateless');
    List<Catatan> semua = await repo.ambilSemua();
    periksa('Tanpa sematan: terbaru di atas', semua.first.id, b.id);

    await repo.sematkan(a.id!, true);
    semua = await repo.ambilSemua();
    periksa('Yang disematkan di atas', semua.first.id, a.id);
    periksa('Status sematan tersimpan', semua.first.disematkan, true);

    await repo.sematkan(a.id!, false);
    semua = await repo.ambilSemua();
    periksa('Lepas sematan: urutan kembali', semua.first.id, b.id);
  } catch (galat) {
    debugPrint('GAGAL  pemeriksaan berhenti: $galat');
  } finally {
    await layanan.tutup();
  }
}

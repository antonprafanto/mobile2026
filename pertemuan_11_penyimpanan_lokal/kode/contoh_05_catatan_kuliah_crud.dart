// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 11: PENYIMPANAN LOKAL
// CONTOH 05: Catatan Kuliah: CRUD dengan SQLite + MVVM
// Topik: Aplikasi catatan yang datanya tersimpan di berkas database
//        catatan_kuliah.db. CRUD = Create (tambah), Read (baca),
//        Update (ubah), Delete (hapus). Pembagian tugasnya:
//        - LayananBasisData       : membuka database SEKALI dan membuat
//                                   tabel saat database pertama kali ada;
//        - RepositoriCatatanSqlite: SQL <-> Model (insert, query, update,
//                                   delete) dengan whereArgs;
//        - CatatanViewModel       : status, pencarian, dan perintah tulis.
//                                   Setelah menulis, daftar dibaca ulang
//                                   dari database (sumber kebenaran);
//        - View                   : daftar, cari, geser untuk menghapus
//                                   (bisa diurungkan), dan formulir.
//        Sebelum aplikasi tampil, jalankanUji() memeriksa repository
//        dengan database di MEMORI. Lihat hasilnya di konsol.
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
  });

  final int? id; // null = belum pernah disimpan ke database
  final String judul;
  final String isi;
  final DateTime diubah;

  Catatan copyWith({int? id, String? judul, String? isi, DateTime? diubah}) {
    return Catatan(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      isi: isi ?? this.isi,
      diubah: diubah ?? this.diubah,
    );
  }

  // Model -> baris tabel. SQLite tidak mengenal DateTime, jadi waktu
  // disimpan sebagai bilangan bulat (milidetik sejak 1 Januari 1970).
  Map<String, Object?> keBaris() {
    return {
      if (id != null) 'id': id, // id baru diisi otomatis oleh SQLite
      'judul': judul,
      'isi': isi,
      'diubah': diubah.millisecondsSinceEpoch,
    };
  }

  // Baris tabel -> Model, dengan pola Dart 3 (sama seperti fromJson
  // di Pertemuan 10).
  factory Catatan.dariBaris(Map<String, Object?> baris) {
    return switch (baris) {
      {
        'id': final int id,
        'judul': final String judul,
        'isi': final String isi,
        'diubah': final int diubah,
      } =>
        Catatan(
          id: id,
          judul: judul,
          isi: isi,
          diubah: DateTime.fromMillisecondsSinceEpoch(diubah),
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
      version: 1,
      // onCreate hanya dijalankan SEKALI, saat berkas database belum ada.
      onCreate: (Database db, int versi) async {
        await db.execute('''
          CREATE TABLE catatan (
            id     INTEGER PRIMARY KEY AUTOINCREMENT,
            judul  TEXT NOT NULL,
            isi    TEXT NOT NULL,
            diubah INTEGER NOT NULL
          )
        ''');
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

// ========================= REPOSITORY =========================

abstract class RepositoriCatatan {
  Future<List<Catatan>> ambilSemua({String kataKunci = ''});

  Future<Catatan> tambah({required String judul, required String isi});

  Future<void> ubah(Catatan catatan);

  Future<void> hapus(int id);

  // Menyimpan kembali catatan yang baru dihapus (tombol "Urungkan").
  Future<void> pulihkan(Catatan catatan);
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
      // Terbaru di atas. Jika waktunya sama persis, id terbesar di atas.
      orderBy: 'diubah DESC, id DESC',
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

Future<void> jalankanUji() async {
  final LayananBasisData layanan = LayananBasisData(
    namaBerkas: inMemoryDatabasePath,
  );
  final RepositoriCatatan repo = RepositoriCatatanSqlite(layanan: layanan);

  try {
    final Catatan a = await repo.tambah(
      judul: 'Normalisasi',
      isi: 'Bentuk normal 1NF sampai 3NF',
    );
    final Catatan b = await repo.tambah(
      judul: 'Widget',
      isi: 'Stateless dan Stateful',
    );
    periksa('Catatan pertama mendapat id 1', a.id, 1);
    periksa('Catatan kedua mendapat id 2', b.id, 2);

    List<Catatan> semua = await repo.ambilSemua();
    periksa('Ada 2 catatan', semua.length, 2);
    periksa('Yang terbaru di atas', semua.first.id, 2);

    final List<Catatan> hasilCari = await repo.ambilSemua(kataKunci: 'NORMAL');
    periksa('Cari tidak membedakan huruf besar', hasilCari.length, 1);

    final List<Catatan> kutip = await repo.ambilSemua(kataKunci: "Jum'at");
    periksa('Tanda kutip tidak merusak SQL', kutip.length, 0);

    await repo.ubah(
      a.copyWith(judul: 'Normalisasi Basis Data', diubah: DateTime(2030)),
    );
    semua = await repo.ambilSemua();
    periksa(
      'Yang diubah naik ke atas',
      semua.first.judul,
      'Normalisasi Basis Data',
    );

    await repo.hapus(b.id!);
    semua = await repo.ambilSemua();
    periksa('Tersisa 1 setelah dihapus', semua.length, 1);

    await repo.pulihkan(b);
    semua = await repo.ambilSemua();
    periksa('Kembali dengan id lamanya', semua.last.id, 2);

    final CatatanViewModel vm = CatatanViewModel(repositori: repo);
    await vm.muat();
    periksa('ViewModel: status berhasil', vm.status, StatusMuat.berhasil);
    await vm.cari('widget');
    periksa(
      'ViewModel: hasil pencarian',
      vm.daftar.map((Catatan c) => c.judul).join(', '),
      'Widget',
    );
    vm.dispose();
  } catch (galat) {
    debugPrint('GAGAL  pemeriksaan berhenti: $galat');
  } finally {
    await layanan.tutup();
  }
}

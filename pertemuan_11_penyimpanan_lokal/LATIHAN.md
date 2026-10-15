# ✍️ Latihan Pertemuan 11 — Penyimpanan Lokal

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md)

Kerjakan **tanpa membuka modul dan tanpa menjalankan kode** terlebih dahulu. Setelah selesai, buktikan jawaban Anda dengan menjalankan kodenya di proyek latihan (Chrome dengan `flutter run -d chrome --web-port=8080`, atau HP Android). Semua kode di bagian B dan C sudah berupa program utuh, jadi bisa langsung ditempel ke `lib/main.dart`. Paket yang dibutuhkan sama dengan [Jobsheet Pertemuan 11](JOBSHEET.md#persiapan-proyek-latihan-sekali-saja).

> [!NOTE]
> Kunci jawaban tidak dipublikasikan. Petunjuk (💡) menunjukkan **bagian modul** yang relevan. Pembahasan lengkap dilakukan bersama dosen di kelas.
>
> Hanya soal D1 dan D3 yang membutuhkan internet. Soal B5 tidak memakai paket apa pun, sehingga bisa juga dijalankan di [DartPad](https://dartpad.dev).

---

## A. Pilihan Ganda

**1.** Sebuah aplikasi menyimpan jumlah klik di variabel `int _jumlah`. Setelah pengguna menekan `R` (*hot restart*), angkanya kembali 0. Penyebabnya adalah ...

- a. nilai itu hanya tersimpan di memori, yang dikosongkan saat aplikasi dimulai ulang
- b. `setState` lupa dipanggil
- c. *hot restart* menghapus semua data di penyimpanan perangkat
- d. tipe `int` tidak bisa disimpan

**2.** Data yang **paling tepat** disimpan dengan `shared_preferences` adalah ...

- a. 500 transaksi keuangan yang perlu dijumlahkan per bulan
- b. token masuk (*login*) pengguna
- c. foto profil berukuran 2 MB
- d. pilihan mode gelap dan bahasa aplikasi

**3.** Aplikasi baru saja dipasang, lalu menjalankan `final int? n = await prefs.getInt('jumlah');`. Nilai `n` adalah ...

- a. `0`
- b. `null`
- c. `-1`
- d. *exception*, karena kuncinya belum ada

**4.** Kunci `mode` berisi teks `'gelap'`. Hasil `ThemeMode.values.asNameMap()['gelap']` adalah ...

- a. `ThemeMode.dark`
- b. `ThemeMode.system`
- c. `null`
- d. *exception*, karena nama itu tidak dikenal

**5.** `SharedPreferencesWithCache` dibuat di `main` sebelum `runApp`. Keuntungannya dibandingkan membaca dengan `SharedPreferencesAsync` di dalam halaman adalah ...

- a. nilai bisa dibaca tanpa `await` sejak layar pertama, sehingga tema tidak berkedip
- b. data otomatis dienkripsi
- c. data tidak hilang saat aplikasi dihapus
- d. tipe data `DateTime` bisa disimpan langsung

**6.** Mahasiswa menjalankan `flutter run -d chrome` (tanpa opsi lain) dua kali. Pada kali kedua, semua data yang tersimpan seolah-olah hilang. Penyebab yang paling mungkin adalah ...

- a. `shared_preferences` tidak berfungsi di Chrome
- b. data hanya tersimpan selama 24 jam
- c. `WidgetsFlutterBinding.ensureInitialized()` belum dipanggil
- d. *port*-nya berbeda setiap kali dijalankan, sehingga *browser* menganggapnya situs lain

**7.** Kolom `selesai` bertipe `bool` di Model akan disimpan di SQLite sebagai ...

- a. `BOOLEAN` berisi `true`/`false`
- b. `TEXT` berisi `'ya'`/`'tidak'`
- c. `INTEGER` berisi `1`/`0`
- d. `REAL` berisi `1.0`/`0.0`

**8.** `await db.update('tugas', {'selesai': 1}, where: 'id = ?', whereArgs: [99])` dijalankan, padahal tidak ada tugas dengan id 99. Hasilnya ...

- a. `DatabaseException`
- b. `0`
- c. `99`
- d. `null`

**9.** Alasan utama memakai `whereArgs` dan tanda `?`, bukan menempelkan nilai langsung ke teks SQL, adalah ...

- a. agar nilai apa pun (termasuk yang berisi tanda kutip) diperlakukan sebagai data, sehingga aman dari *SQL injection*
- b. agar *query* lebih singkat ditulis
- c. agar hasilnya otomatis terurut
- d. agar SQLite bisa membaca huruf kapital

**10.** `onCreate` di `openDatabase` dijalankan ...

- a. setiap kali aplikasi dibuka
- b. setiap kali `version` dinaikkan
- c. setiap kali tabel kosong
- d. hanya saat berkas database belum ada

**11.** Aplikasi versi lama sudah dipakai banyak orang. Kini tabel `catatan` butuh kolom baru. Cara yang benar adalah ...

- a. menambah kolom di `CREATE TABLE` saja
- b. menaikkan `version`, menambah kolom di `CREATE TABLE`, dan menambahkan `ALTER TABLE ... ADD COLUMN` di `onUpgrade`
- c. menghapus database setiap kali aplikasi dibuka
- d. meminta pengguna menghapus lalu memasang ulang aplikasi

**12.** Di dalam `db.transaction((txn) async { ... })`, perintah SQL harus dijalankan lewat ...

- a. `txn`; memakai `db` di dalamnya membuat aplikasi macet
- b. `db`, karena `txn` hanya untuk membaca
- c. `db` atau `txn`, sama saja
- d. `batch`, karena transaksi tidak bisa menjalankan `insert`

**13.** `txn.insert('cuaca', data, conflictAlgorithm: ConflictAlgorithm.replace)` dijalankan, padahal kunci utama baris itu sudah ada. Yang terjadi adalah ...

- a. `DatabaseException` karena kunci kembar
- b. baris lama dibiarkan dan baris baru diabaikan
- c. baris lama diganti dengan baris baru
- d. kedua baris disimpan

**14.** Pernyataan yang **benar** tentang *cache* data internet adalah ...

- a. *cache* adalah sumber data utama, sehingga tidak boleh hilang
- b. *cache* adalah salinan yang boleh hilang dan bisa basi, sehingga waktu pengambilannya perlu ditunjukkan
- c. *cache* hanya bisa disimpan di SQLite
- d. *cache* membuat aplikasi tidak perlu menangani galat jaringan

**15.** Token masuk (*login*) dari server sebaiknya disimpan dengan ...

- a. `shared_preferences`, karena kecil
- b. tabel SQLite biasa
- c. `flutter_secure_storage`
- d. variabel global

---

## B. Tebak Hasil

**B1.** Program berikut dijalankan **tiga kali** berturut-turut di Chrome dengan `flutter run -d chrome --web-port=8099` (port yang belum pernah Anda pakai, agar penyimpanannya masih kosong). Di antara setiap percobaan, aplikasi dihentikan dengan `q`. Pengguna HP Android: hapus dulu data aplikasi proyek latihan Anda, lalu jalankan tiga kali.

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Tema { terang, gelap, sistem }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  final int buka = (await prefs.getInt('buka') ?? 0) + 1;
  await prefs.setInt('buka', buka);
  debugPrint('1: dibuka $buka kali');

  final String? nama = await prefs.getString('nama');
  debugPrint('2: halo ${nama ?? 'tamu'}');
  if (nama == null) {
    await prefs.setString('nama', 'Rina');
  } else {
    await prefs.remove('nama');
  }

  final String? tema = await prefs.getString('tema');
  final Tema? pilihan = Tema.values.asNameMap()[tema];
  debugPrint('3: tema ${pilihan?.name ?? 'bawaan'}');
  await prefs.setString('tema', buka == 1 ? 'Gelap' : 'gelap');

  final List<String> lama = await prefs.getStringList('riwayat') ?? [];
  final List<String> baru = ['buka-$buka', ...lama].take(2).toList();
  await prefs.setStringList('riwayat', baru);
  debugPrint('4: ${baru.join(', ')}');

  runApp(
    const MaterialApp(
      home: Scaffold(body: Center(child: Text('Lihat konsol'))),
    ),
  );
}
```

- (a) Tuliskan empat baris yang tampil di konsol pada setiap percobaan (pertama, kedua, dan ketiga).
- (b) Pada percobaan kedua, baris `3:` belum menampilkan `gelap`. Mengapa?
- (c) Setelah percobaan ketiga, program dijalankan dengan `--web-port=8100`. Apa yang tampil, dan mengapa?

**B2.** Tuliskan tujuh baris yang tampil di konsol.

```dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  final Database db = await openDatabase(inMemoryDatabasePath);
  await db.execute('''
    CREATE TABLE buku (
      id       INTEGER PRIMARY KEY AUTOINCREMENT,
      judul    TEXT NOT NULL UNIQUE,
      tahun    INTEGER,
      dipinjam INTEGER NOT NULL DEFAULT 0
    )
  ''');

  final int a = await db.insert('buku', {'judul': 'Dasar Dart', 'tahun': 2024});
  final int b = await db.insert('buku', {
    'judul': 'Flutter Pemula',
    'tahun': 2026,
  });
  final int c = await db.insert('buku', {'judul': 'Basis Data', 'tahun': null});
  debugPrint('1: $a $b $c');

  final int dipinjam = await db.update(
    'buku',
    {'dipinjam': 1},
    where: 'tahun >= ?',
    whereArgs: [2025],
  );
  debugPrint('2: $dipinjam');

  final List<Map<String, Object?>> urut = await db.query(
    'buku',
    columns: ['judul'],
    orderBy: 'tahun DESC',
  );
  final List<Object?> judul = [
    for (final Map<String, Object?> baris in urut) baris['judul'],
  ];
  debugPrint('3: ${judul.join(' | ')}');

  final int terhapus = await db.delete(
    'buku',
    where: 'judul LIKE ?',
    whereArgs: ['%dart%'],
  );
  debugPrint('4: $terhapus');

  final int d = await db.insert('buku', {
    'judul': 'Pemrograman Web',
    'tahun': 2025,
  });
  debugPrint('5: $d');

  try {
    await db.insert('buku', {'judul': 'Basis Data', 'tahun': 2020});
    debugPrint('6: tersimpan');
  } on DatabaseException catch (galat) {
    debugPrint('6: ditolak ${galat.isUniqueConstraintError()}');
  }

  final int? belumDipinjam = Sqflite.firstIntValue(
    await db.rawQuery('SELECT COUNT(*) FROM buku WHERE dipinjam = 0'),
  );
  debugPrint('7: $belumDipinjam');
  await db.close();

  runApp(
    const MaterialApp(
      home: Scaffold(body: Center(child: Text('Lihat konsol'))),
    ),
  );
}
```

- (a) Tuliskan ketujuh baris itu.
- (b) Mengapa `Basis Data` berada di urutan terakhir pada baris `3:`?
- (c) Mengapa baris `5:` tidak bernilai `1`, padahal buku dengan id 1 sudah dihapus?

**B3.** Program berikut membuka berkas database yang **sama** lima kali dengan nomor versi yang berbeda-beda.

```dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

const String namaBerkas = 'latihan_b3.db';

Future<void> buka(int versi) async {
  final Database db = await openDatabase(
    namaBerkas,
    version: versi,
    onCreate: (Database _, int versiBaru) async {
      debugPrint('onCreate($versiBaru)');
    },
    onUpgrade: (Database _, int lama, int baru) async {
      debugPrint('onUpgrade($lama -> $baru)');
      if (lama < 2) {
        debugPrint('  langkah ke-2');
      }
      if (lama < 3) {
        debugPrint('  langkah ke-3');
      }
    },
    onDowngrade: (Database _, int lama, int baru) async {
      debugPrint('onDowngrade($lama -> $baru)');
    },
  );
  debugPrint('terbuka di versi ${await db.getVersion()}');
  await db.close();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  await deleteDatabase(namaBerkas); // selalu mulai dari nol

  debugPrint('--- A ---');
  await buka(1);
  debugPrint('--- B ---');
  await buka(1);
  debugPrint('--- C ---');
  await buka(3);
  debugPrint('--- D ---');
  await buka(2);
  debugPrint('--- E ---');
  await buka(3);

  runApp(
    const MaterialApp(
      home: Scaffold(body: Center(child: Text('Lihat konsol'))),
    ),
  );
}
```

- (a) Tuliskan semua baris yang tampil di konsol, dari `--- A ---` sampai akhir.
- (b) Mengapa pada bagian **C** kedua langkah dijalankan, sedangkan pada bagian **E** hanya satu?
- (c) Bagian **D** menunjukkan aplikasi yang lebih lama membuka database milik aplikasi yang lebih baru. Mengapa keadaan ini sebaiknya dihindari?

**B4.** Keempat bagian (A–D) memasukkan daftar NIM yang sama, `['001', '002', '002', '003']`, ke tabel yang kolom `nim`-nya `UNIQUE`.

```dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

const List<String> daftarNim = ['001', '002', '002', '003'];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  final Database db = await openDatabase(inMemoryDatabasePath);
  await db.execute(
    'CREATE TABLE peserta (id INTEGER PRIMARY KEY, nim TEXT NOT NULL UNIQUE)',
  );

  Future<int> jumlah() async {
    return Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM peserta'),
        ) ??
        0;
  }

  // A: satu per satu, tanpa transaksi
  try {
    for (final String nim in daftarNim) {
      await db.insert('peserta', {'nim': nim});
    }
  } on DatabaseException {
    debugPrint('A: gagal');
  }
  debugPrint('A: ${await jumlah()}');

  await db.delete('peserta');

  // B: satu per satu, di dalam transaksi
  try {
    await db.transaction((Transaction txn) async {
      for (final String nim in daftarNim) {
        await txn.insert('peserta', {'nim': nim});
      }
    });
  } on DatabaseException {
    debugPrint('B: gagal');
  }
  debugPrint('B: ${await jumlah()}');

  // C: batch dengan ConflictAlgorithm.ignore
  final Batch batch = db.batch();
  for (final String nim in daftarNim) {
    batch.insert('peserta', {
      'nim': nim,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }
  await batch.commit(noResult: true);
  debugPrint('C: ${await jumlah()}');

  // D: replace pada id yang sudah ada
  await db.insert('peserta', {
    'id': 1,
    'nim': '009',
  }, conflictAlgorithm: ConflictAlgorithm.replace);
  final List<Map<String, Object?>> isi = await db.query(
    'peserta',
    orderBy: 'id',
  );
  debugPrint('D: ${isi.map((Map<String, Object?> p) => p['nim']).join(', ')}');
  await db.close();

  runApp(
    const MaterialApp(
      home: Scaffold(body: Center(child: Text('Lihat konsol'))),
    ),
  );
}
```

- (a) Tuliskan semua baris yang tampil di konsol.
- (b) Mengapa hasil bagian A dan B berbeda, padahal datanya sama?
- (c) Di bagian C, id ketiga NIM kembali dimulai dari 1. Mengapa berbeda dengan Contoh 04 di modul, yang tidak memakai ulang id yang sudah dihapus?
- (d) Setelah bagian D, ditambahkan satu perintah lagi: `db.insert('peserta', {'id': 7, 'nim': '002'}, conflictAlgorithm: ConflictAlgorithm.replace)`. Baris mana yang hilang, dan apa isi tabel sesudahnya?

**B5.** Program berikut meniru dua strategi *cache* dari modul dengan server dan *cache* palsu. Setiap panggilan ke server butuh 100 milidetik.

```dart
import 'package:flutter/foundation.dart';

class ServerPalsu {
  bool hidup = true;
  int panggilan = 0;

  Future<String> ambil() async {
    panggilan++;
    final int nomor = panggilan;
    await Future<void>.delayed(const Duration(milliseconds: 100));
    if (!hidup) {
      throw Exception('server mati');
    }
    return 'data-$nomor';
  }
}

class CachePalsu {
  String? isi;
}

// Strategi 1: server dulu, salinan sebagai cadangan.
Future<String> cadangan(ServerPalsu server, CachePalsu cache) async {
  try {
    final String data = await server.ambil();
    cache.isi = data;
    return data;
  } catch (galat) {
    final String? salinan = cache.isi;
    if (salinan == null) {
      rethrow;
    }
    return '$salinan (salinan)';
  }
}

// Strategi 2: salinan dulu, lalu server.
Stream<String> lokalDulu(ServerPalsu server, CachePalsu cache) async* {
  final String? salinan = cache.isi;
  if (salinan != null) {
    yield '$salinan (salinan)';
  }
  final String data = await server.ambil();
  cache.isi = data;
  yield data;
}

Future<void> main() async {
  final ServerPalsu server = ServerPalsu();
  final CachePalsu cache = CachePalsu();

  debugPrint('1: ${await cadangan(server, cache)}');

  server.hidup = false;
  debugPrint('2: ${await cadangan(server, cache)}');

  try {
    await for (final String data in lokalDulu(server, cache)) {
      debugPrint('3: $data');
    }
  } catch (galat) {
    debugPrint('3: galat');
  }

  server.hidup = true;
  await for (final String data in lokalDulu(server, cache)) {
    debugPrint('4: $data');
  }

  server.hidup = false;
  try {
    debugPrint('5: ${await cadangan(server, CachePalsu())}');
  } catch (galat) {
    debugPrint('5: galat');
  }

  debugPrint('6: ${server.panggilan} kali');
}
```

- (a) Tuliskan semua baris yang tampil di konsol.
- (b) Bagian `3:` dan `5:` sama-sama terjadi saat server mati, tetapi hasilnya berbeda. Mengapa?
- (c) Pada bagian `4:`, data apa yang dilihat pengguna lebih dulu, dan berapa lama ia harus menunggu data terbaru?

<details>
<summary>💡 Petunjuk Bagian B</summary>

B1: Bagian 2.3–2.5 dan 3.2; perhatikan huruf besar pada teks yang disimpan di percobaan pertama. B2: Bagian 6.2–6.4; di SQLite, `NULL` dianggap lebih kecil daripada nilai apa pun, dan `LIKE` tidak membedakan huruf besar dan kecil. B3: Bagian 8.2–8.3. B4: Bagian 9.2–9.4 dan 11.3; bandingkan `INTEGER PRIMARY KEY` dengan `INTEGER PRIMARY KEY AUTOINCREMENT`. B5: Bagian 10.2 dan 11.2; hitung panggilan server satu per satu.
</details>

---

## C. Temukan dan Perbaiki Kesalahannya

Setiap kode berikut mengandung **dua** kesalahan. Untuk setiap kesalahan, jelaskan **pesan atau gejalanya**, **penyebabnya**, dan **perbaikannya**.

**C1.** Isi nama dan usia, tekan **Simpan**, lalu hentikan aplikasi dan jalankan lagi (port yang sama). Formulir kembali kosong dan judulnya kembali "Halo!". Konsol juga menampilkan galat berwarna merah.

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      home: const HalamanKartuNama(),
    ),
  );
}

class HalamanKartuNama extends StatefulWidget {
  const HalamanKartuNama({super.key});

  @override
  State<HalamanKartuNama> createState() => _HalamanKartuNamaState();
}

class _HalamanKartuNamaState extends State<HalamanKartuNama> {
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();
  final TextEditingController _kontrolNama = TextEditingController();
  final TextEditingController _kontrolUsia = TextEditingController();
  String _sapaan = 'Halo!';

  @override
  void initState() {
    super.initState();
    _muat();
  }

  @override
  void dispose() {
    _kontrolNama.dispose();
    _kontrolUsia.dispose();
    super.dispose();
  }

  Future<void> _muat() async {
    final String? nama = await _prefs.getString('nama_penguna');
    final int? usia = await _prefs.getInt('usia');
    if (!mounted) {
      return;
    }
    setState(() {
      _kontrolNama.text = nama ?? '';
      _kontrolUsia.text = usia == null ? '' : '$usia';
      _sapaan = nama == null ? 'Halo!' : 'Halo, $nama!';
    });
  }

  Future<void> _simpan() async {
    final String nama = _kontrolNama.text.trim();
    await _prefs.setString('nama_pengguna', nama);
    await _prefs.setString('usia', _kontrolUsia.text.trim());
    if (!mounted) {
      return;
    }
    setState(() => _sapaan = 'Halo, $nama!');
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Tersimpan.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_sapaan)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _kontrolNama,
            decoration: const InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _kontrolUsia,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Usia',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _simpan,
            icon: const Icon(Icons.save),
            label: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
```

**C2.** Ketik `Jum` di kotak pencarian: kontak "Jum'at Hidayat" tampil. Lanjutkan mengetik tanda kutip (`Jum'`): daftar tidak berubah lagi dan konsol menampilkan galat merah. Setelah kesalahan pertama diperbaiki, ketuk bintang pada **satu** kontak: **semua** kontak menjadi favorit.

```dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() {
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const HalamanKontak(),
    ),
  );
}

class Kontak {
  const Kontak({
    required this.id,
    required this.nama,
    required this.telepon,
    required this.favorit,
  });

  final int id;
  final String nama;
  final String telepon;
  final bool favorit;

  factory Kontak.dariBaris(Map<String, Object?> baris) {
    return switch (baris) {
      {
        'id': final int id,
        'nama': final String nama,
        'telepon': final String telepon,
        'favorit': final int favorit,
      } =>
        Kontak(id: id, nama: nama, telepon: telepon, favorit: favorit == 1),
      _ => throw FormatException('Baris kontak tidak sesuai: $baris'),
    };
  }
}

const List<Map<String, Object?>> kontakAwal = [
  {'nama': 'Andi Pratama', 'telepon': '0812-1111-2222'},
  {'nama': "Jum'at Hidayat", 'telepon': '0813-3333-4444'},
  {'nama': 'Siti Rahma', 'telepon': '0815-5555-6666'},
  {'nama': 'Yohanes Bria', 'telepon': '0817-7777-8888'},
];

// Agar ringkas, database dipakai langsung dari halaman (tanpa layanan dan
// repository). Hal itu bukan kesalahan yang dicari.
Future<Database> bukaDatabase() {
  return openDatabase(
    'buku_kontak.db',
    version: 1,
    onCreate: (Database db, int versi) async {
      await db.execute('''
        CREATE TABLE kontak (
          id      INTEGER PRIMARY KEY AUTOINCREMENT,
          nama    TEXT NOT NULL,
          telepon TEXT NOT NULL,
          favorit INTEGER NOT NULL DEFAULT 0
        )
      ''');
      final Batch batch = db.batch();
      for (final Map<String, Object?> kontak in kontakAwal) {
        batch.insert('kontak', kontak);
      }
      await batch.commit(noResult: true);
    },
  );
}

class HalamanKontak extends StatefulWidget {
  const HalamanKontak({super.key});

  @override
  State<HalamanKontak> createState() => _HalamanKontakState();
}

class _HalamanKontakState extends State<HalamanKontak> {
  final Future<Database> _database = bukaDatabase();
  List<Kontak> _daftar = [];
  String _kataKunci = '';

  @override
  void initState() {
    super.initState();
    _muat();
  }

  Future<void> _muat() async {
    final Database db = await _database;
    final List<Map<String, Object?>> baris = await db.rawQuery(
      "SELECT * FROM kontak WHERE nama LIKE '%$_kataKunci%' "
      'ORDER BY favorit DESC, nama',
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _daftar = baris.map(Kontak.dariBaris).toList();
    });
  }

  Future<void> _alihkanFavorit(Kontak kontak) async {
    final Database db = await _database;
    await db.update('kontak', {'favorit': kontak.favorit ? 0 : 1});
    await _muat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buku Kontak')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              hintText: 'Cari nama',
              leading: const Icon(Icons.search),
              onChanged: (String teks) {
                _kataKunci = teks;
                _muat();
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _daftar.length,
              itemBuilder: (BuildContext context, int index) {
                final Kontak kontak = _daftar[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(kontak.nama[0])),
                  title: Text(kontak.nama),
                  subtitle: Text(kontak.telepon),
                  trailing: IconButton(
                    onPressed: () => _alihkanFavorit(kontak),
                    tooltip: 'Favorit',
                    icon: Icon(kontak.favorit ? Icons.star : Icons.star_border),
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
```

**C3.** Ketik sebuah kegiatan lalu tekan tombol **+**: lingkaran di tombol berputar terus tanpa henti, dan sekitar 10 detik kemudian konsol menampilkan peringatan bahwa database terkunci. Setelah kesalahan pertama diperbaiki, geser sebuah kegiatan untuk menghapusnya: layar menampilkan *error* merah.

```dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() {
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const HalamanJurnal(),
    ),
  );
}

// Agar ringkas, database dipakai langsung dari halaman (tanpa layanan dan
// repository). Hal itu bukan kesalahan yang dicari.
Future<Database> bukaDatabase() {
  return openDatabase(
    'jurnal_ukm.db',
    version: 1,
    onCreate: (Database db, int versi) async {
      await db.execute('''
        CREATE TABLE kegiatan (
          id    INTEGER PRIMARY KEY AUTOINCREMENT,
          judul TEXT NOT NULL,
          waktu INTEGER NOT NULL
        )
      ''');
      // Satu baris saja: jumlah kegiatan yang pernah dicatat.
      await db.execute(
        'CREATE TABLE statistik (id INTEGER PRIMARY KEY, total INTEGER)',
      );
      await db.insert('statistik', {'id': 1, 'total': 0});
    },
  );
}

class HalamanJurnal extends StatefulWidget {
  const HalamanJurnal({super.key});

  @override
  State<HalamanJurnal> createState() => _HalamanJurnalState();
}

class _HalamanJurnalState extends State<HalamanJurnal> {
  final Future<Database> _database = bukaDatabase();
  final TextEditingController _kontrolJudul = TextEditingController();
  List<Map<String, Object?>> _daftar = [];
  int _total = 0;
  bool _menyimpan = false;

  @override
  void initState() {
    super.initState();
    _muat();
  }

  @override
  void dispose() {
    _kontrolJudul.dispose();
    super.dispose();
  }

  Future<void> _muat() async {
    final Database db = await _database;
    final List<Map<String, Object?>> daftar = await db.query(
      'kegiatan',
      orderBy: 'id DESC',
    );
    final int? total = Sqflite.firstIntValue(
      await db.rawQuery('SELECT total FROM statistik WHERE id = 1'),
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _daftar = daftar;
      _total = total ?? 0;
    });
  }

  Future<void> _simpan() async {
    final String judul = _kontrolJudul.text.trim();
    if (judul.isEmpty) {
      return;
    }
    setState(() => _menyimpan = true);
    final Database db = await _database;
    // Kegiatan dan statistik harus berubah bersama-sama.
    await db.transaction((Transaction txn) async {
      await txn.insert('kegiatan', {
        'judul': judul,
        'waktu': DateTime.now().millisecondsSinceEpoch,
      });
      await db.rawUpdate('UPDATE statistik SET total = total + 1 WHERE id = 1');
    });
    _kontrolJudul.clear();
    await _muat();
    if (mounted) {
      setState(() => _menyimpan = false);
    }
  }

  Future<void> _hapus(int id) async {
    final Database db = await _database;
    await db.delete('kegiatan', where: 'id = ?', whereArgs: [id]);
    await _muat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jurnal UKM · $_total tercatat')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _kontrolJudul,
                    decoration: const InputDecoration(
                      labelText: 'Kegiatan',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _menyimpan ? null : _simpan,
                  tooltip: 'Simpan',
                  icon: _menyimpan
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _daftar.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, Object?> kegiatan = _daftar[index];
                final int id = kegiatan['id'] as int;
                return Dismissible(
                  key: ValueKey<int>(id),
                  onDismissed: (_) => _hapus(id),
                  background: Container(color: Colors.red),
                  child: ListTile(
                    leading: const Icon(Icons.event_note),
                    title: Text(kegiatan['judul'] as String),
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
```

<details>
<summary>💡 Petunjuk Bagian C</summary>

C1: Bagian 2.3 dan 2.5 (perhatikan nama kunci dan tipe yang dipakai saat menyimpan dan membaca). Setelah memperbaiki, data lama yang terlanjur tersimpan dengan tipe yang salah perlu dihapus ([Bagian 12.3](README.md#123-menghapus-data-selama-pengembangan)). C2: Bagian 6.2 dan 6.6. C3: Bagian 9.2 dan 7.5.
</details>

---

## D. Menulis Program

Kerjakan setiap soal sebagai **aplikasi utuh** yang bisa dijalankan. Semua akses penyimpanan melalui *repository* (kontrak + implementasi), nilai dari pengguna masuk ke SQL lewat `whereArgs`, dan setiap aplikasi punya fungsi `jalankanUji()` yang dijalankan sebelum `runApp` tanpa menyentuh data asli.

**D1 — Riwayat Pencarian Resep.** Buat aplikasi pencarian resep dari `https://dummyjson.com/recipes/search?q=...` (Pertemuan 10) yang **mengingat** kata kunci yang pernah dicari:

- Riwayat disimpan dengan `shared_preferences` sebagai `List<String>`: paling banyak **8** kata kunci, yang terbaru di depan, tanpa kembar (`Nasi` dan `nasi` dianggap sama; yang lebih baru menggantikan yang lama), dan kata kunci kosong tidak disimpan.
- Saat kotak pencarian kosong, tampilkan daftar riwayat. Mengetuk sebuah riwayat menjalankan pencarian itu lagi; menggesernya menghapus kata kunci itu saja; tombol **Hapus semua** (dengan konfirmasi) mengosongkan riwayat.
- Hasil pencarian menampilkan nama resep, gambar kecil, dan waktu memasak, lengkap dengan tampilan memuat dan gagal yang ramah.
- `jalankanUji()` memeriksa logika riwayat memakai penyimpanan versi **memori**, minimal **6** pemeriksaan: urutan, batas 8, tidak kembar tanpa membedakan huruf besar, kata kosong ditolak, hapus satu, dan hapus semua.

<details>
<summary>💡 Petunjuk D1</summary>

Pisahkan logika riwayat (aturan urutan, batas, dan kembar) dari penyimpanannya: buat kontrak kecil seperti `PenyimpananTeks` di Contoh 08 (Bagian 10.5), sehingga pemeriksaan bisa memakai versi memori. Untuk pencarian, ikuti Contoh 07 Pertemuan 10 (*debounce* dan nomor permintaan). Simpan kata kunci ke riwayat saat pencarian benar-benar dijalankan, bukan pada setiap huruf.
</details>

**D2 — Daftar Bacaan.** Buat aplikasi pencatat buku yang sedang dan ingin dibaca, dengan SQLite:

- Tabel `buku`: `id`, `judul`, `penulis`, `halaman` (`CHECK (halaman > 0)`), `dibaca` (halaman yang sudah dibaca, `CHECK (dibaca >= 0 AND dibaca <= halaman)`), dan `status` (`'ingin'`, `'membaca'`, atau `'selesai'`, nama *enum*).
- Daftar dikelompokkan dengan `ChoiceChip` per status; saringannya dikerjakan oleh SQL. Setiap buku menampilkan bilah kemajuan dan persentase.
- Memperbarui halaman yang sudah dibaca lewat dialog. Jika halaman terakhir tercapai, status otomatis menjadi `'selesai'` dalam **satu** perintah `update` yang sama.
- Ringkasan di atas daftar, dihitung dengan SQL: jumlah buku per status dan total halaman yang sudah dibaca.
- **Migrasi versi 2:** kolom `nilai` (1–5, boleh `NULL`) yang hanya bisa diisi untuk buku berstatus selesai; tampilkan sebagai bintang.
- `jalankanUji()` dengan `inMemoryDatabasePath`, minimal **7** pemeriksaan, termasuk aturan `CHECK` yang menolak halaman dibaca melebihi jumlah halaman dan migrasi dari versi 1.

<details>
<summary>💡 Petunjuk D2</summary>

Ikuti Praktikum 3–4 di Jobsheet dan Contoh 06 (Bagian 8). Untuk ringkasan per status, satu *query* `SELECT status, COUNT(*) AS jumlah FROM buku GROUP BY status` sudah cukup. Tangkap `DatabaseException` dari aturan `CHECK` di *repository*, lalu terjemahkan menjadi pesan yang ramah.
</details>

**D3 — Kutipan Harian Luring.** Buat aplikasi "satu kutipan setiap hari" dari `https://dummyjson.com/quotes/random`:

- Kutipan hari ini disimpan **bersama tanggalnya**. Selama tanggalnya masih hari ini, aplikasi menampilkan kutipan tersimpan tanpa menghubungi server, termasuk saat luring. Saat hari berganti, kutipan baru diambil. Jika gagal, kutipan terakhir tetap tampil dengan spanduk yang menyebut tanggalnya.
- Tombol **Kutipan lain** mengambil kutipan baru (butuh internet) dan menggantikan kutipan hari ini.
- Kutipan bisa disimpan sebagai **favorit** di tabel SQLite (`id_kutipan` `UNIQUE`; menyimpan dua kali tidak menimbulkan galat), dibuka di halaman tersendiri, dan dihapus dengan geser lengkap dengan **Urungkan**. Halaman favorit tetap berfungsi tanpa internet.
- `jalankanUji()` memakai `MockClient`, penyimpanan memori untuk kutipan harian, dan `inMemoryDatabasePath` untuk favorit, minimal **6** pemeriksaan, termasuk "tanggal masih sama → server tidak dipanggil" dan "favorit kembar tidak tersimpan dua kali".

<details>
<summary>💡 Petunjuk D3</summary>

Gabungkan Contoh 08 (Bagian 10: satu teks JSON berisi isi dan waktu) dengan Praktikum 4 di Jobsheet (`ConflictAlgorithm.ignore`). Agar pemeriksaan "tanggal masih sama" dan "hari berganti" bisa diuji tanpa menunggu besok, berikan fungsi penentu tanggal lewat *constructor* (misalnya `String Function() hariIni`), lalu di pemeriksaan isi dengan tanggal palsu. Hitung berapa kali `MockClient` dipanggil untuk membuktikan server tidak dihubungi.
</details>

---

[⬅️ Kembali ke Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md) · [🏠 Beranda](../README.md)

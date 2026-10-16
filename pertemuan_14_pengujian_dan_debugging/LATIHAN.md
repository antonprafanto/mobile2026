# ✍️ Latihan Pertemuan 14 — Pengujian & *Debugging*

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md)

Kerjakan **tanpa membuka modul dan tanpa menjalankan kode** terlebih dahulu. Setelah selesai, buktikan jawaban Anda dengan menjalankan kodenya. Semua kode di bagian B dan C sudah berupa berkas utuh.

| Soal | Jenis berkas | Tempat menjalankan |
| :--- | :--- | :--- |
| B1–B3 dan C1 | Tes unit | Folder `test/` proyek latihan, lalu `flutter test test/nama_berkas_test.dart`. Bisa juga di [DartPad](https://dartpad.dev): tempel, lalu **Run**; hasil tes tampil di konsol |
| B4 | Program konsol | DartPad, atau `lib/main.dart` proyek latihan lalu `flutter run -d chrome`. Hasilnya tampil di konsol |
| B5 dan C2 | Tes widget | **Hanya** `flutter test` di laptop, karena DartPad tidak bisa menjalankan tes widget ([Modul Bagian 6.6](README.md#66-mengapa-tes-widget-tidak-dijalankan-di-dartpad)) |
| C3 | Aplikasi | DartPad, atau `lib/main.dart` proyek latihan lalu `flutter run -d chrome` |
| D1–D3 | Kode aplikasi + tes buatan Anda | Proyek di laptop, dijalankan dengan `flutter test` |

**Proyek latihan.** Satu proyek cukup untuk semua soal B, C, dan D1:

```bash
flutter create latihan_p14
cd latihan_p14
```

Proyek baru sudah berisi `flutter_test` di `dev_dependencies`, jadi tidak perlu menambah paket. Hapus `test/widget_test.dart` bawaan: berkas itu menguji aplikasi penghitung bawaan dan akan rusak begitu `lib/main.dart` Anda ganti. Berkas tes harus berada di folder `test/` dan namanya berakhiran **`_test.dart`**, misalnya `test/b1_tarif_parkir_test.dart`.

> [!NOTE]
> Kunci jawaban tidak dipublikasikan. Petunjuk (💡) menunjukkan **bagian modul** yang relevan. Pembahasan lengkap dilakukan bersama dosen di kelas.
>
> Tarif, aturan nilai, nama, dan data dalam soal hanyalah **rekaan** untuk latihan.

---

## A. Pilihan Ganda

**1.** Agar ditemukan dan dijalankan oleh `flutter test`, berkas tes untuk aturan kas sebaiknya disimpan sebagai ...

- a. `lib/kas_test.dart`
- b. `test/tes_kas.dart`
- c. `test/kas_test.dart`
- d. `lib/test/kas.dart`

**2.** Tim ingin memastikan tombol **Simpan** mati selama data dikirim, tanpa membuka emulator atau HP. Jenis tes yang paling tepat adalah ...

- a. tes unit, karena tombol hanyalah sebuah fungsi
- b. tes widget, karena tombol harus digambar dan diketuk, tetapi cukup di lingkungan uji tanpa perangkat
- c. tes integrasi, karena hanya tes integrasi yang bisa mengetuk tombol
- d. tidak bisa diuji otomatis; harus dicoba dengan tangan

**3.** Aturan kantin: "diskon 10% untuk belanja **paling sedikit** Rp50.000". Pasangan data uji yang paling berguna untuk menangkap tertukarnya `>` dengan `>=` adalah ...

- a. Rp10.000 dan Rp100.000
- b. Rp0 dan Rp1.000.000
- c. Rp50.000 dan Rp49.999
- d. Rp75.000 saja, karena sudah pasti mendapat diskon

**4.** `expect(rataRata([1, 2, 2]), 1.67)` gagal dengan `Actual: <1.6666666666666667>`. Perbaikan **tes** yang paling tepat adalah ...

- a. `expect(rataRata([1, 2, 2]), closeTo(1.67, 0.01))`
- b. `expect(rataRata([1, 2, 2]), 1.6666666666666667)`
- c. `expect(rataRata([1, 2, 2]).toString(), '1.67')`
- d. menghapus tes ini, karena hasil desimal memang tidak bisa diuji

**5.** Setelah menemukan bug, mengapa kita dianjurkan menulis tesnya **dan melihatnya merah** sebelum memperbaiki kode?

- a. Agar ringkasan `flutter test` terlihat lebih panjang
- b. Karena `flutter test` menolak menjalankan tes yang belum pernah gagal
- c. Agar bug-nya hilang dengan sendirinya
- d. Untuk membuktikan bahwa tes itu benar-benar bisa menangkap bug tersebut; tes yang belum pernah merah belum terbukti bisa menangkap apa pun

**6.** Sebuah tes lulus jika dijalankan **sendirian**, tetapi gagal jika dijalankan **bersama** tes lain di berkas yang sama. Penyebab yang paling mungkin adalah ...

- a. objek yang diuji dibuat sekali saja di luar `setUp`, sehingga perubahan dari tes sebelumnya terbawa; buat objek baru di `setUp`
- b. laptop kekurangan RAM
- c. nama tesnya terlalu panjang
- d. `flutter test` menjalankan tes secara acak setiap kali

**7.** Mengapa ViewModel diuji dengan *repository* **palsu**, bukan *repository* yang benar-benar menghubungi server?

- a. Karena *repository* asli tidak boleh di-*import* di folder `test/`
- b. Agar aplikasi yang dirilis memakai data palsu
- c. Karena ViewModel tidak bisa memakai *repository* asli
- d. Agar tes cepat, tidak bergantung pada internet, dan setiap keadaan (gagal, lambat, kosong) bisa dibuat sesuka tes

**8.** Di tes widget, `await tester.pump(const Duration(seconds: 30));` ...

- a. benar-benar menunggu 30 detik, sehingga tes terasa lambat
- b. ditolak karena tes widget paling lama 10 detik
- c. selesai seketika: jam palsu dimajukan 30 detik, *timer* yang jatuh tempo dijalankan, lalu satu gambar digambar
- d. sama persis dengan `pumpAndSettle()`

**9.** Semua tes widget hijau, tetapi di HP selebar 360 piksel dengan huruf besar muncul pita kuning-hitam. Mengapa tes tidak menangkapnya, dan apa perbaikannya?

- a. Tes widget memang tidak bisa memeriksa tata letak
- b. Layar uji bawaan berukuran 800 × 600 dengan huruf normal; tambahkan tes yang mengatur `tester.view.physicalSize` dan ukuran huruf
- c. Pita kuning-hitam hanya muncul di iPhone
- d. Tesnya kurang `pumpAndSettle()`

**10.** `meetsGuideline(androidTapTargetGuideline)` memeriksa bahwa ...

- a. setiap teks punya kontras yang cukup dengan latar belakangnya
- b. aplikasi hanya berjalan di Android
- c. setiap tombol punya *tooltip*
- d. setiap bagian yang bisa diketuk berukuran paling sedikit 48 × 48 piksel

**11.** Tes ViewModel yang memanggil `ImagePicker` langsung gagal dengan `MissingPluginException`. Cara yang paling dianjurkan panduan resmi Flutter adalah ...

- a. membungkus *plugin* di balik kontrak sendiri, lalu memakai implementasi palsu di tes
- b. menjalankan tes di emulator agar *plugin*-nya tersedia
- c. menghapus tes itu
- d. meniru *platform channel* dengan `TestDefaultBinaryMessenger`, karena paling sederhana

**12.** Debug Console menampilkan belasan galat sekaligus. Galat mana yang sebaiknya dibaca **pertama kali**?

- a. Galat terakhir, karena paling baru
- b. Galat terpanjang
- c. Galat pertama yang dicetak lengkap dengan garis `════`, karena galat sesudahnya sering hanya akibat
- d. Galat yang menyebut `package:flutter/`, karena di sanalah kesalahannya

**13.** Anda ingin melihat nilai `total` setiap kali perulangan berjalan, **tanpa** menghentikan aplikasi dan **tanpa** mengubah kode. Alat yang paling tepat adalah ...

- a. *logpoint*
- b. *breakpoint* biasa
- c. `print()` di dalam perulangan
- d. *hot restart*

**14.** Galat `Vertical viewport was given unbounded height` paling sering disebabkan oleh ...

- a. teks yang terlalu panjang di dalam `Row`
- b. gambar yang terlalu besar
- c. `TextField` tanpa `controller`
- d. `ListView` yang diletakkan langsung di dalam `Column`; bungkus dengan `Expanded`

**15.** Laporan `flutter test --coverage` menunjukkan cakupan **100%**. Pernyataan yang benar adalah ...

- a. aplikasi pasti bebas bug
- b. semua baris di `lib/` pernah dijalankan oleh tes, tetapi belum tentu setiap hasilnya diperiksa dengan benar
- c. tidak perlu menulis tes lagi untuk fitur baru
- d. semua tes pasti hijau

---

## B. Tebak Hasil

Untuk setiap berkas, tebak dulu hasilnya. Ingat cara membaca baris ringkasan `flutter test` ([Modul Bagian 2.4](README.md#24-membaca-tes-yang-gagal)): angka setelah `+` adalah jumlah tes yang **lulus**, angka setelah `-` adalah jumlah tes yang **gagal**. Contoh: `00:01 +4 -1: Some tests failed.`

**B1.** Tarif parkir motor kampus. Simpan sebagai `test/b1_tarif_parkir_test.dart`.

```dart
import 'package:flutter_test/flutter_test.dart';

/// Tarif parkir motor kampus: 2 jam pertama Rp2.000, setiap jam berikutnya
/// (walaupun baru sebagian) Rp1.000, dan paling mahal Rp10.000.
int tarifParkir(int menit) {
  if (menit <= 120) {
    return 2000;
  }
  final int jamTambahan = (menit - 120) ~/ 60;
  final int tarif = 2000 + jamTambahan * 1000;
  return tarif > 10000 ? 10000 : tarif;
}

void main() {
  test('tepat 2 jam: Rp2.000', () {
    expect(tarifParkir(120), 2000);
  });

  test('2 jam 1 menit: Rp3.000', () {
    expect(tarifParkir(121), 3000);
  });

  test('tepat 3 jam: Rp3.000', () {
    expect(tarifParkir(180), 3000);
  });

  test('3 jam 30 menit: Rp4.000', () {
    expect(tarifParkir(210), 4000);
  });

  test('seharian: paling mahal Rp10.000', () {
    expect(tarifParkir(24 * 60), 10000);
  });
}
```

- (a) Tes mana saja yang **gagal**? Untuk setiap tes yang gagal, tuliskan nilai `Expected` dan `Actual` pada pesannya.
- (b) Tuliskan baris ringkasan terakhir yang dicetak.
- (c) Kesalahannya ada di **tes** atau di **kode**? Perbaiki dengan mengubah **satu baris** saja.

**B2.** Urutan `setUp` dan `tearDown`. Simpan sebagai `test/b2_urutan_setup_test.dart`.

```dart
// Berkas latihan: print() dipakai untuk melihat urutan.
// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() => print('1 setUp luar'));
  tearDown(() => print('2 tearDown luar'));

  test('pertama', () {
    print('3 tes pertama');
  });

  group('keranjang', () {
    setUp(() => print('4 setUp grup'));
    tearDown(() => print('5 tearDown grup'));

    test('kedua', () {
      print('6 tes kedua');
    });

    test('ketiga', () {
      print('7 tes ketiga');
    });
  });
}
```

- (a) Tuliskan angka-angka yang dicetak untuk setiap tes, berurutan. Contoh format: `pertama: 1, 3, 2`.
- (b) Mengapa tes `kedua` dan `ketiga` juga mencetak `1` dan `2`, padahal `setUp` dan `tearDown` luar ditulis di luar `group`?
- (c) Seandainya `setUp` luar membuat sebuah objek `Keranjang` baru, berapa kali objek itu dibuat selama berkas ini berjalan?

**B3.** Tes asinkron, dengan dan tanpa `await`. Simpan sebagai `test/b3_tanpa_await_test.dart`.

```dart
import 'package:flutter_test/flutter_test.dart';

Future<int> gandakanLambat(int angka) async {
  await Future<void>.delayed(const Duration(milliseconds: 100));
  if (angka < 0) {
    throw ArgumentError.value(angka, 'angka', 'tidak boleh negatif');
  }
  return angka * 2;
}

void main() {
  test('A: tanpa async dan await', () {
    gandakanLambat(2).then((int hasil) {
      expect(hasil, 5);
    });
  });

  test('B: dengan async dan await', () async {
    expect(await gandakanLambat(2), 5);
  });

  test('C: memeriksa Future yang gagal', () async {
    await expectLater(gandakanLambat(-1), throwsArgumentError);
  });

  test('D: jenis exception yang salah', () async {
    await expectLater(gandakanLambat(-1), throwsStateError);
  });
}
```

- (a) Untuk tes A sampai D, tebak: **lulus** atau **gagal**?
- (b) `2 × 2` jelas bukan 5, tetapi tes A dilaporkan lulus. Mengapa? Pesan apa yang muncul sesaat kemudian?
- (c) Tes D gagal dengan pesan yang berisi `Which: threw ArgumentError:<...>`. Jelaskan arti pesan itu dengan kata-kata Anda sendiri.

**B4.** Kabar dari `ChangeNotifier`. Jalankan di DartPad.

```dart
// Program konsol, jadi print() boleh dipakai.
// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/foundation.dart';

class Penghitung extends ChangeNotifier {
  int _nilai = 0;
  bool _sibuk = false;

  int get nilai => _nilai;
  bool get sibuk => _sibuk;

  Future<void> tambahLambat(Future<void> tunggu) async {
    if (_sibuk) {
      return;
    }
    _sibuk = true;
    notifyListeners();
    await tunggu;
    _nilai++;
    _sibuk = false;
    notifyListeners();
  }

  void tambahCepat() {
    _nilai++;
  }
}

Future<void> main() async {
  final Penghitung penghitung = Penghitung();
  final List<String> kabar = [];
  penghitung.addListener(() {
    kabar.add('${penghitung.nilai}/${penghitung.sibuk}');
  });

  final Completer<void> server = Completer<void>();
  final Future<void> pertama = penghitung.tambahLambat(server.future);
  final Future<void> kedua = penghitung.tambahLambat(Future<void>.value());
  penghitung.tambahCepat();
  print('1: ${penghitung.nilai} ${penghitung.sibuk} $kabar');

  server.complete();
  await pertama;
  await kedua;
  print('2: ${penghitung.nilai} ${penghitung.sibuk} $kabar');

  penghitung.tambahCepat();
  print('3: ${penghitung.nilai} $kabar');
}
```

- (a) Tuliskan ketiga baris yang dicetak.
- (b) Mengapa pemanggilan `kedua` tidak menambah nilai sama sekali?
- (c) Di baris `3:`, nilainya sudah bertambah, tetapi daftar kabar tidak. Apa akibatnya bagi layar yang membaca penghitung ini dengan `context.watch<Penghitung>()`? Bagaimana memperbaikinya?

**B5.** Tes widget pertama. Simpan sebagai `test/b5_penghitung_widget_test.dart`.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class HalamanKetuk extends StatefulWidget {
  const HalamanKetuk({super.key});

  @override
  State<HalamanKetuk> createState() => _HalamanKetukState();
}

class _HalamanKetukState extends State<HalamanKetuk> {
  int _jumlah = 0;

  void _ketuk() {
    setState(() => _jumlah++);
    if (_jumlah == 3) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Sudah 3 kali!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Diketuk $_jumlah kali'),
            FilledButton(onPressed: _ketuk, child: const Text('Tambah')),
          ],
        ),
      ),
    );
  }
}

Future<void> pasang(WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: HalamanKetuk()));
}

void main() {
  testWidgets('A: satu ketukan', (WidgetTester tester) async {
    await pasang(tester);
    await tester.tap(find.text('Tambah'));
    expect(find.text('Diketuk 1 kali'), findsOneWidget);
  });

  testWidgets('B: satu ketukan, lalu pump', (WidgetTester tester) async {
    await pasang(tester);
    await tester.tap(find.text('Tambah'));
    await tester.pump();
    expect(find.text('Diketuk 1 kali'), findsOneWidget);
  });

  testWidgets('C: berapa banyak Text?', (WidgetTester tester) async {
    await pasang(tester);
    expect(find.byType(Text), findsOneWidget);
  });

  testWidgets('D: SnackBar muncul, lalu hilang', (WidgetTester tester) async {
    await pasang(tester);
    for (int i = 0; i < 3; i++) {
      await tester.tap(find.text('Tambah'));
      await tester.pump();
    }
    expect(find.text('Sudah 3 kali!'), findsOneWidget);

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('Sudah 3 kali!'), findsNothing);
  });
}
```

- (a) Tebak hasil tes A sampai D, lalu tuliskan baris ringkasan terakhirnya.
- (b) Untuk setiap tes yang gagal, jelaskan penyebabnya dan tuliskan perbaikannya. Tes C cukup diperbaiki dengan mengubah **harapannya**.

<details>
<summary>💡 Petunjuk Bagian B</summary>

B1: Bagian 2.4 dan 2.7; perhatikan bahwa `~/` membuang sisa pembagian. B2: Bagian 3.3 dan 3.4. B3: Bagian 4.1 dan 4.3. B4: Bagian 5.4 dan 5.5, serta penjaga `_sibuk` di Contoh 04. B5: Bagian 6.3–6.5 dan 7.4 (kapan *timer* `SnackBar` mulai berjalan).
</details>

---

## C. Temukan dan Perbaiki Kesalahannya

Setiap kode berikut mengandung **dua** kesalahan. Untuk setiap kesalahan, jelaskan **pesan atau gejalanya**, **penyebabnya**, dan **perbaikannya**.

**C1.** Rina menulis tes untuk kelas `NilaiUjian` dan mendapat ringkasan `+2 -1`. Tes `nilai 101 ditolak` gagal dengan pesan `Invalid argument (angka): harus 0 sampai 100: 101`, padahal kelasnya **memang benar** menolak angka 101. Untuk memastikan tes kedua bekerja, Rina sengaja mengubah `ambilNilaiKelas` agar mengembalikan `[80, 75]` saja. Anehnya, ringkasannya **tetap** `+2 -1`. Simpan sebagai `test/c1_nilai_ujian_test.dart`.

```dart
import 'package:flutter_test/flutter_test.dart';

/// Nilai ujian harus 0 sampai 100.
class NilaiUjian {
  NilaiUjian(this.angka) {
    if (angka < 0 || angka > 100) {
      throw ArgumentError.value(angka, 'angka', 'harus 0 sampai 100');
    }
  }

  final int angka;
}

/// Meniru server yang mengirim nilai satu kelas.
Future<List<int>> ambilNilaiKelas() async {
  await Future<void>.delayed(const Duration(milliseconds: 100));
  return [80, 75, 90];
}

void main() {
  test('nilai 101 ditolak', () {
    expect(NilaiUjian(101), throwsArgumentError);
  });

  test('server mengirim tiga nilai', () {
    ambilNilaiKelas().then((List<int> nilai) {
      expect(nilai, hasLength(3));
    });
  });

  test('nilai 100 boleh', () {
    expect(NilaiUjian(100).angka, 100);
  });
}
```

**C2.** Halaman catatan berikut **sudah benar**; yang salah adalah tesnya. Tes ini gagal dengan sebuah pesan galat. Setelah kesalahan pertama diperbaiki, tes masih gagal dengan pesan yang lain. Simpan sebagai `test/c2_tes_simpan_test.dart`.

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ------------------- KODE APLIKASI (sudah benar) -------------------

class HalamanCatatan extends StatefulWidget {
  const HalamanCatatan({super.key, required this.simpan});

  final Future<void> Function(String isi) simpan;

  @override
  State<HalamanCatatan> createState() => _HalamanCatatanState();
}

class _HalamanCatatanState extends State<HalamanCatatan> {
  final TextEditingController _isi = TextEditingController();
  bool _menyimpan = false;

  @override
  void dispose() {
    _isi.dispose();
    super.dispose();
  }

  Future<void> _tekanSimpan() async {
    setState(() => _menyimpan = true);
    await widget.simpan(_isi.text);
    if (!mounted) {
      return;
    }
    setState(() => _menyimpan = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simpan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              key: const Key('isian_catatan'),
              controller: _isi,
              decoration: const InputDecoration(labelText: 'Catatan'),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _menyimpan ? null : _tekanSimpan,
              child: _menyimpan
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------- TES (ada dua kesalahan) ----------------------

void main() {
  testWidgets('catatan dikirim ke server', (WidgetTester tester) async {
    final Completer<void> server = Completer<void>();
    String? terkirim;
    await tester.pumpWidget(
      MaterialApp(
        home: HalamanCatatan(
          simpan: (String isi) {
            terkirim = isi;
            return server.future;
          },
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const Key('isian_catatan')),
      'Beli spidol',
    );
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    server.complete();
    await tester.pumpAndSettle();
    expect(terkirim, 'Beli spidol');
  });
}
```

**C3.** Halaman profil mahasiswa. Begitu dibuka, layarnya langsung **merah**. Setelah kesalahan itu diperbaiki, halamannya tampil, tetapi di HP selebar 360 piksel muncul **pita kuning-hitam** di sebelah kanan nama mahasiswa. Simpan sebagai `lib/main.dart`.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HalamanProfil(),
    ),
  );
}

class HalamanProfil extends StatefulWidget {
  const HalamanProfil({super.key});

  @override
  State<HalamanProfil> createState() => _HalamanProfilState();
}

class _HalamanProfilState extends State<HalamanProfil> {
  late final TextEditingController _surel;

  @override
  void dispose() {
    _surel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme gaya = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Mahasiswa')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 28, child: Icon(Icons.person)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rina Maharani Kusumawardhani',
                    style: gaya.titleLarge,
                  ),
                  const Text('Teknik Informatika · Angkatan 2025'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _surel,
            decoration: const InputDecoration(
              labelText: 'Surel kampus',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
```

Setelah memperbaiki C3, tulis **satu tes widget** yang memasang `HalamanProfil` di layar 360 piksel. Tes itu harus **merah** jika kesalahan kedua dikembalikan, dan **hijau** setelah diperbaiki.

<details>
<summary>💡 Petunjuk Bagian C</summary>

C1: Bagian 3.2 (mengapa `expect` butuh fungsi) dan 4.1. C2: Bagian 6.3 (*finder* yang menemukan lebih dari satu widget) dan 6.5 (`pumpAndSettle` dan lingkaran memuat). C3: Bagian 10.3–10.4 (layar merah), 13.2 (teks panjang di dalam `Row`), dan 7.5 untuk tesnya.
</details>

---

## D. Menulis Tes

Pada bagian ini Anda **tidak** menulis aplikasi, tetapi **menguji** kode milik orang lain. Kode setiap soal sudah disediakan dan **belum punya tes satu pun**. Aturannya:

1. Tulis tes berdasarkan **aturan yang tertulis** (komentar dan keterangan soal), bukan berdasarkan apa yang kebetulan dilakukan kodenya.
2. Jika ada tes yang **merah**, periksa tesnya dulu. Jika tesnya sudah sesuai aturan, berarti Anda menemukan **bug**: perbaiki **kode aplikasinya**, jangan mengubah harapan tesnya.
3. Catat setiap bug di `CATATAN_DEBUGGING.md` di folder utama proyek, dengan tabel seperti [Jobsheet Praktikum 4 Langkah 9](JOBSHEET.md#langkah-9--catatan-debugging-lalu-simpan): gejala, cara menemukan, penyebab, perbaikan, dan tes yang menjaganya.
4. Ikuti aturan hari ini: pola **siapkan–lakukan–periksa**, objek baru di `setUp` agar setiap tes mulai dari nol, nama tes yang menjelaskan aturannya, dan **tanpa** `print` di berkas tes.

**D1 — Predikat Kelulusan.** Bagian akademik meminta Anda menguji perhitungan IPK berikut. Simpan sebagai `lib/ipk.dart` di proyek `latihan_p14`.

```dart
// Aturan nilai dan predikat REKAAN untuk latihan.

/// Bobot setiap nilai huruf.
double bobotHuruf(String huruf) {
  return switch (huruf) {
    'A' => 4.0,
    'AB' => 3.5,
    'B' => 3.0,
    'BC' => 2.5,
    'C' => 2.0,
    'D' => 1.0,
    'E' => 0.0,
    _ => throw ArgumentError.value(huruf, 'huruf', 'nilai huruf tidak dikenal'),
  };
}

class MataKuliah {
  const MataKuliah(this.nama, this.sks, this.huruf);

  final String nama;
  final int sks;
  final String huruf;
}

/// IPK = jumlah (bobot x sks) dibagi jumlah sks, dibulatkan dua angka di
/// belakang koma. Jika belum ada mata kuliah, IPK-nya 0.
double hitungIpk(List<MataKuliah> daftar) {
  int totalSks = 0;
  double totalBobot = 0;
  for (final MataKuliah mk in daftar) {
    totalSks += mk.sks;
    totalBobot += bobotHuruf(mk.huruf) * mk.sks;
  }
  if (totalSks == 0) {
    return 0;
  }
  return (totalBobot / totalSks * 100).round() / 100;
}

/// Predikat kelulusan:
/// - "Dengan pujian": IPK paling sedikit 3,51 DAN tidak ada nilai di
///   bawah B;
/// - "Sangat memuaskan": IPK 3,01 ke atas yang tidak mendapat pujian;
/// - "Memuaskan": IPK 2,76 sampai 3,00;
/// - "Cukup": IPK di bawah 2,76.
String predikat(List<MataKuliah> daftar) {
  final double ipk = hitungIpk(daftar);
  final bool adaDiBawahB = daftar.any(
    (MataKuliah mk) => mk.huruf == 'C' || mk.huruf == 'D' || mk.huruf == 'E',
  );
  if (ipk >= 3.51 && !adaDiBawahB) {
    return 'Dengan pujian';
  }
  if (ipk > 3.00) {
    return 'Sangat memuaskan';
  }
  if (ipk >= 2.76) {
    return 'Memuaskan';
  }
  return 'Cukup';
}
```

Tulis `test/ipk_test.dart` (impor `package:latihan_p14/ipk.dart`) dengan minimal **15** tes:

- `bobotHuruf`: ketujuh huruf ditulis sebagai **tabel kasus** (satu pola, banyak data), ditambah huruf yang tidak dikenal harus ditolak dengan `ArgumentError`.
- `hitungIpk`: daftar kosong, SKS yang ikut menimbang, dan pembulatan dua angka di belakang koma.
- `predikat` **di setiap nilai batas**: 3,51 dan 3,50; 3,01 dan 3,00; 2,76 dan 2,75.
- Aturan "tidak ada nilai di bawah B": coba **setiap** huruf di bawah B, jangan hanya satu.
- Jika menemukan bug, ikuti urutan "merah dulu, baru hijau". Di `CATATAN_DEBUGGING.md`, jelaskan juga mengapa bug itu mudah lolos dari pemeriksaan sekilas.

<details>
<summary>💡 Petunjuk D1</summary>

Membuat IPK tepat 3,51 dari nilai mata kuliah sungguhan itu sulit. Akali dengan jumlah SKS: 51 SKS bernilai A ditambah 49 SKS bernilai B menghasilkan (4 × 51 + 3 × 49) ÷ 100 = **3,51**. Buat fungsi pembantu kecil, misalnya `gabungan({'A': 51, 'B': 49})`, yang mengubah pasangan huruf → jumlah SKS menjadi `List<MataKuliah>`. Tabel kasus: Bagian 3.6; nilai batas: Bagian 2.7; *exception*: Bagian 3.2.
</details>

**D2 — Seminar Kampus: ViewModel.** Teman Anda membuat aplikasi pendaftaran seminar berikut. Buat proyeknya, tambahkan paket `provider`, lalu salin seluruh kodenya ke `lib/main.dart`:

```bash
flutter create seminar_kampus
cd seminar_kampus
flutter pub add provider
```

<details>
<summary>📄 Kode lengkap <code>lib/main.dart</code> (klik untuk membuka)</summary>

```dart
// =====================================================================
// SEMINAR KAMPUS - aplikasi untuk Latihan D2 dan D3 Pertemuan 14
// Ditulis oleh teman Anda dan BELUM punya tes satu pun.
// Salin seluruhnya ke lib/main.dart proyek seminar_kampus.
// =====================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    Provider<RepositoriSeminar>(
      create: (BuildContext context) => RepositoriSeminarMemori(),
      child: const AplikasiSeminar(),
    ),
  );
}

// =========================== BAGIAN 1: DATA ===========================

class Seminar {
  const Seminar({
    required this.id,
    required this.judul,
    required this.pembicara,
    required this.kuota,
    required this.terisi,
  });

  final int id;
  final String judul;
  final String pembicara;
  final int kuota;
  final int terisi;

  int get sisaKursi => kuota - terisi;
  bool get penuh => terisi >= kuota;

  /// Salinan seminar ini dengan satu peserta tambahan.
  Seminar tambahSatuPeserta() {
    return Seminar(
      id: id,
      judul: judul,
      pembicara: pembicara,
      kuota: kuota,
      terisi: terisi + 1,
    );
  }
}

sealed class Hasil<T> {
  const Hasil();
}

final class Berhasil<T> extends Hasil<T> {
  const Berhasil(this.nilai);

  final T nilai;
}

final class Gagal<T> extends Hasil<T> {
  const Gagal(this.pesan);

  final String pesan;
}

// ======================== BAGIAN 2: REPOSITORY ========================

abstract interface class RepositoriSeminar {
  Future<Hasil<List<Seminar>>> semua();

  /// Jika berhasil, mengembalikan seminar dengan jumlah peserta yang baru.
  Future<Hasil<Seminar>> daftarkan(int idSeminar);
}

const List<Seminar> contohSeminar = [
  Seminar(
    id: 1,
    judul: 'Flutter untuk Pemula',
    pembicara: 'Dewi Lestari',
    kuota: 40,
    terisi: 38,
  ),
  Seminar(
    id: 2,
    judul: 'Keamanan Aplikasi',
    pembicara: 'Budi Santoso',
    kuota: 30,
    terisi: 30,
  ),
  Seminar(
    id: 3,
    judul: 'Karier di Industri',
    pembicara: 'Sari Wulandari',
    kuota: 50,
    terisi: 12,
  ),
];

/// Repository di memori agar aplikasi bisa dijalankan tanpa server.
class RepositoriSeminarMemori implements RepositoriSeminar {
  final List<Seminar> _isi = [...contohSeminar];

  @override
  Future<Hasil<List<Seminar>>> semua() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return Berhasil(List.of(_isi));
  }

  @override
  Future<Hasil<Seminar>> daftarkan(int idSeminar) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final int posisi = _isi.indexWhere((Seminar s) => s.id == idSeminar);
    if (posisi < 0) {
      return const Gagal('Seminar tidak ditemukan.');
    }
    if (_isi[posisi].penuh) {
      return const Gagal('Maaf, kursi seminar ini sudah habis.');
    }
    _isi[posisi] = _isi[posisi].tambahSatuPeserta();
    return Berhasil(_isi[posisi]);
  }
}

// ========================= BAGIAN 3: VIEWMODEL =========================

enum StatusMuat { memuat, berhasil, gagal }

class SeminarViewModel extends ChangeNotifier {
  SeminarViewModel({required this._repositori});

  final RepositoriSeminar _repositori;

  StatusMuat _status = StatusMuat.memuat;
  List<Seminar> _daftar = [];
  String _pesanGalat = '';
  String? _pesanDaftar;
  bool _mendaftar = false;
  final Set<int> _terdaftar = {};

  StatusMuat get status => _status;
  List<Seminar> get daftar => List.unmodifiable(_daftar);
  String get pesanGalat => _pesanGalat;
  String? get pesanDaftar => _pesanDaftar;
  bool get mendaftar => _mendaftar;

  bool sudahTerdaftar(Seminar seminar) => _terdaftar.contains(seminar.id);

  /// Tombol Daftar hanya hidup jika fungsi ini mengembalikan true.
  bool bolehDaftar(Seminar seminar) {
    return !seminar.penuh && !sudahTerdaftar(seminar) && !_mendaftar;
  }

  Future<void> muat() async {
    _status = StatusMuat.memuat;
    notifyListeners();
    final Hasil<List<Seminar>> hasil = await _repositori.semua();
    switch (hasil) {
      case Berhasil(:final List<Seminar> nilai):
        _daftar = nilai;
        _status = StatusMuat.berhasil;
      case Gagal(:final String pesan):
        _pesanGalat = pesan;
        _status = StatusMuat.gagal;
    }
    notifyListeners();
  }

  /// Mengembalikan true jika pendaftaran berhasil.
  Future<bool> daftarkan(Seminar seminar) async {
    if (!bolehDaftar(seminar)) {
      return false;
    }
    _mendaftar = true;
    _pesanDaftar = null;
    notifyListeners();
    final Hasil<Seminar> hasil = await _repositori.daftarkan(seminar.id);
    switch (hasil) {
      case Berhasil(:final Seminar nilai):
        _daftar = [
          for (final Seminar s in _daftar) s.id == nilai.id ? nilai : s,
        ];
        _terdaftar.add(nilai.id);
        _mendaftar = false;
        notifyListeners();
        return true;
      case Gagal(:final String pesan):
        _pesanDaftar = pesan;
        notifyListeners();
        return false;
    }
  }
}

// ========================== BAGIAN 4: TAMPILAN ==========================

class AplikasiSeminar extends StatelessWidget {
  const AplikasiSeminar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seminar Kampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HalamanSeminar(),
    );
  }
}

class HalamanSeminar extends StatelessWidget {
  const HalamanSeminar({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          SeminarViewModel(repositori: context.read<RepositoriSeminar>())
            ..muat(),
      child: const TampilanSeminar(),
    );
  }
}

class TampilanSeminar extends StatelessWidget {
  const TampilanSeminar({super.key});

  @override
  Widget build(BuildContext context) {
    final SeminarViewModel vm = context.watch<SeminarViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seminar Kampus'),
        actions: [
          IconButton(
            onPressed: vm.status == StatusMuat.memuat ? null : vm.muat,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: switch (vm.status) {
        StatusMuat.memuat => const Center(child: CircularProgressIndicator()),
        StatusMuat.gagal => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(vm.pesanGalat, textAlign: TextAlign.center),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: vm.muat,
                  child: const Text('Coba lagi'),
                ),
              ],
            ),
          ),
        ),
        StatusMuat.berhasil => const DaftarSeminar(),
      },
    );
  }
}

class DaftarSeminar extends StatelessWidget {
  const DaftarSeminar({super.key});

  Future<void> _daftar(BuildContext context, Seminar seminar) async {
    final SeminarViewModel vm = context.read<SeminarViewModel>();
    final ScaffoldMessengerState pesan = ScaffoldMessenger.of(context);
    final bool berhasil = await vm.daftarkan(seminar);
    if (berhasil) {
      pesan.showSnackBar(
        SnackBar(content: Text('Anda terdaftar di "${seminar.judul}".')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final SeminarViewModel vm = context.watch<SeminarViewModel>();
    final String? pesanDaftar = vm.pesanDaftar;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (pesanDaftar != null)
          Card(
            color: Theme.of(context).colorScheme.errorContainer,
            child: ListTile(
              leading: const Icon(Icons.error_outline),
              title: Text(pesanDaftar),
            ),
          ),
        for (final Seminar seminar in vm.daftar)
          KartuSeminar(
            seminar: seminar,
            terdaftar: vm.sudahTerdaftar(seminar),
            onDaftar: vm.bolehDaftar(seminar)
                ? () => _daftar(context, seminar)
                : null,
          ),
      ],
    );
  }
}

class KartuSeminar extends StatelessWidget {
  const KartuSeminar({
    super.key,
    required this.seminar,
    required this.terdaftar,
    required this.onDaftar,
  });

  final Seminar seminar;
  final bool terdaftar;
  final VoidCallback? onDaftar;

  @override
  Widget build(BuildContext context) {
    final TextTheme gaya = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(seminar.judul, style: gaya.titleMedium),
                const Spacer(),
                Text(
                  seminar.penuh ? 'Penuh' : 'Sisa ${seminar.sisaKursi} kursi',
                  style: gaya.labelLarge,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(seminar.pembicara),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: terdaftar
                  ? const Chip(
                      avatar: Icon(Icons.check),
                      label: Text('Terdaftar'),
                    )
                  : FilledButton(
                      onPressed: onDaftar,
                      child: const Text('Daftar'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
```

</details>

Aturan aplikasi menurut teman Anda:

- Seminar yang **penuh** tidak bisa didaftari, dan setiap orang hanya bisa mendaftar **sekali** di setiap seminar.
- Selama satu pendaftaran sedang dikirim, **semua** tombol Daftar mati, agar ketukan ganda tidak mengirim dua pendaftaran.
- Jika pendaftaran **berhasil**, sisa kursi seminar itu berkurang satu.
- Jika pendaftaran **gagal**, pesannya tampil dan pengguna **bisa mencoba lagi**.

Tugas Anda:

1. Buat `testing/fakes/repositori_seminar_palsu.dart` berisi `RepositoriSeminarPalsu` yang **tanpa jeda**, punya "*remote control*" untuk pura-pura gagal saat memuat dan saat mendaftar, mencatat **id seminar** yang didaftarkan (mata-mata), dan bisa **ditahan** sampai `lepaskan()` dipanggil.
2. Tulis `test/seminar_view_model_test.dart` dengan minimal **8** tes untuk `SeminarViewModel`: memuat berhasil, memuat gagal, urutan kabar ke pendengar, mendaftar berhasil, seminar penuh tidak dikirim, tidak bisa mendaftar dua kali, dua ketukan cepat hanya mengirim satu pendaftaran, serta gagal lalu mencoba lagi.
3. Ada **satu** bug tersembunyi yang membuat sebagian tes Anda merah. Temukan barisnya (boleh dengan *debugger*), perbaiki, lalu catat.

<details>
<summary>💡 Petunjuk D2</summary>

Ikuti Praktikum 2 di Jobsheet: `RepositoriKasPalsu` hampir bisa disalin, cukup ganti jenis datanya dan pakai `String?` sebagai *remote control* (`Gagal` di aplikasi ini berisi pesan, bukan `Kegagalan`). Untuk menguji keadaan "sedang mendaftar", pasang `tahan = true`, panggil `daftarkan` **tanpa** `await` dan simpan `Future`-nya, periksa keadaannya, lalu `lepaskan()` dan `await` *Future* tadi (Bagian 5.3 dan 5.5). Seminar terbaru bisa diambil dari ViewModel dengan `vm.daftar.firstWhere((Seminar s) => s.id == 1)`.
</details>

**D3 — Seminar Kampus: Tampilan.** Kerjakan **setelah** bug D2 diperbaiki. Tulis `test/halaman_seminar_test.dart` yang memasang **aplikasi asli** (`AplikasiSeminar`) dengan `RepositoriSeminarPalsu` dari D2, minimal **7** tes widget:

- lingkaran memuat tampil selama data belum datang, lalu ketiga seminar tampil beserta sisa kursinya;
- tombol Daftar pada seminar yang penuh **mati**;
- setelah Daftar diketuk: semua tombol Daftar mati selama menunggu, lalu *SnackBar* `Anda terdaftar di "…".` muncul, sisa kursi berkurang, dan tombolnya berganti menjadi chip **Terdaftar**;
- pendaftaran gagal: pesannya tampil, tidak ada *SnackBar*, dan Daftar bisa diketuk lagi sampai berhasil;
- gagal memuat: pesan dan tombol **Coba lagi** yang berfungsi;
- layar **320** piksel dengan huruf **200%** tidak meluap;
- memenuhi tiga pedoman aksesibilitas: target sentuh, label, dan kontras.

Kode tampilan teman Anda juga belum pernah diuji. Jika ada tes yang merah, perbaiki kode tampilannya, catat, dan jelaskan mengapa masalah itu tidak terlihat saat aplikasinya dicoba di laptop.

<details>
<summary>💡 Petunjuk D3</summary>

Ikuti Praktikum 3 di Jobsheet. Ada tiga tombol bertulisan "Daftar", jadi `find.text('Daftar')` tidak cukup. Cari tombol **di dalam kartu** seminar tertentu dengan `find.descendant` (Bagian 6.3):

```dart
/// Tombol Daftar di dalam kartu seminar yang berjudul [judul].
Finder tombolDaftar(String judul) {
  return find.descendant(
    of: find.widgetWithText(Card, judul),
    matching: find.byType(FilledButton),
  );
}
```

Hidup-matinya tombol dibaca dengan `tester.widget<ButtonStyleButton>(finder).enabled` (Bagian 7.3). Ingat: jangan `pumpAndSettle()` selama lingkaran memuat masih berputar. Jika perbaikan tata letak pertama Anda belum cukup, baca lagi [Jobsheet Praktikum 4 Langkah 6](JOBSHEET.md#langkah-6--bug-d-kartu-saldo-meluap).
</details>

---

[⬅️ Kembali ke Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md) · [🏠 Beranda](../README.md)

# ✍️ Latihan Pertemuan 10 — Asinkron & Integrasi REST API

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md)

Kerjakan **tanpa membuka modul dan tanpa menjalankan kode** terlebih dahulu. Setelah selesai, buktikan jawaban Anda dengan menjalankan kodenya di [DartPad](https://dartpad.dev) atau di Chrome. Semua kode di bagian B dan C sudah berupa program utuh, jadi bisa langsung ditempel. DartPad sudah menyediakan paket `http` dan `provider`.

> [!NOTE]
> Kunci jawaban tidak dipublikasikan. Petunjuk (💡) menunjukkan **bagian modul** yang relevan. Pembahasan lengkap dilakukan bersama dosen di kelas.
>
> Soal B1, B2, B3, B4, dan B5 **tidak** membutuhkan internet (datanya ditulis di kode atau memakai server tiruan). Soal C dan D membutuhkan koneksi internet.

---

## A. Pilihan Ganda

**1.** Aplikasi ingin menandai tugas nomor 5 di server sebagai selesai, cukup dengan mengirim kolom `completed`. Metode HTTP yang paling tepat adalah ...

- a. `GET`
- b. `POST`
- c. `PATCH`
- d. `DELETE`

**2.** Server menjawab permintaan `POST` dengan kode status `201`. Artinya ...

- a. data baru berhasil dibuat
- b. permintaan salah bentuk
- c. data yang diminta tidak ditemukan
- d. server sedang tidak tersedia

**3.** Kode status yang menunjukkan bahwa masalahnya ada **di sisi server**, sehingga aplikasi sebaiknya meminta pengguna mencoba lagi nanti, adalah ...

- a. `200`
- b. `401`
- c. `404`
- d. `503`

**4.** Teks berikut yang merupakan JSON yang **sah** adalah ...

- a. `{'nama': 'Rina'}`
- b. `{"nama": "Rina", "ipk": 3.75,}`
- c. `{"nama": "Rina", "ipk": 3.75}`
- d. `{nama: "Rina", ipk: 3.75}`

**5.** Sebelum dikirim dengan `POST`, data berupa `Map` diubah menjadi teks JSON dengan ...

- a. `jsonDecode`
- b. `toString()`
- c. `Uri.parse`
- d. `jsonEncode`

**6.** Server menjawab `404` untuk sebuah permintaan `http.get`. Pernyataan yang **benar** adalah ...

- a. `http.get` melempar `ClientException`
- b. `http.get` selesai seperti biasa dengan `statusCode` bernilai `404`, dan kode kitalah yang harus memeriksanya
- c. aplikasi otomatis menampilkan pesan galat kepada pengguna
- d. `respons.body` pasti kosong

**7.** Harga produk di JSON kadang ditulis `15` dan kadang `9.99`. Pola yang tepat di `fromJson` adalah ...

- a. `'price': double harga`
- b. `'price': int harga`
- c. `'price': num harga`, lalu `harga.toDouble()`
- d. `'price': String harga`

**8.** Agar `FutureBuilder` tidak mengirim permintaan baru setiap kali layar dibangun ulang, `Future`-nya dibuat ...

- a. sekali di `initState`, lalu disimpan di variabel *state*
- b. di dalam `build`
- c. di dalam `builder` milik `FutureBuilder`
- d. di dalam `dispose`

**9.** Id wilayah yang salah membuat server menjawab `404` berisi halaman HTML. Jika kode status tidak diperiksa dan `jsonDecode(respons.body)` tetap dijalankan, *exception* yang muncul adalah ...

- a. `FormatException`
- b. `TimeoutException`
- c. `http.ClientException`
- d. tidak ada *exception* sama sekali

**10.** Di fungsi `pesanRamah`, cabang `ApiException(kodeStatus: 404)` harus ditulis **sebelum** cabang `ApiException()` karena ...

- a. Dart selalu mengurutkan cabang dari angka terkecil
- b. `switch` memilih cabang **pertama** yang cocok, dan `ApiException()` cocok untuk semua `ApiException`
- c. cabang yang berisi angka wajib berada di atas
- d. cabang terakhir hanya boleh berisi `_`

**11.** Dalam lapisan data, bagian yang bertugas mengubah JSON mentah menjadi objek Model adalah ...

- a. layanan (*service*)
- b. View
- c. `main`
- d. *repository*

**12.** `LayananDummyJson` menerima `http.Client` lewat *constructor*, bukan membuatnya sendiri di dalam, terutama agar ...

- a. saat pengujian, `http.Client` bisa diganti `MockClient` sehingga tidak membutuhkan internet
- b. permintaan terkirim lebih cepat
- c. kode status tidak perlu diperiksa lagi
- d. `http.Client` tidak perlu ditutup

**13.** `Uri.https('dummyjson.com', '/products/search', {'q': 'meja belajar'})` menghasilkan alamat ...

- a. `https://dummyjson.com/products/search?q=meja belajar`
- b. `https://dummyjson.com/products/search?q=meja+belajar`
- c. `https://dummyjson.com/products/search/meja+belajar`
- d. *error*, karena kata kunci tidak boleh berisi spasi

**14.** Tujuan *debounce* pada kotak pencarian adalah ...

- a. mengirim permintaan untuk setiap huruf secepat mungkin
- b. menunggu sampai pengguna berhenti mengetik sesaat, baru mengirim permintaan
- c. menyimpan hasil pencarian di memori
- d. membatalkan permintaan yang sudah dijawab server

**15.** Aplikasi lancar saat diuji dengan `flutter run` di HP, tetapi APK rilis yang dibagikan ke teman tidak bisa memuat data sama sekali. Penyebab yang paling mungkin adalah ...

- a. CORS
- b. `Future` dibuat di dalam `build`
- c. izin `android.permission.INTERNET` belum ditambahkan di `AndroidManifest.xml`
- d. kode status tidak diperiksa

---

## B. Tebak Hasil

**B1.** Program berikut memakai server tiruan (`MockClient`), sehingga bisa dijalankan tanpa internet.

```dart
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

class ApiException implements Exception {
  const ApiException(this.kodeStatus);

  final int kodeStatus;

  @override
  String toString() => 'ApiException: kode status $kodeStatus';
}

// Server tiruan: jawabannya kita tentukan sendiri.
final MockClient server = MockClient((http.Request permintaan) async {
  return switch (permintaan.url.path) {
    '/buku/1' => http.Response('{"id": 1, "judul": "Dasar Dart"}', 200),
    '/buku/2' => http.Response('{"message": "Buku tidak ditemukan"}', 404),
    '/buku/3' => http.Response('<html>Sedang perawatan</html>', 200),
    '/buku/4' => http.Response('{"id": 4, "title": "Flutter Pemula"}', 200),
    '/buku/5' => http.Response('{"message": "Server sibuk"}', 503),
    _ => throw http.ClientException('Koneksi terputus'),
  };
});

Future<String> ambilJudul(int id) async {
  final http.Response respons = await server.get(
    Uri.https('perpustakaan.contoh', '/buku/$id'),
  );
  if (respons.statusCode != 200) {
    throw ApiException(respons.statusCode);
  }
  return switch (jsonDecode(respons.body)) {
    {'judul': String judul} => judul,
    _ => throw const FormatException('Bentuk data buku tidak sesuai'),
  };
}

String pesanRamah(Object galat) {
  return switch (galat) {
    ApiException(kodeStatus: 404) => 'Buku tidak ditemukan.',
    ApiException() => 'Permintaan ditolak oleh server.',
    FormatException() => 'Data dari server tidak bisa dibaca.',
    http.ClientException() => 'Tidak dapat terhubung.',
    _ => 'Terjadi kesalahan.',
  };
}

Future<void> main() async {
  for (int id = 1; id <= 6; id++) {
    try {
      final String judul = await ambilJudul(id);
      debugPrint('$id: $judul');
    } catch (galat) {
      debugPrint('$id: ${pesanRamah(galat)}');
    }
  }
}
```

- (a) Tuliskan enam baris yang tampil di konsol.
- (b) Nomor 3 dan 4 menghasilkan pesan yang sama. Jelaskan penyebab masing-masing.
- (c) Pesan untuk nomor 5 kurang tepat. Tambahkan **satu** cabang di `pesanRamah` agar nomor 5 menampilkan "Server sedang bermasalah. Coba lagi nanti." Di baris mana cabang itu harus ditulis, dan mengapa?

**B2.** Tuliskan tujuh baris yang tampil di konsol, lalu jelaskan penyebab setiap baris yang gagal.

```dart
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Mahasiswa {
  const Mahasiswa({required this.nim, required this.nama, required this.ipk});

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'nim': String nim, 'nama': String nama, 'ipk': num ipk} => Mahasiswa(
        nim: nim,
        nama: nama,
        ipk: ipk.toDouble(),
      ),
      _ => throw const FormatException('Data mahasiswa tidak sesuai'),
    };
  }

  final String nim;
  final String nama;
  final double ipk;
}

void main() {
  const List<String> data = [
    '{"nim": "2609106001", "nama": "Rina", "ipk": 3.75}',
    '{"nim": "2609106002", "nama": "Bayu", "ipk": 3}',
    '{"nim": "2609106003", "nama": "Citra", "ipk": "3.50"}',
    '{"nim": 2609106004, "nama": "Dimas", "ipk": 3.2}',
    '{"ipk": 3.9, "nama": "Eka", "nim": "2609106005", "angkatan": 2026}',
    '{"nim": "2609106006", "nama": "Fajar"}',
    "{'nim': '2609106007', 'nama': 'Gita', 'ipk': 3.4}",
  ];
  for (int i = 0; i < data.length; i++) {
    try {
      final Mahasiswa mhs = Mahasiswa.fromJson(
        jsonDecode(data[i]) as Map<String, dynamic>,
      );
      debugPrint('${i + 1}: ${mhs.nama}, IPK ${mhs.ipk.toStringAsFixed(2)}');
    } on FormatException catch (galat) {
      final bool dariPola = galat.message == 'Data mahasiswa tidak sesuai';
      debugPrint('${i + 1}: gagal di ${dariPola ? 'fromJson' : 'jsonDecode'}');
    }
  }
}
```

**B3.** Tuliskan lima baris yang tampil di konsol.

```dart
import 'package:flutter/foundation.dart';

void main() {
  final Uri a = Uri.https('dummyjson.com', '/products/search', {
    'q': 'kopi susu',
    'limit': '5',
  });
  debugPrint('1: $a');

  const int halaman = 3;
  final Uri b = Uri.https('dummyjson.com', '/products', {
    'limit': '10',
    'skip': '${(halaman - 1) * 10}',
  });
  debugPrint('2: $b');

  final Uri c = Uri.https('dummyjson.com', '/recipes/search', {
    'q': 'nasi & ayam',
  });
  debugPrint('3: $c');
  debugPrint('4: ${c.queryParameters['q']}');

  final Uri d = Uri.parse('https://dummyjson.com/todos?limit=3&skip=6');
  debugPrint('5: ${d.host} | ${d.path} | ${d.queryParameters['skip']}');
}
```

**B4.** `_ambilAngka` meniru permintaan ke server yang dijawab setelah 1 detik. Setiap kali `builder` milik `FutureBuilder` dijalankan, satu baris `build: ...` dicetak.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: HalamanAngka()));
}

class HalamanAngka extends StatefulWidget {
  const HalamanAngka({super.key});

  @override
  State<HalamanAngka> createState() => _HalamanAngkaState();
}

class _HalamanAngkaState extends State<HalamanAngka> {
  int _permintaan = 0;
  late Future<int> _angka;

  // Meniru permintaan ke server yang dijawab setelah 1 detik.
  Future<int> _ambilAngka() async {
    _permintaan++;
    final int ke = _permintaan;
    debugPrint('Permintaan ke-$ke dikirim');
    await Future<void>.delayed(const Duration(seconds: 1));
    return ke * 10;
  }

  @override
  void initState() {
    super.initState();
    _angka = _ambilAngka();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Angka dari Server')),
      body: FutureBuilder<int>(
        future: _angka,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          debugPrint(
            'build: ${snapshot.connectionState.name}, data=${snapshot.data}',
          );
          return Center(child: Text('${snapshot.data ?? '-'}'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _angka = _ambilAngka();
          });
        },
        tooltip: 'Muat ulang',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
```

- (a) Aplikasi dibuka dan ditunggu 2 detik. Setelah itu tombol muat ulang diketuk **sekali**, lalu ditunggu 2 detik lagi. Tuliskan semua baris di konsol secara berurutan.
- (b) Aplikasi dijalankan ulang dari awal. Setelah angka `10` tampil, tombol muat ulang diketuk **dua kali** dengan cepat (jaraknya sekitar 0,2 detik), lalu ditunggu 2 detik. Tuliskan baris-baris **baru** di konsol. Angka berapa yang akhirnya tampil, dan mengapa angka `20` tidak pernah tampil?

**B5.** Program berikut meniru kotak pencarian dengan *debounce*. Pengguna mengetik `t`, `te`, dan `teh` dengan cepat, berhenti sebentar, lalu mengetik `teh tarik`. Server tiruannya menjawab kata kunci `teh` dengan **sangat lambat**.

```dart
import 'dart:async';

import 'package:flutter/foundation.dart';

class PencarianViewModel {
  PencarianViewModel(this._ambil);

  final Future<List<String>> Function(String kataKunci) _ambil;
  Timer? _penunda;
  int _nomorPermintaan = 0;
  List<String> hasil = [];

  void cari(String teks) {
    _penunda?.cancel();
    _penunda = Timer(const Duration(milliseconds: 400), () => _muat(teks));
  }

  Future<void> _muat(String kataKunci) async {
    final int nomor = ++_nomorPermintaan;
    debugPrint('Kirim #$nomor: $kataKunci');
    final List<String> data = await _ambil(kataKunci);
    if (nomor != _nomorPermintaan) {
      debugPrint('Abaikan #$nomor');
      return;
    }
    hasil = data;
    debugPrint('Tampil #$nomor: $hasil');
  }
}

// Server tiruan: kata kunci "teh" dijawab setelah 1,5 detik,
// kata kunci lain setelah 0,25 detik.
Future<List<String>> serverTiruan(String kataKunci) async {
  final int jeda = kataKunci == 'teh' ? 1500 : 250;
  await Future<void>.delayed(Duration(milliseconds: jeda));
  return ['$kataKunci 1', '$kataKunci 2'];
}

Future<void> tunggu(int ms) => Future<void>.delayed(Duration(milliseconds: ms));

Future<void> main() async {
  final PencarianViewModel vm = PencarianViewModel(serverTiruan);
  vm.cari('t'); // milidetik ke-0
  await tunggu(100);
  vm.cari('te'); // milidetik ke-100
  await tunggu(100);
  vm.cari('teh'); // milidetik ke-200
  await tunggu(800);
  vm.cari('teh tarik'); // milidetik ke-1000
  await tunggu(2000);
  debugPrint('Akhir: ${vm.hasil}');
}
```

- (a) Tuliskan baris-baris yang tampil di konsol, berikut kira-kira pada milidetik ke berapa setiap baris muncul.
- (b) `cari` dipanggil empat kali. Berapa permintaan yang benar-benar dikirim ke server? Mengapa?
- (c) Jika pemeriksaan `if (nomor != _nomorPermintaan) { ... }` beserta isinya dihapus, apa isi baris `Akhir: ...`? Mengapa hasil itu salah?

<details>
<summary>💡 Petunjuk Bagian B</summary>

B1: Bagian 5 (kode `404` tetap sebuah jawaban), Bagian 8.1–8.2, dan Bagian 12.1. B2: Bagian 3.1 dan 6.2; perhatikan apa saja yang diperiksa oleh pola map. B3: Bagian 2.1, 10.1, dan 10.2. B4: Bagian 7.1–7.2; perhatikan apa yang terjadi pada `Future` lama setelah diganti. B5: Bagian 10.3 dan 10.4; gambarkan dulu garis waktunya, mulai dari milidetik ke-0.
</details>

---

## C. Temukan dan Perbaiki Kesalahannya

Setiap kode berikut mengandung **dua** kesalahan. Untuk setiap kesalahan, jelaskan **pesan atau gejalanya**, **penyebabnya**, dan **perbaikannya**. Ketiga program membutuhkan koneksi internet.

**C1.** Kode tidak bisa dijalankan karena editor menandai satu baris dengan garis merah. Setelah kesalahan pertama diperbaiki, aplikasi berjalan, tetapi setiap kali ikon hati diketuk, lingkaran memuat muncul sebentar dan **kutipannya berganti**, padahal pengguna hanya ingin menyukai kutipan yang sedang tampil.

```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(home: HalamanKutipan()));
}

class Kutipan {
  const Kutipan({required this.isi, required this.penulis});

  final String isi;
  final String penulis;
}

Future<Kutipan> ambilKutipan() async {
  final http.Response respons = await http.get(
    'https://dummyjson.com/quotes/random',
    headers: {'Accept': 'application/json'},
  );
  if (respons.statusCode != 200) {
    throw Exception('Server menjawab dengan kode ${respons.statusCode}');
  }
  return switch (jsonDecode(respons.body)) {
    {'quote': String isi, 'author': String penulis} => Kutipan(
      isi: isi,
      penulis: penulis,
    ),
    _ => throw const FormatException('Bentuk data kutipan tidak sesuai'),
  };
}

class HalamanKutipan extends StatefulWidget {
  const HalamanKutipan({super.key});

  @override
  State<HalamanKutipan> createState() => _HalamanKutipanState();
}

class _HalamanKutipanState extends State<HalamanKutipan> {
  bool _disukai = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kutipan Hari Ini'),
        actions: [
          IconButton(
            onPressed: () => setState(() => _disukai = !_disukai),
            tooltip: 'Sukai',
            icon: Icon(_disukai ? Icons.favorite : Icons.favorite_border),
          ),
        ],
      ),
      body: FutureBuilder<Kutipan>(
        future: ambilKutipan(),
        builder: (BuildContext context, AsyncSnapshot<Kutipan> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Gagal memuat kutipan.'));
          }
          final Kutipan kutipan = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  kutipan.isi,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Text('— ${kutipan.penulis}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

**C2.** Setiap kali tombol **Kirim usul** ditekan, `SnackBar` menampilkan "Gagal mengirim: ...". Setelah kesalahan pertama diperbaiki, konsol menunjukkan bahwa server sudah menerima usulnya dan mengirim nomor baru, tetapi `SnackBar` **tetap** mengatakan gagal.

```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(home: HalamanUsulBuku()));
}

Future<int> kirimUsul(String judul) async {
  final http.Response respons = await http.post(
    Uri.https('dummyjson.com', '/posts/add'),
    headers: {'Accept': 'application/json'},
    body: jsonEncode({'title': judul, 'body': 'Usul buku baru', 'userId': 1}),
  );
  debugPrint('Kode status: ${respons.statusCode}');
  debugPrint('Diterima: ${respons.body}');
  if (respons.statusCode != 200) {
    throw Exception('Usul ditolak (kode ${respons.statusCode})');
  }
  return switch (jsonDecode(respons.body)) {
    {'id': int id} => id,
    _ => throw const FormatException('Server tidak mengirim nomor usul'),
  };
}

class HalamanUsulBuku extends StatefulWidget {
  const HalamanUsulBuku({super.key});

  @override
  State<HalamanUsulBuku> createState() => _HalamanUsulBukuState();
}

class _HalamanUsulBukuState extends State<HalamanUsulBuku> {
  final TextEditingController _kontrolJudul = TextEditingController();
  bool _mengirim = false;

  @override
  void dispose() {
    _kontrolJudul.dispose();
    super.dispose();
  }

  Future<void> _kirim() async {
    final String judul = _kontrolJudul.text.trim();
    if (judul.isEmpty) {
      return;
    }
    setState(() => _mengirim = true);
    String pesan;
    try {
      final int nomor = await kirimUsul(judul);
      pesan = 'Usul terkirim dengan nomor #$nomor.';
      _kontrolJudul.clear();
    } catch (galat) {
      pesan = 'Gagal mengirim: $galat';
    }
    if (!mounted) return;
    setState(() => _mengirim = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(pesan)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usul Buku Perpustakaan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _kontrolJudul,
            decoration: const InputDecoration(
              labelText: 'Judul buku yang diusulkan',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _mengirim ? null : _kirim,
            icon: const Icon(Icons.send),
            label: Text(_mengirim ? 'Mengirim...' : 'Kirim usul'),
          ),
        ],
      ),
    );
  }
}
```

**C3.** Editor menampilkan satu peringatan berwarna kuning. Mengetik `laptop` dengan cepat di kotak pencarian memunculkan **enam** baris `GET ...` di konsol, padahal pencarian seharusnya menunggu pengguna berhenti mengetik. Setelah kesalahan pertama diperbaiki, ketik satu kata lalu **segera** tekan tombol kembali (←) selagi garis memuat masih bergerak: konsol menampilkan *error* berwarna merah. (Agar ringkas, pengambil datanya sengaja ditulis sebagai fungsi biasa tanpa layanan dan *repository*; hal itu bukan kesalahan yang dicari.)

```dart
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(const MaterialApp(home: HalamanAwal()));
}

// Agar ringkas, pengambil data ditulis sebagai fungsi biasa
// (tanpa layanan dan repository).
Future<List<String>> cariProduk(String kataKunci) async {
  final Uri alamat = Uri.https('dummyjson.com', '/products/search', {
    'q': kataKunci,
    'limit': '10',
    'select': 'title',
  });
  debugPrint('GET $alamat');
  final http.Response respons = await http
      .get(alamat, headers: {'Accept': 'application/json'})
      .timeout(const Duration(seconds: 10));
  if (respons.statusCode != 200) {
    throw Exception('Server menjawab dengan kode ${respons.statusCode}');
  }
  return switch (jsonDecode(respons.body)) {
    {'products': List<dynamic> isi} => isi.map(_judulDari).toList(),
    _ => throw const FormatException('Kunci "products" tidak ditemukan'),
  };
}

String _judulDari(dynamic item) {
  return switch (item) {
    {'title': String judul} => judul,
    _ => throw const FormatException('Bentuk data produk tidak sesuai'),
  };
}

class PencarianViewModel extends ChangeNotifier {
  Timer? _penunda;
  int _nomorPermintaan = 0;
  bool _memuat = false;
  String _pesan = 'Ketik nama produk untuk mencari.';
  List<String> _hasil = [];

  bool get memuat => _memuat;
  String get pesan => _pesan;
  List<String> get hasil => List.unmodifiable(_hasil);

  void cari(String teks) {
    _penunda = Timer(
      const Duration(milliseconds: 400),
      () => _muat(teks.trim()),
    );
  }

  Future<void> _muat(String kataKunci) async {
    final int nomor = ++_nomorPermintaan;
    _memuat = true;
    notifyListeners();
    try {
      final List<String> hasil = await cariProduk(kataKunci);
      if (nomor != _nomorPermintaan) {
        return; // jawaban terlambat: ada pencarian yang lebih baru
      }
      _hasil = hasil;
      _pesan = hasil.isEmpty ? 'Produk tidak ditemukan.' : '';
    } catch (galat) {
      if (nomor != _nomorPermintaan) {
        return;
      }
      debugPrint('Galat: $galat');
      _hasil = [];
      _pesan = 'Pencarian gagal. Coba lagi.';
    }
    _memuat = false;
    notifyListeners();
  }
}

class HalamanAwal extends StatelessWidget {
  const HalamanAwal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toko Kampus')),
      body: Center(
        child: FilledButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ChangeNotifierProvider(
                  create: (BuildContext context) => PencarianViewModel(),
                  child: const HalamanCari(),
                ),
              ),
            );
          },
          icon: const Icon(Icons.search),
          label: const Text('Cari produk'),
        ),
      ),
    );
  }
}

class HalamanCari extends StatelessWidget {
  const HalamanCari({super.key});

  @override
  Widget build(BuildContext context) {
    final PencarianViewModel vm = context.watch<PencarianViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Cari Produk')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              autofocus: true,
              onChanged: vm.cari,
              decoration: const InputDecoration(
                hintText: 'Nama produk, misalnya phone',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          if (vm.memuat) const LinearProgressIndicator(),
          if (vm.pesan.isNotEmpty)
            Padding(padding: const EdgeInsets.all(16), child: Text(vm.pesan)),
          Expanded(
            child: ListView(
              children: [
                for (final String judul in vm.hasil)
                  ListTile(title: Text(judul)),
              ],
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

C1: Bagian 4.2 (apa yang diterima `http.get`?) dan Bagian 7.2. C2: Bagian 2.4 dan 11.1; bandingkan baris `Kode status` di konsol sebelum dan sesudah perbaikan pertama. C3: Bagian 10.3 (apa yang terjadi pada `Timer` yang lama?) dan Bagian 13.5 (`_sudahDibuang`); ingat juga bahwa *provider* di dalam rute membuang ViewModel saat halamannya ditutup ([Pertemuan 9 Bagian 10.6 dan 11](../pertemuan_09_state_dan_mvvm/README.md#11-cakupan-dan-umur-provider)).
</details>

---

## D. Menulis Program

Kerjakan setiap soal sebagai **aplikasi utuh** yang bisa dijalankan. Semua permintaan memakai `Uri.https`, batas waktu, dan pemeriksaan kode status. Pengguna hanya melihat pesan galat yang ramah, sedangkan detail teknisnya dicetak ke konsol dengan `debugPrint`.

**D1 — Gempa Terkini.** Buat aplikasi yang menampilkan 15 gempa bermagnitudo 5,0 ke atas yang terakhir terjadi di Indonesia, dari [Data Terbuka BMKG](https://data.bmkg.go.id/gempabumi/):

- Alamat datanya `https://data.bmkg.go.id/DataMKG/TEWS/gempaterkini.json`. Jawabannya berbentuk `{"Infogempa": {"gempa": [ {...}, ... ]}}`, dan setiap gempa punya kunci `Tanggal`, `Jam`, `Magnitude`, `Kedalaman`, `Wilayah`, serta `Potensi`. Buka alamat itu di *browser* untuk melihat bentuk lengkapnya. Perhatikan: nilai `Magnitude` berupa **teks**, misalnya `"5.7"`.
- Model `Gempa` yang *immutable* dengan `factory Gempa.fromJson` berpola Dart 3. Magnitudo disimpan sebagai `double`; data yang bentuknya salah, termasuk magnitudo yang bukan angka, melempar `FormatException`.
- `FutureBuilder` dengan `Future` yang dibuat di `initState`, ikon muat ulang di `AppBar`, serta tampilan memuat, gagal (pesan ramah dan tombol **Coba lagi**), dan berhasil.
- Setiap baris: lingkaran berisi magnitudo dengan koma desimal (misalnya **5,7**) berwarna `errorContainer` jika magnitudonya 6,0 ke atas dan `secondaryContainer` jika di bawahnya, lalu wilayah, tanggal dan jam, kedalaman, serta potensi tsunami.
- Di atas daftar tampil ringkasan, misalnya **"15 gempa · terbesar M 6,2"** (angkanya menyesuaikan data).
- Tulisan **"Sumber data: BMKG"** di bagian bawah halaman. BMKG mewajibkan setiap aplikasi yang memakai datanya menyebutkan sumber ini.

<details>
<summary>💡 Petunjuk D1</summary>

Ikuti Praktikum 2 di Jobsheet (`FutureBuilder`, pola map bertingkat seperti `company`) dan Bagian 8.2 (`pesanRamah`). Teks `"5.7"` bisa diubah dengan `double.tryParse`, yang menghasilkan `null` jika teksnya bukan angka. Untuk mencari magnitudo terbesar, `daftar.map(...).reduce(max)` (`max` dari `dart:math`) sudah cukup.
</details>

**D2 — Piket Lab.** Buat aplikasi daftar tugas piket laboratorium yang **mengubah dan menghapus** data di server DummyJSON, dengan pola MVVM lengkap (layanan, *repository*, ViewModel, dan View):

- Muat 6 tugas dari `https://dummyjson.com/todos?limit=6&select=todo,completed`. Di atas daftar tampil, misalnya, **"2 dari 6 tugas selesai"**.
- Mencentang tugas mengirim `PATCH /todos/{id}` yang isinya **hanya** `{"completed": true}` (atau `false`), lengkap dengan *header* `Content-Type`. Selama menunggu jawaban, kotak centang baris itu diganti lingkaran kecil dan tombol hapusnya nonaktif. Status baru baru tampil **setelah** server menjawab berhasil.
- Ikon tempat sampah membuka dialog konfirmasi, lalu mengirim `DELETE /todos/{id}`. Tugas hilang dari daftar hanya jika jawaban server berisi `"isDeleted": true`.
- Setiap perubahan diakhiri `SnackBar`: "Tugas ditandai selesai.", "Tugas dihapus.", atau pesan ramah jika gagal, misalnya "Tugas tidak ditemukan di server." untuk kode `404`.
- Fungsi `jalankanUji()` yang dijalankan sebelum `runApp` dengan `MockClient`, berisi minimal **5** pemeriksaan: metode dan jalur `PATCH`, isi `PATCH`, status tidak berubah jika server menjawab `404`, tugas tetap ada jika jawaban `DELETE` tidak berisi `isDeleted`, dan tugas hilang jika penghapusan berhasil.

<details>
<summary>💡 Petunjuk D2</summary>

Contoh 09 (Bagian 11.2–11.3) melakukan hal yang sama dengan `setState`; pindahkan logikanya ke ViewModel, lalu simpan id tugas yang sedang menunggu server di sebuah `Set<int>`. Agar `SnackBar` tetap bisa tampil walaupun barisnya sudah hilang, ambil `ScaffoldMessenger.of(context)` **sebelum** `await`. Untuk pemeriksaan, simpan permintaan terakhir yang diterima `MockClient` (Bagian 12.1), lalu periksa `method`, `url.path`, dan `body`-nya.
</details>

**D3 — Etalase Toko per Kategori.** Buat katalog produk DummyJSON yang dikelompokkan per kategori:

- Daftar kategori diambil dari `https://dummyjson.com/products/categories`. Perhatikan: jawabannya berupa **larik** (`[...]`), bukan objek, dan setiap unsurnya punya `slug` serta `name`. Tampilkan sebagai deretan `ChoiceChip` yang bisa digeser ke samping; kategori pertama langsung terpilih.
- Produk kategori terpilih diambil dari `/products/category/{slug}` dengan parameter `limit=6`, `skip`, dan `select=title,price,thumbnail`. Setiap baris menampilkan gambar kecil (`Image.network` lengkap dengan tampilan saat memuat dan saat gagal), judul, dan harga.
- Di bagian bawah daftar tampil, misalnya, **"Menampilkan 6 dari 16 produk"** dan tombol **Muat lebih banyak** selama masih ada produk yang belum ditampilkan.
- Memilih kategori lain mengosongkan daftar lalu memuat halaman pertama kategori itu. Jawaban milik kategori lama yang datang terlambat harus diabaikan.
- Tampilan memuat dan gagal (pesan ramah dan tombol **Coba lagi**) untuk daftar kategori maupun daftar produk.
- Fungsi `jalankanUji()` yang dijalankan sebelum `runApp` dengan `MockClient`, berisi minimal **5** pemeriksaan, termasuk kategori yang dibaca dari larik, nilai `skip` pada halaman kedua, dan jawaban terlambat yang diabaikan.

<details>
<summary>💡 Petunjuk D3</summary>

Ikuti Contoh 07 (Bagian 10) untuk `limit`/`skip`/`total`, nomor permintaan, dan `Image.network`. Layanan yang selalu mengembalikan `Map` akan gagal membaca daftar kategori (lihat Bagian 15, baris `List<dynamic>` dan `Map<String, dynamic>`), jadi biarkan layanan mengembalikan hasil `jsonDecode` apa adanya (`Object?`), lalu *repository* yang memeriksa bentuknya dengan pola. Untuk menguji jawaban terlambat, buat `MockClient` menunda jawaban satu kategori dengan `Future.delayed`, lalu pilih dua kategori berturut-turut tanpa `await` di antaranya.
</details>

---

[⬅️ Kembali ke Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md) · [🏠 Beranda](../README.md)

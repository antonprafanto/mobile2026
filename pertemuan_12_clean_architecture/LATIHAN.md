# ✍️ Latihan Pertemuan 12 — Arsitektur Aplikasi: *Clean Architecture*

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md)

Kerjakan **tanpa membuka modul dan tanpa menjalankan kode** terlebih dahulu. Setelah selesai, buktikan jawaban Anda dengan menjalankan kodenya. Semua kode di bagian B dan C sudah berupa program utuh, jadi bisa langsung ditempel ke [DartPad](https://dartpad.dev) atau ke `lib/main.dart` proyek latihan (jalankan dengan `flutter run -d chrome --web-port=8080`). Paket yang dibutuhkan, `http` dan `provider`, sama dengan [Jobsheet Pertemuan 12](JOBSHEET.md).

> [!NOTE]
> Kunci jawaban tidak dipublikasikan. Petunjuk (💡) menunjukkan **bagian modul** yang relevan. Pembahasan lengkap dilakukan bersama dosen di kelas.
>
> Soal B1–B4 adalah program Dart murni tanpa Flutter: hasilnya tampil di konsol. Semua soal B dan C berjalan **tanpa internet**, karena memakai data palsu. Hanya soal D2 (lingkungan produksi) yang membutuhkan internet.

---

## A. Pilihan Ganda

**1.** Aturan ketergantungan (*Dependency Rule*) dalam *Clean Architecture* berarti ...

- a. lapisan luar tidak boleh mengenal apa pun dari lapisan dalam
- b. ketergantungan kode hanya boleh mengarah ke dalam: lingkaran dalam tidak boleh menyebut apa pun dari lingkaran luar
- c. semua lapisan boleh saling mengimpor, asalkan melalui kontrak
- d. lapisan domain wajib mengimpor lapisan data agar bisa mendapatkan datanya

**2.** Perpustakaan kampus menetapkan bahwa satu mahasiswa paling banyak meminjam 3 buku sekaligus. Aturan ini paling tepat ditulis di ...

- a. `build()` halaman katalog, tepat sebelum tombol **Pinjam** digambar
- b. *repository* server, karena data peminjamannya berasal dari server
- c. lapisan domain, sebagai fungsi Dart murni seperti `periksaPeminjaman()`
- d. fungsi `pesanKegagalan()`, karena aturan itu menghasilkan pesan penolakan

**3.** Berkas `lib/domain/models/kategori.dart` berisi kode berikut.

```dart
import 'package:flutter/material.dart';

class Kategori {
  const Kategori({required this.nama, required this.warna});

  final String nama;
  final Color warna;
}
```

Pernyataan yang paling tepat adalah ...

- a. kode ini benar, karena `Color` pada dasarnya hanyalah sebuah angka
- b. kode ini benar, asalkan impornya diubah menjadi `import 'package:flutter/material.dart' show Color;`
- c. kode ini salah, karena setiap entitas wajib memiliki `operator ==`
- d. kode ini melanggar aturan ketergantungan; simpan nilai sederhana (misalnya `enum`) di domain, lalu tentukan warnanya di lapisan UI

**4.** Dari cara-cara ViewModel mendapatkan *repository* berikut, yang disebut ***dependency injection*** adalah ...

- a. `DaftarRuangViewModel({required this._repositori})`, lalu nilainya diisi dari luar
- b. `final _repositori = RepositoriRuangServer(klien: http.Client());` di dalam ViewModel
- c. `final _repositori = repositoriGlobal;` yang dibuat di luar semua *class*
- d. ViewModel mewarisi `RepositoriRuangServer` dengan `extends`

**5.** Akar komposisi berisi `Provider(create: (BuildContext context) => RepositoriBukuServer())`. Saat ViewModel dibuat dengan `context.read<RepositoriBuku>()`, yang terjadi adalah ...

- a. *provider* itu tetap ditemukan, karena `RepositoriBukuServer` mengimplementasikan `RepositoriBuku`
- b. ViewModel menerima `null`
- c. `ProviderNotFoundException`, karena jenis yang dititipkan adalah `RepositoriBukuServer`, bukan kontraknya
- d. editor langsung memberi garis merah pada baris `Provider(...)`

**6.** Server merilis versi baru yang mengganti nama kolom `room_name` menjadi `name`. Aplikasi sudah memakai model API dan `keDomain()`. Bagian yang **perlu diubah** adalah ...

- a. entitas `Ruang` dan semua widget yang menampilkan nama ruang
- b. hanya model API beserta `fromJson`-nya di lapisan data
- c. ViewModel dan fungsi `pesanKegagalan()`
- d. semua lapisan, karena nama kolomnya berubah

**7.** `petaFasilitas` berisi kunci `'projector'`, tetapi **tidak** berisi kunci `'stage'`.

```dart
final List<Fasilitas> daftar = [
  for (final String f in ['projector', 'stage']) ?petaFasilitas[f],
];
```

Isi `daftar` adalah ...

- a. `[Fasilitas.proyektor, null]`
- b. *exception*, karena kunci `'stage'` tidak ditemukan
- c. `[]`, karena ada kode fasilitas yang tidak dikenal
- d. `[Fasilitas.proyektor]`

**8.** Keuntungan utama *repository* yang mengembalikan `Future<Hasil<List<Ruang>>>`, dibandingkan `Future<List<Ruang>>` yang melempar *exception*, adalah ...

- a. kemungkinan gagal terlihat di tanda tangan fungsi, dan pemanggilnya dipaksa menangani kedua kemungkinan tanpa `try`–`catch`
- b. permintaan ke server menjadi lebih cepat
- c. aplikasi tidak mungkin gagal lagi
- d. ViewModel bisa membaca kode status HTTP secara langsung

**9.** Tim menambahkan `final class TerlaluSering extends Kegagalan`. Begitu berkas disimpan, editor menandai fungsi `pesanKegagalan()` dengan garis merah. Penyebabnya adalah ...

- a. nama *class* turunan `Kegagalan` harus diawali kata `Gagal`
- b. *class* `final` tidak boleh mewarisi *class* `sealed`
- c. `Kegagalan` adalah `sealed`, sehingga `switch` yang belum menangani `TerlaluSering` dianggap tidak lengkap
- d. `TerlaluSering` belum memiliki *constructor* `const`

**10.** Pada arsitektur hari ini, `http.ClientException` diterjemahkan menjadi `TanpaKoneksi()` di ...

- a. View, tepat sebelum `SnackBar` ditampilkan
- b. *repository*, satu-satunya penerjemah *exception*
- c. ViewModel, di dalam `try`–`catch`
- d. entitas, di dalam `fromJson`

**11.** Sebuah *use case* hanya berisi kode berikut.

```dart
class AmbilSemuaBuku {
  AmbilSemuaBuku(this._repositori);

  final RepositoriBuku _repositori;

  Future<Hasil<List<Buku>>> jalankan() => _repositori.semua();
}
```

Pendapat yang paling tepat adalah ...

- a. sudah tepat, karena setiap aksi wajib memiliki *use case*
- b. perlu ditambah `try`–`catch` agar lebih aman
- c. sebaiknya dipindahkan ke lapisan data
- d. berlebihan; ViewModel cukup memakai *repository* secara langsung, karena tidak ada aturan maupun gabungan data dari beberapa *repository*

**12.** *Use case* menerima parameter `DateTime Function()? sekarang`, lalu menyimpannya sebagai `sekarang ?? DateTime.now`. Tujuannya adalah ...

- a. pemeriksaan bisa memakai jam tetap sehingga hasilnya selalu sama, sedangkan aplikasi tetap memakai jam sungguhan
- b. agar pengguna tidak bisa mengubah jam di HP-nya
- c. agar jam hanya dibaca sekali seumur aplikasi
- d. karena `DateTime` tidak boleh dipakai di lapisan domain

**13.** Tombol **Pinjam** memakai `Perintah1`, dan penyimpanan butuh 2 detik. Pengguna mengetuk tombol itu tiga kali dengan cepat. Yang terjadi adalah ...

- a. tiga peminjaman tersimpan, tetapi `SnackBar` hanya muncul sekali
- b. ketukan ketiga membatalkan ketukan pertama
- c. hanya satu peminjaman yang tersimpan, karena penjaga `if (_sedangBerjalan) return;` mengabaikan ketukan kedua dan ketiga
- d. aplikasi berhenti merespons sampai ketiga penyimpanan selesai

**14.** Dalam pemeriksaan *use case*, `RepositoriPeminjamanPalsu` memiliki *field* `int jumlahSimpan` yang bertambah setiap kali `simpan()` dipanggil. Data palsu seperti ini disebut ...

- a. server palsu (`MockClient`)
- b. mata-mata (*spy*); misalnya untuk membuktikan bahwa pengajuan yang ditolak tidak pernah disimpan
- c. akar komposisi
- d. model API

**15.** Proyek akhir Anda terdiri dari tiga halaman dengan satu sumber data dari API, tanpa aturan bisnis yang rumit. Menurut prinsip YAGNI, pilihan yang paling bijak adalah ...

- a. membuat *use case* untuk setiap tombol agar seragam
- b. membuat folder `domain/use_cases/` yang masih kosong sebagai persiapan
- c. membuat model API untuk setiap entitas, walaupun bentuknya sama persis dengan entitasnya
- d. MVVM + *repository* sudah cukup; bagian lain (misalnya `Hasil` atau `main_pengembangan.dart`) ditambahkan hanya jika benar-benar membantu

---

## B. Tebak Hasil

**B1.** Program berikut membandingkan objek nilai `Jam`, yang memiliki `operator ==`, dengan `Ruang`, yang tidak memilikinya.

```dart
// Program konsol, jadi print() boleh dipakai.
// ignore_for_file: avoid_print

class Jam {
  const Jam(this.jam, this.menit);

  final int jam;
  final int menit;

  // Objek tidak diubah; yang dibuat adalah objek BARU.
  Jam tambah(int menitTambahan) {
    final int total = jam * 60 + menit + menitTambahan;
    return Jam(total ~/ 60 % 24, total % 60);
  }

  @override
  bool operator ==(Object other) =>
      other is Jam && other.jam == jam && other.menit == menit;

  @override
  int get hashCode => Object.hash(jam, menit);

  @override
  String toString() =>
      '${jam.toString().padLeft(2, '0')}.${menit.toString().padLeft(2, '0')}';
}

// Tanpa operator == dan hashCode.
class Ruang {
  const Ruang(this.kode);

  final String kode;
}

Ruang buatRuang(String kode) => Ruang(kode);

void main() {
  const Jam mulai = Jam(9, 30);
  final Jam selesai = mulai.tambah(45);
  print('1: $mulai $selesai');
  print(
    '2: ${const Jam(10, 15) == selesai} ${identical(const Jam(10, 15), selesai)}',
  );
  print('3: ${{mulai, mulai.tambah(0), selesai}.length}');
  print(
    '4: ${buatRuang('C-110') == buatRuang('C-110')} '
    '${{buatRuang('C-110'), buatRuang('C-110')}.length}',
  );
  print('5: ${mulai.tambah(900)}');
  print('6: ${const Ruang('A') == const Ruang('A')}');
}
```

- (a) Tuliskan keenam baris yang tampil di konsol.
- (b) Baris `2:` dan baris `4:` sama-sama membandingkan dua objek yang isinya sama, tetapi hasil `==`-nya berbeda. Mengapa?
- (c) Baris `6:` menghasilkan `true`, padahal `Ruang` tidak memiliki `operator ==`. Mengapa hasilnya berbeda dengan baris `4:`?

**B2.** Server mengirim data anggota UKM dalam bahasa Inggris. Lapisan data menerjemahkannya dengan model API.

```dart
import 'dart:convert';

// Program konsol, jadi print() boleh dipakai.
// ignore_for_file: avoid_print

// ---------- Domain ----------
class Anggota {
  const Anggota({required this.nama, required this.peran, required this.umur});

  final String nama;
  final String peran;
  final int umur;

  @override
  String toString() => '$nama ($peran, $umur tahun)';
}

// ---------- Data ----------
const Map<String, String> petaPeran = {
  'student': 'Mahasiswa',
  'lecturer': 'Dosen',
};

class AnggotaApiModel {
  const AnggotaApiModel({
    required this.name,
    required this.role,
    required this.age,
  });

  final String name;
  final String role;
  final int age;

  factory AnggotaApiModel.fromJson(Object? json) {
    return switch (json) {
      {
        'name': final String name,
        'role': final String role,
        'age': final int age,
      } =>
        AnggotaApiModel(name: name, role: role, age: age),
      {'name': final String name, 'role': final String role} => AnggotaApiModel(
        name: name,
        role: role,
        age: 0,
      ),
      _ => throw const FormatException('baris tanpa nama atau peran'),
    };
  }

  // null jika peran belum dikenal aplikasi.
  Anggota? keDomain() {
    final String? peran = petaPeran[role];
    if (peran == null) return null;
    return Anggota(nama: name.trim(), peran: peran, umur: age);
  }
}

void main() {
  final Object? json = jsonDecode('''
[
  {"name": "Rina", "role": "student", "age": 20},
  {"name": " Budi ", "role": "lecturer"},
  {"name": "Sari", "role": "guest", "age": 25},
  {"name": "Dewi", "role": "student", "age": "21"},
  {"role": "student", "age": 19}
]
''');
  final List<Object?> baris = json is List<Object?> ? json : const [];

  for (final Object? b in baris) {
    try {
      final AnggotaApiModel model = AnggotaApiModel.fromJson(b);
      print(model.keDomain() ?? 'dilewati: peran ${model.role}');
    } on FormatException catch (galat) {
      print('rusak: ${galat.message}');
    }
  }

  final List<Anggota> tiga = [
    for (final Object? b in baris.take(3))
      ?AnggotaApiModel.fromJson(b).keDomain(),
  ];
  print('Jumlah anggota dari tiga baris pertama: ${tiga.length}');
}
```

- (a) Tuliskan keenam baris yang tampil di konsol.
- (b) JSON menyebut umur Dewi `"21"`, tetapi hasilnya 0 tahun. Cabang pola mana yang dipilih untuk baris Dewi, dan mengapa cabang pertama tidak dipilih?
- (c) Apa arti tanda `?` di depan `AnggotaApiModel.fromJson(b).keDomain()`? Apa yang terjadi jika `baris.take(3)` diganti `baris.take(5)`?

**B3.** Sebuah *repository* menerjemahkan *exception* dari layanan palsu menjadi `Hasil`. Setiap skenario berakhir dengan cara yang berbeda.

```dart
import 'dart:async';

// Program konsol, jadi print() boleh dipakai.
// ignore_for_file: avoid_print

// ---------- Domain ----------
sealed class Hasil<T> {
  const Hasil();
}

final class Berhasil<T> extends Hasil<T> {
  const Berhasil(this.nilai);

  final T nilai;
}

final class Gagal<T> extends Hasil<T> {
  const Gagal(this.kegagalan);

  final Kegagalan kegagalan;
}

sealed class Kegagalan {
  const Kegagalan();
}

final class TanpaKoneksi extends Kegagalan {
  const TanpaKoneksi();
}

final class WaktuHabis extends Kegagalan {
  const WaktuHabis();
}

final class ServerBermasalah extends Kegagalan {
  const ServerBermasalah(this.kodeStatus);

  final int kodeStatus;
}

final class DataRusak extends Kegagalan {
  const DataRusak();
}

// ---------- Data ----------
class ApiException implements Exception {
  const ApiException(this.kodeStatus);

  final int kodeStatus;
}

class KoneksiPutus implements Exception {
  const KoneksiPutus();
}

// Layanan palsu: setiap skenario berakhir dengan cara berbeda.
Future<int> ambilJumlahRuang(int skenario) async {
  await Future<void>.delayed(const Duration(milliseconds: 10));
  return switch (skenario) {
    1 => 21,
    2 => throw TimeoutException('lambat'),
    3 => throw const ApiException(503),
    4 => throw const ApiException(404),
    5 => throw const FormatException('bukan JSON'),
    6 => throw const KoneksiPutus(),
    _ => throw StateError('salah hitung indeks'),
  };
}

int dipanggil = 0;

Future<Hasil<int>> repositori(int skenario) async {
  dipanggil++;
  try {
    final int jumlah = await ambilJumlahRuang(skenario);
    return Berhasil(jumlah * 2);
  } on TimeoutException {
    return const Gagal(WaktuHabis());
  } on ApiException catch (galat) {
    return Gagal(ServerBermasalah(galat.kodeStatus));
  } on Exception {
    return const Gagal(TanpaKoneksi());
  } finally {
    print('  (skenario $skenario selesai)');
  }
}

// ---------- UI ----------
String teks(Hasil<int> hasil) {
  return switch (hasil) {
    Berhasil(:final int nilai) => 'berhasil: $nilai',
    Gagal(kegagalan: ServerBermasalah(:final int kodeStatus))
        when kodeStatus >= 500 =>
      'server rusak ($kodeStatus)',
    Gagal(kegagalan: ServerBermasalah(:final int kodeStatus)) =>
      'permintaan ditolak ($kodeStatus)',
    Gagal(kegagalan: WaktuHabis()) => 'waktu habis',
    Gagal(kegagalan: TanpaKoneksi()) => 'tanpa koneksi',
    Gagal(kegagalan: DataRusak()) => 'data rusak',
  };
}

Future<void> main() async {
  for (int skenario = 1; skenario <= 7; skenario++) {
    try {
      final Hasil<int> hasil = await repositori(skenario);
      print('$skenario -> ${teks(hasil)}');
    } on StateError catch (galat) {
      print('$skenario -> LOLOS: ${galat.message}');
    }
  }
  print('repositori dipanggil $dipanggil kali');
}
```

- (a) Tuliskan semua baris yang tampil di konsol. Perhatikan urutannya.
- (b) Skenario 5 (`FormatException`) tampil sebagai "tanpa koneksi". Mengapa terjadi salah terjemah? Ubah *repository*-nya agar skenario 5 tampil sebagai "data rusak", sedangkan skenario 6 tetap "tanpa koneksi".
- (c) Skenario 7 tidak diterjemahkan sama sekali dan sampai ke `main`. Mengapa? Mengapa keadaan ini justru **diinginkan**?

**B4.** Sebuah *use case* peminjaman ruang dengan jam yang disuntikkan. Agar ringkas, jam ditulis sebagai bilangan bulat: `9` berarti 09.00. Mula-mula sudah ada satu peminjaman milik `B` pukul 9–11.

```dart
// Program konsol, jadi print() boleh dipakai.
// ignore_for_file: avoid_print

// ---------- Domain ----------
// Jam ditulis sebagai bilangan bulat: 9 berarti 09.00.
class Peminjaman {
  const Peminjaman(this.nim, this.mulai, this.selesai);

  final String nim;
  final int mulai;
  final int selesai;
}

abstract class RepositoriPeminjaman {
  Future<List<Peminjaman>> semua();

  Future<void> simpan(Peminjaman peminjaman);
}

class AjukanPeminjaman {
  AjukanPeminjaman(this._repositori, this._sekarang);

  final RepositoriPeminjaman _repositori;
  final int Function() _sekarang;

  Future<String> jalankan(String nim, int mulai, int selesai) async {
    if (selesai <= mulai) return 'ditolak: jam terbalik';
    if (mulai < _sekarang()) return 'ditolak: sudah lewat';
    final List<Peminjaman> semua = await _repositori.semua();
    for (final Peminjaman p in semua) {
      if (mulai < p.selesai && p.mulai < selesai) {
        return 'ditolak: bentrok ${p.mulai}-${p.selesai}';
      }
    }
    final int aktif = semua
        .where((Peminjaman p) => p.nim == nim && p.selesai > _sekarang())
        .length;
    if (aktif >= 2) return 'ditolak: kuota habis';
    await _repositori.simpan(Peminjaman(nim, mulai, selesai));
    return 'disimpan';
  }
}

// ---------- Data palsu ----------
class RepositoriPalsu implements RepositoriPeminjaman {
  final List<Peminjaman> _data = [const Peminjaman('B', 9, 11)];
  int jumlahSimpan = 0;

  @override
  Future<List<Peminjaman>> semua() async => List.of(_data);

  @override
  Future<void> simpan(Peminjaman peminjaman) async {
    jumlahSimpan++;
    _data.add(peminjaman);
  }
}

Future<void> main() async {
  final RepositoriPalsu repositori = RepositoriPalsu();
  int jam = 8;
  final AjukanPeminjaman ajukan = AjukanPeminjaman(repositori, () => jam);

  print('1: ${await ajukan.jalankan('A', 11, 12)}');
  print('2: ${await ajukan.jalankan('A', 10, 11)}');
  print('3: ${await ajukan.jalankan('A', 13, 12)}');
  print('4: ${await ajukan.jalankan('A', 12, 14)}');
  print('5: ${await ajukan.jalankan('A', 15, 16)}');
  jam = 13;
  print('6: ${await ajukan.jalankan('A', 15, 16)}');
  print('7: ${await ajukan.jalankan('C', 12, 13)}');
  print('simpan dipanggil ${repositori.jumlahSimpan} kali');
}
```

- (a) Tuliskan kedelapan baris yang tampil di konsol.
- (b) Pengajuan 4 (12–14) diterima, padahal pengajuan 1 (11–12) milik orang yang sama sudah tersimpan tepat sebelumnya. Mengapa tidak dianggap bentrok?
- (c) Pengajuan 5 dan 6 sama persis, tetapi hasilnya berbeda. Mengapa? Apa akibatnya pada program ini jika `AjukanPeminjaman` memakai `DateTime.now().hour`, bukan `_sekarang()`?

**B5.** Program berikut memakai `Perintah1` dari modul. Aksinya butuh 100 milidetik, dan `kabar` menghitung berapa kali para pendengar (*listener*) dikabari.

```dart
import 'package:flutter/material.dart';

// ---------- Hasil (versi ringkas) ----------
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

// ---------- Perintah (sama dengan modul) ----------
abstract class Perintah<T> extends ChangeNotifier {
  bool _sedangBerjalan = false;
  Hasil<T>? _hasil;
  bool _sudahDibuang = false;

  bool get sedangBerjalan => _sedangBerjalan;

  Hasil<T>? get hasil => _hasil;

  void bersihkanHasil() {
    _hasil = null;
    _kabari();
  }

  Future<void> _jalankan(Future<Hasil<T>> Function() aksi) async {
    if (_sedangBerjalan) return;
    _sedangBerjalan = true;
    _hasil = null;
    _kabari();
    try {
      _hasil = await aksi();
    } finally {
      _sedangBerjalan = false;
      _kabari();
    }
  }

  void _kabari() {
    if (!_sudahDibuang) notifyListeners();
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    super.dispose();
  }
}

class Perintah1<T, A> extends Perintah<T> {
  Perintah1(this._aksi);

  final Future<Hasil<T>> Function(A) _aksi;

  Future<void> jalankan(A argumen) => _jalankan(() => _aksi(argumen));
}

String teks(Hasil<String>? hasil) {
  return switch (hasil) {
    null => 'kosong',
    Berhasil(:final String nilai) => nilai,
    Gagal(:final String pesan) => 'gagal: $pesan',
  };
}

Future<void> main() async {
  int dikirim = 0;
  final Perintah1<String, String> kirim = Perintah1<String, String>((
    String keperluan,
  ) async {
    dikirim++;
    await Future<void>.delayed(const Duration(milliseconds: 100));
    if (keperluan.isEmpty) throw StateError('keperluan kosong');
    return Berhasil('PJ-00$dikirim');
  });
  int kabar = 0;
  kirim.addListener(() => kabar++);

  final Future<void> ketukan1 = kirim.jalankan('Rapat');
  final Future<void> ketukan2 = kirim.jalankan('Rapat');
  debugPrint('1: ${kirim.sedangBerjalan} $dikirim $kabar');
  await Future.wait([ketukan1, ketukan2]);
  debugPrint('2: ${kirim.sedangBerjalan} $dikirim $kabar ${teks(kirim.hasil)}');
  kirim.bersihkanHasil();
  debugPrint('3: $kabar ${teks(kirim.hasil)}');
  try {
    await kirim.jalankan('');
  } on StateError catch (galat) {
    debugPrint('4: ${galat.message}');
  }
  debugPrint('5: ${kirim.sedangBerjalan} $dikirim $kabar ${teks(kirim.hasil)}');

  runApp(
    const MaterialApp(
      home: Scaffold(body: Center(child: Text('Lihat konsol'))),
    ),
  );
}
```

- (a) Tuliskan kelima baris yang tampil di konsol.
- (b) `jalankan('Rapat')` dipanggil dua kali, tetapi `dikirim` hanya 1. Baris mana di `Perintah` yang menyebabkannya?
- (c) Pada baris `5:`, `sedangBerjalan` sudah kembali `false`, walaupun aksinya melempar *exception*. Bagian mana dari `Perintah` yang membuatnya begitu? Apa akibatnya pada tombol di aplikasi jika bagian itu dihapus?

<details>
<summary>💡 Petunjuk Bagian B</summary>

B1: Bagian 3.1. Untuk baris `6:`, perhatikan `identical()` di baris `2:`: apa bedanya objek yang dibuat dengan `const` dan objek yang dibuat saat program berjalan? B2: Bagian 5.2 dan 5.3; cabang pola dicoba berurutan dari atas, dan `"21"` bertipe `String`. B3: Bagian 6.4; `StateError` adalah `Error`, bukan `Exception`, sedangkan blok `finally` selalu dijalankan. B4: Bagian 3.3 dan 7.2; dua rentang bertumpuk jika yang satu mulai **sebelum** yang lain selesai. B5: Bagian 8.2; perhatikan kapan `_kabari()` dipanggil.
</details>

---

## C. Temukan dan Perbaiki Kesalahannya

Setiap kode berikut mengandung **dua** kesalahan. Untuk setiap kesalahan, jelaskan **pesan atau gejalanya**, **penyebabnya**, dan **perbaikannya**.

**C1.** Aplikasi "Ruang Fakultas" seharusnya menampilkan ruang dari *repository* yang dipilih di akar komposisi. Saat dijalankan, layarnya langsung **merah**. Setelah kesalahan itu diperbaiki, `RepositoriRuangContoh()` di akar komposisi diganti dengan `RepositoriRuangLengkap()`. Seharusnya tampil **7 ruang**, tetapi yang tampil tetap **3 ruang**.

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ---------- Akar komposisi ----------
void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (BuildContext context) => RepositoriRuangContoh()),
        ChangeNotifierProvider(
          create: (BuildContext context) =>
              DaftarRuangViewModel(repositori: context.read<RepositoriRuang>())
                ..muat(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        ),
        home: const HalamanRuang(),
      ),
    ),
  );
}

// ---------- Domain ----------
class Ruang {
  const Ruang({
    required this.kode,
    required this.nama,
    required this.kapasitas,
  });

  final String kode;
  final String nama;
  final int kapasitas;
}

abstract class RepositoriRuang {
  Future<List<Ruang>> semua();
}

// ---------- Data ----------
// Tiga ruang contoh untuk mengembangkan tampilan.
class RepositoriRuangContoh implements RepositoriRuang {
  @override
  Future<List<Ruang>> semua() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const [
      Ruang(kode: 'C-105', nama: 'Ruang Seminar C.105', kapasitas: 80),
      Ruang(kode: 'C-110', nama: 'Ruang Diskusi C.110', kapasitas: 12),
      Ruang(kode: 'LAB-1', nama: 'Laboratorium Komputer 1', kapasitas: 40),
    ];
  }
}

// Data lengkap fakultas: tujuh ruang.
class RepositoriRuangLengkap implements RepositoriRuang {
  @override
  Future<List<Ruang>> semua() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const [
      Ruang(kode: 'A-302', nama: 'Ruang Rapat A.302', kapasitas: 20),
      Ruang(kode: 'AULA', nama: 'Aula Fakultas', kapasitas: 200),
      Ruang(kode: 'B-204', nama: 'Ruang Kelas B.204', kapasitas: 45),
      Ruang(kode: 'C-105', nama: 'Ruang Seminar C.105', kapasitas: 80),
      Ruang(kode: 'C-110', nama: 'Ruang Diskusi C.110', kapasitas: 12),
      Ruang(kode: 'LAB-1', nama: 'Laboratorium Komputer 1', kapasitas: 40),
      Ruang(kode: 'LAB-2', nama: 'Laboratorium Komputer 2', kapasitas: 40),
    ];
  }
}

// ---------- ViewModel ----------
class DaftarRuangViewModel extends ChangeNotifier {
  DaftarRuangViewModel({required RepositoriRuang repositori});

  final RepositoriRuang _repositori = RepositoriRuangContoh();

  List<Ruang> _daftar = [];
  bool _memuat = true;
  bool _sudahDibuang = false;

  List<Ruang> get daftar => _daftar;
  bool get memuat => _memuat;

  Future<void> muat() async {
    final List<Ruang> daftar = await _repositori.semua();
    if (_sudahDibuang) return;
    _daftar = daftar;
    _memuat = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    super.dispose();
  }
}

// ---------- View ----------
class HalamanRuang extends StatelessWidget {
  const HalamanRuang({super.key});

  @override
  Widget build(BuildContext context) {
    final DaftarRuangViewModel vm = context.watch<DaftarRuangViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Ruang Fakultas')),
      body: vm.memuat
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(12),
              children: [
                Text(
                  '${vm.daftar.length} ruang',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                for (final Ruang ruang in vm.daftar)
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.meeting_room_outlined),
                      title: Text(ruang.nama),
                      subtitle: Text(
                        '${ruang.kode} · ${ruang.kapasitas} orang',
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
```

**C2.** Aplikasi "Info Beasiswa" memakai server palsu dengan tiga skenario. Batas waktunya 2 detik, sedangkan skenario **lambat** baru menjawab setelah 5 detik. Ada dua masalah: (1) setelah memilih **lambat**, lingkaran memuat berputar terus tanpa pernah berhenti dan tanpa pesan apa pun; (2) setelah memilih **serverError**, pesan "Server bermasalah (kode 500)." muncul, lalu muncul **lagi dan lagi** setiap kali sakelar **Sembunyikan beasiswa fakultas** diketuk.

```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:provider/provider.dart';

// ---------- Akar komposisi ----------
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => BeasiswaViewModel(
        buatRepositori: (Skenario s) => RepositoriBeasiswa(serverPalsu(s)),
      )..muat(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: const HalamanBeasiswa(),
      ),
    ),
  );
}

// ---------- Domain ----------
class Beasiswa {
  const Beasiswa({required this.nama, required this.penyelenggara});

  final String nama;
  final String penyelenggara;
}

sealed class Hasil<T> {
  const Hasil();
}

final class Berhasil<T> extends Hasil<T> {
  const Berhasil(this.nilai);

  final T nilai;
}

final class Gagal<T> extends Hasil<T> {
  const Gagal(this.kegagalan);

  final Kegagalan kegagalan;
}

sealed class Kegagalan {
  const Kegagalan();
}

final class TanpaKoneksi extends Kegagalan {
  const TanpaKoneksi();
}

final class WaktuHabis extends Kegagalan {
  const WaktuHabis();
}

final class ServerBermasalah extends Kegagalan {
  const ServerBermasalah(this.kodeStatus);

  final int kodeStatus;
}

final class DataRusak extends Kegagalan {
  const DataRusak();
}

// ---------- Data ----------
enum Skenario { normal, lambat, serverError }

// Server palsu: jawabannya ditentukan skenario yang dipilih.
http.Client serverPalsu(Skenario skenario) {
  return MockClient((http.Request permintaan) async {
    switch (skenario) {
      case Skenario.normal:
        return http.Response(
          '[{"name": "Beasiswa Prestasi", "provider": "Fakultas"},'
          ' {"name": "Bantuan UKT", "provider": "Universitas"}]',
          200,
        );
      case Skenario.lambat:
        await Future<void>.delayed(const Duration(seconds: 5));
        return http.Response('[]', 200);
      case Skenario.serverError:
        return http.Response('Internal Server Error', 500);
    }
  });
}

class RepositoriBeasiswa {
  RepositoriBeasiswa(this._klien);

  final http.Client _klien;

  Future<Hasil<List<Beasiswa>>> semua() async {
    try {
      final http.Response respons = await _klien
          .get(Uri.https('api.kampus.example', '/beasiswa'))
          .timeout(const Duration(seconds: 2));
      if (respons.statusCode != 200) {
        return Gagal(ServerBermasalah(respons.statusCode));
      }
      final Object? json = jsonDecode(respons.body);
      return switch (json) {
        final List<Object?> daftar => Berhasil([
          for (final Object? baris in daftar)
            switch (baris) {
              {'name': final String nama, 'provider': final String oleh} =>
                Beasiswa(nama: nama, penyelenggara: oleh),
              _ => throw const FormatException('Baris beasiswa rusak'),
            },
        ]),
        _ => const Gagal(DataRusak()),
      };
    } on http.ClientException {
      return const Gagal(TanpaKoneksi());
    } on FormatException {
      return const Gagal(DataRusak());
    }
  }
}

// ---------- ViewModel ----------
class BeasiswaViewModel extends ChangeNotifier {
  // Repository dibuat oleh akar komposisi, sesuai skenario yang dipilih.
  BeasiswaViewModel({required this._buatRepositori});

  final RepositoriBeasiswa Function(Skenario) _buatRepositori;

  Skenario _skenario = Skenario.normal;
  bool _sembunyikanFakultas = false;
  bool _memuat = false;
  Hasil<List<Beasiswa>>? _hasil;
  bool _sudahDibuang = false;

  Skenario get skenario => _skenario;
  bool get sembunyikanFakultas => _sembunyikanFakultas;
  bool get memuat => _memuat;
  Hasil<List<Beasiswa>>? get hasil => _hasil;

  void pilihSkenario(Skenario skenario) {
    _skenario = skenario;
    muat();
  }

  void ubahSaringan(bool sembunyikan) {
    _sembunyikanFakultas = sembunyikan;
    notifyListeners();
  }

  Future<void> muat() async {
    _memuat = true;
    notifyListeners();
    final Hasil<List<Beasiswa>> hasil = await _buatRepositori(_skenario)
        .semua();
    if (_sudahDibuang) return;
    _hasil = hasil;
    _memuat = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    super.dispose();
  }
}

// ---------- View ----------
String pesanKegagalan(Kegagalan kegagalan) {
  return switch (kegagalan) {
    TanpaKoneksi() => 'Tidak dapat terhubung.',
    WaktuHabis() => 'Server terlalu lama menjawab.',
    ServerBermasalah(:final int kodeStatus) =>
      'Server bermasalah (kode $kodeStatus).',
    DataRusak() => 'Data beasiswa tidak bisa dibaca.',
  };
}

class HalamanBeasiswa extends StatelessWidget {
  const HalamanBeasiswa({super.key});

  @override
  Widget build(BuildContext context) {
    final BeasiswaViewModel vm = context.watch<BeasiswaViewModel>();
    final Hasil<List<Beasiswa>>? hasil = vm.hasil;
    // Pesan kegagalan ditampilkan sebagai SnackBar.
    if (hasil is Gagal<List<Beasiswa>>) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(pesanKegagalan(hasil.kegagalan))),
        );
      });
    }
    final List<Beasiswa> daftar = switch (hasil) {
      Berhasil(:final List<Beasiswa> nilai) => [
        for (final Beasiswa b in nilai)
          if (!vm.sembunyikanFakultas || b.penyelenggara != 'Fakultas') b,
      ],
      _ => const [],
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Info Beasiswa')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Wrap(
            spacing: 8,
            children: [
              for (final Skenario s in Skenario.values)
                ChoiceChip(
                  label: Text(s.name),
                  selected: vm.skenario == s,
                  onSelected: (_) => vm.pilihSkenario(s),
                ),
            ],
          ),
          SwitchListTile(
            title: const Text('Sembunyikan beasiswa fakultas'),
            value: vm.sembunyikanFakultas,
            onChanged: vm.ubahSaringan,
          ),
          if (vm.memuat)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            ),
          for (final Beasiswa b in daftar)
            Card(
              child: ListTile(
                leading: const Icon(Icons.school_outlined),
                title: Text(b.nama),
                subtitle: Text(b.penyelenggara),
              ),
            ),
        ],
      ),
    );
  }
}
```

**C3.** Aplikasi "Peminjaman Alat Lab" membatasi **2 alat** per mahasiswa. Ada dua masalah: (1) ketuk **Pinjam** pada Multimeter tiga kali, dan tunggu tombolnya kembali setiap kali. Ketukan ketiga menampilkan "Batas 2 alat per mahasiswa.", tetapi "Alat yang saya pinjam" tetap bertambah menjadi 3; (2) nyalakan sakelar **Server lab mati**, lalu ketuk **Pinjam**. Tombol-tombolnya bertuliskan "Menyimpan..." dan tidak pernah kembali, bahkan setelah sakelarnya dimatikan lagi.

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ---------- Akar komposisi ----------
const String nimAktif = '2609106011';

void main() {
  final RepositoriAlatPalsu repositori = RepositoriAlatPalsu();
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => AlatViewModel(
        repositori: repositori,
        pinjamAlat: PinjamAlat(repositori),
      )..muat(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        ),
        home: const HalamanAlat(),
      ),
    ),
  );
}

// ---------- Domain ----------
class Alat {
  const Alat({required this.kode, required this.nama, required this.stok});

  final String kode;
  final String nama;
  final int stok;
}

class Peminjaman {
  const Peminjaman({required this.kodeAlat, required this.nim});

  final String kodeAlat;
  final String nim;
}

sealed class Hasil<T> {
  const Hasil();
}

final class Berhasil<T> extends Hasil<T> {
  const Berhasil(this.nilai);

  final T nilai;
}

final class Gagal<T> extends Hasil<T> {
  const Gagal(this.alasan);

  final String alasan;
}

abstract class RepositoriAlat {
  Future<List<Alat>> semuaAlat();

  Future<List<Peminjaman>> semuaPeminjaman();

  Future<void> simpan(Peminjaman peminjaman);
}

const int batasPerMahasiswa = 2;

// USE CASE: memeriksa stok dan batas, lalu menyimpan.
class PinjamAlat {
  PinjamAlat(this._repositori);

  final RepositoriAlat _repositori;

  Future<Hasil<Peminjaman>> jalankan(String nim, String kodeAlat) async {
    final Peminjaman baru = Peminjaman(kodeAlat: kodeAlat, nim: nim);
    await _repositori.simpan(baru);

    final List<Alat> alat = await _repositori.semuaAlat();
    final List<Peminjaman> semua = await _repositori.semuaPeminjaman();
    final Alat dipilih = alat.firstWhere((Alat a) => a.kode == kodeAlat);
    final int dipinjam = semua
        .where((Peminjaman p) => p.kodeAlat == kodeAlat)
        .length;
    if (dipinjam > dipilih.stok) {
      return Gagal('Stok ${dipilih.nama} habis.');
    }
    final int milikSaya = semua.where((Peminjaman p) => p.nim == nim).length;
    if (milikSaya > batasPerMahasiswa) {
      return const Gagal('Batas $batasPerMahasiswa alat per mahasiswa.');
    }
    return Berhasil(baru);
  }
}

// ---------- Data palsu ----------
class RepositoriAlatPalsu implements RepositoriAlat {
  final List<Peminjaman> _peminjaman = [];
  bool putus = false; // true = pura-pura server lab mati

  @override
  Future<List<Alat>> semuaAlat() async => const [
    Alat(kode: 'MM', nama: 'Multimeter', stok: 5),
    Alat(kode: 'OS', nama: 'Osiloskop', stok: 1),
  ];

  @override
  Future<List<Peminjaman>> semuaPeminjaman() async => List.of(_peminjaman);

  @override
  Future<void> simpan(Peminjaman peminjaman) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    // Meniru repository yang lupa menerjemahkan exception.
    if (putus) throw Exception('Koneksi ke server lab terputus');
    _peminjaman.add(peminjaman);
  }
}

// ---------- Perintah ----------
abstract class Perintah<T> extends ChangeNotifier {
  bool _sedangBerjalan = false;
  Hasil<T>? _hasil;
  bool _sudahDibuang = false;

  bool get sedangBerjalan => _sedangBerjalan;
  Hasil<T>? get hasil => _hasil;

  void bersihkanHasil() {
    _hasil = null;
    _kabari();
  }

  Future<void> _jalankan(Future<Hasil<T>> Function() aksi) async {
    if (_sedangBerjalan) return;
    _sedangBerjalan = true;
    _hasil = null;
    _kabari();
    _hasil = await aksi();
    _sedangBerjalan = false;
    _kabari();
  }

  void _kabari() {
    if (!_sudahDibuang) notifyListeners();
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    super.dispose();
  }
}

class Perintah1<T, A> extends Perintah<T> {
  Perintah1(this._aksi);

  final Future<Hasil<T>> Function(A) _aksi;

  Future<void> jalankan(A argumen) => _jalankan(() => _aksi(argumen));
}

// ---------- ViewModel ----------
class AlatViewModel extends ChangeNotifier {
  AlatViewModel({required this._repositori, required this._pinjamAlat}) {
    pinjam = Perintah1<Peminjaman, String>(_pinjam);
  }

  // Khusus latihan ini: ViewModel mengenal versi palsu agar sakelar
  // "Server lab mati" bisa dipakai. Ini BUKAN salah satu kesalahannya.
  final RepositoriAlatPalsu _repositori;
  final PinjamAlat _pinjamAlat;
  late final Perintah1<Peminjaman, String> pinjam;

  List<Alat> _alat = [];
  List<Peminjaman> _peminjaman = [];

  List<Alat> get alat => _alat;
  bool get serverMati => _repositori.putus;

  int dipinjam(Alat alat) =>
      _peminjaman.where((Peminjaman p) => p.kodeAlat == alat.kode).length;

  int get milikSaya =>
      _peminjaman.where((Peminjaman p) => p.nim == nimAktif).length;

  void ubahServerMati(bool mati) {
    _repositori.putus = mati;
    notifyListeners();
  }

  Future<void> muat() async {
    _alat = await _repositori.semuaAlat();
    _peminjaman = await _repositori.semuaPeminjaman();
    notifyListeners();
  }

  Future<Hasil<Peminjaman>> _pinjam(String kodeAlat) async {
    final Hasil<Peminjaman> hasil = await _pinjamAlat.jalankan(
      nimAktif,
      kodeAlat,
    );
    await muat();
    return hasil;
  }

  @override
  void dispose() {
    pinjam.dispose();
    super.dispose();
  }
}

// ---------- View ----------
class HalamanAlat extends StatefulWidget {
  const HalamanAlat({super.key});

  @override
  State<HalamanAlat> createState() => _HalamanAlatState();
}

class _HalamanAlatState extends State<HalamanAlat> {
  late final AlatViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = context.read<AlatViewModel>();
    _vm.pinjam.addListener(_saatPinjamBerubah);
  }

  @override
  void dispose() {
    _vm.pinjam.removeListener(_saatPinjamBerubah);
    super.dispose();
  }

  void _saatPinjamBerubah() {
    final Hasil<Peminjaman>? hasil = _vm.pinjam.hasil;
    if (hasil == null) return;
    _vm.pinjam.bersihkanHasil();
    final String pesan = switch (hasil) {
      Berhasil() => 'Berhasil dipinjam.',
      Gagal(:final String alasan) => alasan,
    };
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(pesan)));
  }

  @override
  Widget build(BuildContext context) {
    final AlatViewModel vm = context.watch<AlatViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Peminjaman Alat Lab')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          SwitchListTile(
            title: const Text('Server lab mati'),
            value: vm.serverMati,
            onChanged: vm.ubahServerMati,
          ),
          Text(
            'Alat yang saya pinjam: ${vm.milikSaya}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          for (final Alat alat in vm.alat)
            Card(
              child: ListTile(
                title: Text(alat.nama),
                subtitle: Text(
                  'Dipinjam ${vm.dipinjam(alat)} dari ${alat.stok}',
                ),
                trailing: ListenableBuilder(
                  listenable: vm.pinjam,
                  builder: (BuildContext context, Widget? child) {
                    final bool sibuk = vm.pinjam.sedangBerjalan;
                    return FilledButton(
                      onPressed: sibuk
                          ? null
                          : () => vm.pinjam.jalankan(alat.kode),
                      child: Text(sibuk ? 'Menyimpan...' : 'Pinjam'),
                    );
                  },
                ),
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

C1: Bagian 4.3, 4.4, dan baris pertama tabel di Bagian 13. Periksa juga apakah parameter *constructor* ViewModel benar-benar dipakai. C2: Bagian 6.4 (daftar `on ...`) dan 8.4 (tanggapan sekali jalan seperti `SnackBar`). C3: Bagian 7.2 (urutan langkah *use case*) dan 8.2 (`try`–`finally`).
</details>

---

## D. Menulis Program

Kerjakan setiap soal sebagai **program utuh** yang bisa dijalankan. Ikuti aturan hari ini: kode domain tidak mengimpor Flutter maupun paket lain, nama *class* implementasi hanya disebut di akar komposisi, dan waktu "sekarang" disuntikkan. Setiap program memiliki fungsi `jalankanUji()` yang mencetak `LULUS` atau `GAGAL`; pada aplikasi Flutter, fungsi ini dijalankan sebelum `runApp`. Seperti [Contoh 08](kode/contoh_08_studi_kasus_pinjam_ruang.dart), beri setiap bagian judul `// ===== BERKAS: lib/... =====` sesuai letaknya jika dipecah menjadi banyak berkas.

**D1 — Kartu Hasil Studi.** "Universitas Contoh" memiliki aturan akademik berikut. Semua aturan ini **rekaan** untuk latihan. Tulis lapisan domainnya sebagai program **Dart murni** (tanpa Flutter), lengkap dengan `main()` yang mencetak kartu hasil studi seorang mahasiswa rekaan selama tiga semester.

- `enum NilaiHuruf` beserta bobotnya: A = 4,00; AB = 3,50; B = 3,00; BC = 2,50; C = 2,00; D = 1,00; E = 0,00.
- Entitas `MataKuliah` (`kode`, `nama`, `sks`) dan `NilaiMataKuliah` (`mataKuliah`, `nilai`, `semester`). Semua *field* `final`.
- **IPS** satu semester = jumlah (bobot × SKS) dibagi jumlah SKS pada semester itu. Semester tanpa mata kuliah memiliki IPS 0, bukan galat.
- **IPK** dihitung dari semua semester, tetapi mata kuliah yang diulang hanya dihitung **sekali**, memakai nilai **terbaiknya**.
- **Beban SKS** semester berikutnya ditentukan IPS semester ini: IPS 3,00 ke atas → 24 SKS; 2,50–2,99 → 21 SKS; 2,00–2,49 → 18 SKS; di bawah 2,00 → 15 SKS.
- **Predikat kelulusan:** "Pujian" jika IPK minimal 3,51, tidak ada nilai D atau E (dilihat dari nilai terbaik setiap mata kuliah), dan lama studi paling lama 8 semester; "Sangat Memuaskan" jika IPK minimal 3,01; "Memuaskan" jika IPK minimal 2,76; selain itu "Cukup".
- IPS dan IPK dibulatkan ke **dua** angka desimal sebelum dibandingkan dengan batas dan sebelum ditampilkan.
- `jalankanUji()` minimal **8** pemeriksaan, termasuk: mata kuliah yang diulang memakai nilai terbaik, IPS tepat 2,50 mendapat 21 SKS, semester kosong tidak menghasilkan galat, dan IPK tinggi dengan satu nilai D yang belum diperbaiki tidak mendapat "Pujian".

<details>
<summary>💡 Petunjuk D1</summary>

Ikuti Bagian 3 dan Praktikum 1 di Jobsheet. *Enum* yang membawa bobot sudah dibahas di [Pertemuan 3 Bagian 8.3](../pertemuan_03_dart_lanjutan/README.md#83-enum-dengan-properti). Untuk nilai terbaik, kelompokkan nilai berdasarkan kode mata kuliah, misalnya dengan `Map<String, NilaiMataKuliah>`. Pembulatan dua desimal: `(x * 100).round() / 100`. Tanpa pembulatan, angka seperti 3,5099999 bisa membuat predikat salah.
</details>

**D2 — Forum Kampus.** Buat aplikasi Flutter yang menampilkan diskusi dari `https://dummyjson.com/posts?limit=20&select=title,body,tags,reactions,views,userId`. Satu baris JSON-nya berbentuk seperti ini:

```json
{
  "id": 1,
  "title": "His mother had always taught him",
  "body": "...",
  "tags": ["history", "american", "crime"],
  "reactions": {"likes": 192, "dislikes": 25},
  "views": 305,
  "userId": 121
}
```

- Model API `PostApiModel` membaca semua kolom, termasuk objek bertingkat `reactions`, lalu `keDomain()` menghasilkan entitas `Diskusi` (`id`, `judul`, `isi`, `label`, `suka`, `tidakSuka`, `dilihat`, `idPenulis`).
- Aturan domain: `skor` = suka − tidak suka, dan diskusi dengan skor minimal 500 ditandai **Populer**.
- `Hasil` dan `Kegagalan` (minimal `TanpaKoneksi`, `WaktuHabis`, `ServerBermasalah`, dan `DataRusak`). *Repository* server memakai batas waktu yang bisa disuntikkan; *repository* palsu berisi minimal 3 diskusi rekaan dan bisa pura-pura gagal.
- Akar komposisi `buatPenyedia(Lingkungan lingkungan)` dengan lingkungan **pengembangan** (data palsu, pita "DATA PALSU") dan **produksi** (DummyJSON).
- Tampilan: kartu berisi judul (paling banyak 2 baris), potongan isi (paling banyak 3 baris), label, jumlah suka, tidak suka, dan dilihat, serta tanda **Populer**. Sediakan saringan label dengan `ChoiceChip` yang daftarnya disusun ViewModel dari label yang muncul, tampilan memuat, tampilan gagal dengan **Coba lagi**, dan `RefreshIndicator`. Lolos uji di lebar **360** tanpa garis kuning-hitam.
- `jalankanUji()` memakai `MockClient`, minimal **6** pemeriksaan: data normal, `reactions` bertingkat terbaca benar, kode 500, bukan JSON, `reactions` tanpa `likes` menjadi `DataRusak`, serta lambat menjadi `WaktuHabis`.

<details>
<summary>💡 Petunjuk D2</summary>

Ikuti Praktikum 2 dan 3 di Jobsheet: bentuk `reactions` sama seperti `address` pada data pengguna, sehingga polanya bisa ditulis bertingkat, misalnya `'reactions': {'likes': final int likes, 'dislikes': final int dislikes}`. Daftar label untuk saringan bisa disusun dengan `{for (final Diskusi d in semua) ...d.label}`, yaitu sebuah `Set` agar tidak ada yang kembar. Untuk dua lingkungan, lihat Bagian 4.6 dan 10.3.
</details>

**D3 — Pendaftaran Kegiatan UKM.** Buat aplikasi Flutter untuk mendaftar kegiatan Unit Kegiatan Mahasiswa (UKM).

- Entitas `Kegiatan` (`id`, `nama`, `waktu` berupa objek nilai `RentangWaktu` dari modul, dan `kuota`) serta `Pendaftaran` (`idKegiatan` dan `nim`).
- Kontrak `RepositoriKegiatan` (semua kegiatan) dan `RepositoriPendaftaran` (pendaftaran milik satu kegiatan, milik satu NIM, dan simpan). Semuanya mengembalikan `Hasil`.
- *Use case* `DaftarKegiatan` dengan jam yang disuntikkan. Pendaftaran ditolak dengan `AturanDilanggar` jika: (1) sudah ditutup, karena pendaftaran paling lambat **24 jam** sebelum kegiatan dimulai; (2) kuota penuh; (3) mahasiswa itu sudah terdaftar di kegiatan yang sama; (4) waktunya bertumpuk dengan kegiatan lain yang sudah ia ikuti; atau (5) ia sudah memiliki **3** kegiatan yang belum dimulai. Pendaftaran yang ditolak tidak boleh tersimpan.
- Data palsu: minimal 4 kegiatan rekaan (dua di antaranya bertumpuk), jeda simpan 1 detik, bisa pura-pura putus, dan mata-mata `jumlahSimpan`.
- Halaman daftar kegiatan: nama, hari dan jam, sisa kuota (misalnya `12 dari 30 kursi terisi`), dan tombol **Daftar** di setiap kegiatan yang memakai `Perintah1`: selama menyimpan, tombol mati dan menampilkan lingkaran kecil, dan ketukan berulang diabaikan. Hasilnya ditampilkan sebagai `SnackBar` lewat *listener*.
- `jalankanUji()` minimal **8** pemeriksaan: kelima aturan di atas, "pendaftaran yang ditolak tidak tersimpan" (dengan mata-mata), "internet mati menjadi `Gagal(TanpaKoneksi())`", dan "dua ketukan cepat hanya tersimpan sekali".

<details>
<summary>💡 Petunjuk D3</summary>

Ikuti Contoh 06 dan 07 (Bagian 7 dan 8) serta Praktikum 4 di Jobsheet. Pemeriksaan tutup: pendaftaran masih dibuka jika `sekarang.isBefore(kegiatan.waktu.mulai.subtract(const Duration(hours: 24)))`. Untuk aturan (4), pakai `bertumpukDengan()` dari `RentangWaktu`. Untuk pemeriksaan "dua ketukan cepat", jalankan dua kali tanpa menunggu, lalu tunggu keduanya: `await Future.wait([perintah.jalankan(id), perintah.jalankan(id)]);`, kemudian periksa bahwa `jumlahSimpan` bernilai 1.
</details>

---

[⬅️ Kembali ke Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md) · [🏠 Beranda](../README.md)

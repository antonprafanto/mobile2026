# ✍️ Latihan Pertemuan 9 — Manajemen State & Pola MVVM

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md)

Kerjakan **tanpa membuka modul dan tanpa menjalankan kode** terlebih dahulu. Setelah selesai, buktikan jawaban Anda dengan menjalankan kodenya di [DartPad](https://dartpad.dev) atau di Chrome. Untuk soal yang berupa potongan kode, lengkapi dulu menjadi aplikasi utuh (`import`, `main`, dan `MaterialApp`), seperti kode di [Jobsheet](JOBSHEET.md). DartPad sudah menyediakan paket `provider`.

> [!NOTE]
> Kunci jawaban tidak dipublikasikan. Petunjuk (💡) menunjukkan **bagian modul** yang relevan. Pembahasan lengkap dilakukan bersama dosen di kelas.

---

## A. Pilihan Ganda

**1.** Data yang paling tepat disimpan sebagai *state* lokal dengan `setState` adalah ...

- a. isi keranjang belanja yang dipakai beberapa halaman
- b. pengguna yang sedang masuk ke aplikasi
- c. pilihan mode gelap untuk seluruh aplikasi
- d. teks yang sedang diketik di kolom pencarian sebuah halaman

**2.** Agar widget yang mendengarkan dibangun ulang, metode pengubah di dalam *class* `ChangeNotifier` harus memanggil ...

- a. `notifyListeners()`
- b. `setState()`
- c. `dispose()`
- d. `build()`

**3.** Data di dalam *class* `ChangeNotifier` sebaiknya dibuat privat (diawali `_`) karena ...

- a. Dart mewajibkan semua *field* bersifat privat
- b. data privat lebih cepat dibaca
- c. data hanya bisa diubah lewat metode yang memanggil `notifyListeners()`, sehingga pengumuman tidak mungkin terlupa
- d. data privat otomatis dibuang saat halaman ditutup

**4.** Widget bawaan Flutter yang membangun ulang sebagian layar setiap kali sebuah `ChangeNotifier` mengumumkan perubahan, tanpa paket tambahan, adalah ...

- a. `LayoutBuilder`
- b. `ListenableBuilder`
- c. `FutureBuilder`
- d. `Consumer`

**5.** `nama` adalah `ValueNotifier<List<String>>` yang berisi `['Ani']`. Baris yang membuat widget pendengarnya dibangun ulang adalah ...

- a. `nama.value.add('Budi');`
- b. `nama.value = nama.value;`
- c. `nama.value.clear();`
- d. `nama.value = [...nama.value, 'Budi'];`

**6.** Di dalam `onPressed`, cara yang tepat memanggil metode `tambah` milik `Keranjang` yang dititipkan dengan *provider* adalah ...

- a. `context.read<Keranjang>().tambah(barang)`
- b. `context.watch<Keranjang>().tambah(barang)`
- c. `context.select((Keranjang k) => k.tambah(barang))`
- d. `Keranjang().tambah(barang)`

**7.** Sebuah widget hanya menampilkan `keranjang.jumlah`. Agar widget itu dibangun ulang **hanya** saat jumlahnya berubah, gunakan ...

- a. `context.read<Keranjang>().jumlah`
- b. `ChangeNotifierProvider.value`
- c. `context.select((Keranjang k) => k.jumlah)`
- d. `context.watch<Keranjang>().jumlah`

**8.** Fungsi parameter `child` milik `Consumer` adalah ...

- a. widget yang dibangun ulang setiap kali objek berubah
- b. widget yang dibuat sekali di luar `builder`, lalu diberikan lagi kepada `builder` setiap kali dijalankan
- c. widget pengganti yang tampil saat *provider* tidak ditemukan
- d. widget yang dibuang saat objeknya berubah

**9.** `ChangeNotifierProvider` untuk keranjang dipasang **di atas** `MaterialApp` agar ...

- a. halaman yang dibuka dengan `Navigator.push` juga bisa memakai keranjang yang sama
- b. aplikasi berjalan lebih cepat
- c. keranjang dibuat ulang setiap kali pindah halaman
- d. keranjang tidak perlu ditulis sebagai `ChangeNotifier`

**10.** Pernyataan yang **benar** tentang `ChangeNotifierProvider(create: ...)` adalah ...

- a. `create` dipanggil setiap kali widget di bawahnya dibangun ulang
- b. objek yang dibuat di `create` dibuang (`dispose`) otomatis saat *provider* dilepas dari pohon widget
- c. `create` harus mengembalikan objek yang sudah dibuat di tempat lain
- d. hasilnya sama persis dengan `ChangeNotifierProvider.value`

**11.** Dalam pola MVVM, logika "menyaring daftar berdasarkan kata kunci dan kategori" sebaiknya ditulis di ...

- a. View
- b. Model
- c. `main()`
- d. ViewModel

**12.** Peran *repository* dalam aplikasi adalah ...

- a. menggambar widget daftar
- b. menyimpan tema aplikasi
- c. menyediakan data bagi ViewModel, apa pun sumber datanya
- d. menggantikan `Navigator`

**13.** Status memuat sebaiknya ditulis sebagai `enum StatusMuat { memuat, berhasil, gagal }` daripada beberapa `bool`, karena ...

- a. beberapa `bool` bisa saling bertentangan, misalnya "memuat" dan "gagal" bernilai `true` bersamaan
- b. `enum` otomatis memanggil `notifyListeners()`
- c. `bool` tidak bisa dipakai di dalam `ChangeNotifier`
- d. `enum` lebih cepat ditampilkan

**14.** Penjaga `_sudahDibuang` di dalam ViewModel berguna untuk mencegah ...

- a. ViewModel dibuat dua kali
- b. data dimuat dua kali bersamaan
- c. `notifyListeners()` dipanggil setelah ViewModel dibuang, karena halamannya ditutup selama menunggu `await`
- d. *repository* melempar galat

**15.** ViewModel halaman formulir yang harus selalu dimulai dari keadaan kosong setiap kali halamannya dibuka sebaiknya dititipkan ...

- a. di atas `MaterialApp`
- b. sebagai variabel global di `main()`
- c. di dalam ViewModel lain
- d. di dalam `builder` rute halaman formulir itu

---

## B. Tebak Hasil

**B1.** Perhatikan *class* berikut.

```dart
class Penghitung extends ChangeNotifier {
  int _nilai = 0;

  int get nilai => _nilai;

  void tambahSatu() {
    _nilai++;
    notifyListeners();
  }

  void tambahSepuluh() {
    _nilai += 10;
  }
}
```

Halaman menampilkan `Text('${_hitung.nilai}')` di dalam `ListenableBuilder(listenable: _hitung, ...)`. Tombol **A** memanggil `_hitung.tambahSatu`, dan tombol **B** memanggil `_hitung.tambahSepuluh`. Halaman itu sama sekali tidak memanggil `setState`.

Pengguna menekan tombol berurutan: **A, B, B, A**. Tuliskan angka yang **tampil di layar** setelah setiap ketukan, lalu jelaskan mengapa.

**B2.** Tuliskan empat baris yang tampil di konsol.

```dart
import 'package:flutter/foundation.dart';

void main() {
  final ValueNotifier<List<int>> angka = ValueNotifier<List<int>>([1]);
  int pengumuman = 0;
  angka.addListener(() => pengumuman++);

  angka.value.add(2); // baris 1
  debugPrint('1: $pengumuman ${angka.value}');
  angka.value = [...angka.value]; // baris 2
  debugPrint('2: $pengumuman ${angka.value}');
  angka.value = angka.value; // baris 3
  debugPrint('3: $pengumuman ${angka.value}');
  angka.value = []; // baris 4
  debugPrint('4: $pengumuman ${angka.value}');
}
```

**B3.** `Skor` dititipkan dengan `ChangeNotifierProvider` di atas `MaterialApp`.

```dart
class Skor extends ChangeNotifier {
  int _a = 0;
  int _b = 0;

  int get a => _a;
  int get b => _b;
  String get pemimpin {
    if (_a == _b) {
      return 'Seri';
    }
    return _a > _b ? 'A' : 'B';
  }

  void golA() {
    _a++;
    notifyListeners();
  }

  void golB() {
    _b++;
    notifyListeners();
  }
}
```

Halaman berisi empat widget `const` yang **tidak** saling membungkus. Setiap widget mencatat berapa kali `build`-nya dijalankan.

| Widget | Cara membaca `Skor` di dalam `build` |
| :--- | :--- |
| `KartuW` | `final Skor skor = context.watch<Skor>();` |
| `KartuX` | `final int a = context.select((Skor skor) => skor.a);` |
| `KartuY` | `final String pemimpin = context.select((Skor skor) => skor.pemimpin);` |
| `TombolZ` | Tidak membaca di `build`; tombolnya memanggil `context.read<Skor>().golA()` dan `context.read<Skor>().golB()` |

Pengguna menekan berurutan: **Gol A, Gol A, Gol B, Gol B, Gol B**. Berapa kali `build` setiap widget dijalankan, **termasuk** saat pertama kali tampil? Jelaskan untuk masing-masing.

**B4.** Halaman A membuka halaman B dengan kode berikut. Konstruktor `FormViewModel` mencetak `FormViewModel dibuat`, dan `dispose`-nya mencetak `FormViewModel dibuang`.

```dart
Navigator.push(
  context,
  MaterialPageRoute<void>(
    builder: (BuildContext context) => ChangeNotifierProvider(
      create: (BuildContext context) => FormViewModel(),
      child: const HalamanB(),
    ),
  ),
);
```

Halaman B menampilkan `Jumlah: ...` dengan `context.watch<FormViewModel>()` dan punya tombol **Tambah** serta tombol **Buka C**. Halaman C dibuka dari B dengan `Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => const HalamanC()))`, lalu menampilkan `Ringkasan: ... orang` dengan `context.watch<FormViewModel>().jumlah`.

- (a) Pengguna membuka B, kembali ke A, lalu membuka B lagi. Tuliskan urutan pesan di konsol.
- (b) Di B, pengguna menekan **Tambah** dua kali, lalu **Buka C**. Apa yang tampil di halaman C, dan mengapa?
- (c) Perbaiki kode **Buka C** agar halaman C menampilkan `Ringkasan: 3 orang`, **tanpa** memindahkan *provider* ke atas `MaterialApp`.

**B5.** Perhatikan *repository* dan ViewModel berikut. Percobaan **ganjil** sengaja gagal.

```dart
class RepositoriPalsu {
  int _percobaan = 0;

  Future<List<String>> ambil() async {
    _percobaan++;
    await Future<void>.delayed(const Duration(seconds: 1));
    if (_percobaan.isOdd) {
      throw Exception('Koneksi terputus');
    }
    return ['Data 1', 'Data 2'];
  }
}
```

```dart
Future<void> muat() async {
  _status = StatusMuat.memuat;
  notifyListeners();
  try {
    _data = await _repositori.ambil();
    _status = StatusMuat.berhasil;
  } catch (galat) {
    debugPrint('Galat: $galat');
    _status = StatusMuat.gagal;
  }
  notifyListeners();
}
```

Di `main`, ViewModel dibuat, `muat()` langsung dipanggil (detik ke-0), lalu `muat()` dipanggil lagi tepat pada detik ke-2. Lengkapi tabel berikut:

| Waktu | `status` | Jumlah `data` |
| :---: | :---: | :---: |
| 0,5 detik | ... | ... |
| 1,5 detik | ... | ... |
| 2,5 detik | ... | ... |
| 3,5 detik | ... | ... |

Pesan apa yang tampil di konsol, dan kira-kira pada detik ke berapa?

<details>
<summary>💡 Petunjuk Bagian B</summary>

B1: Bagian 3.2 dan Cek Cepat di Bagian 3. B2: Bagian 5.2 dan Cek Cepat di Bagian 5 (`ValueNotifier` membandingkan objek, bukan isinya). B3: Bagian 7.3; untuk `KartuY`, catat nilai `pemimpin` setelah setiap gol. B4: Bagian 11.2 dan 11.4. B5: Bagian 10.3; ingat bahwa `muat()` mengubah status menjadi `memuat` **sebelum** `await`.
</details>

---

## C. Temukan dan Perbaiki Kesalahannya

Setiap kode berikut mengandung **dua** kesalahan. Untuk setiap kesalahan, jelaskan **pesan atau gejalanya**, **penyebabnya**, dan **perbaikannya**.

**C1.** Tombol **Ambil nomor** tidak mengubah layar. Setelah kesalahan pertama diperbaiki, tombol **Mulai hari baru** tampak tidak bekerja.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: HalamanAntrean()));
}

class AntreanFotokopi extends ChangeNotifier {
  int nomor = 0;
  final List<String> _riwayat = [];

  List<String> get riwayat => _riwayat;

  void ambil() {
    nomor++;
    _riwayat.add('F${nomor.toString().padLeft(3, '0')}');
  }
}

class HalamanAntrean extends StatefulWidget {
  const HalamanAntrean({super.key});

  @override
  State<HalamanAntrean> createState() => _HalamanAntreanState();
}

class _HalamanAntreanState extends State<HalamanAntrean> {
  final AntreanFotokopi _antrean = AntreanFotokopi();

  @override
  void dispose() {
    _antrean.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Antrean Fotokopi')),
      body: ListenableBuilder(
        listenable: _antrean,
        builder: (BuildContext context, Widget? child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Nomor terakhir: ${_antrean.nomor}'),
              Text('Riwayat: ${_antrean.riwayat.join(', ')}'),
              FilledButton(
                onPressed: _antrean.ambil,
                child: const Text('Ambil nomor'),
              ),
              TextButton(
                onPressed: () {
                  _antrean.nomor = 0;
                  _antrean.riwayat.clear();
                },
                child: const Text('Mulai hari baru'),
              ),
            ],
          );
        },
      ),
    );
  }
}
```

**C2.** Menekan **Pinjam** memunculkan *error* di konsol dan bukunya tidak terpinjam. Setelah kesalahan pertama diperbaiki, tombol berubah menjadi **Dipinjam**, tetapi judul `AppBar` tetap "Dipinjam: 0 buku".

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => DaftarPinjam(),
      child: const MaterialApp(home: HalamanBuku()),
    ),
  );
}

class DaftarPinjam extends ChangeNotifier {
  final List<String> _judul = [];

  int get jumlah => _judul.length;
  bool sudahDipinjam(String judul) => _judul.contains(judul);

  void pinjam(String judul) {
    if (_judul.contains(judul)) {
      return;
    }
    _judul.add(judul);
    notifyListeners();
  }
}

const List<String> daftarBuku = [
  'Dasar Pemrograman Dart',
  'Flutter untuk Pemula',
  'Basis Data Terapan',
];

class HalamanBuku extends StatelessWidget {
  const HalamanBuku({super.key});

  @override
  Widget build(BuildContext context) {
    final int jumlah = context.read<DaftarPinjam>().jumlah;

    return Scaffold(
      appBar: AppBar(title: Text('Dipinjam: $jumlah buku')),
      body: ListView(
        children: [
          for (final String judul in daftarBuku) BarisBuku(judul: judul),
        ],
      ),
    );
  }
}

class BarisBuku extends StatelessWidget {
  const BarisBuku({super.key, required this.judul});

  final String judul;

  @override
  Widget build(BuildContext context) {
    final bool dipinjam = context.select(
      (DaftarPinjam daftar) => daftar.sudahDipinjam(judul),
    );
    return ListTile(
      title: Text(judul),
      trailing: FilledButton(
        onPressed: dipinjam
            ? null
            : () => context.watch<DaftarPinjam>().pinjam(judul),
        child: Text(dipinjam ? 'Dipinjam' : 'Pinjam'),
      ),
    );
  }
}
```

**C3.** Mengetik di kolom teks memunculkan *error* di konsol, dan tombol **Simpan** tidak bekerja. Setelah kesalahan pertama diperbaiki, catatan bisa disimpan, tetapi **semuanya hilang** setiap kali mode gelap dinyalakan atau dimatikan.

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => Pengaturan(),
      child: const AplikasiCatatan(),
    ),
  );
}

class Pengaturan extends ChangeNotifier {
  bool _gelap = false;

  bool get gelap => _gelap;

  void ubahGelap(bool gelap) {
    _gelap = gelap;
    notifyListeners();
  }
}

class DaftarCatatan extends ChangeNotifier {
  final List<String> _isi = [];

  List<String> get isi => List.unmodifiable(_isi);

  void tambah(String catatan) {
    _isi.add(catatan);
    notifyListeners();
  }
}

class AplikasiCatatan extends StatelessWidget {
  const AplikasiCatatan({super.key});

  @override
  Widget build(BuildContext context) {
    final bool gelap = context.watch<Pengaturan>().gelap;

    return ChangeNotifierProvider.value(
      value: DaftarCatatan(),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: gelap ? ThemeMode.dark : ThemeMode.light,
        home: const HalamanCatatan(),
      ),
    );
  }
}

class HalamanCatatan extends StatelessWidget {
  const HalamanCatatan({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TeksBaru(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Catatan (${context.watch<DaftarCatatan>().isi.length})'),
          actions: [
            Switch(
              value: context.watch<Pengaturan>().gelap,
              onChanged: (bool nilai) {
                context.read<Pengaturan>().ubahGelap(nilai);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            TextField(
              onChanged: (String teks) => context.read<TeksBaru>().ubah(teks),
            ),
            FilledButton(
              onPressed: () {
                final String teks = context.read<TeksBaru>().teks;
                context.read<DaftarCatatan>().tambah(teks);
              },
              child: const Text('Simpan'),
            ),
            for (final String catatan in context.watch<DaftarCatatan>().isi)
              ListTile(title: Text(catatan)),
          ],
        ),
      ),
    );
  }
}

class TeksBaru extends ChangeNotifier {
  String _teks = '';

  String get teks => _teks;

  void ubah(String teks) {
    _teks = teks;
    notifyListeners();
  }
}
```

<details>
<summary>💡 Petunjuk Bagian C</summary>

C1: Bagian 3.2 (mengapa data harus privat) dan Bagian 6.4 Langkah 1 (`UnmodifiableListView`). C2: Bagian 7.2 dan 7.5. C3: Bagian 11.4 (*context* yang berada di atas *provider*), Bagian 2 (teks yang sedang diketik termasuk *state* apa?), dan Bagian 6.5 (`create` atau `.value`?). Perhatikan juga kapan `AplikasiCatatan` dibangun ulang.
</details>

---

## D. Menulis Program

Kerjakan setiap soal sebagai **aplikasi utuh** yang bisa dijalankan. Warna diambil dari tema, dan semua aturan atau perhitungan ditulis di objek *state*/ViewModel, bukan di widget.

**D1 — Skor Bulu Tangkis.** Buat papan skor satu *game* bulu tangkis memakai `ChangeNotifier` dan `ListenableBuilder` (**tanpa** paket `provider`):

- Dua kartu skor (Pemain A dan Pemain B), masing-masing dengan tombol **+1**.
- Aturan resmi: *game* selesai jika seorang pemain mencapai **21 poin dengan selisih minimal 2**. Jika skor 20–20, permainan berlanjut sampai ada selisih 2, tetapi pemain yang lebih dulu mencapai **30** langsung menang (misalnya 30–29).
- Setelah *game* selesai, tombol **+1** nonaktif dan muncul tulisan "Pemain A menang 21–19". Poin yang ditambahkan setelah selesai harus diabaikan oleh objek *state*, bukan hanya oleh tombol.
- Tombol **Batalkan poin terakhir** (nonaktif jika belum ada poin) dan **Ulang**.
- Fungsi `jalankanUji()` yang dijalankan di `main` sebelum `runApp`, berisi minimal **5** pemeriksaan, termasuk 21–19, 20–20, 22–20, 29–29, dan 30–29.

<details>
<summary>💡 Petunjuk D1</summary>

Pola objek, halaman, dan `dispose` ada di Contoh 02 (Bagian 3–4). Simpan urutan poin (misalnya `List<String>` berisi `'A'`/`'B'`) agar poin terakhir bisa dibatalkan. Untuk pemeriksaan, buat objek baru lalu panggil metodenya berulang kali (Bagian 12): hati-hati, menambah 21 poin untuk A sekaligus akan menyelesaikan *game* sebelum B sempat mendapat poin.
</details>

**D2 — Daftar Belanja Kos.** Buat aplikasi dua halaman dengan `ChangeNotifierProvider` di atas `MaterialApp`:

- Model `Barang` yang *immutable*: `id`, `nama`, `jumlah`, dan `sudahDibeli`. Mengubah status berarti **mengganti** objek lama dengan objek baru.
- Halaman daftar: `CheckboxListTile` untuk menandai sudah dibeli, geser untuk menghapus (`Dismissible`), `SwitchListTile` **"Sembunyikan yang sudah dibeli"**, dan ikon di `AppBar` berlencana **jumlah barang yang belum dibeli** (dibaca dengan `context.select`).
- Halaman tambah: kolom nama (wajib) dan jumlah (angka **1–20**). Setelah disimpan, halaman ditutup dan halaman daftar menampilkan `SnackBar` "Barang ditambahkan."
- Siapkan tiga barang awal, salah satunya sudah dibeli.

<details>
<summary>💡 Petunjuk D2</summary>

Gabungkan pola Contoh 04 (keranjang di atas `MaterialApp`), Contoh 07 (formulir dan hasil `Navigator.pop`), dan Pertemuan 6 Bagian 7 (`Dismissible` dengan `Key` dari `id`). Untuk model *immutable*, tambahkan metode di `Barang` yang mengembalikan salinan dengan status dibalik.
</details>

**D3 — Jadwal Praktikum.** Buat aplikasi dengan pola MVVM lengkap:

- Model `Jadwal` (mata kuliah, hari berupa `enum` Senin–Jumat, jam, ruang, asisten) dan minimal **5** data.
- *Repository* palsu dengan kontrak `abstract class`, jeda 1 detik, dan percobaan **pertama** sengaja gagal.
- ViewModel dengan status memuat–berhasil–gagal, hari terpilih (awalnya Senin), *getter* jadwal hari terpilih yang **urut dari jam paling pagi**, dan jumlah jadwal per hari.
- View: *chip* untuk setiap hari bertuliskan jumlahnya, misalnya "Senin (2)", tampilan untuk ketiga status, dan tombol muat ulang yang nonaktif selama memuat.
- Fungsi `jalankanUji()` dengan minimal **4** pemeriksaan, memakai *repository* khusus pemeriksaan tanpa jeda.

<details>
<summary>💡 Petunjuk D3</summary>

Ikuti Contoh 08 (Bagian 10) untuk *repository*, status, dan `_sudahDibuang`, serta Praktikum 4 di Jobsheet untuk pemeriksaan yang memakai `await`. Jam yang ditulis dua digit ("08.00", "13.00") bisa diurutkan dengan `compareTo` biasa.
</details>

---

[⬅️ Kembali ke Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md) · [🏠 Beranda](../README.md)

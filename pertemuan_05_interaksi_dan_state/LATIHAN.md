# ✍️ Latihan Pertemuan 5 — Interaksi Pengguna & *State* Lokal

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md)

Kerjakan **tanpa membuka modul dan tanpa menjalankan kode** terlebih dahulu. Setelah selesai, buktikan jawaban Anda dengan menjalankan kodenya di [DartPad](https://dartpad.dev). Untuk soal bagian B, lengkapi potongan kodenya menjadi aplikasi utuh dengan kerangka dari [Jobsheet](JOBSHEET.md#kerangka-aplikasi-dipakai-di-semua-praktikum).

> [!NOTE]
> Kunci jawaban tidak dipublikasikan. Petunjuk (💡) menunjukkan **bagian modul** yang relevan. Pembahasan lengkap dilakukan bersama dosen di kelas.

---

## A. Pilihan Ganda

**1.** Data yang bisa berubah selama aplikasi dibuka, dan perubahannya harus terlihat di layar, disebut ...

- a. widget
- b. *constraints*
- c. *state*
- d. tema

**2.** Fungsi `setState()` dipakai untuk ...

- a. mengubah data, lalu meminta Flutter menjalankan `build()` lagi
- b. membuat objek *State* yang baru
- c. menyimpan data ke memori ponsel secara permanen
- d. menghapus widget dari layar

**3.** Pada sebuah `StatefulWidget`, variabel penghitung yang nilainya terus berubah diletakkan di ...

- a. *class* widget, sebagai properti `final`
- b. fungsi `main()`
- c. `MaterialApp`
- d. *class State*

**4.** Penulisan yang membuat sebuah `FilledButton` **nonaktif** adalah ...

- a. `onPressed: () {}`
- b. `onPressed: false`
- c. `onPressed: null`
- d. `enabled: false`

**5.** *Method* siklus hidup yang dipanggil **sekali saja** saat objek *State* dibuat, dan cocok untuk menyiapkan nilai awal, adalah ...

- a. `build()`
- b. `initState()`
- c. `didUpdateWidget()`
- d. `dispose()`

**6.** Urutan yang benar saat sebuah `StatefulWidget` pertama kali muncul di layar adalah ...

- a. `initState()` → `createState()` → `build()`
- b. `build()` → `initState()` → `dispose()`
- c. `createState()` → `build()` → `initState()`
- d. `createState()` → `initState()` → `didChangeDependencies()` → `build()`

**7.** Sebuah `TextEditingController` yang dibuat di *class State* wajib dibuang di ...

- a. `dispose()`
- b. `build()`
- c. `initState()`
- d. `main()`

**8.** Sebuah *validator* menandakan bahwa isian sudah **benar** dengan mengembalikan ...

- a. `true`
- b. `''` (teks kosong)
- c. `null`
- d. `'OK'`

**9.** Widget untuk memilih **satu** dari beberapa pilihan yang berdampingan, dengan parameter `selected` berupa `Set`, adalah ...

- a. `Checkbox`
- b. `SegmentedButton`
- c. `Slider`
- d. `FilterChip`

**10.** Mengapa perlu menulis `if (!mounted) return;` setelah `await showDialog(...)`?

- a. Agar dialog muncul lebih cepat
- b. Agar semua *validator* dijalankan
- c. Agar tombol di halaman menjadi nonaktif
- d. Karena halaman bisa saja sudah ditutup selama menunggu jawaban

**11.** Pengguna menutup dialog dengan mengetuk area gelap di sekitarnya. Nilai yang diterima dari `await showDialog<bool>(...)` adalah ...

- a. `null`
- b. `true`
- c. `false`
- d. Aplikasi *error*

**12.** Dalam pola mengangkat *state*, widget anak memberi tahu induknya bahwa tombolnya ditekan melalui ...

- a. variabel global
- b. *callback*, misalnya `VoidCallback`
- c. `setState()` milik anak
- d. `GlobalKey`

<details>
<summary>💡 Petunjuk Bagian A</summary>

Soal 1 → Bagian 1.1 · Soal 2 → Bagian 2.2 · Soal 3 → Bagian 2.1 · Soal 4 → Bagian 2.4 · Soal 5 dan 6 → Bagian 7.2 · Soal 7 → Bagian 8.3 · Soal 8 → Bagian 9.2 · Soal 9 → Bagian 6.1 · Soal 10 → Bagian 10.2 · Soal 11 → Bagian 10.1 · Soal 12 → Bagian 11.2
</details>

---

## B. Tebak Hasil

**B1.** Perhatikan potongan *class State* berikut.

```dart
int _angka = 0;

// ... di dalam build():
Column(
  children: [
    Text('$_angka'),
    TextButton(
      onPressed: () {
        setState(() {
          _angka += 2;
        });
      },
      child: const Text('A'),
    ),
    TextButton(
      onPressed: () {
        _angka++;
      },
      child: const Text('B'),
    ),
  ],
)
```

Tombol ditekan berurutan: **A, A, B, B, B, A**. Angka berapa yang **tampil di layar** setelah tekanan ke-2, ke-5, dan ke-6?

**B2.** Halaman induk menampilkan widget `Lampu` dan dua tombol.

```dart
// Di dalam State milik halaman induk:
bool _tampil = true;
String _warna = 'merah';

// ... di dalam build() milik induk:
Column(
  children: [
    TextButton(
      onPressed: () {
        setState(() {
          _warna = 'hijau';
        });
      },
      child: const Text('Ganti'),
    ),
    TextButton(
      onPressed: () {
        setState(() {
          _tampil = false;
        });
      },
      child: const Text('Sembunyikan'),
    ),
    if (_tampil) Lampu(warna: _warna),
  ],
)
```

```dart
class Lampu extends StatefulWidget {
  const Lampu({super.key, required this.warna});

  final String warna;

  @override
  State<Lampu> createState() => _LampuState();
}

class _LampuState extends State<Lampu> {
  @override
  void initState() {
    super.initState();
    debugPrint('init ${widget.warna}');
  }

  @override
  void didUpdateWidget(Lampu lama) {
    super.didUpdateWidget(lama);
    debugPrint('update ${lama.warna} -> ${widget.warna}');
  }

  @override
  void dispose() {
    debugPrint('dispose ${widget.warna}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build ${widget.warna}');
    return Text(widget.warna);
  }
}
```

Aplikasi dibuka, lalu tombol **Ganti** ditekan, lalu tombol **Sembunyikan** ditekan. Tuliskan seluruh catatan yang muncul di konsol, **berurutan**.

**B3.** Apa hasil `_cekKodePos('')`, `_cekKodePos('7511')`, `_cekKodePos('75119')`, dan `_cekKodePos('75a19')`?

```dart
String? _cekKodePos(String? isian) {
  final String teks = isian?.trim() ?? '';
  if (teks.isEmpty) return 'Kode pos wajib diisi';
  if (teks.length != 5) return 'Kode pos harus 5 angka';
  if (int.tryParse(teks) == null) return 'Kode pos hanya boleh angka';
  return null;
}
```

**B4.** Sebuah halaman pemesanan jus memakai *getter* berikut. Saat ini `_ukuranBesar` bernilai `true`, `_hargaTopping` berisi `{3000, 2000}`, dan `_jumlah` bernilai `3`. Tulisan apa yang tampil pada tombol `Text('Pesan · ${formatRupiah(_total)}')`?

```dart
const int hargaDasar = 12000;

int get _hargaSatuan {
  int harga = hargaDasar;
  if (_ukuranBesar) {
    harga += 4000;
  }
  for (int topping in _hargaTopping) {
    harga += topping;
  }
  return harga;
}

int get _total => _hargaSatuan * _jumlah;
```

**B5.** Tuliskan isi `_keterangan` setelah pengguna (a) menekan **Ya**, (b) menekan **Tidak**, dan (c) mengetuk area gelap di luar dialog.

```dart
Future<void> _simpan() async {
  final bool? hasil = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Simpan perubahan?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Tidak'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ya'),
          ),
        ],
      );
    },
  );
  if (!mounted) return;
  setState(() {
    if (hasil == true) {
      _keterangan = 'Disimpan';
    } else if (hasil == false) {
      _keterangan = 'Dibatalkan';
    } else {
      _keterangan = 'Ditutup tanpa memilih';
    }
  });
}
```

**B6.** Pengguna mengetik `halo` di kolom, lalu menekan tombol **Hapus**. Apa yang terlihat (a) di dalam kolom dan (b) pada teks di bawahnya? Jelaskan mengapa.

```dart
final TextEditingController _kontrol = TextEditingController();
String _salinan = '';

// ... di dalam build():
Column(
  children: [
    TextField(
      controller: _kontrol,
      onChanged: (String teks) {
        setState(() {
          _salinan = teks;
        });
      },
    ),
    Text('Salinan: $_salinan'),
    TextButton(
      onPressed: () {
        _kontrol.clear();
      },
      child: const Text('Hapus'),
    ),
  ],
)
```

<details>
<summary>💡 Petunjuk Bagian B</summary>

- B1: perubahan data tanpa `setState` baru terlihat ketika ada hal lain yang membuat `build()` berjalan (Bagian 2.2).
- B2: ingat kapan `initState`, `didUpdateWidget`, dan `dispose` dipanggil, serta bahwa `build()` selalu menyusul setelah `initState` dan `didUpdateWidget` (Bagian 7.3).
- B3: *validator* berhenti pada `return` pertama yang terpenuhi (Bagian 9.2).
- B4: hitung harga satuan dulu, baru kalikan jumlah (Bagian 12.1).
- B5: perhatikan tiga kemungkinan nilai `bool?` (Bagian 10.1).
- B6: apakah `clear()` memanggil `onChanged`? (Bagian 8.3)
</details>

---

## C. Temukan dan Perbaiki Kesalahannya

Setiap kode berikut mengandung **dua** kesalahan. Jelaskan **penyebabnya** dan tuliskan **perbaikannya**.

**C1.** Tombol suka yang berganti ikon setiap kali ditekan.

```dart
class TombolSuka extends StatelessWidget {
  const TombolSuka({super.key});

  bool _suka = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Suka',
      icon: Icon(_suka ? Icons.favorite : Icons.favorite_border),
      onPressed: () {
        setState(() {
          _suka = !_suka;
        });
      },
    );
  }
}
```

**C2.** Halaman pencarian yang judulnya berwarna utama tema. Saat dijalankan, layar langsung menampilkan *error*.

```dart
class HalamanCari extends StatefulWidget {
  const HalamanCari({super.key});

  @override
  State<HalamanCari> createState() => _HalamanCariState();
}

class _HalamanCariState extends State<HalamanCari> {
  final TextEditingController _kontrol = TextEditingController();
  late Color _warnaJudul;

  @override
  void initState() {
    super.initState();
    _warnaJudul = Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cari Buku', style: TextStyle(color: _warnaJudul)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: _kontrol,
          decoration: const InputDecoration(labelText: 'Judul buku'),
        ),
      ),
    );
  }
}
```

**C3.** Tombol untuk menghapus semua catatan setelah dikonfirmasi.

```dart
Future<void> _hapusSemua() async {
  final bool yakin = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Hapus semua catatan?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      );
    },
  );
  if (yakin) {
    setState(() {
      _catatan.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Semua catatan dihapus.')),
    );
  }
}
```

<details>
<summary>💡 Petunjuk Bagian C</summary>

- C1: perhatikan jenis widget dan properti yang tidak `final` (Bagian 1.3 dan Bagian 14).
- C2: apa yang boleh dan tidak boleh dilakukan di `initState()`? Apa yang wajib ada untuk setiap *controller*? (Bagian 7.4 dan 8.3)
- C3: tipe hasil `showDialog<bool>` dan apa yang wajib diperiksa setelah `await` (Bagian 10.1 dan 10.2).
</details>

---

## D. Menulis Program

Kerjakan setiap soal sebagai **aplikasi utuh** yang bisa dijalankan. Uji di lebar 360 dan 320.

**D1 — Pesan Tiket Bioskop Kampus.** Buat halaman pemesanan tiket:

- Pilihan film dengan `SegmentedButton` atau `ChoiceChip` (minimal tiga film dengan harga berbeda).
- Jumlah tiket 1 sampai 5 dengan tombol − dan +. Tombol − nonaktif saat 1, tombol + nonaktif saat 5.
- `SwitchListTile` **"Harga pelajar"** yang memberi potongan 20%.
- Total harga tampil di tombol "Pesan" dan berubah saat itu juga. Total harus berupa **nilai turunan**.
- Tombol "Pesan" menampilkan `SnackBar` berisi ringkasan pesanan.

<details>
<summary>💡 Petunjuk D1</summary>

Simpan film terpilih sebagai `enum` berproperti (nama dan harga), seperti `Porsi` pada Bagian 12. Potongan 20% bisa dihitung dengan `(harga * 80) ~/ 100` agar hasilnya tetap `int`. Operator `~/` adalah pembagian bilangan bulat (Pertemuan 2).
</details>

**D2 — Formulir Ganti Kata Sandi.** Buat formulir berisi tiga kolom kata sandi:

- **Kata sandi lama**: wajib diisi.
- **Kata sandi baru**: minimal 8 karakter, harus mengandung minimal satu angka, dan **tidak boleh sama** dengan kata sandi lama.
- **Ulangi kata sandi baru**: harus sama dengan kata sandi baru.
- Setiap kolom punya tombol mata untuk menampilkan atau menyembunyikan isinya.
- Tombol "Simpan" menjalankan `validate()`. Jika lolos, tampilkan `SnackBar`, lalu kosongkan formulir.

<details>
<summary>💡 Petunjuk D2</summary>

Untuk memeriksa ada tidaknya angka, gunakan `teks.contains(RegExp(r'[0-9]'))`. Tiga tombol mata berarti tiga *state* `bool` yang terpisah. *Validator* kolom baru dan kolom ulangi perlu membaca kolom lain lewat *controller*-nya (Bagian 9.5).
</details>

**D3 — Daftar Belanja dengan "Batalkan".** Buat halaman daftar belanja:

- Sebuah `TextField` dan tombol "Tambah". Barang yang ditambahkan muncul sebagai kartu di bawahnya, lalu kolom dikosongkan. Teks kosong tidak boleh ditambahkan.
- Setiap kartu punya tombol hapus. Setelah menghapus, muncul `SnackBar` dengan tombol **"Batalkan"** yang mengembalikan barang itu ke **posisi semula**.
- Jika daftar kosong, tampilkan pesan "Belum ada barang".

<details>
<summary>💡 Petunjuk D3</summary>

Simpan daftar sebagai `List<String>`. Sebelum menghapus, catat barang dan indeksnya. Untuk mengembalikan ke posisi semula, gunakan `_daftar.insert(indeks, barang)`. Ingat `persist: false` agar `SnackBar` tetap hilang sendiri (Bagian 4.4). Untuk saat ini, susun kartu dengan perulangan `for` di dalam `Column`; cara yang lebih efisien untuk daftar panjang (`ListView`) dibahas di Pertemuan 6.
</details>

---

[⬅️ Kembali ke Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md) · [🏠 Beranda](../README.md)

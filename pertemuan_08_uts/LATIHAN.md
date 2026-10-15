# ✍️ Latihan Persiapan UTS

[🏠 Beranda](../README.md) · [📝 Panduan UTS](README.md) · [🎯 Simulasi UTS](SIMULASI_UTS.md)

Latihan ini merangkum Pertemuan 1–7 dengan gaya soal yang mirip UTS. Kerjakan **tanpa membuka modul** terlebih dahulu, lalu buktikan jawaban Anda dengan menjalankan kodenya. Potongan kode di bagian B dan C diambil dari aplikasi seperti di [Simulasi UTS](SIMULASI_UTS.md); lengkapi dengan [bahan simulasi](kode/bahan_simulasi_sewa_alat.dart) jika ingin menjalankannya.

> [!NOTE]
> Kunci jawaban tidak dipublikasikan dan dibahas bersama dosen. **Bagian B** paling penting: pertanyaannya mirip dengan [tanya jawab pemahaman](README.md#9-tanya-jawab-pemahaman) setelah UTS. Biasakan menjawab dengan kalimat Anda sendiri: **apa yang terjadi saat kode berjalan**.

---

## A. Pilihan Ganda

**1.** Perintah untuk menjalankan aplikasi Flutter di Google Chrome dari terminal adalah ...

- a. `flutter build web`
- b. `dart run main.dart`
- c. `flutter run -d chrome`
- d. `flutter create chrome`

**2.** Perhatikan kode berikut.

```dart
String? nama;
print(nama ?? 'Tamu');
```

Hasil yang tercetak adalah ...

- a. `null`
- b. baris kosong
- c. *error* kompilasi
- d. `Tamu`

**3.** Pernyataan yang **benar** tentang `final` dan `const` adalah ...

- a. keduanya boleh diubah setelah diisi
- b. nilai `const` harus sudah diketahui saat kompilasi, sedangkan nilai `final` boleh ditentukan saat program berjalan
- c. `final` hanya untuk angka, sedangkan `const` hanya untuk teks
- d. `const` hanya boleh dipakai di dalam *class*

**4.** Perhatikan `enum` berikut.

```dart
enum Jenis {
  tenda('Tenda'),
  tas('Tas');

  const Jenis(this.label);

  final String label;
}
```

Nilai `Jenis.values.length` dan `Jenis.tas.label` berturut-turut adalah ...

- a. `2` dan `'Tas'`
- b. `1` dan `'tas'`
- c. `2` dan `'tas'`
- d. `3` dan `'Tas'`

**5.** Fungsi yang di dalamnya memakai `await` harus ...

- a. bertipe `void`
- b. dipanggil di dalam `setState`
- c. ditulis di luar *class*
- d. ditandai `async`

**6.** Di dalam sebuah `Row` terdapat `Icon` dan `Text` yang sangat panjang, sehingga muncul garis kuning-hitam. Perbaikan yang paling tepat adalah ...

- a. membungkus `Text` dengan `Expanded` (dan memberi `overflow: TextOverflow.ellipsis` jika perlu)
- b. mengganti `Row` dengan `Stack`
- c. memperbesar ukuran `Icon`
- d. membungkus `Row` dengan `Center`

**7.** Untuk memberi jarak 16 di **semua sisi** sebuah widget, gunakan ...

- a. `SizedBox(width: 16)`
- b. `Spacer(flex: 16)`
- c. `Padding(padding: const EdgeInsets.all(16), child: ...)`
- d. `Expanded(flex: 16, child: ...)`

**8.** Sebuah variabel di dalam *class State* diubah **tanpa** `setState`. Yang terjadi adalah ...

- a. aplikasi menampilkan *error*
- b. nilainya berubah di memori, tetapi tampilan tidak digambar ulang
- c. nilainya tidak berubah sama sekali
- d. Flutter otomatis memanggil `setState`

**9.** `TextEditingController` sebaiknya dibuang (`dispose()`) di ...

- a. `build`
- b. `initState`
- c. fungsi `onPressed` tombol simpan
- d. metode `dispose` milik *State*

**10.** *Validator* sebuah `TextFormField` menandakan bahwa isiannya **benar** dengan mengembalikan ...

- a. `true`
- b. `''` (teks kosong)
- c. `null`
- d. `'OK'`

**11.** Keunggulan `ListView.builder` dibandingkan `ListView(children: [...])` untuk daftar yang panjang adalah ...

- a. hanya membangun baris yang terlihat (dan sedikit di sekitarnya)
- b. otomatis menyimpan data ke perangkat
- c. tidak bisa digulir sehingga lebih ringan
- d. hanya bisa dipakai untuk data `const`

**12.** Perhatikan kode berikut.

```dart
final bool? ubah = await Navigator.push<bool>(context, rute);
if (!mounted) return;
```

Baris kedua diperlukan karena ...

- a. `Navigator.push` selalu gagal pada percobaan pertama
- b. selama menunggu, halaman ini mungkin sudah ditutup, sehingga `setState` dan `context`-nya tidak boleh dipakai lagi
- c. agar `ubah` tidak bernilai `null`
- d. agar halaman tujuan otomatis tertutup

**13.** `ListView` diletakkan langsung di dalam `Column`, lalu muncul *error* `Vertical viewport was given unbounded height.` Perbaikannya adalah ...

- a. mengganti `Column` dengan `Row`
- b. menambahkan `shrinkWrap: false`
- c. membungkus `Column` dengan `Center`
- d. membungkus `ListView` dengan `Expanded`

**14.** Teks yang diletakkan di atas latar `primaryContainer` sebaiknya berwarna ...

- a. `primary`
- b. `onPrimary`
- c. `onPrimaryContainer`
- d. `Colors.black`

**15.** Sebuah halaman memakai `final bool duaPanel = MediaQuery.widthOf(context) >= 840;`. Saat aplikasi berjalan, lebar jendela diubah dari 700 menjadi 900. Yang terjadi adalah ...

- a. tidak ada perubahan sampai aplikasi dijalankan ulang
- b. `build` dijalankan ulang dan susunannya berganti menjadi dua panel; *state* halaman tetap
- c. aplikasi kembali ke halaman awal dan semua *state* hilang
- d. muncul *error* karena lebar berubah

---

## B. Jelaskan Kode Ini

Jawab dengan kalimat Anda sendiri, singkat dan jelas, seolah-olah sedang ditanya langsung oleh dosen.

**B1.** Hasil pencarian di halaman daftar alat:

```dart
List<Alat> get _hasil {
  final String kunci = _kataKunci.trim().toLowerCase();
  return _semuaAlat.where((Alat alat) {
    final bool cocokNama = alat.nama.toLowerCase().contains(kunci);
    final bool cocokJenis = _jenis == null || alat.jenis == _jenis;
    return cocokNama && cocokJenis;
  }).toList();
}
```

- (a) Mengapa `_hasil` ditulis sebagai *getter*, bukan variabel `List<Alat> _hasil = [];` yang diisi ulang di `onChanged` pencarian? Sebutkan **satu keadaan** yang membuat cara kedua menampilkan hasil yang salah.
- (b) Apa arti `_jenis == null` di sini?
- (c) Jika `.trim()` dihapus, apa yang tampil saat pengguna mengetik ` tenda` (diawali satu spasi)?

> 💡 Petunjuk: [Modul P6, Bagian 8](../pertemuan_06_daftar_dan_navigasi/README.md#8-mencari-dan-menyaring-daftar).

**B2.** Membuka halaman detail:

```dart
Future<void> _bukaDetail(Alat alat) async {
  final bool? ubah = await Navigator.push<bool>(
    context,
    MaterialPageRoute<bool>(
      builder: (BuildContext context) =>
          HalamanDetail(alat: alat, disewa: _disewa.contains(alat.id)),
    ),
  );
  if (!mounted) return;
  if (ubah == true) {
    _ubahSewa(alat);
  }
}
```

- (a) Tuliskan urutan kejadian sejak pengguna mengetuk sebuah baris sampai label "Disewa" muncul di baris itu.
- (b) Mengapa tipe `ubah` adalah `bool?`? Kapan nilainya `null`?
- (c) Mengapa tidak ditulis `if (ubah) { ... }`?

> 💡 Petunjuk: [Modul P6, Bagian 11](../pertemuan_06_daftar_dan_navigasi/README.md#11-menerima-hasil-dari-halaman).

**B3.** *State* daftar alat:

```dart
final List<Alat> _semuaAlat = List<Alat>.of(dataAwal);
```

- (a) `dataAwal` adalah `const List<Alat>`. Mengapa tidak langsung ditulis `final List<Alat> _semuaAlat = dataAwal;`? Apa yang terjadi saat `_semuaAlat.add(...)` dipanggil?
- (b) Alat baru diberi id `_semuaAlat.length + 1`. Mengapa cara ini aman di aplikasi simulasi? Kapan cara ini **tidak** aman lagi?

**B4.** Menyimpan formulir:

```dart
void _simpan() {
  if (!_kunciForm.currentState!.validate()) {
    return;
  }
  final Alat baru = Alat(
    id: widget.idBaru,
    nama: _kontrolNama.text.trim(),
    jenis: _jenis!,
    hargaPerHari: int.parse(_kontrolHarga.text.trim()),
    keterangan: 'Belum ada keterangan.',
  );
  Navigator.pop(context, baru);
}
```

- (a) `_jenis!` dan `int.parse(...)` bisa gagal jika isinya tidak sesuai. Mengapa keduanya **aman** di baris ini?
- (b) Apa yang dikirim oleh `Navigator.pop(context, baru)`, dan bagian kode mana yang menerimanya?
- (c) Mengapa ditulis `widget.idBaru`, bukan `idBaru` saja?

> 💡 Petunjuk: [Modul P5, Bagian 9](../pertemuan_05_interaksi_dan_state/README.md#9-formulir-dan-validasi).

**B5.** Tema aplikasi:

```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: warnaBenih),
),
darkTheme: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: warnaBenih),
),
themeMode: _gelap ? ThemeMode.dark : ThemeMode.light,
```

Pengguna menekan tombol mode gelap. Ikon tombolnya berganti, tetapi tampilan aplikasi tetap terang.

- (a) Jelaskan penyebabnya.
- (b) Tuliskan perbaikannya.

> 💡 Petunjuk: [Modul P7, Bagian 7.2](../pertemuan_07_material3_dan_responsif/README.md#72-dua-tema-dan-satu-pilihan).

**B6.** Satu ketukan, dua perilaku:

```dart
void _pilihAlat(Alat alat, bool duaPanel) {
  if (duaPanel) {
    setState(() {
      _idTerpilih = alat.id;
    });
  } else {
    _bukaDetail(alat);
  }
}
```

- (a) Jelaskan perbedaan yang terjadi saat baris diketuk di jendela selebar 400 dan selebar 1000.
- (b) Di lebar 1000, pengguna memilih Matras Gulung. Jendela lalu dipersempit menjadi 400, kemudian dilebarkan lagi menjadi 1000. Apakah Matras Gulung masih tampil di panel kanan? Mengapa?

> 💡 Petunjuk: [Modul P7, Bagian 13](../pertemuan_07_material3_dan_responsif/README.md#13-pola-daftardetail).

---

## C. Temukan dan Perbaiki Kesalahannya

Setiap kode berikut mengandung **tiga** kesalahan. Untuk setiap kesalahan, tuliskan **gejala** yang terlihat saat aplikasi dijalankan, **penyebab**, dan **perbaikannya**. Jalankan kodenya (setelah ditempel bersama [bahan simulasi](kode/bahan_simulasi_sewa_alat.dart)) untuk membuktikan gejalanya.

**C1.** Halaman daftar alat:

```dart
class HalamanDaftar extends StatefulWidget {
  const HalamanDaftar({super.key});

  @override
  State<HalamanDaftar> createState() => _HalamanDaftarState();
}

class _HalamanDaftarState extends State<HalamanDaftar> {
  final Set<int> _disewa = {1, 7};

  @override
  Widget build(BuildContext context) {
    String kataKunci = '';
    final List<Alat> hasil = dataAwal
        .where((Alat alat) => alat.nama.toLowerCase().contains(kataKunci))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Sewa Alat Mapala')),
      body: Column(
        children: [
          SearchBar(
            hintText: 'Cari alat',
            onChanged: (String teks) {
              setState(() {
                kataKunci = teks.toLowerCase();
              });
            },
          ),
          ListView.builder(
            itemCount: hasil.length,
            itemBuilder: (BuildContext context, int index) {
              final Alat alat = hasil[index];
              return ListTile(
                title: Text(
                  alat.nama,
                  style: const TextStyle(color: Colors.black),
                ),
                subtitle: Text(formatRupiah(alat.hargaPerHari)),
                trailing: _disewa.contains(alat.id)
                    ? const Text('Disewa')
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
```

> 💡 Uji di mode terang **dan** gelap. Petunjuk: [Modul P6, Bagian 6 dan 8](../pertemuan_06_daftar_dan_navigasi/README.md#6-daftar-di-dalam-column), [Modul P7, Bagian 7.4](../pertemuan_07_material3_dan_responsif/README.md#74-membuktikannya-warna-tema-vs-warna-yang-ditulis-langsung).

**C2.** Halaman tambah alat:

```dart
class HalamanTambah extends StatefulWidget {
  const HalamanTambah({super.key, required this.idBaru});

  final int idBaru;

  @override
  State<HalamanTambah> createState() => _HalamanTambahState();
}

class _HalamanTambahState extends State<HalamanTambah> {
  final GlobalKey<FormState> _kunciForm = GlobalKey<FormState>();
  JenisAlat? _jenis;

  @override
  Widget build(BuildContext context) {
    final TextEditingController kontrolNama = TextEditingController();
    final TextEditingController kontrolHarga = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Alat')),
      body: Form(
        key: _kunciForm,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: kontrolNama,
              decoration: const InputDecoration(labelText: 'Nama alat'),
              validator: (String? isi) {
                if ((isi ?? '').trim().length < 3) {
                  return 'Nama alat minimal 3 huruf';
                }
                return '';
              },
            ),
            DropdownButtonFormField<JenisAlat>(
              decoration: const InputDecoration(labelText: 'Jenis alat'),
              items: [
                for (final JenisAlat jenis in JenisAlat.values)
                  DropdownMenuItem<JenisAlat>(
                    value: jenis,
                    child: Text(jenis.label),
                  ),
              ],
              onChanged: (JenisAlat? pilihan) {
                setState(() {
                  _jenis = pilihan;
                });
              },
            ),
            TextFormField(
              controller: kontrolHarga,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Harga sewa per hari',
              ),
            ),
            FilledButton(
              onPressed: () {
                if (_kunciForm.currentState!.validate()) {
                  Navigator.pop(
                    context,
                    Alat(
                      id: widget.idBaru,
                      nama: kontrolNama.text.trim(),
                      jenis: _jenis ?? JenisAlat.tenda,
                      hargaPerHari: int.parse(kontrolHarga.text),
                      keterangan: 'Belum ada keterangan.',
                    ),
                  );
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
```

> 💡 Coba urutan ini: ketik nama, **lalu** pilih jenis alat. Kemudian isi semuanya dengan benar dan tekan Simpan. Petunjuk: [Modul P5, Bagian 8 dan 9](../pertemuan_05_interaksi_dan_state/README.md#9-formulir-dan-validasi).

---

## D. Rencanakan Sebelum Menulis

Di UTS, lima menit merencanakan bisa menghemat tiga puluh menit memperbaiki. Bacalah spesifikasi singkat berikut, lalu **isi tabel rencana** di bawahnya **tanpa menulis kode**.

> **Aplikasi "Tugas Kuliahku".** Mahasiswa mencatat tugas kuliah. Setiap tugas punya judul, mata kuliah, prioritas (rendah, sedang, tinggi), dan tenggat (tulisan, misalnya "Jumat, 17 Okt"). Halaman daftar menampilkan semua tugas, bisa dicari berdasarkan judul dan disaring berdasarkan prioritas. Tugas yang sudah selesai diberi label "Selesai". Di bagian atas ada tulisan "3 tugas belum selesai" dan sakelar "Sembunyikan yang selesai". Mengetuk tugas membuka halaman detail dengan tombol "Tandai selesai"/"Belum selesai". Tombol "Tambah tugas" membuka formulir. Pengguna bisa mengganti mode terang/gelap.

| No | Yang direncanakan | Jawaban Anda |
| :---: | :--- | :--- |
| 1 | `enum` dan *class* model: nama, *field*, dan tipe datanya | |
| 2 | Variabel *state* di **akar aplikasi**: nama, tipe, nilai awal | |
| 3 | Variabel *state* di **halaman daftar**: nama, tipe, nilai awal | |
| 4 | **Nilai turunan** di halaman daftar: nama dan cara menghitungnya | |
| 5 | *Class* widget yang perlu dibuat: nama dan parameter *constructor*-nya (data dan *callback*) | |
| 6 | Perpindahan halaman: dari mana ke mana, data yang **dikirim**, dan hasil yang **dikembalikan** (beserta tipenya) | |
| 7 | Lima langkah uji beserta hasil yang diharapkan | |

---

[⬅️ Kembali ke Panduan UTS](README.md) · [🎯 Simulasi UTS](SIMULASI_UTS.md) · [🏠 Beranda](../README.md)

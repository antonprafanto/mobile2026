# ✍️ Latihan Pertemuan 7 — Material Design 3 & UI Responsif

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md)

Kerjakan **tanpa membuka modul dan tanpa menjalankan kode** terlebih dahulu. Setelah selesai, buktikan jawaban Anda dengan menjalankan kodenya di [DartPad](https://dartpad.dev) atau di Chrome. Untuk soal yang berupa potongan kode, lengkapi dulu menjadi aplikasi utuh (`import`, `main`, dan `MaterialApp`), seperti kode di [Jobsheet](JOBSHEET.md). Soal yang menyebut lebar jendela diuji dengan mengubah lebar jendela *browser* atau memakai *device toolbar* Chrome.

> [!NOTE]
> Kunci jawaban tidak dipublikasikan. Petunjuk (💡) menunjukkan **bagian modul** yang relevan. Pembahasan lengkap dilakukan bersama dosen di kelas.

---

## A. Pilihan Ganda

**1.** Fungsi utama `ThemeData` yang dipasang di parameter `theme` milik `MaterialApp` adalah ...

- a. mengatur ukuran jendela aplikasi
- b. menyimpan data yang ditampilkan di halaman
- c. menyimpan pengaturan tampilan yang berlaku untuk semua widget di bawahnya
- d. menggantikan `Scaffold` di setiap halaman

**2.** Teks yang diletakkan di atas latar berwarna `secondaryContainer` sebaiknya berwarna ...

- a. `secondary`
- b. `onSecondary`
- c. `onSurface`
- d. `onSecondaryContainer`

**3.** `ColorScheme.fromSeed(seedColor: Colors.blue)` menghasilkan ...

- a. skema lengkap berisi semua peran warna yang diturunkan dari satu warna benih
- b. satu warna biru yang dipakai untuk semua komponen
- c. daftar warna biru dari yang paling muda sampai paling tua tanpa peran
- d. tema gelap secara otomatis

**4.** Gaya huruf bawaan untuk judul `AppBar` di Material 3 adalah ...

- a. `headlineSmall`
- b. `titleLarge`
- c. `bodyLarge`
- d. `labelLarge`

**5.** Kode `gayaTeks.titleLarge?.copyWith(color: warna.onPrimary)` memakai `?.` karena ...

- a. `copyWith` adalah metode yang berjalan secara asinkron
- b. setiap gaya di `TextTheme` bertipe `TextStyle?`, sehingga bisa bernilai `null`
- c. `warna.onPrimary` bisa bernilai `null`
- d. `?.` membuat tulisan menjadi tebal

**6.** Anda ingin **semua** `FilledButton` di aplikasi setinggi 52 tanpa mengubah tombolnya satu per satu. Cara yang paling tepat adalah ...

- a. mengisi `filledButtonTheme` di `ThemeData`
- b. memberi `style` pada setiap `FilledButton`
- c. membungkus setiap tombol dengan `SizedBox(height: 52)`
- d. mengganti semua `FilledButton` dengan `ElevatedButton`

**7.** `MaterialApp` diberi `theme` (terang), `darkTheme` (gelap, dengan `Brightness.dark`), dan `themeMode: ThemeMode.system`. Perangkat pengguna sedang memakai mode gelap. Tema yang tampil adalah ...

- a. `theme`, karena `theme` selalu diutamakan
- b. campuran `theme` dan `darkTheme`
- c. `darkTheme`
- d. tema bawaan Flutter, karena `themeMode` tidak boleh `system`

**8.** Pilihan mode tema (`ThemeMode`) yang dipilih pengguna di halaman pengaturan paling tepat disimpan di ...

- a. variabel lokal di dalam `build` halaman pengaturan
- b. *state* halaman pengaturan saja
- c. variabel `const` di luar *class*
- d. *state* widget akar aplikasi yang membangun `MaterialApp`

**9.** Pernyataan yang benar tentang `MediaQuery.sizeOf(context)` dan `LayoutBuilder` adalah ...

- a. keduanya selalu menghasilkan angka yang sama
- b. `MediaQuery.sizeOf` mengukur jendela aplikasi, sedangkan `LayoutBuilder` mengukur ruang yang diberikan induk kepada sebuah widget
- c. `LayoutBuilder` mengukur jendela aplikasi, sedangkan `MediaQuery.sizeOf` mengukur ruang widget
- d. `LayoutBuilder` hanya bisa dipakai di dalam `ListView`

**10.** Menurut *breakpoint* Material 3, jendela selebar **840** termasuk kelas ...

- a. ringkas (*compact*)
- b. sedang (*medium*)
- c. lebar (*expanded*)
- d. besar (*large*)

**11.** Apa yang terjadi jika `NavigationRail` diberi `extended: true` dan `labelType: NavigationRailLabelType.all`?

- a. label tampil dua kali
- b. *rail* otomatis kembali ke ukuran biasa
- c. label disembunyikan tanpa pesan apa pun
- d. muncul *assertion error*, karena saat diperlebar `labelType` harus `null` atau `none`

**12.** Pada pola daftar–detail di jendela selebar 1000, mengetuk sebuah item di daftar seharusnya ...

- a. menyimpan item terpilih dengan `setState`, sehingga panel detail di sebelahnya berganti isi
- b. membuka halaman detail baru dengan `Navigator.push`
- c. menutup daftar dan menampilkan detail selebar layar
- d. tidak melakukan apa pun, karena detail selalu menampilkan item pertama

---

## B. Tebak Hasil

**B1.** Tema aplikasi memakai `ColorScheme.fromSeed(seedColor: Colors.blue)`. Perhatikan halaman berikut.

```dart
class HalamanUji extends StatelessWidget {
  const HalamanUji({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: Theme.of(context)
            .copyWith(colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
        child: Column(
          children: [
            Text(
              'A',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            const TeksB(),
            FilledButton(onPressed: () {}, child: const Text('C')),
          ],
        ),
      ),
    );
  }
}

class TeksB extends StatelessWidget {
  const TeksB({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'B',
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
    );
  }
}
```

Apakah warna (a) huruf A, (b) huruf B, dan (c) latar tombol C **kebiruan** atau **kemerahan**? Jelaskan alasannya.

**B2.** Perhatikan `enum` berikut (sama seperti contoh 08 di modul).

```dart
enum KelasUkuran {
  ringkas('Ringkas (compact)', kolom: 1, margin: 16),
  sedang('Sedang (medium)', kolom: 2, margin: 24),
  lebar('Lebar (expanded)', kolom: 3, margin: 24),
  besar('Besar (large)', kolom: 3, margin: 24),
  ekstraBesar('Ekstra besar (extra-large)', kolom: 4, margin: 24);

  const KelasUkuran(this.nama, {required this.kolom, required this.margin});

  final String nama;
  final int kolom;
  final double margin;

  static KelasUkuran dari(double lebar) {
    if (lebar < 600) {
      return KelasUkuran.ringkas;
    }
    if (lebar < 840) {
      return KelasUkuran.sedang;
    }
    if (lebar < 1200) {
      return KelasUkuran.lebar;
    }
    if (lebar < 1600) {
      return KelasUkuran.besar;
    }
    return KelasUkuran.ekstraBesar;
  }
}
```

Tuliskan **nama kelas** dan **jumlah kolom** untuk lebar jendela: (a) 320, (b) 599, (c) 600, (d) 839, (e) 840, (f) 1200, (g) 1920.

**B3.** Jendela aplikasi selebar **400**. Tuliskan dua baris tulisan yang tampil.

```dart
class Ukur extends StatelessWidget {
  const Ukur({super.key, required this.nama});

  final String nama;

  @override
  Widget build(BuildContext context) {
    final double jendela = MediaQuery.sizeOf(context).width;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints batasan) {
        return Text(
          '$nama: ruang ${batasan.maxWidth.toStringAsFixed(0)}, '
          'jendela ${jendela.toStringAsFixed(0)}',
        );
      },
    );
  }
}

// ... body milik Scaffold:
ListView(
  padding: const EdgeInsets.all(16),
  children: const [
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: Ukur(nama: 'kiri')),
        SizedBox(width: 8),
        Expanded(child: Ukur(nama: 'kanan')),
      ],
    ),
  ],
)
```

**B4.** Lengkapi kolom terakhir dengan **terang** atau **gelap**. "Tema terang" dan "tema gelap" dibuat dengan `ColorScheme.fromSeed` yang **sama**; perbedaannya disebutkan di setiap baris.

| No | `theme` | `darkTheme` | `themeMode` | Pengaturan perangkat | Tampilan yang muncul |
| :---: | :--- | :--- | :--- | :--- | :---: |
| (a) | tema terang | tema gelap (`Brightness.dark`) | `ThemeMode.light` | gelap | ... |
| (b) | tema terang | tema gelap (`Brightness.dark`) | `ThemeMode.system` | gelap | ... |
| (c) | tema terang | **tidak diisi** | `ThemeMode.dark` | gelap | ... |
| (d) | tema terang | tema **tanpa** `brightness: Brightness.dark` | `ThemeMode.dark` | terang | ... |
| (e) | tema terang | tema gelap (`Brightness.dark`) | `ThemeMode.system` | terang | ... |

**B5.** Perhatikan potongan `build` berikut. `_terpilih` adalah *field* di *State*, dan setiap ketukan tujuan memanggil `setState` untuk mengubahnya.

```dart
final double lebar = MediaQuery.widthOf(context);

if (lebar < 600) {
  return Scaffold(
    body: isi,
    bottomNavigationBar: NavigationBar(/* Beranda, Jadwal, Tugas */),
  );
}

final bool railLebar = lebar >= 1000;
return Scaffold(
  body: Row(
    children: [
      NavigationRail(
        extended: railLebar,
        labelType: railLebar
            ? NavigationRailLabelType.none
            : NavigationRailLabelType.selected,
        // ... Beranda, Jadwal, Tugas
      ),
      const VerticalDivider(width: 1, thickness: 1),
      Expanded(child: isi),
    ],
  ),
);
```

- (a) Navigasi apa yang tampil di lebar 500?
- (b) Navigasi apa yang tampil di lebar 800, dan label tujuan mana saja yang terlihat?
- (c) Bagaimana tampilan navigasi di lebar 1100?
- (d) Di lebar 500 pengguna memilih **Tugas**, lalu jendela diperlebar menjadi 800. Tujuan mana yang terpilih?
- (e) Seandainya `_terpilih` dihapus dari *State* dan diganti variabel lokal `int terpilih = 0;` di baris pertama `build`, apa yang terjadi saat pengguna mengetuk **Tugas**?

---

## C. Temukan dan Perbaiki Kesalahannya

Setiap kode berikut mengandung **dua** kesalahan. Untuk setiap kesalahan, jelaskan **pesan atau gejalanya**, **penyebabnya**, dan **perbaikannya**.

**C1.** Aplikasi ini seharusnya **selalu** tampil gelap. Kenyataannya tampil terang. Setelah kesalahan pertama diperbaiki, muncul masalah baru pada tulisan sambutan.

```dart
class AplikasiSalam extends StatelessWidget {
  const AplikasiSalam({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      themeMode: ThemeMode.dark,
      home: const HalamanSalam(),
    );
  }
}

class HalamanSalam extends StatelessWidget {
  const HalamanSalam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Salam')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Selamat datang di aplikasi kampus!',
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
      ),
    );
  }
}
```

**C2.** Di lebar 800, mengetuk "Jadwal" tidak memindahkan pilihan. Di lebar 1300, layar langsung menampilkan *error*.

```dart
class _HalamanUtamaState extends State<HalamanUtama> {
  @override
  Widget build(BuildContext context) {
    int terpilih = 0;
    final double lebar = MediaQuery.widthOf(context);

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: terpilih,
            onDestinationSelected: (int indeks) {
              setState(() {
                terpilih = indeks;
              });
            },
            extended: lebar >= 1200,
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Beranda'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.event),
                label: Text('Jadwal'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                label: Text('Profil'),
              ),
            ],
          ),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(child: Center(child: Text('Tujuan ke-$terpilih'))),
        ],
      ),
    );
  }
}
```

**C3.** *Analyzer* memberi peringatan pada tema. Saat dijalankan, halaman donasi menampilkan *error* dan tombolnya tidak tampil.

```dart
class AplikasiDonasi extends StatelessWidget {
  const AplikasiDonasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        appBarTheme: const AppBarTheme(color: Colors.indigo),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
        ),
      ),
      home: const HalamanDonasi(),
    );
  }
}

class HalamanDonasi extends StatelessWidget {
  const HalamanDonasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donasi Buku')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            FilledButton(onPressed: () {}, child: const Text('Donasi')),
            const SizedBox(width: 8),
            OutlinedButton(onPressed: () {}, child: const Text('Nanti')),
          ],
        ),
      ),
    );
  }
}
```

<details>
<summary>💡 Petunjuk bagian C</summary>

C1: Bagian 7.2 (kotak penting) dan 7.4. C2: Bagian 12.2 (kotak peringatan) dan ingat Pertemuan 5: nilai yang harus bertahan antar-`build` disimpan di mana? C3: Bagian 6.2 (catatan tentang nama "Data") dan Bagian 6.3 (kotak peringatan). Perhatikan juga warna tulisan judul `AppBar` setelah latarnya diganti.
</details>

---

## D. Menulis Program

Kerjakan setiap soal sebagai **aplikasi utuh** yang bisa dijalankan. Di dalam halaman **jangan** menulis warna maupun `fontSize`; semuanya dari tema.

**D1 — Kartu Nama Digital.** Buat aplikasi satu halaman berisi kartu nama Anda:

- Tema dari warna benih pilihan Anda, lengkap dengan `theme` dan `darkTheme`.
- `IconButton` di `AppBar` untuk berganti antara mode terang dan gelap. *State*-nya disimpan di akar aplikasi.
- Kartu berisi lingkaran inisial (`primaryContainer` + `onPrimaryContainer`), nama (`headlineSmall`), program studi (`bodyLarge` + `onSurfaceVariant`), tiga baris keterangan (email, nomor telepon, kota) memakai `ListTile`, dan tiga `Chip` keahlian.
- Uji di lebar 320 dan 360, di kedua mode.

<details>
<summary>💡 Petunjuk D1</summary>

Pola akar aplikasi yang menyimpan mode ada di contoh 06 (Bagian 8): `bool _gelap` dan `themeMode: _gelap ? ThemeMode.dark : ThemeMode.light`. Pasangan warna ada di Bagian 4.2, gaya huruf di Bagian 5.1.
</details>

**D2 — Penjelajah *Breakpoint*.** Buat aplikasi yang membantu Anda menghafal *breakpoint* Material 3:

- Tampilkan lebar jendela saat ini (dari `MediaQuery.widthOf`) dalam ukuran besar (`displaySmall`).
- Tampilkan kartu berisi nama kelasnya, jumlah panel yang disarankan, dan navigasi yang disarankan. Data ini disimpan sebagai properti `enum` (lima kelas).
- Warna latar kartu berbeda untuk setiap kelas, memakai pasangan peran warna yang tepat: ringkas `primaryContainer`, sedang `secondaryContainer`, lebar `tertiaryContainer`, besar `surfaceContainerHighest`, ekstra besar `inverseSurface`.
- Di bawah kartu, tampilkan **lima kotak berjajar** (satu untuk setiap kelas). Kotak milik kelas yang sedang aktif ditandai, misalnya berlatar `primary` dengan tulisan `onPrimary`.
- Uji dengan mengubah lebar jendela dari 320 sampai 1700.

<details>
<summary>💡 Petunjuk D2</summary>

Lihat contoh 08 (Bagian 11.2). `enum` boleh menyimpan teks, angka, bahkan fungsi; tetapi warna dari tema tidak bisa disimpan di `enum` karena baru diketahui di `build`. Pilih warnanya dengan `switch` di dalam `build`. Lima kotak berjajar cukup dibuat dengan `Row` berisi lima `Expanded`.
</details>

**D3 — Pratinjau Tema.** Buat aplikasi untuk mencoba-coba tema:

- Akar aplikasi menyimpan tiga *state*: warna benih (pilih dari **6** warna), varian skema (`tonalSpot`, `fidelity`, `vibrant`, `monochrome`), dan `ThemeMode`.
- Panel **Atur** berisi `ChoiceChip` untuk benih dan varian, serta `SegmentedButton` untuk mode.
- Panel **Pratinjau** berisi contoh komponen: `FilledButton`, `FilledButton.tonal`, `OutlinedButton`, beberapa `Chip`, sebuah `Card` berisi `ListTile`, `LinearProgressIndicator`, dan tombol yang menampilkan `SnackBar`.
- Di jendela **< 840**, kedua panel menjadi dua tujuan `NavigationBar` (di bawah 600) atau `NavigationRail` (600–839). Di jendela **≥ 840**, kedua panel tampil **berdampingan** tanpa navigasi: Atur di kiri (lebar 360), Pratinjau di kanan.

<details>
<summary>💡 Petunjuk D3</summary>

Gabungkan pola Bagian 7.3 (*state* di akar), Bagian 12.3 (abstraksi–ukur–cabangkan), dan Bagian 13 (dua panel). `ColorScheme.fromSeed` menerima `dynamicSchemeVariant` (Bagian 4.3). Panel Atur dan Pratinjau dibuat sebagai *class* tersendiri agar bisa dipakai di kedua tata letak.
</details>

---

[⬅️ Kembali ke Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md) · [🏠 Beranda](../README.md)

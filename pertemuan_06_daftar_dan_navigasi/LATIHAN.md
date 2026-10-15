# ✍️ Latihan Pertemuan 6 — Daftar Data & Navigasi

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md)

Kerjakan **tanpa membuka modul dan tanpa menjalankan kode** terlebih dahulu. Setelah selesai, buktikan jawaban Anda dengan menjalankan kodenya di [DartPad](https://dartpad.dev). Untuk soal bagian B dan C, lengkapi potongan kodenya menjadi aplikasi utuh dengan kerangka dari [Jobsheet](JOBSHEET.md#kerangka-aplikasi-dipakai-di-praktikum-14). Soal B2 dan B3 cukup dijalankan sebagai program Dart biasa.

> [!NOTE]
> Kunci jawaban tidak dipublikasikan. Petunjuk (💡) menunjukkan **bagian modul** yang relevan. Pembahasan lengkap dilakukan bersama dosen di kelas.

---

## A. Pilihan Ganda

**1.** Agar daftar berisi 1.000 baris tetap ringan, widget yang paling tepat adalah ...

- a. `Column` berisi perulangan `for`
- b. `ListView(children: [...])`
- c. `ListView.builder`
- d. `SingleChildScrollView` berisi `Column`

**2.** Pada `ListView.builder`, parameter yang memberi tahu **berapa banyak** baris yang ada adalah ...

- a. `itemCount`
- b. `itemBuilder`
- c. `children`
- d. `separatorBuilder`

**3.** `ListView.separated` dengan `itemCount: 7` akan menampilkan berapa garis pemisah?

- a. 6
- b. 7
- c. 8
- d. 14

**4.** Anda ingin galeri foto tampil 2 kolom di ponsel, tetapi lebih banyak kolom di monitor yang lebar. `gridDelegate` yang tepat adalah ...

- a. `SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)`
- b. `SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5)`
- c. `SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2)`
- d. `SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 180)`

**5.** Pesan `Vertical viewport was given unbounded height.` muncul setelah `ListView.builder` diletakkan di dalam `Column`. Perbaikan yang paling tepat adalah ...

- a. mengganti `ListView.builder` dengan `ListView.separated`
- b. membungkus `ListView.builder` dengan `Expanded`
- c. menambahkan `itemCount`
- d. membungkus `Column` dengan `Center`

**6.** *Key* yang paling tepat untuk `Dismissible` pada daftar tugas adalah ...

- a. `ValueKey<int>(index)`
- b. `UniqueKey()`
- c. `ValueKey<int>(tugas.id)`
- d. tidak perlu *key*

**7.** Item di posisi `indeks` baru saja dihapus. Tombol "Urungkan" seharusnya mengembalikannya dengan ...

- a. `_daftar.add(item)`
- b. `_daftar.remove(item)`
- c. `setState(() {})`
- d. `_daftar.insert(indeks, item)`

**8.** Pada fitur pencarian yang ditulis dengan benar, yang disimpan sebagai *state* adalah ...

- a. daftar hasil pencarian
- b. kata kunci dan pilihan saringan
- c. salinan data asli yang sebagian isinya sudah dihapus
- d. jumlah hasil pencarian

**9.** `Navigator.push` bekerja dengan cara ...

- a. menaruh halaman baru di atas tumpukan
- b. mengganti semua halaman di tumpukan
- c. mengambil halaman teratas dari tumpukan
- d. menutup aplikasi

**10.** Pengguna menutup halaman kedua dengan panah kembali di `AppBar`. Nilai yang diterima `await Navigator.push<String>(...)` adalah ...

- a. `''` (teks kosong)
- b. `'kembali'`
- c. `null`
- d. aplikasi *error*

**11.** Agar tulisan yang belum disimpan tidak hilang saat pengguna menekan tombol kembali, halaman dibungkus dengan ...

- a. `WillPopScope`
- b. `BackButton`
- c. `SafeArea`
- d. `PopScope` dengan `canPop: false`

**12.** Dari halaman B, Anda membuka halaman pemilih C dengan `go_router`, lalu ingin **kembali ke B** sambil membawa pilihan pengguna. Perintah yang tepat untuk membuka C adalah ...

- a. `context.go('/c')`
- b. `context.push('/c')`
- c. `context.pop('/c')`
- d. `context.replace('/c')`

<details>
<summary>💡 Petunjuk Bagian A</summary>

Soal 1 → Bagian 3.1–3.2 · Soal 2 → Bagian 3.2 · Soal 3 → Bagian 4.1 · Soal 4 → Bagian 5.2 · Soal 5 → Bagian 6 · Soal 6 → Bagian 7.2 · Soal 7 → Bagian 7.3 · Soal 8 → Bagian 8.1 · Soal 9 → Bagian 9.2 · Soal 10 → Bagian 11.3 · Soal 11 → Bagian 12.2 · Soal 12 → Bagian 13.4
</details>

---

## B. Tebak Hasil

**B1.** Perhatikan potongan kode berikut.

```dart
const List<String> buah = ['Apel', 'Jeruk', 'Mangga', 'Pisang'];

// ... di dalam build():
ListView.builder(
  itemCount: 3,
  itemBuilder: (BuildContext context, int index) {
    return ListTile(title: Text('${index + 1}. ${buah[index]}'));
  },
)
```

(a) Tulisan apa saja yang tampil di layar? (b) Apa yang terjadi jika `itemCount` diubah menjadi `5`?

**B2.** Perhatikan data dan fungsi penyaring berikut.

```dart
enum Jenis { makanan, minuman }

class Menu {
  const Menu(this.nama, this.jenis);

  final String nama;
  final Jenis jenis;
}

const List<Menu> daftarMenu = [
  Menu('Nasi Goreng', Jenis.makanan),
  Menu('Es Teh Manis', Jenis.minuman),
  Menu('Mie Goreng', Jenis.makanan),
  Menu('Es Jeruk', Jenis.minuman),
  Menu('Soto Ayam', Jenis.makanan),
];

List<Menu> saring(String kataKunci, Jenis? jenis) {
  final String kunci = kataKunci.trim().toLowerCase();
  return daftarMenu.where((Menu menu) {
    final bool cocokNama = menu.nama.toLowerCase().contains(kunci);
    final bool cocokJenis = jenis == null || menu.jenis == jenis;
    return cocokNama && cocokJenis;
  }).toList();
}
```

Tuliskan nama-nama menu hasil dari:

- (a) `saring('goreng', null)`
- (b) `saring(' ES ', Jenis.minuman)`
- (c) `saring('es', Jenis.makanan)`
- (d) `saring('', Jenis.makanan)`

(e) Setelah keempat pemanggilan di atas, berapa banyak isi `daftarMenu`?

**B3.** Apa yang tercetak pada baris (a) dan (b)?

```dart
void main() {
  final List<String> antrean = ['Ani', 'Budi', 'Cici', 'Dodi'];

  const int indeks = 1;
  final String terhapus = antrean[indeks];
  antrean.removeAt(indeks);
  print(antrean); // (a)

  antrean.add(terhapus);
  print(antrean); // (b)
}
```

(c) Jika baris `antrean.add(terhapus);` diganti `antrean.insert(indeks, terhapus);`, apa yang tercetak pada baris (b)?

**B4.** Aplikasi dibuka di halaman **Beranda**. Lalu perintah berikut dijalankan berurutan (setiap `push` membuka halaman yang namanya disebut):

1. `push` **Profil**
2. `push` **Ubah Profil**
3. `pop`
4. `push` **Pengaturan**
5. `push` **Tentang**
6. `Navigator.popUntil(context, (Route<dynamic> rute) => rute.isFirst)`

Tuliskan isi tumpukan (dari bawah ke atas) dan halaman yang tampil di layar **setelah setiap langkah**. Setelah langkah ke berapa panah kembali di `AppBar` **tidak** tampil?

**B5.** Halaman pertama menyimpan kota tujuan dan membuka halaman pemilih kota.

```dart
String _kota = 'Samarinda';

Future<void> _pilihKota() async {
  final String? hasil = await Navigator.push<String>(
    context,
    MaterialPageRoute<String>(
      builder: (BuildContext context) => const HalamanPilihKota(),
    ),
  );
  if (!mounted) return;
  setState(() {
    _kota = hasil ?? _kota;
  });
}
```

Di `HalamanPilihKota`, setiap kota memanggil `Navigator.pop(context, namaKota)` saat diketuk. Tuliskan isi `_kota` setelah setiap kejadian berikut, berurutan:

- (a) Pengguna membuka pemilih, lalu mengetuk **Balikpapan**.
- (b) Pengguna membuka pemilih lagi, lalu menekan **panah kembali**.
- (c) Pengguna membuka pemilih lagi, lalu mengetuk **Bontang**.

(d) Apa yang terjadi jika `?? _kota` dihapus, sehingga barisnya menjadi `_kota = hasil;`?

**B6.** Perhatikan peta rute berikut.

```dart
final GoRouter petaRute = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HalamanBeranda();
      },
      routes: [
        GoRoute(
          path: 'fakultas/:kode',
          builder: (BuildContext context, GoRouterState state) {
            return HalamanFakultas(kode: state.pathParameters['kode']!);
          },
        ),
        GoRoute(
          path: 'tentang',
          builder: (BuildContext context, GoRouterState state) {
            return const HalamanTentang();
          },
        ),
      ],
    ),
  ],
  errorBuilder: (BuildContext context, GoRouterState state) {
    return const HalamanTidakDitemukan();
  },
);
```

- (a) Halaman apa yang terbuka untuk alamat `/fakultas/hukum`, dan apa isi `kode`?
- (b) Halaman apa yang terbuka untuk alamat `/fakultas`?
- (c) Dari beranda dijalankan `context.go('/fakultas/teknik')`. Di halaman fakultas, dijalankan `context.push('/tentang')`. Lalu pengguna menekan panah kembali. Halaman apa yang tampil?
- (d) Sama seperti (c), tetapi langkah kedua memakai `context.go('/tentang')`. Halaman apa yang tampil setelah panah kembali ditekan?
- (e) Halaman apa yang terbuka untuk alamat `/Tentang` (huruf T besar)?

<details>
<summary>💡 Petunjuk Bagian B</summary>

- B1: `itemBuilder` dipanggil untuk `index` 0 sampai `itemCount - 1` (Bagian 3.2), dan daftar `buah` hanya berisi 4 nama.
- B2: kata kunci dan nama sama-sama dijadikan huruf kecil; `where` tidak mengubah data asli (Bagian 8.1).
- B3: bandingkan `add` dan `insert` (Bagian 7.3).
- B4: `push` menaruh di atas, `pop` mengambil yang teratas, `popUntil` terus mengambil sampai syaratnya terpenuhi (Bagian 9).
- B5: perhatikan kapan `hasil` bernilai `null` dan apa arti `??` (Bagian 11.3).
- B6: rute anak, perbedaan `go` dan `push`, serta halaman untuk alamat yang tidak cocok (Bagian 13.3–13.6).
</details>

---

## C. Temukan dan Perbaiki Kesalahannya

Setiap kode berikut mengandung **dua** kesalahan. Jelaskan **penyebabnya** dan tuliskan **perbaikannya**.

**C1.** Halaman jadwal dengan baris ringkasan di atas dan daftar mata kuliah di bawahnya.

```dart
const List<String> jadwal = [
  'PPB',
  'Basis Data',
  'Statistika',
  'Jaringan Komputer',
];

class HalamanJadwal extends StatelessWidget {
  const HalamanJadwal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jadwal Hari Ini')),
      body: Column(
        children: [
          const ListTile(title: Text('Senin, 4 mata kuliah')),
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text(jadwal[index]));
            },
          ),
        ],
      ),
    );
  }
}
```

**C2.** Daftar kontak yang bisa dihapus dengan cara digeser.

```dart
class _HalamanKontakState extends State<HalamanKontak> {
  final List<String> _kontak = ['Ayu', 'Bima', 'Citra', 'Dewa'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kontak')),
      body: ListView.builder(
        itemCount: _kontak.length,
        itemBuilder: (BuildContext context, int index) {
          final String nama = _kontak[index];
          return Dismissible(
            key: ValueKey<int>(index),
            onDismissed: (DismissDirection arah) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$nama dihapus.')),
              );
            },
            child: ListTile(title: Text(nama)),
          );
        },
      ),
    );
  }
}
```

**C3.** Toko daring dengan `go_router`. Beranda berisi `ListTile` yang menjalankan `context.go('/produk/3')` saat diketuk, dan `HalamanProduk` menerima `final int id`.

```dart
final GoRouter petaRute = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HalamanBeranda();
      },
      routes: [
        GoRoute(
          path: 'produk/:id',
          builder: (BuildContext context, GoRouterState state) {
            final int id = state.pathParameters['id']!;
            return HalamanProduk(id: id);
          },
        ),
      ],
    ),
  ],
);

class AplikasiToko extends StatelessWidget {
  const AplikasiToko({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HalamanBeranda());
  }
}
```

<details>
<summary>💡 Petunjuk Bagian C</summary>

- C1: ingat aturan daftar di dalam `Column`, dan apa yang terjadi jika `ListView.builder` tidak tahu jumlah barisnya (Bagian 3.2 dan 6).
- C2: apa yang **wajib** dilakukan di `onDismissed`, dan *key* seperti apa yang aman (Bagian 7.1 dan 7.2)?
- C3: apa jenis data parameter alamat, dan bagaimana `MaterialApp` mengenal peta rute (Bagian 13.3 dan 13.5)?
</details>

---

## D. Menulis Program

Kerjakan setiap soal sebagai **aplikasi utuh** yang bisa dijalankan. Uji di lebar 360 dan 320.

**D1 — Galeri Ruang Kampus.** Buat aplikasi untuk melihat ruangan yang bisa dipinjam:

- *Class* model `Ruang` berisi `id`, nama, gedung, kapasitas, ikon, dan daftar fasilitas (`List<String>`). Siapkan minimal **6** ruang.
- Tampilkan ruangan sebagai `GridView` yang berisi **2 kolom** di lebar 360 dan otomatis bertambah kolomnya di layar yang lebih lebar. Setiap kotak berisi ikon, nama ruang, dan kapasitasnya (misalnya "40 orang").
- Mengetuk kotak membuka **halaman detail** yang menerima data ruang lewat *constructor*. Halaman detail menampilkan ikon besar, gedung, kapasitas, dan fasilitas sebagai deretan `Chip`.
- Tidak boleh ada *overflow*, termasuk untuk nama ruang yang panjang.

<details>
<summary>💡 Petunjuk D1</summary>

Gunakan `SliverGridDelegateWithMaxCrossAxisExtent` dengan `mainAxisExtent` (Bagian 5). Batasi nama ruang dengan `maxLines` dan `TextOverflow.ellipsis`. Deretan `Chip` yang bisa turun ke baris berikutnya dibuat dengan `Wrap` (Pertemuan 4). Halaman detail cukup `StatelessWidget` (Bagian 10.2).
</details>

**D2 — Kamus Istilah Flutter.** Buat kamus kecil untuk istilah yang Anda pelajari sejauh ini:

- Minimal **10** istilah, masing-masing berisi istilah, artinya, dan kategori berupa `enum` (misalnya Widget, Dart, Navigasi).
- Kotak pencarian yang mencari di **istilah maupun artinya**, tanpa membedakan huruf besar dan kecil.
- `ChoiceChip` kategori, termasuk pilihan "Semua", yang bisa dipakai bersamaan dengan pencarian.
- Tampilkan jumlah hasil, misalnya "3 istilah ditemukan". Jika hasilnya kosong, tampilkan pesan yang menyebut kata kunci yang dicari dan tombol untuk menampilkan semua istilah lagi.

<details>
<summary>💡 Petunjuk D2</summary>

Ikuti pola contoh 06 (Bagian 8). Syarat cocoknya cukup ditambah satu: `istilah.contains(kunci) || arti.contains(kunci)`, keduanya setelah `toLowerCase()`. Ingat bahwa `clear()` pada *controller* tidak memanggil `onChanged` (Bagian 8.4).
</details>

**D3 — Bank Ide Proyek.** Buat aplikasi dua halaman untuk mengumpulkan ide proyek akhir semester:

- Halaman daftar menyimpan ide di *State*. Tombol `FloatingActionButton` **+** membuka halaman "Ide Baru".
- Halaman "Ide Baru" berisi `TextField` dan tombol **"Simpan"** yang **nonaktif** selama kolomnya kosong. "Simpan" menutup halaman sambil mengirim tulisan ide ke halaman daftar.
- Jika kolom sudah berisi tulisan dan pengguna menekan tombol kembali, tampilkan dialog **"Buang ide ini?"**. Halaman hanya tertutup jika pengguna memilih "Buang".
- Ide terbaru tampil **paling atas**. Ide bisa dihapus dengan cara digeser, lengkap dengan tombol **"Urungkan"**. Jika daftar kosong, tampilkan pesan yang ramah.

<details>
<summary>💡 Petunjuk D3</summary>

Dua ide bisa saja berisi tulisan yang sama, sehingga tulisan tidak bisa dijadikan *key*. Buat *class* `Ide` berisi `id` dan `isi`, lalu beri `id` dari sebuah penghitung (`int _idBerikutnya = 1;` yang dinaikkan setiap kali ada ide baru). Ide baru disisipkan di depan dengan `insert(0, ...)`. Pola halaman tulis dengan `PopScope` ada di contoh 10 (Bagian 12), sedangkan pola menerima hasil ada di Bagian 11.
</details>

---

[⬅️ Kembali ke Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md) · [🏠 Beranda](../README.md)

# 🧪 Jobsheet Pertemuan 14 — Pengujian & *Debugging*

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [✍️ Latihan](LATIHAN.md) · [💻 Kode Contoh](kode/)

| Informasi | Keterangan |
| :--- | :--- |
| Mata kuliah | Pemrograman Piranti Bergerak |
| Pertemuan | 14 — Pengujian & *Debugging* |
| Bentuk kegiatan | Praktikum individu |
| Estimasi waktu | 150 menit |
| Alat | Praktikum 1 dan 2: DartPad **atau** VS Code. Praktikum 3 dan 4: proyek Flutter baru bernama `kas_kelas` di VS Code. Praktikum 5: proyek `tugas_kuliahku` hasil Pertemuan 12 |
| Perangkat | Laptop sudah cukup. Semua tes berjalan **tanpa** HP, emulator, maupun Chrome. Chrome hanya dipakai untuk melihat aplikasinya |
| Paket | `flutter_test` (sudah ada di setiap proyek Flutter) dan `provider`. DartPad menyediakan keduanya |
| Koneksi | Internet dibutuhkan untuk memasang paket dan, di Praktikum 5, untuk GitHub |
| Hasil akhir | Proyek "Kas Kelas" yang punya tes unit, tes ViewModel, dan tes widget; empat bug kiriman teman yang ditemukan dengan tes, *stack trace*, dan *debugger*, lalu dikunci dengan tes regresi; serta proyek "Tugas Kuliahku" yang punya tes sendiri, laporan cakupan, dan pemeriksaan otomatis di GitHub |

---

## 🎯 Tujuan Praktikum

Setelah menyelesaikan jobsheet ini, Anda mampu:

1. Menulis **tes unit** dengan pola siapkan–lakukan–periksa, termasuk tes di **nilai batas**, lalu membaca laporan tes yang gagal.
2. Menguji **ViewModel** dengan *repository* palsu: keadaan memuat, berhasil, dan gagal; aturan yang diperiksa sebelum menyimpan; penjaga ketukan ganda; dan jam palsu.
3. Menulis **tes widget** yang memasang aplikasi asli dengan data palsu, lalu mengetik, mengetuk, dan memeriksa layar, termasuk layar 320 piksel dengan huruf 200% dan pedoman aksesibilitas.
4. **Melacak bug** dari tes yang merah, pesan galat, *stack trace*, *breakpoint*, dan *logpoint*, lalu **mengunci** setiap bug dengan tes regresi.
5. Menata tes di proyek berlapis (`test/` mencerminkan `lib/`, data palsu di `testing/fakes/`), mengukur **cakupan**, dan menjalankan tes **otomatis** di GitHub Actions.

## 📌 Petunjuk Umum

> [!IMPORTANT]
> 1. Setiap praktikum diawali **kode terbimbing**. **Ketik sendiri** kodenya, kecuali bagian yang ditandai *boleh disalin*.
> 2. Kerjakan **🔧 Modifikasi** di setiap praktikum. Jawaban berupa penjelasan ditulis sebagai **komentar** di dalam kode.
> 3. Nama berkas tes **wajib** berakhiran `_test.dart`. Praktikum 1 dan 2 disimpan sebagai `praktikum1_test.dart` dan `praktikum2_test.dart`. Praktikum 3 dan 4 dikerjakan di proyek `kas_kelas`, Praktikum 5 di proyek `tugas_kuliahku`.
> 4. Rapikan kode sebelum menyimpan: tombol **Format** di DartPad, atau `Shift` + `Alt` + `F` di VS Code. Pastikan tidak ada garis merah maupun kuning.
> 5. **Aturan hari ini:** (1) nama setiap tes berupa **kalimat** yang menjelaskan perilaku yang diharapkan; (2) lihat tes **merah** dulu, baru hijau, karena tes yang belum pernah merah belum terbukti bisa menangkap bug; (3) jika tes merah, **perbaiki kodenya**, bukan tesnya, kecuali aturannya memang berubah; (4) setiap bug yang ditemukan **dikunci** dengan tes regresi.
> 6. Banyak modifikasi berupa **eksperimen**: Anda sengaja membuat kesalahan untuk melihat akibatnya. Setelah akibatnya dicatat sebagai komentar, **kembalikan** kodenya seperti semula, kecuali diminta lain.

> [!NOTE]
> Praktikum 1–4 membangun **satu aplikasi** secara bertahap: aturan kas (Praktikum 1) → ViewModel dan data palsu (Praktikum 2) → tampilan dan tes widget (Praktikum 3) → memburu bug kiriman teman (Praktikum 4). Praktikum 5 kembali ke proyek **"Tugas Kuliahku"** yang beristirahat sejak Pertemuan 12. Bandingkan juga dengan contoh di modul: Praktikum 1 ↔ Contoh 01 dan 02, Praktikum 2 ↔ Contoh 04, Praktikum 3 ↔ Contoh 05 dan 06, Praktikum 4 ↔ Contoh 09 dan 10, Praktikum 5 ↔ Contoh 08.

> [!TIP]
> **Di mana melihat hasil tes?**
> - **DartPad:** panel **Console**. Baris terakhirnya berbunyi `All tests passed!` atau `Some tests failed.`
> - **VS Code:** tulisan kecil **Run | Debug** di atas setiap `test(`, `group(`, dan `void main()`, atau panel **Testing** (ikon tabung reaksi di bilah kiri). Tes yang lulus diberi centang hijau, yang gagal diberi tanda silang merah ([Modul Bagian 2.3](README.md#23-tiga-cara-menjalankan-tes)).
> - **Terminal:** `flutter test` menjalankan **semua** berkas tes di folder `test/`, sedangkan `flutter test test/nama_test.dart` menjalankan satu berkas saja.

<details>
<summary>❓ Lupa cara menjalankan program?</summary>

- **DartPad:** buka <https://dartpad.dev>, hapus kode bawaannya, tempelkan kode Anda, lalu klik **Run**. Berkas tes dijalankan seperti program biasa: `main()` mendaftarkan semua tes, lalu hasilnya muncul di **Console**.
- **Proyek Flutter:** buka folder proyek di VS Code. Aplikasinya dijalankan dengan **F5** atau `flutter run -d chrome`, sedangkan tesnya dengan `flutter test`. Setelah **menambah paket** dengan `flutter pub add`, hentikan aplikasi lalu jalankan ulang; *hot reload* saja tidak cukup.

Penjelasan lengkap ada di [Panduan Menjalankan Kode](../panduan/03_menjalankan_kode_contoh.md).
</details>

---

## Praktikum 1 — Aturan Kas Kelas dan Tes Unit Pertama

**Konsep:** tes unit, pola siapkan–lakukan–periksa, `expect` dan *matcher*, `group`, fungsi bantu di dalam tes, tabel kasus, nilai batas, dan membaca tes yang gagal. ([Modul Bagian 2](README.md#2-tes-unit-pertama) dan [Bagian 3](README.md#3-matcher-pengecualian-setup-dan-group))

Bendahara kelas Anda mencatat uang kas di buku tulis. Setiap akhir bulan, angkanya tidak pernah cocok dengan isi dompet kas. Kelas Anda sepakat membuat aplikasi **"Kas Kelas"** dengan aturan berikut:

| Aturan | Nilai |
| :--- | :--- |
| Iuran | Rp5.000 per mahasiswa per minggu |
| Status iuran | **Lunas** jika tidak ada tunggakan, **menunggak** jika tertunggak 1–2 minggu, **perlu ditagih** jika tertunggak 3 minggu atau lebih |
| Pengeluaran | Keperluan minimal 5 huruf; jumlah minimal Rp1.000; tidak boleh melebihi saldo; di atas Rp200.000 harus disetujui ketua kelas |
| Saldo | Semua pemasukan dikurangi semua pengeluaran |

Sebelum ada satu tombol pun, aturan-aturan ini ditulis sebagai fungsi Dart biasa, lalu **diuji**. Fungsi tanpa tampilan seperti ini paling mudah dan paling cepat diuji: tidak perlu HP, tidak perlu layar, dan hasilnya keluar dalam hitungan detik.

### Langkah 1 — Aturan kas (ketik sendiri)

Buka DartPad, hapus kode bawaannya, lalu ketik:

> [!WARNING]
> Aturan di bawah ini **sengaja** berisi **satu bug** kecil, seperti kode buatan manusia pada umumnya. Ketik **persis** seperti tertulis, termasuk bagian yang menurut Anda salah. Bug itu akan ditemukan oleh tes di Langkah 3.

```dart
// =====================================================================
// JOBSHEET PERTEMUAN 14 - PRAKTIKUM 1
// Aturan Kas Kelas dan Tes Unit Pertama
// =====================================================================

import 'package:flutter_test/flutter_test.dart';

// ================== BAGIAN 1: ATURAN KAS (ketik sendiri) ==================

/// Iuran setiap mahasiswa per minggu.
const int iuranPerMinggu = 5000;

/// Pengeluaran di atas batas ini harus disetujui ketua kelas.
const int batasTanpaPersetujuan = 200000;

enum StatusIuran { lunas, menunggak, perluDitagih }

/// Tunggakan dalam rupiah. Membayar di muka tidak membuat tunggakan
/// menjadi negatif.
int hitungTunggakan({required int mingguBerjalan, required int mingguDibayar}) {
  final int selisih = mingguBerjalan - mingguDibayar;
  return selisih > 0 ? selisih * iuranPerMinggu : 0;
}

/// Lunas: tidak ada tunggakan. Menunggak: 1 atau 2 minggu.
/// Perlu ditagih: 3 minggu atau lebih.
StatusIuran statusIuran(int mingguTertunggak) {
  if (mingguTertunggak <= 0) {
    return StatusIuran.lunas;
  }
  if (mingguTertunggak > 3) {
    return StatusIuran.perluDitagih;
  }
  return StatusIuran.menunggak;
}

/// 12500 -> 'Rp12.500'
String rupiah(int angka) {
  final String digit = angka.abs().toString();
  final StringBuffer hasil = StringBuffer();
  for (int i = 0; i < digit.length; i++) {
    if (i > 0 && (digit.length - i) % 3 == 0) {
      hasil.write('.');
    }
    hasil.write(digit[i]);
  }
  return '${angka < 0 ? '-' : ''}Rp$hasil';
}

/// Alasan penolakan, atau null jika pengeluaran boleh dicatat.
String? periksaPengeluaran({
  required int jumlah,
  required int saldo,
  required String keperluan,
  bool disetujuiKetua = false,
}) {
  if (keperluan.trim().length < 5) {
    return 'Tuliskan keperluan minimal 5 huruf.';
  }
  if (jumlah < 1000) {
    return 'Pengeluaran minimal Rp1.000.';
  }
  if (jumlah > saldo) {
    return 'Saldo tidak cukup. Saldo saat ini ${rupiah(saldo)}.';
  }
  if (jumlah > batasTanpaPersetujuan && !disetujuiKetua) {
    return 'Pengeluaran di atas ${rupiah(batasTanpaPersetujuan)} '
        'harus disetujui ketua kelas.';
  }
  return null;
}

enum JenisTransaksi { pemasukan, pengeluaran }

class Transaksi {
  Transaksi({
    required this.jenis,
    required this.jumlah,
    required this.keterangan,
    required this.tanggal,
  }) {
    if (jumlah <= 0) {
      throw ArgumentError.value(jumlah, 'jumlah', 'harus lebih dari 0');
    }
  }

  final JenisTransaksi jenis;
  final int jumlah; // selalu positif; arahnya ditentukan jenis
  final String keterangan;
  final DateTime tanggal;
}

/// Pemasukan menambah saldo, pengeluaran mengurangi.
int hitungSaldo(List<Transaksi> daftar) {
  int saldo = 0;
  for (final Transaksi t in daftar) {
    saldo += t.jenis == JenisTransaksi.pemasukan ? t.jumlah : -t.jumlah;
  }
  return saldo;
}
```

| Bagian | Penjelasan |
| :--- | :--- |
| `import 'package:flutter_test/flutter_test.dart';` | Berisi `test`, `expect`, `group`, dan semua *matcher*. DartPad dan setiap proyek Flutter sudah menyediakannya |
| `const int iuranPerMinggu = 5000;` | Angka aturan diberi **nama**. Kode dan tes memakai nama yang sama, sehingga aturan cukup diubah di satu tempat |
| `hitungTunggakan({required int mingguBerjalan, required int mingguDibayar})` | Parameter bernama membuat pemanggilannya mudah dibaca: `hitungTunggakan(mingguBerjalan: 4, mingguDibayar: 3)` |
| `String? periksaPengeluaran(...)` | Mengembalikan **alasan penolakan**, atau `null` jika pengeluaran boleh dicatat. Pola yang sama dengan Pertemuan 12 dan 13 |
| Urutan `if` di `periksaPengeluaran` | Pemeriksaan **pertama** yang gagal menentukan pesannya. Keperluan diperiksa lebih dulu daripada jumlah |
| `if (jumlah <= 0) { throw ArgumentError.value(...); }` | Jumlah transaksi selalu **positif**; arahnya (masuk atau keluar) ditentukan `jenis`. Nilai yang mustahil langsung ditolak dengan *exception* ([Modul Bagian 3.2](README.md#32-menguji-exception)) |
| `hitungSaldo` | Pemasukan menambah saldo, pengeluaran mengurangi |

### Langkah 2 — Tes (ketik sendiri)

Masih di berkas yang sama, di bawah aturan, ketik:

```dart
// ===================== BAGIAN 2: TES (ketik sendiri) ======================

void main() {
  group('hitungTunggakan', () {
    test('membayar sampai minggu ini: tidak ada tunggakan', () {
      expect(hitungTunggakan(mingguBerjalan: 4, mingguDibayar: 4), 0);
    });

    test('kurang satu minggu: Rp5.000', () {
      expect(hitungTunggakan(mingguBerjalan: 4, mingguDibayar: 3), 5000);
    });

    test('membayar di muka tidak membuat tunggakan negatif', () {
      expect(hitungTunggakan(mingguBerjalan: 4, mingguDibayar: 6), 0);
    });
  });

  group('statusIuran', () {
    test('0 minggu: lunas', () {
      expect(statusIuran(0), StatusIuran.lunas);
    });

    test('1 dan 2 minggu: menunggak', () {
      expect(statusIuran(1), StatusIuran.menunggak);
      expect(statusIuran(2), StatusIuran.menunggak);
    });

    test('tepat 3 minggu: perlu ditagih', () {
      expect(statusIuran(3), StatusIuran.perluDitagih);
    });
  });

  group('periksaPengeluaran', () {
    String? periksa({
      int jumlah = 12000,
      int saldo = 50000,
      String keperluan = 'Spidol papan tulis',
      bool disetujuiKetua = false,
    }) {
      return periksaPengeluaran(
        jumlah: jumlah,
        saldo: saldo,
        keperluan: keperluan,
        disetujuiKetua: disetujuiKetua,
      );
    }

    test('pengeluaran wajar boleh', () {
      expect(periksa(), isNull);
    });

    test('keperluan 4 huruf ditolak, 5 huruf boleh', () {
      expect(periksa(keperluan: 'Kopi'), 'Tuliskan keperluan minimal 5 huruf.');
      expect(periksa(keperluan: 'Kertas'), isNull);
    });

    test('spasi di ujung keperluan tidak dihitung', () {
      expect(periksa(keperluan: '  Kopi  '), isNotNull);
    });

    test('Rp999 ditolak, Rp1.000 boleh', () {
      expect(periksa(jumlah: 999), 'Pengeluaran minimal Rp1.000.');
      expect(periksa(jumlah: 1000), isNull);
    });

    test('tepat sebesar saldo boleh, lebih Rp1 ditolak', () {
      expect(periksa(jumlah: 50000), isNull);
      expect(
        periksa(jumlah: 50001),
        'Saldo tidak cukup. Saldo saat ini Rp50.000.',
      );
    });

    test('di atas Rp200.000 butuh persetujuan ketua', () {
      expect(periksa(jumlah: 200000, saldo: 500000), isNull);
      expect(periksa(jumlah: 200001, saldo: 500000), contains('ketua kelas'));
      expect(
        periksa(jumlah: 200001, saldo: 500000, disetujuiKetua: true),
        isNull,
      );
    });
  });

  group('Transaksi dan saldo', () {
    final DateTime senin = DateTime(2026, 10, 12);

    test('jumlah 0 ditolak dengan ArgumentError', () {
      expect(
        () => Transaksi(
          jenis: JenisTransaksi.pemasukan,
          jumlah: 0,
          keterangan: 'Iuran Rina',
          tanggal: senin,
        ),
        throwsArgumentError,
      );
    });

    test('pemasukan menambah, pengeluaran mengurangi', () {
      final List<Transaksi> daftar = [
        Transaksi(
          jenis: JenisTransaksi.pemasukan,
          jumlah: 25000,
          keterangan: 'Iuran minggu 1',
          tanggal: senin,
        ),
        Transaksi(
          jenis: JenisTransaksi.pengeluaran,
          jumlah: 12000,
          keterangan: 'Spidol papan tulis',
          tanggal: senin,
        ),
      ];
      expect(hitungSaldo(daftar), 13000);
    });

    test('belum ada transaksi: saldo 0', () {
      expect(hitungSaldo([]), 0);
    });
  });

  group('rupiah()', () {
    const Map<int, String> kasus = {
      0: 'Rp0',
      999: 'Rp999',
      1000: 'Rp1.000',
      13000: 'Rp13.000',
      200000: 'Rp200.000',
      1250000: 'Rp1.250.000',
    };
    kasus.forEach((int angka, String harapan) {
      test('$angka menjadi $harapan', () {
        expect(rupiah(angka), harapan);
      });
    });
  });
}
```

| Bagian | Penjelasan |
| :--- | :--- |
| `void main() { ... }` | Di berkas tes, `main()` hanya **mendaftarkan** tes. Setelah itu, setiap tes dijalankan satu per satu |
| `group('hitungTunggakan', () { ... })` | Mengelompokkan tes yang menguji hal yang sama. Nama grup ikut tampil di depan nama tes ([Modul Bagian 3.4](README.md#34-group-mengelompokkan-tes)) |
| `expect(hitungTunggakan(...), 0)` | Hasil **sebenarnya** di kiri, **harapan** di kanan |
| `String? periksa({int jumlah = 12000, ...})` | **Fungsi bantu** di dalam grup. Nilai bawaannya adalah satu pengeluaran yang wajar, jadi setiap tes cukup menyebut **satu** hal yang berbeda, misalnya `periksa(jumlah: 999)` |
| `999` dan `1000`, `50000` dan `50001`, `200000` dan `200001` | **Nilai batas**: tepat di batas dan selisih satu dari batas. Di sinilah bug paling sering bersembunyi ([Modul Bagian 2.7](README.md#27-nilai-batas-di-sinilah-bug-bersembunyi)) |
| `isNull`, `isNotNull`, `contains('ketua kelas')`, `throwsArgumentError` | *Matcher*: cara memeriksa yang lebih kaya daripada sekadar "sama dengan" ([Modul Bagian 3.1](README.md#31-matcher-cara-memeriksa-yang-lebih-kaya)) |
| `() => Transaksi(...)` | Kode yang diharapkan **melempar** *exception* dibungkus fungsi, agar `expect` sendiri yang menjalankan dan menangkapnya |
| `const Map<int, String> kasus = {...}` lalu `kasus.forEach(...)` | **Tabel kasus**: satu pola tes untuk banyak data. Setiap baris tabel menjadi satu tes dengan nama sendiri ([Modul Bagian 3.6](README.md#36-tabel-kasus-banyak-data-satu-pola)) |

### Langkah 3 — Jalankan, lalu baca yang merah

Klik **Run**. Di panel **Console**, satu tes gagal:

```text
00:00 +0: hitungTunggakan membayar sampai minggu ini: tidak ada tunggakan
00:00 +1: hitungTunggakan kurang satu minggu: Rp5.000
00:00 +2: hitungTunggakan membayar di muka tidak membuat tunggakan negatif
00:00 +3: statusIuran 0 minggu: lunas
00:00 +4: statusIuran 1 dan 2 minggu: menunggak
00:00 +5: statusIuran tepat 3 minggu: perlu ditagih
00:00 +5: statusIuran tepat 3 minggu: perlu ditagih [E]
  Expected: StatusIuran:<StatusIuran.perluDitagih>
    Actual: StatusIuran:<StatusIuran.menunggak>
  (baris-baris lokasi galat)
00:00 +5 -1: periksaPengeluaran pengeluaran wajar boleh
...
00:00 +19 -1: rupiah() 1250000 menjadi Rp1.250.000
00:00 +20 -1: Some tests failed.
```

| Yang terlihat | Artinya |
| :--- | :--- |
| `statusIuran tepat 3 minggu: perlu ditagih [E]` | Nama grup dan nama tes yang gagal. Kalimatnya langsung menyebut **aturan** mana yang dilanggar |
| `Expected: StatusIuran:<StatusIuran.perluDitagih>` | Yang **diharapkan** tes |
| `Actual: StatusIuran:<StatusIuran.menunggak>` | Yang **dihasilkan** kode |
| `+20 -1` | 20 tes lulus, 1 gagal |

Sekarang jadilah detektif. Baca kembali fungsi `statusIuran` di Langkah 1 sambil membayangkan `mingguTertunggak` bernilai `3`. Kondisi `if` mana yang terpenuhi? Mengapa hasilnya `menunggak`?

Perhatikan juga bahwa tes `'1 dan 2 minggu: menunggak'` tetap hijau, padahal kodenya salah. Itulah sebabnya nilai **tepat di batas** (3 minggu) wajib punya tes sendiri.

### Langkah 4 — Perbaiki kodenya, bukan tesnya

Aturannya berbunyi "3 minggu **atau lebih**", jadi ganti `>` menjadi `>=`:

```dart
  if (mingguTertunggak >= 3) {
```

Jalankan lagi.

✅ **Hasil yang diharapkan** (baris terakhir di Console):

```text
00:00 +21: All tests passed!
```

> [!TIP]
> Mengerjakan di VS Code? Simpan berkas ini di folder `test/` proyek Flutter mana pun, misalnya proyek `kas_kelas` dari Praktikum 3, lalu jalankan `flutter test test/praktikum1_test.dart`. Di terminal, baris kemajuan ditulis ulang di tempat yang sama, sehingga yang tersisa hanya baris terakhir.

🔧 **Modifikasi:**

1. **Eksperimen — siapa yang menjaga angka iuran?** Ubah sementara `iuranPerMinggu` menjadi `6000`, lalu jalankan. Berapa tes yang merah? Jawab sebagai komentar: mengapa hanya tes itu yang merah, padahal tes `'membayar sampai minggu ini: tidak ada tunggakan'` juga memanggil `hitungTunggakan`? Kembalikan nilainya.
2. **Eksperimen — membaca pesan teks yang berbeda.** Ubah sementara harapan tes `'Rp999 ditolak, Rp1.000 boleh'` menjadi `'Pengeluaran minimal Rp 1.000.'` (ada spasi setelah `Rp`). Salin pesan kegagalannya sebagai komentar, lalu jelaskan bagaimana pesan itu menunjukkan **letak** perbedaannya. Kembalikan.
3. **Tes yang langsung hijau.** Tambahkan tes `'membayar di muka: lunas'` yang memeriksa `statusIuran(-2)`. Tes ini langsung hijau. Jawab sebagai komentar: apakah tes yang langsung hijau tetap berguna? Kapan ia bisa menjadi merah?
4. **Aturan baru, tes lebih dulu.** Bendahara meminta keperluan ditulis **paling banyak 40 huruf** (setelah spasi di ujung dibuang), dengan pesan `'Tuliskan keperluan paling banyak 40 huruf.'`. Tulis **dulu** tesnya di nilai batas (40 huruf boleh, 41 huruf ditolak), jalankan sampai **merah**, baru tambahkan aturannya sampai **hijau**. Petunjuk: `'a' * 40` menghasilkan teks 40 huruf.
5. **Satu baris tabel lagi.** Tambahkan kasus `-12500: '-Rp12.500'` ke tabel `rupiah()`. Jawab sebagai komentar: berapa baris kode yang perlu ditambah untuk satu kasus baru, dibandingkan jika setiap kasus ditulis sebagai `test(...)` sendiri?

---

## Praktikum 2 — ViewModel Kas dengan *Repository* Palsu

**Konsep:** ViewModel diuji tanpa layar, *repository* palsu dengan "*remote control*" dan mata-mata (*spy*), keadaan antara dengan `tahan` dan `lepaskan`, jam palsu, `setUp` dan `tearDown` bertingkat, serta tes `async`. ([Modul Bagian 4](README.md#4-menguji-kode-asinkron) dan [Bagian 5](README.md#5-menguji-viewmodel-dengan-data-palsu))

Nantinya data kas disimpan di server kampus. Selama server itu belum ada, **dan** setiap kali menguji, kita memakai *repository* palsu: cepat, tanpa internet, dan bisa disuruh gagal kapan saja.

```text
RepositoriKas (kontrak)
├── RepositoriKasMemori   ← untuk menjalankan aplikasi (Praktikum 3)
└── RepositoriKasPalsu    ← khusus TES: bisa gagal, menghitung, dan ditahan

KasViewModel  ← diuji memakai RepositoriKasPalsu, tanpa layar
```

Hari ini ViewModel-nya **boleh disalin**, karena cara menulisnya sudah dipelajari di Pertemuan 9 dan 12. Yang **diketik sendiri** adalah *repository* palsu dan tesnya.

### Langkah 1 — Impor dan aturan dari Praktikum 1

Buat berkas baru `praktikum2_test.dart`. Bagian atasnya:

```dart
// =====================================================================
// JOBSHEET PERTEMUAN 14 - PRAKTIKUM 2
// ViewModel Kas Kelas dengan Repository Palsu
// =====================================================================

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

// ======== BAGIAN 1: ATURAN (salin dari Praktikum 1, TANPA main()) =========

// ... salin di sini: aturan dari Praktikum 1, mulai iuranPerMinggu
// sampai akhir fungsi hitungSaldo ...
```

Lalu **salin** seluruh aturan dari Praktikum 1 yang **sudah diperbaiki**, mulai `const int iuranPerMinggu` sampai akhir fungsi `hitungSaldo`. **Jangan** ikut menyalin `void main()` beserta tesnya, karena satu berkas hanya boleh punya satu `main()`.

| Bagian | Penjelasan |
| :--- | :--- |
| `import 'dart:async';` | Untuk `Completer`, "janji" yang baru ditepati saat kita mau ([Modul Bagian 5.3](README.md#53-data-palsu-dengan-remote-control)) |
| `import 'package:flutter/foundation.dart';` | Untuk `ChangeNotifier`. ViewModel cukup mengenal `foundation`, tidak perlu `material` |

### Langkah 2 — Hasil, kegagalan, kontrak, dan data contoh (boleh disalin)

```dart
// ================= BAGIAN 2: HASIL DAN KEGAGALAN (salin) ==================

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

final class ServerBermasalah extends Kegagalan {
  const ServerBermasalah(this.kodeStatus);

  final int kodeStatus;
}

final class PenyimpananGagal extends Kegagalan {
  const PenyimpananGagal();
}

String pesanKegagalan(Kegagalan kegagalan) {
  return switch (kegagalan) {
    TanpaKoneksi() => 'Tidak dapat terhubung. Periksa koneksi internet Anda.',
    ServerBermasalah(:final int kodeStatus) =>
      'Server sedang bermasalah (kode $kodeStatus). Coba lagi nanti.',
    PenyimpananGagal() => 'Data gagal disimpan. Coba lagi.',
  };
}

// ====================== BAGIAN 3: REPOSITORY (salin) ======================

abstract interface class RepositoriKas {
  Future<Hasil<List<Transaksi>>> semua();

  Future<Hasil<Transaksi>> simpan(Transaksi transaksi);
}

/// Data contoh: saldo akhirnya Rp30.000.
final List<Transaksi> contohTransaksi = [
  Transaksi(
    jenis: JenisTransaksi.pemasukan,
    jumlah: 25000,
    keterangan: 'Iuran minggu 1',
    tanggal: DateTime(2026, 10, 5),
  ),
  Transaksi(
    jenis: JenisTransaksi.pengeluaran,
    jumlah: 12000,
    keterangan: 'Spidol papan tulis',
    tanggal: DateTime(2026, 10, 7),
  ),
  Transaksi(
    jenis: JenisTransaksi.pemasukan,
    jumlah: 25000,
    keterangan: 'Iuran minggu 2',
    tanggal: DateTime(2026, 10, 12),
  ),
  Transaksi(
    jenis: JenisTransaksi.pengeluaran,
    jumlah: 8000,
    keterangan: 'Fotokopi modul',
    tanggal: DateTime(2026, 10, 13),
  ),
];
```

| Bagian | Penjelasan |
| :--- | :--- |
| `Hasil`, `Berhasil`, `Gagal`, `Kegagalan` | Sama dengan Pertemuan 12. Kegagalan **dikembalikan**, tidak dilempar, sehingga ViewModel tidak memerlukan `try`–`catch` |
| `PenyimpananGagal` | Jenis kegagalan baru: data gagal disimpan |
| `abstract interface class RepositoriKas` | Kontrak: siapa pun yang mengaku `RepositoriKas` **wajib** punya `semua()` dan `simpan()` |
| `contohTransaksi` | Empat transaksi contoh: 25.000 − 12.000 + 25.000 − 8.000 = **Rp30.000**. Angka ini dipakai di banyak tes, jadi hafalkan |

### Langkah 3 — ViewModel (boleh disalin)

```dart
// ====================== BAGIAN 4: VIEWMODEL (salin) =======================

enum StatusMuat { memuat, berhasil, gagal }

class KasViewModel extends ChangeNotifier {
  KasViewModel({required this._repositori, DateTime Function()? sekarang})
    : _sekarang = sekarang ?? DateTime.now;

  final RepositoriKas _repositori;

  // Jam yang bisa diganti. Aplikasi memakai DateTime.now; tes memakai jam
  // palsu agar tanggal transaksi bisa diperiksa dengan pasti.
  final DateTime Function() _sekarang;

  StatusMuat _status = StatusMuat.memuat;
  List<Transaksi> _daftar = [];
  String _pesanGalat = '';
  String? _pesanSimpan;
  bool _menyimpan = false;
  bool _sudahDibuang = false;

  StatusMuat get status => _status;
  List<Transaksi> get daftar => List.unmodifiable(_daftar);
  String get pesanGalat => _pesanGalat;
  String? get pesanSimpan => _pesanSimpan;
  bool get menyimpan => _menyimpan;
  int get saldo => hitungSaldo(_daftar);

  Future<void> muat() async {
    _status = StatusMuat.memuat;
    _kabari();
    final Hasil<List<Transaksi>> hasil = await _repositori.semua();
    switch (hasil) {
      case Berhasil(:final List<Transaksi> nilai):
        _daftar = nilai;
        _status = StatusMuat.berhasil;
      case Gagal(:final Kegagalan kegagalan):
        _pesanGalat = pesanKegagalan(kegagalan);
        _status = StatusMuat.gagal;
    }
    _kabari();
  }

  /// Mengembalikan true jika pengeluaran tersimpan.
  Future<bool> catatPengeluaran({
    required int jumlah,
    required String keperluan,
  }) async {
    // PENJAGA: selama penyimpanan berjalan, ketukan berikutnya diabaikan.
    if (_menyimpan) {
      return false;
    }
    // Aturan diperiksa SEBELUM menghubungi repository.
    final String? alasan = periksaPengeluaran(
      jumlah: jumlah,
      saldo: saldo,
      keperluan: keperluan,
    );
    if (alasan != null) {
      _pesanSimpan = alasan;
      _kabari();
      return false;
    }
    _menyimpan = true;
    _pesanSimpan = null;
    _kabari();
    final Hasil<Transaksi> hasil = await _repositori.simpan(
      Transaksi(
        jenis: JenisTransaksi.pengeluaran,
        jumlah: jumlah,
        keterangan: keperluan.trim(),
        tanggal: _sekarang(),
      ),
    );
    _menyimpan = false;
    switch (hasil) {
      case Berhasil():
        await _bacaUlang(); // daftar dibaca ulang dari sumbernya
        return true;
      case Gagal(:final Kegagalan kegagalan):
        _pesanSimpan = pesanKegagalan(kegagalan);
        _kabari();
        return false;
    }
  }

  // Dipanggil View setelah lembar formulir ditutup, agar pesan lama tidak
  // muncul lagi saat formulir dibuka berikutnya.
  void bersihkanPesanSimpan() {
    _pesanSimpan = null;
    _kabari();
  }

  // Membaca ulang tanpa menampilkan lingkaran memuat lagi.
  Future<void> _bacaUlang() async {
    final Hasil<List<Transaksi>> hasil = await _repositori.semua();
    if (hasil is Berhasil<List<Transaksi>>) {
      _daftar = hasil.nilai;
    }
    _kabari();
  }

  // Halaman bisa ditutup sebelum data datang. ViewModel yang sudah dibuang
  // tidak boleh memberi kabar lagi.
  void _kabari() {
    if (!_sudahDibuang) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    super.dispose();
  }
}
```

| Bagian | Penjelasan |
| :--- | :--- |
| `DateTime Function()? sekarang` | **Jam yang bisa diganti.** Aplikasi memakai `DateTime.now`, tes memakai jam palsu, sehingga tanggal transaksi bisa diperiksa dengan pasti |
| `int get saldo => hitungSaldo(_daftar);` | Saldo selalu **dihitung** dari daftar, tidak pernah disimpan terpisah, jadi tidak mungkin "lupa diperbarui" |
| Urutan di `catatPengeluaran` | (1) penjaga ketukan ganda → (2) aturan diperiksa **sebelum** menghubungi *repository* → (3) simpan → (4) baca ulang daftar dari sumbernya |
| `_kabari()` dan `_sudahDibuang` | ViewModel yang sudah dibuang (halamannya ditutup) tidak boleh memberi kabar lagi ([Modul Bagian 5.5](README.md#55-aturan-ketukan-ganda-dan-dispose)) |

### Langkah 4 — *Repository* palsu (ketik sendiri)

```dart
// ========= BAGIAN 5: REPOSITORY PALSU (ketik sendiri, khusus tes) =========

class RepositoriKasPalsu implements RepositoriKas {
  RepositoriKasPalsu({List<Transaksi> isi = const []}) : _isi = [...isi];

  final List<Transaksi> _isi;

  // "Remote control": diisi tes agar repository pura-pura gagal.
  Kegagalan? gagalSaatMemuat;
  Kegagalan? gagalSaatMenyimpan;

  // Mata-mata (spy): berapa kali repository dihubungi.
  int jumlahMemuat = 0;
  int jumlahMenyimpan = 0;

  // Jika true, setiap panggilan MENUNGGU sampai lepaskan() dipanggil.
  bool tahan = false;
  final List<Completer<void>> _menunggu = [];

  void lepaskan() {
    for (final Completer<void> penahan in _menunggu) {
      penahan.complete();
    }
    _menunggu.clear();
  }

  Future<void> _mungkinDitahan() async {
    if (!tahan) {
      return;
    }
    final Completer<void> penahan = Completer<void>();
    _menunggu.add(penahan);
    await penahan.future;
  }

  @override
  Future<Hasil<List<Transaksi>>> semua() async {
    jumlahMemuat++;
    await _mungkinDitahan();
    final Kegagalan? kegagalan = gagalSaatMemuat;
    if (kegagalan != null) {
      return Gagal(kegagalan);
    }
    return Berhasil(List.of(_isi));
  }

  @override
  Future<Hasil<Transaksi>> simpan(Transaksi transaksi) async {
    jumlahMenyimpan++;
    await _mungkinDitahan();
    final Kegagalan? kegagalan = gagalSaatMenyimpan;
    if (kegagalan != null) {
      return Gagal(kegagalan);
    }
    _isi.add(transaksi);
    return Berhasil(transaksi);
  }
}
```

| Bagian | Penjelasan |
| :--- | :--- |
| `implements RepositoriKas` | Analyzer memastikan data palsu punya **semua** perintah kontrak. ViewModel tidak bisa membedakan palsu dan asli |
| `_isi = [...isi]` | Salinan daftar, sehingga isi yang diubah satu tes tidak terbawa ke tes berikutnya |
| `gagalSaatMemuat`, `gagalSaatMenyimpan` | **Remote control**: tes mengisinya agar *repository* pura-pura gagal |
| `jumlahMemuat`, `jumlahMenyimpan` | **Mata-mata** (*spy*): berapa kali *repository* dihubungi. Dipakai untuk membuktikan "aturan diperiksa **sebelum** menyimpan" dan "ketukan ganda hanya menyimpan sekali" |
| `tahan`, `Completer`, `lepaskan()` | Saat `tahan` bernilai `true`, setiap panggilan **menunggu** sampai `lepaskan()` dipanggil. Dengan begitu, keadaan **antara** seperti "sedang menyimpan" bisa diperiksa |

### Langkah 5 — Tes ViewModel (ketik sendiri)

```dart
// ===================== BAGIAN 6: TES (ketik sendiri) ======================

void main() {
  late RepositoriKasPalsu repositori;
  late KasViewModel vm;

  // Jam palsu: "sekarang" selalu Rabu, 14 Oktober 2026 pukul 09.30.
  final DateTime jamPalsu = DateTime(2026, 10, 14, 9, 30);

  setUp(() {
    repositori = RepositoriKasPalsu(isi: contohTransaksi);
    vm = KasViewModel(repositori: repositori, sekarang: () => jamPalsu);
  });

  tearDown(() {
    vm.dispose();
  });

  group('memuat', () {
    test('mula-mula berstatus memuat dengan saldo 0', () {
      expect(vm.status, StatusMuat.memuat);
      expect(vm.saldo, 0);
    });

    test('berhasil: 4 transaksi, saldo Rp30.000', () async {
      await vm.muat();

      expect(vm.status, StatusMuat.berhasil);
      expect(vm.daftar, hasLength(4));
      expect(vm.saldo, 30000);
    });

    test('gagal: menjadi pesan yang ramah, bukan exception', () async {
      repositori.gagalSaatMemuat = const ServerBermasalah(500);

      await vm.muat();

      expect(vm.status, StatusMuat.gagal);
      expect(
        vm.pesanGalat,
        'Server sedang bermasalah (kode 500). Coba lagi nanti.',
      );
    });

    test('pendengar diberi kabar saat mulai dan saat selesai', () async {
      final List<StatusMuat> tercatat = [];
      vm.addListener(() => tercatat.add(vm.status));

      await vm.muat();

      expect(tercatat, [StatusMuat.memuat, StatusMuat.berhasil]);
    });
  });

  group('mencatat pengeluaran', () {
    // setUp di dalam group dijalankan SETELAH setUp di luar.
    setUp(() async {
      await vm.muat();
    });

    test('berhasil: saldo berkurang, tanggal dari jam palsu', () async {
      final bool tersimpan = await vm.catatPengeluaran(
        jumlah: 10000,
        keperluan: 'Kertas HVS',
      );

      expect(tersimpan, isTrue);
      expect(vm.saldo, 20000);
      expect(vm.daftar.last.keterangan, 'Kertas HVS');
      expect(vm.daftar.last.tanggal, jamPalsu);
      expect(repositori.jumlahMemuat, 2); // muat awal + baca ulang
    });

    test('melebihi saldo: ditolak SEBELUM menghubungi repository', () async {
      final bool tersimpan = await vm.catatPengeluaran(
        jumlah: 30001,
        keperluan: 'Kaos kelas',
      );

      expect(tersimpan, isFalse);
      expect(vm.pesanSimpan, 'Saldo tidak cukup. Saldo saat ini Rp30.000.');
      expect(repositori.jumlahMenyimpan, 0);
    });

    test('tepat sebesar saldo boleh: saldo menjadi 0', () async {
      final bool tersimpan = await vm.catatPengeluaran(
        jumlah: 30000,
        keperluan: 'Hadiah dosen wali',
      );

      expect(tersimpan, isTrue);
      expect(vm.saldo, 0);
    });

    test('spasi di ujung keperluan dibuang sebelum disimpan', () async {
      await vm.catatPengeluaran(jumlah: 5000, keperluan: '  Kapur tulis  ');

      expect(vm.daftar.last.keterangan, 'Kapur tulis');
    });

    test('ketukan ganda hanya menyimpan SATU kali', () async {
      repositori.tahan = true;

      final Future<bool> pertama = vm.catatPengeluaran(
        jumlah: 5000,
        keperluan: 'Kapur tulis',
      ); // sengaja BELUM di-await
      expect(vm.menyimpan, isTrue); // tombol di layar seharusnya mati

      final bool kedua = await vm.catatPengeluaran(
        jumlah: 5000,
        keperluan: 'Kapur tulis',
      );
      expect(kedua, isFalse);

      repositori
        ..tahan = false
        ..lepaskan();
      expect(await pertama, isTrue);
      expect(repositori.jumlahMenyimpan, 1);
      expect(vm.menyimpan, isFalse);
    });

    test('penyimpanan gagal: pesan tampil, saldo tetap', () async {
      repositori.gagalSaatMenyimpan = const PenyimpananGagal();

      final bool tersimpan = await vm.catatPengeluaran(
        jumlah: 5000,
        keperluan: 'Kapur tulis',
      );

      expect(tersimpan, isFalse);
      expect(vm.pesanSimpan, 'Data gagal disimpan. Coba lagi.');
      expect(vm.saldo, 30000);
      expect(vm.menyimpan, isFalse);
    });

    test('pesan penolakan bisa dibersihkan', () async {
      await vm.catatPengeluaran(jumlah: 500, keperluan: 'Permen');
      expect(vm.pesanSimpan, 'Pengeluaran minimal Rp1.000.');

      vm.bersihkanPesanSimpan();

      expect(vm.pesanSimpan, isNull);
    });
  });

  test('ViewModel yang dibuang saat memuat tidak memberi kabar lagi', () async {
    // ViewModel kedua, karena yang dari setUp dibuang oleh tearDown.
    final KasViewModel lain = KasViewModel(repositori: repositori);
    repositori.tahan = true;

    final Future<void> proses = lain.muat();
    lain.dispose(); // halaman ditutup sebelum data datang
    repositori.lepaskan();

    // Tanpa penjaga _sudahDibuang, baris ini gagal dengan FlutterError:
    // "A KasViewModel was used after being disposed."
    await proses;
    expect(repositori.jumlahMemuat, 1);
  });
}

// HASIL (baris terakhir; angka waktu di depannya bisa berbeda):
// 00:00 +12: All tests passed!
```

| Bagian | Penjelasan |
| :--- | :--- |
| `late RepositoriKasPalsu repositori;` + `setUp(...)` | Setiap tes mendapat *repository* dan ViewModel **baru**, sehingga tes tidak saling memengaruhi ([Modul Bagian 3.3](README.md#33-setup-dan-teardown-setiap-tes-mulai-dari-nol)) |
| `tearDown(() { vm.dispose(); })` | Dijalankan **setelah** setiap tes: ViewModel dibereskan |
| `sekarang: () => jamPalsu` | Jam palsu: transaksi baru selalu bertanggal 14 Oktober 2026 pukul 09.30 |
| `setUp` di dalam `group` | Dijalankan **setelah** `setUp` di luar. Semua tes "mencatat pengeluaran" dimulai dari daftar yang sudah dimuat |
| `vm.addListener(() => tercatat.add(vm.status))` | Mencatat setiap kabar. Tanpa kabar, layar tidak pernah dibangun ulang ([Modul Bagian 5.4](README.md#54-memeriksa-kabar-ke-pendengar)) |
| `final Future<bool> pertama = vm.catatPengeluaran(...);` | Sengaja **tanpa** `await`: penyimpanan dibiarkan "menggantung" karena *repository* ditahan, lalu keadaan di tengahnya diperiksa |
| `repositori..tahan = false..lepaskan();` | *Cascade* (`..`): dua perintah untuk objek yang sama. "Server" menjawab, dan panggilan berikutnya tidak ditahan lagi |
| Tes terakhir | Halaman ditutup **sebelum** data datang. Tanpa penjaga `_sudahDibuang`, tes ini gagal dengan pesan `A KasViewModel was used after being disposed.` |

### Langkah 6 — Jalankan

✅ **Hasil yang diharapkan** (baris terakhir di Console):

```text
00:00 +12: All tests passed!
```

Perhatikan: dua belas tes ini menguji **semua** keadaan ViewModel, termasuk server gagal dan ketukan ganda, dalam waktu kurang dari satu detik dan tanpa satu pun tombol.

🔧 **Modifikasi:**

1. **Eksperimen — penjaga yang hilang.** Di `_kabari()`, ganti sementara isinya menjadi `notifyListeners();` saja, tanpa `if (!_sudahDibuang)`. Tes mana yang merah, dan apa pesannya? Jawab sebagai komentar: kapan galat ini bisa muncul di aplikasi sungguhan? Kembalikan.
2. **Eksperimen — lupa memberi kabar.** Hapus sementara pemanggilan `_kabari();` yang **terakhir** di `muat()`. Tes mana yang merah? Jawab sebagai komentar: mengapa tes lain tetap hijau, dan apa akibatnya di layar? Kembalikan.
3. **Tes kegagalan lain.** Tambahkan dua tes ke grup `memuat`: (a) `TanpaKoneksi` menghasilkan pesan `'Tidak dapat terhubung. Periksa koneksi internet Anda.'`; (b) setelah gagal, `gagalSaatMemuat` dikosongkan lalu `muat()` dipanggil lagi: status menjadi berhasil dan `jumlahMemuat` bernilai 2.
4. **Fitur baru, tes lebih dulu: mencatat iuran.** Tambahkan `Future<bool> catatIuran({required String nama, required int minggu})` di ViewModel: pemasukan sebesar `minggu × iuranPerMinggu` dengan keterangan `'Iuran $nama ($minggu minggu)'`. Tolak jika `nama` kosong atau `minggu` kurang dari 1, dengan pesan pilihan Anda. Tulis **dulu** minimal tiga tes (berhasil, nama kosong, minggu 0), lihat merah, baru tulis kodenya.
5. **Pertanyaan.** Jawab sebagai komentar: mengapa `KasViewModel` menerima `sekarang` dari luar, bukan langsung memanggil `DateTime.now()`? Tes mana yang tidak mungkin ditulis tanpanya?

---

## Praktikum 3 — Proyek "Kas Kelas": Tampilan dan Tes Widget

**Konsep:** proyek dengan folder `test/` dan `testing/fakes/`, `flutter test`, `testWidgets`, `pumpWidget`, *finder*, `enterText` dan `tap`, `pump` dan `pumpAndSettle`, keadaan memuat dengan *repository* yang ditahan, layar sempit dengan huruf besar, serta pedoman aksesibilitas. ([Modul Bagian 6](README.md#6-tes-widget-pertama) dan [Bagian 7](README.md#7-tes-widget-dengan-viewmodel))

Aturan dan ViewModel sudah teruji. Kini keduanya dipindahkan ke proyek Flutter sungguhan, diberi tampilan, lalu tampilannya **ikut diuji**. Tes widget tidak bisa dijalankan di DartPad ([Modul Bagian 6.6](README.md#66-mengapa-tes-widget-tidak-dijalankan-di-dartpad)), jadi mulai praktikum ini kita bekerja di VS Code.

### Langkah 1 — Proyek baru

Di terminal, pada folder tempat Anda biasa menyimpan proyek:

```bash
flutter create kas_kelas
cd kas_kelas
flutter pub add provider
git init
code .
```

Lalu, di panel **Explorer** VS Code:

1. **Hapus** berkas `test/widget_test.dart`. Berkas bawaan ini menguji aplikasi penghitung (*counter*). Setelah `main.dart` diganti, berkas itu tidak bisa dikompilasi dan membuat `flutter test` gagal.
2. Buat folder `testing/fakes/` di folder utama proyek, **sejajar** dengan `lib/` dan `test/`.

Susunan akhirnya:

```text
kas_kelas/
├── lib/
│   └── main.dart                          ← Langkah 2
├── testing/
│   └── fakes/
│       └── repositori_kas_palsu.dart      ← Langkah 3
└── test/
    ├── aturan_kas_test.dart               ← Langkah 4 (tes Praktikum 1)
    ├── kas_view_model_test.dart           ← Langkah 4 (tes Praktikum 2)
    └── halaman_kas_test.dart              ← Langkah 5 (tes widget)
```

| Folder | Isinya |
| :--- | :--- |
| `lib/` | Kode aplikasi. **Hanya** folder ini yang ikut masuk ke aplikasi yang dirilis |
| `test/` | Berkas tes. `flutter test` menjalankan semua berkas berakhiran `_test.dart` di sini |
| `testing/fakes/` | Data palsu yang dipakai **bersama** oleh banyak berkas tes. Susunan ini mengikuti panduan arsitektur resmi Flutter ([Modul Bagian 9.2](README.md#92-susunan-folder-tes)) |

### Langkah 2 — `lib/main.dart`

Ganti seluruh isi `lib/main.dart`. Bagian atasnya (ketik sendiri):

```dart
// =====================================================================
// KAS KELAS - Pertemuan 14, Praktikum 3 (BOLEH DISALIN SELURUHNYA)
// Satu berkas agar mudah disalin. Judul "BAGIAN" menandai lapisannya:
// aturan (Praktikum 1), Hasil dan repository, ViewModel (Praktikum 2),
// lalu tampilan. Di proyek besar, setiap bagian menjadi berkas sendiri.
// =====================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    Provider<RepositoriKas>(
      create: (BuildContext context) =>
          RepositoriKasMemori(isi: contohTransaksi),
      child: const AplikasiKas(),
    ),
  );
}
```

Di bawahnya, susun kode dari dua praktikum sebelumnya dengan urutan berikut:

1. **BAGIAN 1 — Aturan:** salin aturan dari Praktikum 1 (yang sudah diperbaiki), sama seperti di Praktikum 2.
2. **BAGIAN 2, 3, dan 4 — Hasil, *repository*, dan ViewModel:** salin dari `praktikum2_test.dart`, **kecuali** BAGIAN 5 (*repository* palsu) dan BAGIAN 6 (tes). Keduanya dipindahkan di Langkah 3 dan 4.
3. Di akhir BAGIAN 3, tepat setelah `contohTransaksi`, tambahkan *repository* untuk menjalankan aplikasi (ketik sendiri):

```dart
/// Repository di memori untuk menjalankan aplikasi tanpa server. Jedanya
/// meniru server yang butuh waktu untuk menjawab.
class RepositoriKasMemori implements RepositoriKas {
  RepositoriKasMemori({List<Transaksi> isi = const []}) : _isi = [...isi];

  final List<Transaksi> _isi;

  @override
  Future<Hasil<List<Transaksi>>> semua() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return Berhasil(List.of(_isi));
  }

  @override
  Future<Hasil<Transaksi>> simpan(Transaksi transaksi) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    _isi.add(transaksi);
    return Berhasil(transaksi);
  }
}
```

4. **BAGIAN 5 — Tampilan** (*boleh disalin*), di bagian paling bawah:

<details>
<summary>📋 Klik untuk melihat kode BAGIAN 5 — Tampilan</summary>

```dart
// ==================== BAGIAN 5: TAMPILAN (Praktikum 3) ====================

/// 2026-10-07 -> '7 Okt 2026'
String formatTanggal(DateTime tanggal) {
  const List<String> bulan = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];
  return '${tanggal.day} ${bulan[tanggal.month - 1]} ${tanggal.year}';
}

final ThemeData temaTerang = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
);

final ThemeData temaGelap = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.teal,
    brightness: Brightness.dark,
  ),
);

class AplikasiKas extends StatelessWidget {
  const AplikasiKas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kas Kelas',
      theme: temaTerang,
      darkTheme: temaGelap,
      home: const HalamanKas(),
    );
  }
}

class HalamanKas extends StatelessWidget {
  const HalamanKas({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          KasViewModel(repositori: context.read<RepositoriKas>())..muat(),
      child: const TampilanKas(),
    );
  }
}

class TampilanKas extends StatelessWidget {
  const TampilanKas({super.key});

  Future<void> _bukaFormulir(BuildContext context) async {
    final KasViewModel vm = context.read<KasViewModel>();
    final ScaffoldMessengerState pesan = ScaffoldMessenger.of(context);
    final int? jumlah = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) => ChangeNotifierProvider.value(
        value: vm,
        child: const LembarPengeluaran(),
      ),
    );
    vm.bersihkanPesanSimpan(); // pesan lama tidak muncul lagi
    if (jumlah == null) {
      return; // lembar ditutup tanpa menyimpan
    }
    pesan.showSnackBar(
      SnackBar(content: Text('Pengeluaran ${rupiah(jumlah)} tercatat.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final KasViewModel vm = context.watch<KasViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Kas Kelas')),
      body: switch (vm.status) {
        StatusMuat.memuat => const Center(child: CircularProgressIndicator()),
        StatusMuat.gagal => PesanGagal(
          pesan: vm.pesanGalat,
          onCobaLagi: vm.muat,
        ),
        StatusMuat.berhasil => const IsiKas(),
      },
      floatingActionButton: vm.status == StatusMuat.berhasil
          ? FloatingActionButton(
              tooltip: 'Catat pengeluaran',
              onPressed: () => _bukaFormulir(context),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class PesanGagal extends StatelessWidget {
  const PesanGagal({super.key, required this.pesan, required this.onCobaLagi});

  final String pesan;
  final VoidCallback onCobaLagi;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, size: 48),
            const SizedBox(height: 12),
            Text(pesan, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: onCobaLagi,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}

class IsiKas extends StatelessWidget {
  const IsiKas({super.key});

  @override
  Widget build(BuildContext context) {
    final KasViewModel vm = context.watch<KasViewModel>();
    if (vm.daftar.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Belum ada transaksi. Catat iuran pertama dulu.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
      children: [
        KartuSaldo(saldo: vm.saldo),
        const SizedBox(height: 8),
        // Transaksi terbaru di atas.
        for (final Transaksi transaksi in vm.daftar.reversed)
          BarisTransaksi(transaksi: transaksi),
      ],
    );
  }
}

class KartuSaldo extends StatelessWidget {
  const KartuSaldo({super.key, required this.saldo});

  final int saldo;

  @override
  Widget build(BuildContext context) {
    final TextTheme gaya = Theme.of(context).textTheme;
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Saldo kas', style: gaya.labelLarge),
            Text(rupiah(saldo), style: gaya.headlineMedium),
          ],
        ),
      ),
    );
  }
}

class BarisTransaksi extends StatelessWidget {
  const BarisTransaksi({super.key, required this.transaksi});

  final Transaksi transaksi;

  @override
  Widget build(BuildContext context) {
    final bool masuk = transaksi.jenis == JenisTransaksi.pemasukan;
    final ColorScheme warna = Theme.of(context).colorScheme;
    // Jumlah di baris judul, keterangan di bawahnya: keduanya boleh turun
    // baris, sehingga tetap terbaca di layar sempit dengan huruf besar.
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: Icon(masuk ? Icons.south_west : Icons.north_east),
      ),
      title: Text(
        '${masuk ? '+' : '-'}${rupiah(transaksi.jumlah)}',
        style: TextStyle(color: masuk ? warna.primary : warna.error),
      ),
      subtitle: Text(
        '${transaksi.keterangan} · ${formatTanggal(transaksi.tanggal)}',
      ),
    );
  }
}

class LembarPengeluaran extends StatefulWidget {
  const LembarPengeluaran({super.key});

  @override
  State<LembarPengeluaran> createState() => _LembarPengeluaranState();
}

class _LembarPengeluaranState extends State<LembarPengeluaran> {
  final TextEditingController _keperluan = TextEditingController();
  final TextEditingController _jumlah = TextEditingController();

  @override
  void dispose() {
    _keperluan.dispose();
    _jumlah.dispose();
    super.dispose();
  }

  Future<void> _simpan() async {
    final KasViewModel vm = context.read<KasViewModel>();
    final int jumlah = int.tryParse(_jumlah.text.trim()) ?? 0;
    final bool tersimpan = await vm.catatPengeluaran(
      jumlah: jumlah,
      keperluan: _keperluan.text,
    );
    if (!mounted) {
      return;
    }
    if (tersimpan) {
      Navigator.pop(context, jumlah);
    }
  }

  @override
  Widget build(BuildContext context) {
    final KasViewModel vm = context.watch<KasViewModel>();
    final String? pesan = vm.pesanSimpan;
    return Padding(
      // Memberi ruang untuk papan ketik.
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Catat pengeluaran',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('isian_keperluan'),
              controller: _keperluan,
              decoration: const InputDecoration(
                labelText: 'Keperluan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('isian_jumlah'),
              controller: _jumlah,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah (Rp)',
                border: OutlineInputBorder(),
              ),
            ),
            if (pesan != null) ...[
              const SizedBox(height: 12),
              Text(
                pesan,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: 12),
            FilledButton.icon(
              key: const Key('tombol_simpan'),
              // null = tombol mati selama menyimpan.
              onPressed: vm.menyimpan ? null : _simpan,
              icon: vm.menyimpan
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_outlined),
              label: Text(vm.menyimpan ? 'Menyimpan...' : 'Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
```

</details>

| Bagian | Penjelasan |
| :--- | :--- |
| `Provider<RepositoriKas>(create: ... RepositoriKasMemori(...))` | **Akar komposisi**: satu-satunya tempat yang memilih implementasi. Tes nanti mengganti baris ini dengan *repository* palsu |
| `RepositoriKasMemori` | Data di memori dengan jeda 0,5 detik, meniru server yang butuh waktu untuk menjawab. Datanya hilang saat aplikasi ditutup |
| `formatTanggal` | `DateTime(2026, 10, 7)` → `'7 Okt 2026'` |
| `FloatingActionButton(tooltip: 'Catat pengeluaran', ...)` | Tombol yang hanya berisi ikon **wajib** punya *tooltip*: teks itu dibacakan pembaca layar, dan tes bisa mencarinya dengan `find.byTooltip` |
| `BarisTransaksi` memakai `ListTile` | Jumlah di judul, keterangan di bawahnya. Keduanya boleh turun baris, sehingga tetap terbaca di layar sempit dengan huruf besar |
| `Key('isian_keperluan')`, `Key('isian_jumlah')`, `Key('tombol_simpan')` | "Nama panggilan" untuk tes: `find.byKey(...)` tetap menemukan widget yang tepat walaupun tulisannya berubah |
| `onPressed: vm.menyimpan ? null : _simpan` | `null` berarti tombol **mati** selama menyimpan |
| `final ScaffoldMessengerState pesan = ScaffoldMessenger.of(context);` | Diambil **sebelum** `await`, karena setelah lembar ditutup `context` bisa sudah tidak berlaku |

Jalankan aplikasinya dengan **F5** (pilih **Chrome**) atau `flutter run -d chrome`. Setelah setengah detik, tampil kartu **Saldo kas Rp30.000** dan empat transaksi, yang terbaru di atas. Coba ketuk tombol **+**, lalu catat pengeluaran **"Kopi"** sebesar **5000**: pesan `Tuliskan keperluan minimal 5 huruf.` muncul di lembar formulir.

### Langkah 3 — *Repository* palsu dipindahkan ke `testing/fakes/`

Buat berkas `testing/fakes/repositori_kas_palsu.dart`. Bagian atasnya (ketik sendiri):

```dart
import 'dart:async';

import 'package:kas_kelas/main.dart';

/// Repository PALSU untuk tes: tanpa jeda, bisa pura-pura gagal, mencatat
/// berapa kali dipanggil, dan bisa ditahan. Dipindahkan dari Praktikum 2.
```

Di bawahnya, **salin** kelas `RepositoriKasPalsu` dari BAGIAN 5 Praktikum 2, tanpa diubah sedikit pun.

| Bagian | Penjelasan |
| :--- | :--- |
| `import 'package:kas_kelas/main.dart';` | Berkas di luar `lib/` mengimpor kode aplikasi lewat **nama paket**, yaitu nama proyek di `pubspec.yaml` |
| `import 'dart:async';` | Untuk `Completer` |

### Langkah 4 — Tes Praktikum 1 dan 2 pindah ke `test/`

Buat berkas `test/aturan_kas_test.dart`. Isinya hanya dua baris impor:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:kas_kelas/main.dart';
```

lalu **salin** `void main() { ... }` beserta seluruh tes dari Praktikum 1 di bawahnya.

Buat juga `test/kas_view_model_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:kas_kelas/main.dart';

import '../testing/fakes/repositori_kas_palsu.dart';
```

lalu **salin** `void main() { ... }` beserta seluruh tes dari Praktikum 2 di bawahnya.

| Bagian | Penjelasan |
| :--- | :--- |
| `import 'package:kas_kelas/main.dart';` | Aturan dan ViewModel kini diambil dari `lib/`. Kode yang diuji **sama persis** dengan yang dipakai aplikasi |
| `import '../testing/fakes/repositori_kas_palsu.dart';` | Alamat **relatif**: dari folder `test/`, naik satu folder (`..`), lalu masuk ke `testing/fakes/` |

Jalankan semua tes dari terminal:

```bash
flutter test
```

✅ **Hasil yang diharapkan** (angka waktu di depan bisa berbeda):

```text
00:02 +33: All tests passed!
```

Tiga puluh tiga tes: 21 dari Praktikum 1 dan 12 dari Praktikum 2. Tidak ada satu pun yang perlu diubah, karena kodenya memang sama.

### Langkah 5 — Tes widget (ketik sendiri)

Buat berkas `test/halaman_kas_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kas_kelas/main.dart';
import 'package:provider/provider.dart';

import '../testing/fakes/repositori_kas_palsu.dart';

/// Memasang aplikasi ASLI, tetapi dengan repository palsu.
Future<void> pasangAplikasi(
  WidgetTester tester,
  RepositoriKasPalsu repositori,
) async {
  await tester.pumpWidget(
    Provider<RepositoriKas>.value(
      value: repositori,
      child: const AplikasiKas(),
    ),
  );
}

/// Membuka lembar "Catat pengeluaran" lewat tombol +.
Future<void> bukaFormulir(WidgetTester tester) async {
  await tester.tap(find.byTooltip('Catat pengeluaran'));
  await tester.pumpAndSettle(); // tunggu animasi lembar selesai
}

/// Mengisi formulir, lalu mengetuk Simpan. Hanya SATU bingkai digambar,
/// sehingga keadaan "sedang menyimpan" masih bisa diperiksa.
Future<void> isiDanSimpan(
  WidgetTester tester, {
  required String keperluan,
  required String jumlah,
}) async {
  await tester.enterText(find.byKey(const Key('isian_keperluan')), keperluan);
  await tester.enterText(find.byKey(const Key('isian_jumlah')), jumlah);
  await tester.tap(find.byKey(const Key('tombol_simpan')));
  await tester.pump();
}

void main() {
  late RepositoriKasPalsu repositori;

  setUp(() {
    repositori = RepositoriKasPalsu(isi: contohTransaksi);
  });

  testWidgets('memuat, lalu menampilkan saldo dan transaksi', (
    WidgetTester tester,
  ) async {
    repositori.tahan = true; // "server" belum menjawab

    await pasangAplikasi(tester, repositori);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byTooltip('Catat pengeluaran'), findsNothing);
    // Jangan pumpAndSettle() di sini: lingkaran memuat terus berputar.

    repositori.lepaskan();
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Rp30.000'), findsOneWidget);
    expect(find.text('-Rp8.000'), findsOneWidget);
    expect(find.text('Fotokopi modul · 13 Okt 2026'), findsOneWidget);
    expect(find.byTooltip('Catat pengeluaran'), findsOneWidget);
  });

  testWidgets('kas kosong menampilkan ajakan', (WidgetTester tester) async {
    await pasangAplikasi(tester, RepositoriKasPalsu());
    await tester.pumpAndSettle();

    expect(
      find.text('Belum ada transaksi. Catat iuran pertama dulu.'),
      findsOneWidget,
    );
  });

  testWidgets('gagal memuat: pesan dan tombol Coba lagi yang berfungsi', (
    WidgetTester tester,
  ) async {
    repositori.gagalSaatMemuat = const TanpaKoneksi();

    await pasangAplikasi(tester, repositori);
    await tester.pumpAndSettle();

    expect(
      find.text('Tidak dapat terhubung. Periksa koneksi internet Anda.'),
      findsOneWidget,
    );
    expect(find.byTooltip('Catat pengeluaran'), findsNothing);

    repositori.gagalSaatMemuat = null; // koneksi kembali
    await tester.tap(find.text('Coba lagi'));
    await tester.pumpAndSettle();

    expect(find.text('Rp30.000'), findsOneWidget);
    expect(repositori.jumlahMemuat, 2);
  });

  testWidgets('melebihi saldo: alasan tampil dan tidak disimpan', (
    WidgetTester tester,
  ) async {
    await pasangAplikasi(tester, repositori);
    await tester.pumpAndSettle();
    await bukaFormulir(tester);

    await isiDanSimpan(tester, keperluan: 'Kaos kelas', jumlah: '50000');

    expect(
      find.text('Saldo tidak cukup. Saldo saat ini Rp30.000.'),
      findsOneWidget,
    );
    expect(repositori.jumlahMenyimpan, 0);
  });

  testWidgets('tombol Simpan mati selama menyimpan, lalu SnackBar tampil', (
    WidgetTester tester,
  ) async {
    await pasangAplikasi(tester, repositori);
    await tester.pumpAndSettle();
    await bukaFormulir(tester);

    repositori.tahan = true;
    await isiDanSimpan(tester, keperluan: 'Kertas HVS', jumlah: '10000');

    final Finder tombol = find.byKey(const Key('tombol_simpan'));
    expect(tester.widget<ButtonStyleButton>(tombol).enabled, isFalse);
    expect(find.text('Menyimpan...'), findsOneWidget);

    // Ketukan kedua pada tombol yang mati tidak berbuat apa-apa.
    await tester.tap(tombol, warnIfMissed: false);
    await tester.pump();
    expect(repositori.jumlahMenyimpan, 1);

    repositori
      ..tahan = false
      ..lepaskan();
    await tester.pumpAndSettle();

    expect(find.text('Pengeluaran Rp10.000 tercatat.'), findsOneWidget);
    expect(find.text('Rp20.000'), findsOneWidget); // saldo baru
    expect(find.byType(LembarPengeluaran), findsNothing); // lembar tertutup
  });

  testWidgets('layar 320 piksel dengan huruf 200% tidak meluap', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1.0;
    tester.platformDispatcher.textScaleFactorTestValue = 2.0;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await pasangAplikasi(tester, repositori);
    await tester.pumpAndSettle();
    await bukaFormulir(tester);
    await isiDanSimpan(tester, keperluan: 'Kopi', jumlah: '5000');

    // Jika ada yang meluap (overflow), Flutter melaporkan galat dan tes ini
    // otomatis GAGAL. Jadi, cukup periksa bahwa layarnya benar.
    expect(find.text('Tuliskan keperluan minimal 5 huruf.'), findsOneWidget);
  });

  testWidgets('memenuhi pedoman aksesibilitas', (WidgetTester tester) async {
    final SemanticsHandle pegangan = tester.ensureSemantics();

    await pasangAplikasi(tester, repositori);
    await tester.pumpAndSettle();

    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    pegangan.dispose();
  });
}
```

| Bagian | Penjelasan |
| :--- | :--- |
| `testWidgets('...', (WidgetTester tester) async { ... })` | Tes widget. `tester` adalah "robot" yang memasang widget, mengetuk, mengetik, dan menggambar bingkai ([Modul Bagian 6.2](README.md#62-testwidgets-dan-widgettester)) |
| `pasangAplikasi` | Memasang aplikasi **asli** (`AplikasiKas`) di atas *repository* **palsu**: semua widget sungguhan, datanya terkendali ([Modul Bagian 7.1](README.md#71-memasang-aplikasi-asli-dengan-data-palsu)) |
| `repositori.tahan = true` | "Server" belum menjawab, sehingga lingkaran memuat bisa diperiksa. Setelah `lepaskan()`, `pumpAndSettle()` menunggu sampai semua animasi selesai |
| Jangan `pumpAndSettle()` saat lingkaran memuat berputar | Animasinya tidak pernah berhenti, sehingga `pumpAndSettle()` menunggu sampai batas waktunya habis ([Modul Bagian 6.5](README.md#65-pump-pumpdurasi-dan-pumpandsettle)) |
| `find.text`, `find.byTooltip`, `find.byKey`, `find.byType` | *Finder*: cara mencari widget di layar ([Modul Bagian 6.3](README.md#63-finder-mencari-widget-di-layar)) |
| `isiDanSimpan` diakhiri `pump()` | Hanya **satu** bingkai digambar setelah tombol diketuk, sehingga keadaan "sedang menyimpan" masih terlihat |
| `tester.widget<ButtonStyleButton>(tombol).enabled` | `FilledButton.icon` adalah turunan `ButtonStyleButton`, jadi status hidup-matinya bisa dibaca dari situ ([Modul Bagian 7.3](README.md#73-tombol-mati-selama-mengirim)) |
| `tap(tombol, warnIfMissed: false)` | Tombol yang mati tidak menerima ketukan. Tanpa `warnIfMissed: false`, `flutter_test` mencetak peringatan |
| `physicalSize`, `devicePixelRatio`, `textScaleFactorTestValue` | Layar **320 piksel** dengan huruf **200%**. `addTearDown(...)` mengembalikannya seusai tes, agar tes lain tidak ikut terpengaruh ([Modul Bagian 7.5](README.md#75-layar-sempit-dan-huruf-besar)) |
| Tes 320 piksel tanpa `expect` khusus untuk *overflow* | Jika ada widget yang meluap, Flutter melaporkan galat dan tesnya otomatis **gagal** |
| `meetsGuideline(...)` | Target sentuh minimal 48 × 48, semua tombol berlabel, dan kontras teks cukup ([Modul Bagian 7.7](README.md#77-pedoman-aksesibilitas)) |

### Langkah 6 — Jalankan semua tes

```bash
flutter test
```

✅ **Hasil yang diharapkan:**

```text
00:05 +40: All tests passed!
```

Empat puluh tes: 21 aturan, 12 ViewModel, dan 7 tes widget. Coba juga panel **Testing** di VS Code: setiap berkas, grup, dan tes tampil sebagai pohon bercentang hijau.

Terakhir, simpan keadaan ini. Praktikum 4 membutuhkannya:

```bash
git add .
git commit -m "Kas Kelas: aplikasi dan 40 tes"
```

🔧 **Modifikasi:**

1. **Eksperimen — `pumpAndSettle` yang tidak pernah selesai.** Di tes `'memuat, lalu menampilkan saldo dan transaksi'`, tambahkan sementara `await tester.pumpAndSettle();` tepat setelah `await pasangAplikasi(tester, repositori);`. Apa pesannya? Jawab sebagai komentar: mengapa? Kembalikan.
2. **Eksperimen — satu bingkai yang hilang.** Di fungsi `isiDanSimpan`, hapus sementara baris `await tester.pump();`. Tes mana saja yang merah? Jawab sebagai komentar: mengapa tes-tes itu, dan bukan yang lain? Kembalikan.
3. **Tes baru — urutan transaksi.** Tambahkan tes yang memastikan transaksi **terbaru** tampil paling atas: `'-Rp8.000'` (13 Oktober) harus berada **di atas** `'-Rp12.000'` (7 Oktober). Petunjuk: `tester.getTopLeft(find.text('-Rp8.000')).dy` adalah jarak teks itu dari tepi atas layar.
4. **Tes baru — mode gelap.** Seperti [Modul Bagian 7.6](README.md#76-mode-gelap), tambahkan tes yang memastikan kartu saldo memakai tema **gelap** saat `platformBrightnessTestValue` bernilai `Brightness.dark`.
5. **Eksperimen — label yang hilang.** Hapus sementara `tooltip: 'Catat pengeluaran'` dari `FloatingActionButton`, lalu jalankan semua tes widget. Berapa tes yang merah? Salin pesan dari tes aksesibilitas sebagai komentar, lalu kembalikan.

---

## Praktikum 4 — Kiriman Raka: Empat Bug, Satu per Satu

**Konsep:** tes regresi, membaca banyak tes merah sekaligus, *stack trace*, *breakpoint* dan panel *Variables*, galat tata letak, bug yang **tidak** tertangkap tes, serta `git diff`. ([Modul Bagian 10](README.md#10-debugging-1-membaca-pesan-galat), [Bagian 11](README.md#11-debugging-2-debugger-vs-code), dan [Bagian 13](README.md#13-galat-tata-letak-yang-paling-sering))

Raka, teman sekelompok Anda, menambahkan tiga hal ke Kas Kelas:

- **saringan** Semua / Pemasukan / Pengeluaran di atas daftar transaksi;
- baris **pengeluaran terbesar** di bawah kartu saldo;
- **kartu saldo yang lebih ringkas**: label di kiri, angka di kanan.

"Sudah saya coba di HP saya, aman kok," katanya. Tesnya tidak ia jalankan. Tugas Anda: memasang kirimannya, menemukan setiap bug, memperbaikinya, lalu **mengunci** setiap bug dengan tes agar tidak kembali.

### Langkah 1 — Pastikan titik aman sudah tersimpan

Di terminal proyek `kas_kelas`:

```bash
git status
```

Jika masih ada perubahan yang belum di-*commit*, simpan dulu dengan `git add .` dan `git commit -m "..."` seperti di akhir Praktikum 3. Dengan titik aman ini, Anda selalu bisa melihat **apa saja** yang diubah Raka dengan `git diff`, dan kembali ke versi yang benar jika tersesat.

### Langkah 2 — Pasang kiriman Raka (boleh disalin)

Lakukan **empat** perubahan berikut di `lib/main.dart`.

> [!WARNING]
> Salin **persis** seperti tertulis, walaupun Anda mencurigai ada yang salah. Justru itu latihannya: menemukan bug dengan bantuan alat, bukan dengan menebak.

**(a)** Di BAGIAN 1, ganti seluruh fungsi `hitungSaldo` dengan:

```dart
/// Pemasukan menambah saldo, pengeluaran mengurangi.
int hitungSaldo(List<Transaksi> daftar) {
  // Diringkas dengan fold agar lebih pendek.
  return daftar.fold(0, (int total, Transaksi t) => total + t.jumlah);
}
```

**(b)** Di BAGIAN 4, tambahkan `enum` ini tepat di bawah `enum StatusMuat { ... }`:

```dart
enum FilterJenis {
  semua('Semua'),
  pemasukan('Pemasukan'),
  pengeluaran('Pengeluaran');

  const FilterJenis(this.label);

  final String label;
}
```

Lalu, di dalam `KasViewModel`, tambahkan satu *field* di bawah `bool _sudahDibuang = false;`:

```dart
  FilterJenis _filter = FilterJenis.semua;
```

dan tambahkan ini di bawah *getter* `int get saldo => hitungSaldo(_daftar);`:

```dart
  FilterJenis get filter => _filter;

  /// Transaksi sesuai saringan yang dipilih.
  List<Transaksi> get daftarTersaring {
    return switch (_filter) {
      FilterJenis.semua => daftar,
      FilterJenis.pemasukan =>
        daftar
            .where((Transaksi t) => t.jenis == JenisTransaksi.pemasukan)
            .toList(),
      FilterJenis.pengeluaran =>
        daftar
            .where((Transaksi t) => t.jenis == JenisTransaksi.pengeluaran)
            .toList(),
    };
  }

  /// Pengeluaran dengan jumlah paling besar.
  Transaksi get pengeluaranTerbesar {
    return _daftar
        .where((Transaksi t) => t.jenis == JenisTransaksi.pengeluaran)
        .reduce((Transaksi a, Transaksi b) => a.jumlah >= b.jumlah ? a : b);
  }

  void pilihFilter(FilterJenis baru) {
    _filter = baru;
  }
```

**(c)** Di BAGIAN 5, ganti seluruh metode `build` milik `IsiKas` dengan:

```dart
  @override
  Widget build(BuildContext context) {
    final KasViewModel vm = context.watch<KasViewModel>();
    final Transaksi terbesar = vm.pengeluaranTerbesar;
    if (vm.daftar.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Belum ada transaksi. Catat iuran pertama dulu.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
      children: [
        KartuSaldo(saldo: vm.saldo),
        const SizedBox(height: 8),
        Text(
          'Pengeluaran terbesar: ${terbesar.keterangan} '
          '(${rupiah(terbesar.jumlah)})',
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            for (final FilterJenis pilihan in FilterJenis.values)
              ChoiceChip(
                label: Text(pilihan.label),
                selected: vm.filter == pilihan,
                onSelected: (bool _) => vm.pilihFilter(pilihan),
              ),
          ],
        ),
        // Transaksi terbaru di atas.
        for (final Transaksi transaksi in vm.daftarTersaring.reversed)
          BarisTransaksi(transaksi: transaksi),
      ],
    );
  }
```

**(d)** Masih di BAGIAN 5, di dalam `KartuSaldo`, ganti bagian `child: Column(...)` milik `Padding` dengan:

```dart
        // Label di kiri, angka di kanan: lebih ringkas.
        child: Row(
          children: [
            Text('Saldo kas', style: gaya.labelLarge),
            const Spacer(),
            Text(rupiah(saldo), style: gaya.headlineMedium),
          ],
        ),
```

Lihat semua perubahannya sekaligus:

```bash
git diff
```

Baris yang diawali `-` (merah) dihapus, baris yang diawali `+` (hijau) ditambahkan. Inilah yang dilihat seorang peninjau kode (*code reviewer*) sebelum menyetujui kiriman teman.

### Langkah 3 — Jalankan semua tes

```bash
flutter test
```

Hasilnya merah di mana-mana:

```text
00:06 +28 -12: Some tests failed.
```

Dua belas tes gagal. Jangan panik dan **jangan** langsung mengubah kode. Gulir ke atas, lalu kelompokkan pesan-pesannya:

| Kelompok pesan | Contoh | Tes yang terkena |
| :--- | :--- | :--- |
| Angka saldo salah | `Expected: <13000>` `Actual: <37000>`, atau `Found 0 widgets with text "Rp30.000"` | Banyak: aturan, ViewModel, dan widget |
| Galat saat membangun widget | `Bad state: No element` | `kas kosong menampilkan ajakan` |
| Widget meluap | `A RenderFlex overflowed by ... pixels on the right.` | `layar 320 piksel dengan huruf 200% tidak meluap` |

> [!TIP]
> **Mulailah dari tes yang paling kecil.** Satu bug di fungsi aturan bisa membuat puluhan tes ViewModel dan widget ikut merah, karena semuanya memakai fungsi yang sama. Perbaiki penyebab di lapisan terdalam dulu, jalankan ulang, lalu lihat berapa yang masih merah.

### Langkah 4 — Bug A: angka saldo

Jalankan berkas tes aturan saja:

```bash
flutter test test/aturan_kas_test.dart
```

```text
00:00 +12: Transaksi dan saldo pemasukan menambah, pengeluaran mengurangi [E]
  Expected: <13000>
    Actual: <37000>
```

Tes ini memakai dua transaksi: pemasukan 25.000 dan pengeluaran 12.000. Yang diharapkan 25.000 − 12.000 = 13.000. Yang dihasilkan 37.000 = 25.000 **+** 12.000. Artinya: pengeluaran ikut **ditambahkan**.

Pastikan dugaan itu dengan *debugger* ([Modul Bagian 11.6](README.md#116-debugger-untuk-tes)):

1. Klik di sebelah kiri nomor baris `return daftar.fold(...)` di `hitungSaldo` sampai muncul titik merah (*breakpoint*).
2. Di `test/aturan_kas_test.dart`, klik tulisan kecil **Debug** di atas tes `'pemasukan menambah, pengeluaran mengurangi'`.
3. Saat eksekusi berhenti, buka panel **Variables**, lalu buka `daftar`: kedua transaksi ada di sana, dengan `jenis` yang berbeda.
4. Di **Debug Console**, ketik `daftar[1].jenis` lalu tekan `Enter`. Hasilnya `JenisTransaksi.pengeluaran`, tetapi baris `return` di atas menjumlahkan `t.jumlah` tanpa pernah melihat `t.jenis`.

Perbaiki `hitungSaldo` sendiri. Jika buntu:

<details>
<summary>🔑 Perbaikan bug A (buka setelah Anda mencoba)</summary>

```dart
int hitungSaldo(List<Transaksi> daftar) {
  // PERBAIKAN A: pengeluaran MENGURANGI saldo.
  int saldo = 0;
  for (final Transaksi t in daftar) {
    saldo += t.jenis == JenisTransaksi.pemasukan ? t.jumlah : -t.jumlah;
  }
  return saldo;
}
```

</details>

Jalankan ulang **semua** tes:

```text
00:06 +38 -2: Some tests failed.
```

Satu perbaikan, sepuluh tes kembali hijau.

### Langkah 5 — Bug C: `Bad state: No element`

Lihat tes `kas kosong menampilkan ajakan`. Di atas laporan kegagalannya ada pesan galat dari Flutter:

```text
══╡ EXCEPTION CAUGHT BY WIDGETS LIBRARY ╞═══════════════════════════
The following StateError was thrown building IsiKas(dirty, dependencies:
[_InheritedProviderScope<KasViewModel?>]):
Bad state: No element

When the exception was thrown, this was the stack:
#0      Iterable.reduce (dart:core/iterable.dart:...)
#1      KasViewModel.pengeluaranTerbesar (package:kas_kelas/main.dart:...)
#2      IsiKas.build (package:kas_kelas/main.dart:...)
#3      StatelessElement.build (package:flutter/src/widgets/framework.dart:...)
...
```

Baca *stack trace* dari atas, dan berhenti di baris **pertama** yang menyebut `package:kas_kelas/`, yaitu kode Anda sendiri ([Modul Bagian 10.5](README.md#105-membaca-stack-trace)):

| Baris | Artinya |
| :--- | :--- |
| `#0 Iterable.reduce` | Galatnya dilempar oleh `reduce`, milik Dart. Bukan di sini yang salah |
| `#1 KasViewModel.pengeluaranTerbesar` | **Di sini.** `pengeluaranTerbesar` memanggil `reduce` |
| `#2 IsiKas.build` | ...yang dipanggil saat `IsiKas` dibangun |

`reduce` menggabungkan anggota daftar **berpasangan**. Daftar kosong tidak punya anggota pertama, sehingga `reduce` melempar `StateError` dengan pesan `No element`. Saat kas masih kosong, daftar pengeluarannya juga kosong.

> [!IMPORTANT]
> Memindahkan baris `final Transaksi terbesar = vm.pengeluaranTerbesar;` ke bawah pemeriksaan `vm.daftar.isEmpty` **belum** menyelesaikan masalah. Bagaimana jika kas sudah berisi transaksi, tetapi **semuanya** pemasukan? Itu keadaan yang wajar di minggu pertama.

Perbaikan yang menyelesaikan kedua keadaan: `pengeluaranTerbesar` boleh bernilai `null`, dan tampilannya hanya menulis baris itu jika nilainya ada.

<details>
<summary>🔑 Perbaikan bug C (buka setelah Anda mencoba)</summary>

Di `KasViewModel`:

```dart
  /// Pengeluaran dengan jumlah paling besar, atau null jika belum ada
  /// pengeluaran sama sekali.
  Transaksi? get pengeluaranTerbesar {
    // PERBAIKAN C: reduce() pada daftar kosong melempar StateError.
    final Iterable<Transaksi> pengeluaran = _daftar.where(
      (Transaksi t) => t.jenis == JenisTransaksi.pengeluaran,
    );
    if (pengeluaran.isEmpty) {
      return null;
    }
    return pengeluaran.reduce(
      (Transaksi a, Transaksi b) => a.jumlah >= b.jumlah ? a : b,
    );
  }
```

Di `IsiKas`, baris pertama `build` menjadi `final Transaksi? terbesar = vm.pengeluaranTerbesar;`, dan tulisan pengeluaran terbesar hanya dibangun jika ada:

```dart
        if (terbesar != null)
          Text(
            'Pengeluaran terbesar: ${terbesar.keterangan} '
            '(${rupiah(terbesar.jumlah)})',
          ),
```

</details>

### Langkah 6 — Bug D: kartu saldo meluap

Tes yang masih merah tinggal satu. Pesannya:

```text
══╡ EXCEPTION CAUGHT BY RENDERING LIBRARY ╞═════════════════════════
The following assertion was thrown during layout:
A RenderFlex overflowed by ... pixels on the right.

The relevant error-causing widget was:
  Row Row:file:///.../kas_kelas/lib/main.dart:...
```

Di HP Raka yang lebar, label dan angka saldo muat berdampingan. Di layar **320 piksel** dengan huruf **200%**, teks `Saldo kas` dan `Rp30.000` (huruf besar) jauh lebih lebar daripada layarnya. `Spacer` tidak bisa menolong, karena ruang kosongnya sudah habis bahkan sebelum `Spacer` mendapat bagian ([Modul Bagian 13.2](README.md#132-kasus-1-teks-panjang-di-dalam-row)).

Coba dulu membungkus `Text('Saldo kas', ...)` dengan `Expanded`, lalu jalankan tes 320 piksel itu saja:

```bash
flutter test test/halaman_kas_test.dart --plain-name "320"
```

Masih merah, walaupun angka *overflow*-nya mengecil. Teks angka saldo **sendirian** sudah lebih lebar daripada layar, dan teks itu tidak boleh menyusut. Untuk layar sempit dengan huruf besar, susunan **ke bawah** lebih aman daripada berdampingan.

<details>
<summary>🔑 Perbaikan bug D (buka setelah Anda mencoba)</summary>

```dart
        // PERBAIKAN D: disusun ke bawah. Di layar 320 piksel dengan huruf
        // 200%, label dan angka tidak muat berdampingan.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Saldo kas', style: gaya.labelLarge),
            Text(rupiah(saldo), style: gaya.headlineMedium),
          ],
        ),
```

</details>

Jalankan semua tes. Semuanya hijau:

```text
00:06 +40: All tests passed!
```

### Langkah 7 — Bug B: lolos dari semua tes

Semua tes hijau, tetapi apakah fitur Raka sudah benar? Jalankan aplikasinya dengan **F5** (Chrome), lalu ketuk chip **Pengeluaran**. Tidak terjadi apa-apa: chipnya tidak terpilih, dan daftar tidak tersaring. Tes tidak menangkap bug ini karena **belum ada tes** untuk fitur saringan.

Cari penyebabnya dengan *debugger* ([Modul Bagian 11.2](README.md#112-breakpoint-pertama)):

1. Pasang *breakpoint* di baris `_filter = baru;` dalam `pilihFilter`.
2. Ketuk chip **Pengeluaran** di Chrome. Eksekusi berhenti di *breakpoint*: `pilihFilter` **memang** dipanggil.
3. Di panel **Variables**, lihat `baru` (bernilai `FilterJenis.pengeluaran`). Tekan **F10** (*step over*), lalu lihat `this` → `_filter`: nilainya **sudah** berubah.
4. Tekan **F5** untuk melanjutkan. Layar tetap tidak berubah.

Data di ViewModel berubah, tetapi tidak ada yang **memberi tahu** layar. Bandingkan `pilihFilter` dengan `bersihkanPesanSimpan`: apa yang tidak ada?

<details>
<summary>🔑 Perbaikan bug B (buka setelah Anda mencoba)</summary>

```dart
  void pilihFilter(FilterJenis baru) {
    _filter = baru;
    _kabari(); // PERBAIKAN B: tanpa ini, layar tidak dibangun ulang
  }
```

</details>

### Langkah 8 — Kunci dengan tes regresi (ketik sendiri)

Bug B lolos karena tidak ada tes, dan perbaikan bug C bisa saja dihapus orang lain suatu hari nanti. Tambahkan tes **regresi** agar keduanya tidak pernah kembali.

Di `test/kas_view_model_test.dart`, di dalam `main()`, tepat **sebelum** tes `'ViewModel yang dibuang saat memuat tidak memberi kabar lagi'`:

```dart
  // ---------- Tes regresi Praktikum 4 ----------
  group('saringan dan pengeluaran terbesar', () {
    setUp(() async {
      await vm.muat();
    });

    test('pilihFilter memberi kabar dan menyaring', () {
      int kabar = 0;
      vm.addListener(() => kabar++);

      vm.pilihFilter(FilterJenis.pengeluaran);

      expect(kabar, 1); // bug B: 0
      expect(vm.daftarTersaring.map((Transaksi t) => t.keterangan), [
        'Spidol papan tulis',
        'Fotokopi modul',
      ]);
    });

    test('pengeluaran terbesar: spidol Rp12.000', () {
      expect(vm.pengeluaranTerbesar?.keterangan, 'Spidol papan tulis');
    });
  });

  test('belum ada pengeluaran: pengeluaranTerbesar null', () async {
    // bug C: StateError (Bad state: No element)
    final KasViewModel lain = KasViewModel(
      repositori: RepositoriKasPalsu(isi: [contohTransaksi.first]),
    );
    await lain.muat();

    expect(lain.pengeluaranTerbesar, isNull);
    lain.dispose();
  });
```

Di `test/halaman_kas_test.dart`, di dalam `main()`, tepat **sebelum** tes `'memenuhi pedoman aksesibilitas'`:

```dart
  // ---------- Tes regresi Praktikum 4 ----------
  testWidgets('saringan Pengeluaran hanya menampilkan pengeluaran', (
    WidgetTester tester,
  ) async {
    await pasangAplikasi(tester, repositori);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Pengeluaran'));
    await tester.pumpAndSettle();

    expect(find.text('-Rp12.000'), findsOneWidget);
    expect(find.text('+Rp25.000'), findsNothing); // bug B: masih tampil
  });

  testWidgets('hanya pemasukan: tanpa baris pengeluaran terbesar', (
    WidgetTester tester,
  ) async {
    await pasangAplikasi(
      tester,
      RepositoriKasPalsu(isi: [contohTransaksi.first]),
    );
    await tester.pumpAndSettle();

    expect(find.text('Rp25.000'), findsOneWidget);
    expect(find.textContaining('Pengeluaran terbesar'), findsNothing);
  });
```

Buktikan bahwa tes regresi itu benar-benar menjaga: hapus **sementara** perbaikan bug B (`_kabari();` di `pilihFilter`), jalankan semua tes, dan pastikan tepat **dua** tes menjadi merah. Kembalikan perbaikannya.

### Langkah 9 — Catatan *debugging*, lalu simpan

Buat berkas `CATATAN_DEBUGGING.md` di folder utama proyek, lalu isi tabel ini dengan kata-kata Anda sendiri:

```markdown
| Bug | Gejala | Cara menemukan | Penyebab | Perbaikan | Tes yang menjaga |
| --- | --- | --- | --- | --- | --- |
| A | ... | ... | ... | ... | ... |
| B | ... | ... | ... | ... | ... |
| C | ... | ... | ... | ... | ... |
| D | ... | ... | ... | ... | ... |
```

Jalankan semua tes sekali lagi.

✅ **Hasil yang diharapkan:**

```text
00:07 +45: All tests passed!
```

Empat puluh lima tes: 40 lama dan 5 tes regresi. Simpan dengan pesan yang menjelaskan isinya:

```bash
git add .
git commit -m "Perbaiki 4 bug fitur saringan + tes regresi"
```

🔧 **Modifikasi:**

1. ***Logpoint*.** Ganti *breakpoint* di `pilihFilter` dengan *logpoint* (klik kanan di sebelah kiri nomor baris → **Add Logpoint**) berisi `Saringan: {baru}` ([Modul Bagian 11.5](README.md#115-gejala-3-logpoint)). Ketuk ketiga chip bergantian, lalu salin isi **Debug Console** sebagai komentar. Jawab: apa kelebihan *logpoint* dibanding menambah `print()` ke dalam kode?
2. ***Breakpoint* bersyarat.** Pasang *breakpoint* di dalam perulangan `hitungSaldo` dengan syarat `t.jumlah > 20000` ([Modul Bagian 11.4](README.md#114-gejala-2-breakpoint-bersyarat)), lalu jalankan aplikasinya. Berapa kali eksekusi berhenti saat aplikasi pertama kali dibuka? Jelaskan sebagai komentar mengapa jumlahnya sebanyak itu.
3. **Widget Inspector.** Jalankan aplikasi, buka DevTools → **Flutter Inspector** ([Modul Bagian 12.2](README.md#122-flutter-inspector)), aktifkan **Select Widget Mode**, lalu klik angka saldo di Chrome. Tuliskan sebagai komentar **tiga** widget leluhur terdekatnya di pohon widget.
4. **Eksperimen — versi Raka di layar Anda.** Di Chrome, buka DevTools browser (`F12`), aktifkan **Toggle device toolbar**, pilih lebar **320**, lalu kembalikan sementara kartu saldo versi Raka. Apakah pita kuning-hitam muncul di lebar 320 dengan ukuran huruf normal? Jawab sebagai komentar: mengapa tes memakai huruf **200%**, bukan huruf normal saja? Kembalikan perbaikannya.
5. **Pertanyaan.** Jawab sebagai komentar di `CATATAN_DEBUGGING.md`: tes apa yang **seharusnya** ditulis Raka bersama fiturnya? Jika tim Anda punya pemeriksaan otomatis di GitHub (Praktikum 5), di tahap mana kiriman Raka akan tertahan?

---

## Praktikum 5 — "Tugas Kuliahku" Punya Tes Sendiri

**Konsep:** tes di proyek berlapis, folder `test/` yang mencerminkan `lib/`, membuka `Hasil` di dalam tes, menguji `Perintah`, tabel kasus, data palsu bersama di `testing/fakes/`, tes halaman dengan penyedia khusus tes, cakupan kode, dan GitHub Actions. ([Modul Bagian 9](README.md#9-studi-kasus-menguji-pinjam-ruang-kampus), [Bagian 14](README.md#14-melangkah-lebih-jauh-cakupan-ci-dan-jenis-tes-lain), dan [Bagian 16](README.md#16-pengujian-untuk-proyek-akhir))

Sejak Pertemuan 9, "Tugas Kuliahku" diperiksa dengan tangan: jalankan, klik, lihat. Hari ini proyek itu mendapat tes otomatis, **tanpa mengubah satu baris pun** di folder `lib/`.

### Langkah 1 — Simpan keadaan sekarang, lalu lihat petanya

Buka proyek `tugas_kuliahku` di VS Code. Simpan dulu keadaannya:

```bash
git add .
git commit -m "Tugas Kuliahku: sebelum ditambah tes"
```

Jika masih ada berkas `test/widget_test.dart` bawaan `flutter create`, **hapus**. Isinya menguji aplikasi penghitung yang sudah lama tidak ada.

Peta berkas yang akan dibuat:

```text
tugas_kuliahku/
├── lib/                                          ← TIDAK diubah
├── testing/
│   └── fakes/
│       └── repositori_tugas_palsu.dart           ← Langkah 4
├── test/
│   ├── data/
│   │   └── repositories/
│   │       └── repositori_tugas_lokal_test.dart  ← Langkah 2
│   └── ui/
│       ├── core/
│       │   ├── perintah_test.dart                ← Langkah 3
│       │   └── pemuatan_test.dart                ← Langkah 3
│       └── daftar_tugas/
│           └── halaman_tugas_test.dart           ← Langkah 5
└── .github/
    └── workflows/
        └── tes.yml                               ← Langkah 7
```

Perhatikan bahwa susunan `test/` **mencerminkan** `lib/`: tes untuk `lib/ui/core/perintah.dart` ada di `test/ui/core/perintah_test.dart`. Dengan begitu, tes sebuah berkas selalu mudah ditemukan ([Modul Bagian 9.2](README.md#92-susunan-folder-tes)).

### Langkah 2 — Tes `RepositoriTugasLokal` (ketik sendiri)

`RepositoriTugasLokal` adalah data di memori yang dipakai `main_pengembangan.dart`. Inilah *repository* paling sederhana di proyek ini, jadi kita mulai dari sini. Buat berkas `test/data/repositories/repositori_tugas_lokal_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_kuliahku/data/repositories/repositori_tugas_lokal.dart';
import 'package:tugas_kuliahku/domain/hasil.dart';
import 'package:tugas_kuliahku/domain/models/tugas.dart';

/// Membuka Hasil yang DIHARAPKAN berhasil. Jika ternyata gagal, tes
/// langsung gagal dengan pesan yang jelas.
T nilaiDari<T>(Hasil<T> hasil) {
  return switch (hasil) {
    Berhasil(:final T nilai) => nilai,
    Gagal(:final Kegagalan kegagalan) => fail(
      'Diharapkan berhasil, ternyata gagal: $kegagalan',
    ),
  };
}

/// Daftar id semua tugas, berurutan.
Future<List<int>> idSemua(RepositoriTugasLokal repositori) async {
  final List<Tugas> semua = nilaiDari(await repositori.ambilSemua());
  return semua.map((Tugas t) => t.id).toList();
}

void main() {
  late RepositoriTugasLokal repositori;

  setUp(() {
    repositori = RepositoriTugasLokal();
  });

  test('mula-mula berisi 4 tugas contoh yang belum selesai', () async {
    final List<Tugas> semua = nilaiDari(await repositori.ambilSemua());

    expect(semua, hasLength(4));
    expect(semua.first.judul, 'Laporan praktikum MVVM');
    expect(semua.every((Tugas t) => !t.selesai), isTrue);
  });

  test('tambah memberi id 5 dan tugas ikut tersimpan', () async {
    final Tugas baru = nilaiDari(
      await repositori.tambah(
        judul: 'Poster seminar',
        mataKuliah: 'Desain Grafis',
        prioritas: Prioritas.rendah,
      ),
    );

    expect(baru.id, 5);
    expect(await idSemua(repositori), [1, 2, 3, 4, 5]);
  });

  test('ubahSelesai hanya mengubah tugas yang dituju', () async {
    await repositori.ubahSelesai(2, true);

    final List<Tugas> semua = nilaiDari(await repositori.ambilSemua());
    final List<int> selesai = [
      for (final Tugas t in semua)
        if (t.selesai) t.id,
    ];
    expect(selesai, [2]);
  });

  test('hapus lalu pulihkan: urutan kembali seperti semula', () async {
    final Tugas kedua = nilaiDari(await repositori.ambilSemua())[1];

    await repositori.hapus(kedua.id);
    expect(await idSemua(repositori), [1, 3, 4]);

    await repositori.pulihkan(kedua);
    expect(await idSemua(repositori), [1, 2, 3, 4]);
  });

  test('impor pertama menambah 2 tugas, impor kedua tidak menambah', () async {
    expect(nilaiDari(await repositori.imporDariServer()), 2);
    expect(nilaiDari(await repositori.imporDariServer()), 0);

    expect(await idSemua(repositori), [1, 2, 3, 4, 5, 6]);
  });
}
```

| Bagian | Penjelasan |
| :--- | :--- |
| `T nilaiDari<T>(Hasil<T> hasil)` | **Pembuka `Hasil`** khusus tes. Jika hasilnya `Gagal`, `fail(...)` langsung menggagalkan tes dengan pesan yang jelas, alih-alih galat yang membingungkan di baris berikutnya |
| `fail(...)` | Menggagalkan tes saat itu juga. Tipe kembaliannya `Never`, sehingga boleh dipakai di cabang `switch` mana pun |
| `idSemua(...)` | Fungsi bantu: daftar id semua tugas. Membandingkan `[1, 3, 4]` jauh lebih mudah dibaca daripada membandingkan empat objek `Tugas` |
| `[for (...) if (t.selesai) t.id]` | *Collection for* dan *collection if* ([Pertemuan 4](../pertemuan_04_widget_dan_layout/README.md#52-mainaxisalignment-posisi-di-sepanjang-sumbu-utama) dan [Pertemuan 5](../pertemuan_05_interaksi_dan_state/README.md#55-nilai-turunan-ringkasan-dari-semua-pilihan)): daftar id tugas yang sudah selesai |
| Tes impor | Impor dijalankan **dua kali**: yang pertama menambah 2 tugas, yang kedua 0, karena tugas yang sama tidak boleh masuk dua kali |

Jalankan:

```bash
flutter test test/data
```

✅ **Hasil yang diharapkan:**

```text
00:04 +5: All tests passed!
```

Tesnya butuh beberapa detik, karena `RepositoriTugasLokal` sengaja punya jeda: 0,3 detik untuk membaca dan 1 detik untuk mengimpor. Ingat hal ini; Langkah 4 membahasnya.

### Langkah 3 — Tes `Perintah` dan pesan kegagalan (ketik sendiri)

`Perintah` dari Pertemuan 12 punya dua janji penting: ketukan ganda diabaikan, dan tombol tidak pernah terkunci walaupun aksinya melempar *exception*. Kini kedua janji itu dibuktikan. Buat berkas `test/ui/core/perintah_test.dart`:

```dart
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_kuliahku/domain/hasil.dart';
import 'package:tugas_kuliahku/ui/core/perintah.dart';

void main() {
  test('berhasil: hasil tersimpan dan perintah selesai berjalan', () async {
    final Perintah0<int> perintah = Perintah0<int>(
      () async => const Berhasil(7),
    );

    await perintah.jalankan();

    expect(perintah.sedangBerjalan, isFalse);
    expect(perintah.berhasil, isTrue);
    expect(
      perintah.hasil,
      isA<Berhasil<int>>().having((Berhasil<int> h) => h.nilai, 'nilai', 7),
    );
  });

  test('gagal: kegagalan tersimpan di dalam hasil', () async {
    final Perintah0<int> perintah = Perintah0<int>(
      () async => const Gagal(TanpaKoneksi()),
    );

    await perintah.jalankan();

    expect(perintah.gagal, isTrue);
    expect(
      perintah.hasil,
      isA<Gagal<int>>().having(
        (Gagal<int> h) => h.kegagalan,
        'kegagalan',
        isA<TanpaKoneksi>(),
      ),
    );
  });

  test('penjaga: selama berjalan, panggilan kedua diabaikan', () async {
    final Completer<Hasil<int>> server = Completer<Hasil<int>>();
    int jumlahAksi = 0;
    final Perintah0<int> perintah = Perintah0<int>(() {
      jumlahAksi++;
      return server.future; // "server" belum menjawab
    });

    final Future<void> pertama = perintah.jalankan(); // sengaja tanpa await
    expect(perintah.sedangBerjalan, isTrue);
    await perintah.jalankan(); // ketukan kedua: langsung diabaikan

    server.complete(const Berhasil(1)); // "server" menjawab
    await pertama;

    expect(jumlahAksi, 1);
    expect(perintah.sedangBerjalan, isFalse);
  });

  test('finally: aksi yang melempar exception tidak mengunci', () async {
    final Perintah0<int> perintah = Perintah0<int>(
      () async => throw StateError('rusak'),
    );

    await expectLater(perintah.jalankan(), throwsStateError);

    expect(perintah.sedangBerjalan, isFalse); // tombol tidak terkunci
  });

  test('bersihkanHasil mengosongkan hasil dan memberi kabar', () async {
    final Perintah1<int, int> kaliDua = Perintah1<int, int>(
      (int angka) async => Berhasil(angka * 2),
    );
    int kabar = 0;
    kaliDua.addListener(() => kabar++);

    await kaliDua.jalankan(21);
    expect(kaliDua.hasil, isA<Berhasil<int>>());

    kaliDua.bersihkanHasil();

    expect(kaliDua.hasil, isNull);
    expect(kabar, 3); // mulai, selesai, dibersihkan
  });
}
```

| Bagian | Penjelasan |
| :--- | :--- |
| `isA<Berhasil<int>>().having((Berhasil<int> h) => h.nilai, 'nilai', 7)` | Dua pemeriksaan sekaligus: tipenya `Berhasil<int>`, **dan** nilainya 7 ([Modul Bagian 3.1](README.md#31-matcher-cara-memeriksa-yang-lebih-kaya)) |
| `Completer<Hasil<int>> server` | "Server" yang belum menjawab, sehingga perintah masih **berjalan** saat ketukan kedua datang |
| `await perintah.jalankan();` yang kedua | Langsung selesai tanpa menjalankan aksi, karena penjaga `if (_sedangBerjalan) return;` |
| `expectLater(perintah.jalankan(), throwsStateError)` | *Exception* dari aksi tetap diteruskan ke pemanggil. Yang penting, setelahnya `sedangBerjalan` kembali `false` berkat `finally` |
| `expect(kabar, 3)` | Mulai berjalan, selesai berjalan, dan dibersihkan: tiga kabar |

Lalu buat berkas `test/ui/core/pemuatan_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_kuliahku/domain/hasil.dart';
import 'package:tugas_kuliahku/ui/core/pemuatan.dart';

void main() {
  // Tabel kasus: kegagalan -> kalimat yang diharapkan.
  const Map<Kegagalan, String> kasus = {
    TanpaKoneksi(): 'Tidak dapat terhubung. Periksa koneksi internet Anda.',
    WaktuHabis(): 'Server terlalu lama menjawab. Coba lagi.',
    ServerBermasalah(503):
        'Server sedang bermasalah (kode 503). Coba lagi nanti.',
    DataRusak(): 'Data dari server tidak bisa dibaca.',
    PenyimpananGagal(): 'Data di perangkat gagal dibaca atau disimpan.',
  };

  kasus.forEach((Kegagalan kegagalan, String harapan) {
    test('${kegagalan.runtimeType} menjadi kalimat yang ramah', () {
      expect(pesanKegagalan(kegagalan), harapan);
    });
  });
}
```

| Bagian | Penjelasan |
| :--- | :--- |
| `const Map<Kegagalan, String> kasus` | Tabel kasus seperti `rupiah()` di Praktikum 1: kuncinya kegagalan, nilainya kalimat yang diharapkan |
| `kasus.forEach(...)` | Setiap baris tabel menjadi satu tes |
| `'${kegagalan.runtimeType} ...'` | Nama tes memuat nama jenis kegagalannya, misalnya `TanpaKoneksi menjadi kalimat yang ramah` |

> [!NOTE]
> Mengerjakan **Modifikasi 3** di Pertemuan 12? `pesanKegagalan` Anda juga mengenal `AturanDilanggar`. Tambahkan satu baris ke tabelnya: `AturanDilanggar('Judul kembar.'): 'Judul kembar.',`

### Langkah 4 — Data palsu khusus tes (boleh disalin)

Mengapa tidak memakai `RepositoriTugasLokal` saja di tes halaman? Karena ia punya **jeda waktu**, tidak bisa **disuruh gagal**, dan tidak **mencatat** apa pun. Tes yang baik membutuhkan data palsu yang cepat dan bisa dikendalikan, seperti `RepositoriKasPalsu` di Praktikum 2. Buat berkas `testing/fakes/repositori_tugas_palsu.dart`:

```dart
import 'package:tugas_kuliahku/domain/hasil.dart';
import 'package:tugas_kuliahku/domain/models/tugas.dart';
import 'package:tugas_kuliahku/domain/repositories/repositori_tugas.dart';

/// Empat tugas contoh, sama dengan RepositoriTugasLokal.
const List<Tugas> contohTugas = [
  Tugas(
    id: 1,
    judul: 'Laporan praktikum MVVM',
    mataKuliah: 'Piranti Bergerak',
    prioritas: Prioritas.tinggi,
  ),
  Tugas(
    id: 2,
    judul: 'Rancangan ERD perpustakaan',
    mataKuliah: 'Basis Data',
    prioritas: Prioritas.sedang,
  ),
  Tugas(
    id: 3,
    judul: 'Ringkasan bab 4',
    mataKuliah: 'Etika Profesi',
    prioritas: Prioritas.rendah,
  ),
  Tugas(
    id: 4,
    judul: 'Kuis algoritma graf',
    mataKuliah: 'Struktur Data',
    prioritas: Prioritas.tinggi,
  ),
];

/// Repository PALSU khusus tes. Bedanya dengan RepositoriTugasLokal:
/// tanpa jeda waktu, bisa disuruh gagal, dan mencatat berapa kali
/// dipanggil.
class RepositoriTugasPalsu implements RepositoriTugas {
  RepositoriTugasPalsu({List<Tugas> isi = contohTugas}) : _isi = [...isi];

  final List<Tugas> _isi;

  // "Remote control": diisi tes agar repository pura-pura gagal.
  Kegagalan? gagalSaatMuat;
  Kegagalan? gagalSaatImpor;

  // Mata-mata (spy): berapa kali repository dihubungi.
  int jumlahMuat = 0;
  int jumlahImpor = 0;

  // id terbesar yang sudah dipakai.
  int get _idTerakhir {
    int terbesar = 0;
    for (final Tugas t in _isi) {
      if (t.id > terbesar) {
        terbesar = t.id;
      }
    }
    return terbesar;
  }

  @override
  Future<Hasil<List<Tugas>>> ambilSemua() async {
    jumlahMuat++;
    final Kegagalan? kegagalan = gagalSaatMuat;
    if (kegagalan != null) {
      return Gagal(kegagalan);
    }
    return Berhasil(List.of(_isi));
  }

  @override
  Future<Hasil<Tugas>> tambah({
    required String judul,
    required String mataKuliah,
    required Prioritas prioritas,
  }) async {
    final Tugas baru = Tugas(
      id: _idTerakhir + 1,
      judul: judul,
      mataKuliah: mataKuliah,
      prioritas: prioritas,
    );
    _isi.add(baru);
    return Berhasil(baru);
  }

  @override
  Future<Hasil<void>> ubahSelesai(int id, bool selesai) async {
    final int posisi = _isi.indexWhere((Tugas t) => t.id == id);
    if (posisi >= 0) {
      _isi[posisi] = _isi[posisi].copyWith(selesai: selesai);
    }
    return const Berhasil(null);
  }

  @override
  Future<Hasil<void>> hapus(int id) async {
    _isi.removeWhere((Tugas t) => t.id == id);
    return const Berhasil(null);
  }

  @override
  Future<Hasil<void>> pulihkan(Tugas tugas) async {
    _isi.add(tugas);
    _isi.sort((Tugas a, Tugas b) => a.id.compareTo(b.id));
    return const Berhasil(null);
  }

  /// Impor palsu: dua tugas pada impor pertama, nol pada impor berikutnya.
  @override
  Future<Hasil<int>> imporDariServer() async {
    jumlahImpor++;
    final Kegagalan? kegagalan = gagalSaatImpor;
    if (kegagalan != null) {
      return Gagal(kegagalan);
    }
    if (_isi.any((Tugas t) => t.idServer != null)) {
      return const Berhasil(0); // sudah pernah diimpor
    }
    final int id = _idTerakhir;
    _isi.addAll([
      Tugas(
        id: id + 1,
        judul: 'Membaca jurnal arsitektur aplikasi',
        mataKuliah: 'Umum',
        prioritas: Prioritas.sedang,
        idServer: 901,
      ),
      Tugas(
        id: id + 2,
        judul: 'Menyiapkan demo laporan kemajuan',
        mataKuliah: 'Umum',
        prioritas: Prioritas.sedang,
        idServer: 902,
      ),
    ]);
    return const Berhasil(2);
  }
}
```

| Bagian | Penjelasan |
| :--- | :--- |
| `const List<Tugas> contohTugas` | Empat tugas yang **sama** dengan `RepositoriTugasLokal`, sehingga yang tampil di tes sama dengan yang Anda lihat di aplikasi |
| `implements RepositoriTugas` | Analyzer memastikan semua perintah kontrak tersedia |
| `gagalSaatMuat`, `gagalSaatImpor` | *Remote control*: membuat *repository* pura-pura gagal |
| `jumlahMuat`, `jumlahImpor` | Mata-mata: berapa kali dipanggil |
| Tanpa `Future.delayed` | Jawaban langsung datang, sehingga tes widget tidak perlu menunggu jam palsu maju ([Modul Bagian 9.5](README.md#95-menepati-janji-tombol-ajukan-mati-selama-menyimpan)) |

### Langkah 5 — Tes halaman (ketik sendiri)

Buat berkas `test/ui/daftar_tugas/halaman_tugas_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:tugas_kuliahku/domain/hasil.dart';
import 'package:tugas_kuliahku/domain/repositories/repositori_tugas.dart';
import 'package:tugas_kuliahku/ui/core/aplikasi.dart';
import 'package:tugas_kuliahku/ui/daftar_tugas/view_models/daftar_tugas_view_model.dart';

import '../../../testing/fakes/repositori_tugas_palsu.dart';

// SESUAIKAN dengan buatPenyedia() di lib/config/dependensi.dart: salin
// bagian yang "sama untuk kedua lingkungan". Bedanya hanya satu:
// repository-nya diterima dari tes, bukan dibuat di sini.
List<SingleChildWidget> penyediaUji(RepositoriTugas repositori) {
  return [
    Provider<RepositoriTugas>.value(value: repositori),
    ChangeNotifierProvider<DaftarTugasViewModel>(
      create: (BuildContext context) =>
          DaftarTugasViewModel(repositori: context.read<RepositoriTugas>())
            ..muat(),
    ),
  ];
}

/// Memasang aplikasi ASLI dengan repository palsu, lalu menunggu sampai
/// daftar selesai dimuat.
Future<void> pasangAplikasi(
  WidgetTester tester,
  RepositoriTugasPalsu repositori,
) async {
  await tester.pumpWidget(
    MultiProvider(
      providers: penyediaUji(repositori),
      child: const AplikasiTugas(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  late RepositoriTugasPalsu repositori;

  setUp(() {
    repositori = RepositoriTugasPalsu();
  });

  testWidgets('menampilkan 4 tugas contoh', (WidgetTester tester) async {
    await pasangAplikasi(tester, repositori);

    expect(find.text('4 tugas belum selesai'), findsOneWidget);
    expect(find.byType(CheckboxListTile), findsNWidgets(4));
    expect(find.text('Piranti Bergerak · Tinggi'), findsOneWidget);
  });

  testWidgets('mencentang tugas mengurangi hitungan', (
    WidgetTester tester,
  ) async {
    await pasangAplikasi(tester, repositori);

    await tester.tap(find.text('Ringkasan bab 4'));
    await tester.pumpAndSettle();

    expect(find.text('3 tugas belum selesai'), findsOneWidget);
    final CheckboxListTile baris = tester.widget(
      find.widgetWithText(CheckboxListTile, 'Ringkasan bab 4'),
    );
    expect(baris.value, isTrue);
  });

  testWidgets('saringan Tinggi hanya menampilkan prioritas tinggi', (
    WidgetTester tester,
  ) async {
    await pasangAplikasi(tester, repositori);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Tinggi'));
    await tester.pumpAndSettle();

    expect(find.byType(CheckboxListTile), findsNWidgets(2));
    expect(find.text('Ringkasan bab 4'), findsNothing);
  });

  testWidgets('pencarian tanpa hasil menampilkan pesan', (
    WidgetTester tester,
  ) async {
    await pasangAplikasi(tester, repositori);

    await tester.enterText(find.byType(SearchBar), 'skripsi');
    await tester.pumpAndSettle();

    expect(find.text('Tidak ada tugas yang cocok.'), findsOneWidget);
  });

  testWidgets('menambah tugas lewat formulir', (WidgetTester tester) async {
    await pasangAplikasi(tester, repositori);

    await tester.tap(find.text('Tambah tugas'));
    await tester.pumpAndSettle(); // tunggu halaman formulir terbuka
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Judul tugas'),
      'Poster seminar',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Mata kuliah'),
      'Desain Grafis',
    );
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle(); // tunggu kembali ke daftar

    expect(find.text('Tugas ditambahkan.'), findsOneWidget);
    expect(find.text('5 tugas belum selesai'), findsOneWidget);
    expect(find.text('Poster seminar'), findsOneWidget);
  });

  testWidgets('impor dari server mengumumkan 2 tugas baru', (
    WidgetTester tester,
  ) async {
    await pasangAplikasi(tester, repositori);

    await tester.tap(find.byTooltip('Impor dari server'));
    await tester.pumpAndSettle();

    expect(find.text('2 tugas baru diimpor dari server.'), findsOneWidget);
    expect(find.text('6 tugas belum selesai'), findsOneWidget);
    expect(repositori.jumlahImpor, 1);
  });

  testWidgets('gagal memuat: pesan ramah dan tombol Coba lagi', (
    WidgetTester tester,
  ) async {
    repositori.gagalSaatMuat = const PenyimpananGagal();

    await pasangAplikasi(tester, repositori);

    expect(
      find.text('Data di perangkat gagal dibaca atau disimpan.'),
      findsOneWidget,
    );

    repositori.gagalSaatMuat = null; // database kembali normal
    await tester.tap(find.text('Coba lagi'));
    await tester.pumpAndSettle();

    expect(find.text('4 tugas belum selesai'), findsOneWidget);
  });

  testWidgets('geser untuk menghapus, lalu Urungkan', (
    WidgetTester tester,
  ) async {
    await pasangAplikasi(tester, repositori);

    await tester.drag(find.text('Ringkasan bab 4'), const Offset(-600, 0));
    await tester.pumpAndSettle();

    expect(find.text('Ringkasan bab 4'), findsNothing);
    expect(find.text('Tugas "Ringkasan bab 4" dihapus.'), findsOneWidget);

    await tester.tap(find.text('Urungkan'));
    await tester.pumpAndSettle();

    expect(find.text('Ringkasan bab 4'), findsOneWidget);
    expect(find.text('4 tugas belum selesai'), findsOneWidget);
  });
}
```

| Bagian | Penjelasan |
| :--- | :--- |
| `penyediaUji(repositori)` | **Penyedia khusus tes**: sama dengan bagian bawah `buatPenyedia()` di `lib/config/dependensi.dart`, tetapi `RepositoriTugas` diganti data palsu lewat `Provider<RepositoriTugas>.value(...)` |
| `const AplikasiTugas()` | Aplikasi **asli** yang sama dengan yang dijalankan `main.dart` dan `main_pengembangan.dart` |
| `await tester.pumpAndSettle();` di `pasangAplikasi` | Menunggu daftar selesai dimuat dan semua animasi berhenti |
| `find.widgetWithText(ChoiceChip, 'Tinggi')` | Chip **Tinggi**, bukan tulisan "Tinggi" di baris tugas (`Piranti Bergerak · Tinggi` adalah teks lain) |
| `tester.enterText(find.byType(SearchBar), 'skripsi')` | `enterText` mencari kolom ketik **di dalam** `SearchBar` dengan sendirinya |
| `find.widgetWithText(TextFormField, 'Judul tugas')` | Kolom ketik yang berlabel **Judul tugas** |
| `tester.drag(find.text('Ringkasan bab 4'), const Offset(-600, 0))` | Menggeser baris 600 piksel ke **kiri**, seperti jari yang menggeser untuk menghapus |
| `find.text('Urungkan')` | Tombol di dalam `SnackBar`. Setelah diketuk, tugasnya kembali |

> [!IMPORTANT]
> **SESUAIKAN `penyediaUji` dengan proyek Anda.** Bentuk di atas cocok untuk `buatPenyedia()` versi Pertemuan 12 tanpa modifikasi. Jika Anda mengerjakan **Modifikasi 3** (*use case* `TambahTugas`) dan/atau **Modifikasi 4** (`muat` sebagai `Perintah`) di Pertemuan 12, aturannya sederhana: **salin** bagian bawah `buatPenyedia()` Anda apa adanya, lalu ganti hanya penyedia `RepositoriTugas`-nya menjadi `Provider<RepositoriTugas>.value(value: repositori)`.

<details>
<summary>Contoh <code>penyediaUji</code> untuk proyek dengan Modifikasi 3 dan 4</summary>

```dart
List<SingleChildWidget> penyediaUji(RepositoriTugas repositori) {
  return [
    Provider<RepositoriTugas>.value(value: repositori),
    Provider<TambahTugas>(
      create: (BuildContext context) =>
          TambahTugas(repositori: context.read<RepositoriTugas>()),
    ),
    ChangeNotifierProvider<DaftarTugasViewModel>(
      create: (BuildContext context) => DaftarTugasViewModel(
        repositori: context.read<RepositoriTugas>(),
        tambahTugas: context.read<TambahTugas>(),
      ),
    ),
  ];
}
```

Tambahkan juga impor `package:tugas_kuliahku/domain/use_cases/tambah_tugas.dart` di bagian atas berkas tes. Kedelapan tes di atas tetap berlaku tanpa diubah, karena teks dan tombol di layar memang sama.

</details>

### Langkah 6 — Jalankan semua tes, lalu ukur cakupannya

```bash
flutter test
```

✅ **Hasil yang diharapkan:**

```text
00:08 +23: All tests passed!
```

Dua puluh tiga tes: 5 *repository*, 5 `Perintah`, 5 pesan kegagalan, dan 8 halaman.

Sekarang lihat **bagian mana yang belum disentuh** tes ([Modul Bagian 14.1](README.md#141-cakupan-kode-coverage)):

```bash
flutter test --coverage
```

Perintah ini membuat berkas `coverage/lcov.info`. Cara termudah membacanya: di panel **Testing** VS Code, klik **Run Tests with Coverage**. Setiap berkas di `lib/` mendapat persentase, dan baris yang tidak pernah dijalankan tes ditandai merah. Folder `coverage/` adalah hasil buatan alat, jadi tambahkan baris berikut ke `.gitignore`:

```text
coverage/
```

Perhatikan berkas `repositori_tugas_luring.dart`: cakupannya 0%, karena belum ada satu tes pun yang menyentuh database dan server sungguhan. Cakupan bukan target angka, melainkan **peta** bagian yang belum diuji.

### Langkah 7 — Tes otomatis di GitHub (ketik sendiri)

Buat berkas `.github/workflows/tes.yml` di folder utama proyek ([Modul Bagian 14.2](README.md#142-tes-otomatis-di-github-ci)):

```yaml
name: Tes Otomatis

on:
  push:
    branches: [main]
  pull_request:

jobs:
  tes:
    runs-on: ubuntu-latest
    steps:
      - name: Ambil isi repositori
        uses: actions/checkout@v5

      - name: Pasang Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: stable
          cache: true

      - name: Unduh paket
        run: flutter pub get

      - name: Analisis kode
        run: flutter analyze

      - name: Jalankan semua tes
        run: flutter test
```

Jika proyek ini belum punya repositori di GitHub, buat dulu repositori **kosong** bernama `tugas_kuliahku` di <https://github.com/new>, lalu hubungkan dari terminal (ganti `AKUN` dengan nama akun GitHub Anda):

```bash
git remote add origin https://github.com/AKUN/tugas_kuliahku.git
git branch -M main
```

Kirim semuanya:

```bash
git add .
git commit -m "Tes otomatis untuk Tugas Kuliahku"
git push -u origin main
```

Buka tab **Actions** di halaman repositori. Setelah satu sampai tiga menit, *commit* Anda diberi tanda ✅. Klik tandanya untuk melihat setiap langkah: memasang Flutter, mengunduh paket, menganalisis kode, dan menjalankan 23 tes.

> [!TIP]
> Jika langkah **Analisis kode** merah, jalankan `flutter analyze` di laptop dan perbaiki semua temuannya. `flutter analyze` menganggap peringatan, bahkan sekadar *info*, sebagai kegagalan, sehingga kode yang "masih bisa jalan" pun bisa membuat tanda ❌.

🔧 **Modifikasi:**

1. **Layar sempit.** Tambahkan dua tes di `halaman_tugas_test.dart`: daftar tugas dan halaman **Tambah Tugas**, keduanya di layar **320 piksel** dengan huruf **200%** ([Praktikum 3](#praktikum-3--proyek-kas-kelas-tampilan-dan-tes-widget)). Apakah ada yang meluap? Jawab sebagai komentar.
2. **Tes ViewModel tanpa layar.** Buat `test/ui/daftar_tugas/daftar_tugas_view_model_test.dart` dengan `RepositoriTugasPalsu`, berisi minimal empat tes: (a) memuat menghasilkan 4 tugas dan `jumlahBelumSelesai` 4; (b) `cari('KUIS')` tidak membedakan huruf besar-kecil; (c) `pilihSaringan(Prioritas.tinggi)` digabung dengan `cari('laporan')` menyisakan satu tugas; (d) impor yang dijalankan dua kali tanpa ditunggu hanya memanggil *repository* **sekali** (`jumlahImpor`). Jika Anda mengerjakan Modifikasi 4 di Pertemuan 12, `muat()` kini berupa `muat.jalankan()`, dan *constructor* ViewModel sudah mulai memuat sendiri.
3. **Aturan judul kembar (jika mengerjakan Modifikasi 3 di Pertemuan 12).** Buat `test/domain/models/aturan_tugas_test.dart` untuk `periksaTugasBaru`: judul unik boleh; judul kembar ditolak walaupun berbeda huruf besar-kecil dan berspasi di ujung; judul yang sama dengan tugas yang **sudah selesai** boleh; daftar kosong boleh. Tambahkan juga dua tes `TambahTugas` dengan `RepositoriTugasPalsu`: judul kembar menghasilkan `Gagal(AturanDilanggar(...))` dan daftar tidak bertambah; judul unik berhasil.
4. **Eksperimen — CI yang merah.** Ubah sementara teks `'... tugas belum selesai'` di `IsiDaftarTugas` menjadi `'... tugas tersisa'`, lalu *commit* dan *push*. Tunggu tanda ❌ di tab **Actions**, buka laporannya, lalu salin nama tes yang gagal sebagai komentar. Kembalikan teksnya dan *push* lagi sampai ✅.
5. **Tantangan — `RepositoriTugasLuring` dengan database sungguhan.** Uji impor dan penyimpanan `RepositoriTugasLuring` memakai SQLite **di memori** dan server palsu. Petunjuk: pasang `flutter pub add dev:sqflite_common_ffi`; di awal `main()` tes panggil `sqfliteFfiInit()` lalu `databaseFactory = databaseFactoryFfi;`; buat `LayananBasisData(namaBerkas: inMemoryDatabasePath)` dan `LayananDummyJson(klien: MockClient(...))` seperti Pertemuan 10; tutup database di `tearDown`. Uji minimal: impor pertama 2 tugas, impor kedua 0, dan server yang menjawab 500 menghasilkan `ServerBermasalah(500)` tanpa mengubah database. Di GitHub Actions (Linux), tambahkan langkah `sudo apt-get install -y libsqlite3-dev` sebelum `flutter test`.

---

## 🏆 Tugas Mandiri — Pinjam Alat Lab: Aplikasi yang Datang Bersama Tesnya

Laboratorium komputer meminjamkan alat kepada mahasiswa: kamera, *tripod*, proyektor, mikrofon, dan *router* cadangan. Selama ini peminjaman dicatat di buku besar, dan setiap akhir semester selalu ada alat yang "hilang dari catatan". Buat aplikasi **"Pinjam Alat Lab"** di proyek Flutter baru bernama `pinjam_alat`, dengan ketentuan berikut:

1. **Aturan dalam Dart murni**, di bagian aturan `lib/main.dart`:
   - nama peminjam minimal **3 huruf** setelah spasi di ujung dibuang;
   - satu peminjam paling banyak meminjam **3 alat** sekaligus;
   - lama pinjam **1 sampai 7 hari**;
   - alat yang sedang dipinjam orang lain tidak bisa dipinjam;
   - denda keterlambatan **Rp2.000 per hari**, paling banyak **Rp50.000** per peminjaman;
   - setiap aturan berbentuk fungsi yang mengembalikan **alasan penolakan** atau `null`, kecuali denda yang mengembalikan angka.
2. **Struktur** seperti Praktikum 3: judul `BAGIAN` untuk aturan, `Hasil` dan `Kegagalan`, *repository*, ViewModel, dan tampilan. Kontrak `RepositoriPeminjaman` punya implementasi di memori (dengan jeda, untuk menjalankan aplikasi) dan implementasi **palsu** di `testing/fakes/` (tanpa jeda, bisa disuruh gagal, mencatat jumlah panggilan, dan bisa ditahan).
3. **ViewModel** dengan status memuat–berhasil–gagal, aturan diperiksa **sebelum** menghubungi *repository*, penjaga ketukan ganda, penjaga `dispose`, dan jam yang bisa diganti untuk menghitung keterlambatan.
4. **Tampilan:** daftar alat beserta statusnya (tersedia atau dipinjam siapa, sampai kapan), lembar formulir peminjaman dengan alasan penolakan yang jelas, tombol **Simpan** yang mati selama menyimpan, dan pengembalian alat yang menampilkan dendanya. Lengkap dengan `theme` dan `darkTheme`.
5. **Tes** di folder `test/`, minimal:
   - **12 tes unit** untuk aturan, termasuk semua **nilai batas** (2 dan 3 huruf, 3 dan 4 alat, 0/1/7/8 hari, denda tepat di batas Rp50.000 dan sehari sesudahnya);
   - **5 tes ViewModel** dengan *repository* palsu: memuat berhasil, gagal, aturan ditolak tanpa menghubungi *repository*, ketukan ganda, dan denda dengan jam palsu;
   - **5 tes widget**: memuat lalu menampilkan daftar, gagal dan **Coba lagi**, alasan penolakan di formulir, tombol mati selama menyimpan, serta layar 320 piksel dengan huruf 200%;
   - **1 tes aksesibilitas** dengan `meetsGuideline`.
6. **Cakupan dan otomatisasi.** Jalankan `flutter test --coverage`, lalu catat persentase cakupan `lib/main.dart` dari VS Code. Tambahkan `.github/workflows/tes.yml` seperti Praktikum 5.
7. **Catatan *debugging*.** Di `CATATAN_DEBUGGING.md`, ceritakan minimal **satu** bug yang benar-benar Anda temui saat mengerjakan tugas ini: gejalanya, alat yang dipakai untuk menemukannya (tes, pesan galat, *stack trace*, *breakpoint*, atau Inspector), penyebab, perbaikan, dan tes regresi yang menjaganya.
8. **Kerapian.** Kode diformat, memakai `const` di tempat yang memungkinkan, `flutter analyze` diakhiri `No issues found!`, dan semua tes hijau.

Contoh rancangan (susunan dan isinya boleh dikreasikan):

```text
┌─────────────────────────────────────┐    ┌─────────────────────────────────────┐
│ Pinjam Alat Lab                     │    │ Pinjam alat                         │
├─────────────────────────────────────┤    │                                     │
│ 3 dari 5 alat tersedia              │    │ Nama peminjam                       │
│                                     │    │ [ Rina                           ]  │
│ 📷 Kamera mirrorless                │    │ Alat                                │
│    Dipinjam Dimas s.d. 18 Okt       │    │ [x] Tripod  [ ] Mikrofon            │
│ 🎥 Tripod                 Tersedia  │    │ Lama pinjam: 3 hari  [ - ] [ + ]    │
│ 📽 Proyektor              Tersedia  │    │                                     │
│ 🎤 Mikrofon               Tersedia  │    │ Lama pinjam paling lama 7 hari.     │
│ 📡 Router cadangan                  │    │                                     │
│    Terlambat 2 hari · denda Rp4.000 │    │ [          Simpan          ]        │
│                               [ + ] │    │                                     │
└─────────────────────────────────────┘    └─────────────────────────────────────┘
```

> [!TIP]
> - Kerjakan **bertahap**, dan selalu dengan tes: aturan + tes unit → ViewModel + data palsu + tes → tampilan + tes widget.
> - Tulis tes nilai batas **sebelum** aturannya, lalu lihat merah dulu seperti Praktikum 1.
> - Mulai dari salinan proyek `kas_kelas`, lalu ganti isinya bagian demi bagian. Polanya sama persis.
> - Acuan: [Praktikum 2](#praktikum-2--viewmodel-kas-dengan-repository-palsu) (data palsu dan tes ViewModel), [Praktikum 3](#praktikum-3--proyek-kas-kelas-tampilan-dan-tes-widget) (tes widget), dan [Modul Bagian 16](README.md#16-pengujian-untuk-proyek-akhir).

---

## 📤 Pengumpulan

Kumpulkan melalui tempat yang ditentukan dosen:

1. Berkas `praktikum1_test.dart` dan `praktikum2_test.dart` yang **sudah berisi modifikasi**, termasuk jawaban berupa komentar.
2. Folder `lib/`, `test/`, dan `testing/` proyek `kas_kelas` (Praktikum 3 dan 4, sudah dengan modifikasi) beserta `CATATAN_DEBUGGING.md`, dikompres menjadi `praktikum3_4.zip`.
3. Tautan repositori GitHub `tugas_kuliahku` (Praktikum 5) yang tab **Actions**-nya bertanda ✅.
4. Folder `lib/`, `test/`, `testing/`, `.github/`, serta `CATATAN_DEBUGGING.md` proyek tugas mandiri, dikompres menjadi `p14_nim_namapanggilan.zip` (huruf kecil semua, misalnya `p14_2609106001_rina.zip`).
5. *Screenshot* tugas mandiri: (a) terminal berisi hasil `flutter test` yang hijau; (b) panel cakupan di VS Code; (c) tab **Actions** di GitHub; (d) daftar alat di lebar **360**; (e) formulir dengan alasan penolakan; (f) salah satu halaman dalam mode **gelap**.

## 📊 Kriteria Penilaian

| Aspek | Indikator | Skor maks. |
| :--- | :--- | :---: |
| Praktikum 1–5 | Semua modifikasi dikerjakan dan berjalan benar (masing-masing 8 poin) | 40 |
| Tugas mandiri: aturan dan tes unit | Ketentuan 1 dan tes unit di ketentuan 5 | 15 |
| Tugas mandiri: ViewModel, data palsu, dan tesnya | Ketentuan 2, 3, dan tes ViewModel di ketentuan 5 | 15 |
| Tugas mandiri: tampilan dan tes widget | Ketentuan 4, tes widget, dan tes aksesibilitas di ketentuan 5 | 15 |
| Cakupan, CI, catatan *debugging*, dan kerapian | Ketentuan 6, 7, dan 8 | 15 |
| **Total** | | **100** |

## 💭 Refleksi

1. Ingat satu bug yang paling lama Anda cari selama semester ini. Tes seperti apa yang bisa menangkapnya lebih awal, dan berapa lama waktu yang bisa dihemat?
2. Di Praktikum 4, tes mana yang paling cepat menunjukkan letak bug? Bug mana yang lolos dari semua tes, dan apa pelajarannya untuk fitur-fitur Anda berikutnya?
3. Untuk proyek akhir Anda: sebutkan **tiga** bagian yang paling berisiko rusak, lalu tes apa yang akan Anda tulis untuk masing-masing ([Modul Bagian 16](README.md#16-pengujian-untuk-proyek-akhir)).

---

[⬅️ Kembali ke Modul](README.md) · [✍️ Lanjut ke Latihan](LATIHAN.md) · [🏠 Beranda](../README.md)

# ✍️ Latihan Pertemuan 15 — *Build*, Rilis & Finalisasi Proyek

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md)

Kerjakan **tanpa membuka modul dan tanpa menjalankan kode** terlebih dahulu. Setelah selesai, buktikan jawaban Anda dengan menjalankan kodenya. Semua kode di bagian B dan C sudah berupa berkas utuh.

| Soal | Jenis berkas | Tempat menjalankan |
| :--- | :--- | :--- |
| B1, B4, B5, C1, dan D1 | Program konsol (Dart murni) | [DartPad](https://dartpad.dev): tempel, lalu **Run**; hasilnya tampil di konsol. Bisa juga di proyek latihan dengan `flutter run -d chrome -t lib/nama_berkas.dart`; hasilnya tampil di terminal |
| B2 dan B3 | Aplikasi | DartPad hanya bisa membuktikan sebagian, karena DartPad selalu memakai mode *debug* dan tidak bisa diberi `--dart-define`. Untuk membuktikan semua situasi, jalankan di proyek latihan dengan perintah yang tertulis di soal |
| C2 dan C3 | Aplikasi | DartPad, atau proyek latihan. Gejala kedua C2 hanya terlihat di mode *release* |
| D2 | Aplikasi + tes buatan Anda | Proyek latihan di laptop (`flutter run` dan `flutter test`) |
| D3 | Aplikasi buatan Anda | Proyek latihan, atau DartPad |

**Proyek latihan.** Satu proyek cukup untuk semua soal:

```bash
flutter create latihan_p15
cd latihan_p15
flutter pub add http
```

Paket `http` dibutuhkan oleh C3 dan D3: server palsu `MockClient` ada di dalam paket ini ([Pertemuan 10, Bagian 12](../pertemuan_10_async_dan_rest_api/README.md#12-menguji-tanpa-internet-dengan-mockclient)). Simpan setiap soal sebagai **berkas tersendiri** di folder `lib/`, misalnya `lib/b2_mode_build.dart`, lalu pilih berkas yang dijalankan dengan opsi `-t` ([Modul Bagian 3.7](README.md#37-dua-titik-masuk-atau---dart-define)):

```bash
flutter run -d chrome -t lib/b2_mode_build.dart
```

Dengan cara ini, `lib/main.dart` tidak perlu diganti-ganti. Opsi lain, seperti `--release` atau `--dart-define`, ditulis di perintah yang sama.

> [!NOTE]
> Kunci jawaban tidak dipublikasikan. Petunjuk (💡) menunjukkan **bagian modul** yang relevan. Pembahasan lengkap dilakukan bersama dosen di kelas.
>
> Nama aplikasi, akun GitHub, alamat server, nomor versi, dan data dalam soal hanyalah **rekaan** untuk latihan.

---

## A. Pilihan Ganda

**1.** Rina ingin tahu apakah daftar 2.000 tugas di aplikasinya benar-benar tersendat saat digulir. Cara mengukur yang paling tepat adalah ...

- a. `flutter run` di emulator, lalu diamati dengan mata
- b. `flutter run --release` di emulator, karena mode rilis paling cepat
- c. `flutter build apk`, lalu dilihat ukuran berkasnya
- d. `flutter run --profile` di HP sungguhan, lalu dibuka DevTools **Performance**

**2.** Perhatikan kode berikut:

```dart
void simpanToken(String token) {
  debugPrint('Token baru: $token');
  // ... menyimpan token ...
}
```

Apa yang terjadi pada baris `debugPrint` di *build* rilis?

- a. Baris itu tetap dijalankan, sehingga token tertulis di log perangkat. Token tidak boleh dicetak sama sekali, dan log pengembang lainnya dibungkus `if (kDebugMode)`
- b. Baris itu otomatis dibuang dari *build* rilis, karena namanya diawali "debug"
- c. Aplikasi berhenti dengan galat, karena `debugPrint` dilarang di mode rilis
- d. Baris itu hanya dijalankan jika HP sedang tersambung ke laptop

**3.** Agar kunci API layanan pembayaran tidak masuk repositori GitHub, Doni memberikannya lewat `--dart-define=KUNCI_BAYAR=...` saat menjalankan `flutter build apk`. Pernyataan yang benar adalah ...

- a. Aman, karena nilai `--dart-define` hanya tersimpan di laptop Doni
- b. Aman, asalkan nilainya dibaca dengan `const String.fromEnvironment`
- c. Kunci itu memang tidak masuk Git, tetapi **ikut dibawa di dalam APK** dan bisa ditemukan orang yang membongkarnya. Kunci rahasia seperti ini harus tetap di *server*
- d. Aman, asalkan APK-nya disamarkan dengan `--obfuscate`

**4.** Manakah *application ID* yang **sah** dan siap dipakai untuk rilis?

- a. `com.example.jadwalkuliah`
- b. `com.kelompok-3.jadwalkuliah`
- c. `com.3kelompok.jadwalkuliah`
- d. `id.kelompok3.jadwalkuliah`

**5.** Versi terakhir aplikasi Kas Kelas adalah `version: 1.4.2+17`. Rilis berikutnya **hanya** memperbaiki tombol simpan yang macet. Isi baris `version:` yang paling tepat adalah ...

- a. `1.4.3+18`
- b. `1.5.0+17`
- c. `1.4.3+17`
- d. `2.0.0+1`

**6.** Mengapa simbol pada lapisan depan ikon adaptif Android harus diletakkan di tengah, dengan pinggiran yang kosong?

- a. Agar ukuran berkas ikonnya lebih kecil
- b. Karena Google Play menolak ikon yang gambarnya menyentuh tepi
- c. Karena setiap HP memotong ikon menjadi bentuk yang berbeda-beda (lingkaran, persegi membulat, dan lainnya), sehingga bagian pinggirnya bisa ikut terpotong
- d. Agar ikon bisa berubah warna mengikuti tema HP

**7.** Aplikasi memanggil *server*, lalu *server* menjawab dengan kode 500. Menurut pembagian galat di modul, cara menanganinya yang paling tepat adalah ...

- a. Dibiarkan saja, karena jaring pengaman di `main()` akan menangkapnya
- b. Dianggap bug di kode kita: dilaporkan ke Crashlytics, lalu aplikasinya ditutup
- c. Ditampilkan sebagai layar merah, agar pengguna tahu ada masalah
- d. Dianggap galat yang **diduga**: ditangkap dengan `try`–`catch` di *repository* atau ViewModel, lalu ditampilkan pesan ramah beserta tombol coba lagi

**8.** Di *build* rilis, sebuah widget gagal dibangun karena `nilai!` ternyata `null`. Tanpa persiapan apa pun, apa yang dilihat pengguna, dan apa yang dipakai untuk menggantinya dengan tampilan yang sopan?

- a. Layar merah berisi pesan lengkap; diganti dengan `try`–`catch` di dalam `build()`
- b. Kotak abu-abu tanpa keterangan apa pun; diganti dengan `ErrorWidget.builder`
- c. Layar putih kosong; diganti dengan `runZonedGuarded`
- d. *SnackBar* berisi pesan galat; diganti dengan `PlatformDispatcher.instance.onError`

**9.** Aplikasi kalkulator IPK buatan Anda tidak meminta izin apa pun dan tidak mengirim data ke mana pun. Menurut kebijakan Google Play, apakah aplikasi itu tetap memerlukan kebijakan privasi?

- a. Ya. **Semua** aplikasi di Google Play wajib punya kebijakan privasi, yang ditautkan di Play Console dan tersedia di dalam aplikasi. Isinya boleh menyatakan dengan jujur bahwa tidak ada data yang dikumpulkan
- b. Tidak, kebijakan privasi hanya wajib bagi aplikasi yang mengumpulkan data pribadi
- c. Tidak, cukup ditulis di `README.md` repositori
- d. Ya, tetapi cukup berupa berkas PDF yang disertakan di dalam APK

**10.** Repositori Rina bernama `jadwal-kuliah`. Situsnya di GitHub Pages hanya menampilkan layar putih, dan konsol *browser* penuh galat 404. Perintah *build* yang benar adalah ...

- a. `flutter build web --base-href "jadwal-kuliah"`
- b. `flutter build web --release`
- c. `flutter build web --base-href "/jadwal-kuliah/"`
- d. `flutter build web --base-href "/rina.github.io/jadwal-kuliah/"`

**11.** Saat `flutter run`, aplikasi cuaca lancar memuat data. Namun APK rilisnya selalu menampilkan pesan gagal memuat, di HP mana pun. Penyebab yang paling mungkin adalah ...

- a. APK rilis tidak bisa memakai paket `http`
- b. Izin internet hanya ada di `AndroidManifest.xml` versi *debug*; berkas `android/app/src/main/AndroidManifest.xml` belum berisi `android.permission.INTERNET`
- c. *Server* menolak permintaan dari aplikasi rilis
- d. APK belum ditandatangani dengan kunci unggah

**12.** Kemarin Sari memasang APK `1.0.0+1` yang di-*build* di laptop Budi. Hari ini Sari mencoba memasang APK `1.0.1+2` yang di-*build* di laptop Andi (dengan `build.gradle.kts` bawaan), tetapi gagal: *Aplikasi tidak terpasang karena paket bentrok dengan paket yang sudah ada*. Penyebabnya adalah ...

- a. Nomor *build* 2 lebih besar daripada 1
- b. *Application ID* berubah setiap kali di-*build* di laptop lain
- c. HP Sari kehabisan ruang penyimpanan
- d. Kedua APK ditandatangani kunci *debug* yang berbeda, karena kunci *debug* dibuat sendiri-sendiri di setiap laptop

**13.** Berkas manakah yang bisa langsung dipasang di HP Android dengan cara mengetuknya?

- a. `build/app/outputs/flutter-apk/app-release.apk`
- b. `build/app/outputs/bundle/release/app-release.aab`
- c. `build/web/main.dart.js`
- d. `upload-keystore.jks`

**14.** Dimas tidak sengaja mem-*push* `android/key.properties` beserta `upload-keystore.jks` ke GitHub. Lima menit kemudian ia menghapus *commit* itu dari riwayat. Tindakan yang benar berikutnya adalah ...

- a. Tidak perlu apa-apa, karena *commit*-nya sudah dihapus
- b. Cukup mengganti nama berkas kuncinya
- c. Menganggap kunci itu **bocor**: membuat kunci baru, dan jika aplikasinya sudah di Google Play, meminta penggantian kunci unggah lewat Play Console
- d. Mengubah repositorinya menjadi privat, sehingga kunci itu aman lagi

**15.** Rina sudah menjalankan `git tag -a v1.0.0 -m "Rilis 1.0.0"`, lalu `git push`. Namun *workflow* `rilis.yml`, yang berjalan saat *tag* berawalan `v` di-*push*, tidak berjalan. Penyebabnya adalah ...

- a. Nama *tag* harus `1.0.0`, tanpa huruf `v`
- b. `git push` biasa tidak ikut mengirim *tag*. *Tag* harus dikirim dengan `git push origin v1.0.0`
- c. *Workflow* rilis hanya berjalan pada hari kerja
- d. *Tag* hanya bisa dibuat lewat halaman web GitHub

---

## B. Tebak Hasil

Untuk setiap berkas, tebak dulu hasilnya, baru jalankan untuk membuktikan.

**B1.** Mengurutkan versi. Simpan sebagai `lib/b1_urutan_versi.dart`.

```dart
// ignore_for_file: avoid_print
// Ini program konsol, jadi print() boleh dipakai.

class Versi implements Comparable<Versi> {
  const Versi(this.mayor, this.minor, this.patch, this.build);

  final int mayor;
  final int minor;
  final int patch;
  final int build;

  /// Mengurai teks seperti "1.10.0+15".
  static Versi urai(String teks) {
    final List<String> bagian = teks.split('+');
    final List<int> angka = bagian[0].split('.').map(int.parse).toList();
    return Versi(angka[0], angka[1], angka[2], int.parse(bagian[1]));
  }

  /// Urutan menurut NAMA VERSI saja; nomor build tidak ikut dibandingkan.
  @override
  int compareTo(Versi lain) {
    if (mayor != lain.mayor) return mayor.compareTo(lain.mayor);
    if (minor != lain.minor) return minor.compareTo(lain.minor);
    return patch.compareTo(lain.patch);
  }

  @override
  String toString() => '$mayor.$minor.$patch+$build';
}

void main() {
  final List<String> rilis = ['1.9.0+12', '1.10.0+15', '1.2.0+3', '2.0.0+20'];

  final List<String> sebagaiTeks = [...rilis]..sort();
  print('Teks : ${sebagaiTeks.join('  ')}');

  final List<Versi> sebagaiVersi = rilis.map(Versi.urai).toList()..sort();
  print('Versi: ${sebagaiVersi.join('  ')}');

  final Versi a = Versi.urai('1.10.0+15');
  final Versi b = Versi.urai('1.10.0+14');
  print('a lebih baru dari b? ${a.compareTo(b) > 0}');
  print('a sama dengan b?     ${a.compareTo(b) == 0}');
  print('Terbaru: ${sebagaiVersi.last}');
}
```

- (a) Tuliskan kelima baris yang dicetak.
- (b) Mengapa urutan pada baris `Teks` berbeda dengan urutan pada baris `Versi`?
- (c) `a` dan `b` berbeda nomor *build*-nya, tetapi program menganggap keduanya **sama**. Mengapa? Apakah perilaku ini tepat untuk fitur cek pembaruan?
- (d) Apa yang terjadi jika baris `print(Versi.urai('1.4.0'));` ditambahkan di akhir `main()`? Jelaskan penyebabnya.

**B2.** Mode *build*. Simpan sebagai `lib/b2_mode_build.dart`.

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

int _jumlahAssert = 0;

bool _hitungAssert() {
  _jumlahAssert++;
  return true;
}

String get namaMode {
  if (kReleaseMode) return 'release';
  if (kProfileMode) return 'profile';
  return 'debug';
}

void main() {
  assert(_hitungAssert());
  assert(_hitungAssert());

  final List<String> baris = [
    'Mode: $namaMode',
    'assert dijalankan: $_jumlahAssert kali',
    if (kDebugMode) 'Log debug: aktif',
    'Di web: ${kIsWeb ? 'ya' : 'tidak'}',
  ];

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: [for (final String b in baris) ListTile(title: Text(b))],
        ),
      ),
    ),
  );
}
```

Aplikasi ini dijalankan dengan tiga cara:

| No. | Cara menjalankan |
| :---: | :--- |
| 1 | DartPad |
| 2 | `flutter run -d chrome --release -t lib/b2_mode_build.dart` |
| 3 | `flutter run --profile -t lib/b2_mode_build.dart` di HP Android sungguhan |

- (a) Tuliskan baris-baris yang tampil di layar untuk setiap cara. Jumlah barisnya tidak selalu empat.
- (b) Mengapa angka pada baris `assert dijalankan` berbeda-beda?
- (c) Pada cara mana saja baris `Log debug: aktif` tidak tampil? Apakah kode untuk baris itu masih ada di dalam berkas hasil *build*-nya?
- (d) Mengapa cara 3 harus memakai HP sungguhan, bukan emulator?

**B3.** `--dart-define`. Simpan sebagai `lib/b3_dart_define.dart`.

```dart
import 'package:flutter/material.dart';

enum Lingkungan { pengembangan, produksi }

const String teksLingkungan = String.fromEnvironment(
  'LINGKUNGAN',
  defaultValue: 'produksi',
);
const int batasData = int.fromEnvironment('BATAS_DATA', defaultValue: 20);
const bool logRinci = bool.fromEnvironment('LOG_RINCI');

String jelaskanKonfigurasi() {
  final Lingkungan? lingkungan = Lingkungan.values.asNameMap()[teksLingkungan];
  if (lingkungan == null) {
    return 'GALAT: lingkungan "$teksLingkungan" tidak dikenal';
  }
  return '${lingkungan.name}, batas $batasData data, log rinci $logRinci';
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(body: Center(child: Text(jelaskanKonfigurasi()))),
    ),
  );
}
```

Setiap perintah berikut diawali `flutter run -d chrome -t lib/b3_dart_define.dart`, lalu ditambah opsi pada tabel. Jalankan setiap perintah dari awal: hentikan dulu aplikasi sebelumnya dengan menekan `q` di terminal, karena nilai `--dart-define` tidak berubah lewat *hot reload*.

| No. | Opsi tambahan |
| :---: | :--- |
| 1 | (tidak ada) |
| 2 | `--dart-define=LINGKUNGAN=pengembangan --dart-define=LOG_RINCI=true` |
| 3 | `--dart-define=lingkungan=pengembangan` |
| 4 | `--dart-define=LINGKUNGAN=Pengembangan` |
| 5 | `--dart-define=BATAS_DATA=lima` |
| 6 | `--dart-define=LOG_RINCI=ya` |

- (a) Tuliskan teks di tengah layar untuk keenam perintah.
- (b) Pada perintah mana saja pengaturan yang Anda tulis **diam-diam diabaikan**, tanpa pesan apa pun? Mengapa hal ini berbahaya saat mem-*build* rilis?
- (c) Usulkan cara agar salah ketik seperti pada perintah 5 dan 6 juga **ketahuan**, seperti salah ketik pada perintah 4.

**B4.** Keputusan pembaruan. Simpan sebagai `lib/b4_keputusan_pembaruan.dart`.

```dart
// ignore_for_file: avoid_print
// Ini program konsol, jadi print() boleh dipakai.

class Versi implements Comparable<Versi> {
  const Versi(this.mayor, this.minor, this.patch, this.build);

  final int mayor;
  final int minor;
  final int patch;
  final int build;

  static Versi urai(String teks) {
    final RegExpMatch? cocok = RegExp(r'^(\d+)\.(\d+)\.(\d+)(?:\+(\d+))?$')
        .firstMatch(teks);
    if (cocok == null) {
      throw FormatException('Versi tidak dikenal', teks);
    }
    return Versi(
      int.parse(cocok.group(1)!),
      int.parse(cocok.group(2)!),
      int.parse(cocok.group(3)!),
      int.parse(cocok.group(4) ?? '1'),
    );
  }

  @override
  int compareTo(Versi lain) {
    if (mayor != lain.mayor) return mayor.compareTo(lain.mayor);
    if (minor != lain.minor) return minor.compareTo(lain.minor);
    return patch.compareTo(lain.patch);
  }

  bool lebihLamaDari(Versi lain) => compareTo(lain) < 0;

  String get nama => '$mayor.$minor.$patch';

  @override
  String toString() => '$mayor.$minor.$patch+$build';
}

enum Keputusan { terbaru, disarankan, wajib }

Keputusan putuskanPembaruan({
  required Versi terpasang,
  required Versi terbaru,
  required Versi minimum,
}) {
  if (terpasang.lebihLamaDari(minimum)) return Keputusan.wajib;
  if (terpasang.lebihLamaDari(terbaru)) return Keputusan.disarankan;
  return Keputusan.terbaru;
}

void main() {
  // Isi berkas info_rilis.json di server.
  final Versi terbaru = Versi.urai('2.1.0');
  final Versi minimum = Versi.urai('2.0.0');
  print('Server: terbaru ${terbaru.nama}, minimum ${minimum.nama}');

  for (final String terpasang in [
    '2.1.0+30',
    '2.1.0+28',
    '2.0.5+27',
    '2.0.0+20',
    '1.10.3+19',
    '2.10.0+40',
  ]) {
    final Keputusan k = putuskanPembaruan(
      terpasang: Versi.urai(terpasang),
      terbaru: terbaru,
      minimum: minimum,
    );
    print('${terpasang.padRight(10)} -> ${k.name}');
  }
}
```

- (a) Tuliskan ketujuh baris yang dicetak.
- (b) Mengapa `2.1.0+28` dan `2.1.0+30` mendapat keputusan yang sama?
- (c) Mengapa `2.10.0+40` mendapat keputusan `terbaru`, padahal versi terbaru di *server* adalah `2.1.0`?
- (d) Tim menaikkan `versi_minimum` di *server* menjadi `2.1.0`. Baris mana saja yang berubah, dan menjadi apa?

**B5.** Zona dan galat asinkron. Simpan sebagai `lib/b5_zona.dart`.

```dart
// ignore_for_file: avoid_print
// Ini program konsol, jadi print() boleh dipakai.

import 'dart:async';

Future<void> muatProfil() async {
  await Future<void>.delayed(const Duration(milliseconds: 10));
  throw StateError('profil rusak');
}

Future<int> hitungTugas() async {
  await Future<void>.delayed(const Duration(milliseconds: 30));
  return 4;
}

void main() {
  runZonedGuarded(
    () async {
      print('1. mulai');
      try {
        await muatProfil();
      } on StateError catch (galat) {
        print('2. ditangkap try: ${galat.message}');
      }
      muatProfil(); // sengaja TIDAK ditunggu
      print('3. lanjut');
      final int jumlah = await hitungTugas();
      print('4. jumlah tugas: $jumlah');
    },
    (Object galat, StackTrace jejak) {
      print('ZONA: $galat');
    },
  );
  print('5. main selesai');
}
```

- (a) Tuliskan semua baris yang dicetak, sesuai urutannya.
- (b) Mengapa `5. main selesai` tidak dicetak paling akhir?
- (c) `muatProfil()` dipanggil dua kali dan gagal dua kali. Mengapa galat pertama ditangkap oleh `try`–`catch`, sedangkan galat kedua sampai ke fungsi kedua milik `runZonedGuarded`?
- (d) Di aplikasi Flutter, jaring pengaman mana yang menangkap galat seperti galat kedua ini di HP Android, dan mana yang dipakai di web?

<details>
<summary>💡 Petunjuk Bagian B</summary>

B1: Bagian 5.1 dan 5.5; ingat bahwa `sort()` pada daftar teks membandingkan huruf demi huruf. B2: Bagian 2.1–2.3, termasuk catatan tentang emulator. B3: Bagian 3.2–3.4; `int.fromEnvironment` memakai nilai bawaan jika teksnya bukan bilangan bulat, dan `bool.fromEnvironment` memakai nilai bawaan jika teksnya bukan `true` atau `false`. B4: Bagian 13.2 dan 5.5. B5: Bagian 7.3–7.4, serta cara kerja `async` dan `await` di [Pertemuan 3, Bagian 10.3](../pertemuan_03_dart_lanjutan/README.md#103-then-vs-await-siapa-yang-duluan) dan [10.5](../pertemuan_03_dart_lanjutan/README.md#105-menangani-error-pada-future).
</details>

---

## C. Temukan dan Perbaiki Kesalahannya

Setiap kode berikut mengandung **dua** kesalahan. Untuk setiap kesalahan, jelaskan **pesan atau gejalanya**, **penyebabnya**, dan **perbaikannya**. Perbaiki seperlunya saja: struktur kode dan teks tampilannya dipertahankan.

**C1.** Dina menulis program yang menyarankan pembaruan. Versi yang terpasang adalah `1.9.2+14`. Aturannya: sarankan **PERBARUI** jika **nama versi** di *server* lebih baru; nomor *build* diabaikan. Hasil yang ia harapkan:

```text
Server 1.9.3+15 -> PERBARUI
Server 1.10.0+16 -> PERBARUI
Server 1.9.2+15 -> sudah terbaru
Server 1.8.9+9 -> sudah terbaru
```

Kenyataannya, program langsung berhenti dengan galat `FormatException` yang menyebut teks `2+14`. Setelah galat itu diperbaiki, masih ada **satu** baris hasil yang salah. Simpan sebagai `lib/c1_pengingat_pembaruan.dart`.

```dart
// ignore_for_file: avoid_print
// Ini program konsol, jadi print() boleh dipakai.

/// Versi aplikasi, misalnya "1.10.0+15".
class Versi {
  const Versi(this.mayor, this.minor, this.patch, this.build);

  final int mayor;
  final int minor;
  final int patch;
  final int build;

  static Versi urai(String teks) {
    final List<int> angka = teks.split('.').map(int.parse).toList();
    return Versi(angka[0], angka[1], angka[2], angka.length > 3 ? angka[3] : 1);
  }

  String get nama => '$mayor.$minor.$patch';

  /// true jika versi ini lebih baru daripada [lain]. Nomor build diabaikan.
  bool lebihBaruDari(Versi lain) => nama.compareTo(lain.nama) > 0;
}

void main() {
  final Versi terpasang = Versi.urai('1.9.2+14');
  for (final String diServer in [
    '1.9.3+15',
    '1.10.0+16',
    '1.9.2+15',
    '1.8.9+9',
  ]) {
    final Versi versiServer = Versi.urai(diServer);
    final String saran = versiServer.lebihBaruDari(terpasang)
        ? 'PERBARUI'
        : 'sudah terbaru';
    print('Server $diServer -> $saran');
  }
}
```

**C2.** Raka membuat halaman pengaturan, lalu menerima dua laporan:

1. Di DartPad, seluruh layar langsung **merah** dengan pesan `Unsupported operation: String.fromEnvironment can only be used as a const constructor`.
2. Setelah masalah pertama diperbaiki, sakelar **Pengingat tenggat tugas** tampak berfungsi di DartPad: baris **Tersimpan** berubah menjadi `{pengingat: true}`. Namun pada *build* rilis (`flutter run -d chrome --release -t lib/c2_pengaturan.dart`), baris **Tersimpan** tetap `{}` walaupun sakelarnya sudah dinyalakan berkali-kali.

Simpan sebagai `lib/c2_pengaturan.dart`.

```dart
import 'package:flutter/material.dart';

/// Alamat server, bisa diganti saat build: --dart-define=ALAMAT_API=...
final String alamatApi = String.fromEnvironment(
  'ALAMAT_API',
  defaultValue: 'https://dummyjson.com',
);

/// Tempat pengaturan disimpan. Di aplikasi sungguhan: shared_preferences.
final Map<String, bool> penyimpanan = {};

bool simpanPengaturan(String kunci, bool nilai) {
  penyimpanan[kunci] = nilai;
  return true;
}

void main() => runApp(const MaterialApp(home: HalamanPengaturan()));

class HalamanPengaturan extends StatefulWidget {
  const HalamanPengaturan({super.key});

  @override
  State<HalamanPengaturan> createState() => _HalamanPengaturanState();
}

class _HalamanPengaturanState extends State<HalamanPengaturan> {
  bool _pengingat = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Pengingat tenggat tugas'),
            value: _pengingat,
            onChanged: (bool nilai) {
              setState(() => _pengingat = nilai);
              // Pastikan penyimpanannya berhasil.
              assert(simpanPengaturan('pengingat', nilai));
            },
          ),
          ListTile(
            title: const Text('Tersimpan'),
            subtitle: Text('$penyimpanan'),
          ),
          ListTile(title: const Text('Server'), subtitle: Text(alamatApi)),
        ],
      ),
    );
  }
}
```

**C3.** Aplikasi "Jadwal Kuliah" memeriksa pembaruan setiap kali dibuka. Penguji melaporkan dua masalah:

1. Saat *server* info rilis sedang mati (`skenario = 'mati'`), tulisan **Memeriksa pembaruan ...** tidak pernah berganti, dan galat `ClientException: kode status 503` tidak ditangani siapa pun. Penguji juga khawatir: jika *server* sangat lambat, pengguna akan menunggu tanpa batas.
2. Saat versi minimum dinaikkan (`skenario = 'wajib'`), dialog **Perbarui aplikasi** bisa ditutup hanya dengan mengetuk area gelap di luar dialog (atau dengan tombol kembali di Android), lalu aplikasi versi lama tetap bisa dipakai.

Perilaku yang diharapkan: jika pemeriksaan gagal, tulisan berganti menjadi **Gagal memeriksa pembaruan. Aplikasi tetap bisa dipakai.** paling lama dalam 5 detik, dan dialog wajib **tidak bisa ditutup** sama sekali. Simpan sebagai `lib/c3_jadwal_kuliah.dart` (membutuhkan paket `http`).

```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

const String versiTerpasang = '1.2.0';

/// Ganti untuk mencoba keadaan server: 'normal', 'wajib', atau 'mati'.
const String skenario = 'mati';

/// Server palsu (Pertemuan 10): menjawab setelah jeda 300 milidetik.
http.Client buatKlien() {
  return MockClient((http.Request permintaan) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return switch (skenario) {
      'normal' => http.Response(
        jsonEncode({'versi_terbaru': '1.3.0', 'versi_minimum': '1.0.0'}),
        200,
      ),
      'wajib' => http.Response(
        jsonEncode({'versi_terbaru': '1.3.0', 'versi_minimum': '1.3.0'}),
        200,
      ),
      _ => http.Response('Service Unavailable', 503),
    };
  });
}

/// Membandingkan dua versi "MAYOR.MINOR.PATCH" sebagai ANGKA.
/// Hasil negatif jika [a] lebih lama daripada [b].
int bandingkan(String a, String b) {
  final List<int> x = a.split('.').map(int.parse).toList();
  final List<int> y = b.split('.').map(int.parse).toList();
  for (int i = 0; i < 3; i++) {
    if (x[i] != y[i]) return x[i].compareTo(y[i]);
  }
  return 0;
}

class LayananInfoRilis {
  LayananInfoRilis(this._klien);

  final http.Client _klien;

  Future<Map<String, dynamic>> ambil() async {
    final http.Response respons = await _klien.get(
      Uri.parse('https://jadwal.contoh.ac.id/info_rilis.json'),
    );
    if (respons.statusCode != 200) {
      throw http.ClientException('kode status ${respons.statusCode}');
    }
    return jsonDecode(respons.body) as Map<String, dynamic>;
  }
}

void main() => runApp(const MaterialApp(home: HalamanJadwal()));

class HalamanJadwal extends StatefulWidget {
  const HalamanJadwal({super.key});

  @override
  State<HalamanJadwal> createState() => _HalamanJadwalState();
}

class _HalamanJadwalState extends State<HalamanJadwal> {
  String _status = 'Memeriksa pembaruan ...';

  @override
  void initState() {
    super.initState();
    _periksa(); // sekali, saat aplikasi dibuka
  }

  Future<void> _periksa() async {
    final Map<String, dynamic> info = await LayananInfoRilis(buatKlien())
        .ambil();
    if (!mounted) return;
    final String terbaru = info['versi_terbaru'] as String;
    final String minimum = info['versi_minimum'] as String;

    if (bandingkan(versiTerpasang, minimum) < 0) {
      setState(() => _status = 'Versi ini sudah tidak didukung.');
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Perbarui aplikasi'),
          content: Text(
            'Versi $versiTerpasang sudah tidak didukung. '
            'Perbarui ke versi $terbaru untuk melanjutkan.',
          ),
          actions: [
            FilledButton(
              onPressed: () {}, // di aplikasi sungguhan: buka tautan unduhan
              child: const Text('Perbarui sekarang'),
            ),
          ],
        ),
      );
    } else if (bandingkan(versiTerpasang, terbaru) < 0) {
      setState(() => _status = 'Versi $terbaru tersedia.');
    } else {
      setState(() => _status = 'Aplikasi sudah versi terbaru.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jadwal Kuliah')),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.system_update),
            title: Text(_status),
          ),
          const Divider(),
          const Expanded(
            child: Center(child: Text('Senin 07.30 · Pemrograman Piranti')),
          ),
        ],
      ),
    );
  }
}
```

<details>
<summary>💡 Petunjuk Bagian C</summary>

C1: Bagian 5.1 (dua nomor dalam satu baris `version`) dan 5.5. C2: Bagian 3.3 dan 2.3. C3: Bagian 13.2 (tabel tampilan setiap keputusan) dan 13.3.
</details>

---

## D. Menulis Kode

Pada bagian ini Anda menulis kode sendiri. Terapkan kebiasaan rilis hari ini:

1. Versi selalu dibandingkan sebagai **angka**, bukan sebagai teks.
2. Aplikasi Flutter tidak memakai `print`. Log untuk pengembang dibungkus `if (kDebugMode)`.
3. Fitur tambahan, seperti cek pembaruan, **tidak boleh** membuat aplikasi macet atau galat.
4. Sebelum selesai: `dart format .`, lalu `flutter analyze` harus diakhiri `No issues found!`, dan `flutter test` harus hijau.

**D1 — Versi Berikutnya dari Pesan *Commit*.** Banyak tim menulis judul *commit* dengan pola **`jenis: isi`**, misalnya `fix: tombol simpan tidak macet lagi`. Pola ini dikenal sebagai [*Conventional Commits*](https://www.conventionalcommits.org/en/v1.0.0/). Dengan pola ini, nomor versi berikutnya bisa ditentukan oleh program.

| Jenis | Arti | Contoh judul |
| :--- | :--- | :--- |
| `feat` | Fitur baru | `feat: ekspor jadwal ke kalender` |
| `fix` | Perbaikan bug | `fix: urutan hari salah di minggu kedua` |
| `docs`, `test`, `refactor`, `chore`, dan lainnya | Perubahan yang tidak dirasakan langsung oleh pengguna | `docs: perbarui README` |

Perubahan yang **tidak cocok** dengan versi lama ditandai dengan tanda `!` tepat sebelum titik dua (`feat!: format penyimpanan baru`), atau dengan baris `BREAKING CHANGE:` di badan pesan *commit*.

Lengkapi dua fungsi pada kerangka berikut. Jangan mengubah kelas `Versi` dan fungsi `main()`. Simpan sebagai `lib/d1_versi_rilis.dart`, atau kerjakan di DartPad.

```dart
// ignore_for_file: avoid_print
// Ini program konsol, jadi print() boleh dipakai.

class Versi {
  const Versi(this.mayor, this.minor, this.patch, this.build);

  final int mayor;
  final int minor;
  final int patch;
  final int build;

  static Versi urai(String teks) {
    final RegExpMatch? cocok = RegExp(r'^(\d+)\.(\d+)\.(\d+)\+(\d+)$')
        .firstMatch(teks);
    if (cocok == null) {
      throw FormatException('Versi harus MAYOR.MINOR.PATCH+BUILD', teks);
    }
    return Versi(
      int.parse(cocok.group(1)!),
      int.parse(cocok.group(2)!),
      int.parse(cocok.group(3)!),
      int.parse(cocok.group(4)!),
    );
  }

  String get nama => '$mayor.$minor.$patch';

  @override
  String toString() => '$nama+$build';
}

/// Versi rilis berikutnya menurut pesan commit sejak rilis terakhir.
/// Kembalikan null jika tidak ada yang perlu dirilis.
Versi? versiBerikutnya(Versi sekarang, List<String> pesanCommit) {
  // Tulis kode Anda di sini. Aturan lengkapnya ada di soal D1.
  throw UnimplementedError();
}

/// Bagian CHANGELOG.md untuk versi baru.
String bagianChangelog(Versi versi, String tanggal, List<String> pesanCommit) {
  // Tulis kode Anda di sini. Formatnya ada di soal D1.
  throw UnimplementedError();
}

void main() {
  final List<(String, List<String>)> kasus = [
    (
      '1.4.2+17',
      ['fix: tombol simpan tidak macet lagi', 'docs: perbarui README'],
    ),
    (
      '1.4.3+18',
      [
        'feat: ekspor jadwal ke kalender',
        'fix: urutan hari salah di minggu kedua',
        'test: tambah tes ekspor',
      ],
    ),
    (
      '1.5.0+19',
      [
        'feat!: format penyimpanan baru',
        'fix: ikon tidak tampil di Android 13',
      ],
    ),
    (
      '2.0.0+20',
      [
        'refactor: pindahkan logika ke ViewModel\n\n'
            'BREAKING CHANGE: data versi 1 tidak bisa dibaca lagi',
      ],
    ),
    ('3.0.0+21', ['docs: perbaiki salah ketik', 'chore: perbarui paket']),
  ];

  for (final (String teks, List<String> pesan) in kasus) {
    final Versi? baru = versiBerikutnya(Versi.urai(teks), pesan);
    print('$teks -> ${baru ?? 'tidak perlu rilis'}');
  }

  print('');
  print(bagianChangelog(Versi.urai('1.5.0+19'), '2026-11-20', kasus[1].$2));
}
```

Aturan `versiBerikutnya` mengikuti *Semantic Versioning* ([Modul Bagian 5.2–5.3](README.md#52-nama-versi-semantic-versioning)):

1. Judul *commit* adalah **baris pertama** pesannya.
2. Jika ada **minimal satu** *commit* yang ditandai perubahan besar (tanda `!` sebelum titik dua pada judulnya, atau pesannya memuat `BREAKING CHANGE`), **MAYOR** naik.
3. Jika tidak, tetapi ada *commit* berjenis `feat`, **MINOR** naik.
4. Jika tidak, tetapi ada *commit* berjenis `fix`, **PATCH** naik.
5. Jika tidak ada satu pun, kembalikan `null`: tidak perlu rilis.
6. Saat satu bagian naik, bagian di kanannya kembali ke `0`. Nomor *build* **selalu** naik satu.

Aturan `bagianChangelog` mengikuti format [Modul Bagian 17.3](README.md#173-catatan-perubahan-changelogmd):

1. Baris pertama `## [NAMA_VERSI] - TANGGAL`, tanpa nomor *build*.
2. Kelompok `### Ditambahkan` berisi *commit* `feat`, lalu kelompok `### Diperbaiki` berisi *commit* `fix`. Jenis lain tidak ditulis, dan kelompok yang kosong tidak ditulis.
3. Setiap butir diawali `- `, berisi isi judul (teks setelah titik dua) dengan huruf pertama dijadikan kapital.
4. Ada satu baris kosong setelah setiap judul, dan satu baris kosong sebelum kelompok berikutnya, seperti hasil di bawah.

Hasil yang diharapkan:

```text
1.4.2+17 -> 1.4.3+18
1.4.3+18 -> 1.5.0+19
1.5.0+19 -> 2.0.0+20
2.0.0+20 -> 3.0.0+21
3.0.0+21 -> tidak perlu rilis

## [1.5.0] - 2026-11-20

### Ditambahkan

- Ekspor jadwal ke kalender

### Diperbaiki

- Urutan hari salah di minggu kedua
```

<details>
<summary>💡 Petunjuk D1</summary>

Ambil judul dengan `pesan.split('\n').first`. Judul bisa dipecah tanpa `RegExp`: cari posisi titik dua pertama dengan `judul.indexOf(':')`. Teks sebelumnya adalah jenis, yang mungkin diakhiri `!` (periksa dengan `endsWith('!')`, lalu buang tanda itu). Teks sesudahnya, setelah `trim()`, adalah isinya. Jika tidak ada titik dua, `indexOf` menghasilkan `-1`: *commit* itu tidak berjenis. Untuk menyusun teks bertingkat, `StringBuffer` lebih rapi daripada menyambung `String` berkali-kali.
</details>

**D2 — Konfigurasi Rilis "Kas Kelas".** Aplikasi Kas Kelas akan dibagikan dalam tiga bentuk: *build* **pengembangan** untuk tim (boleh memakai *server* lokal), *build* **demo** untuk presentasi, dan *build* **produksi** untuk teman sekelas. Semua pengaturannya diberikan lewat `--dart-define`:

| Nama | Jenis | Nilai bawaan | Aturan |
| :--- | :--- | :--- | :--- |
| `LINGKUNGAN` | Teks | `produksi` | Hanya `pengembangan`, `demo`, atau `produksi`, ditulis persis (huruf kecil) |
| `ALAMAT_API` | Teks | `https://kaskelas.contoh.ac.id` | Alamat lengkap yang punya nama *host*. Di `demo` dan `produksi` wajib diawali `https://` |
| `BATAS_DATA` | Bilangan bulat | `50` | 1 sampai 100 |
| `LOG_RINCI` | `true` atau `false` | `false` | Tidak boleh `true` di `produksi` |

Ketentuan:

1. Semua nilai dibaca dengan `const ... fromEnvironment` ([Modul Bagian 3.3](README.md#33-membaca-nilainya-wajib-const)), lalu disimpan di konstanta privat `_teksLingkungan`, `_teksAlamat`, `_batasData`, dan `_logRinci`.
2. Buat `enum Lingkungan { pengembangan, demo, produksi }` dan kelas `Konfigurasi` berisi `lingkungan`, `alamatApi` (bertipe `Uri`), `batasData`, dan `logRinci`. Kelas ini punya fungsi statis yang bentuknya **persis** seperti ini:

   ```dart
   static ({Konfigurasi? konfigurasi, List<String> masalah}) periksa({
     String teksLingkungan = _teksLingkungan,
     String teksAlamat = _teksAlamat,
     int batasData = _batasData,
     bool logRinci = _logRinci,
   })
   ```

   Karena nilai bawaan parameternya adalah konstanta `--dart-define`, `periksa()` tanpa argumen memeriksa pengaturan *build*, sedangkan tes bisa memanggilnya dengan nilai lain, misalnya `periksa(teksLingkungan: 'demo')`.
3. `periksa` memeriksa **semua** aturan, lalu mengembalikan dua hal: `konfigurasi` (bernilai `null` jika ada masalah) dan `masalah` (daftar **semua** masalah; kosong jika tidak ada). Dengan begitu, orang yang mem-*build* langsung melihat semua kesalahannya, bukan satu per satu. Pesannya ditulis persis seperti berikut:

   | Masalah | Pesan |
   | :--- | :--- |
   | Lingkungan tidak dikenal | `LINGKUNGAN "<nilai>" tidak dikenal. Pilih: pengembangan, demo, produksi.` |
   | Alamat tanpa nama *host* | `ALAMAT_API "<nilai>" tidak valid.` |
   | Bukan `https://` di demo atau produksi | `Lingkungan <nama lingkungan> wajib memakai https://.` |
   | Batas data di luar rentang | `BATAS_DATA <nilai> di luar rentang 1 sampai 100.` |
   | Log rinci di produksi | `LOG_RINCI tidak boleh aktif di produksi.` |

4. `main()`: jika `konfigurasi` bernilai `null`, jalankan layar berjudul **Konfigurasi build tidak valid** yang menampilkan semua masalah, satu per baris. Jika valid, jalankan aplikasi yang halamannya menampilkan keempat nilai. Tandai *build*-nya dengan pita `Banner` ([Modul Bagian 3.5](README.md#35-pita-penanda-build-uji)): `BUILD UJI` untuk pengembangan, `DEMO` berwarna oranye untuk demo, dan tanpa pita untuk produksi.
5. Tulis `test/konfigurasi_test.dart` berisi enam tes, satu untuk setiap baris tabel uji di bawah. Setiap tes memanggil `Konfigurasi.periksa(...)` **langsung** dengan nilai baris itu, bukan lewat `--dart-define`.

Simpan aplikasinya sebagai `lib/d2_kas_kelas.dart`. Tabel uji (setiap perintah diawali `flutter run -d chrome -t lib/d2_kas_kelas.dart`):

| No. | Opsi tambahan | Hasil yang diharapkan |
| :---: | :--- | :--- |
| 1 | (tidak ada) | Aplikasi berjalan di lingkungan produksi, tanpa pita |
| 2 | `--dart-define=LINGKUNGAN=demo` | Aplikasi berjalan dengan pita oranye **DEMO** |
| 3 | `--dart-define=LINGKUNGAN=pengembangan --dart-define=ALAMAT_API=http://localhost:8080` | Aplikasi berjalan dengan pita **BUILD UJI**; `http://` boleh dipakai di pengembangan |
| 4 | `--dart-define=ALAMAT_API=http://kaskelas.contoh.ac.id` | Layar konfigurasi salah: `Lingkungan produksi wajib memakai https://.` |
| 5 | `--dart-define=BATAS_DATA=0 --dart-define=LOG_RINCI=true` | Layar konfigurasi salah dengan **dua** masalah: `BATAS_DATA 0 di luar rentang 1 sampai 100.` dan `LOG_RINCI tidak boleh aktif di produksi.` |
| 6 | `--dart-define=LINGKUNGAN=Produksi` | Layar konfigurasi salah: `LINGKUNGAN "Produksi" tidak dikenal. Pilih: pengembangan, demo, produksi.` |

> [!NOTE]
> **Tentang *record*.** `({Konfigurasi? konfigurasi, List<String> masalah})` adalah *record*: satu nilai yang membawa beberapa nilai sekaligus, masing-masing bernama. Membuatnya: `return (konfigurasi: null, masalah: masalah);`. Membacanya bisa lewat namanya, misalnya `hasil.masalah`, atau dibongkar sekaligus menjadi dua variabel: `final (:Konfigurasi? konfigurasi, :List<String> masalah) = Konfigurasi.periksa();`. Selengkapnya ada di [dokumentasi Dart tentang *records*](https://dart.dev/language/records).

<details>
<summary>💡 Petunjuk D2</summary>

Mulailah dari Contoh 02 ([Modul Bagian 3.4](README.md#34-nilai-bawaan-yang-aman-dan-nilai-yang-salah-ketik)). Bedanya, `dariLingkungan()` di sana **melempar galat** pada masalah pertama, sedangkan `periksa()` **mengumpulkan** semua masalah ke dalam daftar. Karena itu, tulis pemeriksaan untuk setiap aturan sebagai `if` tersendiri, bukan rangkaian `else if`. `Lingkungan.values.asNameMap()[teks]` menghasilkan `null` untuk nama yang tidak dikenal ([Pertemuan 11, Bagian 3.2](../pertemuan_11_penyimpanan_lokal/README.md#32-enum-disimpan-sebagai-namanya)). `Uri.tryParse(teks)` menghasilkan `null` jika teksnya rusak, tetapi `Uri.tryParse('kaskelas')` tetap menghasilkan `Uri` dengan `host` kosong; periksa juga `host.isEmpty`. Skema alamat dibaca dengan `alamat.scheme` (`'https'` atau `'http'`). Di tes, `expect(masalah, isEmpty)`, `expect(konfigurasi, isNull)`, dan `expect(masalah, [...])` sudah cukup ([Pertemuan 14](../pertemuan_14_pengujian_dan_debugging/README.md)).
</details>

**D3 — Cek Pembaruan dari GitHub Releases.** Tim "Jadwal Kuliah" membagikan APK lewat GitHub Releases ([Modul Bagian 12](README.md#12-rilis-otomatis-dengan-github)). Daripada membuat berkas `info_rilis.json` sendiri, mereka ingin memakai alamat yang sudah disediakan GitHub ([Modul Bagian 13.4](README.md#134-coba-sendiri-contoh-05), kotak *Tip*):

```text
GET https://api.github.com/repos/<akun>/<repositori>/releases/latest
```

Alamat ini mengembalikan rilis **terbaru** yang bukan *draft* dan bukan *pre-release*. Contohnya (dipersingkat):

```json
{
  "tag_name": "v1.4.0",
  "name": "v1.4.0",
  "html_url": "https://github.com/timjadwal/jadwal_kuliah/releases/tag/v1.4.0",
  "body": "Ekspor jadwal ke kalender.",
  "draft": false,
  "prerelease": false
}
```

Kesepakatan tim: jika catatan rilis (`body`) memuat teks **`[WAJIB]`**, versi sebelumnya sudah tidak boleh dipakai.

Agar latihan ini tidak bergantung pada internet dan pada batas jumlah permintaan ke GitHub, gunakan *server* palsu siap pakai berikut. Salin ke bagian **atas** `lib/d3_jadwal_kuliah.dart`, lalu tulis sisanya di bawahnya:

```dart
// BAGIAN SIAP PAKAI UNTUK SOAL D3 (boleh disalin).
// Server GitHub palsu yang meniru jawaban
// GET https://api.github.com/repos/<akun>/<repositori>/releases/latest
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

/// Versi "Jadwal Kuliah" yang sedang terpasang. Di proyek sungguhan,
/// versi ini dibaca dengan package_info_plus.
const String versiTerpasang = '1.3.0';

/// Alamat rilis terbaru di GitHub (contoh).
final Uri alamatRilisTerbaru = Uri.https(
  'api.github.com',
  '/repos/timjadwal/jadwal_kuliah/releases/latest',
);

enum Skenario {
  sama('Belum ada versi baru'),
  baru('Ada versi 1.4.0'),
  wajib('Versi 1.4.0 bertanda [WAJIB]'),
  dibatasi('GitHub membatasi permintaan (403)'),
  tagAneh('Tag tidak berformat versi');

  const Skenario(this.label);

  final String label;
}

/// Jawaban palsu untuk setiap skenario, setelah jeda 300 milidetik.
http.Client buatKlien(Skenario skenario) {
  String rilis(String tag, String catatan) => jsonEncode({
    'tag_name': tag,
    'name': tag,
    'html_url': 'https://github.com/timjadwal/jadwal_kuliah/releases/tag/$tag',
    'body': catatan,
    'draft': false,
    'prerelease': false,
  });

  return MockClient((http.Request permintaan) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return switch (skenario) {
      Skenario.sama => http.Response(rilis('v1.3.0', 'Perbaikan kecil.'), 200),
      Skenario.baru => http.Response(
        rilis('v1.4.0', 'Ekspor jadwal ke kalender.'),
        200,
      ),
      Skenario.wajib => http.Response(
        rilis(
          'v1.4.0',
          '[WAJIB] Format data baru. Versi lama tidak bisa '
              'memuat jadwal.',
        ),
        200,
      ),
      Skenario.dibatasi => http.Response(
        jsonEncode({'message': 'API rate limit exceeded'}),
        403,
      ),
      Skenario.tagAneh => http.Response(
        rilis('rilis-desember', 'Rilis akhir semester.'),
        200,
      ),
    };
  });
}
```

Ketentuan:

1. Saat aplikasi dibuka, periksa pembaruan **sekali**, memakai `buatKlien(skenario)` dengan skenario awal `Skenario.baru`. Tutup kliennya setelah selesai.
2. Kirim permintaan ke `alamatRilisTerbaru` dengan *header* `Accept: application/vnd.github+json`, sesuai anjuran dokumentasi GitHub, dan dengan batas waktu 5 detik.
3. Ambil `tag_name`, `html_url`, dan `body` dengan pola *map* ([Pertemuan 10, Bagian 6.2](../pertemuan_10_async_dan_rest_api/README.md#62-factory-fromjson-dengan-pola-dart-3)). Nama *tag* boleh diawali huruf `v`. Bandingkan dengan `versiTerpasang` sebagai **angka**.
4. Keputusan dan tampilannya:

   | Keadaan | Teks status | Tampilan tambahan |
   | :--- | :--- | :--- |
   | Rilis terbaru **tidak** lebih baru daripada versi terpasang | `Aplikasi sudah versi terbaru.` | — |
   | Lebih baru, tanpa `[WAJIB]` | `Versi 1.4.0 tersedia.` | `MaterialBanner` berisi versi dan catatan rilis, dengan tombol **Nanti** (menutup *banner*) dan **Lihat rilis** |
   | Lebih baru, dengan `[WAJIB]` | `Versi ini sudah tidak didukung.` | Dialog **Perbarui aplikasi** berisi catatan rilis dan tombol **Perbarui sekarang**, yang tidak bisa ditutup dengan mengetuk di luar dialog maupun dengan tombol kembali |
   | Gagal: kode status bukan 200, bentuk JSON tidak sesuai, nama *tag* bukan versi, atau lewat dari 5 detik | `Gagal memeriksa pembaruan. Aplikasi tetap bisa dipakai.` | — |

5. **Lihat rilis** dan **Perbarui sekarang** belum perlu membuka *browser*. Tampilkan saja *SnackBar* `Membuka <html_url>`; di proyek sungguhan dipakai paket `url_launcher`. Khusus untuk latihan ini, **Perbarui sekarang** juga menutup dialognya, agar skenario lain bisa dicoba.
6. Sediakan `PopupMenuButton` di `AppBar` untuk memilih `Skenario`. Setiap pilihan langsung memeriksa ulang. Halaman menampilkan versi terpasang, label skenario yang aktif, dan teks status.
7. Galat tidak pernah sampai ke pengguna. Log untuk pengembang hanya muncul di mode *debug*.

Hasil yang diharapkan:

| Skenario | Hasil |
| :--- | :--- |
| Belum ada versi baru | `Aplikasi sudah versi terbaru.` |
| Ada versi 1.4.0 | *Banner* "Versi 1.4.0 tersedia. Ekspor jadwal ke kalender."; **Lihat rilis** memunculkan *SnackBar* `Membuka https://github.com/timjadwal/jadwal_kuliah/releases/tag/v1.4.0` |
| Versi 1.4.0 bertanda [WAJIB] | Dialog wajib muncul; mengetuk area gelap atau menekan `Esc` tidak menutupnya |
| GitHub membatasi permintaan (403) | `Gagal memeriksa pembaruan. Aplikasi tetap bisa dipakai.` |
| Tag tidak berformat versi | Sama seperti baris sebelumnya |

Terakhir, jawab dalam komentar di akhir berkas: menurut dokumentasi GitHub, permintaan tanpa akun dibatasi **60 permintaan per jam** untuk setiap alamat IP. Mengapa aplikasi Anda tetap bisa dipakai jika batas itu terlampaui, dan mengapa pemeriksaan sebaiknya dilakukan sekali saja saat aplikasi dibuka, bukan setiap kali halaman dibangun?

<details>
<summary>💡 Petunjuk D3</summary>

Kerangkanya hampir sama dengan Contoh 05 ([Modul Bagian 13.4](README.md#134-coba-sendiri-contoh-05)): kelas `Versi`, keputusan `terbaru`/`disarankan`/`wajib`, `MaterialBanner`, dan dialog wajib. Yang berbeda hanya sumber datanya. Nama *tag* `v1.4.0` bisa diubah menjadi `1.4.0` dengan `tag.startsWith('v') ? tag.substring(1) : tag`. `FormatException`, `TimeoutException`, dan `http.ClientException` semuanya termasuk `Exception`, sehingga satu `on Exception catch` cukup untuk menangkap kegagalan yang diduga ([Modul Bagian 13.3](README.md#133-aturan-emas-jangan-menghalangi-pengguna)). Panggil pemeriksaan dari `initState`, bukan dari `build` ([Pertemuan 10](../pertemuan_10_async_dan_rest_api/README.md)).
</details>

---

[⬅️ Kembali ke Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md) · [🏠 Beranda](../README.md)

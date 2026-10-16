# ✍️ Latihan Pertemuan 13 — Fitur Perangkat & Izin Akses

[🏠 Beranda](../README.md) · [📖 Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md)

Kerjakan **tanpa membuka modul dan tanpa menjalankan kode** terlebih dahulu. Setelah selesai, buktikan jawaban Anda dengan menjalankan kodenya. Semua kode di bagian B dan C sudah berupa program utuh.

| Soal | Tempat menjalankan |
| :--- | :--- |
| B1–B4 | Program Dart murni: [DartPad](https://dartpad.dev) atau `dart run nama_berkas.dart`. Hasilnya tampil di konsol |
| B5 dan C3 | DartPad, atau `lib/main.dart` proyek latihan dengan paket `provider` |
| C1 dan C2 | Proyek `lapor_fasilitas` dari [Jobsheet](JOBSHEET.md), yang sudah berisi `image_picker` dan `geolocator`. Jalankan dengan `flutter run -d chrome --web-port=8080`. DartPad tidak menyediakan kedua paket itu |

> [!NOTE]
> Kunci jawaban tidak dipublikasikan. Petunjuk (💡) menunjukkan **bagian modul** yang relevan. Pembahasan lengkap dilakukan bersama dosen di kelas.
>
> Koordinat dan aturan dalam soal hanyalah **rekaan** untuk latihan.

---

## A. Pilihan Ganda

**1.** Aplikasi "Lapor Fasilitas" membutuhkan lokasi hanya saat pengguna menandai kerusakan. Kapan izin lokasi sebaiknya diminta?

- a. Saat aplikasi pertama kali dibuka, agar semua izin beres di awal
- b. Setelah laporan dikirim, agar pengguna tidak terganggu saat mengisi
- c. Tidak perlu diminta, karena `geolocator` meminta izin sendiri setiap kali aplikasi dibuka
- d. Saat pengguna mengetuk **Tandai lokasi**, karena pada saat itulah alasannya jelas bagi pengguna

**2.** `Geolocator.checkPermission()` mengembalikan `LocationPermission.denied`. Artinya ...

- a. izin belum pernah diminta, atau baru ditolak; aplikasi masih boleh memintanya lagi
- b. pengguna sudah menolak dua kali, sehingga dialog tidak akan muncul lagi
- c. layanan lokasi di HP sedang mati
- d. aplikasi lupa menulis izin di `AndroidManifest.xml`

**3.** Di Android 11 ke atas, pengguna menolak dialog izin lokasi untuk **kedua** kalinya. Saat aplikasi memanggil `requestPermission()` lagi, yang terjadi adalah ...

- a. dialog muncul lagi dengan pilihan yang sama
- b. aplikasi ditutup paksa oleh Android
- c. Android langsung menjawab `deniedForever` tanpa dialog, sehingga jalan satu-satunya adalah Pengaturan
- d. izin otomatis diberikan karena pengguna sudah ditanya dua kali

**4.** Seorang mahasiswa menambahkan `<uses-permission android:name="android.permission.CAMERA" />` ke `AndroidManifest.xml` karena aplikasinya memakai `image_picker`. Akibatnya ...

- a. kamera terbuka lebih cepat
- b. jika izin itu belum diberikan pengguna, Android justru menolak membuka aplikasi kamera bawaan
- c. tidak ada akibat apa pun
- d. galeri tidak bisa dibuka lagi

**5.** `pickImage(source: ImageSource.camera)` mengembalikan `null`. Tindakan yang paling tepat adalah ...

- a. menganggapnya pengguna **membatalkan**, sehingga tidak perlu pesan galat
- b. menampilkan pesan galat merah "Kamera rusak"
- c. memanggil `pickImage` lagi sampai hasilnya tidak `null`
- d. memakai `berkas!`, karena `pickImage` tidak pernah mengembalikan `null`

**6.** Cara menampilkan foto dari `XFile` yang bekerja di Chrome **dan** di HP adalah ...

- a. `Image.file(File(berkas.path))`
- b. `Image.network(berkas.path)`
- c. `Image.memory(await berkas.readAsBytes())`
- d. `Image.asset(berkas.path)`

**7.** Mengapa `pickImage` dipanggil dengan `maxWidth: 1280` dan `imageQuality: 75`?

- a. Agar foto menjadi lebih tajam daripada aslinya
- b. Karena tanpa keduanya `image_picker` tidak bisa dipakai di web
- c. Agar foto otomatis tersimpan ke galeri
- d. Agar ukuran berkas dan pemakaian memori jauh lebih kecil, sementara foto masih cukup jelas

**8.** Urutan pemeriksaan sebelum mengambil posisi yang dipakai di modul adalah ...

- a. ambil posisi → periksa izin → periksa layanan lokasi
- b. periksa layanan lokasi → periksa (dan bila perlu minta) izin → ambil posisi
- c. periksa izin → ambil posisi → periksa layanan lokasi
- d. minta izin → ambil posisi; layanan lokasi tidak perlu diperiksa

**9.** Posisi yang didapat berakurasi ± 45 m, padahal aturan laporan meminta paling buruk 30 m. Pernyataan yang benar adalah ...

- a. posisinya pasti meleset tepat 45 m
- b. akurasi 45 m lebih baik daripada 30 m, karena angkanya lebih besar
- c. posisi sebenarnya kemungkinan besar berada di dalam lingkaran berjari-jari 45 m di sekitar titik itu, sehingga aturan menolaknya dan pengguna diminta menandai ulang
- d. akurasi hanya berlaku di iPhone

**10.** Mengapa jarak dua koordinat dihitung dengan rumus *haversine*, bukan teorema Pythagoras langsung pada angka derajatnya?

- a. Karena bumi berbentuk bola, dan panjang 1° bujur makin pendek ke arah kutub, sehingga selisih derajat tidak bisa langsung dianggap jarak
- b. Karena Pythagoras hanya berlaku untuk segitiga yang kecil
- c. Karena *haversine* lebih cepat dihitung
- d. Karena `dart:math` tidak punya fungsi akar kuadrat

**11.** `AppLifecycleListener(onResume: ...)` dipakai di Praktikum 3 dan 5 untuk ...

- a. meminta izin setiap kali aplikasi dibuka
- b. mematikan GPS saat aplikasi ditutup
- c. menyimpan foto ke galeri saat aplikasi berpindah ke latar belakang
- d. memeriksa ulang lokasi saat pengguna kembali dari Pengaturan, tanpa perlu mengetuk lagi

**12.** Di browser, izin lokasi situs diblokir. Mengapa aplikasi menampilkan petunjuk "Klik ikon di sebelah kiri alamat situs", bukan tombol **Buka Pengaturan**?

- a. Karena di browser `openAppSettings()` tidak tersedia; izin situs diatur sendiri oleh pengguna lewat browser
- b. Karena tombol tidak bisa ditampilkan di web
- c. Karena izin di browser tidak bisa diubah sama sekali
- d. Karena `kIsWeb` selalu bernilai `false`

**13.** Manfaat utama membungkus `geolocator` dengan kontrak `LayananLokasi` dan membuat `LayananLokasiPalsu` adalah ...

- a. ukuran aplikasi menjadi lebih kecil
- b. GPS menjadi lebih akurat
- c. semua keadaan (diblokir, layanan mati, di luar kampus) bisa dicoba dan diperiksa otomatis tanpa HP dan tanpa mengubah pengaturan
- d. aplikasi tidak perlu lagi meminta izin

**14.** Dalam `tanggapanUntuk`, kegagalan `Dibatalkan` sengaja dipetakan menjadi `null`. Alasannya ...

- a. agar aplikasi tertutup otomatis
- b. karena `Dibatalkan` tidak mungkin terjadi
- c. agar `switch` tidak perlu menangani kasus itu
- d. karena pengguna sendiri yang membatalkan, sehingga pesan galat justru terasa seperti menegur

**15.** Aplikasi presensi di Contoh 08 menyimpan `jarakMeter` dan `akurasiMeter`, tetapi tidak menyimpan lintang dan bujur. Prinsip yang diterapkan adalah ...

- a. menyimpan data sebanyak mungkin untuk berjaga-jaga
- b. mengumpulkan data **seperlunya** (minimisasi data), sesuai prinsip pelindungan data pribadi
- c. koordinat memang tidak bisa disimpan di database
- d. agar aplikasi lebih cepat dibuka

---

## B. Tebak Hasil

**B1.** Program berikut meniru aturan izin Android: penolakan kedua dianggap permanen.

```dart
// Program konsol, jadi print() boleh dipakai.
// ignore_for_file: avoid_print

enum StatusIzin {
  ditolak,
  ditolakPermanen,
  saatDipakai,
  selalu,
  tidakDiketahui,
}

enum Tindakan { nyalakanLayanan, mintaIzin, bukaPengaturan, ambilLokasi }

Tindakan tindakanUntuk({required bool layananAktif, required StatusIzin izin}) {
  if (!layananAktif) return Tindakan.nyalakanLayanan;
  return switch (izin) {
    StatusIzin.ditolak || StatusIzin.tidakDiketahui => Tindakan.mintaIzin,
    StatusIzin.ditolakPermanen => Tindakan.bukaPengaturan,
    StatusIzin.saatDipakai || StatusIzin.selalu => Tindakan.ambilLokasi,
  };
}

/// Meniru aturan Android: penolakan KEDUA dianggap permanen, dan izin yang
/// sudah ditolak permanen tidak lagi menampilkan dialog.
class AndroidPalsu {
  StatusIzin status = StatusIzin.ditolak;
  int penolakan = 0;
  int dialogTampil = 0;

  StatusIzin minta({required bool setuju}) {
    if (status != StatusIzin.ditolak) return status;
    dialogTampil++;
    if (setuju) {
      status = StatusIzin.saatDipakai;
    } else {
      penolakan++;
      if (penolakan >= 2) status = StatusIzin.ditolakPermanen;
    }
    return status;
  }
}

void main() {
  print(
    '1: ${tindakanUntuk(layananAktif: false, izin: StatusIzin.ditolakPermanen).name}',
  );
  print(
    '2: ${tindakanUntuk(layananAktif: true, izin: StatusIzin.tidakDiketahui).name}',
  );

  final AndroidPalsu hp = AndroidPalsu();
  print('3: ${hp.minta(setuju: false).name} ${hp.dialogTampil}');
  print('4: ${hp.minta(setuju: false).name} ${hp.dialogTampil}');
  print('5: ${hp.minta(setuju: true).name} ${hp.dialogTampil}');
  print('6: ${tindakanUntuk(layananAktif: true, izin: hp.status).name}');

  // Pengguna membuka Pengaturan, lalu mengizinkan lokasi di sana.
  hp.status = StatusIzin.saatDipakai;
  print('7: ${tindakanUntuk(layananAktif: true, izin: hp.status).name}');
}
```

- (a) Tuliskan ketujuh baris yang tampil di konsol.
- (b) Pada baris `5:`, pengguna sebenarnya **setuju**, tetapi statusnya tetap `ditolakPermanen` dan `dialogTampil` tidak bertambah. Mengapa? Apa yang harus dilakukan aplikasi sungguhan dalam keadaan ini?
- (c) Pada baris `1:`, izin sudah diblokir, tetapi tindakannya justru `nyalakanLayanan`. Mengapa urutan pemeriksaan di `tindakanUntuk` dibuat begitu?

**B2.** Program berikut menghitung jarak, menulis teks jarak, dan memberi nama arah.

```dart
import 'dart:math';

// Program konsol, jadi print() boleh dipakai.
// ignore_for_file: avoid_print

class Koordinat {
  const Koordinat(this.lintang, this.bujur);

  final double lintang;
  final double bujur;
}

const double jariJariBumiMeter = 6378137.0;

double _radian(double derajat) => derajat * pi / 180;

double jarakMeter(Koordinat a, Koordinat b) {
  final double dLintang = _radian(b.lintang - a.lintang);
  final double dBujur = _radian(b.bujur - a.bujur);
  final double h =
      pow(sin(dLintang / 2), 2) +
      pow(sin(dBujur / 2), 2) *
          cos(_radian(a.lintang)) *
          cos(_radian(b.lintang));
  return jariJariBumiMeter * 2 * asin(sqrt(h));
}

String namaArah(double derajat) {
  const List<String> nama = [
    'utara',
    'timur laut',
    'timur',
    'tenggara',
    'selatan',
    'barat daya',
    'barat',
    'barat laut',
  ];
  return nama[((derajat + 22.5) ~/ 45) % 8];
}

String teksJarak(double meter) {
  if (meter < 1000) return '${meter.round()} m';
  return '${(meter / 1000).toStringAsFixed(1).replaceAll('.', ',')} km';
}

void main() {
  const Koordinat nol = Koordinat(0, 0);
  print('1: ${teksJarak(jarakMeter(nol, const Koordinat(0, 1)))}');
  print('2: ${teksJarak(jarakMeter(nol, const Koordinat(1, 0)))}');
  print(
    '3: ${teksJarak(jarakMeter(const Koordinat(-60, 0), const Koordinat(-60, 1)))}',
  );
  print('4: ${teksJarak(999.6)} | ${teksJarak(1000)} | ${teksJarak(1049)}');
  print(
    '5: ${namaArah(359)} | ${namaArah(22.5)} | ${namaArah(337.4)} | '
    '${namaArah(180)}',
  );
}
```

- (a) Tuliskan kelima baris yang tampil di konsol.
- (b) Baris `1:` dan `3:` sama-sama mengukur selisih **1° bujur**, tetapi jaraknya berbeda jauh. Mengapa?
- (c) `teksJarak(999.6)` menghasilkan teks yang janggal. Jelaskan penyebabnya, lalu perbaiki `teksJarak` tanpa mengubah hasil untuk angka lain.

**B3.** Program berikut meniru tombol **Galeri** di Praktikum 2, lengkap dengan penjaga dan batas tiga foto.

```dart
// Program konsol, jadi print() boleh dipakai.
// ignore_for_file: avoid_print

/// Pemilih foto palsu. Seperti di browser, limit diabaikan: yang kembali
/// selalu empat foto, kecuali pengguna membatalkan.
class PemilihPalsu {
  int dibuka = 0;
  bool batal = false;

  Future<List<String>> pilih({required int limit}) async {
    dibuka++;
    await Future<void>.delayed(const Duration(milliseconds: 10));
    if (batal) return [];
    return ['a.jpg', 'b.jpg', 'c.jpg', 'd.jpg'];
  }
}

class FormFoto {
  FormFoto(this.pemilih);

  final PemilihPalsu pemilih;
  final List<String> foto = [];
  final List<String> pesan = [];
  bool sibuk = false;

  int get sisa => 3 - foto.length;

  Future<void> galeri() async {
    if (sibuk || sisa == 0) return;
    sibuk = true;
    try {
      final List<String> dipilih = await pemilih.pilih(limit: sisa);
      if (dipilih.isEmpty) {
        pesan.add('batal');
        return;
      }
      final List<String> baru = dipilih.take(sisa).toList();
      foto.addAll(baru);
      if (dipilih.length > baru.length) {
        pesan.add('dipotong ${dipilih.length - baru.length}');
      }
    } finally {
      sibuk = false;
    }
  }
}

Future<void> main() async {
  final PemilihPalsu pemilih = PemilihPalsu();
  final FormFoto form = FormFoto(pemilih);

  await Future.wait([form.galeri(), form.galeri()]);
  print('1: ${form.foto} dibuka ${pemilih.dibuka} ${form.pesan}');

  await form.galeri();
  print('2: ${form.foto} dibuka ${pemilih.dibuka}');

  form.foto.removeAt(1);
  pemilih.batal = true;
  await form.galeri();
  print('3: ${form.foto} dibuka ${pemilih.dibuka} ${form.pesan}');

  pemilih.batal = false;
  await form.galeri();
  print('4: ${form.foto} dibuka ${pemilih.dibuka} ${form.pesan}');
}
```

- (a) Tuliskan keempat baris yang tampil di konsol.
- (b) Pada baris `1:`, `galeri()` dipanggil dua kali, tetapi pemilih hanya dibuka **sekali**. Baris mana yang menyebabkannya, dan mengapa baris itu bekerja walaupun kedua panggilan dimulai hampir bersamaan?
- (c) Apa yang terjadi pada tombol di aplikasi sungguhan jika blok `finally` dihapus, lalu pemilih foto melempar *exception* sekali saja?

**B4.** Program berikut mengubah kegagalan menjadi pesan dan tombol, di HP maupun di browser.

```dart
// Program konsol, jadi print() boleh dipakai.
// ignore_for_file: avoid_print

enum Fitur { lokasi, kamera }

sealed class Kegagalan {
  const Kegagalan();
}

final class LayananMati extends Kegagalan {
  const LayananMati();
}

final class IzinDitolak extends Kegagalan {
  const IzinDitolak(this.fitur);
  final Fitur fitur;
}

final class IzinDiblokir extends Kegagalan {
  const IzinDiblokir(this.fitur);
  final Fitur fitur;
}

final class Dibatalkan extends Kegagalan {
  const Dibatalkan();
}

final class WaktuHabis extends Kegagalan {
  const WaktuHabis();
}

enum Aksi { tidakAda, cobaLagi, bukaPengaturan, nyalakanLokasi }

/// Satu-satunya tempat yang mengubah kegagalan menjadi pesan dan aksi.
(String, Aksi)? tanggapanUntuk(Kegagalan k) {
  return switch (k) {
    Dibatalkan() => null,
    LayananMati() => ('Layanan lokasi mati.', Aksi.nyalakanLokasi),
    IzinDitolak(:final Fitur fitur) => (
      'Izin ${fitur.name} belum diberikan.',
      Aksi.cobaLagi,
    ),
    IzinDiblokir(:final Fitur fitur) => (
      'Izin ${fitur.name} diblokir.',
      Aksi.bukaPengaturan,
    ),
    WaktuHabis() => ('Lokasi belum didapat.', Aksi.cobaLagi),
  };
}

String tampilan(Kegagalan k, {required bool diBrowser}) {
  final (String, Aksi)? t = tanggapanUntuk(k);
  if (t == null) return '(tanpa pesan)';
  final (String pesan, Aksi aksi) = t;
  final bool lewatPengaturan =
      aksi == Aksi.bukaPengaturan || aksi == Aksi.nyalakanLokasi;
  if (lewatPengaturan && diBrowser) return '$pesan [petunjuk ikon situs]';
  return switch (aksi) {
    Aksi.tidakAda => pesan,
    Aksi.cobaLagi => '$pesan [Coba lagi]',
    Aksi.bukaPengaturan => '$pesan [Buka Pengaturan]',
    Aksi.nyalakanLokasi => '$pesan [Nyalakan lokasi]',
  };
}

void main() {
  const List<Kegagalan> semua = [
    Dibatalkan(),
    IzinDitolak(Fitur.lokasi),
    IzinDiblokir(Fitur.kamera),
    LayananMati(),
    WaktuHabis(),
  ];
  int nomor = 0;
  for (final Kegagalan k in semua) {
    nomor++;
    print(
      '$nomor: ${tampilan(k, diBrowser: false)} | '
      '${tampilan(k, diBrowser: true)}',
    );
  }
}
```

- (a) Tuliskan kelima baris yang tampil di konsol.
- (b) Baris `4:` versi browser sebenarnya **tidak pernah** dilihat pengguna sungguhan. Mengapa? (Petunjuk: `isLocationServiceEnabled()` di web.)
- (c) Tambahkan `final class GangguanPerangkat extends Kegagalan` tanpa mengubah `tanggapanUntuk`. Apa yang terjadi saat program dijalankan, dan mengapa hal itu justru menguntungkan?

**B5.** Program Flutter berikut meniru `kembaliKeAplikasi()` dari Praktikum 5. Hasilnya tampil di konsol.

```dart
import 'package:flutter/material.dart';

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

enum Skenario { berhasil, diblokir, layananMati, waktuHabis }

class LokasiPalsu {
  Skenario skenario = Skenario.diblokir;
  int dipanggil = 0;

  Future<Hasil<String>> posisi() async {
    dipanggil++;
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return switch (skenario) {
      Skenario.berhasil => const Berhasil('Gedung A'),
      Skenario.diblokir => const Gagal('diblokir'),
      Skenario.layananMati => const Gagal('layanan mati'),
      Skenario.waktuHabis => const Gagal('waktu habis'),
    };
  }
}

class Perintah<T> extends ChangeNotifier {
  Perintah(this._aksi);

  final Future<Hasil<T>> Function() _aksi;
  bool sedangBerjalan = false;
  Hasil<T>? hasil;

  Future<void> jalankan() async {
    if (sedangBerjalan) return;
    sedangBerjalan = true;
    hasil = null;
    notifyListeners();
    try {
      hasil = await _aksi();
    } finally {
      sedangBerjalan = false;
      notifyListeners();
    }
  }
}

class LokasiViewModel {
  LokasiViewModel(this._lokasi) {
    tandai = Perintah<String>(_lokasi.posisi);
  }

  final LokasiPalsu _lokasi;
  late final Perintah<String> tandai;

  /// Dipanggil oleh AppLifecycleListener(onResume: ...).
  Future<void> kembaliKeAplikasi() async {
    final Hasil<String>? h = tandai.hasil;
    if (h is Gagal<String> &&
        (h.alasan == 'diblokir' || h.alasan == 'layanan mati')) {
      await tandai.jalankan();
    }
  }
}

String teks(Hasil<String>? h) {
  return switch (h) {
    null => '-',
    Berhasil(:final String nilai) => 'di $nilai',
    Gagal(:final String alasan) => alasan,
  };
}

Future<void> main() async {
  final LokasiPalsu lokasi = LokasiPalsu();
  final LokasiViewModel vm = LokasiViewModel(lokasi);

  await vm.tandai.jalankan();
  debugPrint('1: ${teks(vm.tandai.hasil)} ${lokasi.dipanggil}');

  await vm.kembaliKeAplikasi(); // izinnya masih diblokir
  debugPrint('2: ${teks(vm.tandai.hasil)} ${lokasi.dipanggil}');

  lokasi.skenario = Skenario.berhasil; // diizinkan di Pengaturan
  await vm.kembaliKeAplikasi();
  debugPrint('3: ${teks(vm.tandai.hasil)} ${lokasi.dipanggil}');

  await vm.kembaliKeAplikasi();
  debugPrint('4: ${teks(vm.tandai.hasil)} ${lokasi.dipanggil}');

  lokasi.skenario = Skenario.waktuHabis;
  final Future<void> ketukan = vm.tandai.jalankan();
  final Future<void> kembali = vm.kembaliKeAplikasi();
  await Future.wait([ketukan, kembali]);
  debugPrint('5: ${teks(vm.tandai.hasil)} ${lokasi.dipanggil}');

  runApp(
    const MaterialApp(
      home: Scaffold(body: Center(child: Text('Lihat konsol'))),
    ),
  );
}
```

- (a) Tuliskan kelima baris yang tampil di konsol.
- (b) Mengapa `dipanggil` pada baris `4:` tetap 3?
- (c) Pada baris `5:`, `kembaliKeAplikasi()` dipanggil saat `tandai` **sedang berjalan**, tetapi layanan lokasi tidak dipanggil dua kali. Ada dua alasan yang masing-masing sudah cukup. Sebutkan keduanya.

<details>
<summary>💡 Petunjuk Bagian B</summary>

B1: Bagian 2.3–2.5. B2: Bagian 6.1–6.3; untuk `teksJarak`, perhatikan kapan `round()` dipanggil. B3: Bagian 4.3 dan 4.7; penjaga diperiksa **sebelum** `await` pertama. B4: Bagian 3.4 dan 9.6. B5: Bagian 5.6 dan 10.6, serta Perintah di Pertemuan 12 Bagian 8.
</details>

---

## C. Temukan dan Perbaiki Kesalahannya

Setiap kode berikut mengandung **dua** kesalahan. Untuk setiap kesalahan, jelaskan **pesan atau gejalanya**, **penyebabnya**, dan **perbaikannya**.

**C1.** Halaman "Foto Profil" seharusnya menampilkan foto yang dipilih di dalam lingkaran. Di Chrome, setelah foto dipilih, lingkarannya **tetap kosong** dan konsol menampilkan galat yang diawali `Unsupported operation`. Selain itu, jika jendela pemilih ditutup tanpa memilih apa pun, konsol menampilkan galat lain.

```dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HalamanFotoProfil(),
    ),
  );
}

class HalamanFotoProfil extends StatefulWidget {
  const HalamanFotoProfil({super.key});

  @override
  State<HalamanFotoProfil> createState() => _HalamanFotoProfilState();
}

class _HalamanFotoProfilState extends State<HalamanFotoProfil> {
  final ImagePicker _pemilih = ImagePicker();
  String? _jalur;

  Future<void> _pilih() async {
    final XFile? berkas = await _pemilih.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
      imageQuality: 80,
    );
    setState(() => _jalur = berkas!.path);
  }

  @override
  Widget build(BuildContext context) {
    final String? jalur = _jalur;
    return Scaffold(
      appBar: AppBar(title: const Text('Foto Profil')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 64,
              backgroundImage: jalur == null ? null : FileImage(File(jalur)),
              child: jalur == null ? const Icon(Icons.person, size: 64) : null,
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: _pilih, child: const Text('Pilih foto')),
          ],
        ),
      ),
    );
  }
}
```

**C2.** Halaman "Jarak ke Perpustakaan" bekerja dengan baik saat izin diberikan. Namun setelah izin lokasi **diblokir** (di Chrome: ikon di sebelah kiri alamat situs → Lokasi → Blokir), tombolnya berubah menjadi **Mencari...** dan tidak pernah kembali, sementara konsol menampilkan galat bahwa izin lokasi ditolak (di Chrome biasanya berbunyi `User denied Geolocation`).

```dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HalamanJarak(),
    ),
  );
}

class HalamanJarak extends StatefulWidget {
  const HalamanJarak({super.key});

  @override
  State<HalamanJarak> createState() => _HalamanJarakState();
}

class _HalamanJarakState extends State<HalamanJarak> {
  bool _mencari = false;
  String _teks = 'Ketuk tombol untuk mengukur jarak ke perpustakaan.';

  Future<void> _ukur() async {
    setState(() => _mencari = true);
    LocationPermission izin = await Geolocator.checkPermission();
    if (izin == LocationPermission.denied) {
      izin = await Geolocator.requestPermission();
    }
    if (izin == LocationPermission.denied) {
      setState(() {
        _mencari = false;
        _teks = 'Izin lokasi belum diberikan.';
      });
      return;
    }
    final Position p = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 15),
      ),
    );
    final double jarak = Geolocator.distanceBetween(
      p.latitude,
      p.longitude,
      -0.4697,
      117.1611,
    );
    setState(() {
      _mencari = false;
      _teks = 'Perpustakaan berjarak ${jarak.round()} m dari Anda.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jarak ke Perpustakaan')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_teks, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _mencari ? null : _ukur,
                child: Text(_mencari ? 'Mencari...' : 'Ukur jarak'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

**C3.** Aplikasi "Absen Kelas" menolak kehadiran yang lebih dari 100 m dari ruang kelas. Konsol menunjukkan dua pemeriksaan `GAGAL`. Di layar, pilih chip **Di kantin** lalu ketuk **Saya hadir** beberapa kali: kehadirannya ditolak, tetapi angka "Kehadiran tercatat" terus bertambah.

```text
LULUS  Di kelas -> tercatat
LULUS  Di kantin -> ditolak aturan
GAGAL  Di kantin -> tidak tercatat: diharapkan 1, hasilnya 2
GAGAL  Izin diblokir -> tombol Buka Pengaturan: diharapkan Aksi.bukaPengaturan, hasilnya Aksi.cobaLagi
LULUS  Layanan mati -> tombol Nyalakan lokasi
Ringkasan: 3 dari 5 uji lulus
```

```dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await jalankanUji();
  runApp(
    MultiProvider(
      providers: [
        Provider<LayananLokasiPalsu>(create: (_) => LayananLokasiPalsu()),
        Provider<RepositoriHadirMemori>(create: (_) => RepositoriHadirMemori()),
        ChangeNotifierProvider(
          create: (BuildContext context) => HadirViewModel(
            lokasi: context.read<LayananLokasiPalsu>(),
            repositori: context.read<RepositoriHadirMemori>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: const HalamanHadir(),
      ),
    ),
  );
}

// ------------------------------- DOMAIN -------------------------------

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

final class IzinDiblokir extends Kegagalan {
  const IzinDiblokir();
}

final class LayananLokasiMati extends Kegagalan {
  const LayananLokasiMati();
}

final class AturanDilanggar extends Kegagalan {
  const AturanDilanggar(this.alasan);
  final String alasan;
}

class Titik {
  const Titik(this.lintang, this.bujur);

  final double lintang;
  final double bujur;
}

double _radian(double derajat) => derajat * pi / 180;

double jarakMeter(Titik a, Titik b) {
  final double dLintang = _radian(b.lintang - a.lintang);
  final double dBujur = _radian(b.bujur - a.bujur);
  final double h =
      pow(sin(dLintang / 2), 2) +
      pow(sin(dBujur / 2), 2) *
          cos(_radian(a.lintang)) *
          cos(_radian(b.lintang));
  return 6378137.0 * 2 * asin(sqrt(h));
}

const Titik ruangKelas = Titik(-0.4703, 117.1584);
const double radiusMeter = 100;

/// Aturan: kehadiran hanya sah dalam radius 100 m dari ruang kelas.
String? periksaJarak(double jarak) {
  if (jarak <= radiusMeter) return null;
  return 'Anda berada ${jarak.round()} m dari ruang kelas '
      '(paling jauh ${radiusMeter.round()} m).';
}

abstract interface class LayananLokasi {
  Future<Hasil<Titik>> posisiSekarang();
}

abstract interface class RepositoriHadir {
  Future<void> simpan(double jarakMeter);
}

// ----------------------------- DATA PALSU -----------------------------

enum Skenario {
  diKelas('Di kelas'),
  diKantin('Di kantin'),
  diblokir('Izin diblokir'),
  layananMati('Layanan mati');

  const Skenario(this.label);
  final String label;
}

class LayananLokasiPalsu implements LayananLokasi {
  Skenario skenario = Skenario.diKelas;

  @override
  Future<Hasil<Titik>> posisiSekarang() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return switch (skenario) {
      Skenario.diKelas => const Berhasil(Titik(-0.47031, 117.15842)),
      Skenario.diKantin => const Berhasil(Titik(-0.4762, 117.1630)),
      Skenario.diblokir => const Gagal(IzinDiblokir()),
      Skenario.layananMati => const Gagal(LayananLokasiMati()),
    };
  }
}

class RepositoriHadirMemori implements RepositoriHadir {
  final List<double> semua = [];

  @override
  Future<void> simpan(double jarakMeter) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    semua.add(jarakMeter);
  }
}

// --------------------------------- UI ---------------------------------

class Perintah0<T> extends ChangeNotifier {
  Perintah0(this._aksi);

  final Future<Hasil<T>> Function() _aksi;
  bool sedangBerjalan = false;
  Hasil<T>? hasil;

  Future<void> jalankan() async {
    if (sedangBerjalan) return;
    sedangBerjalan = true;
    hasil = null;
    notifyListeners();
    try {
      hasil = await _aksi();
    } finally {
      sedangBerjalan = false;
      notifyListeners();
    }
  }
}

enum Aksi { tidakAda, cobaLagi, bukaPengaturan, nyalakanLokasi }

class Tanggapan {
  const Tanggapan(this.pesan, this.aksi);
  final String pesan;
  final Aksi aksi;
}

Tanggapan tanggapanUntuk(Kegagalan kegagalan) {
  return switch (kegagalan) {
    IzinDiblokir() => const Tanggapan('Izin lokasi diblokir.', Aksi.cobaLagi),
    LayananLokasiMati() => const Tanggapan(
      'Layanan lokasi mati.',
      Aksi.nyalakanLokasi,
    ),
    AturanDilanggar(:final String alasan) => Tanggapan(alasan, Aksi.tidakAda),
  };
}

class HadirViewModel extends ChangeNotifier {
  HadirViewModel({required this._lokasi, required this._repositori}) {
    hadir = Perintah0<double>(_hadir);
  }

  final LayananLokasi _lokasi;
  final RepositoriHadir _repositori;
  late final Perintah0<double> hadir;

  Future<Hasil<double>> _hadir() async {
    final Hasil<Titik> posisi = await _lokasi.posisiSekarang();
    final Titik titik;
    switch (posisi) {
      case Gagal(:final Kegagalan kegagalan):
        return Gagal(kegagalan);
      case Berhasil(:final Titik nilai):
        titik = nilai;
    }
    final double jarak = jarakMeter(titik, ruangKelas);
    await _repositori.simpan(jarak);
    final String? alasan = periksaJarak(jarak);
    if (alasan != null) return Gagal(AturanDilanggar(alasan));
    return Berhasil(jarak);
  }

  @override
  void dispose() {
    hadir.dispose();
    super.dispose();
  }
}

class HalamanHadir extends StatefulWidget {
  const HalamanHadir({super.key});

  @override
  State<HalamanHadir> createState() => _HalamanHadirState();
}

class _HalamanHadirState extends State<HalamanHadir> {
  @override
  Widget build(BuildContext context) {
    final HadirViewModel vm = context.watch<HadirViewModel>();
    final LayananLokasiPalsu lokasi = context.watch<LayananLokasiPalsu>();
    final RepositoriHadirMemori repo = context.watch<RepositoriHadirMemori>();
    return Scaffold(
      appBar: AppBar(title: const Text('Absen Kelas')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Wrap(
            spacing: 6,
            children: [
              for (final Skenario s in Skenario.values)
                ChoiceChip(
                  label: Text(s.label),
                  selected: lokasi.skenario == s,
                  onSelected: (_) => setState(() => lokasi.skenario = s),
                ),
            ],
          ),
          const SizedBox(height: 16),
          ListenableBuilder(
            listenable: vm.hadir,
            builder: (BuildContext context, _) {
              final Hasil<double>? h = vm.hadir.hasil;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                    onPressed: vm.hadir.sedangBerjalan
                        ? null
                        : vm.hadir.jalankan,
                    child: Text(
                      vm.hadir.sedangBerjalan ? 'Memeriksa...' : 'Saya hadir',
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (h is Berhasil<double>)
                    Text('Hadir, ${h.nilai.round()} m dari ruang kelas.'),
                  if (h is Gagal<double>)
                    Text(
                      '${tanggapanUntuk(h.kegagalan).pesan} '
                      '[${tanggapanUntuk(h.kegagalan).aksi.name}]',
                    ),
                  Text('Kehadiran tercatat: ${repo.semua.length} kali'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// ----------------------------- PEMERIKSAAN -----------------------------

int _lulus = 0;
int _jumlah = 0;

void periksa(String nama, Object? didapat, Object? diharapkan) {
  _jumlah++;
  if (didapat == diharapkan) {
    _lulus++;
    debugPrint('LULUS  $nama');
  } else {
    debugPrint('GAGAL  $nama: diharapkan $diharapkan, hasilnya $didapat');
  }
}

Future<void> jalankanUji() async {
  final LayananLokasiPalsu lokasi = LayananLokasiPalsu();
  final RepositoriHadirMemori repo = RepositoriHadirMemori();
  final HadirViewModel vm = HadirViewModel(lokasi: lokasi, repositori: repo);

  await vm.hadir.jalankan();
  periksa('Di kelas -> tercatat', repo.semua.length, 1);

  lokasi.skenario = Skenario.diKantin;
  await vm.hadir.jalankan();
  final Hasil<double>? ditolak = vm.hadir.hasil;
  periksa(
    'Di kantin -> ditolak aturan',
    ditolak is Gagal<double> && ditolak.kegagalan is AturanDilanggar,
    true,
  );
  periksa('Di kantin -> tidak tercatat', repo.semua.length, 1);

  lokasi.skenario = Skenario.diblokir;
  await vm.hadir.jalankan();
  final Hasil<double>? diblokir = vm.hadir.hasil;
  periksa(
    'Izin diblokir -> tombol Buka Pengaturan',
    diblokir is Gagal<double> ? tanggapanUntuk(diblokir.kegagalan).aksi : null,
    Aksi.bukaPengaturan,
  );

  lokasi.skenario = Skenario.layananMati;
  await vm.hadir.jalankan();
  final Hasil<double>? mati = vm.hadir.hasil;
  periksa(
    'Layanan mati -> tombol Nyalakan lokasi',
    mati is Gagal<double> ? tanggapanUntuk(mati.kegagalan).aksi : null,
    Aksi.nyalakanLokasi,
  );
  debugPrint('Ringkasan: $_lulus dari $_jumlah uji lulus');
}
```

<details>
<summary>💡 Petunjuk Bagian C</summary>

C1: Bagian 3.4 (perilaku `XFile.path` di web) dan 4.3–4.4. C2: Bagian 2.3, 5.3, dan 5.4; perhatikan juga apa yang terjadi pada `_mencari` jika ada *exception*. C3: Bagian 9.6 dan 10.3 (urutan langkah: aturan diperiksa **sebelum** menyimpan).
</details>

---

## D. Menulis Program

Kerjakan setiap soal sebagai **program utuh** yang bisa dijalankan. Ikuti aturan hari ini: izin diminta saat fiturnya dipakai, setiap kemungkinan hasil punya pesan, dan nama paket perangkat hanya muncul di implementasi asli. Setiap program memiliki fungsi `jalankanUji()` yang mencetak `LULUS` atau `GAGAL`; pada aplikasi Flutter, fungsi ini dijalankan sebelum `runApp` di lingkungan pengembangan. Seperti [Contoh 08](kode/contoh_08_studi_kasus_presensi.dart), beri setiap bagian judul `// ===== BERKAS: lib/... =====`.

**D1 — Antar Makanan Kantin.** Kantin kampus melayani pesan antar di sekitar kampus. Tulis aturannya sebagai program **Dart murni** (tanpa Flutter), lengkap dengan `main()` yang mencetak tabel hasil untuk minimal **6** titik pemesan rekaan.

- Kantin berada di `-0.4705, 117.1572`. Jarak dihitung dengan rumus *haversine* dari Praktikum 1.
- **Ongkos antar:** paling jauh 300 m **gratis**; lebih dari 300 m sampai 1 km **Rp3.000**; lebih dari 1 km sampai 2 km **Rp6.000**; lebih dari 2 km **ditolak** dengan alasan `Di luar jangkauan antar (paling jauh 2 km).`
- **Lokasi pemesan** ditolak jika berasal dari pemalsu GPS, atau akurasinya lebih buruk dari 50 m.
- **Jam buka:** Senin–Jumat, mulai pukul 07.00 sampai **sebelum** 16.00. Di luar itu ditolak dengan alasan `Kantin buka Senin–Jumat pukul 07.00–16.00.` Waktu "sekarang" disuntikkan sebagai parameter.
- **Perkiraan waktu antar:** 5 menit persiapan ditambah waktu jalan kurir (70 m per menit), lalu dibulatkan **ke atas** ke kelipatan 5 menit. Contoh: 450 m → 5 + 6,4 = 11,4 → **15 menit**.
- Hasil pemeriksaan berupa `sealed class` dengan dua bentuk: diterima (ongkos, perkiraan menit, dan arah kurir dari kantin, misalnya `timur laut`) atau ditolak (alasan). Urutan pemeriksaan: jam buka → lokasi palsu → akurasi → jarak.
- `jalankanUji()` minimal **10** pemeriksaan, termasuk tepat 300 m, tepat 2 km, pukul 15.59 dan 16.00, hari Sabtu, serta contoh 450 m di atas.

<details>
<summary>💡 Petunjuk D1</summary>

Ikuti Praktikum 1 di Jobsheet. Untuk membuat titik yang berjarak tepat sekian meter ke utara, ingat bahwa 1° lintang sekitar 111.319,5 m pada jari-jari 6.378.137 m, jadi 300 m ke utara kurang lebih `300 / 111319.49` derajat. Pembulatan ke atas ke kelipatan 5: `(menit / 5).ceil() * 5`. Hari kerja: `waktu.weekday <= DateTime.friday`. Format rupiah boleh disalin dari `Rupiah` di [Jobsheet Pertemuan 12](../pertemuan_12_clean_architecture/JOBSHEET.md#langkah-1--objek-nilai-rupiah-ketik-sendiri).
</details>

**D2 — Galeri Kegiatan UKM.** Buat aplikasi Flutter untuk mengumpulkan foto dokumentasi kegiatan Unit Kegiatan Mahasiswa (UKM) sebelum diunggah.

- Paling banyak **12** foto. Tombol **Galeri** memakai `pickMultiImage` dengan `limit` sesuai sisa slot, dan tombol **Kamera** (hanya jika didukung) mengambil satu foto. Semua foto dikecilkan dengan `maxWidth: 1600` dan `imageQuality: 80`.
- Foto ditampilkan dalam *grid* 3 kolom, memakai `cacheWidth` yang sesuai. Ketukan pada foto membuka pratinjau besar yang bisa diperbesar (`InteractiveViewer`), dan setiap foto bisa dihapus.
- Tampilkan jumlah foto dan total ukurannya. Total ukuran paling besar **10 MB**: foto yang membuat total melewati batas dilewati dengan pesan yang jelas.
- Kontrak `PemilihFoto` dengan implementasi `image_picker` dan implementasi palsu berskenario (minimal **berhasil**, **dibatalkan**, **akses ditolak**, dan **tanpa kamera**). Batal tidak diberi pesan; kode galat diterjemahkan menjadi `Kegagalan`, lalu menjadi pesan oleh **satu** fungsi `tanggapanUntuk`.
- ViewModel memakai `Perintah1<..., bool>` untuk mengambil foto, sehingga pemilih tidak bisa terbuka dua kali. Dua lingkungan dipilih dengan satu konstanta; lingkungan pengembangan menampilkan pita "DATA PALSU" dan chip skenario.
- `jalankanUji()` minimal **6** pemeriksaan: batas 12 foto dari galeri, batas 10 MB, batal tanpa pesan, akses ditolak menjadi pesan dengan tombol Pengaturan, perangkat tanpa kamera menyembunyikan tombol Kamera, dan dua ketukan cepat hanya membuka pemilih sekali.
- Lolos uji di lebar **360** dalam mode terang dan gelap.

<details>
<summary>💡 Petunjuk D2</summary>

Ikuti Praktikum 2 dan 4 di Jobsheet. *Grid* bisa dibuat dengan `GridView.count(crossAxisCount: 3, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), ...)` di dalam `ListView`, atau `SliverGrid` di dalam `CustomScrollView`. Lebar satu kotak kira-kira (360 − jarak) ÷ 3, jadi `cacheWidth` sekitar 3 × lebar itu. Untuk foto palsu, ukuran bisa ditiru dengan `Uint8List(ukuran)`, lalu tampilkan ikon pengganti lewat `errorBuilder` seperti Praktikum 5.
</details>

**D3 — Fasilitas Terdekat.** Buat aplikasi Flutter yang menampilkan fasilitas kampus dan mengurutkannya dari lokasi pengguna.

- Minimal **8** fasilitas rekaan (nama, kategori, dan koordinat), dengan kategori `enum`: ibadah, makan, belajar, transportasi, dan kesehatan. Saring dengan `ChoiceChip` per kategori.
- Sebelum lokasi diketahui, daftar diurutkan menurut **abjad**, dengan kartu ajakan "Urutkan dari lokasi saya" yang menjelaskan alasan lokasi dibutuhkan ([Modul Bagian 7.2](README.md#72-jelaskan-dulu-di-layar-sendiri)). Izin baru diminta saat tombol di kartu itu diketuk.
- Setelah lokasi didapat, daftar diurutkan menurut **jarak**, dan setiap baris menampilkan jarak serta arah, misalnya `350 m · timur laut`. Jika akurasinya lebih buruk dari 100 m, tampilkan peringatan bahwa urutannya mungkin kurang tepat, tetapi tetap urutkan.
- Ketukan pada satu fasilitas membuka **petunjuk jalan kaki** di Google Maps dengan `url_launcher`. Jika gagal dibuka, tampilkan `SnackBar`.
- Semua keadaan punya pesan: izin ditolak (daftar tetap tampil menurut abjad, dengan tombol **Coba lagi**), diblokir (tombol Pengaturan, atau petunjuk ikon situs di browser), layanan mati, dan waktu habis. Kembali dari Pengaturan, lokasi diperiksa ulang.
- Kontrak `LayananLokasi` dan `PembukaPeta`, masing-masing dengan implementasi asli dan palsu. `LayananLokasiPalsu` minimal punya 5 skenario; `PembukaPetaPalsu` mencatat alamat terakhir yang diminta (mata-mata).
- `jalankanUji()` minimal **8** pemeriksaan: urutan abjad, urutan jarak, teks jarak dan arah, peringatan akurasi, saringan kategori, izin ditolak tetap menampilkan daftar, izin diblokir memberi tombol Pengaturan, dan alamat peta yang diminta.

<details>
<summary>💡 Petunjuk D3</summary>

Ikuti Contoh 05 (alur izin yang sopan) dan Bagian 13 (`petunjukArah`). Urutan menurut jarak cukup dihitung di ViewModel dengan `sort((a, b) => jarak(a).compareTo(jarak(b)))` pada **salinan** daftar, bukan daftar aslinya. Simpan hasil jarak dalam sebuah *record* atau *class* kecil, misalnya `({Fasilitas fasilitas, double jarak, String arah})`, agar tidak dihitung berulang-ulang saat digambar.
</details>

---

[⬅️ Kembali ke Modul](README.md) · [🧪 Jobsheet](JOBSHEET.md) · [🏠 Beranda](../README.md)

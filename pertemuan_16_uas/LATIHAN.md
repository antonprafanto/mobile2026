# ✍️ Latihan Persiapan UAS — Pertemuan 16

[🏠 Beranda](../README.md) · [📝 Panduan UAS](README.md) · [🎯 Gladi Resik](GLADI_RESIK.md)

Latihan ini menyiapkan Anda untuk **tanya jawab** UAS. Bagian A dan B dikerjakan **tanpa membuka modul**. Bagian C melatih penalaran "bagaimana jika". Bagian D melatih **ubah kecil langsung**, sesuatu yang bisa diminta penguji ([Panduan UAS Bagian 7.4](README.md#74-ubah-kecil-langsung)). Bagian E adalah penilaian diri dengan rubrik UAS.

| Bagian | Isi | Tempat mengerjakan |
| :--- | :--- | :--- |
| A | 15 soal pilihan ganda | Kertas atau catatan |
| B | Menjelaskan potongan kode, seperti saat ditanya penguji | Kertas, lalu ucapkan jawabannya dengan suara keras |
| C | Enam situasi "bagaimana jika" | Kertas |
| D | Tujuh perubahan kecil pada Contoh 02 dan 03, dengan batas waktu | [DartPad](https://dartpad.dev) atau proyek latihan (D6 dan D7 wajib proyek latihan) |
| E | Menilai proyek sendiri dengan rubrik | Bersama tim |

**Proyek latihan** (untuk bagian D):

```bash
flutter create latihan_p16
```

Salin [Contoh 02](kode/contoh_02_pengatur_waktu_presentasi.dart) ke `lib/pengatur_waktu.dart` dan [Contoh 03](kode/contoh_03_kartu_latihan_tanya_jawab.dart) ke `lib/kartu_latihan.dart`, lalu jalankan salah satunya dengan opsi `-t` ([Pertemuan 15, Bagian 3.7](../pertemuan_15_build_rilis_dan_finalisasi/README.md#37-dua-titik-masuk-atau---dart-define)):

```bash
flutter run -d chrome -t lib/pengatur_waktu.dart
```

> [!NOTE]
> Kunci jawaban tidak dipublikasikan. Petunjuk (💡) menunjukkan **bagian modul** yang relevan. Nama orang, aplikasi, dan data dalam soal hanyalah **rekaan** untuk latihan.

---

## A. Pilihan Ganda

**1.** Menurut Panduan UAS, bagian yang paling menentukan nilai saat UAS adalah ...

- a. slide yang lengkap dan penuh teks
- b. jumlah fitur sebanyak-banyaknya, walaupun sebagian belum selesai
- c. video demo cadangan yang diputar sejak awal
- d. aplikasi yang didemokan langsung dan pemahaman setiap anggota tentang kodenya

**2.** Nilai tim sebuah proyek adalah 70. Seorang anggota mendapat faktor individu 0,8 dan nilai presentasi 12. Nilai proyek akhirnya adalah ...

- a. 82,0
- b. 68,0
- c. 65,6
- d. 56,0

**3.** Penguji meminta, "Matikan internetnya, lalu muat ulang." Tampilan yang paling diharapkan adalah ...

- a. pesan yang ramah dan tombol **Coba lagi**; data yang sudah tersimpan tetap tampil
- b. layar merah berisi *stack trace*, karena itu bukti aplikasi jujur
- c. indikator memuat yang berputar terus sampai internet kembali
- d. aplikasi menutup diri agar tidak terjadi galat

**4.** Aplikasi didemokan sebagai versi web di Chrome. Cara meniru "internet mati" adalah ...

- a. menekan `Ctrl` + `Shift` + `M`
- b. menutup tab lalu membukanya lagi
- c. membuka DevTools (`F12`), tab **Network**, lalu mengubah *No throttling* menjadi **Offline**
- d. menjalankan `flutter run --release`

**5.** Di Contoh 02, sisa waktu dihitung dari **selisih jam**, bukan dengan mengurangi satu detik setiap kali `Timer` berdetak. Alasannya ...

- a. agar kodenya lebih pendek
- b. karena `Timer.periodic` tidak bisa memanggil fungsi
- c. karena `DateTime.now` hanya tersedia di web
- d. agar angkanya tetap tepat walaupun detak `Timer` tertunda atau terlewat

**6.** `PengaturWaktuViewModel` menerima parameter `DateTime Function()? jam`. Manfaat utamanya adalah ...

- a. tes bisa memakai jam palsu, sehingga "tujuh menit" bisa diuji tanpa menunggu
- b. aplikasi berjalan lebih cepat
- c. zona waktu berganti otomatis
- d. `Timer` tidak perlu dibatalkan di `dispose`

**7.** Penguji bertanya, "Apa akibatnya jika `if (!mounted) return;` setelah `await` ini dihapus?" Jawaban yang tepat adalah ...

- a. tidak ada akibatnya, baris itu hanya penanda
- b. aplikasi tidak bisa dikompilasi
- c. jika halaman sudah ditutup saat `await` selesai, kode memakai `context` atau `setState` milik halaman yang sudah tidak ada, sehingga muncul galat
- d. data tidak tersimpan ke database

**8.** Data berikut yang paling tepat disimpan dengan `shared_preferences` adalah ...

- a. 500 catatan kuliah yang perlu dicari dan diubah
- b. pilihan mode gelap
- c. token *login*
- d. foto profil berukuran besar

**9.** Agar aman dari *SQL injection*, nilai dari isian pengguna dikirim ke `sqflite` lewat ...

- a. interpolasi teks, misalnya `"WHERE nama = '$nama'"`
- b. `jsonEncode`
- c. `toUpperCase()`
- d. tanda `?` dan `whereArgs`

**10.** Sehari sebelum UAS, API proyek Anda mati. Dengan arsitektur yang benar, perubahan paling kecil agar demo tetap berjalan dengan data palsu adalah ...

- a. mengganti tempat *repository* dibuat (akar komposisi), atau menjalankan titik masuk pengembangan
- b. menulis ulang semua View
- c. menghapus folder `test/`
- d. menyalin data contoh ke setiap ViewModel

**11.** Saat `flutter test` dijalankan di depan penguji, baris terakhir yang diharapkan adalah ...

- a. `No issues found!`
- b. `Formatted 0 files`
- c. `+N: All tests passed!`
- d. `BUILD SUCCESSFUL`

**12.** Anda memperbaiki satu *bug* setelah rilis `1.0.0+1`. Baris `version:` yang benar untuk rilis berikutnya adalah ...

- a. `1.0.0+1`, cukup buat *tag* baru
- b. `1.0.1+2`
- c. `2.0.0+1`
- d. `1.0.1+1`

**13.** Mengapa `key.properties` dan berkas `.jks` tidak boleh masuk repositori?

- a. ukurannya terlalu besar untuk GitHub
- b. GitHub Actions tidak bisa membacanya
- c. `flutter analyze` akan gagal
- d. siapa pun yang memilikinya bisa menandatangani versi palsu aplikasi Anda

**14.** Perintah untuk melihat jumlah *commit* setiap anggota tim adalah ...

- a. `git shortlog -sn --no-merges`
- b. `git status`
- c. `git tag`
- d. `git push --force`

**15.** Saat demo, aplikasi tiba-tiba *crash*. Sikap terbaik adalah ...

- a. menyalahkan laptop dan meminta pindah giliran
- b. diam sampai penguji bertanya
- c. tetap tenang, membaca pesan galatnya, menjelaskan dugaan penyebab, lalu mengulang alur atau memutar video cadangan
- d. mengatakan bahwa fitur itu memang belum dibuat

<details>
<summary>💡 Petunjuk Bagian A</summary>

1: Panduan UAS Bagian 4 dan 8. 2: Bagian 9; perhatikan bagian mana yang dikalikan faktor. 3–4: Bagian 6. 5–6: Bagian 15.2. 7: [Pertemuan 6, Bagian 11](../pertemuan_06_daftar_dan_navigasi/README.md#11-menerima-hasil-dari-halaman). 8: [Pertemuan 11, Bagian 1](../pertemuan_11_penyimpanan_lokal/README.md#1-mengapa-data-hilang-saat-aplikasi-ditutup) dan [Bagian 13](../pertemuan_11_penyimpanan_lokal/README.md#13-keamanan-dan-pilihan-penyimpanan-lain). 9: [Pertemuan 11, Bagian 6](../pertemuan_11_penyimpanan_lokal/README.md#6-sql-langkah-demi-langkah). 10: [Pertemuan 12, Bagian 4](../pertemuan_12_clean_architecture/README.md#4-kontrak-repository-dan-dependency-injection). 11: Gladi Resik Kegiatan 1. 12: [Pertemuan 15, Bagian 5](../pertemuan_15_build_rilis_dan_finalisasi/README.md#5-identitas-aplikasi-2-nomor-versi). 13: [Pertemuan 15, Bagian 11](../pertemuan_15_build_rilis_dan_finalisasi/README.md#11-rilis-android-2-tanda-tangan-digital-dan-app-bundle). 14: Gladi Resik Kegiatan 1 Langkah 3. 15: Panduan UAS Bagian 10.
</details>

---

## B. Jelaskan Kode Ini

Bayangkan penguji menunjuk potongan kode berikut di proyek Anda. **Ucapkan** jawaban Anda dengan suara keras, seolah sedang UAS, lalu tuliskan intinya.

**B1.** ViewModel halaman beranda aplikasi resep.

```dart
class BerandaViewModel extends ChangeNotifier {
  BerandaViewModel({required this._repositori});

  final RepositoriResep _repositori;

  StatusMuat _status = StatusMuat.memuat;
  List<Resep> _resep = [];
  String? _pesanGalat;

  StatusMuat get status => _status;
  List<Resep> get resep => List.unmodifiable(_resep);
  String? get pesanGalat => _pesanGalat;

  Future<void> muat() async {
    _status = StatusMuat.memuat;
    _pesanGalat = null;
    notifyListeners(); // (1)

    final Hasil<List<Resep>> hasil = await _repositori.semuaResep();
    switch (hasil) {
      case Berhasil(:final List<Resep> nilai):
        _resep = nilai;
        _status = StatusMuat.berhasil;
      case Gagal(:final Kegagalan kegagalan):
        _pesanGalat = pesanUntuk(kegagalan);
        _status = StatusMuat.gagal;
    }
    notifyListeners(); // (2)
  }
}
```

- (a) Ceritakan apa yang terlihat di layar sejak `muat()` dipanggil sampai selesai, jika server berhasil menjawab.
- (b) Baris (1) dihapus. Pengguna yang sedang melihat pesan gagal menekan **Coba lagi**. Apa yang ia lihat selama menunggu jawaban server?
- (c) Cabang `case Gagal(...)` dihapus. Apa yang terjadi, dan mengapa itu justru menguntungkan?
- (d) Mengapa kalimat untuk pengguna dibuat oleh `pesanUntuk(kegagalan)` di lapisan UI, bukan oleh *repository*?

**B2.** *Repository* data gempa yang tetap berguna saat luring.

```dart
class RepositoriGempaServer implements RepositoriGempa {
  RepositoriGempaServer({required this._layanan, required this._cache});

  final LayananBmkg _layanan;
  final CacheGempa _cache;

  @override
  Future<Hasil<DataGempa>> terbaru() async {
    try {
      final List<Gempa> daftar = await _layanan.ambilTerbaru();
      await _cache.simpan(daftar);
      return Berhasil(DataGempa(daftar, dariCache: false));
    } on http.ClientException {
      final List<Gempa> lama = await _cache.baca();
      if (lama.isEmpty) return const Gagal(TanpaKoneksi());
      return Berhasil(DataGempa(lama, dariCache: true));
    }
  }
}
```

- (a) Ceritakan urutan kejadiannya saat internet **menyala**.
- (b) Internet **mati**, dan aplikasi pernah berhasil memuat data kemarin. Apa yang dikembalikan, dan apa yang sebaiknya dilihat pengguna?
- (c) Internet mati saat aplikasi **pertama kali** dipakai. Apa yang dikembalikan?
- (d) Mengapa nilai `dariCache` perlu dibawa sampai ke layar?

**B3.** Tes ViewModel lain yang memakai Perintah ([Pertemuan 12, Bagian 8](../pertemuan_12_clean_architecture/README.md#8-perintah-command-status-milik-setiap-aksi)) dan *repository* palsu yang bisa ditahan ([Pertemuan 14, Bagian 5](../pertemuan_14_pengujian_dan_debugging/README.md#5-menguji-viewmodel-dengan-data-palsu)).

```dart
test('muat ulang diketuk dua kali: server dihubungi sekali', () async {
  final RepositoriResepPalsu repositori = RepositoriResepPalsu()..tahan = true;
  final DaftarResepViewModel vm = DaftarResepViewModel(repositori: repositori);

  final Future<void> pertama = vm.muatUlang.jalankan(); // belum di-await
  final Future<void> kedua = vm.muatUlang.jalankan(); // ketukan kedua
  expect(vm.muatUlang.sedangBerjalan, isTrue);

  repositori.lepaskan();
  await Future.wait([pertama, kedua]);

  expect(repositori.jumlahMemuat, 1);
  expect(vm.muatUlang.sedangBerjalan, isFalse);
});
```

- (a) Jelaskan dalam bahasa **pengguna**: perilaku apa yang dijamin tes ini?
- (b) Penjaga `if (_sedangBerjalan) return;` di dalam Perintah dihapus. Baris `expect` mana yang gagal, dan apa kira-kira pesan galatnya?
- (c) Kedua panggilan diubah menjadi `await vm.muatUlang.jalankan();` dua kali berturut-turut (tetap sebelum `lepaskan()`). Apa yang terjadi saat tes dijalankan?
- (d) Mengapa tes ini memakai *repository* palsu, bukan server sungguhan?

**B4.** Membaca konfigurasi dari `--dart-define` ([Pertemuan 15, Bagian 3](../pertemuan_15_build_rilis_dan_finalisasi/README.md#3-konfigurasi-tanpa-mengubah-kode---dart-define)).

```dart
enum Lingkungan { pengembangan, produksi }

const String _teksLingkungan = String.fromEnvironment(
  'LINGKUNGAN',
  defaultValue: 'produksi',
);

Lingkungan bacaLingkungan() {
  return switch (_teksLingkungan) {
    'pengembangan' => Lingkungan.pengembangan,
    'produksi' => Lingkungan.produksi,
    _ => throw StateError('LINGKUNGAN "$_teksLingkungan" tidak dikenal'),
  };
}
```

- (a) Apa hasil `bacaLingkungan()` untuk setiap perintah berikut?
  1. `flutter run -d chrome`
  2. `flutter run -d chrome --dart-define=LINGKUNGAN=pengembangan`
  3. `flutter build apk --dart-define=LINGKUNGAN=Produksi`
- (b) Mengapa nilai bawaannya `produksi`, bukan `pengembangan`?
- (c) Kata `const` di depan `String.fromEnvironment` dihapus. Apa yang terjadi saat aplikasi dijalankan di Chrome?

<details>
<summary>💡 Petunjuk Bagian B</summary>

B1: [Pertemuan 10, Bagian 8](../pertemuan_10_async_dan_rest_api/README.md#8-menangani-galat-jaringan), [Pertemuan 12, Bagian 6](../pertemuan_12_clean_architecture/README.md#6-hasil-dan-kegagalan-galat-yang-menyeberangi-lapisan); ingat bahwa `switch` pada *sealed class* harus menangani semua jenisnya. B2: [Pertemuan 11, Bagian 10](../pertemuan_11_penyimpanan_lokal/README.md#10-cache-data-internet-yang-tetap-terbaca-saat-luring). B3: [Pertemuan 14, Bagian 5](../pertemuan_14_pengujian_dan_debugging/README.md#5-menguji-viewmodel-dengan-data-palsu) tentang `Completer`; perhatikan kapan `lepaskan()` dipanggil. B4: [Pertemuan 15, Bagian 3.3–3.4](../pertemuan_15_build_rilis_dan_finalisasi/README.md#33-membaca-nilainya-wajib-const); perhatikan huruf besar pada perintah ketiga.
</details>

---

## C. Bagaimana Jika

Jawab setiap situasi dengan urutan: **apa yang terjadi**, **mengapa**, dan **apa yang Anda lakukan**.

**C1.** Penguji membuka tautan versi web Anda dari HP-nya. Layarnya putih polos, dan konsol *browser* penuh galat 404. Di laptop Anda, `flutter run -d chrome` berjalan lancar.

**C2.** Kemarin Anda memasang APK `1.0.0` hasil `flutter build apk` di laptop. Hari ini Anda mengunduh APK `1.0.1` dari halaman rilis GitHub yang di-*build* robot tanpa kunci unggah. HP menolak: *"Aplikasi tidak terpasang karena paket bentrok dengan paket yang sudah ada"*.

**C3.** Setelah tenggat pengumpulan, seorang anggota merapikan riwayat Git lalu menjalankan `git push --force`.

**C4.** Aplikasi Anda tidak menyimpan salinan data API (*cache*). Penguji menyalakan mode pesawat, menutup aplikasi, lalu membukanya lagi.

**C5.** [Contoh 02](kode/contoh_02_pengatur_waktu_presentasi.dart) sedang berjalan di bagian pertama (7 menit) dan sudah menunjukkan `06:00`. Laptop lalu tertidur (*sleep*) selama 2 menit. Setelah dibangunkan, angka berapa yang tampil? Bandingkan dengan pengatur waktu yang mengurangi satu detik setiap kali `Timer` berdetak.

**C6.** Seorang anggota tim tidak punya satu *commit* pun, tetapi ia mengaku mengerjakan seluruh desain tampilan di Figma dan menguji aplikasi di HP-nya.

<details>
<summary>💡 Petunjuk Bagian C</summary>

C1: [Pertemuan 15, Bagian 9.3](../pertemuan_15_build_rilis_dan_finalisasi/README.md#93-alamat-dasar---base-href). C2: [Pertemuan 15, Bagian 11.1](../pertemuan_15_build_rilis_dan_finalisasi/README.md#111-mengapa-aplikasi-ditandatangani) dan [Troubleshooting bagian J](../panduan/04_troubleshooting.md#j-masalah-build-dan-rilis). C3: Panduan UAS Bagian 12. C4: [Pertemuan 11, Bagian 10](../pertemuan_11_penyimpanan_lokal/README.md#10-cache-data-internet-yang-tetap-terbaca-saat-luring). C5: Panduan UAS Bagian 15.2; jam dinding tetap berjalan saat laptop tidur. C6: Panduan UAS Bagian 9 dan 11, serta [templat `KONTRIBUSI_TIM.md`](templat/KONTRIBUSI_TIM.md).
</details>

---

## D. Ubah Kecil Langsung

Kerjakan dengan **batas waktu** seperti saat diminta penguji. Nyalakan pengatur waktu (Contoh 02 juga bisa!), lalu catat berapa menit Anda butuhkan. Setelah selesai, jalankan aplikasinya dan pastikan `flutter analyze` tetap bersih.

**D1 — Rencana proyek individu (3 menit, Contoh 02).** Ubah `rencanaUas` menjadi rencana 15 menit untuk proyek individu: **Presentasi dan demo** 6 menit, **Uji langsung** 3 menit, **Tanya jawab** 5 menit, **Catatan penguji** 1 menit.

✅ Daftar bagian menulis **Rencana 15 menit**, dan bagian pertama dimulai dari `06:00`.

**D2 — Ambang 30 detik (5 menit, Contoh 02).** Ubah ambang "hampir habis" menjadi **30 detik**, lalu ganti keterangan "Hampir habis" menjadi kalimat yang angkanya **diambil dari ambang**, misalnya *"Sisa 30 detik atau kurang"*. Jika ambangnya kelak diubah lagi, kalimat itu harus ikut berubah tanpa disentuh.

✅ Saat sisa waktu `00:45`, kartu masih berwarna "cukup". Saat `00:30`, kartu berganti warna dan bertuliskan **Sisa 30 detik atau kurang**.

**D3 — Tombol bagian sebelumnya (7 menit, Contoh 02).** Tambahkan tombol **Bagian sebelumnya** (ikon `Icons.skip_previous`) di sebelah kiri tombol yang sudah ada. Tombol itu **nonaktif** di bagian pertama. Seperti `berikutnya()`, perpindahan mengulang waktu bagian tujuan dari awal dan tidak menghentikan jam yang sedang berjalan.

✅ Di bagian pertama tombolnya pudar (nonaktif). Di bagian kedua, menekannya kembali ke **Presentasi dan demo** dengan waktu penuh bagian itu: `07:00`, atau `06:00` jika D1 sudah Anda kerjakan.

**D4 — Kategori baru (5 menit, Contoh 03).** Tambahkan kategori **Etika dan AI** (ikon `Icons.psychology`) beserta dua kartu berikut:

| Pertanyaan | Poin jawaban | Rujukan |
| :--- | :--- | :--- |
| Bagian mana dari aplikasi Anda yang dibantu asisten AI, dan bagaimana Anda memastikan hasilnya benar? | Sebutkan bagiannya dengan jujur, sesuai `KONTRIBUSI_TIM.md`. · Jelaskan cara memeriksanya: membaca ulang, menguji, dan menyederhanakan. | Panduan Proyek Akhir Bagian 10 |
| Data pribadi apa yang dikumpulkan aplikasi Anda, dan di mana pengguna bisa membacanya? | Sebutkan data yang benar-benar dikumpulkan, termasuk yang dikirim ke server. · Tunjukkan `KEBIJAKAN_PRIVASI.md` dan halaman Tentang. | P15 Bagian 8 |

✅ Chip **Etika dan AI** muncul di ujung kanan deretan chip, dan latihan berisi **23 kartu**. Anda tidak perlu mengubah satu baris pun di bagian VIEW. Mengapa?

**D5 — Persentase di ringkasan (3 menit, Contoh 03).** Ringkasan menulis persentase kartu yang sudah bisa, dibulatkan ke bilangan bulat terdekat: *"Sudah bisa 2 dari 3 kartu (67%)"*.

✅ Pilih satu kategori saja, tandai dua kartu **Sudah bisa** dan satu **Perlu diulang**, lalu periksa ringkasannya.

**D6 — Tes jam palsu (10 menit, proyek latihan).** Buat `test/pengatur_waktu_test.dart` yang menguji `PengaturWaktuViewModel` dari `lib/pengatur_waktu.dart` dengan **jam palsu**. Pakai rencana milik tes sendiri, berisi satu bagian 7 menit, agar tes tetap benar walaupun `rencanaUas` diubah (misalnya di D1). Empat tes:

1. ViewModel baru: sisa waktu 7 menit, status `cukup`, dan jam belum berjalan.
2. Setelah `mulai()` dan jam palsu maju 6 menit 30 detik: status `hampirHabis`.
3. Jam maju lagi 31 detik: status `lewatWaktu`, dan `formatSisa(vm.sisa)` menghasilkan `'+00:01'`.
4. Setelah `jeda()`, jam maju 5 menit: sisa waktu **tidak berubah**.

✅ `flutter test` → `+4: All tests passed!`

**D7 — Tantangan: kategori terakhir (10 menit, proyek latihan).** Buat `test/kartu_latihan_test.dart` untuk `LatihanTanyaJawabViewModel` dengan `Random(1)`. Buktikan dua hal: (a) setelah semua kategori kecuali satu dilepas, jumlah kartu sama dengan jumlah kartu kategori itu; (b) kategori terakhir **tidak bisa** dilepas.

✅ `flutter test` → kedua tes lulus.

<details>
<summary>💡 Petunjuk Bagian D</summary>

D1: hanya data. D2: `PengaturWaktuViewModel` sudah punya parameter `ambangHampirHabis`; berikan nilainya di tempat ViewModel dibuat, lalu pakai `vm.ambangHampirHabis.inSeconds` di `PanelWaktu`. D3: tiru `berikutnya()` dan `bagianTerakhir`; tombol nonaktif cukup diberi `onPressed: null`. D4: perhatikan bahwa chip dibuat dari `Kategori.values`. D5: `(bisa * 100 / total).round()`. D6: jam palsu bisa berupa variabel yang dibaca oleh fungsi:

```dart
DateTime sekarang = DateTime(2026, 12, 7, 8);
final PengaturWaktuViewModel vm = PengaturWaktuViewModel(
  rencana: rencanaUji, // satu bagian 7 menit, dibuat di berkas tes
  jam: () => sekarang,
);
sekarang = sekarang.add(const Duration(minutes: 6, seconds: 30));
```

D7: telusuri `Kategori.values` dengan `for`, lalu lepas setiap kategori yang bukan pilihan Anda; bandingkan jumlah kartunya dengan `semuaKartu.where(...).length` ([Pertemuan 14, Bagian 2–3](../pertemuan_14_pengujian_dan_debugging/README.md#2-tes-unit-pertama)).
</details>

---

## E. Menilai Diri dengan Rubrik

Isi bersama tim dengan **jujur** memakai patokan [Panduan UAS Bagian 8](README.md#8-rubrik-penilaian). Untuk setiap komponen, tuliskan buktinya (berkas, perintah, atau tangkapan layar) dan satu hal yang akan diperbaiki sebelum UAS.

| Komponen | Perkiraan (Sangat baik/Baik/Cukup/Kurang) | Bukti | Yang diperbaiki |
| :--- | :--- | :--- | :--- |
| Fungsionalitas | | | |
| Arsitektur dan kualitas kode | | | |
| UI/UX | | | |
| Pengujian | | | |
| Repositori, rilis, dan dokumentasi | | | |
| Presentasi dan tanya jawab (setiap anggota) | | | |

Komponen dengan perkiraan **Cukup** atau **Kurang** adalah prioritas minggu ini. Gunakan [Rencana Persiapan Satu Minggu](README.md#14-rencana-persiapan-satu-minggu) untuk menjadwalkannya.

---

[⬅️ Kembali ke Panduan UAS](README.md) · [🎯 Gladi Resik](GLADI_RESIK.md) · [🏠 Beranda](../README.md)

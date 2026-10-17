# 🩺 Panduan Troubleshooting (Mengatasi Masalah)

[🏠 Beranda](../README.md) · [📚 Daftar Panduan](01_cara_belajar.md#daftar-panduan)

Sebelum panik, ingat tiga langkah emas ini:

1. **Baca pesan error-nya** pelan-pelan, terutama baris pertama.
2. **Cari kata kunci pesan tersebut** di halaman ini (`Ctrl` + `F`).
3. Jika belum terpecahkan, **bertanyalah dengan format yang baik** (lihat [Cara Bertanya](01_cara_belajar.md#8-cara-bertanya-yang-baik)).

---

## A. Masalah Instalasi

### `'flutter' is not recognized as an internal or external command`

**Penyebab:** folder `flutter\bin` belum masuk PATH, atau terminal belum dibuka ulang setelah instalasi.
**Solusi:** tutup semua terminal dan VS Code, lalu buka kembali. Jika masih gagal, ikuti [Panduan Instalasi bagian 5](02_instalasi_flutter_windows.md#5-jika-perintah-flutter-tidak-dikenali).

### `The Flutter SDK is installed in a protected folder and may not function correctly.`

**Penyebab:** SDK dipasang di folder yang butuh hak administrator, misalnya `C:\Program Files\`.
**Solusi:** pindahkan folder `flutter` ke lokasi lain, misalnya `C:\Users\NamaAnda\develop\flutter`, lalu perbarui PATH.

### Berkas `flutter.bat` hilang dari folder `bin`

**Penyebab:** antivirus mengkarantina berkas tersebut.
**Solusi:** izinkan (*whitelist*) folder Flutter di pengaturan antivirus, lalu ekstrak atau unduh ulang SDK.

### `Invoke-Expression : You cannot call a method on a null-valued expression.`

**Penyebab:** pengaturan PowerShell di komputer Anda membatasi skrip.
**Solusi:** buka PowerShell **sebagai Administrator**, lalu jalankan:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### `Waiting for another flutter command to release the startup lock...`

**Penyebab:** ada perintah `flutter` lain yang masih berjalan, misalnya VS Code sedang menyiapkan proyek.
**Solusi:** tunggu sebentar. Jika tidak kunjung selesai, tutup VS Code dan semua terminal, lalu coba lagi.

### `Got TLS error trying to find package ... at https://pub.dev/` atau `exit code: 69`

**Penyebab:** masalah koneksi internet saat mengunduh paket.
**Solusi:** periksa koneksi, mulai ulang komputer dan perangkat jaringan, lalu coba lagi. Jika jaringan kampus memblokir akses, coba jaringan lain.

---

## B. Masalah Android

### `cmdline-tools component is missing`

**Solusi:** buka Android Studio → **More Actions → SDK Manager** → tab **SDK Tools** → centang **Android SDK Command-line Tools (latest)** → **Apply**.

### `Android license status unknown.`

**Solusi:** jalankan `flutter doctor --android-licenses`, lalu ketik `y` untuk setiap lisensi.

### HP Android tidak muncul di `flutter devices`

Periksa satu per satu:

1. Kabel yang dipakai adalah **kabel data**, bukan kabel yang hanya untuk mengisi daya. Coba kabel lain.
2. **Debugging USB** sudah aktif di **Opsi pengembang**.
3. Dialog *"Izinkan debugging USB?"* di HP sudah dijawab **Izinkan**. Jika tidak muncul, cabut lalu pasang kembali kabelnya.
4. Di Windows, beberapa merek HP membutuhkan *driver* USB khusus dari produsennya.

### `java.lang.UnsupportedClassVersionError ...`

**Penyebab:** ada beberapa versi Java di komputer Anda.
**Solusi:** jika tidak membutuhkannya, hapus JDK lain. Flutter otomatis memakai JDK bawaan Android Studio.

---

## C. Masalah Saat Menjalankan Aplikasi

### Chrome tidak muncul di daftar perangkat

Jika `flutter doctor` menampilkan `Cannot find Chrome. Try setting CHROME_EXECUTABLE to a Chrome executable.`:

1. Pasang Google Chrome dari <https://www.google.com/chrome>.
2. Jika Chrome terpasang di lokasi tidak biasa, buat *environment variable* bernama `CHROME_EXECUTABLE` yang berisi lokasi lengkap berkas `chrome.exe`.

### `Building with plugins requires symlink support.`

**Solusi:** aktifkan *Developer Mode* Windows. Jalankan `start ms-settings:developers`, lalu nyalakan **Developer Mode**.

### Perubahan kode tidak terlihat di aplikasi

| Kemungkinan | Solusi |
| :--- | :--- |
| Aplikasi dijalankan dari terminal | Setelah menyimpan, tekan `r` di terminal. |
| Yang diubah isi `main()` atau nilai awal variabel | Lakukan *hot restart*: tekan `R`. |
| Menambah paket baru di `pubspec.yaml` | Hentikan aplikasi (`q`), lalu jalankan ulang. |

### Layar merah bertuliskan `No Directionality widget found.`

**Penyebab:** widget teks dipakai tanpa `MaterialApp` dan tanpa `textDirection`.
**Solusi:** bungkus aplikasi dengan `MaterialApp` (lihat [Pertemuan 1, Contoh 02](../pertemuan_01_pengenalan_flutter/kode/contoh_02_materialapp_dan_scaffold.dart)).

### Garis kuning-hitam dan pesan `A RenderFlex overflowed by ... pixels`

**Penyebab:** isi tampilan lebih lebar (`on the right`) atau lebih tinggi (`on the bottom`) daripada ruang yang tersedia. Garis ini hanya tampil saat *debug*; di aplikasi rilis isinya terpotong diam-diam.
**Solusi:** teks panjang di dalam `Row` → bungkus dengan `Expanded`; banyak item kecil dalam satu baris → ganti `Row` dengan `Wrap`; halaman lebih tinggi daripada layar → bungkus dengan `SingleChildScrollView`. Penjelasan lengkapnya ada di [Pertemuan 4, Bagian 9](../pertemuan_04_widget_dan_layout/README.md#9-overflow-saat-isi-tidak-muat).

> [!TIP]
> Satu kesalahan tata letak bisa memicu puluhan pesan error berantai. Selalu baca dan perbaiki pesan **pertama** di konsol, lalu jalankan ulang.

### Tombol ditekan, tetapi tampilan tidak berubah

**Penyebab:** data diubah tanpa `setState()`, atau data disimpan di dalam `StatelessWidget`. Nilainya memang berubah di memori, tetapi Flutter tidak tahu bahwa layar perlu digambar ulang.
**Solusi:** simpan data di *class State* milik `StatefulWidget`, lalu ubah di dalam `setState(() { ... })`. Penjelasan lengkapnya ada di [Pertemuan 5, Bagian 2](../pertemuan_05_interaksi_dan_state/README.md#2-anatomi-statefulwidget).

Jika datanya disimpan di `ChangeNotifier` (mulai Pertemuan 9), periksa tiga hal:

1. Metode yang mengubah data diakhiri `notifyListeners()`.
2. Widget yang **menampilkan** data memakai `context.watch` atau `context.select`, bukan `context.read`. `read` di dalam `build` tidak menimbulkan *error*, tetapi tampilannya tidak pernah berubah.
3. Untuk `ValueNotifier<List<...>>`, ganti `.value` dengan `List` baru (`[...lama, baru]`), jangan hanya `.add(...)`. Lihat [Pertemuan 9, Bagian 5.2](../pertemuan_09_state_dan_mvvm/README.md#52-jebakan-isi-berubah-objeknya-tetap).

### `setState() called after dispose()`

**Penyebab:** `setState` dipanggil setelah `await` (misalnya setelah dialog atau pengambilan data selesai), padahal halamannya sudah ditutup.
**Solusi:** tepat setelah `await`, tambahkan `if (!mounted) return;`. Lihat [Pertemuan 5, Bagian 10.2](../pertemuan_05_interaksi_dan_state/README.md#102-periksa-mounted-setelah-await).

### Layar merah bertuliskan `Vertical viewport was given unbounded height.`

**Penyebab:** `ListView` atau `GridView` diletakkan langsung di dalam `Column`. `Column` tidak membatasi tinggi anaknya, sedangkan `ListView` ingin setinggi mungkin.
**Solusi:** bungkus `ListView` dengan `Expanded`, agar ia memakai sisa tinggi layar. Lihat [Pertemuan 6, Bagian 6](../pertemuan_06_daftar_dan_navigasi/README.md#6-daftar-di-dalam-column).

### `A dismissed Dismissible widget is still part of the tree.`

**Penyebab:** item yang sudah digeser tidak dihapus dari daftar di `onDismissed`, atau *key*-nya memakai `index` sehingga item lain mendapat *key* yang sama.
**Solusi:** hapus item di dalam `setState` pada `onDismissed`, dan pakai *key* yang unik dan tetap, misalnya `ValueKey(item.id)`. Lihat [Pertemuan 6, Bagian 7](../pertemuan_06_daftar_dan_navigasi/README.md#7-geser-untuk-menghapus-dan-peran-key). Jika daftarnya berasal dari database, buang dulu barisnya dari daftar di memori, baru hapus dari database. Jangan menunggu database selesai lebih dulu ([Pertemuan 11, Bagian 7.5](../pertemuan_11_penyimpanan_lokal/README.md#75-viewmodel-tulis-lalu-baca-ulang)).

### `No GoRouter found in context`

**Penyebab:** `context.go` atau `context.push` dipakai, tetapi aplikasi masih memakai `MaterialApp` biasa, sehingga peta rute tidak pernah dipasang.
**Solusi:** ganti dengan `MaterialApp.router(routerConfig: petaRute)`. Lihat [Pertemuan 6, Bagian 13.3](../pertemuan_06_daftar_dan_navigasi/README.md#133-menulis-peta-rute).

### Aplikasi tetap terang walaupun mode gelap dipilih

**Penyebab:** `darkTheme` tidak diisi (sehingga `theme` yang terang dipakai untuk semua pilihan), atau `ColorScheme.fromSeed` untuk `darkTheme` lupa diberi `brightness: Brightness.dark`.
**Solusi:** isi `darkTheme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: benih, brightness: Brightness.dark))`. Lihat [Pertemuan 7, Bagian 7.2](../pertemuan_07_material3_dan_responsif/README.md#72-dua-tema-dan-satu-pilihan).

### Teks nyaris hilang atau kotak putih mencolok di mode gelap

**Penyebab:** warna ditulis langsung (`Colors.black`, `Colors.white`, dan sejenisnya), sehingga tidak ikut berganti saat tema berganti.
**Solusi:** ambil warna dari peran warna tema, misalnya `colorScheme.onSurface` untuk teks dan `colorScheme.surfaceContainerHighest` untuk latar kotak, serta gaya huruf dari `textTheme`. Lihat [Pertemuan 7, Bagian 7.4](../pertemuan_07_material3_dan_responsif/README.md#74-membuktikannya-warna-tema-vs-warna-yang-ditulis-langsung).

### `BoxConstraints forces an infinite width.`

**Penyebab:** tombol yang `minimumSize`-nya `Size.fromHeight(...)` (misalnya dari `filledButtonTheme`) diletakkan di dalam `Row`. `Size.fromHeight` meminta lebar sebesar-besarnya, padahal `Row` tidak membatasi lebar anaknya.
**Solusi:** bungkus tombol itu dengan `Expanded`, atau beri tombol itu `style` sendiri dengan `minimumSize` yang lebarnya terbatas. Lihat [Pertemuan 7, Bagian 6.3](../pertemuan_07_material3_dan_responsif/README.md#63-siapa-yang-menang-jika-aturannya-berbeda).

### *Assertion error* yang menyebut `!extended || (labelType == null || labelType == NavigationRailLabelType.none)`

**Penyebab:** `NavigationRail` diperlebar (`extended: true`), tetapi `labelType`-nya diisi `NavigationRailLabelType.all` atau `.selected`.
**Solusi:** saat diperlebar, `labelType` harus `null` atau `NavigationRailLabelType.none`, misalnya `labelType: railLebar ? NavigationRailLabelType.none : NavigationRailLabelType.all`. Lihat [Pertemuan 7, Bagian 12.2](../pertemuan_07_material3_dan_responsif/README.md#122-navigationrail-navigasi-di-samping).

### `Error: Could not find the correct Provider<...> above this ... Widget`

**Penyebab:** widget meminta objek dari *provider* yang tidak dititipkan **di atasnya**. Yang paling sering: *provider* belum dipasang; *provider* baru ditambahkan di `main` lalu aplikasi hanya di-*hot reload*; *provider* dipasang di rute halaman lain (halaman hasil `Navigator.push` bukan "anak" halaman sebelumnya); atau `context` yang dipakai berada di atas *provider* yang dibuat di `build` yang sama.
**Solusi:** lakukan *hot restart* (`R`); pindahkan *provider* ke atas `MaterialApp` jika dipakai banyak halaman; atau bungkus bagian yang membaca dengan `Consumer`. Lihat [Pertemuan 9, Bagian 11.4](../pertemuan_09_state_dan_mvvm/README.md#114-saat-provider-tidak-ditemukan).

### `Tried to listen to a value exposed with provider, from outside of the widget tree.`

**Penyebab:** `context.watch` dipakai di dalam `onPressed`, `onChanged`, atau *callback* lain.
**Solusi:** di dalam *callback*, pakai `context.read`. Pegangannya: menampilkan data → `watch`/`select`; memanggil metode → `read`. Lihat [Pertemuan 9, Bagian 7.5](../pertemuan_09_state_dan_mvvm/README.md#75-pesan-error-yang-sering-muncul).

### ``Tried to use `context.select` outside of the `build` method of a widget.``

**Penyebab:** `context.select` dipakai di dalam *callback*.
**Solusi:** di dalam *callback*, pakai `context.read`. `select` hanya untuk dipakai langsung di dalam `build`.

### `A ... was used after being disposed.`

**Penyebab:** `notifyListeners()` dipanggil pada objek yang sudah dibuang. Biasanya terjadi pada ViewModel halaman: halaman ditutup saat data masih dimuat, lalu setelah `await` selesai ViewModel tetap mengumumkan perubahan.
**Solusi:** tambahkan penjaga `_sudahDibuang` yang diisi `true` di `dispose()`, lalu periksa setelah setiap `await`. Lihat [Pertemuan 9, Bagian 10.6](../pertemuan_09_state_dan_mvvm/README.md#106-mengapa-ada-_sudahdibuang).

### `Unsupported operation: Cannot add to an unmodifiable list`

**Penyebab:** kode di luar objek *state* mencoba mengubah daftar yang dibuka sebagai `UnmodifiableListView`, misalnya `keranjang.isi.add(...)`.
**Solusi:** ini memang disengaja agar perubahan selalu lewat metode yang memanggil `notifyListeners()`. Panggil metodenya, misalnya `keranjang.tambah(...)`. Lihat [Pertemuan 9, Bagian 6.4](../pertemuan_09_state_dan_mvvm/README.md#64-tiga-langkah-memakai-provider).

### Tata letak tidak berganti walaupun lebar sudah dibuat 320 dengan `SizedBox`

**Penyebab:** `MediaQuery.widthOf(context)` membaca lebar **jendela**. `SizedBox` di `MaterialApp.builder` hanya mengubah ruang untuk widget di dalamnya, bukan ukuran jendela.
**Solusi:** ubah ukuran jendela Chrome dengan menyeret tepinya, atau buka DevTools (`F12`) lalu tekan `Ctrl` + `Shift` + `M` dan ketik lebarnya. Lihat [Pertemuan 7, Bagian 15](../pertemuan_07_material3_dan_responsif/README.md#15-cara-menguji-tampilan-responsif).

---

## D. Masalah Penulisan Kode

### Garis merah di VS Code

Garis merah = **error** (kode tidak bisa dijalankan). Arahkan *mouse* ke garis tersebut untuk membaca pesannya. Penyebab paling umum:

- Lupa titik koma `;`.
- Kurung `(`, `[`, atau `{` tidak berpasangan.
- Salah ketik nama (ingat, huruf besar dan kecil dibedakan).

### Garis kuning atau biru di VS Code

Garis kuning = **peringatan** (*warning*); garis biru = **saran** (*info/lint*). Kode tetap bisa berjalan, tetapi sebaiknya diperbaiki agar kode bersih. Banyak saran bisa diperbaiki otomatis dengan menekan `Ctrl` + `.` (titik) pada baris tersebut.

### Error saat membaca `pubspec.yaml`

**Penyebab:** ada karakter Tab, atau indentasi tidak rata.
**Solusi:** gunakan **spasi** (2 spasi per tingkat), bukan Tab. Pastikan setiap tingkat sejajar dengan rapi.

### `Target of URI doesn't exist: 'package:go_router/go_router.dart'.`

**Penyebab:** paket `go_router` belum ditambahkan di `pubspec.yaml`, atau belum diunduh.
**Solusi:** tambahkan `go_router: ^17.5.0` di bawah `dependencies:`, simpan, lalu jalankan `flutter pub get`. Lihat [Pertemuan 6, Bagian 13.2](../pertemuan_06_daftar_dan_navigasi/README.md#132-memasang-paket-go_router).

### `Target of URI doesn't exist: 'package:provider/provider.dart'.`

**Penyebab:** paket `provider` belum dipasang di proyek Anda.
**Solusi:** di terminal, dari folder proyek, jalankan `flutter pub add provider`. Lihat [Pertemuan 9, Bagian 6.3](../pertemuan_09_state_dan_mvvm/README.md#63-memasang-paket).

### `Target of URI doesn't exist: 'package:http/http.dart'.`

**Penyebab:** paket `http` belum dipasang di proyek Anda.
**Solusi:** di terminal, dari folder proyek, jalankan `flutter pub add http`. Untuk `MockClient`, cukup tambahkan `import 'package:http/testing.dart';` (masih paket yang sama). Lihat [Pertemuan 10, Bagian 4.1](../pertemuan_10_async_dan_rest_api/README.md#41-memasang-paket).

### `Target of URI doesn't exist: 'package:shared_preferences/shared_preferences.dart'.`

**Penyebab:** paket `shared_preferences` belum dipasang di proyek Anda.
**Solusi:** dari folder proyek, jalankan `flutter pub add shared_preferences`. Jika aplikasi sedang berjalan, hentikan dulu (`q`), lalu jalankan lagi. Lihat [Pertemuan 11, Bagian 2.1](../pertemuan_11_penyimpanan_lokal/README.md#21-memasang-paket).

### `Target of URI doesn't exist: 'package:sqflite/sqflite.dart'.` (atau `package:sqflite_common_ffi_web/...`)

**Penyebab:** paket `sqflite` atau `sqflite_common_ffi_web` belum dipasang di proyek Anda.
**Solusi:** jalankan `flutter pub add sqflite sqflite_common_ffi_web`. Khusus Chrome, jalankan juga **sekali** `dart run sqflite_common_ffi_web:setup`. Lihat [Pertemuan 11, Bagian 5.4](../pertemuan_11_penyimpanan_lokal/README.md#54-memasang-sqflite).

### `Target of URI doesn't exist: 'package:nama_proyek/...'` di proyek yang dipecah menjadi banyak berkas

**Penyebab:** nama proyek di baris `import` tidak sama dengan isi `name:` di `pubspec.yaml`, atau jalurnya salah ketik (jalur dimulai dari dalam folder `lib/`).
**Solusi:** samakan nama proyeknya, periksa ejaan setiap folder, lalu simpan berkasnya. Arahkan kursor ke nama *class* yang bergaris merah dan tekan `Ctrl` + `.` untuk membiarkan VS Code menambahkan `import` yang benar. Lihat [Pertemuan 9, Bagian 13.3](../pertemuan_09_state_dan_mvvm/README.md#133-mengimpor-berkas-lain-di-proyek-sendiri).

### `'color' is deprecated and shouldn't be used. Use backgroundColor instead.`

**Penyebab:** kode dari tutorial lama memakai `AppBarTheme(color: ...)`.
**Solusi:** pakai `AppBarThemeData(backgroundColor: ..., foregroundColor: ...)`, dengan pasangan peran warna yang serasi, misalnya `primary` dan `onPrimary`. Lihat [Pertemuan 7, Bagian 6.2](../pertemuan_07_material3_dan_responsif/README.md#62-tema-komponen-mengatur-semua-komponen-sejenis-sekaligus).

### Kesalahan umum bahasa Dart dan widget Flutter

Lihat tabel lengkap di [Pertemuan 2, Bagian 15](../pertemuan_02_dasar_dart/README.md#15-kesalahan-umum-pemula-dan-solusinya) (variabel, tipe data, *null safety*), [Pertemuan 3, Bagian 14](../pertemuan_03_dart_lanjutan/README.md#14-kesalahan-umum-pemula-dan-solusinya) (*class*, pewarisan, *exception*, `Future`, dan `Stream`), [Pertemuan 4, Bagian 15](../pertemuan_04_widget_dan_layout/README.md#15-kesalahan-umum-pemula-dan-solusinya) (`child`/`children`, `Expanded`, *overflow*, dan *constraints*), [Pertemuan 5, Bagian 14](../pertemuan_05_interaksi_dan_state/README.md#14-kesalahan-umum-pemula-dan-solusinya) (`setState`, siklus hidup, *controller*, formulir, dan dialog), [Pertemuan 6, Bagian 15](../pertemuan_06_daftar_dan_navigasi/README.md#15-kesalahan-umum-pemula-dan-solusinya) (`ListView`, `Dismissible`, pencarian, `Navigator`, dan `go_router`), [Pertemuan 7, Bagian 17](../pertemuan_07_material3_dan_responsif/README.md#17-kesalahan-umum-pemula-dan-solusinya) (tema, peran warna, mode gelap, *breakpoint*, dan navigasi adaptif), [Pertemuan 9, Bagian 15](../pertemuan_09_state_dan_mvvm/README.md#15-kesalahan-umum-pemula-dan-solusinya) (`ChangeNotifier`, `provider`, MVVM, dan *repository*), [Pertemuan 10, Bagian 15](../pertemuan_10_async_dan_rest_api/README.md#15-kesalahan-umum-pemula-dan-solusinya) (paket `http`, JSON, `FutureBuilder`, galat jaringan, dan CORS), [Pertemuan 11, Bagian 14](../pertemuan_11_penyimpanan_lokal/README.md#14-kesalahan-umum-pemula-dan-solusinya) (`shared_preferences`, SQLite, migrasi, transaksi, dan *cache*), [Pertemuan 12, Bagian 13](../pertemuan_12_clean_architecture/README.md#13-kesalahan-umum-pemula-dan-solusinya) (lapisan, kontrak, `Hasil`, *use case*, dan Perintah), dan [Pertemuan 13, Bagian 14](../pertemuan_13_fitur_perangkat_dan_izin/README.md#14-kesalahan-umum-pemula-dan-solusinya) (izin akses, kamera, galeri, dan lokasi).

---

## E. Masalah Jaringan dan REST API

### `ClientException` saat mengambil data (misalnya `Failed to fetch`, `XMLHttpRequest error`, atau `Failed host lookup`)

**Penyebab:** permintaan **tidak mendapat jawaban sama sekali**: tidak ada koneksi internet, alamat servernya salah ketik, atau (khusus web) server tidak mengizinkan dipanggil dari *browser* (CORS). Di *browser*, ekstensi pemblokir iklan juga bisa memblokir permintaan ke server tertentu.
**Solusi:** periksa koneksi internet dan ejaan alamatnya. Buka alamat yang sama langsung di *browser*: jika di sana tampil normal tetapi aplikasi web tetap gagal, kemungkinan besar penyebabnya CORS, jadi uji di HP Android atau pilih API lain. Coba juga matikan sementara ekstensi pemblokir iklan. Lihat [Pertemuan 10, Bagian 5](../pertemuan_10_async_dan_rest_api/README.md#5-membedah-jawaban-server) dan [Bagian 14.1](../pertemuan_10_async_dan_rest_api/README.md#141-di-web-chrome-dan-dartpad-cors).

### `TimeoutException after ...: Future not completed`

**Penyebab:** server tidak menjawab dalam batas waktu yang dipasang dengan `.timeout(...)`. Bisa karena koneksi lambat, server sedang sibuk, atau batas waktunya terlalu pendek.
**Solusi:** coba lagi beberapa saat kemudian. Pakai batas waktu yang wajar (10–15 detik), dan tampilkan pesan yang ramah beserta tombol **Coba lagi**. Lihat [Pertemuan 10, Bagian 8.1](../pertemuan_10_async_dan_rest_api/README.md#81-empat-jenis-kegagalan).

### `FormatException` saat `jsonDecode` (misalnya `Unexpected character` atau `Unexpected token '<'`)

**Penyebab:** isi jawaban **bukan JSON**. Paling sering: server mengirim halaman HTML, misalnya halaman galat `404` karena jalurnya salah, lalu `jsonDecode` tetap dijalankan tanpa memeriksa kode status.
**Solusi:** periksa `statusCode` **sebelum** `jsonDecode`, lalu buka alamatnya di *browser* untuk melihat isi jawabannya. Lihat [Pertemuan 10, Bagian 5](../pertemuan_10_async_dan_rest_api/README.md#5-membedah-jawaban-server).

### `type 'List<dynamic>' is not a subtype of type 'Map<String, dynamic>' in type cast`

**Penyebab:** jawaban server berupa larik (`[...]`), tetapi kode memperlakukannya sebagai objek (`{...}`), atau sebaliknya.
**Solusi:** buka alamatnya di *browser* dan lihat bentuk JSON-nya dulu. Baca dengan pola Dart 3 (`switch` dengan pola map/larik) agar bentuk yang tidak sesuai menjadi `FormatException` yang jelas. Lihat [Pertemuan 10, Bagian 6.2](../pertemuan_10_async_dan_rest_api/README.md#62-factory-fromjson-dengan-pola-dart-3).

### Angka dari JSON gagal dibaca di Android, padahal lancar di Chrome

**Penyebab:** angka dibaca dengan pola atau tipe `double`. Di web, angka bulat seperti `15` bisa ikut dianggap `double`, sedangkan di Android `15` adalah `int`.
**Solusi:** baca angka yang bisa desimal dengan `num`, lalu ubah dengan `.toDouble()`. Lihat [Pertemuan 10, Bagian 6.2](../pertemuan_10_async_dan_rest_api/README.md#62-factory-fromjson-dengan-pola-dart-3).

### Huruf aneh seperti `Ã©` atau `Â°` pada data dari server

**Penyebab:** server tidak menyebutkan *charset* di *header* `Content-Type`, sehingga `respons.body` membaca teksnya dengan aturan lama.
**Solusi:** baca isi jawaban dengan `utf8.decode(respons.bodyBytes)`. Lihat [Pertemuan 10, Bagian 9.2](../pertemuan_10_async_dan_rest_api/README.md#92-layanan-satu-tempat-untuk-urusan-http).

### Server menolak data yang dikirim dengan `POST` (kode `400`)

**Penyebab:** *body* tidak diubah menjadi teks JSON, atau *header* `Content-Type: application/json` tidak dikirim, sehingga server tidak membaca datanya. Di DummyJSON, jawabannya misalnya `{"message":"User id is required"}`.
**Solusi:** kirim `body: jsonEncode({...})` bersama `headers: {'Content-Type': 'application/json'}`, lalu anggap semua kode 2xx (termasuk `201`) sebagai berhasil. Lihat [Pertemuan 10, Bagian 11.1](../pertemuan_10_async_dan_rest_api/README.md#111-post-menambah-data-baru).

### Lingkaran memuat muncul terus dan permintaan terkirim berulang-ulang

**Penyebab:** `Future` dibuat di dalam `build`, misalnya `FutureBuilder(future: ambilData(), ...)`. Setiap kali layar dibangun ulang, permintaan baru dikirim.
**Solusi:** buat `Future` sekali di `initState` lalu simpan di variabel *state*, atau pindahkan pengambilan data ke ViewModel. Lihat [Pertemuan 10, Bagian 7.2](../pertemuan_10_async_dan_rest_api/README.md#72-jebakan-membuat-future-di-dalam-build).

### APK rilis tidak bisa memuat data, padahal lancar saat `flutter run`

**Penyebab:** izin internet belum ditambahkan. Mode *debug* (`flutter run`) mendapatkannya otomatis, sedangkan APK rilis tidak.
**Solusi:** tambahkan `<uses-permission android:name="android.permission.INTERNET" />` di `android/app/src/main/AndroidManifest.xml`, di dalam tag `<manifest>` dan sebelum tag `<application>`. Lihat [Pertemuan 10, Bagian 14.2](../pertemuan_10_async_dan_rest_api/README.md#142-di-android-izin-internet).

### `Bad state: Insecure HTTP is not allowed by platform: http://...`

**Penyebab:** alamat server memakai `http://` (tanpa **s**). Android dan iOS menolak koneksi tanpa enkripsi secara bawaan.
**Solusi:** pakai alamat `https://`. Lihat [Pertemuan 10, Bagian 14.3](../pertemuan_10_async_dan_rest_api/README.md#143-dua-hal-lain-yang-sering-menjebak).

---

## F. Masalah Penyimpanan Lokal

### Contoh Pertemuan 11 di DartPad hanya menampilkan lingkaran memuat (atau gagal karena `sqflite`)

**Penyebab:** jendela hasil DartPad tidak diizinkan memakai penyimpanan *browser*, sehingga `shared_preferences` gagal membaca data (di konsol *browser* muncul `SecurityError` yang menyebut `localStorage`). Paket `sqflite` juga belum tersedia di DartPad.
**Solusi:** jalankan contoh dan praktikum Pertemuan 11 di proyek latihan dengan `flutter run -d chrome --web-port=8080` atau di HP Android. Lihat [Panduan Menjalankan Kode, Cara 2](03_menjalankan_kode_contoh.md#cara-2--proyek-latihan-flutter-di-komputer-sendiri).

### `MissingPluginException(No implementation found for method ...)`

**Penyebab:** paket yang membawa bagian asli (*plugin*), misalnya `shared_preferences`, `sqflite`, `image_picker`, atau `geolocator`, baru dipasang saat aplikasi sedang berjalan. *Hot reload* dan *hot restart* tidak memuat bagian aslinya.
**Solusi:** hentikan aplikasi (tekan `q` di terminal), lalu jalankan lagi dengan `flutter run`. Lihat [Pertemuan 11, Bagian 2.1](../pertemuan_11_penyimpanan_lokal/README.md#21-memasang-paket) dan [Pertemuan 13, Bagian 3.1](../pertemuan_13_fitur_perangkat_dan_izin/README.md#31-menambah-paket).

### Data yang disimpan hilang setiap kali `flutter run -d chrome` dijalankan

**Penyebab:** tanpa *port* tetap, Flutter memilih *port* acak setiap kali dijalankan. Chrome menyimpan data per alamat situs, termasuk nomor *port*-nya, sehingga data lama tersimpan "di situs lain".
**Solusi:** selalu jalankan dengan `flutter run -d chrome --web-port=8080`. Lihat [Pertemuan 11, Bagian 2.4](../pertemuan_11_penyimpanan_lokal/README.md#24-membuktikan-data-benar-benar-tersimpan).

### `Binding has not yet been initialized.`

**Penyebab:** *plugin* penyimpanan dipakai di `main` sebelum `runApp`, padahal jalurnya ke bagian asli platform belum disiapkan.
**Solusi:** jadikan `WidgetsFlutterBinding.ensureInitialized();` baris pertama di `main`. Lihat [Pertemuan 11, Bagian 3.1](../pertemuan_11_penyimpanan_lokal/README.md#31-masalah-berkedip).

### `type 'String' is not a subtype of type 'int?'` saat membaca `shared_preferences`

**Penyebab:** satu kunci dibaca dengan tipe yang berbeda dari saat disimpan, misalnya disimpan dengan `setString` tetapi dibaca dengan `getInt`.
**Solusi:** pakai satu tipe untuk satu kunci, dan tulis nama kunci sebagai konstanta agar tidak salah ketik. Selama pengembangan, hapus data lama yang terlanjur salah tipe (lihat [Pertemuan 11, Bagian 12.3](../pertemuan_11_penyimpanan_lokal/README.md#123-menghapus-data-selama-pengembangan)). Daftar tipe yang bisa disimpan ada di [Bagian 2.5](../pertemuan_11_penyimpanan_lokal/README.md#25-tipe-data-yang-bisa-disimpan).

### `ArgumentError` yang menyebut `is not included in the PreferencesFilter allowlist`

**Penyebab:** kunci yang dipakai belum dimasukkan ke `allowList` milik `SharedPreferencesWithCache`.
**Solusi:** tambahkan kunci itu ke `allowList` saat memanggil `SharedPreferencesWithCache.create(...)`. Lihat [Pertemuan 11, Bagian 3.1](../pertemuan_11_penyimpanan_lokal/README.md#31-masalah-berkedip).

### Tema berkedip (sekilas terang, lalu gelap) saat aplikasi dibuka

**Penyebab:** pengaturan tema baru dibaca setelah layar pertama tampil.
**Solusi:** baca pengaturan dengan `SharedPreferencesWithCache` di `main`, sebelum `runApp`. Lihat [Pertemuan 11, Bagian 3](../pertemuan_11_penyimpanan_lokal/README.md#3-pengaturan-yang-langsung-siap-sejak-layar-pertama).

### `Bad state: databaseFactory not initialized` (di Chrome)

**Penyebab:** di Chrome, `sqflite` membutuhkan pembuat database versi web, tetapi barisnya belum ditulis.
**Solusi:** tambahkan `databaseFactory = databaseFactoryFfiWeb;` di `main`, di dalam `if (kIsWeb) { ... }`. Lihat [Pertemuan 11, Bagian 5.4](../pertemuan_11_penyimpanan_lokal/README.md#54-memasang-sqflite).

### Di Chrome muncul galat yang menyebut `sqlite3.wasm` atau `sqflite_sw.js`, atau aplikasi terus memuat

**Penyebab:** langkah persiapan `sqflite` versi web belum dijalankan, sehingga kedua berkas itu belum ada di folder `web/`.
**Solusi:** dari folder proyek, jalankan `dart run sqflite_common_ffi_web:setup`, lalu jalankan ulang aplikasi. Lihat [Pertemuan 11, Bagian 5.4](../pertemuan_11_penyimpanan_lokal/README.md#54-memasang-sqflite).

### `no such table` atau `no such column` setelah `CREATE TABLE` diubah

**Penyebab:** `onCreate` hanya berjalan **sekali**, yaitu saat berkas database belum ada. Berkas lama di perangkat masih memakai struktur tabel yang lama.
**Solusi:** naikkan `version`, lalu tulis perubahan strukturnya di `onUpgrade` ([Pertemuan 11, Bagian 8](../pertemuan_11_penyimpanan_lokal/README.md#8-mengubah-struktur-tabel-versi-dan-migrasi)). Selama pengembangan, boleh juga menghapus data Anda sendiri ([Bagian 12.3](../pertemuan_11_penyimpanan_lokal/README.md#123-menghapus-data-selama-pengembangan)).

### `duplicate column name` saat migrasi

**Penyebab:** migrasi yang sama berjalan dua kali, biasanya karena `version` sempat diturunkan lalu dinaikkan lagi.
**Solusi:** nomor versi database hanya boleh naik. Selama pengembangan, hapus data aplikasi Anda sendiri agar mulai dari awal. Lihat [Pertemuan 11, Bagian 8.3](../pertemuan_11_penyimpanan_lokal/README.md#83-aturan-emas-migrasi).

### Aplikasi macet saat menyimpan (lingkaran memuat berputar terus)

**Penyebab:** di dalam `db.transaction(...)`, perintah masih memakai `db`, bukan `txn`. Perintah lewat `db` menunggu transaksi selesai, padahal transaksi menunggu perintah itu (*deadlock*).
**Solusi:** pakai `txn` untuk semua perintah di dalam blok transaksi. Lihat [Pertemuan 11, Bagian 9.2](../pertemuan_11_penyimpanan_lokal/README.md#92-transaksi-semua-atau-tidak-sama-sekali).

### `UNIQUE constraint failed`

**Penyebab:** ada data kembar pada kolom yang memakai aturan `UNIQUE`, misalnya NIM yang sama disimpan dua kali.
**Solusi:** tangkap `DatabaseException`, periksa `isUniqueConstraintError()`, lalu tampilkan pesan yang ramah. Lihat [Pertemuan 11, Bagian 6.4](../pertemuan_11_penyimpanan_lokal/README.md#64-database-pun-bisa-menolak-databaseexception).

### Galat SQL saat teks berisi tanda kutip (misalnya `Jum'at`)

**Penyebab:** nilai ditempel langsung ke teks SQL, sehingga tanda kutip memotong perintahnya. Cara ini juga membuka celah *SQL injection*.
**Solusi:** selalu pakai tanda `?` dan kirim nilainya lewat `whereArgs` (atau daftar argumen `rawQuery`). Lihat [Pertemuan 11, Bagian 6.6](../pertemuan_11_penyimpanan_lokal/README.md#66-mengapa-harus-whereargs).

## G. Masalah Arsitektur Berlapis

### `Error: Could not find the correct Provider<RepositoriRuang> ...` padahal *provider*-nya sudah dipasang

**Penyebab:** *provider* dititipkan dengan jenis **implementasinya**, misalnya `Provider(create: (context) => RepositoriRuangServer(...))`. Tanpa `<...>`, jenisnya disimpulkan menjadi `RepositoriRuangServer`, sedangkan ViewModel meminta kontraknya dengan `context.read<RepositoriRuang>()`. Kebalikannya juga gagal: dititipkan sebagai kontrak, tetapi diminta sebagai implementasi.
**Solusi:** tulis jenis kontraknya saat menitipkan, `Provider<RepositoriRuang>(create: ...)`, dan selalu minta kontraknya. Lihat [Pertemuan 12, Bagian 4.4](../pertemuan_12_clean_architecture/README.md#44-akar-komposisi-composition-root).

### Sumber data sudah diganti di akar komposisi, tetapi tampilan tetap memakai data lama

**Penyebab:** ViewModel membuat *repository*-nya sendiri, misalnya `final RepositoriRuang _repositori = RepositoriRuangContoh();`, sehingga parameter *constructor*-nya diterima lalu diabaikan.
**Solusi:** terima *repository* dari luar dengan `DaftarRuangViewModel({required this._repositori})` dan *field* `final RepositoriRuang _repositori;` tanpa nilai awal. Lihat [Pertemuan 12, Bagian 4.3](../pertemuan_12_clean_architecture/README.md#43-dependency-injection-bahan-diantar-bukan-dicari).

### `Named parameters can't start with an underscore.`

**Penyebab:** bentuk singkat `required this._repositori` baru didukung sejak Dart 3.12. SDK Anda masih lebih lama.
**Solusi:** perbarui Flutter dengan `flutter upgrade` (mata kuliah ini memakai Flutter 3.47 / Dart 3.13). Jika belum bisa memperbarui, pakai bentuk panjang: `({required RepositoriRuang repositori}) : _repositori = repositori;`. Lihat [Pertemuan 9, Bagian 10.4](../pertemuan_09_state_dan_mvvm/README.md#104-menitipkan-repository-dan-menyerahkannya-ke-viewmodel).

### `The named parameter '_repositori' isn't defined.`

**Penyebab:** saat memanggil *constructor*, nama parameternya ditulis dengan garis bawah.
**Solusi:** dari luar, nama parameternya ditulis **tanpa** garis bawah: `DaftarRuangViewModel(repositori: ...)`. Lihat [Pertemuan 12, Bagian 4.3](../pertemuan_12_clean_architecture/README.md#43-dependency-injection-bahan-diantar-bukan-dicari).

### `The type 'Kegagalan' isn't exhaustively matched by the switch cases since it doesn't match the pattern '...'.`

**Penyebab:** jenis kegagalan baru ditambahkan ke `sealed class Kegagalan`, tetapi sebuah `switch` (misalnya di `pesanKegagalan`) belum punya cabangnya.
**Solusi:** tambahkan cabang untuk jenis baru itu di **setiap** `switch` yang ditandai. Jangan menutupnya dengan cabang `_ =>`, karena justru galat inilah yang menjaga agar tidak ada kegagalan tanpa pesan. Lihat [Pertemuan 12, Bagian 6.5](../pertemuan_12_clean_architecture/README.md#65-viewmodel-dan-view-membaca-hasil).

### `The method 'fromJson' isn't defined for the type 'Ruang'.`

**Penyebab:** `fromJson` sudah dipindah ke model API di lapisan data, tetapi pemanggilnya belum diubah.
**Solusi:** baca JSON lewat model API, lalu terjemahkan: `RuangApiModel.fromJson(json).keDomain()`. Lihat [Pertemuan 12, Bagian 5.3](../pertemuan_12_clean_architecture/README.md#53-langkah-2-model-api-menjadi-entitas).

### Lingkaran memuat berputar terus tanpa pesan, padahal *repository* sudah mengembalikan `Hasil`

**Penyebab:** ada *exception* yang tidak diterjemahkan, misalnya `on TimeoutException` terlupa di *repository*. *Exception* itu lolos ke ViewModel, sehingga baris sesudah `await` (yang mematikan lingkaran memuat) tidak pernah dijalankan.
**Solusi:** pastikan semua kode yang bisa gagal berada di dalam `try`, dan setiap jenis *exception* punya `on ...` sendiri. Lihat [Pertemuan 12, Bagian 6.4](../pertemuan_12_clean_architecture/README.md#64-repository-satu-satunya-penerjemah).

### Tombol tetap bertuliskan "Menyimpan..." dan tidak bisa diketuk lagi

**Penyebab:** Perintah dijalankan tanpa `try`–`finally`. Saat aksinya melempar *exception*, status `sedangBerjalan` tidak pernah dikembalikan menjadi `false`, dan penjaganya menolak semua ketukan berikutnya.
**Solusi:** kembalikan statusnya di blok `finally`: `try { _hasil = await aksi(); } finally { _sedangBerjalan = false; _kabari(); }`. Lihat [Pertemuan 12, Bagian 8.2](../pertemuan_12_clean_architecture/README.md#82-isi-class-perintah).

### `SnackBar` yang sama muncul berulang-ulang

**Penyebab:** `SnackBar` ditampilkan dari dalam `build()` (sering lewat `addPostFrameCallback`) berdasarkan hasil yang masih tersimpan. `build()` dipanggil ulang setiap kali layar berubah, misalnya saat sakelar diketuk, sehingga pesannya ikut terjadwal lagi.
**Solusi:** tampilkan `SnackBar` dari *listener*, sekali untuk setiap hasil, lalu panggil `bersihkanHasil()`. Lihat [Pertemuan 12, Bagian 8.4](../pertemuan_12_clean_architecture/README.md#84-memakai-perintah-di-viewmodel-dan-view).

### Pemeriksaan lulus hari ini, tetapi gagal besok

**Penyebab:** aturan bisnis memanggil `DateTime.now()` sendiri, sehingga hasilnya bergantung pada hari dan jam saat dijalankan.
**Solusi:** suntikkan "waktu sekarang" sebagai parameter (`required DateTime sekarang`) atau sebagai fungsi (`DateTime Function()? sekarang`), lalu pakai jam tetap saat memeriksa. Lihat [Pertemuan 12, Bagian 3.3](../pertemuan_12_clean_architecture/README.md#33-waktu-sekarang-sebagai-parameter).

---

## H. Masalah Fitur Perangkat dan Izin Akses

### `PermissionDefinitionsNotFoundException`

**Penyebab:** izin lokasi belum ditulis di `android/app/src/main/AndroidManifest.xml` (Android), atau kalimat alasannya belum ditulis di `ios/Runner/Info.plist` (iOS).
**Solusi:** tambahkan baris `ACCESS_COARSE_LOCATION` dan `ACCESS_FINE_LOCATION` (atau `NSLocationWhenInUseUsageDescription` untuk iOS), lalu hentikan aplikasi dan jalankan ulang. Lihat [Pertemuan 13, Bagian 3.2](../pertemuan_13_fitur_perangkat_dan_izin/README.md#32-android-androidmanifestxml) dan [Bagian 3.3](../pertemuan_13_fitur_perangkat_dan_izin/README.md#33-ios-infoplist).

### Tombol lokasi diketuk, tetapi tidak terjadi apa-apa (dialog izin tidak muncul)

**Penyebab:** izin sudah **diblokir** (`deniedForever`). Di Android, penolakan kedua dianggap permanen, sehingga `requestPermission()` langsung menjawab tanpa dialog, sedangkan aplikasi belum punya pesan untuk keadaan ini.
**Solusi:** tangani `deniedForever` dengan pesan dan tombol **Buka Pengaturan** (`Geolocator.openAppSettings()`). Untuk mencoba dialognya lagi, cabut izinnya lewat Pengaturan. Lihat [Pertemuan 13, Bagian 2.6](../pertemuan_13_fitur_perangkat_dan_izin/README.md#26-menjalankan-contoh-01) dan [Bagian 11.4](../pertemuan_13_fitur_perangkat_dan_izin/README.md#114-mengulang-dari-awal-mencabut-izin).

### Kamera tidak mau terbuka di Android, padahal galeri bisa

**Penyebab:** baris izin `CAMERA` tertulis di `AndroidManifest.xml`, tetapi belum diberikan pengguna. Dalam keadaan ini Android menolak membuka aplikasi kamera bawaan.
**Solusi:** hapus baris `android.permission.CAMERA` jika aplikasi hanya memakai `image_picker`. Lihat [Pertemuan 13, Bagian 3.2](../pertemuan_13_fitur_perangkat_dan_izin/README.md#32-android-androidmanifestxml).

### Aplikasi iOS tertutup sendiri saat kamera atau galeri dibuka

**Penyebab:** kalimat alasan `NSCameraUsageDescription` atau `NSPhotoLibraryUsageDescription` belum ditulis di `Info.plist`.
**Solusi:** tambahkan kalimat alasannya, lalu jalankan ulang. Lihat [Pertemuan 13, Bagian 3.3](../pertemuan_13_fitur_perangkat_dan_izin/README.md#33-ios-infoplist).

### `Unsupported operation` saat menampilkan foto di Chrome

**Penyebab:** foto ditampilkan dengan `Image.file(File(berkas.path))`. `File` berasal dari `dart:io`, yang tidak tersedia di web; di sana `berkas.path` hanyalah alamat sementara `blob:...`.
**Solusi:** baca isinya dengan `await berkas.readAsBytes()`, lalu tampilkan dengan `Image.memory(...)`, yang berjalan di semua platform. Lihat [Pertemuan 13, Bagian 4.4](../pertemuan_13_fitur_perangkat_dan_izin/README.md#44-membaca-dan-menampilkan-foto).

### Dialog izin lokasi tidak muncul di *browser*

**Penyebab:** izin situs itu pernah diblokir, atau halaman dibuka lewat alamat yang tidak aman (misalnya `http://` dengan alamat IP). Lokasi dan kamera hanya tersedia di HTTPS atau `localhost`.
**Solusi:** klik ikon di sebelah kiri alamat situs, lalu pilih **Reset izin**. Jalankan dengan `flutter run -d chrome`, yang memakai `localhost`. Lihat [Pertemuan 13, Bagian 3.4](../pertemuan_13_fitur_perangkat_dan_izin/README.md#34-web).

### Di Chrome, lokasi palsu selalu "kurang akurat (± 150 m)"

**Penyebab:** kolom **Accuracy** di Chrome DevTools → *Sensors* dibiarkan kosong, sehingga Chrome memakai akurasi 150 m.
**Solusi:** isi **Accuracy**, misalnya `10`. Lihat [Pertemuan 13, Bagian 11.1](../pertemuan_13_fitur_perangkat_dan_izin/README.md#111-chrome-devtools-sensors).

### Tombol lokasi berputar terus tanpa hasil

**Penyebab:** `getCurrentPosition` dipanggil tanpa batas waktu, sedangkan GPS sulit mendapat posisi di dalam gedung.
**Solusi:** beri `timeLimit` pada `LocationSettings`, tangkap `TimeoutException`, lalu tampilkan pesan seperti "Coba di dekat jendela atau di luar ruangan". Lihat [Pertemuan 13, Bagian 5.3](../pertemuan_13_fitur_perangkat_dan_izin/README.md#53-tiga-pemeriksaan-berurutan).

### Jarak ke kampus belasan ribu kilometer saat dicoba di emulator

**Penyebab:** lokasi bawaan emulator Android biasanya berada di Amerika Serikat.
**Solusi:** atur lokasinya lewat **Extended controls** (tombol ⋯) → **Location**. Lihat [Pertemuan 13, Bagian 11.2](../pertemuan_13_fitur_perangkat_dan_izin/README.md#112-emulator-android).

### Baterai cepat habis setelah memakai aplikasi yang mengikuti lokasi

**Penyebab:** langganan `getPositionStream` tidak dibatalkan, sehingga GPS tetap menyala walaupun halamannya sudah ditutup.
**Solusi:** panggil `cancel()` pada langganannya di tombol Berhenti **dan** di `dispose()`. Lihat [Pertemuan 13, Bagian 8.2](../pertemuan_13_fitur_perangkat_dan_izin/README.md#82-berlangganan-lalu-berhenti).

---

## I. Masalah Pengujian dan *Debugging*

### `No tests ran.` atau `flutter test` tidak menemukan tes

**Penyebab:** nama berkas tidak berakhiran `_test.dart`, atau berkasnya tidak berada di folder `test/`.
**Solusi:** ganti nama menjadi `nama_test.dart` dan letakkan di folder `test/`, lalu jalankan `flutter test`. Lihat [Pertemuan 14, Bagian 2.1](../pertemuan_14_pengujian_dan_debugging/README.md#21-folder-test-dan-paket-flutter_test).

### Tes lulus, padahal kodenya jelas salah, lalu muncul `This test failed after it had already completed.`

**Penyebab:** tes asinkron ditulis tanpa `async`/`await`, sehingga tes dianggap selesai (dan lulus) sebelum hasilnya diperiksa. Pesan kegagalannya baru muncul belakangan.
**Solusi:** tulis `() async { ... }` dan `await` di depan setiap `Future`, termasuk `await expectLater(...)`. Lihat [Pertemuan 14, Bagian 4.1](../pertemuan_14_pengujian_dan_debugging/README.md#41-tes-async-jangan-lupa-await).

### `expect(...)` dengan `throwsArgumentError` gagal karena *exception* yang justru sedang diuji

**Penyebab:** kodenya dijalankan **sebelum** `expect` bekerja, misalnya `expect(NilaiUjian(101), throwsArgumentError)`.
**Solusi:** bungkus dengan fungsi: `expect(() => NilaiUjian(101), throwsArgumentError)`. Lihat [Pertemuan 14, Bagian 3.2](../pertemuan_14_pengujian_dan_debugging/README.md#32-menguji-exception).

### Setelah `tap`, tes berkata `Found 0 widgets with text ...`

**Penyebab:** layar belum digambar ulang setelah `setState` atau `notifyListeners`.
**Solusi:** tambahkan `await tester.pump();` setelah setiap aksi (`tap`, `enterText`). Lihat [Pertemuan 14, Bagian 6.4](../pertemuan_14_pengujian_dan_debugging/README.md#64-aksi-mengetik-mengetuk-menggulir).

### `pumpAndSettle timed out`

**Penyebab:** ada animasi yang tidak pernah berhenti, biasanya `CircularProgressIndicator` yang terus berputar selama data belum datang.
**Solusi:** pakai `await tester.pump();`, atau buat data palsunya selesai lebih dulu sebelum memanggil `pumpAndSettle()`. Lihat [Pertemuan 14, Bagian 6.5](../pertemuan_14_pengujian_dan_debugging/README.md#65-pump-pumpdurasi-dan-pumpandsettle).

### `... ambiguously found multiple matching widgets. The "tap()" method needs a single target.`

**Penyebab:** *finder* menemukan lebih dari satu widget, misalnya tulisan "Simpan" ada di judul `AppBar` **dan** di tombol.
**Solusi:** pakai *finder* yang lebih spesifik: `find.byKey`, `find.byTooltip`, `find.widgetWithText(FilledButton, 'Simpan')`, atau `find.descendant`. Lihat [Pertemuan 14, Bagian 6.3](../pertemuan_14_pengujian_dan_debugging/README.md#63-finder-mencari-widget-di-layar).

### Peringatan `... would not hit test on the specified widget` saat mengetuk

**Penyebab:** widget yang diketuk berada di luar layar (misalnya di bagian bawah lembar formulir pada layar sempit) atau tertutup widget lain.
**Solusi:** gulir dulu sampai terlihat (`ensureVisible` atau `scrollUntilVisible`), lalu `pumpAndSettle()`, baru ketuk. Lihat [Pertemuan 14, Bagian 9.6](../pertemuan_14_pengujian_dan_debugging/README.md#96-satu-tes-untuk-seluruh-alur).

### `A Timer is still pending even after the widget tree was disposed.`

**Penyebab:** saat tes selesai, kode yang diuji masih menunggu `Future.delayed` atau *timer*, misalnya *repository* memori yang sengaja diberi jeda. Jam di tes widget adalah jam palsu; `pump()` tanpa durasi tidak memajukannya.
**Solusi:** pakai *repository* palsu **tanpa** jeda, atau majukan jam dengan `await tester.pump(const Duration(...))` sampai semua *timer* selesai. Lihat [Pertemuan 14, Bagian 9.5](../pertemuan_14_pengujian_dan_debugging/README.md#95-menepati-janji-tombol-ajukan-mati-selama-menyimpan).

### `A SemanticsHandle was active at the end of the test.`

**Penyebab:** `tester.ensureSemantics()` dipanggil di tes aksesibilitas, tetapi pegangannya tidak dilepas.
**Solusi:** panggil `pegangan.dispose()` di akhir tes. Lihat [Pertemuan 14, Bagian 7.7](../pertemuan_14_pengujian_dan_debugging/README.md#77-pedoman-aksesibilitas).

### Tes berikutnya ikut memakai layar 320 piksel atau huruf 200%

**Penyebab:** ukuran layar atau ukuran huruf diubah di dalam tes tanpa dikembalikan.
**Solusi:** tulis `addTearDown(tester.view.reset)` dan `addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue)` tepat setelah mengubahnya. Lihat [Pertemuan 14, Bagian 7.5](../pertemuan_14_pengujian_dan_debugging/README.md#75-layar-sempit-dan-huruf-besar).

### `MissingPluginException` saat menjalankan `flutter test`

**Penyebab:** tes memanggil *plugin* (misalnya `image_picker` atau `geolocator`) yang membutuhkan kode Android/iOS, padahal di lingkungan uji tidak ada HP.
**Solusi:** bungkus *plugin* di balik kontrak lalu pakai data palsu, atau palsukan objeknya dengan `Fake`. Lihat [Pertemuan 14, Bagian 8](../pertemuan_14_pengujian_dan_debugging/README.md#8-menguji-kode-yang-memakai-plugin).

### `LateInitializationError: Field '...' has not been initialized.`

**Penyebab:** variabel `late` dibaca sebelum pernah diisi, misalnya `late final TextEditingController _surel;` yang lupa dibuat.
**Solusi:** isi langsung saat dideklarasikan (`final TextEditingController _surel = TextEditingController();`) atau di `initState`. Baris kode Anda yang membacanya bisa dicari lewat *stack trace*. Lihat [Pertemuan 14, Bagian 10.5](../pertemuan_14_pengujian_dan_debugging/README.md#105-membaca-stack-trace).

### *Breakpoint* tidak pernah berhenti

**Penyebab:** aplikasi dijalankan tanpa *debugger*, misalnya dengan `flutter run` di terminal atau **Run Without Debugging** (`Ctrl` + `F5`).
**Solusi:** jalankan dengan **Run → Start Debugging** (`F5`) di VS Code. Untuk tes, klik **Debug** (bukan **Run**) di atas `test(` atau `testWidgets(`. Lihat [Pertemuan 14, Bagian 11.2](../pertemuan_14_pengujian_dan_debugging/README.md#112-breakpoint-pertama) dan [Bagian 11.6](../pertemuan_14_pengujian_dan_debugging/README.md#116-debugger-untuk-tes).

### `Don't use 'BuildContext's across async gaps.` di berkas tes

**Penyebab:** di dalam `testWidgets(... async { ... })`, sebuah `BuildContext` (misalnya hasil `tester.element(...)`) dipakai **sesudah** `await`. Aturan `use_build_context_synchronously` tidak bisa membedakan tes dari halaman sungguhan, jadi tetap memprotes. Tesnya hijau, tetapi `flutter analyze` (dan langkah **Analisis kode** di GitHub Actions) gagal.
**Solusi:** pindahkan pemakaian `BuildContext` ke fungsi bantu **tanpa** `async` di luar `main()`, misalnya `kecerahanTema(tester, find.text('Rina'))` yang berisi `Theme.of(tester.element(sasaran)).brightness`. Fungsi tanpa `async` tidak punya `await`, jadi tidak ada yang diprotes. Di halaman sungguhan (bukan tes), tetap gunakan `if (!mounted) return;` setelah `await`. Lihat [Pertemuan 14, Bagian 7.6](../pertemuan_14_pengujian_dan_debugging/README.md#76-mode-gelap).

### Tab **Actions** di GitHub bertanda ❌, padahal di laptop semua tes hijau

**Penyebab:** langkah **Analisis kode** gagal karena masih ada temuan `flutter analyze` (bahkan sekadar *info*), atau tes bergantung pada sesuatu yang hanya ada di laptop Anda (berkas lokal, jam, atau internet).
**Solusi:** buka langkah yang merah di halaman Actions, jalankan `flutter analyze` di laptop dan perbaiki semua temuannya, lalu pastikan tes memakai data palsu dan jam palsu. Lihat [Pertemuan 14, Bagian 14.2](../pertemuan_14_pengujian_dan_debugging/README.md#142-tes-otomatis-di-github-ci).

---

## J. Masalah *Build* dan Rilis

### APK rilis tidak bisa memuat data internet, padahal saat `flutter run` lancar

**Penyebab:** izin internet hanya ada di `AndroidManifest.xml` versi *debug* (dipakai `flutter run`). *Manifest* utama, yang dipakai *build* rilis, belum memuatnya.
**Solusi:** tambahkan `<uses-permission android:name="android.permission.INTERNET" />` di `android/app/src/main/AndroidManifest.xml`, di dalam `<manifest>` dan sebelum `<application>`, lalu *build* ulang. Lihat [Pertemuan 15, Bagian 10.2](../pertemuan_15_build_rilis_dan_finalisasi/README.md#102-sebelum-build-izin-internet-dan-teman-temannya).

### Situs di GitHub Pages hanya putih, dan konsol *browser* penuh galat 404

**Penyebab:** `--base-href` tidak diisi, atau tidak sama dengan nama repositori, sehingga aplikasi mencari berkasnya di alamat yang salah.
**Solusi:** `flutter build web --base-href "/nama-repositori/"` (diawali dan diakhiri `/`). Lebih mudah lagi, pakai `templat/web.yml`, yang mengisinya otomatis. Lihat [Pertemuan 15, Bagian 9.3](../pertemuan_15_build_rilis_dan_finalisasi/README.md#93-alamat-dasar---base-href).

### `build/web/index.html` diklik dua kali, tetapi layarnya kosong

**Penyebab:** *browser* tidak menjalankan aplikasi web dari alamat `file://`.
**Solusi:** jalankan *web server* kecil: `dart pub global activate dhttpd` (sekali saja), lalu `dhttpd --path build/web` dan buka `http://localhost:8080`. Lihat [Pertemuan 15, Bagian 9.2](../pertemuan_15_build_rilis_dan_finalisasi/README.md#92-mencoba-hasil-build-di-laptop).

### *Workflow* `web.yml` gagal di langkah **Terbitkan**

**Penyebab:** GitHub Pages belum diatur ke **Source: GitHub Actions**, atau repositorinya privat tanpa GitHub Pro.
**Solusi:** buka **Settings** → **Pages** → **Source**, pilih **GitHub Actions**, lalu jalankan ulang *workflow*-nya dari tab **Actions**. Lihat [Pertemuan 15, Bagian 9.4](../pertemuan_15_build_rilis_dan_finalisasi/README.md#94-terbit-otomatis-di-github-pages).

### Situs sudah diperbarui, tetapi yang tampil masih versi lama

**Penyebab:** *browser* dan GitHub Pages menyimpan salinan sementara (*cache*).
**Solusi:** tunggu sampai tanda centang hijau muncul di tab **Actions**, lalu muat ulang paksa dengan `Ctrl` + `Shift` + `R`. Lihat [Pertemuan 15, Bagian 9.5](../pertemuan_15_build_rilis_dan_finalisasi/README.md#95-hal-yang-perlu-diperhatikan-di-web).

### `Aplikasi tidak terpasang karena paket bentrok dengan paket yang sudah ada`

**Penyebab:** tanda tangan APK baru berbeda dengan aplikasi yang terpasang, misalnya APK lama di-*build* di laptop lain atau oleh robot GitHub dengan kunci *debug*.
**Solusi:** hapus dulu aplikasi lama dari HP. Untuk seterusnya, tanda tangani semua rilis dengan **kunci unggah yang sama**. Lihat [Pertemuan 15, Bagian 11.1](../pertemuan_15_build_rilis_dan_finalisasi/README.md#111-mengapa-aplikasi-ditandatangani).

### `flutter build apk` gagal di laptop teman atau di robot GitHub, dengan pesan yang menyebut *keystore* atau *signing config*

**Penyebab:** `build.gradle.kts` selalu memakai kunci rilis, padahal `key.properties` tidak ada di sana.
**Solusi:** pakai pola "kunci rilis jika `key.properties` ada, kunci *debug* jika tidak". Lihat [Pertemuan 15, Bagian 11.4](../pertemuan_15_build_rilis_dan_finalisasi/README.md#114-memberi-tahu-gradle-letak-kuncinya).

### `'keytool' is not recognized as an internal or external command`

**Penyebab:** `keytool` (bagian dari Java di Android Studio) tidak terdaftar di PATH.
**Solusi:** jalankan `flutter doctor -v`, cari baris **Java binary at:**, lalu panggil `keytool` dengan alamat lengkap dari folder yang sama. Lihat [Pertemuan 15, Bagian 11.3](../pertemuan_15_build_rilis_dan_finalisasi/README.md#113-membuat-kunci-unggah).

### `key.properties` atau berkas `.jks` muncul di `git status`

**Penyebab:** kunci disimpan di folder yang tidak diabaikan Git, atau isi `android/.gitignore` berubah.
**Solusi:** **jangan di-*commit***. Simpan berkas `.jks` di luar folder proyek, periksa dengan `git check-ignore -v android/key.properties`, dan perbaiki `android/.gitignore`. Kunci yang terlanjur di-*push* harus dianggap bocor. Lihat [Pertemuan 15, Bagian 11.5](../pertemuan_15_build_rilis_dan_finalisasi/README.md#115-menjaga-kunci-dua-aturan-mutlak).

### Berkas `.aab` tidak bisa dipasang di HP

**Penyebab:** *App Bundle* bukan APK; berkas ini harus diolah dulu oleh Google Play.
**Solusi:** bagikan APK (`flutter build apk`). Berkas `.aab` hanya untuk diunggah ke Google Play. Lihat [Pertemuan 15, Bagian 11.6](../pertemuan_15_build_rilis_dan_finalisasi/README.md#116-app-bundle-aab-untuk-google-play).

### Ikon di HP masih logo Flutter setelah `dart run flutter_launcher_icons`

**Penyebab:** peluncur HP masih menyimpan ikon lama.
**Solusi:** hapus aplikasi dari HP, lalu pasang lagi. Di Chrome, muat ulang paksa dengan `Ctrl` + `Shift` + `R`. Lihat [Pertemuan 15, Bagian 6.3](../pertemuan_15_build_rilis_dan_finalisasi/README.md#63-melihat-ikon-barunya).

### `Unsupported operation: String.fromEnvironment can only be used as a const constructor`

**Penyebab:** `String.fromEnvironment` (atau `int.`/`bool.fromEnvironment`) dipanggil tanpa `const`.
**Solusi:** tulis `const String nama = String.fromEnvironment('NAMA', defaultValue: '...');`. Lihat [Pertemuan 15, Bagian 3.3](../pertemuan_15_build_rilis_dan_finalisasi/README.md#33-membaca-nilainya-wajib-const).

### Nilai `--dart-define` tidak terbaca, selalu nilai bawaan

**Penyebab:** namanya berbeda (huruf besar dan kecil dibedakan), opsinya lupa ditulis saat `flutter build`, atau aplikasi hanya di-*hot reload* setelah nilainya diganti.
**Solusi:** samakan namanya persis, tulis opsi itu di `flutter run` **maupun** `flutter build`, dan hentikan aplikasi (`q`) lalu jalankan lagi setiap kali nilainya diganti. Lihat [Pertemuan 15, Bagian 3.2](../pertemuan_15_build_rilis_dan_finalisasi/README.md#32-memberi-nilai-dengan---dart-define).

### *Tag* sudah dibuat, tetapi *workflow* `rilis.yml` tidak berjalan

**Penyebab:** *tag* belum di-*push* (`git push` biasa tidak ikut mengirim *tag*), atau namanya tidak diawali `v`.
**Solusi:** `git push origin v1.0.0`. Lihat [Pertemuan 15, Bagian 12.1](../pertemuan_15_build_rilis_dan_finalisasi/README.md#121-tag-penanda-versi-di-riwayat-git).

### `rilis.yml` gagal membuat rilis: `Resource not accessible by integration`

**Penyebab:** izin `contents: write` terhapus dari *workflow*.
**Solusi:** kembalikan `permissions:` → `contents: write` seperti di `templat/rilis.yml`. Lihat [Pertemuan 15, Bagian 12.2](../pertemuan_15_build_rilis_dan_finalisasi/README.md#122-robot-yang-mem-build-apk-dan-membuat-halaman-rilis).

### Pengguna melihat kotak abu-abu kosong di aplikasi rilis

**Penyebab:** terjadi galat saat membangun widget. Di *build* rilis, layar merah berubah menjadi kotak abu-abu tanpa keterangan.
**Solusi:** pasang `ErrorWidget.builder` dan jaring pengaman galat agar galatnya tercatat, lalu perbaiki bug-nya dari laporan itu. Lihat [Pertemuan 15, Bagian 7.5](../pertemuan_15_build_rilis_dan_finalisasi/README.md#75-pengganti-layar-merah-yang-ramah).

### Galat asinkron di web tidak pernah tercatat

**Penyebab:** di web, galat asinkron yang lolos tidak sampai ke `PlatformDispatcher.instance.onError`.
**Solusi:** bungkus aplikasi dengan `runZonedGuarded`, dan panggil `WidgetsFlutterBinding.ensureInitialized()` serta `runApp()` di dalam zona yang sama. Lihat [Pertemuan 15, Bagian 7.4](../pertemuan_15_build_rilis_dan_finalisasi/README.md#74-di-web-tambahkan-runzonedguarded).

---

## K. Masalah Saat Presentasi dan Demo (UAS)

Masalah yang sering muncul saat gladi resik dan hari-H. Panduan lengkapnya ada di [Panduan UAS](../pertemuan_16_uas/README.md) dan [Gladi Resik](../pertemuan_16_uas/GLADI_RESIK.md).

### `ERROR: Could not find any ADB device` saat menjalankan `scrcpy`

**Penyebab:** HP belum terdeteksi laptop: Debugging USB belum aktif, kabelnya hanya untuk mengisi daya, atau (di Windows) *driver* USB HP belum terpasang.
**Solusi:** aktifkan Debugging USB ([Panduan Instalasi Bagian 7.3](02_instalasi_flutter_windows.md#73-menyambungkan-hp-android-lewat-kabel-usb)), ganti dengan kabel data, dan coba port USB lain. Periksa dengan `flutter devices`: HP Anda harus tercantum. Beberapa HP membutuhkan *driver* USB dari pabrikannya. Jika tetap gagal, demo dengan versi web di Chrome ([Panduan UAS Bagian 10](../pertemuan_16_uas/README.md#10-rencana-cadangan-saat-ada-kendala)).

### `ERROR: Device is unauthorized` saat menjalankan `scrcpy`

**Penyebab:** izin debugging USB dari laptop ini belum diterima di HP.
**Solusi:** buka kunci layar HP, lalu ketuk **Izinkan** pada pertanyaan *"Izinkan debugging USB?"* (centang *Selalu izinkan dari komputer ini*). Jika pertanyaannya tidak muncul, cabut kabel, matikan lalu nyalakan lagi Debugging USB, kemudian sambungkan ulang.

### `'scrcpy' is not recognized as an internal or external command`

**Penyebab:** terminal dibuka sebelum `scrcpy` dipasang, sehingga belum mengenal lokasinya; atau `scrcpy` dipasang manual dari berkas ZIP.
**Solusi:** tutup lalu buka lagi terminal setelah `winget install --exact Genymobile.scrcpy`. Untuk pemasangan manual, klik dua kali `open_a_terminal_here.bat` di folder `scrcpy`, lalu ketik perintahnya di terminal yang terbuka. Lihat [Panduan UAS Bagian 5.5](../pertemuan_16_uas/README.md#55-menampilkan-layar-hp-di-proyektor-dengan-scrcpy).

### Layar laptop tidak muncul di proyektor

**Penyebab:** mode tampilan Windows belum diatur, atau kabel HDMI dan adaptornya longgar.
**Solusi:** tekan `Windows` + `P`, lalu pilih **Duplikat** (*Duplicate*). Periksa kabel dan adaptor, lalu cabut dan pasang lagi. Cobalah di ruang ujian sebelum giliran Anda. Jika tetap gagal, demo langsung menghadap penguji.

### Tampilan di proyektor terpotong, atau hurufnya terlalu kecil dari belakang ruangan

**Penyebab:** resolusi proyektor lebih kecil daripada layar laptop, atau aplikasi web ditampilkan pada ukuran 100%.
**Solusi:** di Chrome, perbesar dengan `Ctrl` + `+` (kembali normal dengan `Ctrl` + `0`); jendela `scrcpy` bisa diperbesar seperti jendela biasa. Jika gambar terpotong, buka **Settings** → **System** → **Display**, lalu pilih resolusi yang didukung proyektor. Saat diperbesar, aplikasi Flutter web bisa berpindah ke tata letak layar sempit; itu justru bukti tampilannya responsif.

### Data dari API tidak muncul di jaringan kampus, padahal di rumah lancar

**Penyebab:** Wi-Fi kampus meminta *login* lewat halaman *browser* lebih dulu, memblokir alamat tertentu, atau sedang lambat.
**Solusi:** buka satu situs di *browser* untuk memastikan sudah *login* Wi-Fi; nyalakan *hotspot* dari HP lain; atau jalankan versi data palsu (`main_pengembangan.dart` atau `--dart-define=LINGKUNGAN=pengembangan`) sambil menjelaskan alasannya. Tunjukkan juga pesan ramah yang tampil saat gagal terhubung.

### Saat demo, aplikasi ternyata memakai data palsu (atau sebaliknya)

**Penyebab:** aplikasi dijalankan dengan titik masuk atau nilai `--dart-define` yang keliru.
**Solusi:** periksa perintahnya. Data asli: `flutter run -d chrome --release`. Data palsu: `flutter run -d chrome -t lib/main_pengembangan.dart` atau dengan `--dart-define=LINGKUNGAN=pengembangan`. Pita penanda seperti "BUILD UJI" membantu membedakan keduanya. Lihat [Pertemuan 15, Bagian 3.7](../pertemuan_15_build_rilis_dan_finalisasi/README.md#37-dua-titik-masuk-atau---dart-define).

### `flutter test` lama sekali saat diminta penguji

**Penyebab:** saat pertama kali dijalankan, tes harus dikompilasi dulu. Di laptop yang lambat, ini bisa lebih dari satu menit.
**Solusi:** jalankan `flutter test` sekali sebelum giliran, dan biarkan terminalnya tetap terbuka di folder proyek. Saat diminta penguji, hasilnya keluar jauh lebih cepat.

### Layar HP mati sendiri, atau notifikasi pribadi muncul di proyektor

**Penyebab:** waktu tunggu layar HP pendek, dan mode Jangan Ganggu belum aktif.
**Solusi:** jalankan `scrcpy --stay-awake`, perpanjang waktu tunggu layar HP (misalnya 10 menit), lalu aktifkan **Jangan Ganggu** di HP serta **Do not disturb** di Windows 11 (**Settings** → **System** → **Notifications**) atau **Focus assist** di Windows 10.

### Video demo cadangan tidak bisa diputar orang lain

**Penyebab:** tautan Google Drive hanya bisa dibuka pemiliknya, atau formatnya tidak didukung pemutar.
**Solusi:** ubah akses berbagi menjadi **Siapa saja yang memiliki link** (*Anyone with the link*), lalu coba buka dari akun atau HP lain. Rekam dalam format MP4, misalnya `scrcpy --record=demo_uas.mp4`, yang bisa diputar hampir semua perangkat. Lihat [Gladi Resik, Kegiatan 4](../pertemuan_16_uas/GLADI_RESIK.md#kegiatan-4--video-demo-cadangan).

### *Commit* saya tidak muncul di **Insights** → **Contributors** GitHub

**Penyebab:** GitHub mengenali pemilik *commit* dari **email** di `git config user.email`. Jika email di laptop Anda tidak terdaftar di akun GitHub, *commit* itu tidak dihitung sebagai milik Anda, walaupun tetap ada di riwayat.
**Solusi:** lihat nama dan email setiap *commit* dengan `git shortlog -sne`. Tambahkan email itu di GitHub (**Settings** → **Emails**), atau samakan `git config --global user.email` dengan email akun untuk *commit* berikutnya. Jika satu orang memakai beberapa nama atau email, tuliskan di [`KONTRIBUSI_TIM.md`](../pertemuan_16_uas/templat/KONTRIBUSI_TIM.md).

---

## Masih Belum Terpecahkan?

1. Jalankan `flutter doctor -v` dan simpan hasilnya.
2. Cari pesan error Anda di [halaman troubleshooting resmi Flutter](https://docs.flutter.dev/install/troubleshoot).
3. Tanyakan ke dosen atau asisten dengan [format pertanyaan yang baik](01_cara_belajar.md#8-cara-bertanya-yang-baik), sertakan hasil `flutter doctor -v` dan *screenshot*.

[🏠 Beranda](../README.md)

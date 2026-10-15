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

Lihat tabel lengkap di [Pertemuan 2, Bagian 15](../pertemuan_02_dasar_dart/README.md#15-kesalahan-umum-pemula-dan-solusinya) (variabel, tipe data, *null safety*), [Pertemuan 3, Bagian 14](../pertemuan_03_dart_lanjutan/README.md#14-kesalahan-umum-pemula-dan-solusinya) (*class*, pewarisan, *exception*, `Future`, dan `Stream`), [Pertemuan 4, Bagian 15](../pertemuan_04_widget_dan_layout/README.md#15-kesalahan-umum-pemula-dan-solusinya) (`child`/`children`, `Expanded`, *overflow*, dan *constraints*), [Pertemuan 5, Bagian 14](../pertemuan_05_interaksi_dan_state/README.md#14-kesalahan-umum-pemula-dan-solusinya) (`setState`, siklus hidup, *controller*, formulir, dan dialog), [Pertemuan 6, Bagian 15](../pertemuan_06_daftar_dan_navigasi/README.md#15-kesalahan-umum-pemula-dan-solusinya) (`ListView`, `Dismissible`, pencarian, `Navigator`, dan `go_router`), [Pertemuan 7, Bagian 17](../pertemuan_07_material3_dan_responsif/README.md#17-kesalahan-umum-pemula-dan-solusinya) (tema, peran warna, mode gelap, *breakpoint*, dan navigasi adaptif), [Pertemuan 9, Bagian 15](../pertemuan_09_state_dan_mvvm/README.md#15-kesalahan-umum-pemula-dan-solusinya) (`ChangeNotifier`, `provider`, MVVM, dan *repository*), [Pertemuan 10, Bagian 15](../pertemuan_10_async_dan_rest_api/README.md#15-kesalahan-umum-pemula-dan-solusinya) (paket `http`, JSON, `FutureBuilder`, galat jaringan, dan CORS), dan [Pertemuan 11, Bagian 14](../pertemuan_11_penyimpanan_lokal/README.md#14-kesalahan-umum-pemula-dan-solusinya) (`shared_preferences`, SQLite, migrasi, transaksi, dan *cache*).

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

**Penyebab:** paket yang membawa bagian asli (*plugin*), misalnya `shared_preferences` atau `sqflite`, baru dipasang saat aplikasi sedang berjalan. *Hot reload* dan *hot restart* tidak memuat bagian aslinya.
**Solusi:** hentikan aplikasi (tekan `q` di terminal), lalu jalankan lagi dengan `flutter run`. Lihat [Pertemuan 11, Bagian 2.1](../pertemuan_11_penyimpanan_lokal/README.md#21-memasang-paket).

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

---

## Masih Belum Terpecahkan?

1. Jalankan `flutter doctor -v` dan simpan hasilnya.
2. Cari pesan error Anda di [halaman troubleshooting resmi Flutter](https://docs.flutter.dev/install/troubleshoot).
3. Tanyakan ke dosen atau asisten dengan [format pertanyaan yang baik](01_cara_belajar.md#8-cara-bertanya-yang-baik), sertakan hasil `flutter doctor -v` dan *screenshot*.

[🏠 Beranda](../README.md)

SLIDE DECK MATERI AJAR: PERTEMUAN 06 - 08
## Fase 2: State Management, Clean Architecture, & Evaluasi UTS

---

# PERTEMUAN 06: State Management Reaktif (Cubit & BLoC Pattern)

---

### Slide 1: Cover Utama & Sub-CPMK 6
* **Mata Kuliah:** Pemrograman Piranti Bergerak (Flutter & Dart 2026).
* **Capaian Sub-CPMK 6:** Mahasiswa mampu memecahkan masalah state management, memisahkan logika bisnis dari UI, dan mengimplementasikan arsitektur reaktif menggunakan `flutter_bloc` & `Cubit`.
* **Fokus Praktikum:** Immutability, `Equatable`, `BlocProvider`, `BlocBuilder`, `BlocListener`, `BlocConsumer`, `BlocSelector`, dan `BlocObserver`.
* **Tautan Kode Sumber:** Tersedia 18 berkas mandiri siap run di folder `07_contoh_kode_program/pertemuan_06_state_management_cubit/`.

### Slide 2: Setup & Alat Bantu: flutter_bloc & Ekstensi VS Code
* **Analogi Alat:** Memasang mesin pabrik modern di bengkel kita agar tidak merakit roda gigi manual dari nol.
* **Perintah Terminal:** Jalankan `flutter pub add flutter_bloc equatable` di root proyek Flutter.
* **Ekstensi Resmi VS Code:** Pasang ekstensi 'Bloc' oleh Felix Angelov untuk auto-generate class Cubit dan State dalam 1 detik.
* **Shortcut Ajaib:** Cukup tekan `Alt + Enter` pada widget, lalu pilih "Wrap with BlocBuilder" atau "Wrap with BlocListener".
* **Contoh Kode:**
  ```dart
  // pubspec.yaml:
  dependencies:
    flutter_bloc: ^8.1.6
    equatable: ^2.0.5

  // Import resmi:
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:equatable/equatable.dart';
  ```
* **Tips Praktikum:** Ekstensi VS Code Bloc menghemat waktu mengetik boilerplate hingga 90%!

### Slide 3: The State Problem: Ephemeral State vs App State
* **Analogi Kunci:** Kunci kamar tidur (Ephemeral) hanya Anda yang pakai. Kunci gerbang utama (App State) dipakai bersama seluruh penghuni kompleks.
* **Ephemeral State:** Data lokal sementara yang hanya dibutuhkan oleh 1 widget saja (misal: status animasi, dropdown buka/tutup). Cukup dikelola `setState()`.
* **App State:** Data penting yang digunakan bersama di banyak halaman (misal: item keranjang belanja, status login pengguna, tema aplikasi).
* **Aturan Emas:** Gunakan `setState()` untuk Ephemeral State, dan WAJIB gunakan Cubit/BLoC untuk App State!
* **Contoh Kode:**
  ```dart
  // 1. Ephemeral State: Cukup setState lokal
  bool _isCardOpen = false;

  // 2. App State: Wajib dikelola Cubit bersama
  class CartCubit extends Cubit<int> {
    CartCubit() : super(0);
    void tambahItem() => emit(state + 1);
  }
  ```
* **Tips Praktikum:** Jangan gunakan BLoC untuk status lokal sederhana seperti warna tombol saat ditekan; gunakan BLoC untuk data lintas halaman!

### Slide 4: [DIAGRAM MENTAL MODEL 1] Spektrum Pengelolaan State: Ephemeral vs App State
* **Aset Diagram Visual:** `state-spectrum.png` (Rasio Lebar Penuh 16:9).
* **Alur Mental Mahasiswa:**
  - **Sisi Kiri (Ephemeral):** Hidup di dalam 1 widget via `setState()`, hancur otomatis saat widget di-*dispose*. Contoh: animasi tombol, toggle mata password.
  - **Sisi Kanan (App State):** Hidup di memori global via `Cubit/BLoC`, dibagikan lintas halaman dan tidak hilang saat navigasi rute berpindah. Contoh: keranjang belanja, sesi login.
* **Panduan Dosen:** Jangan over-engineering menggunakan BLoC untuk animasi tombol lokal, tetapi jangan pernah membagikan `setState()` melewati lebih dari 2 halaman!

### Slide 5: Keterbatasan setState() & Bahaya Prop Drilling
* **Analogi Kurir Berantai:** Kakek ingin menitipkan surat ke Cucu, tetapi terpaksa menitipkannya ke Ayah yang sama sekali tidak peduli isi surat tersebut.
* **Prop Drilling:** Mengoper data dan fungsi callback melewati 5 lapisan widget hanya agar tombol di widget cucu bisa mengubah data di kakek.
* **Boros Performa:** Memanggil `setState()` di widget atas memaksa seluruh pohon widget di bawahnya di-rebuild tanpa alasan.
* **Tidak Bisa Diuji:** Logika perhitungan bisnis terkunci rapat di dalam kode antarmuka UI dan mustahil diuji dengan Unit Test murni.
* **Contoh Masalah:**
  ```dart
  LevelKakek(
    child: LevelAyah(
      counter: _counter,       // Dititipkan saja
      onIncrement: _increment, // Dititipkan saja
      child: LevelCucu(...),   // Konsumen sesungguhnya
    ),
  );
  ```
* **Tips Praktikum:** Prop Drilling membuat kode rapuh! Sekali widget perantara diubah, rantai data aplikasi akan patah semua.

### Slide 6: [DIAGRAM ARSITEKTUR 2] Bahaya Prop Drilling vs Distribusi Terpusat (BlocProvider)
* **Aset Diagram Visual:** `prop-drilling-vs-provider.png` (Pohon Widget Berantai vs Terminal Terpusat).
* **Alur Mental Mahasiswa:**
  - **Sisi Kiri (Prop Drilling Merah):** Parameter dialirkan berantai: `LayarUtama(cart)` ➔ `DaftarProduk(cart)` ➔ `ItemCard(cart)` ➔ `TombolBeli(cart)`. Setiap modifikasi merusak semua konstruktor perantara!
  - **Sisi Kanan (BlocProvider Hijau):** `BlocProvider` diletakkan di puncak ranting pohon; widget `TombolBeli` dan `BadgeCart` langsung mengakses data via `context.read()` tanpa perantara.
* **Panduan Dosen:** Jika Anda mengoper parameter yang sama melewati lebih dari 2 widget turunan, itu sinyal merah darurat untuk segera me-refactor kode ke Cubit!

### Slide 7: Mental Model Cubit: Pabrik Radio & Konsep Stream Reaktif
* **Analogi Pabrik Radio:** Cubit bertindak sebagai stasiun pemancar. Widget UI adalah radio penerima yang mendengarkan siaran frekuensi.
* **Konsep Stream & Reaktif:** Di balik layar, Cubit adalah pipa aliran data (*Dart Stream*). Setiap `emit()` mengalirkan data baru ke widget secara instan.
* **Cubit vs BLoC:** Cubit memakai fungsi langsung (*Functions in -> States out*, 90% kasus industri). BLoC memakai objek Event (*Events in -> States out*, untuk live search / debounce).
* **Otak vs Otot:** Cubit murni logika bisnis Dart tanpa widget; UI murni bertugas menggambar pixel ke layar tanpa logika data.
* **Contoh Kode:**
  ```dart
  class CounterCubit extends Cubit<int> {
    CounterCubit() : super(0); // Frekuensi awal

    void tambah() => emit(state + 1); // Pancarkan
    void kurang() => emit(state - 1);
  }
  ```
* **Tips Praktikum:** Gunakan Cubit untuk 90% fitur aplikasi! Beralihlah ke full BLoC hanya jika Anda butuh debounce pada Live Search Bar.

### Slide 8: [DIAGRAM KOMPARASI 3] Perbandingan Alur Kerja: Cubit vs BLoC Penuh
* **Aset Diagram Visual:** `cubit-vs-bloc.png` (Pipeline Ringkas vs Event-Driven Stream).
* **Alur Mental Mahasiswa:**
  - **Pipeline Cubit:** `UI Screen` ➔ Panggil Fungsi `cubit.tambah()` ➔ Eksekusi Logika & `emit(state + 1)` ➔ `UI Rebuild`. Sangat cepat, minim baris kode (*low boilerplate*).
  - **Pipeline BLoC:** `UI Screen` ➔ Kirim Event `bloc.add(Event)` ➔ Masuk Antrean Stream & Filter Debounce ➔ `on<Event>` memproses ➔ `emit(State)` ➔ `UI Rebuild`.
* **Panduan Dosen:** Selalu mulai dengan Cubit di awal proyek! Beralih ke BLoC penuh hanya jika Anda butuh proteksi spam transaksi atau live-search debounce.

### Slide 9: Immutability & Equatable: Stempel Cetak Ulang KTP
* **Analogi KTP:** Jangan mencoret data KTP lama saat Anda pindah rumah; cetaklah blanko KTP baru yang bersih (Immutable / Tidak Berubah).
* **Larangan Mutasi:** Dilarang mengubah properti objek secara langsung (misal: `state.poin = 100`). Flutter BLoC tidak akan mendeteksi perubahannya!
* **Method `copyWith()`:** Cara resmi membuat salinan objek baru dengan mengganti nilai spesifik yang diinginkan.
* **Peran Equatable:** Membandingkan isi nilai objek, bukan referensi memori, sehingga mencegah render ulang yang mubazir.
* **Contoh Kode:**
  ```dart
  class UserState extends Equatable {
    final String nama;
    final int poin;

    const UserState({required this.nama, required this.poin});

    UserState copyWith({String? nama, int? poin}) {
      return UserState(
        nama: nama ?? this.nama,
        poin: poin ?? this.poin,
      );
    }

    @override
    List<Object?> get props => [nama, poin];
  }
  ```
* **Tips Praktikum:** Selalu gunakan `extends Equatable` pada kelas State Anda agar Flutter BLoC tahu persis kapan data benar-benar berubah!

### Slide 10: Anatomi Kelas Cubit & Fungsi emit()
* **Analogi Manajer Gudang:** Saat barang baru masuk ke gudang, manajer mengumumkan lewat mikrofon `emit()` ke seluruh staf kasir toko.
* **Pewarisan `Cubit<T>`:** Kelas Cubit wajib mewarisi `Cubit<NamaState>` dan memanggil `super(initialState)` di konstruktornya.
* **Fungsi Sakti `emit()`:** Satu-satunya jalan legal untuk memperbarui data state dan memberitahu widget UI agar menggambar ulang.
* **Hak Akses Terlindungi:** `emit()` bersifat protected—hanya bisa dipanggil dari dalam method internal Cubit itu sendiri.
* **Contoh Kode:**
  ```dart
  class CartCubit extends Cubit<CartState> {
    CartCubit() : super(const CartState(total: 0));

    void beliBarang(int harga) {
      // Memancarkan state baru ke seluruh aplikasi:
      emit(state.copyWith(total: state.total + harga));
    }
  }
  ```
* **Tips Praktikum:** Dilarang emit() jika nilai sama, dan selalu periksa `if (!isClosed) emit(...)` pada proses asynchronous agar bebas dari bug StateError!

### Slide 11: [FLOWCHART KUNCI 4] Siklus Tertutup Unidirectional Data Flow (UDF) & Reaktivitas UI
* **Aset Diagram Visual:** `bloc-udf-flow.png` (Siklus Tertutup UI ➔ Event ➔ BLoC ➔ State ➔ Rebuild).
* **Alur Mental Mahasiswa:**
  1. Pengguna menekan tombol "Tambah Produk" di `UI Screen`.
  2. Tombol memicu aksi satu arah: `context.read<CartBloc>().add(AddToCart(item))`.
  3. BLoC menerima event pada handler `on<AddToCart>`, memvalidasi logika, dan memanggil `emit(CartLoaded(items))`.
  4. Stream State baru mengalir ke antarmuka: `BlocBuilder` menggambar ulang pixel daftar barang, dan `BlocListener` memunculkan SnackBar hijau.
* **Panduan Dosen:** Data hanya boleh mengalir satu arah! UI dilarang keras mengubah variabel logika secara langsung.

### Slide 12: BlocProvider & Context: Terminal Colokan Listrik Dinding
* **Analogi Colokan Listrik:** Pasang stopkontak di dinding kamar (`BlocProvider`). Alat elektronik apa pun (Widget anak) tinggal colok ke stopkontak.
* **Pohon Widget:** `BlocProvider(create: (ctx) => MyCubit(), child: ...)` menempatkan instance Cubit agar hidup di ranting widget.
* **`context.read<T>()`:** Digunakan di dalam tombol aksi (`onPressed`) untuk memicu method Cubit tanpa mendengarkan perubahan data.
* **`context.watch<T>()`:** Mendengarkan perubahan data terus-menerus dan me-rebuild widget saat data baru terpancar.
* **Contoh Kode:**
  ```dart
  // 1. Menyediakan Cubit ke widget anak:
  BlocProvider(
    create: (context) => CounterCubit(),
    child: const CounterPage(),
  );

  // 2. Memanggil method Cubit saat tombol diklik:
  FilledButton(
    onPressed: () => context.read<CounterCubit>().tambah(),
    child: const Icon(Icons.add),
  );
  ```
* **Tips Praktikum:** Gunakan `context.read` di dalam tombol aksi `onPressed`, dan gunakan `context.watch` hanya di dalam method `build()`!

### Slide 13: [MATRIKS KEPUTUSAN 5] Kuadran Keputusan 4 Widget Utama BLoC: Kapan Menggunakan Apa?
* **Aset Diagram Visual:** `bloc-widgets-quadrant.png` (Matriks 2x2: Builder, Listener, Consumer, Selector).
* **Alur Mental Mahasiswa:**
  - **Kuadran 1 (`BlocBuilder`):** HANYA untuk menggambar visual UI pixel (Text, ListView, Container). Rebuild berkali-kali.
  - **Kuadran 2 (`BlocListener`):** HANYA untuk aksi 1 kali / *Side Effect* (SnackBar, Dialog konfirmasi, `context.go`). Tidak rebuild UI.
  - **Kuadran 3 (`BlocConsumer`):** Kombinasi Builder + Listener dalam 1 widget ringkas (misal: tombol Login).
  - **Kuadran 4 (`BlocSelector`):** Filter 1 properti spesifik agar performa tinggi (misal: badge keranjang di AppBar).
* **Panduan Dosen:** Dilarang keras menaruh `showDialog()` di dalam `BlocBuilder`! Gunakan selalu `BlocListener` untuk feedback pop-up.

### Slide 14: BlocBuilder & buildWhen: Layar TV Menyala Hanya Saat Acara Cocok
* **Analogi TV Pintar:** Layar TV yang hanya menyala saat acara favorit Anda mulai tayang, bukan menyala setiap detik.
* **Peran `BlocBuilder`:** Menggambar ulang widget antarmuka setiap kali Cubit memancarkan state baru.
* **Optimasi `buildWhen`:** Filter kondisi cerdas `(prev, curr) => curr % 5 == 0`. Mencegah render ulang jika syarat belum terpenuhi.
* **Pantangan Keras:** DILARANG menampilkan SnackBar, Dialog, atau Navigasi halaman di dalam `BlocBuilder`!
* **Contoh Kode:**
  ```dart
  BlocBuilder<StepCubit, int>(
    // Hanya rebuild jika angka kelipatan 5:
    buildWhen: (previous, current) => current % 5 == 0,
    builder: (context, step) {
      return Text('Milestone Kelipatan 5: $step');
    },
  );
  ```
* **Tips Praktikum:** Bungkus hanya widget kecil yang membutuhkan data, jangan membungkus seluruh Scaffold dengan BlocBuilder!

### Slide 15: BlocListener & listenWhen: Bunyi Klakson Notifikasi
* **Analogi Notifikasi WA:** Anda tidak perlu menatap layar terus; saat pesan penting masuk, nada dering 'ting' berbunyi tepat 1 kali.
* **Penanganan Side Effects:** Tempat resmi memanggil aksi satu kali, seperti memunculkan SnackBar, Dialog galat, atau Navigasi rute.
* **Bebas Duplikasi:** Berbeda dengan builder yang bisa terpanggil berulang kali, listener hanya dieksekusi tepat 1 kali per transisi state.
* **Filter `listenWhen`:** Hanya mendengarkan saat kondisi tertentu terjadi (misal: saat status berubah menjadi kode sukses 200).
* **Contoh Kode:**
  ```dart
  BlocListener<FormCubit, int>(
    listenWhen: (prev, curr) => curr == 200,
    listener: (context, code) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pendaftaran Berhasil!')),
      );
    },
    child: const FormInputWidget(),
  );
  ```
* **Tips Praktikum:** Gunakan BlocListener saat ingin memindahkan halaman pengguna (`context.go`) setelah sukses login!

### Slide 16: BlocConsumer: Duo Komentator & Papan Skor Pertandingan
* **Analogi Stadion Bola:** Papan skor mencatat gol (builder), sementara komentator mengumumkan gol lewat peluit (listener).
* **Dua Fungsi Bersatu:** Menggabungkan `BlocBuilder` dan `BlocListener` ke dalam satu widget ringkas tanpa tumpukan bersarang.
* **Parameter `listener`:** Untuk menampilkan pesan umpan balik SnackBar atau navigasi rute.
* **Parameter `builder`:** Untuk menggambar tampilan visual tombol, teks skor, atau ikon status.
* **Contoh Kode:**
  ```dart
  BlocConsumer<LoginCubit, bool>(
    listener: (context, isLoggedIn) {
      if (isLoggedIn) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selamat Datang!')),
        );
      }
    },
    builder: (context, isLoggedIn) {
      return FilledButton(
        onPressed: () => context.read<LoginCubit>().toggle(),
        child: Text(isLoggedIn ? 'Logout' : 'Login'),
      );
    },
  );
  ```
* **Tips Praktikum:** Gunakan BlocConsumer pada tombol autentikasi login atau proses checkout keranjang belanja!

### Slide 17: BlocSelector: Lensa Kamera Zoom ke Objek Tertentu
* **Analogi Lensa Zoom:** Memotret burung di dahan pohon tanpa peduli daun-daun di sekitarnya bergoyang tertiup angin.
* **Ekstraksi Properti Spesifik:** Jika State Anda memiliki 10 properti data, `BlocSelector` hanya memantau 1 nilai saja.
* **Efisiensi Tingkat Tinggi:** Widget nama pengguna tidak akan pernah di-rebuild meskipun saldo atau usia pengguna berubah ratusan kali.
* **Skala Enterprise:** Kunci utama menjaga aplikasi Flutter tetap berjalan mulus 60-120 FPS tanpa lag.
* **Contoh Kode:**
  ```dart
  BlocSelector<ProfilCubit, ProfilData, String>(
    selector: (state) => state.nama, // Hanya pantau 'nama'
    builder: (context, nama) {
      return Text('Nama Pengguna: $nama');
    },
  );
  ```
* **Tips Praktikum:** BlocSelector adalah senjata rahasia saat aplikasi memiliki formulir raksasa dengan puluhan field input!

### Slide 18: Arsitektur 4 Status UI: Empat Indikator Mesin Cuci
* **Analogi Mesin Cuci:** Siap (Initial), Sedang Mencuci (Loading), Selesai (Success), atau Air Mampet (Error).
* **Pola Baku Industri:** Seluruh interaksi data dan API wajib dimodelkan ke dalam 4 state terpisah yang jelas (*sealed class*).
* **DataInitial & DataLoading:** Kondisi saat layar baru dibuka atau proses sedang berlangsung.
* **DataSuccess & DataError:** Menjamin pengguna mendapatkan data atau pesan kesalahan yang transparan.
* **Contoh Kode:**
  ```dart
  sealed class DataState extends Equatable {}
  class DataInitial extends DataState { ... }
  class DataLoading extends DataState { ... }
  class DataSuccess extends DataState { final List items; ... }
  class DataError extends DataState { final String pesan; ... }

  // Di UI, tangani dengan pola switch ekspresif Dart 3:
  return switch (state) {
    DataInitial() => const Text('Tekan Tombol'),
    DataLoading() => const CircularProgressIndicator.adaptive(),
    DataSuccess(:final items) => ListView(...),
    DataError(:final pesan) => Text('Galat: $pesan'),
  };
  ```
* **Tips Praktikum:** Gunakan switch expression Dart modern untuk memastikan seluruh status UI tertangani secara tuntas!

### Slide 19: Proteksi Spam Klik: Transformer bloc_concurrency
* **Masalah Spam Transaksi:** Pengguna panik mengetuk tombol bayar 5 kali cepat, server menerima 5 transaksi duplikat!
* **Solusi `droppable()`:** Mengabaikan event baru yang masuk saat proses sebelumnya belum selesai (Wajib untuk Fintech).
* **Solusi `restartable()`:** Membatalkan pencarian lama dan langsung menjalankan pencarian terbaru saat user mengetik di search bar.
* **Paket Resmi:** Cukup pasang pustaka resmi `bloc_concurrency` oleh tim inti Flutter BLoC.
* **Contoh Kode:**
  ```dart
  import 'package:bloc_concurrency/bloc_concurrency.dart';

  class SearchBloc extends Bloc<SearchEvent, SearchState> {
    SearchBloc() : super(SearchInitial()) {
      // 1. Debounce pencarian: batalkan yang lama
      on<QueryChanged>(_onSearch, transformer: restartable());

      // 2. Proteksi checkout: abaikan klik dobel
      on<PayPressed>(_onCheckout, transformer: droppable());
    }
  }
  ```
* **Tips Praktikum:** Terapkan `droppable()` pada tombol transaksi uang agar saldo pengguna tidak terpotong dua kali!

### Slide 20: [DIAGRAM KONKURENSI 6] Mode Konkurensi Event: Melindungi Sistem dari Spam Klik
* **Aset Diagram Visual:** `bloc-concurrency-modes.png` (Visualisasi droppable vs restartable).
* **Alur Mental Mahasiswa:**
  - **`droppable()`:** Event 1 masuk ➔ diproses. Event 2 & 3 masuk saat proses sibuk ➔ otomatis di-*DROP* (diabaikan).
  - **`restartable()`:** Event 1 sedang jalan ➔ Event 2 masuk ➔ Event 1 langsung dibatalkan, Event 2 dijalankan.
* **Panduan Dosen:** Di industri profesional, penanganan konkurensi membedakan developer amatir dari *senior engineer* yang peduli integritas transaksi perbankan.

### Slide 21: MultiBlocProvider: Panel Saklar Listrik Rumah Terpusat
* **Analogi Panel MCB:** Di meteran listrik rumah tangga, ada saklar untuk kulkas, AC, dan lampu di dalam 1 kotak rapi.
* **Kebutuhan Nyata:** Aplikasi riil membutuhkan banyak Cubit sekaligus (AuthCubit, CartCubit, ThemeCubit, NotifCubit).
* **Mencegah Piramida Neraka:** Menghindari susunan bersarang 'BlocProvider di dalam BlocProvider di dalam BlocProvider'.
* **Pasang di Root:** Tempatkan `MultiBlocProvider` di atas MaterialApp agar semua halaman memiliki akses data yang sama.
* **Contoh Kode:**
  ```dart
  MultiBlocProvider(
    providers: [
      BlocProvider<AuthCubit>(create: (ctx) => AuthCubit()),
      BlocProvider<CartCubit>(create: (ctx) => CartCubit()),
      BlocProvider<ThemeCubit>(create: (ctx) => ThemeCubit()),
    ],
    child: const MainApp(),
  );
  ```
* **Tips Praktikum:** Daftarkan seluruh Cubit global di MultiBlocProvider pada file main.dart aplikasi Anda!

### Slide 22: Pemantauan Global dengan BlocObserver
* **Analogi CCTV Satpam:** Kamera pemantau yang mencatat siapa pun yang keluar-masuk gedung tanpa mengganggu aktivitas staf.
* **Melacak Perubahan Global:** `BlocObserver` menangkap setiap kali ada Cubit yang memanggil `emit()` di seluruh aplikasi.
* **Logging Otomatis di Terminal:** Mencetak 'CartCubit: state lama -> state baru' secara otomatis tanpa menulis `print()` manual.
* **Deteksi Galat Terpusat:** Method `onError()` menangkap error logika unhandled sebelum aplikasi sempat mengalami crash.
* **Contoh Kode:**
  ```dart
  class AppBlocObserver extends BlocObserver {
    @override
    void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
      super.onChange(bloc, change);
      debugPrint('[CCTV] ${bloc.runtimeType}: '
          '${change.currentState} -> ${change.nextState}');
    }
  }

  void main() {
    Bloc.observer = AppBlocObserver(); // Pasang CCTV
    runApp(const MyApp());
  }
  ```
* **Tips Praktikum:** BlocObserver menghemat waktu debugging Anda hingga 80% saat mencari sumber kesalahan logika data!

### Slide 23: Refactoring Nyata: Operasi Bedah Memisahkan Otak dari Otot
* **Analogi Operasi Medis:** Mengambil tumor logika yang menempel di organ UI dan memindahkannya ke wadah steril tersendiri.
* **Bersihkan StatefulWidget:** Ubah widget menjadi `StatelessWidget` sederhana yang murni bertugas menggambar antarmuka.
* **Bungkus Data ke Cubit:** Pindahkan variabel `Set<String> wishlist` dan fungsi `toggle()` ke dalam file `WishlistCubit`.
* **Hasil Akhir:** UI menjadi sangat bersih, reaktif, mudah dibaca rekan tim, dan siap dihubungkan ke database online!
* **Contoh Kode:**
  ```dart
  // SESUDAH (Cubit bersih & modular):
  class WishlistCubit extends Cubit<Set<String>> {
    WishlistCubit() : super({});
    void toggle(String id) {
      final updated = Set<String>.from(state);
      updated.contains(id) ? updated.remove(id) : updated.add(id);
      emit(updated);
    }
  }
  ```
* **Tips Praktikum:** Refactoring dari setState ke Cubit adalah ujian keterampilan nomor 1 pada sesi Live Code Defense UTS!

### Slide 24: [MATRIKS INDUSTRI 7] Matriks Keputusan State Management 2026
* **Aset Diagram Visual:** `comparison-matrix-state.png` (Provider vs Riverpod 2.x vs BLoC/Cubit).
* **Alur Mental Mahasiswa:**
  - **Provider:** Paling sederhana untuk belajar, tetapi rentan keterikatan `BuildContext` dan *ProviderNotFoundException*.
  - **Riverpod 2.x:** Pilihan favorit startup cepat, bebas `BuildContext`, sangat baik dalam penanganan asinkron jaringan via `AsyncValue`.
  - **BLoC / Cubit:** Standar mutlak perbankan, fintech, dan aplikasi *mission-critical* karena jejak audit `BlocObserver` dan alur UDF yang deterministik.
* **Panduan Dosen:** Kuasai Cubit & BLoC untuk perkuliahan semester ini; pemisahan mutlak logika bisnis dari UI akan menjadi modal utama saat Anda menghadapi *live coding interview* industri!

### Slide 25: Checklist 5 Aturan Emas State Management 2026
* **1. State Wajib Immutable:** Selalu extends Equatable dan gunakan copyWith() untuk membuat data baru.
* **2. Dilarang Memanggil Side Effect di BlocBuilder:** Gunakan BlocListener khusus untuk SnackBar & Navigasi.
* **3. Gunakan context.read() di Event Callback:** Hanya gunakan context.watch() saat membaca nilai untuk tampilan UI.
* **4. Pasang BlocObserver di main.dart:** Jangan pernah merilis aplikasi tanpa CCTV pencatat transisi state.
* **5. Pisahkan File State & Cubit:** Satu fitur wajib memiliki folder /cubit/ terisolasi (Feature-First).
* **Contoh Checklist:**
  ```dart
  // [✓] Seluruh App State dikelola Cubit (Zero setState lintas widget)
  // [✓] BlocBuilder tidak memicu SnackBar/Dialog galat
  // [✓] Equatable mencegah render ulang saat data tidak berubah
  // [✓] Log transisi tercetak rapi di terminal via BlocObserver
  ```
* **Tips Praktikum:** Jadikan kelima checklist ini sebagai acuan penilaian proyek UTS kelompok Anda agar meraih nilai A!

### Slide 26: Lab Quest 06 - Cart & Wishlist dengan Cubit
* **Tujuan Praktikum:** Bangun aplikasi Toko Piranti Bergerak dengan State Management Cubit terpisah dari antarmuka UI.
* **Pengelolaan State:** Buat kelas `CartCubit` dan `CartItemState` yang mewarisi Equatable untuk mencatat daftar produk belanjaan.
* **Badge Reaktif:** Tampilkan Badge jumlah item keranjang di AppBar yang otomatis bertambah saat tombol 'Beli' diklik.
* **Umpan Balik:** Terapkan `BlocListener` untuk memunculkan SnackBar hijau 'Berhasil menambah barang' setiap kali item baru masuk keranjang.
* **Kalkulasi Otomatis:** Sediakan BottomBar yang menghitung total harga belanjaan secara otomatis dan tombol 'Checkout / Reset'.
* **Target Pengujian:** Jalankan di browser Chrome (`flutter run -d chrome`), buktikan bahwa penambahan item berjalan instan tanpa lag!
* **Tips Praktikum:** Klik tombol kuning di slide presentasi untuk membuka kode lengkap Lab Quest di GitHub!

---

# PERTEMUAN 07: Clean Architecture & Enterprise Project Structure

### Slide 1: Cover Utama
* **Judul:** Clean Architecture & Enterprise Project Structure
* **Sub-CPMK 7:** Mampu merancang arsitektur aplikasi berskala enterprise menggunakan Clean Architecture, struktur Feature-First, dan Dependency Injection.
* **Analogi:** Cetak Biru Gedung Pencakar Langit — Membangun fondasi yang kokoh agar gedung tahan gempa saat bertambah tinggi.

### Slide 2: Setup & Alat Bantu Dependency Injection (get_it)
* **Analogi Konseptual:** Kotak Perkakas Mekanik Standar di bengkel kerja.
* **Dependensi:** `flutter pub add get_it equatable flutter_bloc`
* **Peran GetIt:** Service Locator terpusat untuk memutus ketergantungan antar kelas tanpa prop drilling.
* **Aturan Emas:** UI dilarang keras membuat objek Repository atau Data Source dengan kata kunci `new / ()`!

### Slide 3: Separation of Concerns (SoC)
* **Analogi Konseptual:** Departemen Pabrik Mobil Mandiri (Bodi UI, Mesin Bisnis, Baut Data).
* **Bahaya Spaghetti Code:** Menulis pemanggilan API Dio langsung di dalam tombol `onPressed` membuat kode mustahil diuji secara otomatis.
* **Tanggung Jawab Tunggal:** Pisahkan kode ke dalam tugas murni: Menggambar UI, Aturan Bisnis, dan Mengambil Data.

### Slide 4: Model Tiga Lapisan (Clean Architecture)
* **Analogi Konseptual:** Bawang Bombay Berlapis — Kulit luar melindungi daging, daging melindungi biji inti paling dalam.
* **1. Presentation Layer:** Widgets, Screens, Cubit/BLoC, State.
* **2. Domain Layer (Inti):** Entities, Use Cases, Repository Contracts (100% Pure Dart murni).
* **3. Data Layer:** Data Sources (Dio/Isar), Models (DTO), Repository Implementations.

### Slide 5: Struktur Direktori Feature-First
* **Analogi Konseptual:** Kamar Kos Mandiri vs Lemari Sekompleks.
* **Keunggulan Enterprise:** Setiap fitur (`features/auth/`, `features/product/`, `features/cart/`) memiliki 3 lapisannya sendiri.
* **Bebas Konflik Git:** Anggota tim bisa bekerja di fitur berbeda tanpa mengalami merge conflict besar.

### Slide 6: Domain Layer - Entity
* **Analogi Konseptual:** Emas Murni 24 Karat Bebas Karat.
* **Objek Bisnis Murni:** Merepresentasikan entitas bisnis sejati (`ProductEntity`) dengan validasi aturan bisnis.
* **Larangan JSON:** Entity dilarang memiliki method `fromJson` atau `toJson`! Itu adalah tugas Data Layer.

### Slide 7: Domain Layer - Repository Contract (Interface)
* **Analogi Konseptual:** Surat Perjanjian Kontrak Notaris.
* **Kelas Abstrak:** Domain mendefinisikan apa yang dibutuhkan sistem (`abstract class ProductRepository`).
* **Kekuatan Abstraksi:** Domain tidak peduli data diambil dari AWS, Firebase, atau sekadar data palsu (mocking).

### Slide 8: Domain Layer - Use Case (Interactor)
* **Analogi Konseptual:** Satu Tombol Khusus Mesin ATM (Single Responsibility Principle).
* **Satu Aksi Spesifik:** Satu kelas Use Case hanya menjalankan 1 tugas bisnis (`GetProductsUseCase`, `LoginUserUseCase`).
* **Reusable & Testable:** Dapat dipanggil oleh Mobile, Tablet, maupun Web dan diuji unit test murni dalam 0.1 detik.

### Slide 9: Data Layer - Model / DTO vs Entity
* **Analogi Konseptual:** Baju Dalam Kardus Ekspedisi Pengiriman.
* **Data Transfer Object (DTO):** Model bertugas membaca JSON dari server (`fromJson`) dan mengubah objek ke JSON (`toJson`).
* **Pewarisan:** `class ProductModel extends ProductEntity`.

### Slide 10: Data Layer - Data Sources
* **Analogi Konseptual:** Kran Air PAM (Internet) vs Sumur Bor Rumah (Cache Offline).
* **RemoteDataSource:** Menangani request HTTP mentah via Dio/HTTP client.
* **LocalDataSource:** Menangani pembacaan data luring dari SharedPreferences atau SQLite.

### Slide 11: Data Layer - Repository Implementation
* **Analogi Konseptual:** Manajer Logistik Pengambil Keputusan.
* **Menepati Kontrak Domain:** Kelas `ProductRepositoryImpl` mengimplementasikan `ProductRepository`.
* **Orkestrasi:** Memanggil Data Source, mem-parse ke Model, lalu mengembalikannya sebagai Entity murni ke Domain.

### Slide 12: Dependency Inversion Principle (DIP)
* **Analogi Konseptual:** Steker Listrik Standar Stopkontak Universal.
* **Aturan SOLID:** Modul tingkat tinggi (Presentation/Domain) tidak boleh bergantung pada modul tingkat rendah (Data/API).
* **Mocking Instan:** Bisa mengganti implementasi database atau notifikasi dalam 1 detik tanpa mengubah kode UI.

### Slide 13: Service Locator GetIt
* **Analogi Konseptual:** Meja Resepsionis Hotel Bintang Lima Terpusat (`sl<T>()`).
* **Registrasi Terpusat:** Seluruh instance kelas didaftarkan di `core/di/injection_container.dart`.
* **Bebas Parameter:** Widget apa pun bisa meminta layanan tanpa perlu passing variabel bertingkat.

### Slide 14: Factory vs Singleton di GetIt
* **Analogi Konseptual:** Karcis Parkir Sekali Pakai (Factory) vs Genset Listrik Gedung (Singleton).
* **registerLazySingleton:** Objek dibuat 1 kali dan dipakai bersama (Cocok untuk Repository, Dio, Database).
* **registerFactory:** Objek baru dibuat setiap kali dipanggil (Cocok untuk Cubit agar state segar saat buka halaman baru).

### Slide 15: Presentation Layer: Use Case ke Cubit
* **Analogi Konseptual:** Kasir Meneruskan Pesanan ke Koki Spesialis Dapur.
* **Cubit Dilarang Sentuh Repo:** Cubit hanya boleh memanggil Use Case sebagai perantara logika bisnis.
* **State Reaktif:** Cubit menerima data dari Use Case, lalu memancarkan status `ProductLoaded` ke antarmuka.

### Slide 16: Alur Data Utuh End-to-End
* **Analogi Konseptual:** Ekspedisi Paket Pos dari Pabrik Hingga Tangan Pembeli.
* **Rantai Pemanggilan:** UI (Button) -> Cubit -> Use Case -> Repo Contract -> Repo Impl -> Data Source -> API Server.

### Slide 17: 5 Aturan Emas Clean Architecture 2026
1. Domain Layer 100% Bebas dari `package:flutter`.
2. Satu Use Case hanya memiliki satu tanggung jawab (SRP).
3. Cubit dilarang memanggil Repository secara langsung.
4. Model di Data Layer mewarisi Entity di Domain Layer.
5. Seluruh dependensi diinjeksi via Service Locator GetIt di `main.dart`.

### Slide 18: Lab Quest 07 - Katalog E-Commerce Clean Arch
* **Tujuan Praktikum:** Membangun aplikasi Katalog Gadget 2026 menggunakan 3 layer Clean Architecture, 4 status UI reaktif, dan Service Locator GetIt.
* **Domain:** `Product` Entity, `ProductRepository` Contract, `GetProductsUseCase`.
* **Data:** `ProductModel` (fromJson) & `ProductRepositoryImpl`.
* **Presentation:** `ProductCubit` (Initial, Loading, Loaded, Error) & `ProductCatalogScreen`.
* **DI:** Pendaftaran lengkap di GetIt (`LazySingleton` untuk Repo & UseCase, `Factory` untuk Cubit).
* **Resiliensi Galat:** Tersedia tombol simulasi pemutusan koneksi server dan mekanisme coba ulang (retry) tanpa crash.


---

# PERTEMUAN 08: UJIAN TENGAH SEMESTER (UTS) - SPRINT 1 REVIEW

### Slide 1: Format Evaluasi & Standar Demo Sprint
* **Waktu:** 10 menit presentasi + 10 menit *Live Code Walkthrough* per kelompok.
* **Rubrik Verifikasi:**
  1. Kelancaran interaksi antarmuka (Tanpa overflow error / frame stutter).
  2. Kerapihan struktur folder dan isolasi logika ke dalam Cubit/BLoC.
  3. Audit riwayat commit Git untuk membuktikan tidak ada anggota yang pasif.

### Slide 2: Standar Pertanyaan Live Code Defense
* *"Tunjukkan di mana file State didefinisikan!"*
* *"Ubah warna background AppBar saat tombol ini ditekan secara live!"*
* *"Jelaskan mengapa method ini mengembalikan `Stream` bukan `Future`!"*

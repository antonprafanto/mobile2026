# SLIDE DECK MATERI AJAR: PERTEMUAN 06 - 08
## Fase 2: State Management, Clean Architecture, & Evaluasi UTS

---

# PERTEMUAN 06: The State Problem & Introduction to BLoC/Cubit

### Slide 1: Dilema "SetState": Mengapa Tidak Cukup?
* **Problem:** 
  1. *Prop Drilling:* Mengoper callback melewati 5 lapisan widget hanya agar tombol di widget cucu bisa mengubah teks di kakek.
  2. *Performance Drain:* Memanggil `setState()` di root widget menyebabkan seluruh turunan di-rebuild tanpa perlu.
  3. *Un-testable UI:* Logika kalkulasi bisnis terkunci di dalam file widget UI dan tidak bisa diuji dengan Unit Test murni.

### Slide 2: Mental Model: Separation of Presentation & Logic
* **Visual Diagram:**
  ```
  [User Action] ---> (Event / Method Call) ---> [ Cubit / BLoC ]
                                                        |
                                                  (Emits State)
                                                        v
  [ UI Widget ] <--- (Rebuilds only necessary) <--- [ State ]
  ```

### Slide 3: Implementasi Cubit (Sederhana & Elegan)
* **Kode State & Cubit:**
  ```dart
  class CartCubit extends Cubit<List<Item>> {
    CartCubit() : super([]);

    void addItem(Item item) {
      emit([...state, item]);
    }
  }
  ```

### Slide 4: Konsumsi State di UI: BlocBuilder vs BlocListener
* **Kapan pakai apa?**
  * `BlocBuilder`: Khusus menggambar ulang antarmuka (*render UI*). Dilarang menampilkan Dialog/SnackBar di sini!
  * `BlocListener`: Khusus menangani efek samping (*Side Effects*) satu kali, seperti navigasi layar atau pop-up SnackBar.
  * `BlocConsumer`: Gabungan keduanya.

---

# PERTEMUAN 07: Clean Architecture & Enterprise Project Structure

### Slide 1: The Uncle Bob Clean Architecture for Flutter
* **Tiga Lapisan Utama (*Three Core Layers*):**
  1. **Presentation Layer:** Widgets, Pages, BLoC/Cubit, Animations.
  2. **Domain Layer (The Core):** Entities, Value Objects, Use Cases. Murni Dart, *zero framework dependency*.
  3. **Data Layer:** Repositories Implementation, Data Sources (Remote API / Local Database), DTO Models.

### Slide 2: Feature-First vs Layer-First
* **Mengapa Feature-First Lebih Unggul di Industri?**
  * Di proyek skala besar, mengelompokkan folder berdasarkan fitur (`features/auth/`, `features/product/`, `features/checkout/`) membuat tim bisa bekerja secara paralel tanpa mengalami *merge conflict* besar di Git.

### Slide 3: Dependency Injection (DI) dengan `get_it`
* **Konsep:** Memutus keterikatan langsung (*Decoupling*).
* **Kode:**
  ```dart
  final sl = GetIt.instance;

  void init() {
    // Repository
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
    // Cubit
    sl.registerFactory(() => AuthCubit(authRepository: sl()));
  }
  ```

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

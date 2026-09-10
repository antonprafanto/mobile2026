# PANDUAN OPERASIONAL ASISTEN LABORATORIUM & KUNCI JAWABAN
## Dokumen Internal Tim Pengajar & Asisten Praktikum (Asprak)

---

## 1. Standar Operasional Prosedur (SOP) Asisten Lab

1. **Persiapan Sesi (H-1):**
   * Asisten wajib memastikan PC laboratorium terhubung dengan kabel LAN lokal dan paket cache offline siap digunakan.
   * Melakukan *pull* repositori terbaru dan mencoba menjalankan modul latihan mandiri di komputer lab.
2. **Saat Sesi Praktikum Berjalan:**
   * Membantu mahasiswa yang mengalami kendala teknis *driver USB*, lisensi Android SDK, atau *Scrcpy*.
   * Dilarang mengetikkan kode langsung di keyboard mahasiswa! Bimbing mahasiswa dengan menanyakan logika dan mengarahkan mereka membaca pesan error (*guided debugging*).
3. **Paska Sesi Praktikum (H+3):**
   * Menilai tugas mingguan mahasiswa di dashboard GitHub Classroom sesuai rubrik analitik yang telah ditetapkan.
   * Memberikan catatan/komentar tertulis pada baris kode mahasiswa jika terdapat *anti-pattern* atau kesalahan fatal.

---

## 2. Matriks Troubleshooting: 5 Galat Paling Sering Dialami Mahasiswa

| Gejala Galat (Error Message) | Akar Masalah | Tindakan Perbaikan Cepat oleh Asisten |
| :--- | :--- | :--- |
| **`RenderFlex overflowed by xxx pixels`** | Widget anak di dalam `Row`/`Column` melebihi dimensi layar fisik. | 1. Bungkus widget anak dengan `Expanded` atau `Flexible`.<br>2. Jika berupa form panjang, bungkus `Column` dengan `SingleChildScrollView`. |
| **`Null check operator used on a null value`** | Mahasiswa memaksakan operator bang (`!`) pada variabel yang bernilai `null`. | Minta mahasiswa menghapus tanda `!` dan menggantinya dengan pengecekan aman `if (data != null)` atau operator default `?? 'Nilai Kosong'`. |
| **`setState() called after dispose()`** | Operasi asynchronous selesai setelah halaman ditutup oleh pengguna. | Tambahkan guard clause `if (!mounted) return;` sebelum memanggil `setState()`. |
| **`LateInitializationError: Field has not been initialized`** | Variabel bertipe `late` diakses sebelum diberi nilai inisial. | Periksa apakah inisialisasi di `initState()` berjalan sebelum method `build()` memanggil variabel tersebut. |
| **`Execution failed for task ':app:checkDebugAarMetadata'`** | Versi dependensi native Android (Kotlin/Gradle) tidak cocok dengan SDK. | Periksa file `android/app/build.gradle`. Pastikan `compileSdkVersion` minimal disetel ke 34 dan perbarui versi plugin Android Gradle. |

---

## 3. Kunci Jawaban & Solusi Logika (Reference Solutions)

### Solusi Modul 01 (Dart Async Challenge):
```dart
class NilaiInvalidException implements Exception {
  final String message;
  NilaiInvalidException(this.message);
  @override
  String toString() => 'NilaiInvalidException: $message';
}

Future<String> hitungNilaiAkhir(double tugas, double uts, double uas) async {
  await Future.delayed(const Duration(milliseconds: 1500));

  if (tugas < 0 || tugas > 100 || uts < 0 || uts > 100 || uas < 0 || uas > 100) {
    throw NilaiInvalidException('Komponen nilai harus berada di rentang 0 sampai 100');
  }

  final double nilaiAkhir = (0.3 * tugas) + (0.3 * uts) + (0.4 * uas);

  if (nilaiAkhir >= 85) return 'A';
  if (nilaiAkhir >= 75) return 'B';
  if (nilaiAkhir >= 60) return 'C';
  if (nilaiAkhir >= 50) return 'D';
  return 'E';
}
```

### Solusi Modul 03 (Cart Cubit with Stock Limit):
```dart
class CartItem extends Equatable {
  final String id;
  final String name;
  final int qty;
  final double price;

  const CartItem({required this.id, required this.name, required this.qty, required this.price});

  CartItem copyWith({int? qty}) => CartItem(id: id, name: name, qty: qty ?? this.qty, price: price);

  @override
  List<Object?> get props => [id, name, qty, price];
}

class CartCubit extends Cubit<List<CartItem>> {
  CartCubit() : super([]);

  static const int maxStock = 5;

  void addItem(String id, String name, double price) {
    final index = state.indexWhere((item) => item.id == id);
    if (index >= 0) {
      if (state[index].qty >= maxStock) return; // Batasi stok
      final updatedList = List<CartItem>.from(state);
      updatedList[index] = updatedList[index].copyWith(qty: updatedList[index].qty + 1);
      emit(updatedList);
    } else {
      emit([...state, CartItem(id: id, name: name, qty: 1, price: price)]);
    }
  }

  double get totalPrice => state.fold(0.0, (sum, item) => sum + (item.price * item.qty));
}
```

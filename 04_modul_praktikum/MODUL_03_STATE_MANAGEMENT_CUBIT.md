# MODUL PRAKTIKUM 03: STATE MANAGEMENT DENGAN CUBIT & BLOC
## Laboratorium Rekayasa Perangkat Lunak - Teknik Informatika

---

## 1. Tujuan Pembelajaran
1. Mahasiswa mampu menganalisis kekurangan `setState()` pada arsitektur aplikasi berskala menengah ke atas.
2. Mahasiswa mampu mendesain *State* yang *immutable* menggunakan library **Equatable**.
3. Mahasiswa mampu mengimplementasikan **Cubit** untuk memisahkan logika bisnis dari komponen tampilan (*Presentation Layer*).
4. Mahasiswa mampu memanfaatkan widget `BlocProvider`, `BlocBuilder`, dan `BlocListener` secara tepat guna.

---

## 2. Langkah Kerja Terpandu: Kasus Wishlist Belanja

### Langkah 1: Definisikan Model & State
Buat berkas `wishlist_state.dart`:

```dart
import 'package:equatable/equatable.dart';

class ProductItem extends Equatable {
  final String id;
  final String name;
  final double price;

  const ProductItem({required this.id, required this.name, required this.price});

  @override
  List<Object?> get props => [id, name, price];
}

class WishlistState extends Equatable {
  final List<ProductItem> items;
  final String? message;

  const WishlistState({this.items = const [], this.message});

  WishlistState copyWith({List<ProductItem>? items, String? message}) {
    return WishlistState(
      items: items ?? this.items,
      message: message,
    );
  }

  @override
  List<Object?> get props => [items, message];
}
```

---

### Langkah 2: Buat Cubit Pengelola Logika
Buat berkas `wishlist_cubit.dart`:

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(const WishlistState());

  void toggleWishlist(ProductItem product) {
    final isExist = state.items.any((item) => item.id == product.id);

    if (isExist) {
      final updatedList = state.items.where((item) => item.id != product.id).toList();
      emit(state.copyWith(
        items: updatedList,
        message: '${product.name} dihapus dari Wishlist',
      ));
    } else {
      emit(state.copyWith(
        items: [...state.items, product],
        message: '${product.name} berhasil ditambahkan ke Wishlist!',
      ));
    }
  }
}
```

---

### Langkah 3: Integrasikan ke Tampilan UI
Gunakan `BlocConsumer` untuk menampilkan visual sekaligus menampilkan SnackBar:

```dart
Widget buildWishlistButton(BuildContext context, ProductItem product) {
  return BlocConsumer<WishlistCubit, WishlistState>(
    listenWhen: (previous, current) => current.message != null,
    listener: (context, state) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message!),
          duration: const Duration(seconds: 1),
        ),
      );
    },
    builder: (context, state) {
      final isFavorited = state.items.any((item) => item.id == product.id);
      return IconButton(
        icon: Icon(
          isFavorited ? Icons.favorite : Icons.favorite_border,
          color: isFavorited ? Colors.red : Colors.grey,
        ),
        onPressed: () => context.read<WishlistCubit>().toggleWishlist(product),
      );
    },
  );
}
```

---

## 3. Tugas Latihan Mandiri (Graded Lab Task)

> **Tantangan Praktikum 3:**
> 1. Kembangkan fitur *Shopping Cart* (Keranjang Belanja) menggunakan **Cubit**:
>    * State harus mencatat daftar item, kuantitas per item, dan total harga belanja secara otomatis.
>    * Terdapat tombol tambah kuantitas (`+`), kurangi kuantitas (`-`), dan hapus dari keranjang.
>    * Tambahkan validasi: kuantitas tidak boleh melebihi batas stok maksimal (misal: stok max 5).
> 2. Pasang **AppBlocObserver** untuk membuktikan bahwa setiap transisi state tercatat di konsol log.
> 3. Tuliskan pesan commit: `feat: implement cart cubit with auto total calculation`.

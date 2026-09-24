// =====================================================================
// SLIDE 26: SOLUSI MASTER LAB QUEST TUGAS 06
// Topik: Keranjang Belanja & Wishlist Multi-Bloc Reaktif dengan SnackBar
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// --- MODEL & STATE ---
class Produk extends Equatable {
  final String id;
  final String nama;
  final int harga;

  const Produk({required this.id, required this.nama, required this.harga});

  @override
  List<Object?> get props => [id, nama, harga];
}

// --- CUBIT 1: KERANJANG BELANJA ---
class CartItemState extends Equatable {
  final Map<Produk, int> items;

  const CartItemState({this.items = const {}});

  int get totalItem => items.values.fold(0, (sum, count) => sum + count);
  int get totalHarga =>
      items.entries.fold(0, (sum, e) => sum + (e.key.harga * e.value));

  CartItemState copyWith({Map<Produk, int>? items}) {
    return CartItemState(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}

class CartCubit extends Cubit<CartItemState> {
  CartCubit() : super(const CartItemState());

  void tambahKeKeranjang(Produk produk) {
    final map = Map<Produk, int>.from(state.items);
    map[produk] = (map[produk] ?? 0) + 1;
    emit(state.copyWith(items: map));
  }

  void kosongkanKeranjang() {
    emit(const CartItemState());
  }
}

// --- MAIN ENTRY POINT ---
void main() {
  runApp(
    BlocProvider(
      create: (context) => CartCubit(),
      child: const LabQuest06App(),
    ),
  );
}

class LabQuest06App extends StatelessWidget {
  const LabQuest06App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab Quest 06 - Cart Cubit',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const TokoScreen(),
    );
  }
}

class TokoScreen extends StatelessWidget {
  const TokoScreen({super.key});

  final List<Produk> katalog = const [
    Produk(id: '1', nama: 'Buku Pemrograman Flutter 2026', harga: 120000),
    Produk(id: '2', nama: 'Mouse Ergonomis Bluetooth', harga: 250000),
    Produk(id: '3', nama: 'Mechanical Keyboard 60%', harga: 450000),
    Produk(id: '4', nama: 'USB-C Fast Charger 65W', harga: 180000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Piranti Bergerak'),
        actions: [
          BlocBuilder<CartCubit, CartItemState>(
            builder: (context, state) {
              return Badge(
                label: Text('${state.totalItem}'),
                child: const Icon(Icons.shopping_cart),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: BlocListener<CartCubit, CartItemState>(
        listenWhen: (previous, current) =>
            current.totalItem > previous.totalItem,
        listener: (context, state) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Berhasil menambah ke keranjang! Total: ${state.totalItem} barang',
              ),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: katalog.length,
          itemBuilder: (context, i) {
            final p = katalog[i];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                title: Text(p.nama),
                subtitle: Text('Rp ${p.harga}'),
                trailing: FilledButton.tonal(
                  onPressed: () =>
                      context.read<CartCubit>().tambahKeKeranjang(p),
                  child: const Text('Beli'),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartItemState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Pembayaran:'),
                    Text(
                      'Rp ${state.totalHarga}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                FilledButton(
                  onPressed: state.totalItem == 0
                      ? null
                      : () => context.read<CartCubit>().kosongkanKeranjang(),
                  child: const Text('Checkout / Reset'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

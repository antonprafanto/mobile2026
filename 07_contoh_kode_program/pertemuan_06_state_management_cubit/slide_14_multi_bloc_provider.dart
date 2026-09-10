// =====================================================================
// SLIDE 14: MULTIBLOCPROVIDER (MENGELOLA BANYAK CUBIT SEKALIGUS)
// Topik: Menggabungkan Lebih dari Satu State Management pada Root Aplikasi
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit 1: Pengelola Keranjang
class CartCubit extends Cubit<int> {
  CartCubit() : super(0);
  void add() => emit(state + 1);
}

// Cubit 2: Pengelola Notifikasi
class NotifCubit extends Cubit<int> {
  NotifCubit() : super(2);
  void clear() => emit(0);
}

void main() {
  runApp(
    // Menggunakan MultiBlocProvider untuk mendaftarkan semua Cubit:
    MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(create: (context) => CartCubit()),
        BlocProvider<NotifCubit>(create: (context) => NotifCubit()),
      ],
      child: const MultiBlocApp(),
    ),
  );
}

class MultiBlocApp extends StatelessWidget {
  const MultiBlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 14 - MultiBlocProvider',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueGrey),
      home: const MultiBlocScreen(),
    );
  }
}

class MultiBlocScreen extends StatelessWidget {
  const MultiBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<CartCubit>().state;
    final notifCount = context.watch<NotifCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 14: MultiBlocProvider'),
        actions: [
          Badge(
            label: Text('$notifCount'),
            child: const Icon(Icons.notifications),
          ),
          const SizedBox(width: 16),
          Badge(
            label: Text('$cartCount'),
            child: const Icon(Icons.shopping_bag),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.icon(
              onPressed: () => context.read<CartCubit>().add(),
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Beli Barang (+1 Keranjang)'),
            ),
            const SizedBox(height: 12),
            FilledButton.tonalIcon(
              onPressed: () => context.read<NotifCubit>().clear(),
              icon: const Icon(Icons.clear_all),
              label: const Text('Bersihkan Notifikasi'),
            ),
          ],
        ),
      ),
    );
  }
}

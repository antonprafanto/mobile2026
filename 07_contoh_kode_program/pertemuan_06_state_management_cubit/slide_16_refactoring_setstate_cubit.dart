// =====================================================================
// SLIDE 16: REFACTORING DARI SETSTATE() MENUJU CUBIT BERSIH
// Topik: Memisahkan Logika Bisnis dari Tampilan Widget
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// State & Logika Terisolasi Murni:
class WishlistCubit extends Cubit<Set<String>> {
  WishlistCubit() : super({});

  void toggleItem(String namaBarang) {
    final updated = Set<String>.from(state);
    if (updated.contains(namaBarang)) {
      updated.remove(namaBarang);
    } else {
      updated.add(namaBarang);
    }
    emit(updated);
  }
}

void main() {
  runApp(const RefactorApp());
}

class RefactorApp extends StatelessWidget {
  const RefactorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 16 - Refactoring Cubit',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.pink),
      home: BlocProvider(
        create: (context) => WishlistCubit(),
        child: const RefactorScreen(),
      ),
    );
  }
}

class RefactorScreen extends StatelessWidget {
  const RefactorScreen({super.key});

  final List<String> produk = const [
    'Laptop AI 2026',
    'Mouse Ergonomis',
    'Monitor 4K',
  ];

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistCubit>().state;

    return Scaffold(
      appBar: AppBar(title: Text('Wishlist (${wishlist.length} item)')),
      body: ListView.builder(
        itemCount: produk.length,
        itemBuilder: (context, i) {
          final item = produk[i];
          final isFav = wishlist.contains(item);

          return ListTile(
            title: Text(item),
            trailing: IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : null,
              ),
              onPressed: () => context.read<WishlistCubit>().toggleItem(item),
            ),
          );
        },
      ),
    );
  }
}

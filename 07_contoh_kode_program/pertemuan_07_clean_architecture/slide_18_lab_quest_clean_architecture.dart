// =====================================================================
// SLIDE 18: SOLUSI MASTER LAB QUEST 07
// Topik: Mini E-Commerce Produk dengan Clean Architecture & GetIt
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// --- 1. DOMAIN LAYER ---
class Product extends Equatable {
  final String id;
  final String name;
  final int price;

  const Product({required this.id, required this.name, required this.price});

  @override
  List<Object?> get props => [id, name, price];
}

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}

class GetProductsUseCase {
  final ProductRepository repository;
  GetProductsUseCase(this.repository);
  Future<List<Product>> call() => repository.getProducts();
}

// --- 2. DATA LAYER ---
class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
    );
  }
}

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 600));
    final rawData = [
      {'id': '1', 'name': 'MacBook Pro M3 Max', 'price': 35000000},
      {'id': '2', 'name': 'iPad Pro OLED 13', 'price': 21000000},
      {'id': '3', 'name': 'AirPods Max USB-C', 'price': 8500000},
    ];
    return rawData.map((e) => ProductModel.fromJson(e)).toList();
  }
}

// --- 3. PRESENTATION LAYER (CUBIT & 4 STATUS UI) ---
sealed class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  const ProductLoaded(this.products);
  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);
  @override
  List<Object?> get props => [message];
}

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProducts;
  ProductCubit(this.getProducts) : super(ProductInitial());

  Future<void> fetch({bool simulateError = false}) async {
    emit(ProductLoading());
    try {
      if (simulateError) {
        throw Exception('Koneksi server terputus! Gagal mengambil data.');
      }
      final result = await getProducts();
      emit(ProductLoaded(result));
    } catch (e) {
      emit(ProductError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}

// --- 4. DEPENDENCY INJECTION (GET_IT) ---
final sl = GetIt.instance;

void initDI() {
  if (!sl.isRegistered<ProductRepository>()) {
    sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());
    sl.registerLazySingleton<GetProductsUseCase>(
      () => GetProductsUseCase(sl()),
    );
    sl.registerFactory<ProductCubit>(() => ProductCubit(sl()));
  }
}

// --- 5. MAIN APP ---
void main() {
  initDI();
  runApp(const LabQuest07App());
}

class LabQuest07App extends StatelessWidget {
  const LabQuest07App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab Quest 07 - Clean Architecture',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: BlocProvider(
        create: (context) => sl<ProductCubit>()..fetch(),
        child: const ProductCatalogScreen(),
      ),
    );
  }
}

class ProductCatalogScreen extends StatelessWidget {
  const ProductCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Produk (Clean Arch & GetIt)'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Simulasikan Error Server',
            icon: const Icon(Icons.bolt, color: Colors.amber),
            onPressed: () =>
                context.read<ProductCubit>().fetch(simulateError: true),
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return switch (state) {
            ProductInitial() => const Center(child: Text('Memulai...')),
            ProductLoading() => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            ProductLoaded(products: final list) => ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final p = list[i];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.devices, color: Colors.indigo),
                    title: Text(
                      p.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Rp ${p.price}'),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                );
              },
            ),
            ProductError(message: final msg) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 54,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      msg,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: () => context.read<ProductCubit>().fetch(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Muat Ulang'),
                    ),
                  ],
                ),
              ),
            ),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Muat Data Sukses',
        onPressed: () => context.read<ProductCubit>().fetch(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

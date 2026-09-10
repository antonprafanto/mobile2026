// =====================================================================
// SLIDE 06: DOMAIN LAYER - ENTITY
// Topik: Objek Bisnis Murni Tanpa Ketergantungan Eksternal (Pure Dart)
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// 1. Entity Murni: Hanya merepresentasikan aturan bisnis, bebas dari fromJson!
class ProductEntity extends Equatable {
  final String id;
  final String name;
  final int price;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
  });

  // Logika bisnis domain: Apakah produk bernilai mahal?
  bool get isPremium => price >= 1000000;

  @override
  List<Object?> get props => [id, name, price];
}

void main() {
  runApp(const DomainEntityApp());
}

class DomainEntityApp extends StatelessWidget {
  const DomainEntityApp({super.key});

  @override
  Widget build(BuildContext context) {
    const p1 = ProductEntity(
      id: 'P01',
      name: 'Laptop Pro 2026',
      price: 15000000,
    );
    const p2 = ProductEntity(id: 'P02', name: 'Mouse USB', price: 50000);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 06 - Domain Entity',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: Scaffold(
        appBar: AppBar(title: const Text('Slide 06: Domain Entity')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.laptop),
                  title: Text(p1.name),
                  subtitle: Text('Rp ${p1.price} (Premium: ${p1.isPremium})'),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.mouse),
                  title: Text(p2.name),
                  subtitle: Text('Rp ${p2.price} (Premium: ${p2.isPremium})'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

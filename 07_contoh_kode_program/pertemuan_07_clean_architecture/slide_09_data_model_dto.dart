// =====================================================================
// SLIDE 09: DATA LAYER - MODEL / DTO VS DOMAIN ENTITY
// Topik: Memisahkan Format Serialisasi JSON dari Objek Bisnis
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

// 1. Entity di Domain Layer (Murni)
class UserEntity {
  final int id;
  final String name;
  const UserEntity({required this.id, required this.name});
}

// 2. Model / DTO di Data Layer (Mewarisi Entity & Paham JSON)
class UserModel extends UserEntity {
  const UserModel({required super.id, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'] as int, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

void main() {
  runApp(const ModelDtoApp());
}

class ModelDtoApp extends StatelessWidget {
  const ModelDtoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulasi respons JSON mentah dari server:
    final rawJson = {'id': 101, 'name': 'Budi Rahardjo'};
    final userModel = UserModel.fromJson(rawJson);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 09 - Model DTO',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('Slide 09: Model vs Entity')),
        body: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Dikonversi dari JSON mentah:'),
                  const SizedBox(height: 8),
                  Text('ID: ${userModel.id}'),
                  Text('Nama: ${userModel.name}'),
                  const SizedBox(height: 12),
                  Text('Kembali ke JSON: ${userModel.toJson()}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

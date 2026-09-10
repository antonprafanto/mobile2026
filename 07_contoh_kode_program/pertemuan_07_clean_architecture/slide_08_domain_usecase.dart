// =====================================================================
// SLIDE 08: DOMAIN LAYER - USE CASE (INTERACTOR)
// Topik: Mengisolasi Satu Aksi Bisnis Spesifik (Single Responsibility)
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

// Kontrak
abstract class NumberRepository {
  int getRandomNumber();
}

class FakeNumberRepository implements NumberRepository {
  @override
  int getRandomNumber() => 42;
}

// Use Case: Hanya bertugas mengeksekusi 1 aksi bisnis
class GetLuckyNumberUseCase {
  final NumberRepository repository;

  GetLuckyNumberUseCase(this.repository);

  int execute() {
    // Bisa disisipkan aturan bisnis (validasi, perhitungan, dll)
    return repository.getRandomNumber();
  }
}

void main() {
  runApp(const UseCaseDemoApp());
}

class UseCaseDemoApp extends StatefulWidget {
  const UseCaseDemoApp({super.key});

  @override
  State<UseCaseDemoApp> createState() => _UseCaseDemoAppState();
}

class _UseCaseDemoAppState extends State<UseCaseDemoApp> {
  late final GetLuckyNumberUseCase _useCase;
  int? _number;

  @override
  void initState() {
    super.initState();
    _useCase = GetLuckyNumberUseCase(FakeNumberRepository());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 08 - Use Case',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.purple),
      home: Scaffold(
        appBar: AppBar(title: const Text('Slide 08: Domain Use Case')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _number == null
                    ? 'Tekan tombol'
                    : 'Angka Keberuntungan: $_number',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => setState(() => _number = _useCase.execute()),
                child: const Text('Eksekusi Use Case'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

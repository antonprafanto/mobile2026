// =====================================================================
// SLIDE 15: PRESENTATION LAYER: MENGHUBUNGKAN CUBIT KE USE CASE
// Topik: Cubit Bergantung Pada Use Case, Bukan Pada Database / API Langsung
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Use Case di Domain Layer:
class GetGreetingUseCase {
  String execute(String name) =>
      'Halo, $name! Selamat Datang di Clean Architecture.';
}

// Cubit di Presentation Layer:
class GreetingCubit extends Cubit<String> {
  final GetGreetingUseCase useCase;
  GreetingCubit(this.useCase) : super('Tekan tombol untuk menyapa');

  void greet(String name) {
    emit(useCase.execute(name));
  }
}

void main() {
  runApp(const CubitUseCaseApp());
}

class CubitUseCaseApp extends StatelessWidget {
  const CubitUseCaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final useCase = GetGreetingUseCase();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 15 - Cubit & Use Case',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: BlocProvider(
        create: (context) => GreetingCubit(useCase),
        child: const GreetingScreen(),
      ),
    );
  }
}

class GreetingScreen extends StatelessWidget {
  const GreetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slide 15: Cubit Memanggil Use Case')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<GreetingCubit, String>(
                builder: (context, greeting) {
                  return Text(
                    greeting,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () =>
                    context.read<GreetingCubit>().greet('Mahasiswa 2026'),
                child: const Text('Panggil Use Case via Cubit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

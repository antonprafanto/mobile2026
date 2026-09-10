// =====================================================================
// SLIDE 09: MENGGAMBAR ULANG UI DENGAN BLOCBUILDER & BUILDWHEN
// Topik: Memfilter Kondisi Kapan Widget Perlu Di-Rebuild
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepCubit extends Cubit<int> {
  StepCubit() : super(0);

  void step() => emit(state + 1);
}

void main() {
  runApp(const BuildWhenApp());
}

class BuildWhenApp extends StatelessWidget {
  const BuildWhenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 09 - BlocBuilder buildWhen',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: BlocProvider(
        create: (context) => StepCubit(),
        child: const BuildWhenScreen(),
      ),
    );
  }
}

class BuildWhenScreen extends StatelessWidget {
  const BuildWhenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slide 09: BlocBuilder & buildWhen')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. Builder Umum (Rebuild setiap ada emisi angka):
              BlocBuilder<StepCubit, int>(
                builder: (context, step) {
                  return Text(
                    'Setiap Langkah: $step',
                    style: const TextStyle(fontSize: 16),
                  );
                },
              ),
              const SizedBox(height: 16),

              // 2. Builder Terfilter: Hanya rebuild jika angka kelipatan 5!
              BlocBuilder<StepCubit, int>(
                buildWhen: (previous, current) => current % 5 == 0,
                builder: (context, step) {
                  return Card(
                    color: Colors.green.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Milestone Kelipatan 5: $step',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => context.read<StepCubit>().step(),
                child: const Text('Langkah Selanjutnya (+1)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

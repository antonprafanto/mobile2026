// =====================================================================
// SLIDE 05: MENTAL MODEL CUBIT (SEPARATION OF CONCERNS)
// Topik: Memisahkan Otak Logika (Cubit) dari Otot Tampilan (Widget UI)
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1. Otak Logika (Cubit murni tanpa ketergantungan UI):
class SimpleCounterCubit extends Cubit<int> {
  SimpleCounterCubit() : super(0); // Nilai awal = 0

  void tambah() => emit(state + 1); // Memancarkan nilai baru
  void kurang() => emit(state - 1);
  void reset() => emit(0);
}

void main() {
  runApp(const MentalModelCubitApp());
}

class MentalModelCubitApp extends StatelessWidget {
  const MentalModelCubitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 05 - Mental Model Cubit',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      // 2. Injeksi Cubit ke pohon widget:
      home: BlocProvider(
        create: (context) => SimpleCounterCubit(),
        child: const CounterView(),
      ),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slide 05: Model Mental Cubit')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Jumlah Ketukan (Dibaca dari Cubit):'),
            // 3. Hanya widget ini yang di-rebuild saat state berubah:
            BlocBuilder<SimpleCounterCubit, int>(
              builder: (context, count) {
                return Text(
                  '$count',
                  style: Theme.of(context).textTheme.displayLarge,
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.tonal(
                  onPressed: () => context.read<SimpleCounterCubit>().kurang(),
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: () => context.read<SimpleCounterCubit>().tambah(),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

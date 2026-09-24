// =====================================================================
// SLIDE 10: ANATOMI KELAS CUBIT & FUNGSI EMIT()
// Topik: Membangun Cubit Berbasis State Objek & Memancarkan Nilai
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1. State terstruktur:
class CounterState extends Equatable {
  final int count;
  final String status;

  const CounterState({required this.count, required this.status});

  CounterState copyWith({int? count, String? status}) {
    return CounterState(
      count: count ?? this.count,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [count, status];
}

// 2. Kelas Cubit:
class AdvanceCounterCubit extends Cubit<CounterState> {
  AdvanceCounterCubit()
    : super(const CounterState(count: 0, status: 'Nilai Awal'));

  void increment() {
    emit(
      state.copyWith(
        count: state.count + 1,
        status: 'Bertambah pada ${DateTime.now().second}s',
      ),
    );
  }

  void reset() {
    emit(const CounterState(count: 0, status: 'Direset'));
  }
}

void main() {
  runApp(const AnatomiCubitApp());
}

class AnatomiCubitApp extends StatelessWidget {
  const AnatomiCubitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 10 - Anatomi Cubit',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.cyan),
      home: BlocProvider(
        create: (context) => AdvanceCounterCubit(),
        child: const AnatomiCubitScreen(),
      ),
    );
  }
}

class AnatomiCubitScreen extends StatelessWidget {
  const AnatomiCubitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slide 10: Anatomi Cubit & emit()')),
      body: Center(
        child: BlocBuilder<AdvanceCounterCubit, CounterState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${state.count}',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Catatan: ${state.status}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () =>
                      context.read<AdvanceCounterCubit>().increment(),
                  icon: const Icon(Icons.add),
                  label: const Text('Panggil emit()'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

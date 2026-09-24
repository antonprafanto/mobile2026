// =====================================================================
// SLIDE 18: ARSITEKTUR 4 STATUS UI (INITIAL, LOADING, SUCCESS, ERROR)
// Topik: Pola Baku Industri Menangani Kondisi Jaringan & Data di BLoC
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1. Empat Status State:
sealed class DataFetchState extends Equatable {
  const DataFetchState();
  @override
  List<Object?> get props => [];
}

class DataInitial extends DataFetchState {}

class DataLoading extends DataFetchState {}

class DataSuccess extends DataFetchState {
  final List<String> items;
  const DataSuccess(this.items);
  @override
  List<Object?> get props => [items];
}

class DataError extends DataFetchState {
  final String pesan;
  const DataError(this.pesan);
  @override
  List<Object?> get props => [pesan];
}

// 2. Kelas Cubit Pengontrol:
class DataFetchCubit extends Cubit<DataFetchState> {
  DataFetchCubit() : super(DataInitial());

  Future<void> fetchData({bool sukses = true}) async {
    emit(DataLoading());
    await Future<void>.delayed(const Duration(milliseconds: 1000));

    if (sukses) {
      emit(const DataSuccess(['Flutter 3.24', 'Dart 3.5', 'Material 3']));
    } else {
      emit(const DataError('Gagal memuat: Server tidak merespon (503)'));
    }
  }
}

void main() {
  runApp(const DataFetchApp());
}

class DataFetchApp extends StatelessWidget {
  const DataFetchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 18 - 4 Status UI',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: BlocProvider(
        create: (context) => DataFetchCubit(),
        child: const DataFetchScreen(),
      ),
    );
  }
}

class DataFetchScreen extends StatelessWidget {
  const DataFetchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slide 18: 4 Status UI')),
      body: Center(
        child: BlocBuilder<DataFetchCubit, DataFetchState>(
          builder: (context, state) {
            return switch (state) {
              DataInitial() => const Text('Tekan tombol untuk memuat data.'),
              DataLoading() => const CircularProgressIndicator.adaptive(),
              DataSuccess(items: final data) => ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (ctx, i) => ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text(data[i]),
                ),
              ),
              DataError(pesan: final err) => Text(
                err,
                style: const TextStyle(color: Colors.red),
              ),
            };
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FilledButton(
              onPressed: () =>
                  context.read<DataFetchCubit>().fetchData(sukses: true),
              child: const Text('Muat Sukses'),
            ),
            FilledButton.tonal(
              onPressed: () =>
                  context.read<DataFetchCubit>().fetchData(sukses: false),
              child: const Text('Muat Gagal'),
            ),
          ],
        ),
      ),
    );
  }
}

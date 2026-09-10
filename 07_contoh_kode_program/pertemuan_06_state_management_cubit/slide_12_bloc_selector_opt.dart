// =====================================================================
// SLIDE 12: OPTIMASI TINGKAT TINGGI DENGAN BLOCSELECTOR
// Topik: Hanya Menggambar Ulang Widget Saat Properti Tertentu Berubah
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilData extends Equatable {
  final String nama;
  final int umur;

  const ProfilData({required this.nama, required this.umur});

  ProfilData copyWith({String? nama, int? umur}) {
    return ProfilData(nama: nama ?? this.nama, umur: umur ?? this.umur);
  }

  @override
  List<Object?> get props => [nama, umur];
}

class ProfilCubit extends Cubit<ProfilData> {
  ProfilCubit() : super(const ProfilData(nama: 'Andi', umur: 20));

  void tambahUmur() => emit(state.copyWith(umur: state.umur + 1));
  void gantiNama(String baru) => emit(state.copyWith(nama: baru));
}

void main() {
  runApp(const BlocSelectorApp());
}

class BlocSelectorApp extends StatelessWidget {
  const BlocSelectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 12 - BlocSelector',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: BlocProvider(
        create: (context) => ProfilCubit(),
        child: const SelectorScreen(),
      ),
    );
  }
}

class SelectorScreen extends StatelessWidget {
  const SelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slide 12: BlocSelector')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Hanya me-rebuild nama, tidak terpengaruh umur:
            BlocSelector<ProfilCubit, ProfilData, String>(
              selector: (state) => state.nama,
              builder: (context, nama) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text('Nama: $nama'),
                    subtitle: const Text('Hanya rebuild saat nama berubah!'),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            // Hanya me-rebuild umur, tidak terpengaruh nama:
            BlocSelector<ProfilCubit, ProfilData, int>(
              selector: (state) => state.umur,
              builder: (context, umur) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.cake),
                    title: Text('Umur: $umur tahun'),
                    subtitle: const Text('Hanya rebuild saat umur berubah!'),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.tonal(
                  onPressed: () => context.read<ProfilCubit>().tambahUmur(),
                  child: const Text('Tambah Umur (+1)'),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: () =>
                      context.read<ProfilCubit>().gantiNama('Budi Santoso'),
                  child: const Text('Ubah Nama'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

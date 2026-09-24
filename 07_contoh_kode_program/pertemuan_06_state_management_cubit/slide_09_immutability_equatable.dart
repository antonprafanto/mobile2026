// =====================================================================
// SLIDE 09: IMMUTABILITY & KESETARAAN DATA EQUATABLE
// Topik: Mengapa State Wajib Tidak Berubah (Immutable) & Peran Equatable
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Definisi objek immutable menggunakan Equatable:
class PenggunaState extends Equatable {
  final String nama;
  final int poin;

  const PenggunaState({required this.nama, required this.poin});

  // copyWith untuk membuat objek baru dengan perubahan spesifik:
  PenggunaState copyWith({String? nama, int? poin}) {
    return PenggunaState(nama: nama ?? this.nama, poin: poin ?? this.poin);
  }

  // Equatable membandingkan isi nilai, bukan referensi alamat memori:
  @override
  List<Object?> get props => [nama, poin];
}

void main() {
  runApp(const EquatableDemoApp());
}

class EquatableDemoApp extends StatelessWidget {
  const EquatableDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    const userA = PenggunaState(nama: 'Budi', poin: 100);
    const userB = PenggunaState(nama: 'Budi', poin: 100);
    final userC = userA.copyWith(poin: 150);

    final bool samaAB = userA == userB; // True berkat Equatable!
    final bool samaAC = userA == userC; // False

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 09 - Equatable',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.purple),
      home: Scaffold(
        appBar: AppBar(title: const Text('Slide 09: Immutability & Equatable')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.compare_arrows),
                  title: const Text('userA == userB (Nilai Sama)'),
                  subtitle: Text(
                    'Hasil: $samaAB (Equatable mencegah rebuild duplikat)',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('userA.copyWith(poin: 150)'),
                  subtitle: Text('userC Poin: ${userC.poin} (Sama: $samaAC)'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

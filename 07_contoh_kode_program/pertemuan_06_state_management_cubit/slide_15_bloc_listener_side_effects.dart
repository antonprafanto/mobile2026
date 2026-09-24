// =====================================================================
// SLIDE 15: MENANGANI SIDE EFFECTS DENGAN BLOCLISTENER
// Topik: Memunculkan SnackBar & Navigasi Tanpa Mengotori BlocBuilder
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormSubmitCubit extends Cubit<int> {
  FormSubmitCubit() : super(0);

  void submitSuccess() => emit(200);
  void submitError() => emit(500);
}

void main() {
  runApp(const BlocListenerApp());
}

class BlocListenerApp extends StatelessWidget {
  const BlocListenerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 15 - BlocListener',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.orange),
      home: BlocProvider(
        create: (context) => FormSubmitCubit(),
        child: const BlocListenerScreen(),
      ),
    );
  }
}

class BlocListenerScreen extends StatelessWidget {
  const BlocListenerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slide 15: BlocListener')),
      // BlocListener hanya dipanggil saat state berubah untuk aksi 1 kali (side effect):
      body: BlocListener<FormSubmitCubit, int>(
        listenWhen: (previous, current) => current != 0,
        listener: (context, code) {
          final isSuccess = code == 200;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isSuccess
                    ? 'Data Berhasil Disimpan ke Server!'
                    : 'Gagal! Terjadi Masalah Koneksi.',
              ),
              backgroundColor: isSuccess ? Colors.green : Colors.red,
            ),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('BlocListener bertugas memicu SnackBar / Navigasi:'),
              const SizedBox(height: 20),
              FilledButton.tonal(
                onPressed: () =>
                    context.read<FormSubmitCubit>().submitSuccess(),
                child: const Text('Simulasi Sukses (200)'),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => context.read<FormSubmitCubit>().submitError(),
                child: const Text('Simulasi Gagal (500)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

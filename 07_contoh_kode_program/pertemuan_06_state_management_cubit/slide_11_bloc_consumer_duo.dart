// =====================================================================
// SLIDE 11: DUET MAUT DENGAN BLOCCONSUMER
// Topik: Menggabungkan BlocBuilder & BlocListener dalam Satu Widget Ringkas
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<bool> {
  LoginCubit() : super(false); // false = logged out, true = logged in

  void login() => emit(true);
  void logout() => emit(false);
}

void main() {
  runApp(const BlocConsumerApp());
}

class BlocConsumerApp extends StatelessWidget {
  const BlocConsumerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 11 - BlocConsumer',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.pink),
      home: BlocProvider(
        create: (context) => LoginCubit(),
        child: const ConsumerScreen(),
      ),
    );
  }
}

class ConsumerScreen extends StatelessWidget {
  const ConsumerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slide 11: BlocConsumer')),
      body: Center(
        child: BlocConsumer<LoginCubit, bool>(
          // 1. listener: Menangani efek samping (notifikasi):
          listener: (context, isLoggedIn) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isLoggedIn
                      ? 'Selamat datang kembali, Mahasiswa!'
                      : 'Anda telah keluar dari sesi.',
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          // 2. builder: Menggambar ulang antarmuka (UI):
          builder: (context, isLoggedIn) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isLoggedIn ? Icons.lock_open : Icons.lock_outline,
                  size: 64,
                  color: isLoggedIn ? Colors.green : Colors.grey,
                ),
                const SizedBox(height: 12),
                Text(
                  isLoggedIn ? 'Status: Terautentikasi' : 'Status: Belum Masuk',
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () {
                    final cubit = context.read<LoginCubit>();
                    isLoggedIn ? cubit.logout() : cubit.login();
                  },
                  child: Text(isLoggedIn ? 'Keluar (Logout)' : 'Masuk (Login)'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

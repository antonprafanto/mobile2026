import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

import 'core/theme/app_theme.dart';
import 'core/utils/app_bloc_observer.dart';
import 'features/counter_example/presentation/pages/counter_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inisialisasi Environment Variables secara aman
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    debugPrint('⚠️ Berkas .env tidak ditemukan, menggunakan nilai default.');
  }

  // 2. Inisialisasi Global BLoC Observer untuk pemantauan state
  Bloc.observer = AppBlocObserver();

  runApp(const MobileCourseApp());
}

/// Konfigurasi Rute Deklaratif menggunakan GoRouter
final GoRouter _appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CounterPage(),
    ),
  ],
);

class MobileCourseApp extends StatelessWidget {
  const MobileCourseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mobile Programming 2026',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Menyesuaikan preferensi OS pengguna
      routerConfig: _appRouter,
    );
  }
}

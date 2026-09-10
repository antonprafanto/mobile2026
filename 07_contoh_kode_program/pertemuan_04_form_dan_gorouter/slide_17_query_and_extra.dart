// =====================================================================
// SLIDE 17: QUERY PARAMETERS (?Q=) & OBJEK EXTRA
// Topik: Mengirim Nilai Filter Opsional & Objek Kelas Kompleks
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const QueryAndExtraApp());
}

// Model data sederhana untuk dikirim via 'extra'
class MahasiswaModel {
  final String nim;
  final String nama;
  final String prodi;

  const MahasiswaModel({
    required this.nim,
    required this.nama,
    required this.prodi,
  });
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SenderScreen()),
    GoRoute(
      path: '/hasil',
      builder: (context, state) {
        // Membaca Query Parameter (?kategori=...)
        final kategori = state.uri.queryParameters['kategori'] ?? 'Semua';
        // Membaca Objek Kompleks via state.extra
        final mhs = state.extra as MahasiswaModel?;
        return ReceiverScreen(kategori: kategori, mahasiswa: mhs);
      },
    ),
  ],
);

class QueryAndExtraApp extends StatelessWidget {
  const QueryAndExtraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Slide 17 - Query & Extra',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
      routerConfig: _router,
    );
  }
}

class SenderScreen extends StatelessWidget {
  const SenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 17: Pengirim Data'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Kirim Query Parameter & Objek Kelas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  const dataMhs = MahasiswaModel(
                    nim: '2026001001',
                    nama: 'Anton Prafanto',
                    prodi: 'Teknik Informatika',
                  );

                  // Navigasi dengan query parameter URL dan objek extra
                  context.go('/hasil?kategori=Reguler', extra: dataMhs);
                },
                icon: const Icon(Icons.send),
                label: const Text('Kirim Objek Mahasiswa + ?kategori'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReceiverScreen extends StatelessWidget {
  final String kategori;
  final MahasiswaModel? mahasiswa;

  const ReceiverScreen({
    super.key,
    required this.kategori,
    required this.mahasiswa,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Penerima Data'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.filter_alt),
                title: const Text('Query Parameter (?kategori=)'),
                subtitle: Text(
                  kategori,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.badge),
                title: const Text('Data Objek Kompleks (state.extra)'),
                subtitle: Text(
                  mahasiswa != null
                      ? 'NIM: ${mahasiswa!.nim}\nNama: ${mahasiswa!.nama}\nProdi: ${mahasiswa!.prodi}'
                      : 'Objek extra kosong / null',
                ),
              ),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali ke Pengirim'),
            ),
          ],
        ),
      ),
    );
  }
}

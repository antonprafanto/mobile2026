// =====================================================================
// SLIDE 16: MENGIRIM DATA VIA PATH PARAMETERS (/MAHASISWA/:NIM)
// Topik: Membaca Parameter URL Dinamis state.pathParameters
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const PathParamsApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const StudentListScreen()),
    GoRoute(
      path: '/mahasiswa/:nim',
      builder: (context, state) {
        // Mengekstrak parameter :nim dari URL dinamis
        final nim = state.pathParameters['nim'] ?? '000000';
        return StudentDetailScreen(nim: nim);
      },
    ),
  ],
);

class PathParamsApp extends StatelessWidget {
  const PathParamsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Slide 16 - Path Parameters',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      routerConfig: _router,
    );
  }
}

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  final List<Map<String, String>> _students = const [
    {'nim': '2026001001', 'nama': 'Ahmad Fauzi'},
    {'nim': '2026001002', 'nama': 'Siti Rahmawati'},
    {'nim': '2026001003', 'nama': 'Budi Santoso'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Mahasiswa'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _students.length,
        itemBuilder: (context, index) {
          final s = _students[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(
                s['nama']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('NIM: ${s['nim']}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Menavigasi ke path dinamis dengan NIM mahasiswa
                context.go('/mahasiswa/${s['nim']}');
              },
            ),
          );
        },
      ),
    );
  }
}

class StudentDetailScreen extends StatelessWidget {
  final String nim;
  const StudentDetailScreen({super.key, required this.nim});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Mahasiswa'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                child: Icon(Icons.person, size: 48),
              ),
              const SizedBox(height: 16),
              Text(
                'NIM: $nim',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Parameter berhasil diekstrak dari pathParameters!',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: () => context.go('/'),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

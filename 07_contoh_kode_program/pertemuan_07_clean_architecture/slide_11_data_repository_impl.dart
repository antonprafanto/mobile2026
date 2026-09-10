// =====================================================================
// SLIDE 11: DATA LAYER - REPOSITORY IMPLEMENTATION
// Topik: Menjembatani Pemanggilan Data Source & Mengonversinya ke Entity
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

// 1. Entity di Domain:
class Profile {
  final String username;
  const Profile(this.username);
}

// 2. Kontrak di Domain:
abstract class ProfileRepository {
  Future<Profile> getProfile();
}

// 3. Implementasi Nyata di Data Layer:
class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<Profile> getProfile() async {
    // Memanggil Data Source, mem-parse JSON, lalu mengembalikan Profile Entity murni:
    await Future.delayed(const Duration(milliseconds: 400));
    const jsonFromApi = {'user': 'anton_dev'};
    return Profile(jsonFromApi['user'] as String);
  }
}

void main() {
  runApp(const RepoImplApp());
}

class RepoImplApp extends StatelessWidget {
  const RepoImplApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileRepository repo = ProfileRepositoryImpl();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 11 - Repo Impl',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Slide 11: Repository Implementation'),
        ),
        body: FutureBuilder<Profile>(
          future: repo.getProfile(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return const Center(child: CircularProgressIndicator());
            return Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Profile Entity: ${snapshot.data!.username}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

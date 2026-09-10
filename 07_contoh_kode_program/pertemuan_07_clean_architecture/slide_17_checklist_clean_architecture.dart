// =====================================================================
// SLIDE 17: 5 ATURAN EMAS CLEAN ARCHITECTURE 2026
// Topik: Checklist Penilaian Struktur Repositori Kelompok UTS
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const ChecklistCleanArchApp());
}

class ChecklistCleanArchApp extends StatelessWidget {
  const ChecklistCleanArchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 17 - Checklist Clean Arch',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Slide 17: 5 Aturan Emas Clean Arch'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: const [
            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('1. Domain Layer Bebas dari Flutter Framework'),
                subtitle: Text(
                  'Folder domain murni berisi kode Dart murni tanpa dependensi UI.',
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text(
                  '2. Satu Use Case Hanya Memiliki Satu Tanggung Jawab',
                ),
                subtitle: Text(
                  'Gunakan class tersendiri: LoginUseCase, GetProductsUseCase.',
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text(
                  '3. Presentation Layer Tidak Boleh Langsung Sentuh Repository',
                ),
                subtitle: Text(
                  'Cubit wajib memanggil Use Case, bukan Repository langsung.',
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('4. Data Model Mewarisi Domain Entity'),
                subtitle: Text(
                  'class UserModel extends UserEntity (dengan fromJson/toJson).',
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text(
                  '5. Gunakan Service Locator (GetIt) di Core Injection',
                ),
                subtitle: Text(
                  'Seluruh instansiasi objek terpusat di injection_container.dart.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

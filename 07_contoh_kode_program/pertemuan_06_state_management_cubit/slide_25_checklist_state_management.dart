// =====================================================================
// SLIDE 25: CHECKLIST 5 ATURAN EMAS STATE MANAGEMENT INDUSTRI 2026
// Topik: Pedoman Kebersihan Kode Proyek UTS & Standar Perusahaan
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const ChecklistBlocApp());
}

class ChecklistBlocApp extends StatelessWidget {
  const ChecklistBlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 25 - Checklist BLoC',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Slide 25: 5 Aturan Emas BLoC/Cubit'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: const [
            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('1. State Wajib Immutable'),
                subtitle: Text('Gunakan Equatable & fungsi copyWith()'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('2. Dilarang Panggil Side Effect di BlocBuilder'),
                subtitle: Text(
                  'Gunakan BlocListener untuk SnackBar dan Navigasi',
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('3. Gunakan context.read() di Event Callback'),
                subtitle: Text(
                  'Hanya gunakan context.watch() saat membaca nilai untuk UI',
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('4. Pasang BlocObserver di main.dart'),
                subtitle: Text(
                  'Mudah melacak riwayat perubahan state saat debugging',
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('5. Pisahkan File State & Cubit'),
                subtitle: Text(
                  'Folder feature-first: /cubit/nama_cubit.dart & nama_state.dart',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

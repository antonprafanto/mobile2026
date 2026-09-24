// =====================================================================
// SLIDE 02: SETUP & ALAT BANTU FLUTTER_BLOC
// Topik: Memasang flutter_bloc dan Ekstensi VS Code
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const SetupBlocApp());
}

class SetupBlocApp extends StatelessWidget {
  const SetupBlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 02 - Setup Bloc',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Slide 02: Setup flutter_bloc'),
          centerTitle: true,
        ),
        body: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: ListTile(
                  leading: Icon(Icons.terminal, color: Colors.indigo),
                  title: Text('Perintah Terminal:'),
                  subtitle: Text('flutter pub add flutter_bloc equatable'),
                ),
              ),
              SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: Icon(Icons.extension, color: Colors.teal),
                  title: Text('Ekstensi VS Code Wajib:'),
                  subtitle: Text(
                    'Bloc oleh Felix Angelov (Generator Kode Cepat)',
                  ),
                ),
              ),
              SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: Icon(Icons.speed, color: Colors.green),
                  title: Text('Shortcut Ajaib VS Code:'),
                  subtitle: Text(
                    'Alt + Enter pada widget -> "Wrap with BlocBuilder"',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

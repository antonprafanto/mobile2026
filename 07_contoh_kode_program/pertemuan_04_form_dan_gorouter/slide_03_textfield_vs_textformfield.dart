// =====================================================================
// SLIDE 03: DUA JENIS INPUT TEKS (TEXTFIELD VS TEXTFORMFIELD)
// Topik: Memilih Input yang Tepat untuk Kebutuhan Pengguna
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const TextFieldComparisonApp());
}

class TextFieldComparisonApp extends StatelessWidget {
  const TextFieldComparisonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 03 - TextField vs TextFormField',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const InputComparisonScreen(),
    );
  }
}

class InputComparisonScreen extends StatefulWidget {
  const InputComparisonScreen({super.key});

  @override
  State<InputComparisonScreen> createState() => _InputComparisonScreenState();
}

class _InputComparisonScreenState extends State<InputComparisonScreen> {
  final _formKey = GlobalKey<FormState>();
  String _searchQuery = '';
  String _submittedEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 03: TextField vs TextFormField'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. TextField biasa (Cocok untuk search bar mandiri)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '1. TextField (Input Mandiri / Search Bar)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Cari Produk / Mahasiswa',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Query aktif: ${_searchQuery.isEmpty ? "(kosong)" : _searchQuery}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. TextFormField (Cocok untuk Formulir Validasi)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '2. TextFormField (Formulir dengan Validasi)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email Akun Kampus',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email wajib diisi!';
                          }
                          if (!value.contains('@')) {
                            return 'Format email tidak valid (harus ada @)';
                          }
                          return null; // Valid
                        },
                        onSaved: (value) => _submittedEmail = value ?? '',
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Tersimpan: $_submittedEmail'),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Validasi & Kirim'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

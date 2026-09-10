// =====================================================================
// SLIDE 09: ARSITEKTUR FORM & GLOBALKEY<FORMSTATE>
// Topik: Menghubungkan Form, Validasi Serentak, & Analogi Stempel
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const FormArchitectureApp());
}

class FormArchitectureApp extends StatelessWidget {
  const FormArchitectureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 09 - Form Architecture',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const FormArchitectureScreen(),
    );
  }
}

class FormArchitectureScreen extends StatefulWidget {
  const FormArchitectureScreen({super.key});

  @override
  State<FormArchitectureScreen> createState() => _FormArchitectureScreenState();
}

class _FormArchitectureScreenState extends State<FormArchitectureScreen> {
  // GlobalKey bertindak sebagai 'kunci kendali' untuk memvalidasi seluruh input anak sekaligus
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nimController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Memanggil fungsi validasi pada semua TextFormField di dalam Form
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua kolom valid! Data siap dikirim ke server.'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ada kolom yang belum valid! Silakan periksa kembali.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 09: Arsitektur Form & Key'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(
                  labelText: 'NIM Mahasiswa',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty)
                    return 'NIM tidak boleh kosong!';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty)
                    return 'Nama tidak boleh kosong!';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.send),
                label: const Text('Validasi Serentak (_formKey)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

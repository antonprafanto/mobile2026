// =====================================================================
// SLIDE 10: LOGIKA VALIDATOR & REGEX EMAIL KAMPUS
// Topik: Memvalidasi Format Format Khusus (Angka & Domain Kampus)
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const RegexValidatorApp());
}

class RegexValidatorApp extends StatelessWidget {
  const RegexValidatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 10 - Validator Regex',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
      home: const RegexValidatorScreen(),
    );
  }
}

class RegexValidatorScreen extends StatefulWidget {
  const RegexValidatorScreen({super.key});

  @override
  State<RegexValidatorScreen> createState() => _RegexValidatorScreenState();
}

class _RegexValidatorScreenState extends State<RegexValidatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _nimCtrl = TextEditingController();

  // Pola regex email resmi kampus (@mhs.kampus.ac.id atau @kampus.ac.id)
  final _emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@(mhs\.)?kampus\.ac\.id$');

  @override
  void dispose() {
    _emailCtrl.dispose();
    _nimCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 10: Validasi Regex Email'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Validasi NIM hanya angka 10 digit
              TextFormField(
                controller: _nimCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'NIM (Wajib 10 Digit Angka)',
                  hintText: 'Contoh: 2026001001',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty)
                    return 'NIM tidak boleh kosong!';
                  if (!RegExp(r'^[0-9]+$').hasMatch(val))
                    return 'Hanya boleh berisi angka!';
                  if (val.length != 10)
                    return 'Panjang NIM harus tepat 10 digit!';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 2. Validasi Email Kampus dengan Regex
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Kampus Resmi',
                  hintText: 'user@mhs.kampus.ac.id',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty)
                    return 'Email wajib diisi!';
                  if (!_emailRegex.hasMatch(val.trim())) {
                    return 'Wajib berakhiran @mhs.kampus.ac.id atau @kampus.ac.id';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Format NIM & Email kampus valid!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.verified),
                label: const Text('Uji Validasi Regex'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

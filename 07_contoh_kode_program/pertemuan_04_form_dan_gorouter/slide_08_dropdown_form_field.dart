// =====================================================================
// SLIDE 08: INPUT PILIHAN (DROPDOWNBUTTONFORMFIELD)
// Topik: Menyediakan Pilihan Program Studi dengan Standar API Modern
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const DropdownDemoApp());
}

class DropdownDemoApp extends StatelessWidget {
  const DropdownDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 08 - Dropdown Form Field',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const DropdownDemoScreen(),
    );
  }
}

class DropdownDemoScreen extends StatefulWidget {
  const DropdownDemoScreen({super.key});

  @override
  State<DropdownDemoScreen> createState() => _DropdownDemoScreenState();
}

class _DropdownDemoScreenState extends State<DropdownDemoScreen> {
  final _formKey = GlobalKey<FormState>();

  // Daftar opsi program studi
  final List<String> _daftarProdi = const [
    'Teknik Informatika',
    'Sistem Informasi',
    'Teknik Komputer',
    'Teknologi Informasi',
  ];

  String? _prodiTerpilih;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 08: Dropdown Pilihan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Menggunakan initialValue (bukan value: yang sudah deprecated)
              DropdownButtonFormField<String>(
                initialValue: _prodiTerpilih,
                decoration: const InputDecoration(
                  labelText: 'Pilih Program Studi',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school_outlined),
                ),
                hint: const Text('Pilih satu prodi...'),
                items: _daftarProdi.map((prodi) {
                  return DropdownMenuItem<String>(
                    value: prodi,
                    child: Text(prodi),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _prodiTerpilih = val;
                  });
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Program studi wajib dipilih!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Prodi terpilih: $_prodiTerpilih'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.check),
                label: const Text('Simpan Pilihan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

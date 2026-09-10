// =====================================================================
// SLIDE 19: SOLUSI LAB QUEST TUGAS 04 (PORTAL REGISTRASI KTM)
// Topik: Form Lengkap, Validasi, Dropdown Prodi, & Preview Kartu Mahasiswa
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const PortalKtmApp());
}

class PortalKtmApp extends StatelessWidget {
  const PortalKtmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portal Registrasi KTM Digital',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const FormKtmScreen(),
    );
  }
}

class FormKtmScreen extends StatefulWidget {
  const FormKtmScreen({super.key});

  @override
  State<FormKtmScreen> createState() => _FormKtmScreenState();
}

class _FormKtmScreenState extends State<FormKtmScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nimCtrl = TextEditingController();
  final _namaCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  String? _selectedProdi;
  bool _isCardSubmitted = false;

  final List<String> _prodiList = const [
    'Teknik Informatika',
    'Sistem Informasi',
    'Teknik Komputer',
  ];

  @override
  void dispose() {
    _nimCtrl.dispose();
    _namaCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  void _submitForm() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isCardSubmitted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pendaftaran KTM Digital Berhasil!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tugas 04: Registrasi KTM Digital'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nimCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'NIM Mahasiswa',
                        hintText: 'Contoh: 2026001001',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.numbers),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty)
                          return 'NIM wajib diisi!';
                        if (val.length != 10)
                          return 'NIM harus tepat 10 digit!';
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _namaCtrl,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty)
                          return 'Nama wajib diisi!';
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email Kampus Resmi',
                        hintText: 'nama@mhs.kampus.ac.id',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty)
                          return 'Email wajib diisi!';
                        if (!val.contains('@'))
                          return 'Format email tidak valid!';
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedProdi,
                      decoration: const InputDecoration(
                        labelText: 'Program Studi',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.school_outlined),
                      ),
                      hint: const Text('Pilih Program Studi...'),
                      items: _prodiList
                          .map(
                            (p) => DropdownMenuItem(value: p, child: Text(p)),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => _selectedProdi = val),
                      validator: (val) =>
                          val == null ? 'Pilih salah satu prodi!' : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.badge_outlined),
                label: const Text('Cetak KTM Digital'),
              ),
              const SizedBox(height: 28),

              // Preview Kartu Mahasiswa setelah submit
              if (_isCardSubmitted) ...[
                const Text(
                  'Kartu Tanda Mahasiswa Digital:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 28,
                              child: Icon(Icons.person, size: 36),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _namaCtrl.text,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'NIM: ${_nimCtrl.text}',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    _selectedProdi ?? '',
                                    style: const TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        Text(
                          'Email: ${_emailCtrl.text}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 19: SOLUSI MASTER LAB QUEST 04
// TOPIK: Registrasi Akun Mahasiswa Lengkap -> Kartu KTM Digital Neo-Brutal
// =====================================================================
// CARA MENJALANKAN:
// 1. Pastikan package go_router sudah terpasang: flutter pub add go_router
// 2. Salin seluruh isi berkas ini ke: lib/main.dart
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MhsData {
  final String nim;
  final String nama;
  final String prodi;
  const MhsData({required this.nim, required this.nama, required this.prodi});
}

final labRouter = GoRouter(
  initialLocation: '/daftar',
  routes: [
    GoRoute(path: '/daftar', builder: (ctx, state) => const RegistrasiScreen()),
    GoRoute(
      path: '/ktm/:nim',
      builder: (ctx, state) {
        final nim = state.pathParameters['nim']!;
        final mhs = state.extra as MhsData? ?? MhsData(nim: nim, nama: 'Mahasiswa', prodi: 'Informatika');
        return KtmScreen(mhs: mhs);
      },
    ),
  ],
);

void main() => runApp(MaterialApp.router(routerConfig: labRouter, debugShowCheckedModeBanner: false));

class RegistrasiScreen extends StatefulWidget {
  const RegistrasiScreen({super.key});

  @override
  State<RegistrasiScreen> createState() => _RegistrasiScreenState();
}

class _RegistrasiScreenState extends State<RegistrasiScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nim = TextEditingController();
  final _nama = TextEditingController();
  final _email = TextEditingController();
  final _pwd = TextEditingController();
  bool _obscure = true;
  String? _prodi;

  @override
  void dispose() {
    _nim.dispose();
    _nama.dispose();
    _email.dispose();
    _pwd.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi Berhasil!'), backgroundColor: Colors.green),
      );
      context.push(
        '/ktm/${_nim.text}',
        extra: MhsData(nim: _nim.text, nama: _nama.text, prodi: _prodi!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PORTAL REGISTRASI MAHASISWA'), backgroundColor: const Color(0xFFFFE600)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nim,
                decoration: const InputDecoration(labelText: 'NIM (Minimal 8 digit)', border: OutlineInputBorder()),
                validator: (v) => (v == null || v.length < 8) ? 'NIM minimal 8 digit!' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nama,
                decoration: const InputDecoration(labelText: 'Nama Lengkap', border: OutlineInputBorder()),
                validator: (v) => (v == null || v.isEmpty) ? 'Nama tidak boleh kosong!' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(labelText: 'Email Kampus (@mhs.kampus.ac.id)', border: OutlineInputBorder()),
                validator: (v) {
                  if (v == null || !v.endsWith('@mhs.kampus.ac.id')) {
                    return 'Gunakan domain @mhs.kampus.ac.id!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _pwd,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: 'Kata Sandi',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                validator: (v) => (v == null || v.length < 8) ? 'Sandi minimal 8 karakter!' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _prodi,
                decoration: const InputDecoration(labelText: 'Program Studi', border: OutlineInputBorder()),
                items: ['Informatika', 'Sistem Informasi', 'Teknik Komputer'].map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                onChanged: (v) => setState(() => _prodi = v),
                validator: (v) => v == null ? 'Pilih program studi!' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFE600), foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 50)),
                child: const Text('DAFTAR & TERBITKAN KTM', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KtmScreen extends StatelessWidget {
  final MhsData mhs;
  const KtmScreen({super.key, required this.mhs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KTM DIGITAL MAHASISWA'), backgroundColor: const Color(0xFF4ADE80)),
      body: Center(
        child: Container(
          width: 360,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE600),
            border: Border.all(color: Colors.black, width: 3),
            boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(6, 6))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('KARTU TANDA MAHASISWA', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
              const Divider(color: Colors.black, thickness: 2),
              Text('NIM  : ${mhs.nim}', style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('NAMA : ${mhs.nama}'),
              Text('PRODI: ${mhs.prodi}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.pop(),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                child: const Text('KEMBALI KE FORM'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

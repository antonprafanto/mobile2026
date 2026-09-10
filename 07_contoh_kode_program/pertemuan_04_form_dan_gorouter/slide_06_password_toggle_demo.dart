// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 06: TOGGLE INTIP PASSWORD NYATA
// TOPIK: Membuat tombol mata interaktif dengan boolean _isObscure & setState
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide06App());
}

class Slide06App extends StatelessWidget {
  const Slide06App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slide06Screen(),
    );
  }
}

class Slide06Screen extends StatefulWidget {
  const Slide06Screen({super.key});

  @override
  State<Slide06Screen> createState() => _Slide06ScreenState();
}

class _Slide06ScreenState extends State<Slide06Screen> {
  bool _isObscure = true; // Status awal: sandi tersembunyi
  final _pwdController = TextEditingController();

  @override
  void dispose() {
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 06: Interactive Password Toggle'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Coba ketik kata sandi lalu klik ikon mata di sebelah kanan:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _pwdController,
              obscureText: _isObscure, // Dikendalikan boolean _isObscure
              decoration: InputDecoration(
                labelText: 'Kata Sandi Akun',
                hintText: 'Minimal 8 karakter unik',
                prefixIcon: const Icon(Icons.lock_outline),
                border: const OutlineInputBorder(),
                // SuffixIcon tombol mata yang mengubah _isObscure
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure; // Toggle bolak-balik
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Status saat ini: ${_isObscure ? "TERSEMBUNYI (••••)" : "TERLIHAT (Teks Terbuka)"}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _isObscure ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

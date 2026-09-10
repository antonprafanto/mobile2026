// =====================================================================
// SLIDE 06: TOGGLE INTIP PASSWORD INTERAKTIF
// Topik: Mengamankan Input Sandi dengan obscureText & suffixIcon
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const PasswordToggleApp());
}

class PasswordToggleApp extends StatelessWidget {
  const PasswordToggleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 06 - Password Toggle',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const PasswordToggleScreen(),
    );
  }
}

class PasswordToggleScreen extends StatefulWidget {
  const PasswordToggleScreen({super.key});

  @override
  State<PasswordToggleScreen> createState() => _PasswordToggleScreenState();
}

class _PasswordToggleScreenState extends State<PasswordToggleScreen> {
  // Variabel penentu apakah kata sandi sedang disamarkan
  bool _isObscure = true;
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 06: Toggle Intip Sandi'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _passwordController,
              // obscureText true akan menampilkan bulatan sandi (••••••)
              obscureText: _isObscure,
              decoration: InputDecoration(
                labelText: 'Kata Sandi Portal',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock_outline),
                // Tombol intip sandi diletakkan pada suffixIcon
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  tooltip: _isObscure ? 'Tampilkan sandi' : 'Sembunyikan sandi',
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      _isObscure ? Icons.shield_outlined : Icons.lock_open,
                      color: _isObscure ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _isObscure
                            ? 'Mode Aman: Karakter kata sandi disamarkan.'
                            : 'Mode Intip: Karakter terlihat langsung di layar.',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

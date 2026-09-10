// =====================================================================
// CONTOH KODE LENGKAP & SIAP DIJALANKAN (RUNNABLE FLUTTER APP)
// PERTEMUAN 04: FORMULIR REGISTRASI, VALIDASI REGEX, & UX KONTROL
// =====================================================================
// Cara Menjalankan:
// 1. Buat proyek baru atau gunakan proyek yang ada:
//    flutter create demo_form
// 2. Salin seluruh isi berkas ini ke: lib/main.dart
// 3. Jalankan di browser Chrome (paling cepat di lab):
//    flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const FormDemoApp());
}

class FormDemoApp extends StatelessWidget {
  const FormDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Form & Validasi Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFE600)),
        scaffoldBackgroundColor: const Color(
          0xFFFAF8F5,
        ), // Warm Cream Neo-Brutal
      ),
      home: const FormRegistrasiScreen(),
    );
  }
}

class FormRegistrasiScreen extends StatefulWidget {
  const FormRegistrasiScreen({super.key});

  @override
  State<FormRegistrasiScreen> createState() => _FormRegistrasiScreenState();
}

class _FormRegistrasiScreenState extends State<FormRegistrasiScreen> {
  // 1. Kunci Pengendali Form (Analogi: Stempel Legalisir)
  final _formKey = GlobalKey<FormState>();

  // 2. Controller Pengendali Input Teks
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // 3. Status Keamanan & Pilihan Form
  bool _isObscure = true; // Status sembunyikan password
  String? _selectedProdi; // Nilai dropdown terpilih

  final List<String> _daftarProdi = [
    'Teknik Informatika',
    'Sistem Informasi',
    'Teknik Komputer',
    'Sains Data',
  ];

  // 4. PEMBERSIHAN MEMORI (Mencegah Kebocoran RAM / Memory Leak)
  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 5. Logika Eksekusi Pengiriman Form
  void _submitForm() {
    // Trik Praktis: Sembunyikan keyboard virtual HP seketika agar tidak menutupi layar
    FocusScope.of(context).unfocus();

    // Periksa keabsahan seluruh kolom formulir sekaligus
    if (_formKey.currentState!.validate()) {
      // Jika seluruh kolom lolos validasi:
      final nama = _namaController.text.trim();
      final email = _emailController.text.trim();
      final prodi = _selectedProdi!;

      // Tampilkan notifikasi umpan balik sukses (SnackBar hijau)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.black),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Registrasi Berhasil!\nNama: $nama | Email: $email | Prodi: $prodi',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF4ADE80), // Hijau Mint Neo-Brutal
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      // Jika ada kolom yang salah/kosong:
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Mohon perbaiki data yang bertanda merah!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xFFFB7185), // Merah Coral Neo-Brutal
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PORTAL REGISTRASI MAHASISWA',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
        ),
        backgroundColor: const Color(0xFFFFE600), // Kuning Canary Neo-Brutal
        foregroundColor: Colors.black,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(color: Colors.black, width: 2.5),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(6, 6),
                      blurRadius: 0, // Neo-brutal hard shadow
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Judul Form
                      const Text(
                        'FORMULIR AKUN BARU',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const Text(
                        'Isi data identitas mahasiswa dengan benar dan teliti.',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                      const SizedBox(height: 20),

                      // Kolom 1: Nama Lengkap
                      TextFormField(
                        controller: _namaController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Nama Lengkap',
                          hintText: 'Contoh: Ahmad Dahlan',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nama lengkap tidak boleh kosong!';
                          }
                          if (value.trim().length < 3) {
                            return 'Nama terlalu pendek (minimal 3 huruf)!';
                          }
                          return null; // Lolos
                        },
                      ),
                      const SizedBox(height: 16),

                      // Kolom 2: Email Kampus Resmi
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Email Kampus Resmi',
                          hintText: 'nama@mhs.kampus.ac.id',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email tidak boleh kosong!';
                          }
                          // Regex pemeriksaan domain email kampus
                          final regex = RegExp(
                            r'^[\w\.-]+@mhs\.kampus\.ac\.id$',
                          );
                          if (!regex.hasMatch(value.trim())) {
                            return 'Gunakan domain resmi: @mhs.kampus.ac.id';
                          }
                          return null; // Lolos
                        },
                      ),
                      const SizedBox(height: 16),

                      // Kolom 3: Password dengan Fitur Toggle Intip Sandi
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isObscure,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelText: 'Kata Sandi',
                          hintText: 'Minimal 8 karakter kombinasi',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: const OutlineInputBorder(),
                          // Tombol mata intip password
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure =
                                    !_isObscure; // Bolak-balik status intip
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kata sandi tidak boleh kosong!';
                          }
                          if (value.length < 8) {
                            return 'Kata sandi minimal harus 8 karakter!';
                          }
                          return null; // Lolos
                        },
                      ),
                      const SizedBox(height: 16),

                      // Kolom 4: Dropdown Program Studi
                      DropdownButtonFormField<String>(
                        initialValue: _selectedProdi,
                        decoration: const InputDecoration(
                          labelText: 'Program Studi',
                          prefixIcon: Icon(Icons.school_outlined),
                          border: OutlineInputBorder(),
                        ),
                        items: _daftarProdi.map((prodi) {
                          return DropdownMenuItem(
                            value: prodi,
                            child: Text(prodi),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedProdi = val;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Wajib memilih salah satu Program Studi!';
                          }
                          return null; // Lolos
                        },
                      ),
                      const SizedBox(height: 24),

                      // Tombol Submit Berdesain Neo-Brutalism dengan InkWell
                      Material(
                        color: const Color(0xFFFFE600), // Kuning Canary
                        child: InkWell(
                          onTap: _submitForm,
                          splashColor: Colors.black26,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2.5,
                              ),
                            ),
                            child: const Text(
                              'DAFTAR SEKARANG',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

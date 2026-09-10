"""
Generator Berkas Kode Lengkap Runnable untuk Setiap Slide Pertemuan 04
1 Slide Konsep = 1 Berkas Kode Lengkap Mandiri (main.dart) Siap Run
"""

import os

DEST_DIR = r"c:\Users\anton\vibecoding\mobile2026_v2\07_contoh_kode_program\pertemuan_04_form_dan_gorouter"
os.makedirs(DEST_DIR, exist_ok=True)

slide_codes = {
    "slide_03_textfield_vs_textformfield.dart": '''// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 03: DUA JENIS INPUT TEKS
// TOPIK: Perbedaan TextField (Search Bar) vs TextFormField (Form Validasi)
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide03App());
}

class Slide03App extends StatelessWidget {
  const Slide03App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const Slide03Screen(),
    );
  }
}

class Slide03Screen extends StatefulWidget {
  const Slide03Screen({super.key});

  @override
  State<Slide03Screen> createState() => _Slide03ScreenState();
}

class _Slide03ScreenState extends State<Slide03Screen> {
  final _formKey = GlobalKey<FormState>();
  String _hasilPencarian = '';
  String _hasilForm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 03: TextField vs TextFormField'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. CONTOH TEXTFIELD BIASA (KOLOM PENCARIAN)
            const Text(
              '1. CONTOH TEXTFIELD (Untuk Input Bebas / Search Bar):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Ketik untuk mencari sesuatu...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                setState(() {
                  _hasilPencarian = text;
                });
              },
            ),
            const SizedBox(height: 6),
            Text('Karakter pencarian: "$_hasilPencarian"', style: const TextStyle(color: Colors.blueGrey)),

            const Divider(height: 40, thickness: 2),

            // 2. CONTOH TEXTFORMFIELD CERDAS (UNTUK FORM DENGAN VALIDASI)
            const Text(
              '2. CONTOH TEXTFORMFIELD (Terintegrasi Form & Validator):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email Mahasiswa',
                      hintText: 'nama@mhs.kampus.ac.id',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Email wajib diisi, tidak boleh kosong!';
                      }
                      if (!val.contains('@')) {
                        return 'Format email harus memuat simbol @!';
                      }
                      return null; // Lolos
                    },
                    onSaved: (val) => _hasilForm = val ?? '',
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Lolos Validasi! Nilai tersimpan: $_hasilForm'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFE600),
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('SUBMIT TEXTFORMFIELD'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''',

    "slide_04_controller_lifecycle.dart": '''// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 04: TEXTEDITINGCONTROLLER & DISPOSE
// TOPIK: Membaca teks, mengosongkan teks, dan mencegah kebocoran memori RAM
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide04App());
}

class Slide04App extends StatelessWidget {
  const Slide04App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slide04Screen(),
    );
  }
}

class Slide04Screen extends StatefulWidget {
  const Slide04Screen({super.key});

  @override
  State<Slide04Screen> createState() => _Slide04ScreenState();
}

class _Slide04ScreenState extends State<Slide04Screen> {
  // 1. Inisialisasi Controller
  final _namaController = TextEditingController();
  String _teksTerbaca = '-';

  // 2. WAJIB DISPOSE: Mencegah Kebocoran Memori (Memory Leak)
  @override
  void dispose() {
    _namaController.dispose(); // Matikan remote pengendali teks!
    super.dispose();
  }

  void _bacaTeks() {
    setState(() {
      _teksTerbaca = _namaController.text;
    });
  }

  void _kosongkanKolom() {
    _namaController.clear();
    setState(() {
      _teksTerbaca = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 04: Controller & Lifecycle'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Remote Pengendali Input Teks (TextEditingController):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Ketik Nama Anda',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _bacaTeks,
                  icon: const Icon(Icons.search),
                  label: const Text('BACA TEKS'),
                ),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: _kosongkanKolom,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('KOSONGKAN'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              color: Colors.amber.shade100,
              child: Text(
                'Nilai di controller saat ini:\n"$_teksTerbaca"',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''',

    "slide_05_input_decoration_ux.dart": '''// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 05: DESAIN UX INPUT & KEYBOARD TYPE
// TOPIK: Mempercantik kolom dengan label, hint, ikon, dan papan ketik HP
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide05App());
}

class Slide05App extends StatelessWidget {
  const Slide05App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slide05Screen(),
    );
  }
}

class Slide05Screen extends StatelessWidget {
  const Slide05Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 05: InputDecoration & UX'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Kolom 1: Keyboard Angka (Telepon/NIM)
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nomor WhatsApp / HP',
                hintText: '0812xxxxxxxx',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Kolom 2: Keyboard Email (Ada Simbol @)
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Kampus',
                hintText: 'nama@mhs.kampus.ac.id',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Kolom 3: Kolom Catatan Multi-Line
            TextFormField(
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: 'Catatan Keperluan Mahasiswa',
                hintText: 'Tuliskan alasan pengajuan di sini...',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''',

    "slide_06_password_toggle_demo.dart": '''// =====================================================================
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
''',

    "slide_07_keyboard_focus_control.dart": '''// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 07: MENJINAKKAN KEYBOARD HP
// TOPIK: Pindah kolom otomatis dengan Next & menutup keyboard virtual
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome (atau di smartphone)
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide07App());
}

class Slide07App extends StatelessWidget {
  const Slide07App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slide07Screen(),
    );
  }
}

class Slide07Screen extends StatelessWidget {
  const Slide07Screen({super.key});

  void _submitData(BuildContext context) {
    // KUNCI EMAS: Tutup keyboard virtual seketika!
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Keyboard HP berhasil ditutup secara elegan!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 07: Unfocus & Keyboard Action'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Kolom 1: Menekan Enter HP otomatis pindah ke Kolom 2
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Kolom 1: Nama (Tekan panah Next pada keyboard HP)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Kolom 2: Menekan Enter HP menandakan Selesai (Done)
            TextFormField(
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Kolom 2: Catatan (Ikon centang Done)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => _submitData(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFE600),
                foregroundColor: Colors.black,
              ),
              child: const Text('SUBMIT & TUTUP KEYBOARD'),
            ),
          ],
        ),
      ),
    );
  }
}
''',

    "slide_08_dropdown_form_field.dart": '''// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 08: DROPDOWNBUTTONFORMFIELD
// TOPIK: Input pilihan terintegrasi validator form
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide08App());
}

class Slide08App extends StatelessWidget {
  const Slide08App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slide08Screen(),
    );
  }
}

class Slide08Screen extends StatefulWidget {
  const Slide08Screen({super.key});

  @override
  State<Slide08Screen> createState() => _Slide08ScreenState();
}

class _Slide08ScreenState extends State<Slide08Screen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedProdi;

  final List<String> _daftarProdi = [
    'Teknik Informatika',
    'Sistem Informasi',
    'Teknik Komputer',
    'Sains Data',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 08: DropdownButtonFormField'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih Program Studi Anda (Wajib Dipilih):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedProdi,
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
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Program studi wajib dipilih!';
                  }
                  return null; // Lolos
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Prodi terpilih: $_selectedProdi'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFE600),
                  foregroundColor: Colors.black,
                ),
                child: const Text('VALIDASI PILIHAN DROPDOWN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''',

    "slide_09_form_architecture.dart": '''// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 09: FORM & GLOBALKEY<FORMSTATE>
// TOPIK: Analogi Map Berkas & Stempel Legalisir untuk mengecek form serentak
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide09App());
}

class Slide09App extends StatelessWidget {
  const Slide09App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slide09Screen(),
    );
  }
}

class Slide09Screen extends StatefulWidget {
  const Slide09Screen({super.key});

  @override
  State<Slide09Screen> createState() => _Slide09ScreenState();
}

class _Slide09ScreenState extends State<Slide09Screen> {
  // Stempel Kunci Form
  final _formKey = GlobalKey<FormState>();

  void _kirimForm() {
    // 1 Perintah untuk memeriksa seluruh kolom di dalam Form:
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Seluruh isian lolos verifikasi!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 09: GlobalKey<FormState>'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Pasang kunci stempel pada widget Form
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? 'Nama wajib diisi!' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? 'Nomor telepon wajib diisi!' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _kirimForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFE600),
                  foregroundColor: Colors.black,
                ),
                child: const Text('STEMPEL FORMULIR (VALIDATE)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''',

    "slide_10_validator_regex.dart": '''// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 10: LOGIKA VALIDATOR & REGEX KAMPUS
// TOPIK: Aturan kembalian null vs String galat & Regex @mhs.kampus.ac.id
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide10App());
}

class Slide10App extends StatelessWidget {
  const Slide10App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slide10Screen(),
    );
  }
}

class Slide10Screen extends StatefulWidget {
  const Slide10Screen({super.key});

  @override
  State<Slide10Screen> createState() => _Slide10ScreenState();
}

class _Slide10ScreenState extends State<Slide10Screen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 10: Validator & Regex Sanitasi'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Coba masukkan email bebas, lalu bandingkan jika memakai domain resmi @mhs.kampus.ac.id:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'Email Kampus Resmi',
                  hintText: 'nama@mhs.kampus.ac.id',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // 1. Periksa teks kosong
                  if (value == null || value.trim().isEmpty) {
                    return 'Email tidak boleh kosong!';
                  }
                  // 2. Pola Regex domain resmi
                  final regex = RegExp(r'^[\\w\\.-]+@mhs\\.kampus\\.ac\\.id$');
                  if (!regex.hasMatch(value.trim())) {
                    return 'Wajib menggunakan domain resmi: @mhs.kampus.ac.id';
                  }
                  // 3. Jika benar, WAJIB mengembalikan null!
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Lolos! Email resmi kampus terverifikasi.'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFE600),
                  foregroundColor: Colors.black,
                ),
                child: const Text('UJI REGEX EMAIL'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''',

    "slide_11_snackbar_feedback.dart": '''// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 11: UMPAN BALIK PENGGUNA (SNACKBAR)
// TOPIK: Menampilkan floating SnackBar hijau (sukses) dan merah (galat)
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide11App());
}

class Slide11App extends StatelessWidget {
  const Slide11App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slide11Screen(),
    );
  }
}

class Slide11Screen extends StatelessWidget {
  const Slide11Screen({super.key});

  void _tampilkanSnackBar(BuildContext context, bool sukses) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(sukses ? Icons.check_circle : Icons.error, color: Colors.black),
            const SizedBox(width: 10),
            Text(
              sukses ? 'Registrasi Berhasil Diproses!' : 'Koneksi Server Terputus!',
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: sukses ? const Color(0xFF4ADE80) : const Color(0xFFFB7185),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 11: SnackBar Feedback UX'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _tampilkanSnackBar(context, true),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4ADE80), foregroundColor: Colors.black),
              child: const Text('Uji Sukses (Hijau)'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () => _tampilkanSnackBar(context, false),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFB7185), foregroundColor: Colors.black),
              child: const Text('Uji Galat (Merah)'),
            ),
          ],
        ),
      ),
    );
  }
}
''',

    "slide_12_inkwell_gestures.dart": '''// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 12: GESTUREDTECTOR VS INKWELL
// TOPIK: Membandingkan sentuhan mentah vs riak air Material Splash Effect
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide12App());
}

class Slide12App extends StatelessWidget {
  const Slide12App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slide12Screen(),
    );
  }
}

class Slide12Screen extends StatefulWidget {
  const Slide12Screen({super.key});

  @override
  State<Slide12Screen> createState() => _Slide12ScreenState();
}

class _Slide12ScreenState extends State<Slide12Screen> {
  String _statusSentuh = 'Sentuh salah satu kotak di bawah:';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SLIDE 12: GestureDetector vs InkWell'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(_statusSentuh, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // 1. GestureDetector (Sentuhan Mentah Tanpa Efek Visual)
            GestureDetector(
              onTap: () {
                setState(() => _statusSentuh = 'Kotak GestureDetector disentuh (tanpa animasi riak air)!');
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                color: const Color(0xFF38BDF8),
                child: const Text('1. GESTUREDTECTOR (Mentah)', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),

            // 2. InkWell (Sentuhan Ber-animasi Riak Air Material Splash)
            Material(
              color: const Color(0xFFFFE600),
              child: InkWell(
                onTap: () {
                  setState(() => _statusSentuh = 'Kotak InkWell disentuh (ada efek cipratan riak air tinta)!');
                },
                splashColor: Colors.black26,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
                  child: const Text('2. INKWELL (Ada Ripple Splash)', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''',

    "slide_13_why_gorouter.dart": '''// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 13: MENGAPA GOROUTER?
// TOPIK: Navigasi deklaratif berbasis URL standar industri 2026
// =====================================================================
// CARA MENJALANKAN:
// 1. Pastikan package go_router sudah terpasang: flutter pub add go_router
// 2. Salin seluruh isi berkas ini ke: lib/main.dart
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Slide13HomeScreen(),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) => const Slide13DetailScreen(),
    ),
  ],
);

void main() {
  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routerConfig: router,
  ));
}

class Slide13HomeScreen extends StatelessWidget {
  const Slide13HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SLIDE 13: GoRouter Beranda')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/detail'),
          child: const Text('Pindah ke /detail via context.go()'),
        ),
      ),
    );
  }
}

class Slide13DetailScreen extends StatelessWidget {
  const Slide13DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SLIDE 13: Layar Detail')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Kembali ke Beranda via context.go()'),
        ),
      ),
    );
  }
}
''',

    "slide_14_app_router_config.dart": '''// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 14: KONFIGURASI GOROUTER & ERROR 404
// TOPIK: Menghubungkan routerConfig dan menangani rute tidak terdaftar
// =====================================================================
// CARA MENJALANKAN:
// 1. Pastikan package go_router sudah terpasang: flutter pub add go_router
// 2. Salin seluruh isi berkas ini ke: lib/main.dart
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/daftar', builder: (context, state) => const DaftarScreen()),
  ],
  // Penanganan Halaman 404 jika mahasiswa mengetik URL sembarangan di browser:
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('404 NOT FOUND'), backgroundColor: Colors.red),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 70, color: Colors.red),
          const SizedBox(height: 10),
          Text('Alamat "${state.uri}" Tidak Ditemukan!'),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: () => context.go('/'), child: const Text('Kembali')),
        ],
      ),
    ),
  ),
);

void main() {
  runApp(MaterialApp.router(routerConfig: appRouter, debugShowCheckedModeBanner: false));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SLIDE 14: Konfigurasi Router')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () => context.push('/daftar'), child: const Text('Buka /daftar')),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: () => context.push('/halaman-rusak'), child: const Text('Uji Rute 404 (Sengaja Salah)')),
          ],
        ),
      ),
    );
  }
}

class DaftarScreen extends StatelessWidget {
  const DaftarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Daftar')),
      body: Center(child: ElevatedButton(onPressed: () => context.pop(), child: const Text('Kembali (context.pop)'))),
    );
  }
}
''',

    "slide_15_navigation_actions.dart": '''// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 15: CONTEXT.GO() VS CONTEXT.PUSH()
// TOPIK: Perbedaan mengganti rute vs menumpuk layar dengan tombol panah Back
// =====================================================================
// CARA MENJALANKAN:
// 1. Pastikan package go_router sudah terpasang: flutter pub add go_router
// 2. Salin seluruh isi berkas ini ke: lib/main.dart
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final routerActions = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const ScreenA()),
    GoRoute(path: '/screen-b', builder: (context, state) => const ScreenB()),
    GoRoute(path: '/screen-c', builder: (context, state) => const ScreenC()),
  ],
);

void main() {
  runApp(MaterialApp.router(routerConfig: routerActions, debugShowCheckedModeBanner: false));
}

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LAYAR A (PANGKAL)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.push('/screen-b'),
              child: const Text('1. Buka B via context.push() (Ada tombol Back)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/screen-c'),
              child: const Text('2. Buka C via context.go() (Ganti Rute / No Back)'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LAYAR B (DITUMPUK PUSH)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Perhatikan pojok kiri atas AppBar: ada tombol panah kembali!'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () => context.pop(), child: const Text('Tutup via context.pop()')),
          ],
        ),
      ),
    );
  }
}

class ScreenC extends StatelessWidget {
  const ScreenC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LAYAR C (DIGANTI GO)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Tidak ada tombol panah Back otomatis di pojok kiri atas!'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () => context.go('/'), child: const Text('Kembali ke A via context.go()')),
          ],
        ),
      ),
    );
  }
}
''',

    "slide_16_path_parameters.dart": '''// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 16: PATH PARAMETERS (:id)
// TOPIK: Mengirim dan membaca ID unik pada URL (/buku/:id)
// =====================================================================
// CARA MENJALANKAN:
// 1. Pastikan package go_router sudah terpasang: flutter pub add go_router
// 2. Salin seluruh isi berkas ini ke: lib/main.dart
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final pathRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const KatalogScreen(),
    ),
    // Definisi rute dengan placeholder :id
    GoRoute(
      path: '/buku/:id',
      builder: (context, state) {
        // Membaca nilai :id dari URL
        final id = state.pathParameters['id']!;
        return DetailBukuScreen(bukuId: id);
      },
    ),
  ],
);

void main() {
  runApp(MaterialApp.router(routerConfig: pathRouter, debugShowCheckedModeBanner: false));
}

class KatalogScreen extends StatelessWidget {
  const KatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KATALOG DENGAN PATH PARAMETER')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: const Text('Buku #101: Flutter Modern'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => context.push('/buku/101'),
          ),
          ListTile(
            title: const Text('Buku #202: Clean Architecture'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => context.push('/buku/202'),
          ),
          ListTile(
            title: const Text('Buku #303: Dart Asynchronous'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => context.push('/buku/303'),
          ),
        ],
      ),
    );
  }
}

class DetailBukuScreen extends StatelessWidget {
  final String bukuId;
  const DetailBukuScreen({super.key, required this.bukuId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DETAIL BUKU #$bukuId')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ID yang dibaca dari URL: $bukuId', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () => context.pop(), child: const Text('KEMBALI')),
          ],
        ),
      ),
    );
  }
}
''',

    "slide_17_query_and_extra.dart": '''// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 17: QUERY PARAMETERS & EXTRA OBJECT
// TOPIK: Mengirim kueri filter (?keyword=) dan objek model kompleks (extra)
// =====================================================================
// CARA MENJALANKAN:
// 1. Pastikan package go_router sudah terpasang: flutter pub add go_router
// 2. Salin seluruh isi berkas ini ke: lib/main.dart
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Mahasiswa {
  final String nim;
  final String nama;
  final double ipk;
  const Mahasiswa({required this.nim, required this.nama, required this.ipk});
}

final queryRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/cari',
      builder: (context, state) {
        final q = state.uri.queryParameters['q'] ?? 'Kosong';
        return SearchResultScreen(query: q);
      },
    ),
    GoRoute(
      path: '/profil',
      builder: (context, state) {
        final mhs = state.extra as Mahasiswa;
        return ProfileScreen(mahasiswa: mhs);
      },
    ),
  ],
);

void main() {
  runApp(MaterialApp.router(routerConfig: queryRouter, debugShowCheckedModeBanner: false));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SLIDE 17: Query & Extra Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.push('/cari?q=Flutter2026'),
              child: const Text('1. Kirim Query Parameter (?q=Flutter2026)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.push(
                  '/profil',
                  extra: const Mahasiswa(nim: '2301092026', nama: 'Budi Santoso', ipk: 3.88),
                );
              },
              child: const Text('2. Kirim Objek Mahasiswa Utuh (extra)'),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResultScreen extends StatelessWidget {
  final String query;
  const SearchResultScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Pencarian')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Kata kunci query: "$query"', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () => context.pop(), child: const Text('KEMBALI')),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final Mahasiswa mahasiswa;
  const ProfileScreen({super.key, required this.mahasiswa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Mahasiswa (Dari Extra)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('NIM  : ${mahasiswa.nim}', style: const TextStyle(fontSize: 16)),
            Text('Nama : ${mahasiswa.nama}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('IPK  : ${mahasiswa.ipk}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => context.pop(), child: const Text('KEMBALI')),
          ],
        ),
      ),
    );
  }
}
''',

    "slide_18_nested_and_shell_routes.dart": '''// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 18: RUTE BERSARANG & STATEFULSHELLROUTE
// TOPIK: Nested routes & Bottom Navigation Bar tanpa kehilangan scroll
// =====================================================================
// CARA MENJALANKAN:
// 1. Pastikan package go_router sudah terpasang: flutter pub add go_router
// 2. Salin seluruh isi berkas ini ke: lib/main.dart
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const ShellDemoApp());
}

final shellRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (idx) => navigationShell.goBranch(idx),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Beranda'),
              NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
            ],
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (ctx, state) => Scaffold(
                appBar: AppBar(title: const Text('Tab Beranda (Scroll Preserved)')),
                body: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (ctx, i) => ListTile(title: Text('Item Beranda #$i')),
                ),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (ctx, state) => Scaffold(
                appBar: AppBar(title: const Text('Tab Profil')),
                body: const Center(child: Text('Halaman Profil Pengguna')),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

class ShellDemoApp extends StatelessWidget {
  const ShellDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: shellRouter,
    );
  }
}
''',

    "slide_19_lab_quest_portal_ktm.dart": '''// =====================================================================
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
'''
}

for fname, code in slide_codes.items():
    fpath = os.path.join(DEST_DIR, fname)
    with open(fpath, "w", encoding="utf-8") as f:
        f.write(code)
    print(f"Berhasil membuat: {fname}")

print(f"\\nSUKSES: Seluruh {len(slide_codes)} berkas kode lengkap runnable telah dibuat di: {DEST_DIR}")

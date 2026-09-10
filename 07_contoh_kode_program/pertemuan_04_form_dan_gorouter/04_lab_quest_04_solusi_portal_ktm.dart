// =====================================================================
// KUNCI JAWABAN LENGKAP & RUNNABLE: LAB QUEST PERTEMUAN 04
// PORTAL REGISTRASI MAHASISWA & PENERBITAN KARTU KTM DIGITAL
// =====================================================================
// Alur Kerja Aplikasi:
// 1. Mahasiswa mengisi formulir di layar '/daftar'.
// 2. Validasi regex memeriksa format email '@mhs.kampus.ac.id' dan sandi.
// 3. Saat submit valid: SnackBar hijau muncul, keyboard HP menutup otomatis,
//    lalu aplikasi berpindah ke layar '/ktm/:nim' membawa data mahasiswa.
// 4. Di layar KTM, kartu identitas digital berdesain Neo-Brutalism ditampilkan
//    lengkap dengan tombol kembali 'context.pop()'.
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// --- MODEL DATA IDENTITAS MAHASISWA ---
class MahasiswaModel {
  final String nim;
  final String nama;
  final String email;
  final String prodi;

  const MahasiswaModel({
    required this.nim,
    required this.nama,
    required this.email,
    required this.prodi,
  });
}

// =====================================================================
// KONFIGURASI GOROUTER APLIKASI
// =====================================================================
final GoRouter labRouter = GoRouter(
  initialLocation: '/daftar',
  routes: [
    // Layar 1: Formulir Registrasi
    GoRoute(
      path: '/daftar',
      builder: (context, state) => const RegistrasiMahasiswaScreen(),
    ),

    // Layar 2: Kartu Tanda Mahasiswa Digital (Menerima :nim & objek extra)
    GoRoute(
      path: '/ktm/:nim',
      builder: (context, state) {
        final nim = state.pathParameters['nim']!;
        final mhs = state.extra as MahasiswaModel? ??
            MahasiswaModel(
              nim: nim,
              nama: 'Nama Mahasiswa',
              email: 'mhs@kampus.ac.id',
              prodi: 'Teknik Informatika',
            );
        return KtmDigitalScreen(mahasiswa: mhs);
      },
    ),
  ],

  // Penanganan Halaman 404
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('404: Rute ${state.uri} tidak ditemukan!'),
    ),
  ),
);

// =====================================================================
// MAIN ENTRY POINT
// =====================================================================
void main() {
  runApp(const LabQuest04App());
}

class LabQuest04App extends StatelessWidget {
  const LabQuest04App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Lab Quest 04 - Portal KTM Digital',
      debugShowCheckedModeBanner: false,
      routerConfig: labRouter,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAF8F5), // Warm Cream
      ),
    );
  }
}

// =====================================================================
// LAYAR 1: FORM REGISTRASI MAHASISWA BARU
// =====================================================================
class RegistrasiMahasiswaScreen extends StatefulWidget {
  const RegistrasiMahasiswaScreen({super.key});

  @override
  State<RegistrasiMahasiswaScreen> createState() => _RegistrasiMahasiswaScreenState();
}

class _RegistrasiMahasiswaScreenState extends State<RegistrasiMahasiswaScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nimCtrl = TextEditingController();
  final _namaCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool _isObscure = true;
  String? _selectedProdi;

  final List<String> _daftarProdi = [
    'Teknik Informatika',
    'Sistem Informasi',
    'Teknik Komputer',
    'Teknologi Rekayasa Perangkat Lunak',
  ];

  @override
  void dispose() {
    _nimCtrl.dispose();
    _namaCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _prosesRegistrasi() {
    // 1. Sembunyikan keyboard virtual seketika
    FocusScope.of(context).unfocus();

    // 2. Evaluasi seluruh kolom form
    if (_formKey.currentState!.validate()) {
      final model = MahasiswaModel(
        nim: _nimCtrl.text.trim(),
        nama: _namaCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        prodi: _selectedProdi!,
      );

      // 3. Beri umpan balik SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selamat Datang, ${model.nama}! Menerbitkan KTM...'),
          backgroundColor: const Color(0xFF4ADE80),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );

      // 4. Berpindah ke layar KTM menggunakan context.push()
      context.push(
        '/ktm/${model.nim}',
        extra: model,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'REGISTRASI AKUN SIKAD',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
        ),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 2.5)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2.5),
                  boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(6, 6))],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'FORMULIR BIODATA MAHASISWA',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Data akan dicetak langsung pada KTM Digital Anda.',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      const SizedBox(height: 20),

                      // Kolom NIM
                      TextFormField(
                        controller: _nimCtrl,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Nomor Induk Mahasiswa (NIM)',
                          hintText: 'Contoh: 2301092026',
                          prefixIcon: Icon(Icons.badge_outlined),
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'NIM wajib diisi!';
                          if (v.trim().length < 8) return 'NIM minimal 8 digit angka!';
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      // Kolom Nama
                      TextFormField(
                        controller: _namaCtrl,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Nama Lengkap Mahasiswa',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Nama tidak boleh kosong!';
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      // Kolom Email Kampus
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Email Kampus Resmi',
                          hintText: 'nama@mhs.kampus.ac.id',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Email wajib diisi!';
                          final reg = RegExp(r'^[\w\.-]+@mhs\.kampus\.ac\.id$');
                          if (!reg.hasMatch(v.trim())) {
                            return 'Domain wajib: @mhs.kampus.ac.id';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      // Kolom Password dengan Toggle Intip
                      TextFormField(
                        controller: _passwordCtrl,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          labelText: 'Kata Sandi Portal',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                            onPressed: () => setState(() => _isObscure = !_isObscure),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.length < 8) return 'Kata sandi minimal 8 karakter!';
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      // Dropdown Prodi
                      DropdownButtonFormField<String>(
                        value: _selectedProdi,
                        decoration: const InputDecoration(
                          labelText: 'Program Studi Terdaftar',
                          prefixIcon: Icon(Icons.school_outlined),
                          border: OutlineInputBorder(),
                        ),
                        items: _daftarProdi.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                        onChanged: (val) => setState(() => _selectedProdi = val),
                        validator: (v) => v == null ? 'Pilih salah satu program studi!' : null,
                      ),
                      const SizedBox(height: 24),

                      // Tombol Submit Neo-Brutalist
                      Material(
                        color: const Color(0xFFFFE600),
                        child: InkWell(
                          onTap: _prosesRegistrasi,
                          splashColor: Colors.black26,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2.5),
                            ),
                            child: const Text(
                              'TERBITKAN KARTU MAHASISWA',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
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

// =====================================================================
// LAYAR 2: KARTU TANDA MAHASISWA (KTM) DIGITAL NEO-BRUTALISM
// =====================================================================
class KtmDigitalScreen extends StatelessWidget {
  final MahasiswaModel mahasiswa;

  const KtmDigitalScreen({super.key, required this.mahasiswa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KTM DIGITAL RESMI', style: TextStyle(fontWeight: FontWeight.w900)),
        backgroundColor: const Color(0xFF4ADE80), // Mint Green
        foregroundColor: Colors.black,
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 2.5)),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Kartu KTM Fisik Neo-Brutalist
              Container(
                width: 380,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE600), // Kuning Canary
                  border: Border.all(color: Colors.black, width: 3),
                  boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(8, 8))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Kartu
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'KARTU TANDA MAHASISWA',
                            style: TextStyle(
                              color: Color(0xFFFFE600),
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                          Icon(Icons.nfc, color: Colors.white, size: 20),
                        ],
                      ),
                    ),

                    // Isi Badan Kartu
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Kotak Foto Profil Avatar
                          Container(
                            width: 80,
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFF38BDF8),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: const Icon(Icons.person, size: 60, color: Colors.black),
                          ),
                          const SizedBox(width: 16),

                          // Data Teks Mahasiswa
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mahasiswa.nama.toUpperCase(),
                                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'NIM: ${mahasiswa.nim}',
                                  style: const TextStyle(fontFamily: 'Consolas', fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  mahasiswa.prodi,
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  mahasiswa.email,
                                  style: const TextStyle(fontSize: 10, color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Footer Kartu Barcode
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(top: BorderSide(color: Colors.black, width: 2)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('STATUS: AKTIF 2026/2027', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900)),
                          Icon(Icons.qr_code_2, size: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Tombol Kembali
              ElevatedButton.icon(
                onPressed: () {
                  // Menutup halaman KTM dan kembali ke form registrasi
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('KEMBALI KE FORM REGISTRASI'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  side: const BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

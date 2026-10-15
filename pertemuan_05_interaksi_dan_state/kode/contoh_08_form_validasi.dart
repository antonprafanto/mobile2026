// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 05: INTERAKSI & STATE LOKAL
// CONTOH 08: Formulir dan Validasi
// Topik: Form + GlobalKey<FormState>, TextFormField dengan validator,
//        keyboardType, inputFormatters, kata sandi yang bisa
//        ditampilkan, DropdownButtonFormField, dan FormField untuk
//        kotak centang persetujuan.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // FilteringTextInputFormatter

void main() {
  runApp(const AplikasiPendaftaran());
}

const List<String> daftarProdi = [
  'Informatika',
  'Sistem Informasi',
  'Teknik Elektro',
  'Teknik Mesin',
];

class AplikasiPendaftaran extends StatelessWidget {
  const AplikasiPendaftaran({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const HalamanPendaftaran(),
    );
  }
}

class HalamanPendaftaran extends StatefulWidget {
  const HalamanPendaftaran({super.key});

  @override
  State<HalamanPendaftaran> createState() => _HalamanPendaftaranState();
}

class _HalamanPendaftaranState extends State<HalamanPendaftaran> {
  // Kunci untuk "memanggil" Form dari luar: validate() dan reset().
  final GlobalKey<FormState> _kunciForm = GlobalKey<FormState>();

  final TextEditingController _kontrolNama = TextEditingController();
  final TextEditingController _kontrolNim = TextEditingController();
  final TextEditingController _kontrolEmail = TextEditingController();
  final TextEditingController _kontrolSandi = TextEditingController();

  String? _prodi;
  bool _sandiTersembunyi = true;
  String? _anggotaBaru; // ringkasan pendaftar terakhir

  @override
  void dispose() {
    _kontrolNama.dispose();
    _kontrolNim.dispose();
    _kontrolEmail.dispose();
    _kontrolSandi.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------
  // VALIDATOR: kembalikan null jika isian BENAR,
  // atau kembalikan pesan error (String) jika SALAH.
  // ---------------------------------------------------------------
  String? _cekNama(String? isian) {
    final String teks = isian?.trim() ?? '';
    if (teks.isEmpty) return 'Nama wajib diisi';
    if (teks.length < 3) return 'Nama minimal 3 huruf';
    return null;
  }

  String? _cekNim(String? isian) {
    final String teks = isian ?? '';
    if (teks.isEmpty) return 'NIM wajib diisi';
    if (teks.length != 10) return 'NIM harus 10 angka';
    return null;
  }

  String? _cekEmail(String? isian) {
    final String teks = isian?.trim() ?? '';
    if (teks.isEmpty) return 'Email wajib diisi';
    // Pemeriksaan sederhana: ada "@" (bukan di awal) dan ada titik
    // sesudahnya, misalnya rina@kampus.ac.id.
    final int posisiAt = teks.indexOf('@');
    if (posisiAt < 1 || !teks.substring(posisiAt).contains('.')) {
      return 'Contoh email yang benar: rina@kampus.ac.id';
    }
    return null;
  }

  String? _cekSandi(String? isian) {
    if (isian == null || isian.length < 8) return 'Minimal 8 karakter';
    return null;
  }

  String? _cekUlangSandi(String? isian) {
    if (isian == null || isian.isEmpty) return 'Ketik ulang kata sandi';
    // Validator boleh membaca kolom lain lewat controller-nya.
    if (isian != _kontrolSandi.text) return 'Kata sandi tidak sama';
    return null;
  }

  void _daftar() {
    // validate() menjalankan SEMUA validator di dalam Form.
    // Hasilnya true hanya jika semuanya lolos.
    final bool semuaBenar = _kunciForm.currentState!.validate();
    if (!semuaBenar) return; // pesan error sudah tampil di bawah kolom

    final String nama = _kontrolNama.text.trim();
    setState(() {
      _anggotaBaru = '$nama · ${_kontrolNim.text} · $_prodi';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pendaftaran berhasil. Selamat bergabung, $nama!'),
      ),
    );
    _kosongkan();
  }

  void _kosongkan() {
    // reset() mengembalikan SEMUA kolom ke keadaan awal dan
    // menghapus pesan error.
    _kunciForm.currentState!.reset();
    setState(() {
      _prodi = null;
      _sandiTersembunyi = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar UKM Robotika')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _kunciForm,
          // Pesan error baru muncul setelah tombol Daftar ditekan. Setelah
          // itu, pesan diperbarui setiap kali pengguna mengubah isian.
          autovalidateMode: AutovalidateMode.onUserInteractionIfError,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              TextFormField(
                controller: _kontrolNama,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Nama lengkap',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: _cekNama, // nama fungsi, tanpa tanda ()
              ),
              TextFormField(
                controller: _kontrolNim,
                keyboardType: TextInputType.number, // keyboard angka
                // Huruf yang diketik langsung ditolak, hanya angka masuk.
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 10,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  prefixIcon: Icon(Icons.badge_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: _cekNim,
              ),
              TextFormField(
                controller: _kontrolEmail,
                keyboardType: TextInputType.emailAddress, // ada tombol @
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Email kampus',
                  hintText: 'nama@kampus.ac.id',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: _cekEmail,
              ),
              TextFormField(
                controller: _kontrolSandi,
                obscureText: _sandiTersembunyi, // tampil sebagai titik
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Kata sandi',
                  helperText: 'Minimal 8 karakter',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),
                  // ExcludeFocus: tombol mata dilewati saat menekan
                  // "lanjut", jadi fokus langsung ke kolom berikutnya.
                  suffixIcon: ExcludeFocus(
                    child: IconButton(
                      tooltip: _sandiTersembunyi ? 'Tampilkan' : 'Sembunyikan',
                      icon: Icon(
                        _sandiTersembunyi
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _sandiTersembunyi = !_sandiTersembunyi;
                        });
                      },
                    ),
                  ),
                ),
                validator: _cekSandi,
              ),
              TextFormField(
                obscureText: true,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Ulangi kata sandi',
                  prefixIcon: Icon(Icons.lock_reset),
                  border: OutlineInputBorder(),
                ),
                validator: _cekUlangSandi,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Program studi',
                  prefixIcon: Icon(Icons.school_outlined),
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (String prodi in daftarProdi)
                    DropdownMenuItem<String>(value: prodi, child: Text(prodi)),
                ],
                onChanged: (String? pilihan) {
                  setState(() {
                    _prodi = pilihan;
                  });
                },
                validator: (String? pilihan) {
                  if (pilihan == null) return 'Pilih program studi';
                  return null;
                },
              ),
              // FormField: membuat widget APA SAJA ikut divalidasi Form,
              // di sini sebuah kotak centang persetujuan.
              FormField<bool>(
                initialValue: false,
                validator: (bool? setuju) {
                  if (setuju != true) return 'Centang dulu persetujuan ini';
                  return null;
                },
                builder: (FormFieldState<bool> kolom) {
                  return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Saya bersedia mengikuti kegiatan UKM'),
                    value: kolom.value,
                    onChanged: kolom.didChange, // simpan pilihan ke kolom
                    subtitle: kolom.hasError
                        ? Text(
                            kolom.errorText!,
                            style: TextStyle(color: warna.error),
                          )
                        : null,
                  );
                },
              ),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _kosongkan,
                      child: const Text('Kosongkan'),
                    ),
                  ),
                  Expanded(
                    child: FilledButton(
                      onPressed: _daftar,
                      child: const Text('Daftar'),
                    ),
                  ),
                ],
              ),
              if (_anggotaBaru != null)
                Card.filled(
                  child: ListTile(
                    leading: const Icon(Icons.verified),
                    title: const Text('Anggota baru'),
                    subtitle: Text(_anggotaBaru!),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

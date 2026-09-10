// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 17: SINGLECHILDSCROLLVIEW
// TOPIK: Mencegah Form Tertutup Keyboard Virtual pada Layar Kecil
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide17ScrollViewApp());

class Slide17ScrollViewApp extends StatelessWidget {
  const Slide17ScrollViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SLIDE 17 • SINGLECHILDSCROLLVIEW',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color(0xFFC084FC),
          elevation: 0,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.5),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2.5),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Formulir Pendaftaran Praktikum Lab:',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInputField(
                      'Nama Lengkap Mahasiswa',
                      'Contoh: Ahmad Fauzan',
                    ),
                    const SizedBox(height: 12),
                    _buildInputField(
                      'Nomor Induk Mahasiswa (NIM)',
                      'Contoh: 120140042',
                    ),
                    const SizedBox(height: 12),
                    _buildInputField(
                      'Alamat Surel Kampus',
                      'Contoh: ahmad@mhs.kampus.ac.id',
                    ),
                    const SizedBox(height: 12),
                    _buildInputField(
                      'Nomor WhatsApp / Kontak',
                      'Contoh: 081234567890',
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Formulir berhasil terkirim!'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFE600),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        side: const BorderSide(color: Colors.black, width: 2),
                        shape: const RoundedRectangleBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'KIRIM DATA PRAKTIKAN',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '💡 SingleChildScrollView memastikan seluruh kolom input tetap bisa di-scroll '
                'ke atas saat keyboard virtual HP muncul menutupi separuh layar!',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(height: 4),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF1F5F9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: const BorderSide(width: 1.5),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(width: 2.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 08: ATURAN PENAMAAN PROYEK
// TOPIK: Aturan snake_case (Huruf Kecil & Garis Bawah)
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiPenamaanProyek());
}

class AplikasiPenamaanProyek extends StatefulWidget {
  const AplikasiPenamaanProyek({super.key});

  @override
  State<AplikasiPenamaanProyek> createState() => _AplikasiPenamaanProyekState();
}

class _AplikasiPenamaanProyekState extends State<AplikasiPenamaanProyek> {
  String _inputNama = 'proyek_pertama';

  bool get _isValidSnakeCase {
    // Aturan: hanya huruf kecil a-z, angka 0-9, dan garis bawah (_), tidak boleh diawali angka
    return RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(_inputNama);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Validator Nama Proyek Flutter'),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ketik Nama Proyek Baru:'),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Contoh: aplikasi_katalog_kopi',
                ),
                onChanged: (val) {
                  setState(() => _inputNama = val);
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    _isValidSnakeCase ? Icons.check_circle : Icons.cancel,
                    color: _isValidSnakeCase ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isValidSnakeCase
                        ? 'Nama Valid (snake_case)'
                        : 'Format Salah! Dilarang spasi atau huruf kapital',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _isValidSnakeCase ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Perintah Terminal:\n\$ flutter create nama_proyek_anda',
                style: TextStyle(fontFamily: 'Consolas', fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

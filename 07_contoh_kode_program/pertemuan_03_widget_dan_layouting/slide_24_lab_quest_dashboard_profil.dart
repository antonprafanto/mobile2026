// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 24: LAB QUEST DASHBOARD PROFIL
// PROYEK: Dashboard Profil Mahasiswa Sederhana & Bersih
// =====================================================================
// Menggabungkan:
// 1. SafeArea & SingleChildScrollView (Anti-Overflow Layar)
// 2. Row & Column (Penyusunan Teks dan Foto Profil)
// 3. Stack & Positioned (Lencana Terverifikasi di Atas Foto)
// 4. Wrap (Deretan Chip Keahlian)
// 5. ListView (Daftar Proyek Singkat)
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardProfilMahasiswa(),
    ),
  );
}

class DashboardProfilMahasiswa extends StatelessWidget {
  const DashboardProfilMahasiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Bagian Foto & Identitas (Row + Stack)
              Row(
                children: [
                  Stack(
                    children: const [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.check,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Ahmad Fauzan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('NIM: 120140042'),
                      Text('Teknik Informatika 2026'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(),

              // 2. Bagian Keahlian (Wrap)
              const Text(
                'Keahlian Mobile:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: const [
                  Chip(label: Text('Flutter')),
                  Chip(label: Text('Dart')),
                  Chip(label: Text('Widget Tree')),
                  Chip(label: Text('Row & Column')),
                  Chip(label: Text('Git')),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(),

              // 3. Bagian Daftar Proyek
              const Text(
                'Proyek Praktikum:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  ListTile(
                    leading: Icon(Icons.phone_android),
                    title: Text('Aplikasi Kasir Sederhana'),
                    subtitle: Text('Pertemuan 02 - Dart Async'),
                  ),
                  ListTile(
                    leading: Icon(Icons.dashboard),
                    title: Text('Dashboard Profil Mahasiswa'),
                    subtitle: Text('Pertemuan 03 - Layouting'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

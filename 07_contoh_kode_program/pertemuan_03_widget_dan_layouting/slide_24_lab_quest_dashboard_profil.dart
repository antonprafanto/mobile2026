// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 24: SOLUSI MASTER LAB QUEST PERTEMUAN 03
// PROYEK: Dashboard Profil Mahasiswa & Kartu Portofolio Neo-Brutalism
// =====================================================================
// MENGGABUNGKAN SELURUH KONSEP MINGGU KE-3:
// 1. SafeArea & SingleChildScrollView (Anti-Overflow & Ramah Poni HP)
// 2. Column & Row (Penyusunan Hierarki Terstruktur)
// 3. Stack & Positioned (Foto Profil & Lencana Terverifikasi Melayang)
// 4. Wrap (Deretan Chip Keahlian Fleksibel Anti-Crash)
// 5. ListView.builder (Daftar Riwayat Proyek Berkinerja Tinggi)
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const LabQuest03App());

class LabQuest03App extends StatelessWidget {
  const LabQuest03App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab Quest 03 - Profil Mahasiswa',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAF8F5),
        fontFamily: 'Segoe UI',
      ),
      home: const DashboardProfilScreen(),
    );
  }
}

class DashboardProfilScreen extends StatefulWidget {
  const DashboardProfilScreen({super.key});

  @override
  State<DashboardProfilScreen> createState() => _DashboardProfilScreenState();
}

class _DashboardProfilScreenState extends State<DashboardProfilScreen> {
  int _followers = 128;
  bool _isFollowing = false;

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
      _followers += _isFollowing ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PORTAL PROFIL MAHASISWA 2026',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        backgroundColor: const Color(0xFFFFE600),
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(color: Colors.black, width: 2.5),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tautan profil disalin!')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Bagian Header Profil dengan Stack & Positioned
              _buildHeaderProfile(),
              const SizedBox(height: 20),

              // 2. Bagian Statistik Pengikut
              _buildStatsRow(),
              const SizedBox(height: 20),

              // 3. Bagian Kategori Keahlian dengan Wrap
              _buildSkillsSection(),
              const SizedBox(height: 20),

              // 4. Bagian Riwayat Proyek Mobile
              _buildProjectsSection(),
              const SizedBox(height: 24),

              // Tombol Checklist Tugas Lab
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF4ADE80),
                  border: Border.all(color: Colors.black, width: 2.5),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.verified, color: Colors.black, size: 28),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'PRAKTIKUM MINGGU 3 SELESAI!\nTunjukkan hasil ini kepada Dosen/Asisten Lab.',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Header Profil (Stack + Positioned)
  Widget _buildHeaderProfile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2.5),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
      ),
      child: Row(
        children: [
          // Foto Profil dengan Lencana Terverifikasi Melayang
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: const Color(0xFF38BDF8),
                    border: Border.all(color: Colors.black, width: 2.5),
                  ),
                  child: const Center(
                    child: Icon(Icons.person, size: 48, color: Colors.black),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4ADE80),
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Identitas Mahasiswa
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ahmad Fauzan',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                ),
                const SizedBox(height: 2),
                const Text(
                  'NIM: 120140042 • IF-2026',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _toggleFollow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFollowing
                        ? Colors.black
                        : const Color(0xFFFFE600),
                    foregroundColor: _isFollowing ? Colors.white : Colors.black,
                    elevation: 0,
                    side: const BorderSide(color: Colors.black, width: 2),
                    shape: const RoundedRectangleBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                  ),
                  child: Text(
                    _isFollowing ? 'MENGIKUTI' : '+ IKUTI PROFIL',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Baris Statistik Pengikut
  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem('Proyek', '14 App', const Color(0xFFE0F2FE)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStatItem(
            'Pengikut',
            '$_followers',
            const Color(0xFFFEF08A),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStatItem('IPK Lab', '3.92', const Color(0xFFDCFCE7)),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, Color col) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: col,
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(3, 3))],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  // Kategori Keahlian (Wrap)
  Widget _buildSkillsSection() {
    final skills = [
      'Flutter UI',
      'Dart Async',
      'Material 3',
      'GoRouter',
      'Clean Code',
      'Git Classroom',
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2.5),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Keahlian & Kompetensi Mobile:',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((s) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF8F5),
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
                child: Text(
                  s,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Riwayat Proyek (ListView di dalam Container)
  Widget _buildProjectsSection() {
    final projects = [
      {'title': 'Katalog Produk Kafe Kampus', 'tech': 'Layout Row & Column'},
      {
        'title': 'Simulasi Antrean Cerdas Barista',
        'tech': 'Stream async* & yield',
      },
      {
        'title': 'Portal Registrasi Mahasiswa Baru',
        'tech': 'Form & SingleChildScrollView',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2.5),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Portofolio Praktikum Minggu 1-3:',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
          ),
          const SizedBox(height: 10),
          ListView.separated(
            shrinkWrap: true, // Wajib di dalam SingleChildScrollView!
            physics:
                const NeverScrollableScrollPhysics(), // Scroll mengikuti halaman
            itemCount: projects.length,
            separatorBuilder: (ctx, i) =>
                const Divider(color: Colors.black, height: 16),
            itemBuilder: (ctx, i) {
              final p = projects[i];
              return Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    color: const Color(0xFFFB7185),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          p['tech']!,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 14),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

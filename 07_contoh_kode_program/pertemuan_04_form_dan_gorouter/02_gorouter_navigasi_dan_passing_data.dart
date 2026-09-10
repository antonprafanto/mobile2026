// =====================================================================
// CONTOH KODE LENGKAP & SIAP DIJALANKAN (RUNNABLE FLUTTER APP)
// PERTEMUAN 04: NAVIGASI DEKLARATIF GOROUTER, PARAMETER, & EXTRA
// =====================================================================
// Cara Menjalankan:
// 1. Pastikan package go_router sudah terpasang di terminal:
//    flutter pub add go_router
// 2. Salin seluruh isi berkas ini ke: lib/main.dart
// 3. Jalankan di browser Chrome:
//    flutter run -d chrome
//    (Perhatikan alamat URL di browser otomatis berganti!)
// =====================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// --- MODEL DATA UNTUK PENGIRIMAN OBJEK (EXTRA) ---
class Mahasiswa {
  final String nim;
  final String nama;
  final String prodi;
  final double ipk;

  const Mahasiswa({
    required this.nim,
    required this.nama,
    required this.prodi,
    required this.ipk,
  });
}

// --- MODEL DATA KATALOG BUKU ---
class Buku {
  final String id;
  final String judul;
  final String pengarang;
  final String deskripsi;

  const Buku({
    required this.id,
    required this.judul,
    required this.pengarang,
    required this.deskripsi,
  });
}

const List<Buku> daftarKatalogBuku = [
  Buku(
    id: '101',
    judul: 'Mastering Flutter 2026',
    pengarang: 'Google Developer Team',
    deskripsi: 'Panduan lengkap rekayasa aplikasi mobile modern lintas platform.',
  ),
  Buku(
    id: '102',
    judul: 'Clean Architecture with BLoC',
    pengarang: 'Mobile Enterprise Team',
    deskripsi: 'Pemisahan logika bisnis, data caching, dan arsitektur enterprise.',
  ),
  Buku(
    id: '103',
    judul: 'Modern Dart: Asynchronous & Streams',
    pengarang: 'Dart Language Specialist',
    deskripsi: 'Membedah masa depan Future, async-await, dan reactive streams.',
  ),
];

// =====================================================================
// DEFINISI RUTE TERPUSAT MENGGUNAKAN GOROUTER
// =====================================================================
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // 1. Rute Beranda (Katalog Buku)
    GoRoute(
      path: '/',
      builder: (context, state) => const KatalogBukuScreen(),
      routes: [
        // Rute Bersarang (Nested Route): /buku/:id
        GoRoute(
          path: 'buku/:id',
          builder: (context, state) {
            // Membaca Path Parameter ':id' dari URL
            final bookId = state.pathParameters['id']!;
            final buku = daftarKatalogBuku.firstWhere(
              (b) => b.id == bookId,
              orElse: () => const Buku(
                id: '0',
                judul: 'Tidak Ditemukan',
                pengarang: '-',
                deskripsi: 'Buku tidak terdaftar.',
              ),
            );
            return DetailBukuScreen(buku: buku);
          },
        ),
      ],
    ),

    // 2. Rute Hasil Pencarian (Membaca Query Parameters ?q=)
    GoRoute(
      path: '/cari',
      builder: (context, state) {
        // Membaca query dari URL misal: /cari?keyword=flutter
        final keyword = state.uri.queryParameters['keyword'] ?? 'Semua';
        return HasilPencarianScreen(keyword: keyword);
      },
    ),

    // 3. Rute Profil (Menerima Objek Utuh via 'extra')
    GoRoute(
      path: '/profil',
      builder: (context, state) {
        // Membaca objek data Mahasiswa yang dikirimkan
        final mhs = state.extra as Mahasiswa? ??
            const Mahasiswa(
              nim: '00000',
              nama: 'Tamu Anonim',
              prodi: 'Umum',
              ipk: 0.0,
            );
        return ProfilMahasiswaScreen(mahasiswa: mhs);
      },
    ),
  ],

  // 4. Penanganan Galat Halaman 404 (Not Found)
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(
      title: const Text('404: HALAMAN TIDAK DITEMUKAN'),
      backgroundColor: const Color(0xFFFB7185), // Merah Coral Neo-Brutal
      foregroundColor: Colors.black,
      shape: const Border(bottom: BorderSide(color: Colors.black, width: 2.5)),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: Color(0xFFFB7185)),
          const SizedBox(height: 16),
          Text(
            'Galat: Alamat "${state.uri}" Tidak Ditemukan!',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.go('/'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFE600),
              foregroundColor: Colors.black,
            ),
            child: const Text('Kembali ke Beranda'),
          ),
        ],
      ),
    ),
  ),
);

// =====================================================================
// ENTRY POINT APLIKASI
// =====================================================================
void main() {
  runApp(const NavigationDemoApp());
}

class NavigationDemoApp extends StatelessWidget {
  const NavigationDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan MaterialApp.router untuk mengaktifkan GoRouter
    return MaterialApp.router(
      title: 'Demo Navigasi GoRouter 2026',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter, // Pasang konfigurasi router
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAF8F5),
      ),
    );
  }
}

// =====================================================================
// LAYAR 1: KATALOG BUKU (BERANDA)
// =====================================================================
class KatalogBukuScreen extends StatelessWidget {
  const KatalogBukuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KATALOG PERPUSTAKAAN',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
        ),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 2.5)),
        actions: [
          // Tombol menuju profil dengan membawa objek 'extra'
          IconButton(
            icon: const Icon(Icons.account_circle, size: 28),
            tooltip: 'Buka Profil (Kirim Objek Extra)',
            onPressed: () {
              context.push(
                '/profil',
                extra: const Mahasiswa(
                  nim: '2301092026',
                  nama: 'Fajar Pratama',
                  prodi: 'Teknik Informatika',
                  ipk: 3.92,
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Bar Pencarian Contoh (Query Parameters)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF38BDF8), // Electric Cyan
              border: Border.all(color: Colors.black, width: 2.5),
              boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Cari buku kategori "Flutter"?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Berpindah menggunakan query parameter: /cari?keyword=Flutter
                    context.push('/cari?keyword=Flutter');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    side: const BorderSide(color: Colors.black, width: 2),
                  ),
                  child: const Text('Cari Sekarang'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            'DAFTAR KOLEKSI BUKU (KLIK UNTUK DETAIL):',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 0.5),
          ),
          const SizedBox(height: 10),

          // Daftar Kartu Buku
          ...daftarKatalogBuku.map((buku) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2.5),
                boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFFFE600),
                  foregroundColor: Colors.black,
                  child: Text(buku.id, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                title: Text(buku.judul, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Oleh: ${buku.pengarang}'),
                trailing: const Icon(Icons.arrow_forward, color: Colors.black),
                onTap: () {
                  // Berpindah menggunakan Path Parameters: /buku/:id
                  // Menggunakan context.push() agar ada tombol panah kembali (Back) di AppBar!
                  context.push('/buku/${buku.id}');
                },
              ),
            );
          }),

          const SizedBox(height: 10),
          // Tombol Tes 404
          TextButton.icon(
            onPressed: () => context.push('/halaman-asal-asalan'),
            icon: const Icon(Icons.bug_report, color: Colors.grey),
            label: const Text('Uji Coba Rute 404 (Sengaja Salah URL)', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// LAYAR 2: DETAIL BUKU (PATH PARAMETERS /buku/:id)
// =====================================================================
class DetailBukuScreen extends StatelessWidget {
  final Buku buku;

  const DetailBukuScreen({super.key, required this.buku});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DETAIL BUKU #${buku.id}'),
        backgroundColor: const Color(0xFF4ADE80), // Mint Green
        foregroundColor: Colors.black,
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 2.5)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2.5),
            boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(6, 6))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                buku.judul,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Text(
                'Pengarang: ${buku.pengarang}',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black89),
              ),
              const Divider(height: 30, thickness: 2, color: Colors.black),
              const Text(
                'Sinopsis Buku:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 6),
              Text(buku.deskripsi, style: const TextStyle(fontSize: 14, height: 1.5)),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  // Menutup layar dan kembali ke katalog
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('KEMBALI KE KATALOG'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFE600),
                  foregroundColor: Colors.black,
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

// =====================================================================
// LAYAR 3: HASIL PENCARIAN (QUERY PARAMETERS /cari?keyword=xxx)
// =====================================================================
class HasilPencarianScreen extends StatelessWidget {
  final String keyword;

  const HasilPencarianScreen({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HASIL PENCARIAN'),
        backgroundColor: const Color(0xFF38BDF8),
        foregroundColor: Colors.black,
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 2.5)),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2.5),
            boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(5, 5))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.search, size: 60, color: Color(0xFF38BDF8)),
              const SizedBox(height: 12),
              Text(
                'Menampilkan hasil untuk kata kunci:\n"$keyword"',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFE600),
                  foregroundColor: Colors.black,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  side: const BorderSide(color: Colors.black, width: 2),
                ),
                child: const Text('Tutup Hasil'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// LAYAR 4: PROFIL MAHASISWA (EXTRA OBJECT)
// =====================================================================
class ProfilMahasiswaScreen extends StatelessWidget {
  final Mahasiswa mahasiswa;

  const ProfilMahasiswaScreen({super.key, required this.mahasiswa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFIL MAHASISWA'),
        backgroundColor: const Color(0xFFC084FC), // Lavender Neo-Brutal
        foregroundColor: Colors.black,
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 2.5)),
      ),
      body: Center(
        child: Container(
          width: 380,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE600),
            border: Border.all(color: Colors.black, width: 2.5),
            boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(6, 6))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.badge, size: 28),
                  SizedBox(width: 8),
                  Text('KARTU IDENTITAS SIKAD', style: TextStyle(fontWeight: FontWeight.w900)),
                ],
              ),
              const Divider(color: Colors.black, thickness: 2, height: 24),
              Text('NIM         : ${mahasiswa.nim}', style: const TextStyle(fontFamily: 'Consolas', fontSize: 14)),
              const SizedBox(height: 6),
              Text('Nama Lengkap: ${mahasiswa.nama}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 6),
              Text('Program Studi: ${mahasiswa.prodi}', style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 6),
              Text('IPK Kumulatif: ${mahasiswa.ipk.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    side: const BorderSide(color: Colors.black, width: 2),
                  ),
                  child: const Text('KEMBALI'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 13: FITUR PERANGKAT & IZIN
// CONTOH 02: Mengambil Foto dari Galeri dan Kamera (image_picker)
// Topik: Aplikasi "Foto Profil" dengan paket image_picker:
//        1. pickImage(source: ImageSource.gallery / camera) membuka
//           pemilih foto atau aplikasi kamera BAWAAN sistem. Aplikasi
//           kita tidak perlu membuat tampilan kamera sendiri;
//        2. hasilnya XFile: berkas SEMENTARA. Isinya dibaca sebagai bita
//           (readAsBytes) lalu ditampilkan dengan Image.memory, cara
//           yang sama di Android, iOS, maupun web;
//        3. maxWidth dan imageQuality mengecilkan foto sebelum dipakai;
//        4. pengguna boleh membatalkan (hasilnya null), dan galat bisa
//           terjadi (PlatformException), misalnya akses kamera ditolak;
//        5. tombol Kamera hanya muncul jika perangkat mendukungnya
//           (supportsImageSource);
//        6. khusus Android: retrieveLostData() memulihkan foto jika
//           aplikasi sempat ditutup sistem saat kamera sedang terbuka.
// =====================================================================
// CARA MENJALANKAN (tidak bisa di DartPad, karena DartPad tidak
// menyediakan paket image_picker):
// 1. Di proyek Flutter, jalankan sekali: flutter pub add image_picker
// 2. Khusus iOS: tambahkan NSPhotoLibraryUsageDescription dan
//    NSCameraUsageDescription ke ios/Runner/Info.plist (modul Bagian
//    3). Android dan web tidak membutuhkan pengaturan tambahan.
// 3. Salin seluruh isi berkas ini ke lib/main.dart.
// 4. Jalankan: flutter run -d chrome --web-port=8080
//    (di HP Android cukup: flutter run). Di Chrome laptop, tombol
//    Kamera biasanya membuka pemilih berkas, bukan webcam.
// =====================================================================

import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const AplikasiFotoProfil());

class AplikasiFotoProfil extends StatelessWidget {
  const AplikasiFotoProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foto Profil',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: const HalamanFotoProfil(),
    );
  }
}

// ============================== MODEL ==============================

/// Foto yang sudah dibaca dari XFile, siap ditampilkan.
class FotoTerpilih {
  const FotoTerpilih({
    required this.nama,
    required this.bita,
    required this.lebar,
    required this.tinggi,
    this.jenis,
  });

  final String nama;
  final Uint8List bita;
  final int lebar;
  final int tinggi;

  /// Jenis berkas (MIME), misalnya image/jpeg. Di Android bisa null.
  final String? jenis;
}

/// 850 B, 312 KB, 1,4 MB.
String teksUkuran(int bita) {
  if (bita < 1024) return '$bita B';
  if (bita < 1024 * 1024) return '${(bita / 1024).round()} KB';
  final String mb = (bita / (1024 * 1024)).toStringAsFixed(1);
  return '${mb.replaceAll('.', ',')} MB';
}

/// Mengubah kode galat image_picker menjadi kalimat untuk pengguna.
String pesanGalatFoto(PlatformException e) {
  return switch (e.code) {
    'camera_access_denied' =>
      'Akses kamera ditolak. Anda bisa mengizinkannya di Pengaturan.',
    'photo_access_denied' =>
      'Akses galeri ditolak. Anda bisa mengizinkannya di Pengaturan.',
    'camera_access_restricted' ||
    'photo_access_restricted' => 'Akses dibatasi oleh pengaturan perangkat.',
    'no_available_camera' => 'Perangkat ini tidak memiliki kamera.',
    'already_active' ||
    'multiple_request' => 'Pemilih foto masih terbuka. Coba lagi.',
    _ => 'Foto gagal diambil (${e.code}).',
  };
}

// ============================== HALAMAN ==============================

class HalamanFotoProfil extends StatefulWidget {
  const HalamanFotoProfil({super.key});

  @override
  State<HalamanFotoProfil> createState() => _HalamanFotoProfilState();
}

class _HalamanFotoProfilState extends State<HalamanFotoProfil> {
  // Cukup satu objek untuk seluruh halaman.
  final ImagePicker _pemilih = ImagePicker();
  FotoTerpilih? _foto;
  bool _sedangMemilih = false;

  @override
  void initState() {
    super.initState();
    _pulihkanFotoYangHilang();
  }

  /// Saat kamera terbuka, Android boleh mematikan aplikasi kita jika
  /// memori menipis. Ketika aplikasi dibuka lagi, foto yang sempat
  /// diambil masih bisa diminta SEKALI lewat retrieveLostData().
  Future<void> _pulihkanFotoYangHilang() async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    final LostDataResponse respons = await _pemilih.retrieveLostData();
    final XFile? berkas = respons.file;
    if (respons.isEmpty || berkas == null) return;
    await _tampilkan(berkas);
  }

  Future<void> _ambilFoto(ImageSource sumber) async {
    if (_sedangMemilih) return; // cegah pemilih terbuka dua kali
    setState(() => _sedangMemilih = true);
    try {
      final XFile? berkas = await _pemilih.pickImage(
        source: sumber,
        maxWidth: 1080, // foto 4000 piksel diperkecil menjadi 1080
        imageQuality: 80, // 0-100; berlaku untuk JPEG (dan WebP)
        // Untuk foto profil, MINTA kamera depan. Ini permintaan, bukan
        // jaminan: sebagian HP Android tetap membuka kamera belakang.
        preferredCameraDevice: CameraDevice.front,
        // Kita tidak butuh metadata lengkap (misalnya lokasi pemotretan).
        // Di iOS, ini juga menghindari permintaan izin tambahan.
        requestFullMetadata: false,
      );
      if (berkas == null) {
        _beriTahu('Tidak ada foto yang dipilih.');
        return;
      }
      await _tampilkan(berkas);
    } on PlatformException catch (e) {
      _beriTahu(pesanGalatFoto(e));
    } finally {
      if (mounted) setState(() => _sedangMemilih = false);
    }
  }

  /// Membaca isi berkas, lalu mencari tahu ukuran gambarnya.
  Future<void> _tampilkan(XFile berkas) async {
    final Uint8List bita = await berkas.readAsBytes();
    final ui.Image gambar = await decodeImageFromList(bita);
    final FotoTerpilih foto = FotoTerpilih(
      nama: berkas.name,
      bita: bita,
      lebar: gambar.width,
      tinggi: gambar.height,
      jenis: berkas.mimeType,
    );
    gambar.dispose(); // yang kita perlukan hanya ukurannya
    if (!mounted) return;
    setState(() => _foto = foto);
  }

  void _beriTahu(String pesan) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(pesan)));
  }

  @override
  Widget build(BuildContext context) {
    final FotoTerpilih? foto = _foto;
    // Di Android, iOS, dan web: true. Di Windows/Linux/macOS: false.
    final bool kameraAda = _pemilih.supportsImageSource(ImageSource.camera);
    final TextTheme teks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Foto Profil')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(child: _Avatar(foto: foto)),
          const SizedBox(height: 16),
          if (_sedangMemilih) const LinearProgressIndicator(),
          if (foto == null)
            Text(
              'Belum ada foto. Pilih dari galeri atau ambil dengan kamera.',
              textAlign: TextAlign.center,
              style: teks.bodyLarge,
            )
          else
            _InfoBerkas(foto: foto),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: _sedangMemilih
                    ? null
                    : () => _ambilFoto(ImageSource.gallery),
                icon: const Icon(Icons.photo_library_outlined),
                label: const Text('Galeri'),
              ),
              if (kameraAda)
                FilledButton.tonalIcon(
                  onPressed: _sedangMemilih
                      ? null
                      : () => _ambilFoto(ImageSource.camera),
                  icon: const Icon(Icons.photo_camera_outlined),
                  label: const Text('Kamera'),
                ),
              if (foto != null)
                TextButton.icon(
                  onPressed: () => setState(() => _foto = null),
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Hapus foto'),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Foto hanya disimpan selama aplikasi terbuka.',
            textAlign: TextAlign.center,
            style: teks.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.foto});

  final FotoTerpilih? foto;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final FotoTerpilih? f = foto;
    return ClipOval(
      child: SizedBox.square(
        dimension: 160,
        child: f == null
            ? ColoredBox(
                color: warna.surfaceContainerHighest,
                child: Icon(Icons.person, size: 96, color: warna.outline),
              )
            // cacheWidth: gambar diuraikan (decode) seukuran tampilan
            // saja, sehingga memori tidak terbuang untuk foto besar.
            : Image.memory(f.bita, fit: BoxFit.cover, cacheWidth: 480),
      ),
    );
  }
}

class _InfoBerkas extends StatelessWidget {
  const _InfoBerkas({required this.foto});

  final FotoTerpilih foto;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.image_outlined),
            title: const Text('Nama berkas'),
            subtitle: Text(foto.nama),
          ),
          ListTile(
            leading: const Icon(Icons.aspect_ratio),
            title: const Text('Ukuran gambar'),
            subtitle: Text('${foto.lebar} x ${foto.tinggi} piksel'),
          ),
          ListTile(
            leading: const Icon(Icons.sd_storage_outlined),
            title: const Text('Ukuran berkas'),
            subtitle: Text(
              '${teksUkuran(foto.bita.length)} · '
              '${foto.jenis ?? 'jenis tidak dilaporkan'}',
            ),
          ),
        ],
      ),
    );
  }
}

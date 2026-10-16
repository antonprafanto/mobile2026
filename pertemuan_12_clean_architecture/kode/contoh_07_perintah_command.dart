// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 12: CLEAN ARCHITECTURE
// CONTOH 07: Perintah (Command): Status Milik Setiap Aksi
// Topik: Server palsu di contoh ini butuh 2 detik untuk menyimpan satu
//        pengajuan. Ketuk tombol "Ajukan" tiga kali dengan cepat di
//        kedua kartu, lalu perhatikan angka di bagian atas layar:
//        - Kartu A (tanpa Perintah): tiga ketukan = TIGA pengajuan
//          terkirim, dan tiga SnackBar muncul berurutan.
//        - Kartu B (dengan Perintah): tiga ketukan = SATU pengajuan.
//          Selama perintah berjalan, tombolnya mati dan memutar
//          lingkaran kecil.
//        Perintah (Command) membungkus satu aksi ViewModel beserta
//        statusnya: sedangBerjalan, hasil (Berhasil/Gagal), dan
//        bersihkanHasil() agar SnackBar hanya muncul satu kali.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Proyek Flutter: jalankan sekali `flutter pub add provider`, salin
//    seluruh isi berkas ini ke lib/main.dart, lalu
//    flutter run -d chrome --web-port=8080
// =====================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // Akar komposisi versi ringkas: implementasi repository dipilih di sini.
    ChangeNotifierProvider(
      create: (BuildContext context) =>
          FormulirViewModel(repositori: RepositoriPeminjamanLambat()),
      child: MaterialApp(
        title: 'Perintah',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        ),
        home: const HalamanPerintah(),
      ),
    ),
  );
}

// ============================== DOMAIN ==============================

// Versi ringkas Hasil dari Contoh 05. Agar contoh ini fokus pada
// Perintah, Gagal di sini cukup membawa satu kalimat pesan.
sealed class Hasil<T> {
  const Hasil();
}

final class Berhasil<T> extends Hasil<T> {
  const Berhasil(this.nilai);

  final T nilai;
}

final class Gagal<T> extends Hasil<T> {
  const Gagal(this.pesan);

  final String pesan;
}

abstract class RepositoriPeminjaman {
  // Mengembalikan nomor peminjaman baru jika berhasil.
  Future<Hasil<String>> ajukan(String keperluan);
}

// =============================== DATA ===============================

// Server palsu yang lambat: 2 detik untuk menyimpan setiap pengajuan.
class RepositoriPeminjamanLambat implements RepositoriPeminjaman {
  int _nomorTerakhir = 0;

  @override
  Future<Hasil<String>> ajukan(String keperluan) async {
    _nomorTerakhir++;
    final String id = 'PJ-${_nomorTerakhir.toString().padLeft(3, '0')}';
    await Future<void>.delayed(const Duration(seconds: 2));
    return Berhasil(id);
  }
}

// ========== UI: PERINTAH (di proyek: lib/ui/core/perintah.dart) ==========
// Perintah (Command): membungkus satu aksi ViewModel beserta statusnya
// (sedang berjalan, berhasil, gagal). View cukup mendengarkan perintah
// itu. Perintah yang sedang berjalan tidak bisa dijalankan lagi, jadi
// tombol yang diketuk dua kali tidak mengirim dua permintaan.

abstract class Perintah<T> extends ChangeNotifier {
  bool _sedangBerjalan = false;
  Hasil<T>? _hasil;
  bool _sudahDibuang = false;

  bool get sedangBerjalan => _sedangBerjalan;

  // Hasil terakhir; null jika belum pernah dijalankan atau sudah dibaca.
  Hasil<T>? get hasil => _hasil;

  bool get gagal => _hasil is Gagal<T>;

  bool get berhasil => _hasil is Berhasil<T>;

  // Dipanggil View setelah menanggapi hasil (misalnya menampilkan
  // SnackBar), agar tanggapan itu tidak muncul berulang kali.
  void bersihkanHasil() {
    _hasil = null;
    _kabari();
  }

  Future<void> _jalankan(Future<Hasil<T>> Function() aksi) async {
    // Penjaga: selama aksi masih berjalan, ketukan berikutnya diabaikan.
    if (_sedangBerjalan) return;
    _sedangBerjalan = true;
    _hasil = null;
    _kabari();
    try {
      _hasil = await aksi();
    } finally {
      // finally: tetap dijalankan walaupun aksi melempar exception,
      // sehingga tombol tidak terkunci selamanya.
      _sedangBerjalan = false;
      _kabari();
    }
  }

  void _kabari() {
    if (!_sudahDibuang) notifyListeners();
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    super.dispose();
  }
}

// Perintah tanpa argumen, misalnya "muat" (dipakai di Contoh 08).
class Perintah0<T> extends Perintah<T> {
  Perintah0(this._aksi);

  final Future<Hasil<T>> Function() _aksi;

  Future<void> jalankan() => _jalankan(_aksi);
}

// Perintah dengan satu argumen A, misalnya "ajukan(keperluan)".
class Perintah1<T, A> extends Perintah<T> {
  Perintah1(this._aksi);

  final Future<Hasil<T>> Function(A) _aksi;

  Future<void> jalankan(A argumen) => _jalankan(() => _aksi(argumen));
}

// ============================ UI: VIEWMODEL ============================

class FormulirViewModel extends ChangeNotifier {
  FormulirViewModel({required this._repositori}) {
    ajukan = Perintah1<String, String>(_kirim);
  }

  final RepositoriPeminjaman _repositori;

  // Kartu B: aksi _kirim dibungkus Perintah. late final: diisi sekali
  // di constructor, karena _kirim butuh `this`.
  late final Perintah1<String, String> ajukan;

  int _jumlahDikirim = 0;

  int get jumlahDikirim => _jumlahDikirim;

  // Kartu A: aksi yang SAMA, tetapi dipanggil langsung. Tidak ada penjaga
  // dan tidak ada status "sedang berjalan".
  Future<Hasil<String>> ajukanTanpaPerintah(String keperluan) {
    return _kirim(keperluan);
  }

  Future<Hasil<String>> _kirim(String keperluan) {
    _jumlahDikirim++;
    notifyListeners(); // angka di bagian atas layar langsung bertambah
    return _repositori.ajukan(keperluan);
  }

  @override
  void dispose() {
    ajukan.dispose();
    super.dispose();
  }
}

// =============================== VIEW ===============================

class HalamanPerintah extends StatefulWidget {
  const HalamanPerintah({super.key});

  @override
  State<HalamanPerintah> createState() => _HalamanPerintahState();
}

class _HalamanPerintahState extends State<HalamanPerintah> {
  // Disimpan agar listener bisa dilepas lagi di dispose().
  late final FormulirViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = context.read<FormulirViewModel>();
    // Mendengarkan PERINTAH ajukan (bukan seluruh ViewModel) untuk
    // menampilkan SnackBar tepat satu kali setiap perintah selesai.
    _vm.ajukan.addListener(_saatAjukanBerubah);
  }

  @override
  void dispose() {
    _vm.ajukan.removeListener(_saatAjukanBerubah);
    super.dispose();
  }

  void _saatAjukanBerubah() {
    final Hasil<String>? hasil = _vm.ajukan.hasil;
    if (hasil == null) return; // belum selesai, atau sudah ditanggapi
    _vm.ajukan.bersihkanHasil(); // tanggapi satu kali saja
    _tampilkan('B', hasil);
  }

  void _tampilkan(String kartu, Hasil<String> hasil) {
    // Server palsu ini selalu berhasil, tetapi switch tetap wajib
    // menangani Gagal karena Hasil adalah sealed class.
    final String teks = switch (hasil) {
      Berhasil(:final String nilai) => 'Kartu $kartu: $nilai tersimpan.',
      Gagal(:final String pesan) => 'Kartu $kartu gagal: $pesan',
    };
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(teks), duration: const Duration(seconds: 2)),
    );
  }

  // Kartu A: setiap ketukan langsung memanggil ViewModel.
  Future<void> _ajukanTanpaPerintah() async {
    final Hasil<String> hasil = await _vm.ajukanTanpaPerintah('Rapat A');
    if (!mounted) return;
    _tampilkan('A', hasil);
  }

  @override
  Widget build(BuildContext context) {
    final FormulirViewModel vm = context.watch<FormulirViewModel>();
    final TextTheme teks = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Perintah (Command)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Pengajuan yang terkirim ke server: ${vm.jumlahDikirim}',
            style: teks.titleMedium,
          ),
          const SizedBox(height: 4),
          const Text(
            'Server butuh 2 detik untuk setiap pengajuan. Ketuk setiap '
            'tombol tiga kali dengan cepat.',
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('A. Tanpa Perintah', style: teks.titleSmall),
                  const Text('Setiap ketukan mengirim pengajuan baru.'),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: _ajukanTanpaPerintah,
                    icon: const Icon(Icons.send),
                    label: const Text('Ajukan'),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('B. Dengan Perintah', style: teks.titleSmall),
                  const Text('Ketukan diabaikan selama perintah berjalan.'),
                  const SizedBox(height: 12),
                  // Hanya tombol ini yang dibangun ulang saat status
                  // perintah ajukan berubah.
                  ListenableBuilder(
                    listenable: vm.ajukan,
                    builder: (BuildContext context, Widget? child) {
                      final bool sibuk = vm.ajukan.sedangBerjalan;
                      return FilledButton.icon(
                        // onPressed null = tombol mati (abu-abu).
                        onPressed: sibuk
                            ? null
                            : () => vm.ajukan.jalankan('Rapat B'),
                        icon: sibuk
                            ? const SizedBox.square(
                                dimension: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.send),
                        label: Text(sibuk ? 'Menyimpan...' : 'Ajukan'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

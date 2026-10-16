// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 16: UJIAN AKHIR SEMESTER
// CONTOH 03: Kartu Latihan Tanya Jawab
// Topik: Alat bantu berlatih tanya jawab UAS secara berpasangan (Gladi
//        Resik Kegiatan 6). Satu orang memegang aplikasi dan membacakan
//        pertanyaan; yang lain menjawab sambil MENUNJUK kodenya sendiri.
//        Sesudah menjawab, buka "poin jawaban" untuk mencocokkan, lalu
//        tandai "Sudah bisa" atau "Perlu diulang".
//        Pola yang dipakai sudah Anda kenal:
//        1. data kartu = List objek konstan, kategori = enum;
//        2. ViewModel menyimpan antrean kartu, posisi, dan hasil latihan;
//        3. pengacak (Random) DISUNTIKKAN, sehingga urutan kartu bisa
//           dibuat tetap saat diuji (Pertemuan 14);
//        4. FilterChip memilih kategori; ringkasan muncul di akhir.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Proyek Flutter: salin berkas ini ke lib/main.dart, lalu
//    flutter run -d chrome (atau jalankan di HP Android).
// =====================================================================

import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const AplikasiLatihanTanyaJawab());

// ============================== DATA ==============================

enum Kategori {
  arsitektur('Arsitektur', Icons.account_tree),
  state('State', Icons.sync),
  api('API dan asinkron', Icons.cloud_download),
  penyimpanan('Penyimpanan', Icons.storage),
  pengujian('Pengujian', Icons.fact_check),
  tampilan('Tampilan', Icons.palette),
  rilis('Rilis dan Git', Icons.rocket_launch);

  const Kategori(this.label, this.ikon);

  final String label;
  final IconData ikon;
}

class KartuPertanyaan {
  const KartuPertanyaan({
    required this.kategori,
    required this.pertanyaan,
    required this.poinJawaban,
    required this.rujukan,
  });

  final Kategori kategori;
  final String pertanyaan;
  final List<String> poinJawaban; // hal yang sebaiknya muncul di jawaban
  final String rujukan; // bagian modul untuk dibaca ulang
}

/// Pertanyaan yang sering muncul saat tanya jawab UAS. Jawablah untuk
/// APLIKASI ANDA SENDIRI, sambil menunjuk berkas dan barisnya.
const List<KartuPertanyaan> semuaKartu = <KartuPertanyaan>[
  // ----------------------------- Arsitektur -----------------------------
  KartuPertanyaan(
    kategori: Kategori.arsitektur,
    pertanyaan:
        'Ceritakan perjalanan data dari internet sampai tampil di layar. '
        'Sebutkan berkasnya satu per satu.',
    poinJawaban: [
      'View meminta ViewModel memuat data, misalnya saat halaman dibuka.',
      'ViewModel meminta ke repository, tidak langsung memanggil http.',
      'Repository memanggil API, mengubah JSON menjadi model, lalu '
          'mengembalikan hasil atau kegagalan.',
      'ViewModel menyimpan status (memuat, berhasil, gagal), memanggil '
          'notifyListeners(), lalu View menggambar ulang.',
    ],
    rujukan: 'P9 Bagian 9-10, P10 Bagian 9',
  ),
  KartuPertanyaan(
    kategori: Kategori.arsitektur,
    pertanyaan:
        'Mengapa View tidak memanggil http atau database secara langsung?',
    poinJawaban: [
      'Tugas terpisah: View hanya menampilkan dan meneruskan aksi.',
      'Sumber data bisa diganti (API, cache, data palsu) tanpa mengubah '
          'View.',
      'Logikanya bisa diuji tanpa layar dan tanpa internet.',
    ],
    rujukan: 'P9 Bagian 9, P12 Bagian 1',
  ),
  KartuPertanyaan(
    kategori: Kategori.arsitektur,
    pertanyaan:
        'API Anda tiba-tiba mati. Bagian mana yang perlu diubah agar '
        'aplikasi memakai data palsu?',
    poinJawaban: [
      'Cukup satu tempat: bagian yang membuat repository (main atau '
          'akar komposisi).',
      'ViewModel dan View tidak berubah karena bergantung pada kontrak.',
      'Contoh: main_pengembangan.dart atau '
          '--dart-define=LINGKUNGAN=pengembangan.',
    ],
    rujukan: 'P12 Bagian 4, P15 Bagian 3',
  ),
  // ------------------------------- State -------------------------------
  KartuPertanyaan(
    kategori: Kategori.state,
    pertanyaan:
        'Apa beda state lokal dan state aplikasi? Beri satu contoh dari '
        'aplikasi Anda.',
    poinJawaban: [
      'State lokal hanya dipakai satu widget (isi kolom teks, tab '
          'terpilih): cukup setState.',
      'State aplikasi dipakai banyak halaman (tema, keranjang, data '
          'pengguna): ChangeNotifier dan provider.',
    ],
    rujukan: 'P9 Bagian 2',
  ),
  KartuPertanyaan(
    kategori: Kategori.state,
    pertanyaan:
        'Apa yang terjadi jika notifyListeners() lupa dipanggil setelah '
        'data berubah?',
    poinJawaban: [
      'Data di ViewModel sudah berubah, tetapi layar tidak digambar ulang.',
      'Layar baru berubah saat hal lain memicu build, sehingga terlihat '
          'seperti bug acak.',
    ],
    rujukan: 'P9 Bagian 3',
  ),
  KartuPertanyaan(
    kategori: Kategori.state,
    pertanyaan: 'Kapan memakai context.watch dan kapan context.read?',
    poinJawaban: [
      'Menampilkan data: watch (atau select) di dalam build, agar widget '
          'dibangun ulang saat data berubah.',
      'Memanggil metode: read di onPressed, onChanged, atau initState; '
          'widget tidak ikut dibangun ulang.',
    ],
    rujukan: 'P9 Bagian 7',
  ),
  // ------------------------------- API -------------------------------
  KartuPertanyaan(
    kategori: Kategori.api,
    pertanyaan:
        'Apa yang tampil saat internet mati ketika data sedang dimuat? '
        'Tunjukkan kodenya.',
    poinJawaban: [
      'Pesan ramah dan tombol Coba lagi, bukan layar merah atau putaran '
          'tanpa akhir.',
      'Exception jaringan ditangkap di lapisan data lalu diterjemahkan '
          'menjadi kegagalan.',
      'Jika ada cache, data terakhir tetap ditampilkan.',
    ],
    rujukan: 'P10 Bagian 8, P11 Bagian 10',
  ),
  KartuPertanyaan(
    kategori: Kategori.api,
    pertanyaan:
        'Di mana JSON diubah menjadi objek Dart? Apa yang terjadi jika '
        'bentuk JSON-nya tidak sesuai?',
    poinJawaban: [
      'Di model (factory fromJson) atau pemetaan di lapisan data.',
      'Bentuk yang tidak cocok dihentikan dengan FormatException yang '
          'jelas, bukan diam-diam menjadi data kosong.',
      'Angka dari JSON dibaca sebagai num agar aman di web dan Android.',
    ],
    rujukan: 'P10 Bagian 6',
  ),
  KartuPertanyaan(
    kategori: Kategori.api,
    pertanyaan:
        'Mengapa memakai async dan await? Apa yang dilihat pengguna '
        'selama menunggu jawaban server?',
    poinJawaban: [
      'Permintaan jaringan butuh waktu; await menunggu tanpa membekukan '
          'layar.',
      'Selama menunggu, status ViewModel "memuat" dan layar menampilkan '
          'indikator.',
      'Setelah await di dalam State, periksa mounted sebelum memakai '
          'context.',
    ],
    rujukan: 'P10 Bagian 4 dan 8',
  ),
  // ---------------------------- Penyimpanan ----------------------------
  KartuPertanyaan(
    kategori: Kategori.penyimpanan,
    pertanyaan:
        'Data apa yang disimpan di perangkat, dan mengapa memakai '
        'shared_preferences atau SQLite?',
    poinJawaban: [
      'shared_preferences untuk pengaturan kecil (tema, pilihan terakhir).',
      'SQLite untuk data yang banyak, dicari, dan diubah (catatan, '
          'favorit).',
      'Data rahasia seperti token tidak disimpan di keduanya.',
    ],
    rujukan: 'P11 Bagian 1 dan 13',
  ),
  KartuPertanyaan(
    kategori: Kategori.penyimpanan,
    pertanyaan:
        'Buktikan data tetap ada setelah aplikasi ditutup. Apa yang '
        'terjadi di kode saat aplikasi dibuka lagi?',
    poinJawaban: [
      'Saat mulai, repository membaca database atau prefs, lalu '
          'ViewModel mengisi layar.',
      'Pengaturan untuk layar pertama dibaca sebelum runApp '
          '(SharedPreferencesWithCache) agar layar tidak berkedip.',
    ],
    rujukan: 'P11 Bagian 3 dan 7',
  ),
  KartuPertanyaan(
    kategori: Kategori.penyimpanan,
    pertanyaan:
        'Mengapa memakai tanda ? dan whereArgs, bukan menyusun perintah '
        'SQL dari teks isian?',
    poinJawaban: [
      'Isian pengguna diperlakukan sebagai data, bukan bagian perintah.',
      "Mencegah SQL injection, misalnya isian berbunyi: ' OR '1'='1",
    ],
    rujukan: 'P11 Bagian 6',
  ),
  // ----------------------------- Pengujian -----------------------------
  KartuPertanyaan(
    kategori: Kategori.pengujian,
    pertanyaan:
        'Tunjukkan satu tes yang menguji nilai batas. Mengapa nilai itu '
        'yang dipilih?',
    poinJawaban: [
      'Bug paling sering bersembunyi di batas: 0, nilai maksimal, tepat '
          'di ambang.',
      'Tes memakai pola siapkan, lakukan, periksa, dan namanya '
          'menjelaskan perilaku yang diuji.',
    ],
    rujukan: 'P14 Bagian 2-3',
  ),
  KartuPertanyaan(
    kategori: Kategori.pengujian,
    pertanyaan:
        'Mengapa tes ViewModel memakai repository palsu, bukan API '
        'sungguhan?',
    poinJawaban: [
      'Cepat dan stabil: tidak bergantung internet atau server.',
      'Bisa meniru keadaan sulit: gagal, kosong, lambat.',
      'Bisa menghitung panggilan, misalnya memastikan tidak ada '
          'permintaan ganda.',
    ],
    rujukan: 'P14 Bagian 5',
  ),
  KartuPertanyaan(
    kategori: Kategori.pengujian,
    pertanyaan:
        'Ubah satu aturan di kode Anda, lalu jalankan flutter test. Tes '
        'mana yang merah, dan apa artinya?',
    poinJawaban: [
      'Tes penjaga aturan itu gagal: tandanya tes benar-benar memeriksa '
          'perilaku.',
      'Pesan Expected dan Actual menunjukkan nilai yang diharapkan dan '
          'yang didapat.',
      'Kembalikan aturannya; semua tes hijau lagi.',
    ],
    rujukan: 'P14 Bagian 2 dan 16',
  ),
  // ----------------------------- Tampilan -----------------------------
  KartuPertanyaan(
    kategori: Kategori.tampilan,
    pertanyaan:
        'Mengapa warna diambil dari Theme.of(context).colorScheme, bukan '
        'Colors.xxx?',
    poinJawaban: [
      'Satu warna benih menghasilkan peran warna yang serasi.',
      'Mode gelap otomatis mendapat pasangan warna yang kontras.',
      'Mengganti tema cukup di satu tempat.',
    ],
    rujukan: 'P7 Bagian 4 dan 7',
  ),
  KartuPertanyaan(
    kategori: Kategori.tampilan,
    pertanyaan:
        'Bagaimana tampilan Anda berubah di layar lebar? Tunjukkan '
        'kodenya.',
    poinJawaban: [
      'MediaQuery atau LayoutBuilder membaca lebar; patokannya '
          'breakpoint 600 dan 840.',
      'Di layar lebar: daftar dan detail berdampingan, atau '
          'NavigationRail.',
    ],
    rujukan: 'P7 Bagian 10-13',
  ),
  KartuPertanyaan(
    kategori: Kategori.tampilan,
    pertanyaan:
        'Apa yang terjadi jika pengguna memperbesar ukuran huruf di '
        'pengaturan HP?',
    poinJawaban: [
      'Teks ikut membesar; tata letak harus tetap muat tanpa pita '
          'kuning-hitam.',
      'Pakai Expanded atau Flexible, ellipsis, dan daftar yang bisa '
          'digulir.',
      'Diuji dengan layar 320 piksel dan huruf 200%.',
    ],
    rujukan: 'P7 Bagian 14, P14 Bagian 7',
  ),
  // ---------------------------- Rilis dan Git ----------------------------
  KartuPertanyaan(
    kategori: Kategori.rilis,
    pertanyaan:
        'Dari mana tulisan versi di halaman Tentang berasal? Apa yang '
        'diubah saat merilis 1.0.1?',
    poinJawaban: [
      'Dari baris version di pubspec.yaml, dibaca dengan '
          'package_info_plus.',
      'Rilis perbaikan: version 1.0.1+2 (nomor build ikut naik), '
          'CHANGELOG, lalu tag v1.0.1.',
    ],
    rujukan: 'P15 Bagian 5 dan 12',
  ),
  KartuPertanyaan(
    kategori: Kategori.rilis,
    pertanyaan:
        'Mengapa key.properties dan berkas .jks tidak boleh masuk '
        'repositori?',
    poinJawaban: [
      'Kunci unggah adalah tanda tangan aplikasi; pemiliknya bisa '
          'menandatangani pembaruan palsu.',
      'Simpan di luar repositori dan buat cadangannya; di GitHub '
          'Actions pakai secrets.',
    ],
    rujukan: 'P15 Bagian 11',
  ),
  KartuPertanyaan(
    kategori: Kategori.rilis,
    pertanyaan:
        'Tunjukkan commit Anda sendiri. Bagian mana yang paling Anda '
        'pahami?',
    poinJawaban: [
      'git log --author="Nama" --oneline, atau tab Insights lalu '
          'Contributors di GitHub.',
      'Ceritakan satu masalah yang Anda temui dan cara '
          'menyelesaikannya.',
    ],
    rujukan: 'Panduan Proyek Akhir Bagian 8',
  ),
];

// ============================ VIEWMODEL ============================

class LatihanTanyaJawabViewModel extends ChangeNotifier {
  LatihanTanyaJawabViewModel({required this._kartu, Random? acak})
    : _acak = acak ?? Random() {
    _susunAntrean();
  }

  final List<KartuPertanyaan> _kartu;
  final Random _acak; // di tes: Random(angka tetap) agar urutannya sama

  final Set<Kategori> _kategoriTerpilih = Kategori.values.toSet();
  List<KartuPertanyaan> _antrean = <KartuPertanyaan>[];
  int _posisi = 0;
  bool _poinTerlihat = false;
  final List<KartuPertanyaan> _sudahBisa = <KartuPertanyaan>[];
  final List<KartuPertanyaan> _perluDiulang = <KartuPertanyaan>[];

  Set<Kategori> get kategoriTerpilih => Set.unmodifiable(_kategoriTerpilih);
  int get jumlahKartu => _antrean.length;
  int get posisi => _posisi; // dimulai dari 0
  bool get selesai => _posisi >= _antrean.length;
  KartuPertanyaan? get kartuSekarang => selesai ? null : _antrean[_posisi];
  bool get poinTerlihat => _poinTerlihat;
  List<KartuPertanyaan> get sudahBisa => List.unmodifiable(_sudahBisa);
  List<KartuPertanyaan> get perluDiulang => List.unmodifiable(_perluDiulang);

  /// Memilih atau melepas kategori. Kategori terakhir tidak bisa dilepas,
  /// agar antrean tidak pernah kosong.
  void ubahKategori(Kategori kategori, {required bool dipilih}) {
    if (dipilih) {
      _kategoriTerpilih.add(kategori);
    } else {
      if (_kategoriTerpilih.length == 1) return;
      _kategoriTerpilih.remove(kategori);
    }
    _susunAntrean();
    notifyListeners();
  }

  void kocokUlang() {
    _susunAntrean();
    notifyListeners();
  }

  void tampilkanPoin() {
    _poinTerlihat = true;
    notifyListeners();
  }

  /// Mencatat hasil kartu sekarang, lalu maju ke kartu berikutnya.
  void tandai({required bool bisa}) {
    final KartuPertanyaan? kartu = kartuSekarang;
    if (kartu == null) return;
    if (bisa) {
      _sudahBisa.add(kartu);
    } else {
      _perluDiulang.add(kartu);
    }
    _posisi++;
    _poinTerlihat = false;
    notifyListeners();
  }

  /// Berlatih lagi, khusus kartu yang ditandai "Perlu diulang".
  void ulangiYangPerluDiulang() {
    if (_perluDiulang.isEmpty) return;
    _mulaiAntrean(List.of(_perluDiulang)); // salin dulu, baru dikosongkan
    notifyListeners();
  }

  void _susunAntrean() {
    _mulaiAntrean(
      _kartu
          .where((KartuPertanyaan k) => _kategoriTerpilih.contains(k.kategori))
          .toList(),
    );
  }

  void _mulaiAntrean(List<KartuPertanyaan> kartu) {
    _antrean = kartu..shuffle(_acak);
    _posisi = 0;
    _poinTerlihat = false;
    _sudahBisa.clear();
    _perluDiulang.clear();
  }
}

// ============================== VIEW ==============================

class AplikasiLatihanTanyaJawab extends StatefulWidget {
  const AplikasiLatihanTanyaJawab({super.key});

  @override
  State<AplikasiLatihanTanyaJawab> createState() =>
      _AplikasiLatihanTanyaJawabState();
}

class _AplikasiLatihanTanyaJawabState extends State<AplikasiLatihanTanyaJawab> {
  final LatihanTanyaJawabViewModel _viewModel = LatihanTanyaJawabViewModel(
    kartu: semuaKartu,
  );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Latihan Tanya Jawab',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: HalamanLatihan(viewModel: _viewModel),
    );
  }
}

class HalamanLatihan extends StatelessWidget {
  const HalamanLatihan({super.key, required this.viewModel});

  final LatihanTanyaJawabViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan Tanya Jawab'),
        actions: [
          IconButton(
            onPressed: viewModel.kocokUlang,
            tooltip: 'Kocok ulang',
            icon: const Icon(Icons.shuffle),
          ),
        ],
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (BuildContext context, Widget? _) {
            final KartuPertanyaan? kartu = viewModel.kartuSekarang;
            // Di layar lebar, isi dibatasi 640 piksel agar mudah dibaca.
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    PilihanKategori(viewModel: viewModel),
                    const SizedBox(height: 16),
                    if (kartu != null)
                      KartuTampil(viewModel: viewModel, kartu: kartu)
                    else
                      RingkasanLatihan(viewModel: viewModel),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Deretan FilterChip yang bisa digeser ke samping.
class PilihanKategori extends StatelessWidget {
  const PilihanKategori({super.key, required this.viewModel});

  final LatihanTanyaJawabViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final Kategori k in Kategori.values)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(k.label),
                selected: viewModel.kategoriTerpilih.contains(k),
                onSelected: (bool pilih) =>
                    viewModel.ubahKategori(k, dipilih: pilih),
              ),
            ),
        ],
      ),
    );
  }
}

/// Satu kartu: pertanyaan, poin jawaban (setelah dibuka), dan tombol.
class KartuTampil extends StatelessWidget {
  const KartuTampil({super.key, required this.viewModel, required this.kartu});

  final LatihanTanyaJawabViewModel viewModel;
  final KartuPertanyaan kartu;

  @override
  Widget build(BuildContext context) {
    final TextTheme gaya = Theme.of(context).textTheme;
    final ColorScheme warna = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Kartu ${viewModel.posisi + 1} dari ${viewModel.jumlahKartu}',
          style: gaya.labelLarge,
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: viewModel.posisi / viewModel.jumlahKartu,
        ),
        const SizedBox(height: 12),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(kartu.kategori.ikon, color: warna.primary),
                    const SizedBox(width: 8),
                    Text(
                      kartu.kategori.label,
                      style: gaya.labelLarge?.copyWith(color: warna.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(kartu.pertanyaan, style: gaya.titleLarge),
                if (viewModel.poinTerlihat) ...[
                  const Divider(height: 32),
                  Text('Poin jawaban yang baik:', style: gaya.titleSmall),
                  const SizedBox(height: 8),
                  for (final String poin in kartu.poinJawaban)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check, size: 20, color: warna.primary),
                          const SizedBox(width: 8),
                          Expanded(child: Text(poin, style: gaya.bodyMedium)),
                        ],
                      ),
                    ),
                  Text('Baca ulang: ${kartu.rujukan}', style: gaya.bodySmall),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Jawab dulu dengan suara keras, BARU buka poin jawabannya.
        if (!viewModel.poinTerlihat)
          FilledButton.tonalIcon(
            onPressed: viewModel.tampilkanPoin,
            icon: const Icon(Icons.visibility),
            label: const Text('Lihat poin jawaban'),
          )
        else
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => viewModel.tandai(bisa: false),
                  icon: const Icon(Icons.replay),
                  label: const Text('Perlu diulang'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => viewModel.tandai(bisa: true),
                  icon: const Icon(Icons.check),
                  label: const Text('Sudah bisa'),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

/// Hasil akhir latihan dan kartu yang perlu diulang.
class RingkasanLatihan extends StatelessWidget {
  const RingkasanLatihan({super.key, required this.viewModel});

  final LatihanTanyaJawabViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final TextTheme gaya = Theme.of(context).textTheme;
    final List<KartuPertanyaan> ulang = viewModel.perluDiulang;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Latihan selesai',
          style: gaya.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          'Sudah bisa ${viewModel.sudahBisa.length} dari '
          '${viewModel.jumlahKartu} kartu',
          style: gaya.titleMedium,
          textAlign: TextAlign.center,
        ),
        if (ulang.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('Perlu diulang:', style: gaya.titleSmall),
          for (final KartuPertanyaan k in ulang)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(k.kategori.ikon),
              title: Text(k.pertanyaan),
              subtitle: Text('Baca ulang: ${k.rujukan}'),
            ),
          FilledButton.icon(
            onPressed: viewModel.ulangiYangPerluDiulang,
            icon: const Icon(Icons.replay),
            label: Text('Ulangi ${ulang.length} kartu ini'),
          ),
        ],
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: viewModel.kocokUlang,
          icon: const Icon(Icons.shuffle),
          label: const Text('Kocok ulang semua kartu'),
        ),
      ],
    );
  }
}

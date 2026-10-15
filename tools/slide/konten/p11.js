// Konten slide Pertemuan 11 — Penyimpanan Lokal.
// Teks diambil dari modul bacaan (pertemuan_11_penyimpanan_lokal/README.md).
// Tangkapan layar diambil dari folder pertemuan_11_penyimpanan_lokal/gambar/.

module.exports = {
  nomor: '11',
  folder: 'pertemuan_11_penyimpanan_lokal',
  namaBerkas: 'PERTEMUAN_11_Penyimpanan_Lokal',
  topik: 'Penyimpanan Lokal',

  bangun(d) {
    const C = d.C;
    const KODE = { fontFace: 'Consolas' };
    const kode = (teks) => ({ text: teks, options: KODE });

    d.judul({
      judul: 'Penyimpanan Lokal',
      subjudul: 'Pertemuan 11  ·  shared_preferences, objek sebagai JSON, SQLite dengan sqflite, CRUD yang aman dengan whereArgs, migrasi versi, transaksi dan batch, cache agar tetap terbaca saat luring, dan menguji tanpa menyentuh data asli',
      catatan: 'Di Praktikum 5 Pertemuan 10, tugas yang ditambahkan ke "Tugas Kuliahku" hilang begitu aplikasi ditutup atau di-hot restart, dan tanpa internet aplikasinya tidak bisa dipakai. Hari ini kita membuat data tetap ada. Bekal: Future, async/await, exception, dan Stream (P3); ChangeNotifier, provider, MVVM, repository (P9); JSON, layanan, MockClient (P10). Pengetahuan SQL dari Basis Data membantu, tetapi dasarnya diulang di Bagian 5. Semua contoh hari ini dijalankan di proyek latihan (VS Code), bukan di DartPad, karena paket sqflite belum tersedia di DartPad.',
    });

    d.tujuan({
      pengantar: 'Setelah pertemuan ini, Anda mampu:',
      poin: [
        'Membedakan data di memori dan di penyimpanan perangkat, lalu memilih tempat yang tepat',
        'Menyimpan pengaturan dengan SharedPreferencesAsync dan SharedPreferencesWithCache',
        'Menyimpan enum, waktu, daftar teks, dan objek kecil (JSON)',
        'Membuat tabel SQLite dan menjalankan CRUD dengan sqflite secara aman (whereArgs)',
        'Mengubah struktur tabel dengan versi dan migrasi tanpa menghapus data',
        'Menjaga keutuhan data dengan transaksi, dan mempercepatnya dengan batch',
        'Menerapkan cache agar data internet tetap terbaca saat luring',
      ],
      catatan: 'Target akhir hari ini: aplikasi "Cuaca Kampus Luring". Aplikasi cuaca dari Pertemuan 10 kini mengingat kota terakhir dan kota favorit, menyimpan prakiraan di database SQLite, menampilkan data tersimpan seketika, lalu memperbaruinya dari internet. Saat internet mati, data terakhir tetap tampil dengan keterangan waktunya.',
    });

    d.alur({
      judul: 'Peta Materi Hari Ini',
      langkah: [
        { ikon: 'memori', judul: 'A. Memori vs penyimpanan', isi: 'Mengapa data hilang, dan di mana menyimpannya (Bagian 1)' },
        { ikon: 'kunci', judul: 'B. Pengaturan kecil', isi: 'shared_preferences: enum, JSON, debounce (2–4)' },
        { ikon: 'tabel', judul: 'C. SQLite & sqflite', isi: 'CRUD, whereArgs, MVVM, migrasi, transaksi, batch (5–9)' },
        { ikon: 'luring', judul: 'D. Cache & luring', isi: 'Data internet tetap terbaca; studi kasus cuaca (10–11)' },
        { ikon: 'perisai', judul: 'E. Memeriksa & aman', isi: 'DevTools, pengujian, keamanan (12–13)', warna: C.accent4 },
      ],
      catatan: 'Bagian A: mengapa data hilang, dan alat apa untuk data apa? Bagian B: bagaimana menyimpan pengaturan kecil seperti mode gelap atau kota terakhir? Bagian C: bagaimana menyimpan banyak data yang perlu dicari, diurutkan, diubah, dan dijaga keutuhannya? Bagian D: bagaimana aplikasi tetap berguna saat internet mati? Bagian E: bagaimana melihat isi penyimpanan, mengujinya, dan menjaga keamanannya?',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 1', judul: 'Mengapa Data Hilang Saat Aplikasi Ditutup?', ikon: 'memori', catatan: 'Semua variabel Dart tinggal di memori. Memori dikosongkan saat aplikasi ditutup.' });

    d.banding({
      judul: 'Papan Tulis dan Buku Catatan',
      kolom: [
        {
          ikon: 'memori', judul: 'Memori (RAM) = papan tulis', warna: C.accent5, tag: 'Cepat, tetapi dihapus saat kelas selesai',
          poin: [
            'Tempat semua variabel Dart, seperti _jumlah atau _daftar',
            'Kosong lagi saat aplikasi ditutup, di-hot restart, atau "dibunuh" sistem',
          ],
        },
        {
          ikon: 'disket', judul: 'Penyimpanan perangkat = buku catatan', warna: C.accent4, tag: 'Butuh sedikit waktu, tetapi isinya tetap ada', sorot: true,
          poin: [
            'Berkas di HP, atau penyimpanan milik browser',
            'Tetap ada walaupun aplikasi ditutup, HP dimatikan, lalu dinyalakan lagi',
          ],
        },
      ],
      pesan: 'Kapan menyimpan? SEGERA setelah data berubah, lalu baca kembali saat aplikasi dibuka. Jangan menunggu aplikasi ditutup.',
      catatan: 'Di Pertemuan 1 Bagian 6 kita belajar bahwa aplikasi bisa dihentikan sistem tanpa sempat melewati status detached. Data yang menunggu disimpan "nanti saja" bisa hilang begitu saja. Alurnya: aplikasi dibuka → baca dari penyimpanan → data di memori (variabel) → pengguna mengubah data → simpan ke penyimpanan.',
    });

    d.tabel({
      judul: 'Memilih Tempat Penyimpanan',
      kepala: ['Jenis data', 'Contoh', 'Alat', 'Bagian'],
      lebarKolom: [3.4, 3.4, 3.4, 1.2],
      baris: [
        ['Pengaturan kecil berbentuk kunci–nilai', 'Mode gelap, kota terakhir', kode('shared_preferences'), '2–4'],
        ['Data terstruktur yang banyak: dicari, diurutkan, diubah', 'Catatan, daftar tugas, transaksi keuangan', 'SQLite + paket sqflite', '5–9'],
        ['Salinan data dari internet', 'Pengumuman, prakiraan cuaca', 'Cache (salah satu alat di atas)', '10–11'],
        ['Data rahasia', 'Token masuk (login), PIN', kode('flutter_secure_storage'), '13'],
        ['Berkas', 'Foto, PDF hasil unduhan', kode('path_provider + dart:io'), '13'],
      ],
      ukuran: 15,
      tinggiBaris: 0.72,
      catatan: 'Cek cepat: aplikasi kas kelas mencatat ratusan transaksi yang harus bisa dicari per bulan dan tidak boleh hilang. Pakai apa? SQLite (dengan transaksi, Bagian 9), bukan shared_preferences. Mode gelap aplikasi yang sama cukup dengan shared_preferences.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 2', judul: 'shared_preferences: Loker Berlabel', ikon: 'kunci', catatan: 'Paket resmi tim Flutter untuk data kecil berbentuk kunci–nilai.' });

    d.kode({
      judul: 'Memasang shared_preferences',
      kode: [
        '# sekali, di folder proyek',
        'flutter pub add shared_preferences',
        '',
        '# di bagian atas berkas Dart:',
        "import 'package:shared_preferences/shared_preferences.dart';",
        '',
        '# setiap kali menjalankan di Chrome:',
        'flutter run -d chrome --web-port=8080',
      ].join('\n'),
      shell: true,
      ukuran: 13,
      lebarKode: 7.6,
      poin: [
        'Kunci = label loker; nilai = isinya. Sebutkan labelnya untuk mengambil kembali.',
        'Android: DataStore Preferences · iOS: NSUserDefaults · Web: Local Storage · Windows: folder AppData.',
        'Kodenya sama untuk semua platform.',
        'Paket berplugin: setelah memasang, hentikan aplikasi (q), lalu jalankan lagi.',
      ],
      catatan: 'Jika paket dipasang saat aplikasi sedang berjalan, hot reload atau hot restart memunculkan MissingPluginException, karena bagian aslinya belum ikut terpasang. Alasan --web-port=8080 dijelaskan dua slide lagi.',
    });

    d.tabel({
      judul: 'Tiga Cara Memakai shared_preferences',
      kepala: ['Cara', 'Ciri', 'Kapan dipakai'],
      lebarKolom: [3.9, 4.3, 3.4],
      baris: [
        [kode('SharedPreferencesAsync'), 'Setiap baca dan tulis memakai await; selalu membaca nilai terbaru', 'Pilihan paling sederhana (Contoh 01, 03, 08, 09)'],
        [kode('SharedPreferencesWithCache'), 'Dibuat sekali dengan await; setelah itu membaca TANPA await (nilai disalin ke memori)', 'Pengaturan yang harus ada sejak layar pertama, misalnya tema (Contoh 02)'],
        [kode('SharedPreferences (lama)'), 'SharedPreferences.getInstance()', 'Hanya untuk memahami kode lama: akan dihentikan (deprecated)'],
      ],
      ukuran: 15,
      tinggiBaris: 0.95,
      pesan: 'Sejak versi 2.3.0 paket ini menyediakan tiga cara. Cara ketiga masih sering muncul di tutorial lama.',
      catatan: 'Dokumentasi resmi paket shared_preferences menyebut API lama SharedPreferences akan dihentikan di masa depan. Untuk kode baru, pakai SharedPreferencesAsync atau SharedPreferencesWithCache.',
    });

    d.layar({
      judul: 'Contoh 01: Penghitung Tamu yang Tidak Lupa',
      gambar: 'hasil_contoh_01.jpg',
      berkas: 'kode/contoh_01_penghitung_tersimpan.dart',
      kode: [
        "static const String _kunciJumlah = 'jumlah_tamu';",
        'final SharedPreferencesAsync _penyimpanan =',
        '    SharedPreferencesAsync();',
        'Future<void> _muat() async {',
        '  final int? jumlah =',
        '      await _penyimpanan.getInt(_kunciJumlah);',
        '  if (!mounted) return;',
        '  setState(() {',
        '    _jumlah = jumlah ?? 0; // null = belum pernah',
        '    _memuat = false;',
        '  });',
        '}',
        '// setiap kali angkanya berubah:',
        'await _penyimpanan.setInt(_kunciJumlah, _jumlah);',
      ].join('\n'),
      ukuranKode: 11,
      poin: [
        'getInt → null jika kunci itu belum pernah disimpan.',
        'setInt menimpa nilai lama; remove menghapus kunci.',
        'Waktu: toIso8601String() → teks, DateTime.tryParse → kembali.',
      ],
      ukuranPoin: 15,
      catatan: 'Kunci ditulis sekali sebagai konstanta agar tidak salah ketik di tempat lain. Tampilan diubah dulu dengan setState (terasa cepat), baru kemudian disimpan. Membaca penyimpanan butuh waktu (asinkron), jadi halaman menampilkan lingkaran memuat lebih dulu, seperti saat mengambil data dari internet. Cek cepat: aplikasi baru dipasang, await getInt(\'jumlah_tamu\') hasilnya? null, karena belum pernah disimpan. ?? 0 memberi nilai awal agar _jumlah (int, tidak boleh null) tetap punya nilai.',
    });

    d.tabel({
      judul: 'Membuktikan Data Benar-Benar Tersimpan',
      kepala: ['Percobaan', 'Cara', 'Hasil'],
      lebarKolom: [3.2, 4.8, 3.6],
      baris: [
        ['Hot restart', 'Tekan R di terminal', 'Semua variabel dibuat ulang, tetapi angkanya TETAP ADA'],
        ['Jalankan ulang di Chrome', 'Tekan q, lalu flutter run -d chrome --web-port=8080', 'Angkanya tetap ada'],
        ['Jalankan ulang di Android', 'Tutup dari daftar aplikasi terbuka, lalu buka lagi', 'Angkanya tetap ada'],
      ],
      ukuran: 16,
      tinggiBaris: 0.8,
      pesan: 'Mengapa --web-port=8080? Chrome menyimpan data per alamat situs, TERMASUK port. Port acak = "situs lain" = data seolah hilang.',
      catatan: 'localhost:8080 dan localhost:8081 dianggap dua situs berbeda. Tanpa --web-port, flutter run memilih port acak setiap kali dijalankan. Ingin melihat isinya? Chrome DevTools (F12) → tab Application → Local Storage → http://localhost:8080: tampil kunci jumlah_tamu beserta nilainya.',
    });

    d.tabel({
      judul: 'Tipe Data yang Bisa Disimpan',
      kepala: ['Data', 'Menyimpan', 'Membaca'],
      lebarKolom: [3.4, 4.6, 3.6],
      baris: [
        ['bool, int, double, String', kode('setBool / setInt / setDouble / setString'), kode('getBool / getInt / ...')],
        ['List<String>', kode("setStringList(k, ['a', 'b'])"), kode('getStringList(k)')],
        ['DateTime → teks ISO 8601', kode('setString(k, w.toIso8601String())'), kode('DateTime.tryParse(...)')],
        ['Enum → namanya', kode('setString(k, ThemeMode.dark.name)'), kode('asNameMap()[nama]')],
        ['Objek kecil → teks JSON', kode('setString(k, jsonEncode(...))'), kode('jsonDecode(...)')],
      ],
      ukuran: 14,
      tinggiBaris: 0.66,
      pesan: 'Satu tipe untuk satu kunci. Disimpan dengan setString, lalu dibaca dengan getInt → TypeError.',
      catatan: 'Tipe lain (DateTime, enum, objek) harus diubah dulu menjadi salah satu dari lima tipe dasar. Nama kunci ditulis sebagai konstanta agar tidak salah ketik. Contoh kesalahan: setString(\'jumlah_tamu\', \'5\') lalu getInt(\'jumlah_tamu\').',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 3', judul: 'Pengaturan yang Siap Sejak Layar Pertama', ikon: 'gelap', catatan: 'Contoh 05 Pertemuan 7: pilihan mode gelap hilang setiap aplikasi ditutup. Sekarang disimpan, tanpa berkedip.' });

    d.kode({
      judul: 'Masalah "Berkedip" dan SharedPreferencesWithCache',
      berkas: 'kode/contoh_02_pengaturan_tampilan.dart',
      kode: [
        'Future<void> main() async {',
        '  // Wajib jika plugin dipakai SEBELUM runApp.',
        '  WidgetsFlutterBinding.ensureInitialized();',
        '',
        '  // Membaca semua pengaturan ke memori, sekali saja.',
        '  final SharedPreferencesWithCache prefs =',
        '      await SharedPreferencesWithCache.create(',
        '        cacheOptions: const SharedPreferencesWithCacheOptions(',
        '          allowList: RepositoriPengaturanPrefs.semuaKunci,',
        '        ),',
        '      );',
        '',
        '  runApp(/* ... RepositoriPengaturanPrefs(prefs) ... */);',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.6,
      poin: [
        'Dengan Async: layar pertama tampil terang dulu, sesaat kemudian gelap = BERKEDIP.',
        'WithCache: semua nilai dibaca SEBELUM runApp.',
        'Sesudahnya prefs.getString(...) tanpa await (sinkron).',
        'allowList: hanya kunci ini yang boleh dipakai; kunci lain → ArgumentError.',
      ],
      catatan: 'ensureInitialized: plugin (shared_preferences, sqflite) berbicara dengan bagian asli platform. Jalurnya baru siap setelah Flutter "dinyalakan". Biasanya runApp yang menyalakannya; jika plugin dipakai sebelum runApp, nyalakan sendiri dengan baris ini. setString tetap Future: nilai di memori langsung berubah, lalu ditulis ke perangkat. Contoh 02 menyimpan tiga pengaturan: mode tema, warna utama, dan tingkat kontras.',
    });

    d.kode({
      judul: 'Enum Disimpan sebagai Namanya',
      berkas: 'kode/contoh_02_pengaturan_tampilan.dart',
      kode: [
        "// Menyimpan: ThemeMode.dark -> 'dark'",
        'await _prefs.setString(kunciMode, pengaturan.mode.name);',
        '',
        "// Membaca: 'dark' -> ThemeMode.dark",
        'final String? namaMode = _prefs.getString(kunciMode);',
        'final ThemeMode mode =',
        '    ThemeMode.values.asNameMap()[namaMode] ?? ThemeMode.system;',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.8,
      poin: [
        "asNameMap(): {'system': ThemeMode.system, 'light': ..., 'dark': ...}",
        'Kunci belum ada (null) atau nama tidak dikenal → nilai bawaan setelah ??.',
        'Aplikasi tidak pernah crash karena data lama.',
        'Jangan simpan .index: jika urutan enum berubah, angka lama menunjuk pilihan yang salah.',
      ],
      catatan: 'Nama yang tidak dikenal bisa muncul, misalnya nama enum yang sudah dihapus di versi aplikasi yang lebih baru. Nama juga lebih mudah dibaca saat diperiksa di DevTools daripada angka urutan.',
    });

    d.layar({
      judul: 'Contoh 02: Pengaturan Tampilan yang Tersimpan',
      gambar: ['hasil_contoh_02a.jpg', 'hasil_contoh_02b.jpg'],
      lebarMaks: 6.0,
      berkas: 'kode/contoh_02_pengaturan_tampilan.dart',
      kode: [
        '// sinkron: nilainya sudah ada di cache',
        'PengaturanViewModel({required this._repositori})',
        '  : _pengaturan = _repositori.baca();',
        '',
        'Future<void> ubahMode(ThemeMode mode) =>',
        '    _terapkan(_pengaturan.copyWith(mode: mode));',
        '',
        'Future<void> _terapkan(Pengaturan baru) async {',
        '  _pengaturan = baru;',
        '  notifyListeners(); // tampilan berubah dulu,',
        '  await _repositori.simpan(baru); // lalu simpan',
        '}',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'MaterialApp memakai context.watch: seluruh tema langsung berganti.',
        'contrastLevel: 0.0 normal, 0.5 sedang, 1.0 tinggi.',
      ],
      ukuranPoin: 15,
      catatan: 'Kiri: mode terang, warna hijau toska. Kanan: mode gelap, warna indigo, kontras tinggi. Coba: pilih Gelap, Indigo, Tinggi, hentikan aplikasi (q), lalu jalankan lagi dengan port yang sama: aplikasi langsung tampil gelap sejak layar pertama. Cek cepat: mengapa PengaturanViewModel bisa membaca pengaturan di constructor tanpa await, sedangkan Contoh 01 butuh _memuat? Karena WithCache sudah membaca (dan ditunggu) di main sebelum runApp; Contoh 01 memakai Async yang membaca dari platform setiap kali.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 4', judul: 'Menyimpan Objek dan Daftar', ikon: 'data', catatan: 'shared_preferences tidak bisa menyimpan objek, tetapi bisa menyimpan teks. Kita pakai lagi JSON dari Pertemuan 10.' });

    d.kode({
      judul: 'Objek Kecil sebagai Teks JSON',
      berkas: 'kode/contoh_03_draf_dan_riwayat.dart',
      kode: [
        'Future<void> simpanDraf(DrafIzin draf) async {',
        '  final String teks = jsonEncode(draf.keJson());',
        '  await _prefs.setString(_kunciDraf, teks);',
        '}',
        '',
        'Future<DrafIzin?> bacaDraf() async {',
        '  final String? teks = await _prefs.getString(_kunciDraf);',
        '  if (teks == null) return null; // belum ada draf',
        '  try {',
        '    return switch (jsonDecode(teks)) {',
        '      final Map<String, dynamic> json => DrafIzin.dariJson(json),',
        '      _ => null,',
        '    };',
        '  } on FormatException {',
        '    await _prefs.remove(_kunciDraf); // rusak: buang saja',
        '    return null;',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.8,
      poin: [
        'Objek → keJson() → jsonEncode → setString.',
        'getString → jsonDecode → dariJson → objek.',
        'Data tersimpan bisa rusak, atau berasal dari versi lama yang bentuknya berbeda.',
        'Aplikasi yang baik tidak crash: draf rusak dibuang, formulir mulai kosong.',
      ],
      catatan: 'Contoh 03 adalah formulir surat izin kuliah yang drafnya tersimpan sendiri. Isi formulir (mata kuliah, jenis izin, alasan) adalah satu objek DrafIzin. Teks yang tersimpan misalnya {"mata_kuliah":"Basis Data","jenis":"sakit","alasan":"Demam"}. Kode di slide sedikit dirapatkan (return di baris yang sama).',
    });

    d.layar({
      judul: 'Contoh 03: Draf Otomatis dan Riwayat',
      gambar: 'hasil_contoh_03.jpg',
      berkas: 'kode/contoh_03_draf_dan_riwayat.dart',
      kode: [
        '// debounce: simpan 600 ms setelah BERHENTI mengetik',
        'void _jadwalkanSimpan() {',
        '  _penunda?.cancel(); // batalkan jadwal sebelumnya',
        '  _penunda = Timer(',
        '      const Duration(milliseconds: 600), _simpanSekarang);',
        '}',
        '// riwayat: terbaru di depan, paling banyak 5',
        'final List<String> lama =',
        '    await _prefs.getStringList(_kunciRiwayat) ?? [];',
        'final List<String> baru =',
        '    [entri, ...lama].take(batasRiwayat).toList();',
        'await _prefs.setStringList(_kunciRiwayat, baru);',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Menyimpan setiap huruf itu boros: debounce dari Pertemuan 10.',
        'Halaman ditutup sebelum 600 ms? Ketikan terakhir disimpan di dispose().',
        'Coba: isi sebagian formulir, hot restart → "Draf terakhir dipulihkan."',
      ],
      ukuranPoin: 15,
      catatan: 'Cek cepat: mengapa riwayat disimpan sebagai List<String>, sedangkan draf sebagai satu String JSON? Setiap entri riwayat cukup satu teks. Draf terdiri dari beberapa bagian yang harus tetap berpasangan, sehingga lebih mudah disimpan sebagai satu teks JSON lalu dibaca kembali menjadi satu objek.',
    });

    d.tabel({
      judul: 'Batas Kemampuan shared_preferences',
      kepala: ['Kebutuhan', 'Cocok?', 'Sebaiknya'],
      lebarKolom: [6.0, 1.4, 4.2],
      baris: [
        ['Mode gelap, bahasa, kota terakhir', 'Ya', '—'],
        ['Draf formulir, riwayat pencarian singkat', 'Ya', '—'],
        ['Salinan kecil data internet (cache)', 'Ya', 'Bagian 10'],
        ['Ratusan catatan yang perlu dicari dan diurutkan', 'Tidak', 'SQLite (Bagian 5)'],
        ['Transaksi keuangan, nilai: TIDAK BOLEH hilang', 'Tidak', 'SQLite + transaksi, cadangan di server'],
        ['Password dan token masuk', 'Tidak', 'flutter_secure_storage (Bagian 13)'],
      ],
      ukuran: 15,
      tinggiBaris: 0.6,
      pesan: 'Dokumentasi resminya: tidak ada jaminan data benar-benar tertulis saat perintah simpan selesai → jangan dipakai untuk data penting.',
      catatan: 'shared_preferences cocok untuk data kecil dan tidak penting. Untuk data yang banyak, terstruktur, atau penting, kita pindah ke SQLite.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 5', judul: 'Mengenal SQLite dan Memasang sqflite', ikon: 'tabel', catatan: 'Database lengkap dalam satu berkas di perangkat, tanpa server.' });

    d.tabel({
      judul: 'SQLite: Lemari Arsip dalam Satu Berkas',
      kepala: ['Lemari arsip', 'SQLite'],
      lebarKolom: [5.6, 6.0],
      baris: [
        ['Lemarinya', 'Berkas database, misalnya catatan_kuliah.db'],
        ['Satu laci untuk satu jenis arsip', 'Tabel, misalnya catatan atau mahasiswa'],
        ['Isian yang sama di setiap kartu (nama, NIM, IPK)', 'Kolom'],
        ['Satu kartu arsip', 'Baris (row), yaitu satu data'],
        ['Nomor kartu yang tidak pernah kembar', 'Kunci utama (primary key), biasanya kolom id'],
      ],
      ukuran: 16,
      tinggiBaris: 0.62,
      pesan: 'SQLite bisa mencari (WHERE), mengurutkan (ORDER BY), menghitung (COUNT, SUM), menghubungkan tabel (JOIN), dan menjaga keutuhan (UNIQUE, CHECK, transaksi).',
      catatan: 'Android, iOS, dan browser modern memakai SQLite di balik layar, misalnya untuk menyimpan pesan, kontak, dan riwayat. Dengan paket sqflite, aplikasi Flutter bisa membuat database SQLite sendiri dan mengolahnya dengan SQL, walaupun datanya ribuan.',
    });

    d.tabel({
      judul: 'Tipe Data SQLite dan Padanannya di Dart',
      kepala: ['SQLite', 'Dart', 'Catatan'],
      lebarKolom: [3.0, 3.6, 5.0],
      baris: [
        [kode('INTEGER'), kode('int'), 'Bilangan bulat, termasuk uang dalam rupiah'],
        [kode('REAL'), kode('double (dibaca sebagai num)'), 'Pecahan, misalnya IPK dan suhu'],
        [kode('TEXT'), kode('String'), 'Teks'],
        [kode('INTEGER 1 / 0'), kode('bool'), "SQLite tidak punya bool: disematkan ? 1 : 0"],
        [kode('INTEGER milidetik'), kode('DateTime (waktu)'), 'waktu.millisecondsSinceEpoch'],
        [kode("TEXT 'YYYY-MM-DD'"), kode('DateTime (tanggal saja)'), 'Urutan teksnya sama dengan urutan tanggal'],
        [kode('TEXT nama'), kode('Enum'), 'kondisi.name'],
      ],
      ukuran: 14,
      tinggiBaris: 0.6,
      catatan: 'Ada juga BLOB (Uint8List) untuk data biner kecil dan NULL untuk kosong. Ingat dua yang tidak ada di SQLite: bool dan DateTime. Keduanya diubah dulu sebelum disimpan, lalu diubah kembali saat dibaca.',
    });

    d.kode({
      judul: 'SQL Kilat',
      kode: [
        'CREATE TABLE mahasiswa (',
        '  id   INTEGER PRIMARY KEY AUTOINCREMENT,',
        '  nim  TEXT NOT NULL UNIQUE,',
        '  nama TEXT NOT NULL,',
        '  ipk  REAL NOT NULL',
        ');',
        '',
        'INSERT INTO mahasiswa (nim, nama, ipk)',
        "  VALUES ('2609106001', 'Rina Kusuma', 3.75);",
        'SELECT * FROM mahasiswa WHERE ipk >= 3.5 ORDER BY ipk DESC;',
        "UPDATE mahasiswa SET ipk = 3.40 WHERE nim = '2609106002';",
        'DELETE FROM mahasiswa WHERE id = 3;',
        'SELECT COUNT(*) FROM mahasiswa;',
      ].join('\n'),
      shell: true,
      ukuran: 13,
      lebarKode: 7.8,
      poin: [
        'AUTOINCREMENT: nomor otomatis, tidak pernah dipakai ulang.',
        'NOT NULL: wajib diisi. UNIQUE: tidak boleh kembar.',
        'Sudah mengambil Basis Data? Ini sekadar pengingat.',
      ],
      catatan: 'Tabel mahasiswa ini dipakai Contoh 04 (Lab SQL Mini). Di slide berikutnya kita lihat bahwa sqflite menyediakan metode pembantu, sehingga sebagian besar SQL di atas tidak perlu ditulis lengkap.',
    });

    d.kode({
      judul: 'Memasang sqflite (Android dan Chrome)',
      kode: [
        '// flutter pub add sqflite sqflite_common_ffi_web',
        '// Chrome, sekali: dart run sqflite_common_ffi_web:setup',
        "import 'package:flutter/foundation.dart' show kIsWeb;",
        "import 'package:sqflite/sqflite.dart';",
        "import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';",
        '',
        'void main() {',
        '  if (kIsWeb) {',
        '    databaseFactory = databaseFactoryFfiWeb;',
        '  }',
        '  runApp(const AplikasiSaya());',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.4,
      poin: [
        'sqflite: Android, iOS, macOS; data = satu berkas di folder aplikasi.',
        'sqflite_common_ffi_web: SQLite versi WebAssembly untuk Chrome; data di IndexedDB.',
        'setup menyiapkan web/sqlite3.wasm dan web/sqflite_sw.js.',
        'Di Chrome: selalu --web-port=8080.',
        'Belum tersedia di DartPad. Dukungan web masih eksperimental.',
      ],
      catatan: 'kIsWeb bernilai true hanya saat aplikasi berjalan di browser. Di Android, baris itu dilewati dan sqflite memakai SQLite bawaan HP. Semua contoh SQLite hari ini sudah memuat baris tersebut, jadi berkasnya bisa dijalankan di Chrome maupun di Android tanpa diubah. Perintah setup butuh internet dan bisa memakan waktu beberapa menit. Untuk aplikasi web sungguhan, pertimbangkan pilihan lain (Bagian 13) atau simpan datanya di server.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 6', judul: 'SQL Langkah demi Langkah', ikon: 'terminal', catatan: 'Contoh 04 "Lab SQL Mini": 11 langkah SQL pada tabel mahasiswa, di database memori.' });

    d.tabel({
      judul: 'Empat Operasi Utama: CRUD',
      kepala: ['Operasi', 'Kode Dart', 'Hasilnya'],
      lebarKolom: [1.5, 7.2, 2.9],
      baris: [
        ['Create', kode("db.insert('mahasiswa', {'nim': '2609106001', 'nama': 'Rina Kusuma', 'ipk': 3.75})"), 'int: id baris baru'],
        ['Read', kode("db.query('mahasiswa', where: 'ipk >= ?', whereArgs: [3.5], orderBy: 'ipk DESC')"), 'List<Map<String, Object?>>'],
        ['Update', kode("db.update('mahasiswa', {'ipk': 3.40}, where: 'nim = ?', whereArgs: ['2609106002'])"), 'int: JUMLAH baris berubah'],
        ['Delete', kode("db.delete('mahasiswa', where: 'id = ?', whereArgs: [3])"), 'int: JUMLAH baris terhapus'],
      ],
      ukuran: 14,
      tinggiBaris: 0.85,
      pesan: 'Isi baris = Map: kunci = nama kolom, nilai = isinya. Kolom id tidak perlu diisi: AUTOINCREMENT.',
      catatan: 'openDatabase(...) membuka (atau membuat) database dan menghasilkan objek Database; semua perintah lewat objek itu dan semuanya asinkron (await). execute menjalankan SQL apa adanya, cocok untuk CREATE TABLE. Contoh 04 memakai openDatabase(inMemoryDatabasePath): database baru yang kosong, hanya hidup di memori, sehingga hasilnya selalu sama setiap kali dijalankan.',
    });

    d.kode({
      judul: 'Baris Tabel Menjadi Model, dan rawQuery',
      berkas: 'kode/contoh_04_sql_langkah_demi_langkah.dart',
      kode: [
        'factory Mahasiswa.dariBaris(Map<String, Object?> baris) {',
        '  return switch (baris) {',
        '    {',
        "      'id': final int id,",
        "      'nim': final String nim,",
        "      'nama': final String nama,",
        "      'ipk': final num ipk, // REAL dibaca sebagai num",
        '    } =>',
        '      Mahasiswa(id: id, nim: nim, nama: nama, ipk: ipk.toDouble()),',
        "    _ => throw FormatException('Baris tidak sesuai: $baris'),",
        '  };',
        '}',
        '',
        'final int? jumlah = Sqflite.firstIntValue(',
        "  await db.rawQuery('SELECT COUNT(*) FROM mahasiswa'),",
        ');',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.8,
      poin: [
        'Pola map, sama seperti fromJson di Pertemuan 10.',
        'rawQuery: SQL bebas, misalnya COUNT, AVG, SUM, JOIN.',
        'Sqflite.firstIntValue: angka pertama di baris pertama.',
        'Pasangan tulisnya: rawInsert, rawUpdate, rawDelete.',
      ],
      catatan: 'Hasil query berupa daftar Map, misalnya {id: 1, nim: 2609106001, nama: Rina Kusuma, ipk: 3.75}. Model dibuat sekali di satu tempat, lalu seluruh aplikasi memakai objek Mahasiswa.',
    });

    d.layar({
      judul: 'Contoh 04: Database Pun Bisa Menolak',
      gambar: 'hasil_contoh_04.jpg',
      berkas: 'kode/contoh_04_sql_langkah_demi_langkah.dart',
      kode: [
        'try {',
        "  await db.insert('mahasiswa', {",
        "    'nim': '2609106001', // sudah dipakai Rina",
        "    'nama': 'Rina Palsu',",
        "    'ipk': 4.0,",
        '  });',
        '} on DatabaseException catch (galat) {',
        '  if (galat.isUniqueConstraintError()) {',
        '    // Langkah 9: ditolak (UNIQUE)',
        '  } else {',
        '    rethrow;',
        '  }',
        '}',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'NIM kembar ditolak SQLite → DatabaseException.',
        'NOT NULL, UNIQUE, CHECK = pagar terakhir, walaupun kode Dart ber-bug.',
      ],
      ukuranPoin: 15,
      catatan: 'Di layar, tombol Jalankan menampilkan hasil langkah 1 sampai 11, misalnya INSERT Rina id 1, Bayu id 2, Citra id 3. Hasil yang sama juga dicetak di konsol. Slide berikutnya menampilkan seluruh keluarannya.',
    });

    d.kode({
      judul: 'Hasil Seluruh Langkah',
      kode: [
        'Langkah 1 · CREATE TABLE: tabel mahasiswa dibuat',
        'Langkah 2 · INSERT: Rina -> id 1, Bayu -> id 2, Citra -> id 3',
        'Langkah 3 · SELECT semua (urut nama): Bayu, Citra, Rina',
        'Langkah 4 · SELECT IPK >= 3.50 (tertinggi dulu): Citra, Rina',
        'Langkah 5 · UPDATE IPK Bayu -> 1 baris berubah',
        'Langkah 6 · UPDATE NIM 2609109999 -> 0 baris berubah',
        'Langkah 7 · COUNT -> 3 mahasiswa, rata-rata IPK 3.69',
        'Langkah 8 · DELETE id 3 -> 1 baris terhapus',
        'Langkah 9 · INSERT NIM kembar -> ditolak (UNIQUE)',
        'Langkah 10 · INSERT Dewi -> id 4 (id 3 tidak dipakai lagi)',
        'Langkah 11 · SELECT semua (urut id):',
        '   1 · Rina Kusuma · 2609106001 · IPK 3.75',
        '   2 · Bayu Saputra · 2609106002 · IPK 3.40',
        '   4 · Dewi Anggraini · 2609106004 · IPK 3.58',
      ].join('\n'),
      shell: true,
      ukuran: 12,
      lebarKode: 7.8,
      poin: [
        'Langkah 6: tidak gagal. UPDATE yang tidak menemukan baris hanya menghasilkan 0.',
        'Langkah 7: rata-rata dihitung SETELAH IPK Bayu menjadi 3.40: (3.75 + 3.40 + 3.92) ÷ 3 = 3.69.',
        'Langkah 10: id yang sudah dihapus tidak dipakai ulang.',
      ],
      catatan: 'Langkah 3 dan 4 di slide diringkas menjadi nama saja; keluaran aslinya menampilkan satu baris lengkap per mahasiswa (id, nama, NIM, IPK). Mengapa id lama tidak dipakai ulang? Agar id yang masih tercatat di tempat lain tidak tertukar dengan data baru. Cek cepat: db.delete dengan id 99 yang tidak ada → tidak ada exception, hasilnya 0.',
    });

    d.banding({
      judul: 'Mengapa Harus whereArgs?',
      ukuranContoh: 13,
      kolom: [
        {
          ikon: 'galat', judul: 'Ditempel ke teks SQL', warna: C.accent5, tag: 'Rawan error dan SQL injection',
          poin: [
            "nama = Jum'at → error: tanda kutip memotong SQL",
            "nama = ' OR '1'='1 → SEMUA data tampil (SQL injection)",
          ],
          contoh: "// JANGAN\ndb.rawQuery(\n  \"SELECT * FROM mahasiswa\n   WHERE nama = '$nama'\");",
        },
        {
          ikon: 'perisai', judul: 'Dikirim lewat whereArgs', warna: C.accent4, tag: 'Nilai tetap data, apa pun isinya', sorot: true,
          poin: [
            'Nilai dikirim TERPISAH dari perintah SQL',
            'Untuk setiap nilai dari pengguna, internet, atau dari mana pun di luar kode',
          ],
          contoh: "db.query('mahasiswa',\n  where: 'nama = ?',\n  whereArgs: [nama]);",
        },
      ],
      pesan: 'Hanya nama tabel dan nama kolom yang boleh ditulis langsung di teks SQL, karena keduanya Anda tentukan sendiri.',
      catatan: "Dengan isian ' OR '1'='1, SQL yang terbentuk menjadi ... WHERE nama = '' OR '1'='1', dan syarat '1'='1' selalu benar. Untuk rawQuery, nilainya dikirim sebagai argumen kedua: db.rawQuery('SELECT * FROM mahasiswa WHERE nama = ?', [nama]).",
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 7', judul: 'CRUD dengan MVVM: Catatan Kuliah', ikon: 'catatan', catatan: 'Contoh 05: aplikasi catatan yang datanya tersimpan di berkas catatan_kuliah.db.' });

    d.lapisan({
      judul: 'Siapa Mengerjakan Apa?',
      lapisan: [
        { ikon: 'hp', judul: 'View', isi: 'Daftar, kotak pencarian, geser untuk menghapus, formulir' },
        { ikon: 'restoran', judul: 'CatatanViewModel', isi: 'Status memuat, kata kunci, perintah tulis. Tidak tahu SQL', warna: C.accent6 },
        { ikon: 'gudang', judul: 'RepositoriCatatanSqlite', isi: 'SQL ⇄ Model: insert, query, update, delete', warna: C.accent4 },
        { ikon: 'kurir', judul: 'LayananBasisData', isi: 'Membuka database SEKALI, membuat tabel, menutupnya', warna: C.accent5 },
        { ikon: 'simpan', judul: 'catatan_kuliah.db', isi: 'Berkas database di folder milik aplikasi', warna: C.text2 },
      ],
      keterangan: [
        'Susunannya sama dengan Pertemuan 9 dan 10.',
        'Yang berbeda hanya sumber datanya: database, bukan internet.',
        'Database = sumber kebenaran (source of truth).',
      ],
      catatan: 'Analogi restoran berlanjut: ViewModel = pelayan, repository = bagian pembelian bahan, layanan = kurir. Kali ini kurirnya tidak ke pasar (server), melainkan ke gudang di belakang (berkas database di perangkat).',
    });

    d.kode({
      judul: 'Layanan: Membuka Database Sekali Saja',
      berkas: 'kode/contoh_05_catatan_kuliah_crud.dart',
      kode: [
        'class LayananBasisData {',
        "  LayananBasisData({this.namaBerkas = 'catatan_kuliah.db'});",
        '  final String namaBerkas;',
        '  Future<Database>? _database;',
        '',
        '  Future<Database> get database => _database ??= _buka();',
        '',
        '  Future<Database> _buka() {',
        '    return openDatabase(',
        '      namaBerkas,',
        '      version: 1,',
        '      // hanya SEKALI: saat berkas database belum ada',
        '      onCreate: (Database db, int versi) async {',
        "        await db.execute('''",
        '          CREATE TABLE catatan (',
        '            id     INTEGER PRIMARY KEY AUTOINCREMENT,',
        '            judul  TEXT NOT NULL, isi TEXT NOT NULL,',
        "            diubah INTEGER NOT NULL)''');",
        '      },',
        '    );',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.4,
      poin: [
        'Cukup nama berkas: sqflite menyimpannya di folder database milik aplikasi.',
        '??= : openDatabase hanya dipanggil SEKALI, walaupun getter dipanggil berkali-kali.',
        'version: nomor versi STRUKTUR database (Bagian 8).',
        'Dititipkan dengan Provider + dispose: database ditutup saat aplikasi selesai.',
      ],
      catatan: 'Kode di slide sedikit dirapatkan (kolom judul dan isi ditulis satu baris). Banyak tutorial menulis join(await getDatabasesPath(), \'nama.db\') dengan paket path; hasilnya sama. Penitipan dengan Provider beserta dispose sama seperti http.Client di Pertemuan 10.',
    });

    d.kode({
      judul: 'Repository: SQL ⇄ Model',
      berkas: 'kode/contoh_05_catatan_kuliah_crud.dart',
      kode: [
        "Future<List<Catatan>> ambilSemua({String kataKunci = ''}) async {",
        '  final Database db = await _layanan.database;',
        '  final String kunci = kataKunci.trim();',
        '  final List<Map<String, Object?>> baris = await db.query(',
        "    'catatan',",
        "    where: kunci.isEmpty ? null : 'judul LIKE ? OR isi LIKE ?',",
        "    whereArgs: kunci.isEmpty ? null : ['%$kunci%', '%$kunci%'],",
        "    orderBy: 'diubah DESC, id DESC', // terbaru di atas",
        '  );',
        '  return baris.map(Catatan.dariBaris).toList();',
        '}',
        '',
        'Map<String, Object?> keBaris() => {',
        "  'id': ?id, // id null: diisi SQLite",
        "  'judul': judul,",
        "  'isi': isi,",
        "  'diubah': diubah.millisecondsSinceEpoch, // DateTime -> int",
        '};',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.8,
      poin: [
        "LIKE '%kata%' = mengandung kata itu; huruf besar dan kecil dianggap sama.",
        'id DESC: dua catatan bisa saja disimpan pada milidetik yang sama.',
        'id bertipe int?: null = belum pernah disimpan. Setelah insert: copyWith(id: id).',
      ],
      catatan: 'Nilai kata kunci tetap dikirim lewat whereArgs, bukan ditempel ke SQL. Tanpa urutan kedua (id DESC), posisi dua catatan bertanggal sama bisa berganti-ganti. Di berkas aslinya, keBaris ditulis dengan return di dalam blok; di slide dipersingkat dengan =>.',
    });

    d.layar({
      judul: 'ViewModel: Tulis, lalu Baca Ulang',
      gambar: ['hasil_contoh_05a.jpg', 'hasil_contoh_05b.jpg'],
      lebarMaks: 5.0,
      berkas: 'kode/contoh_05_catatan_kuliah_crud.dart',
      kode: [
        'Future<bool> _tulis(Future<void> Function() perintah) async {',
        '  bool berhasil = true;',
        '  try {',
        '    await perintah();',
        '  } catch (galat) {',
        '    berhasil = false;',
        '  }',
        '  await muat(); // SELALU baca ulang dari database',
        '  return berhasil;',
        '}',
        'Future<bool> hapus(Catatan catatan) {',
        '  // Dismissible: barisnya harus LANGSUNG hilang',
        '  _daftar = _daftar.where((c) => c.id != catatan.id).toList();',
        '  notifyListeners();',
        '  return _tulis(() => _repositori.hapus(catatan.id!));',
        '}',
      ].join('\n'),
      ukuranKode: 11,
      poin: [
        'Database = sumber kebenaran: cukup baca ulang hasil akhirnya.',
        'Urungkan → pulihkan: disimpan lagi lengkap dengan id lamanya.',
      ],
      ukuranPoin: 14,
      catatan: 'Kiri: daftar catatan dengan kotak pencarian. Kanan: halaman Ubah Catatan. Di berkas aslinya, catch juga mencetak galat dengan debugPrint, dan tipe parameter where ditulis lengkap (Catatan c). Membaca ulang beberapa ratus baris dari database di perangkat hanya butuh beberapa milidetik. Cek cepat: mengapa CatatanViewModel dititipkan di atas MaterialApp? Halaman formulir dibuka dengan Navigator.push, sehingga menjadi rute baru yang bersaudara dengan home. Provider di home tidak terlihat dari rute itu (P9 Bagian 11).',
    });

    d.kode({
      judul: 'Menguji dengan Database di Memori',
      berkas: 'kode/contoh_05_catatan_kuliah_crud.dart',
      kode: [
        'final LayananBasisData layanan = LayananBasisData(',
        '  namaBerkas: inMemoryDatabasePath, // database sementara',
        ');',
        'final RepositoriCatatan repo =',
        '    RepositoriCatatanSqlite(layanan: layanan);',
        '',
        '// Konsol (sebagian dari 11 baris):',
        '// LULUS  Catatan pertama mendapat id 1',
        '// LULUS  Yang terbaru di atas',
        '// LULUS  Cari tidak membedakan huruf besar',
        '// LULUS  Tanda kutip tidak merusak SQL',
        '// LULUS  Kembali dengan id lamanya',
        '// LULUS  ViewModel: hasil pencarian',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.6,
      poin: [
        'Hanya nama berkasnya yang berbeda: SQL yang diuji sama persis dengan aplikasi.',
        'Catatan asli di catatan_kuliah.db tidak tersentuh.',
        'Setiap uji dimulai dari database kosong.',
        'Pertemuan 14: cara yang sama di folder test/ dengan flutter test.',
      ],
      catatan: 'jalankanUji() dijalankan sebelum runApp, seperti Pertemuan 9 dan 10. Baris lainnya: Catatan kedua mendapat id 2, Ada 2 catatan, Yang diubah naik ke atas, Tersisa 1 setelah dihapus, ViewModel: status berhasil.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 8', judul: 'Mengubah Struktur Tabel: Versi dan Migrasi', ikon: 'naik', catatan: 'Fitur sematkan (pin) di Contoh 06 membutuhkan kolom baru di tabel catatan.' });

    d.tabel({
      judul: 'Kolom Baru, Pengguna Lama: Mengapa Error?',
      pengantar: 'Kolom disematkan hanya ditambahkan di CREATE TABLE → pengguna lama: DatabaseException(no such column: disematkan ...)',
      kepala: ['"Solusi"', 'Mengapa tidak boleh untuk pengguna sungguhan'],
      lebarKolom: [5.0, 6.6],
      baris: [
        ['Menambah kolom di CREATE TABLE saja', 'onCreate hanya berjalan saat berkas BELUM ada; berkas pengguna lama sudah ada'],
        ['Hapus aplikasi lalu pasang ulang', 'Semua catatan pengguna HILANG'],
        ['Hapus berkas database setiap aplikasi dibuka', 'Sama saja: semua data hilang'],
      ],
      ukuran: 16,
      tinggiBaris: 0.8,
      pesan: 'Selama pengembangan, menghapus data sendiri memang jalan pintas. Untuk aplikasi yang sudah dipakai orang: MIGRASI.',
      catatan: 'Pengguna ingin menyematkan catatan penting agar selalu tampil paling atas. Cara menghapus data sendiri selama pengembangan ada di Bagian 12.3 modul.',
    });

    d.kode({
      judul: 'version dan onUpgrade',
      berkas: 'kode/contoh_06_migrasi_skema.dart',
      kode: [
        'return openDatabase(',
        '  namaBerkas,',
        '  version: 2, // naik dari 1: struktur tabel berubah',
        '  // Pengguna BARU: langsung tabel versi terbaru.',
        '  onCreate: (Database db, int versi) async {',
        "    await db.execute('''CREATE TABLE catatan (...,",
        "        disematkan INTEGER NOT NULL DEFAULT 0)''');",
        '  },',
        '  // Pengguna LAMA (berkas versi 1): ditingkatkan.',
        '  onUpgrade: (Database db, int versiLama, int versiBaru) async {',
        '    await tingkatkanSkema(db, versiLama, versiBaru);',
        '  },',
        ');',
        '',
        'Future<void> tingkatkanSkema(',
        '    Database db, int versiLama, int versiBaru) async {',
        '  if (versiLama < 2) {',
        "    await db.execute('ALTER TABLE catatan ADD COLUMN '",
        "        'disematkan INTEGER NOT NULL DEFAULT 0');",
        '  }',
        '  // berikutnya: if (versiLama < 3) { ... }',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.6,
      poin: [
        'DEFAULT 0: semua catatan lama otomatis "tidak disematkan".',
        'Tidak ada satu catatan pun yang hilang.',
        'tingkatkanSkema ditulis terpisah agar bisa diuji.',
        'Konsol: Migrasi database: versi 1 -> 2.',
      ],
      catatan: 'Kode di slide dirapatkan: di berkas aslinya CREATE TABLE ditulis lengkap, onUpgrade juga mencetak pesan migrasi dengan debugPrint, dan ALTER TABLE dibungkus try dengan isDuplicateColumnError. Pengaman itu khusus untuk latihan: jika Contoh 05 (versi 1) sempat dijalankan lagi setelah Contoh 06, versi database turun menjadi 1 padahal kolomnya sudah ada. Di aplikasi sungguhan, versi database hanya pernah naik.',
    });

    d.tabel({
      judul: 'Setiap Kali Membuka, Versi Dibandingkan',
      pengantar: 'sqflite menyimpan nomor versi DI DALAM berkas database, lalu membandingkannya dengan version:',
      kepala: ['Keadaan berkas di perangkat', 'Yang dijalankan sqflite'],
      lebarKolom: [5.6, 6.0],
      baris: [
        ['Belum ada (pengguna baru)', kode('onCreate(db, 2)')],
        ['Versi 1 (pengguna lama)', kode('onUpgrade(db, 1, 2)')],
        ['Sudah versi 2', 'Tidak ada; database langsung dipakai'],
        ['Versi 3 (dibuat aplikasi yang lebih baru)', 'onDowngrade, jika ada. Hindari keadaan ini'],
      ],
      ukuran: 17,
      tinggiBaris: 0.75,
      catatan: 'Mencobanya (modul Bagian 8.4): jalankan Contoh 05 dengan --web-port=8080 dan tambahkan beberapa catatan; hentikan (q); ganti isi lib/main.dart dengan Contoh 06; jalankan dengan port yang sama. Konsol menampilkan "Migrasi database: versi 1 -> 2", semua catatan masih ada, dan kini punya tombol pin. Jalankan sekali lagi: pesan migrasi tidak muncul, karena database sudah versi 2.',
    });

    d.kartu({
      judul: 'Aturan Emas Migrasi',
      kolom: 3,
      item: [
        { ikon: 'naik', judul: 'version hanya naik', isi: 'Setiap kali struktur berubah: tambah tabel, kolom, atau indeks.' },
        { ikon: 'centang', judul: 'onCreate = struktur terbaru', isi: 'Untuk pengguna baru, langsung lengkap.' },
        { ikon: 'nomor', judul: 'Setahap demi setahap', isi: 'if (versiLama < 2), if (versiLama < 3), ... TANPA else: lompat dari versi 1 ke 3 tetap melewati semua langkah.' },
        { ikon: 'gembok', judul: 'Blok yang sudah dirilis tidak diubah', isi: 'Ada yang salah? Perbaiki di versi berikutnya.', warna: C.accent5 },
        { ikon: 'tabel', judul: 'ALTER TABLE terbatas', isi: 'Menambah kolom mudah. Mengubah tipe kolom: buat tabel baru, salin data, hapus yang lama, ganti nama.' },
        { ikon: 'uji', judul: 'Uji migrasinya', isi: 'Buat tabel versi 1 di memori, isi, jalankan tingkatkanSkema(db, 1, 2), periksa datanya.', warna: C.accent4 },
      ],
      catatan: 'jalankanUji() di Contoh 06 melakukan persis aturan keenam: membuat tabel versi 1 di memori, mengisinya, menjalankan tingkatkanSkema(db, 1, 2), lalu memastikan catatan lama masih ada dan kolom barunya bernilai 0. Praktikum 4 dan tugas mandiri Dompet Kuliah memakai pola yang sama.',
    });

    d.layar({
      judul: 'Contoh 06: Catatan yang Bisa Disematkan',
      gambar: 'hasil_contoh_06.jpg',
      berkas: 'kode/contoh_06_migrasi_skema.dart',
      kode: [
        '// Yang disematkan (1) di atas, lalu terbaru.',
        "orderBy: 'disematkan DESC, diubah DESC, id DESC',",
        '',
        '// bool -> INTEGER saat menyimpan',
        "'disematkan': disematkan ? 1 : 0,",
        '// INTEGER -> bool saat membaca',
        'disematkan: disematkan == 1,',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        'Ikon pin terisi = disematkan; bergaris = tidak.',
        'Menyematkan hanya mengubah kolom disematkan; waktu diubah tetap.',
        'Bagian yang berubah dari Contoh 05 ditandai [BARU] di berkasnya.',
      ],
      ukuranPoin: 16,
      catatan: 'Catatan yang disematkan berada paling atas dengan ikon pin terisi. Perintahnya: db.update(_tabel, {\'disematkan\': disematkan ? 1 : 0}, where: \'id = ?\', whereArgs: [id]).',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 9', judul: 'Transaksi dan Batch', ikon: 'dompet', catatan: 'Contoh 07: aplikasi bendahara kelas dengan dua dompet, Kas Kelas (saldo awal Rp500.000) dan Kas Study Tour.' });

    d.kode({
      judul: 'Masalah "Uang Hilang"',
      kode: [
        '# Memindahkan Rp50.000 dari Kas Kelas ke Kas Study Tour:',
        '1. UPDATE dompet SET saldo = saldo - 50000 WHERE id = 1',
        '2. INSERT INTO mutasi ...   (catat uang keluar)',
        '3. UPDATE dompet SET saldo = saldo + 50000 WHERE id = 2',
        '4. INSERT INTO mutasi ...   (catat uang masuk)',
      ].join('\n'),
      shell: true,
      ukuran: 13,
      lebarKode: 7.8,
      poin: [
        'Satu pemindahan = EMPAT perintah SQL.',
        'Aplikasi mati tepat setelah perintah 2 (baterai habis, crash, dihentikan sistem)?',
        'Kas Kelas sudah berkurang, Kas Study Tour tidak pernah bertambah.',
        'Rp50.000 HILANG. Bank tidak pernah mengizinkan ini.',
      ],
      catatan: 'Tanyakan ke kelas sebelum membuka slide berikutnya: bagaimana caranya agar keempat perintah itu berhasil bersama, atau tidak berubah sama sekali?',
    });

    d.kode({
      judul: 'Transaksi: Semua atau Tidak Sama Sekali',
      berkas: 'kode/contoh_07_transaksi_dan_batch.dart',
      kode: [
        'await db.transaction((Transaction txn) async {',
        '  // Di dalam blok ini, pakai txn, JANGAN db.',
        '  await txn.rawUpdate(',
        "    'UPDATE dompet SET saldo = saldo - ? WHERE id = ?',",
        '    [jumlah, dariId],',
        '  );',
        "  await txn.insert('mutasi', {...});",
        '  await txn.rawUpdate(',
        "    'UPDATE dompet SET saldo = saldo + ? WHERE id = ?',",
        '    [jumlah, keId],',
        '  );',
        "  await txn.insert('mutasi', {...});",
        '});',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.4,
      poin: [
        'Semua berhasil → disimpan (commit).',
        'Satu saja melempar exception → SEMUA dibatalkan (rollback).',
        'Biarkan exception keluar dari blok: itu tanda untuk membatalkan, lalu diteruskan ke ViewModel.',
        'Memakai db di dalam blok → aplikasi MACET (deadlock).',
      ],
      catatan: 'Deadlock: perintah lewat db menunggu transaksi selesai, padahal transaksi menunggu perintah itu. onCreate dan onUpgrade tidak perlu dibungkus transaksi lagi, karena sqflite sudah menjalankan keduanya di dalam transaksi. Cek cepat: di dalam blok transaksi seseorang menulis await db.insert(...). Apa yang terjadi? Aplikasi macet; selalu pakai txn.',
    });

    d.layar({
      judul: 'Contoh 07: Percobaan dengan dan tanpa Transaksi',
      gambar: 'hasil_contoh_07.jpg',
      berkas: 'kode/contoh_07_transaksi_dan_batch.dart',
      kode: [
        '// Database dan Transaction sama-sama DatabaseExecutor',
        'if (pakaiTransaksi) {',
        '  await db.transaction((Transaction txn) async {',
        '    await _langkahPindah(txn, ...);',
        '  });',
        '} else {',
        '  await _langkahPindah(db, ...); // langsung tersimpan',
        '}',
        '',
        '// Total uang dihitung oleh SQL:',
        "'SELECT COALESCE(SUM(saldo), 0) FROM dompet'",
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Transaksi, tanpa gangguan: 450 rb + 50 rb = 500 rb (utuh).',
        'Transaksi + gangguan: 500 rb + 0 = 500 rb (dibatalkan semua).',
        'TANPA transaksi + gangguan: 450 rb + 0 = 450 rb (50 rb HILANG).',
        'CHECK (saldo >= 0): database menolak saldo negatif.',
      ],
      ukuranPoin: 15,
      catatan: 'Saat sakelar Simulasikan gangguan menyala, repository sengaja melempar exception tepat setelah perintah 2. Tekan Atur ulang (kanan atas) sebelum setiap percobaan. Saldo kurang ditolak dua lapis: repository membaca saldo dulu lalu melempar SaldoTidakCukup, dan kolom saldo memakai CHECK (saldo >= 0). COALESCE(SUM(saldo), 0): SUM dari tabel kosong bernilai NULL, COALESCE menggantinya dengan 0. Pola SUM yang sama dipakai di tugas mandiri Dompet Kuliah.',
    });

    d.kode({
      judul: 'Batch: Banyak Perintah Sekaligus',
      berkas: 'kode/contoh_07_transaksi_dan_batch.dart',
      kode: [
        'await db.transaction((Transaction txn) async {',
        '  final Batch batch = txn.batch();',
        '  for (final String nama in namaMahasiswa) {',
        "    batch.insert('mutasi', { // BELUM dijalankan",
        "      'dompet_id': idKasKelas,",
        "      'jumlah': iuranPerOrang,",
        "      'keterangan': 'Iuran $nama',",
        "      'waktu': waktu,",
        '    });',
        '  }',
        "  batch.rawUpdate('UPDATE dompet SET saldo = saldo + ? WHERE id = ?', [",
        '    iuranPerOrang * namaMahasiswa.length,',
        '    idKasKelas,',
        '  ]);',
        '  await batch.commit(noResult: true); // kirim sekaligus',
        '});',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.8,
      poin: [
        'batch.insert(...) tanpa await: hanya DICATAT.',
        'commit: semua perintah dikirim dalam satu kali kirim.',
        'noResult: true: hasil tiap perintah tidak perlu dikembalikan → lebih cepat.',
        'Batch di dalam transaksi: ikut aturan semua atau tidak sama sekali.',
      ],
      catatan: 'Tombol Catat iuran 12 mahasiswa menyimpan 12 baris mutasi dan menambah saldo: 13 perintah dikirim sekaligus, bukan satu per satu. Di Contoh 07, onCreate juga memakai batch untuk membuat dua tabel dan dua dompet awal dalam satu kali kirim.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 10', judul: 'Cache: Data Internet yang Tetap Terbaca Saat Luring', ikon: 'luring', catatan: 'Contoh 08 melanjutkan aplikasi Pengumuman Prodi dari Contoh 06 Pertemuan 10.' });

    d.banding({
      judul: 'Cache = Salinan',
      kolom: [
        {
          ikon: 'hapus', judul: 'Cache boleh hilang', warna: C.accent1, tag: 'Data aslinya tetap ada di server',
          poin: [
            'Terhapus? Aplikasi cukup mengambil lagi dari server saat internet tersedia',
            'Karena itu cache yang kecil boleh disimpan dengan shared_preferences',
            'Cache yang banyak atau terstruktur: SQLite',
          ],
        },
        {
          ikon: 'jam', judul: 'Cache bisa basi', warna: C.accent5, tag: 'Tunjukkan waktunya',
          poin: [
            'Selalu beri tahu pengguna KAPAN data itu diambil',
            'Tanpa keterangan waktu, pengumuman yang sudah basi dikira yang terbaru',
            'Perbarui begitu internet tersedia',
          ],
        },
      ],
      pesan: 'Seperti memotret jadwal kuliah di papan pengumuman: tetap bisa dibaca saat tidak ke kampus, walaupun mungkin bukan yang terbaru.',
      catatan: 'Cek cepat: mengapa cache pengumuman boleh disimpan dengan shared_preferences, padahal paket itu tidak boleh dipakai untuk data penting? Karena cache hanya salinan; data aslinya tetap ada di server. Ukurannya pun kecil (sepuluh pengumuman).',
    });

    d.kode({
      judul: 'Strategi "Data Lokal sebagai Cadangan"',
      berkas: 'kode/contoh_08_cache_data_internet.dart',
      kode: [
        'Future<HasilPengumuman> ambilSemua() async {',
        '  try {',
        '    // 1. Coba ambil dari server.',
        '    final List<Pengumuman> daftar = await _ambilDariServer();',
        '    // 2. Berhasil: simpan salinannya untuk nanti.',
        '    final DateTime sekarang = DateTime.now();',
        '    await _cache.simpan(daftar, sekarang);',
        '    return HasilPengumuman(',
        '        daftar: daftar, waktu: sekarang, dariCache: false);',
        '  } catch (galat) {',
        '    // 3. Gagal: pakai salinan tersimpan, jika ada.',
        '    final HasilPengumuman? tersimpan = await _cache.baca();',
        '    if (tersimpan == null) rethrow; // belum pernah tersimpan',
        '    return tersimpan;',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.8,
      poin: [
        'Semua keputusan ada di repository; ViewModel dan View tidak tahu asal datanya.',
        'rethrow: exception yang sama dilempar ulang → pesanRamah (P10) tetap bekerja.',
        'Kelemahan: salinan baru dipakai SETELAH server gagal, jadi pengguna tetap menunggu.',
      ],
      catatan: 'Alur: ambil dari server berhasil → simpan salinan + waktunya → tampilkan data terbaru. Gagal → ada salinan? Ya: tampilkan salinan + spanduk Mode luring. Tidak: tampilkan pesan galat + tombol Coba lagi. Kode di slide dirapatkan (if dan rethrow satu baris).',
    });

    d.layar({
      judul: 'Contoh 08: Pengumuman Saat Luring',
      gambar: 'hasil_contoh_08.jpg',
      berkas: 'kode/contoh_08_cache_data_internet.dart',
      kode: [
        '// Isi dan waktunya dalam SATU teks JSON',
        'final String teks = jsonEncode({',
        "  'waktu': waktu.millisecondsSinceEpoch,",
        "  'daftar': [for (final Pengumuman p in daftar) p.keJson()],",
        '});',
        'return _penyimpanan.tulis(_kunci, teks);',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Satu teks: isi baru tidak mungkin tersimpan bersama waktu yang lama.',
        'Format milik aplikasi (judul, isi, dibaca), bukan format server (title, body, views).',
        'Spanduk Mode luring + waktunya: pengguna tahu datanya salinan.',
        'Diuji tanpa menyentuh data asli: PenyimpananTeksMemori + MockClient yang bisa "dimatikan".',
      ],
      ukuranPoin: 15,
      catatan: 'Jika disimpan dengan dua kunci terpisah, bisa saja isi baru sudah tersimpan tetapi waktunya masih yang lama (aplikasi mati di antara dua perintah simpan). Format sendiri membuat salinan lama tetap terbaca walaupun suatu hari server mengubah bentuk JSON-nya. CachePengumuman memakai kontrak kecil PenyimpananTeks: aplikasi memakai PenyimpananTeksPrefs, pemeriksaan memakai PenyimpananTeksMemori.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 11', judul: 'Studi Kasus: Cuaca Kampus Luring', ikon: 'cuaca', catatan: 'Contoh 09 melanjutkan aplikasi Cuaca Kampus dari Pertemuan 10 Bagian 13.' });

    d.tabel({
      judul: 'Fitur Baru dan Tempat Menyimpannya',
      kepala: ['Fitur', 'Disimpan di', 'Alasan'],
      lebarKolom: [4.8, 3.6, 3.2],
      baris: [
        ['Mengingat kota terakhir yang dipilih', kode('shared_preferences (String)'), 'Satu nilai kecil'],
        ['Kota favorit tampil paling depan, bertanda bintang', kode('shared_preferences (List<String>)'), 'Daftar pendek berisi nama enum'],
        ['Prakiraan terakhir setiap kota tetap terbaca tanpa internet', 'SQLite (cuaca_kampus.db)', 'Data terstruktur: cuaca saat ini + tujuh hari per kota'],
      ],
      ukuran: 15,
      tinggiBaris: 0.95,
      pesan: 'Satu aplikasi bisa memakai keduanya: setiap jenis data disimpan dengan alat yang paling cocok.',
      catatan: 'Susunannya: CuacaViewModel memakai RepositoriCuacaLuring (yang memakai LayananOpenMeteo untuk internet dan CacheCuacaSqlite untuk database) serta RepositoriPreferensiShared (shared_preferences). Kota favorit disimpan sebagai daftar nama enum, misalnya [\'samarinda\', \'medan\']; saat dibaca, nama yang tidak dikenal dibuang dengan whereType<Kota>().',
    });

    d.kode({
      judul: 'Strategi "Lokal Dulu, lalu Server": Stream',
      berkas: 'kode/contoh_09_studi_kasus_cuaca_luring.dart',
      kode: [
        'Stream<HasilCuaca> pantau(Kota kota) async* {',
        '  // 1. Data tersimpan: cepat dan tidak butuh internet.',
        '  final HasilCuaca? tersimpan = await _cache.baca(kota);',
        '  if (tersimpan != null) {',
        '    yield tersimpan;',
        '  }',
        '  // 2. Data terbaru dari server. Jika melempar exception,',
        '  //    Stream mengirim galat itu, lalu selesai.',
        '  final Cuaca cuaca = await _ambilDariServer(kota);',
        '  final DateTime sekarang = DateTime.now();',
        '  await _cache.simpan(cuaca, sekarang);',
        '  yield HasilCuaca(',
        '      cuaca: cuaca, diperbarui: sekarang, dariCache: false);',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.4,
      poin: [
        'Ada salinan + internet → salinan, lalu data server.',
        'Ada salinan, internet mati → salinan, lalu galat.',
        'Belum ada salinan + internet → data server saja.',
        'Belum ada salinan, internet mati → galat saja.',
        'Hasil datang DUA kali → Stream, bukan Future (Pertemuan 3).',
      ],
      catatan: 'Contoh 08 baru memakai salinan setelah server gagal, sehingga pengguna menunggu sampai batas waktu habis. Di sini salinan tampil seketika, lalu diganti data terbaru begitu tiba. Panduan resmi Flutter tentang aplikasi offline-first menyarankan pola yang sama. Di Contoh 09, baca dan simpan juga dibungkus try agar kerusakan cache tidak membuat aplikasi gagal total.',
    });

    d.kode({
      judul: 'Cache SQLite: Dua Tabel dan Kunci Gabungan',
      kode: [
        'CREATE TABLE cuaca_saat_ini (',
        '  kota       TEXT PRIMARY KEY,   -- satu baris per kota',
        '  suhu       REAL NOT NULL,',
        '  ...',
        "  kondisi    TEXT NOT NULL,      -- nama enum, mis. 'hujan'",
        '  diperbarui INTEGER NOT NULL    -- milidetik',
        ');',
        'CREATE TABLE prakiraan_harian (',
        '  kota          TEXT NOT NULL,',
        "  tanggal       TEXT NOT NULL,   -- '2026-10-15'",
        '  ...',
        '  peluang_hujan INTEGER,         -- boleh NULL',
        '  PRIMARY KEY (kota, tanggal)    -- kunci gabungan',
        ');',
      ].join('\n'),
      shell: true,
      ukuran: 12,
      lebarKode: 7.8,
      poin: [
        'Kunci gabungan: pasangan (kota, tanggal) tidak boleh kembar.',
        'Satu kota boleh punya banyak tanggal; satu tanggal boleh dimiliki banyak kota.',
        'Tanggal sebagai teks YYYY-MM-DD; kondisi sebagai nama enum.',
      ],
      catatan: 'Kolom lain di cuaca_saat_ini: kelembapan (INTEGER) dan angin (REAL). Di prakiraan_harian: kondisi, suhu_maks, dan suhu_min. peluang_hujan boleh NULL karena data Open-Meteo kadang tidak menyertakannya; pemeriksaan "SQLite: NULL tetap null" memastikannya.',
    });

    d.kode({
      judul: 'Menyimpan: Transaksi + Upsert + Batch',
      berkas: 'kode/contoh_09_studi_kasus_cuaca_luring.dart',
      kode: [
        'await db.transaction((Transaction txn) async {',
        '  // replace: jika kota ini sudah ada, barisnya DITIMPA',
        "  await txn.insert('cuaca_saat_ini', {",
        "    'kota': kota,",
        "    'suhu': cuaca.saatIni.suhu,",
        '    // ... kolom lain ...',
        '  }, conflictAlgorithm: ConflictAlgorithm.replace);',
        '',
        '  // prakiraan lama kota ini dibuang, diganti yang baru',
        "  await txn.delete('prakiraan_harian',",
        "      where: 'kota = ?', whereArgs: [kota]);",
        '  final Batch batch = txn.batch();',
        '  for (final PrakiraanHarian hari in cuaca.harian) {',
        "    batch.insert('prakiraan_harian', {/* ... */});",
        '  }',
        '  await batch.commit(noResult: true);',
        '});',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.6,
      poin: [
        'ConflictAlgorithm.replace: "masukkan, atau timpa jika sudah ada" = upsert.',
        'Tanpa replace: kota yang sama untuk kedua kalinya ditolak PRIMARY KEY.',
        'Satu transaksi: cuaca saat ini dan prakiraannya selalu cocok.',
      ],
      catatan: 'Kode di slide diringkas. Pemeriksaan "SQLite: hari tidak berganda" memastikan menyimpan kota yang sama dua kali tidak menggandakan baris prakiraan.',
    });

    d.kode({
      judul: 'ViewModel: Mendengarkan Stream dengan await for',
      berkas: 'kode/contoh_09_studi_kasus_cuaca_luring.dart',
      kode: [
        'await for (final HasilCuaca hasil in _repositori.pantau(_kota)) {',
        '  if (_sudahDibuang || nomor != _nomorPermintaan) {',
        '    return; // keluar = berhenti mendengarkan',
        '  }',
        '  final HasilCuaca? tampil = _hasil;',
        '  if (hasil.dariCache && tampil != null && !tampil.dariCache) {',
        '    continue; // yang tampil sudah lebih baru',
        '  }',
        '  _hasil = hasil;',
        '  _status = StatusMuat.berhasil;',
        '  notifyListeners();',
        '}',
        '// catch: masih ada data -> _peringatan;',
        '//        belum ada data -> _pesanGalat + status gagal',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.8,
      poin: [
        'await for: menerima nilai Stream satu per satu, langsung ditampilkan.',
        'return: kota sudah diganti → berhenti mendengarkan (penjaga P10).',
        'continue: saat ditarik untuk menyegarkan, salinan yang datang lebih dulu dilewati.',
        'Gagal tetapi ada data → spanduk peringatan; tanpa data → halaman galat + Coba lagi.',
      ],
      catatan: 'StreamBuilder adalah pasangan FutureBuilder untuk Stream (P3), dan aturannya sama: buat Stream-nya sekali, jangan di dalam build. Untuk aplikasi dengan banyak aturan seperti ini, ViewModel dengan await for lebih mudah diatur dan diuji.',
    });

    d.kode({
      judul: 'Pemeriksaan Sebelum Aplikasi Tampil',
      kode: [
        'LULUS  Belum tersimpan: 1 data (dari server)',
        'LULUS  Sudah tersimpan: salinan dulu, lalu server',
        'LULUS  Server mati: salinan, lalu galat',
        'LULUS  Kota terakhir diingat',
        'LULUS  Luring: tetap berhasil',
        'LULUS  Luring: memakai salinan',
        'LULUS  Luring: ada peringatan',
        'LULUS  Kota baru tanpa salinan: gagal',
        'LULUS  Medan menjadi favorit',
        'LULUS  Favorit di urutan pertama',
        'LULUS  SQLite: hari tidak berganda',
        'LULUS  SQLite: NULL tetap null',
        'LULUS  SQLite: kota lain kosong',
      ].join('\n'),
      shell: true,
      ukuran: 12,
      lebarKode: 7.2,
      poin: [
        'Tanpa internet: repository + cache memori, ViewModel + preferensi memori, cache SQLite + inMemoryDatabasePath.',
        'Pesan "Galat saat memuat cuaca: ClientException: ..." di antaranya memang disengaja.',
      ],
      catatan: 'Slide ini menampilkan 13 dari 17 baris LULUS. Baris lainnya: Data server bukan salinan, Data server ikut disimpan, Pilihan kota disimpan, SQLite: kondisi terbaca lagi. Sebagian pemeriksaan sengaja mematikan "server", sehingga pesan galat itu muncul di konsol.',
    });

    d.layar({
      judul: 'Cuaca Kampus Luring Berjalan',
      gambar: ['hasil_contoh_09a.jpg', 'hasil_contoh_09b.jpg'],
      lebarMaks: 6.4,
      berkas: 'kode/contoh_09_studi_kasus_cuaca_luring.dart',
      poin: [
        'Bintang di kanan atas: chip Samarinda pindah ke depan.',
        'Ganti kota lalu kembali: data muncul SEKETIKA (SQLite), disusul garis progres tipis.',
        'q, matikan internet, jalankan lagi: kota terakhir + data tersimpan + spanduk "Gagal memperbarui".',
        'Kota yang belum pernah dibuka: halaman galat + Coba lagi.',
      ],
      ukuranPoin: 15,
      catatan: 'Kiri: Samarinda bertanda bintang di depan, kartu cuaca, dan prakiraan tujuh hari. Kanan: luring, spanduk Gagal memperbarui (Tidak dapat terhubung ke internet) di atas data tersimpan. Tanpa mematikan internet, ganti \'api.open-meteo.com\' menjadi \'api.open-meteo.invalid\' di LayananOpenMeteo. Daftar uji mandiri lengkap di modul Bagian 11.8.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 12–13', judul: 'Memeriksa, Menguji, dan Menjaga Keamanan', ikon: 'perisai', catatan: 'Melihat isi penyimpanan, menghapusnya selama pengembangan, mengujinya, dan memilih tempat untuk data rahasia.' });

    d.tabel({
      judul: 'Melihat dan Menghapus Data Tersimpan',
      kepala: ['Tempat', 'Isinya / gunanya'],
      lebarKolom: [6.0, 5.6],
      baris: [
        ['Chrome: F12 → Application → Local storage → localhost:8080', 'Data shared_preferences; nilainya teks JSON ("dark" dengan kutip)'],
        ['Chrome: Application → IndexedDB', 'Tempat sqflite versi web menyimpan databasenya'],
        ['Chrome: Application → Storage → Clear site data', 'Menghapus SEMUA data situs itu'],
        ['Android Studio → App Inspection → Database Inspector', 'Melihat isi tabel SQLite, bahkan menjalankan query'],
        ['Android: Setelan → Aplikasi → Penyimpanan → Hapus data', 'Menghapus semua data aplikasi'],
      ],
      ukuran: 15,
      tinggiBaris: 0.68,
      pesan: 'Jangan biarkan deleteDatabase atau clear() terbawa ke aplikasi yang dibagikan, kecuali untuk tombol "Hapus semua data" yang disertai konfirmasi.',
      catatan: 'Saat CREATE TABLE diubah di tengah pengembangan dan belum ingin menulis migrasi, menghapus data lama adalah jalan pintas yang wajar, asalkan itu data Anda sendiri: Clear site data di Chrome, Hapus data di Android, atau await deleteDatabase(\'catatan_kuliah.db\') sebelum database dibuka. Menguji tanpa menyentuh data asli: repository/penyimpanan versi memori (Contoh 08, 09) atau database SQLite sungguhan di memori dengan inMemoryDatabasePath (Contoh 05, 06, 07, 09).',
    });

    d.banding({
      judul: 'Keamanan Data',
      kolom: [
        {
          ikon: 'gembok', judul: 'Data rahasia', warna: C.accent5, tag: 'Bukan shared_preferences, bukan SQLite biasa',
          poin: [
            'Keduanya TIDAK dienkripsi: di Chrome terbaca lewat DevTools',
            'Token masuk → flutter_secure_storage (Keychain di iOS, terenkripsi di Android)',
            'Password: jangan disimpan sama sekali; simpan token dari server',
          ],
        },
        {
          ikon: 'orang', judul: 'Data pribadi pengguna', warna: C.accent6, tag: 'Seperlunya saja',
          poin: [
            'Simpan hanya yang benar-benar dibutuhkan aplikasi',
            'Saat keluar (logout), hapus data milik pengguna itu',
            'Jelaskan di halaman privasi data apa saja yang disimpan',
          ],
        },
      ],
      pesan: 'Di Android pun, data shared_preferences dan SQLite tetap berupa berkas biasa, dan secara bawaan ikut dicadangkan otomatis oleh sistem.',
      catatan: 'Di Android, data memang tersimpan di folder khusus milik aplikasi, tetapi tetap berupa berkas biasa dan secara bawaan ikut dicadangkan otomatis oleh sistem. Di Chrome, kode JavaScript lain di situs yang sama pun bisa membacanya. Dukungan web flutter_secure_storage masih eksperimental. Untuk proyek akhir yang dipakai orang lain, halaman privasi sangat disarankan.',
    });

    d.tabel({
      judul: 'Pilihan Penyimpanan Lain',
      kepala: ['Pilihan', 'Jenisnya', 'Kapan dipertimbangkan'],
      lebarKolom: [2.8, 5.0, 3.8],
      baris: [
        [kode('drift'), 'SQLite dengan kode Dart yang dibuat otomatis; salah nama kolom ketahuan sebelum dijalankan. Mendukung web', 'Aplikasi besar dengan banyak tabel dan query (mirip peran Room di Android native)'],
        [kode('hive_ce'), 'Database kunci–nilai (NoSQL) murni Dart, mendukung web', 'Menyimpan objek tanpa SQL. Paket hive asli: versi stabil terakhir 2022'],
        [kode('path_provider + dart:io'), 'Berkas', 'Foto atau PDF. Tidak berlaku di web'],
        ['Firebase, Supabase', 'Database di server', 'Data harus sama di beberapa perangkat atau dibagikan'],
      ],
      ukuran: 14,
      tinggiBaris: 0.78,
      pesan: 'shared_preferences dan sqflite sudah cukup untuk sebagian besar aplikasi, termasuk proyek akhir.',
      catatan: 'hive_ce adalah lanjutan komunitas dari paket hive yang masih dirawat. Kenali pilihan-pilihan ini, tetapi tidak perlu dipakai di kuliah ini.',
    });

    d.tabel({
      judul: 'Kesalahan Umum Pemula',
      kepala: ['Gejala', 'Solusi'],
      lebarKolom: [6.4, 5.2],
      baris: [
        ['Data hilang setiap kali flutter run -d chrome', '--web-port=8080'],
        [kode('MissingPluginException'), 'Hentikan aplikasi (q), jalankan lagi'],
        [kode('Binding has not yet been initialized'), 'ensureInitialized() di baris pertama main'],
        [kode('Bad state: databaseFactory not initialized'), 'databaseFactory = databaseFactoryFfiWeb di main'],
        [kode('no such table / no such column'), 'Naikkan version, tulis onUpgrade'],
        ['Aplikasi macet saat menyimpan', 'Pakai txn di dalam transaksi'],
        ["Error saat teks berisi tanda kutip (Jum'at)", 'Selalu ? dan whereArgs'],
        [kode('A dismissed Dismissible widget is still part of the tree'), 'Buang dari daftar dulu, baru hapus dari database'],
      ],
      ukuran: 13,
      tinggiBaris: 0.56,
      catatan: 'Tabel lengkap di modul Bagian 14 dan di Panduan Troubleshooting bagian F, termasuk TypeError karena satu kunci dibaca dengan tipe berbeda, ArgumentError allowList, galat sqlite3.wasm atau sqflite_sw.js (setup web belum dijalankan), duplicate column name, UNIQUE constraint failed, update yang tidak mengubah apa pun, bool/DateTime di SQLite, dan tema yang berkedip.',
    });

    d.tabel({
      judul: 'Memilih Alat yang Tepat',
      kepala: ['Kebutuhan', 'Pakai'],
      lebarKolom: [6.4, 5.2],
      baris: [
        ['Satu atau beberapa nilai kecil, dibaca dengan await', kode('SharedPreferencesAsync')],
        ['Pengaturan yang harus siap sejak layar pertama', 'SharedPreferencesWithCache di main'],
        ['Banyak data: dicari, diurutkan, diubah, dihitung', 'SQLite (sqflite) + layanan + repository'],
        ['Beberapa perintah tulis yang harus berhasil bersama', kode('db.transaction(...)')],
        ['Puluhan atau ratusan baris sekaligus', 'batch (sebaiknya di dalam transaksi)'],
        ['Data internet yang tetap terbaca saat luring', 'Cache: "cadangan" atau "lokal dulu, lalu server"'],
        ['Token dan data rahasia', kode('flutter_secure_storage')],
      ],
      ukuran: 15,
      tinggiBaris: 0.62,
      catatan: 'Minta mahasiswa memetakan proyek akhir: data apa yang menjadi pengaturan (shared_preferences), data apa yang ditambah atau diubah pengguna (SQLite), dan data internet apa yang perlu tetap terbaca saat luring (cache).',
    });

    d.ringkasan({
      poin: [
        'Variabel hidup di memori; simpan ke penyimpanan perangkat SEGERA setelah data berubah.',
        'shared_preferences: kunci–nilai kecil. Async untuk umum, WithCache + allowList untuk pengaturan sejak layar pertama.',
        'Enum sebagai nama (asNameMap), waktu sebagai teks/milidetik, objek sebagai JSON; data rusak ditangani.',
        'SQLite: tabel, baris, kolom, kunci utama. insert → id; update/delete → jumlah baris.',
        'Nilai dari luar kode SELALU lewat ? dan whereArgs.',
        'onCreate sekali; struktur berubah → version naik + onUpgrade bertahap.',
        'Transaksi: semua atau tidak sama sekali (pakai txn). Batch: banyak perintah sekaligus.',
        'Cache = salinan: "cadangan" atau "lokal dulu, lalu server" (Stream); tunjukkan waktunya.',
      ],
      catatan: 'Minta mahasiswa menjelaskan dengan kata-kata sendiri: mengapa onCreate tidak cukup saat struktur tabel berubah, dan apa yang terjadi pada pengguna lama jika version lupa dinaikkan.',
    });

    d.penutup({
      judul: 'Saatnya Praktik!',
      subjudul: 'Kerjakan Jobsheet Pertemuan 11 (lima praktikum + tugas Dompet Kuliah), lalu uji diri di Latihan. Untuk proyek akhir: tentukan data apa yang disimpan di perangkat dan di mana menyimpannya. Pertemuan berikutnya: Clean Architecture.',
      tautan: [
        { teks: 'Jobsheet P11', ikon: 'tugas', url: d.urlBerkas('pertemuan_11_penyimpanan_lokal/JOBSHEET.md') },
        { teks: 'Latihan P11', ikon: 'kuis', url: d.urlBerkas('pertemuan_11_penyimpanan_lokal/LATIHAN.md') },
        { teks: 'Proyek Akhir', ikon: 'roket', url: d.urlBerkas('panduan/05_proyek_akhir.md') },
      ],
      catatan: 'Semua praktikum dijalankan di VS Code, bukan DartPad. Persiapan sekali: flutter pub add shared_preferences provider sqflite sqflite_common_ffi_web, lalu (untuk Chrome) dart run sqflite_common_ffi_web:setup, dan selalu jalankan dengan --web-port=8080. Praktikum 1–2: shared_preferences; Praktikum 3–4: Kamus Istilah dengan SQLite (CRUD, lalu migrasi dan impor); Praktikum 5: "Tugas Kuliahku" tersimpan di perangkat dan tetap berguna tanpa internet. Tugas mandiri Dompet Kuliah: SQLite dengan migrasi versi 2, ringkasan dengan SUM dan GROUP BY, anggaran di shared_preferences, dan jalankanUji minimal 8 pemeriksaan. Pertemuan 12 menata layanan, repository, dan ViewModel menjadi lapisan Clean Architecture.',
    });
  },
};

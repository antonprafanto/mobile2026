// Konten slide Pertemuan 1 — Pengenalan Pemrograman Piranti Bergerak & Flutter.
// Setiap pemanggilan d.xxx({...}) menghasilkan satu slide. Teks diambil dari
// modul bacaan (pertemuan_01_pengenalan_flutter/README.md).

module.exports = {
  nomor: '01',
  folder: 'pertemuan_01_pengenalan_flutter',
  namaBerkas: 'PERTEMUAN_01_Pengenalan_Flutter',
  topik: 'Pengenalan Flutter',

  bangun(d) {
    const C = d.C;

    d.judul({
      judul: 'Pengenalan Pemrograman Piranti Bergerak & Flutter',
      subjudul: 'Pertemuan 1  ·  Dari konsep aplikasi mobile sampai aplikasi Flutter pertama Anda',
      catatan: 'Sambut mahasiswa. Sampaikan bahwa semua materi (modul, kode, jobsheet, latihan, slide) ada di repositori GitHub mata kuliah, dan hari ini targetnya aplikasi Flutter pertama berjalan di Chrome.',
    });

    d.tujuan({
      pengantar: 'Setelah pertemuan ini, Anda mampu:',
      poin: [
        'Menjelaskan ciri khas aplikasi piranti bergerak',
        'Membandingkan pendekatan native, web/hibrida, dan lintas platform',
        'Menjelaskan apa itu Flutter, Dart, dan cara kerja Flutter',
        'Menyebutkan status siklus hidup (lifecycle) aplikasi',
        'Membuat dan menjalankan proyek Flutter pertama',
        'Membedakan hot reload dan hot restart',
      ],
      catatan: 'Bacakan tujuan secara singkat. Tekankan bahwa poin 5 dan 6 akan langsung dipraktikkan di jobsheet.',
    });

    d.alur({
      judul: 'Peta Materi Hari Ini',
      langkah: [
        { ikon: 'hp', judul: 'Konsep mobile', isi: 'Ciri khas HP, Android vs iOS, tiga pendekatan' },
        { ikon: 'widget', judul: 'Flutter & Dart', isi: 'Apa, mengapa, dan bagaimana cara kerjanya' },
        { ikon: 'riwayat', judul: 'Siklus hidup', isi: 'Lima status aplikasi dan kegunaannya' },
        { ikon: 'perkakas', judul: 'Alat kerja', isi: 'Git, VS Code, Flutter SDK, Chrome' },
        { ikon: 'folder', judul: 'Proyek pertama', isi: 'Membuat, menjalankan, membedah kode' },
        { ikon: 'kilat', judul: 'Hot reload', isi: 'Perubahan terlihat dalam hitungan detik' },
      ],
      catatan: 'Bagian 1-3 adalah konsep, bagian 4-6 adalah praktik yang langkah lengkapnya ada di jobsheet.',
    });

    d.bagian({ label: 'BAGIAN 1', judul: 'Mengenal Dunia Aplikasi Mobile', ikon: 'hp' });

    d.kartu({
      judul: 'Mengapa Aplikasi Mobile Itu Berbeda?',
      kolom: 3,
      item: [
        { ikon: 'hp', judul: 'Layar kecil & beragam', isi: 'Tampilan harus ringkas dan menyesuaikan banyak ukuran layar.' },
        { ikon: 'sentuh', judul: 'Dioperasikan dengan jari', isi: 'Tombol harus cukup besar untuk disentuh, bukan diklik mouse.' },
        { ikon: 'baterai', judul: 'Baterai terbatas', isi: 'Aplikasi harus hemat daya, misalnya tidak terus memakai GPS.' },
        { ikon: 'sinyal', judul: 'Koneksi naik-turun', isi: 'Aplikasi tetap "sopan" saat sinyal hilang: beri pesan, simpan data.' },
        { ikon: 'sensor', judul: 'Kaya sensor', isi: 'Kamera, GPS, sidik jari, akselerometer siap dimanfaatkan.' },
        { ikon: 'pindah', judul: 'Sering ditinggal', isi: 'Pengguna bisa pindah aplikasi kapan saja; data harus aman.' },
      ],
      catatan: 'Ajak mahasiswa membandingkan HP mereka dengan PC lab. Tanyakan: aplikasi apa yang paling sering mereka pakai dan apa yang menyebalkan saat sinyal hilang?',
    });

    d.statistik({
      judul: 'Dua Penguasa Pasar di Indonesia',
      item: [
        { ikon: 'hp', angka: '79,16%', label: 'Android (Google, banyak merek HP)', warna: C.accent4 },
        { ikon: 'hp', angka: '20,79%', label: 'iOS (Apple, khusus iPhone)', warna: C.accent6 },
      ],
      pesan: 'Aplikasi untuk pasar Indonesia idealnya hadir di Android DAN iOS sekaligus. Masalahnya: keduanya "berbicara bahasa" yang berbeda.',
      sumber: 'Sumber: StatCounter Global Stats, Mobile Operating System Market Share Indonesia, September 2026.',
      catatan: 'Data StatCounter September 2026. Jelaskan konsekuensinya: bahasa resmi Android adalah Kotlin, iOS adalah Swift. Ini menjadi jembatan ke slide berikutnya.',
    });

    d.banding({
      judul: 'Tiga Cara Membuat Aplikasi Mobile',
      kolom: [
        {
          ikon: 'kode', judul: 'Native', warna: C.text2,
          poin: ['Dua aplikasi terpisah, bahasa resmi tiap platform', 'Kotlin + Jetpack Compose, Swift + SwiftUI', 'Performa & akses fitur paling maksimal', 'Biaya dan waktu dua kali lipat'],
        },
        {
          ikon: 'web', judul: 'Web / Hibrida', warna: C.accent6,
          poin: ['Situs web dibungkus seperti aplikasi', 'PWA, Ionic/Capacitor', 'Cepat dibuat oleh pengembang web', 'Kurang mulus; akses fitur terbatas'],
        },
        {
          ikon: 'perangkat', judul: 'Lintas Platform', warna: C.accent1, sorot: true, tag: '✓ Dipakai di mata kuliah ini',
          poin: ['Satu kode untuk banyak platform', 'Flutter, React Native, Kotlin Multiplatform', 'Hemat waktu, tampilan konsisten', 'Ukuran aplikasi sedikit lebih besar'],
        },
      ],
      pesan: 'Analogi katering: dapur di setiap kota (native), makanan beku dari dapur pusat (web), satu dapur modern dengan resep untuk semua kota (lintas platform).',
      catatan: 'Tekankan bahwa tidak ada pendekatan yang paling benar; perusahaan memilih berdasarkan kebutuhan, anggaran, dan keahlian tim.',
    });

    d.banding({
      judul: 'Berkenalan dengan Flutter dan Dart',
      kolom: [
        {
          ikon: 'widget', judul: 'Flutter = bodi & dasbor', warna: C.accent2,
          poin: ['Framework UI sumber terbuka dari Google', 'Stabil sejak Desember 2018; kini versi 3.47', 'Satu kode untuk 6 platform: Android, iOS, web, Windows, macOS, Linux', 'Komponen tampilan siap pakai (widget)'],
        },
        {
          ikon: 'kode', judul: 'Dart = mesin', warna: C.accent1,
          poin: ['Bahasa pemrograman untuk menulis aplikasi Flutter', 'Juga buatan Google', 'Mengatur logika: variabel, perhitungan, keputusan', 'Dipelajari khusus di Pertemuan 2 dan 3'],
        },
      ],
      pesan: 'Mesinnya dikenal dulu sebelum mobilnya dikendarai jauh. Itulah sebabnya dua pertemuan berikutnya membahas Dart.',
      catatan: 'Gunakan analogi mobil. Sebutkan contoh aplikasi Flutter dari Flutter Showcase: Google Pay, Google Classroom, NotebookLM, BMW, Toyota, Alibaba, Nubank.',
    });

    d.kartu({
      judul: 'Mengapa Kita Memakai Flutter?',
      kolom: 3,
      item: [
        { ikon: 'perangkat', judul: 'Satu kode', isi: 'Android dan iOS dari satu kode sumber; waktu belajar efisien.' },
        { ikon: 'web', judul: 'Ringan di Chrome', isi: 'PC lab RAM 8 GB cukup: aplikasi dijalankan di browser, tanpa emulator.' },
        { ikon: 'kilat', judul: 'Hot reload', isi: 'Perubahan kode terlihat dalam hitungan detik.' },
        { ikon: 'palet', judul: 'Material Design 3', isi: 'Komponen tampilan modern sudah tersedia.', warna: C.accent6 },
        { ikon: 'grup', judul: 'Dipakai industri', isi: 'Google Pay, Google Classroom, NotebookLM, BMW, Toyota, Nubank.' },
        { ikon: 'buku', judul: 'Dokumentasi lengkap', isi: 'docs.flutter.dev dan DartPad untuk belajar mandiri.' },
      ],
      catatan: 'Contoh perusahaan diambil dari flutter.dev/showcase.',
    });

    d.lapisan({
      judul: 'Bagaimana Flutter Bekerja?',
      lapisan: [
        { ikon: 'kode', judul: 'Kode Dart Anda', isi: 'lib/main.dart dan berkas lain yang Anda tulis' },
        { ikon: 'widget', judul: 'Framework Flutter', isi: 'Widget siap pakai: teks, tombol, daftar, tata letak' },
        { ikon: 'kuas', judul: 'Engine Flutter', isi: 'Menggambar setiap piksel sendiri (Impeller)', warna: C.accent6 },
        { ikon: 'perangkat', judul: 'Embedder', isi: 'Penghubung ke Android, iOS, web, dan desktop', warna: C.text2 },
        { ikon: 'hp', judul: 'Layar perangkat', isi: 'Hasil akhir yang dilihat pengguna', warna: C.accent4 },
      ],
      keterangan: [
        'Flutter tidak "menyewa perabot" (komponen bawaan OS), tetapi "melukis sendiri" tampilannya.',
        'Hasilnya: tampilan sama persis di semua perangkat dan bisa digambar sangat cepat.',
        'Tugas Anda cukup di lapisan paling atas: menulis Dart dan menyusun widget.',
      ],
      catatan: 'Jangan masuk terlalu dalam ke arsitektur engine. Cukup pahami ide "melukis sendiri" dan bahwa mahasiswa bekerja di lapisan paling atas.',
    });

    d.bagian({ label: 'BAGIAN 2', judul: 'Siklus Hidup (Lifecycle) Aplikasi', ikon: 'riwayat' });

    d.tabel({
      judul: 'Lima Status Aplikasi (AppLifecycleState)',
      pengantar: 'Mengapa video berhenti saat Anda menekan tombol Home? Karena aplikasinya memperhatikan siklus hidupnya.',
      kepala: ['Status', 'Artinya', 'Contoh situasi'],
      lebarKolom: [1.2, 3, 3.4],
      baris: [
        [{ text: 'resumed', options: { bold: true, fontFace: 'Consolas' } }, 'Terlihat dan sedang dipakai', 'Menggulir beranda aplikasi'],
        [{ text: 'inactive', options: { bold: true, fontFace: 'Consolas' } }, 'Terlihat, tetapi tidak menerima input', 'Panel notifikasi ditarik; di web: klik jendela lain'],
        [{ text: 'hidden', options: { bold: true, fontFace: 'Consolas' } }, 'Semua tampilan tersembunyi', 'Aplikasi diminimalkan; tab browser ditinggal'],
        [{ text: 'paused', options: { bold: true, fontFace: 'Consolas' } }, 'Tidak terlihat, berjalan di latar belakang', 'Menekan Home lalu membuka aplikasi lain'],
        [{ text: 'detached', options: { bold: true, fontFace: 'Consolas' } }, 'Mesin masih ada, tanpa tampilan', 'Aplikasi sedang ditutup'],
      ],
      pesan: 'Simpan data penting saat aplikasi masuk paused atau hidden. Jangan menunggu detached, karena aplikasi bisa "dibunuh" mendadak.',
      catatan: 'Di Android/iOS urutannya biasanya resumed -> inactive -> hidden -> paused, dan sebaliknya saat dibuka kembali. Beberapa status bisa terlewati jika sistem mematikan aplikasi.',
    });

    d.kode({
      judul: 'Melihat Siklus Hidup Secara Langsung',
      berkas: 'kode/06_siklus_hidup_aplikasi.dart',
      kode: [
        'late final AppLifecycleListener _pendengar;',
        '',
        '@override',
        'void initState() {',
        '  super.initState();',
        '  // dikabari setiap kali status berubah',
        '  _pendengar = AppLifecycleListener(',
        '    onStateChange: _catatStatus,',
        '  );',
        '}',
        '',
        '@override',
        'void dispose() {',
        '  _pendengar.dispose(); // WAJIB: cegah bocor memori',
        '  super.dispose();',
        '}',
      ].join('\n'),
      poin: [
        'AppLifecycleListener memanggil _catatStatus setiap kali status aplikasi berubah.',
        'Jalankan di Chrome, pindah ke tab lain, lalu kembali: catatan inactive, hidden, resumed akan muncul.',
        'Detail initState() dan dispose() dibahas tuntas di Pertemuan 5.',
      ],
      catatan: 'Demo langsung: jalankan contoh 06 di Chrome, lalu pindah tab dan kembali. Tunjukkan daftar catatan bertambah.',
    });

    d.bagian({ label: 'BAGIAN 3', judul: 'Menyiapkan Alat & Proyek Pertama', ikon: 'perkakas' });

    d.kartu({
      judul: 'Alat Kerja yang Dibutuhkan',
      kolom: 3,
      item: [
        { ikon: 'riwayat', judul: 'Git', isi: '"Mesin waktu" kode. Juga dipakai saat mengunduh Flutter. (Wajib)' },
        { ikon: 'kode', judul: 'Visual Studio Code', isi: '"Meja kerja" tempat menulis kode. (Wajib)' },
        { ikon: 'bintang', judul: 'Ekstensi Flutter', isi: 'Pewarnaan kode, saran otomatis, tombol Run. Dart ikut terpasang. (Wajib)' },
        { ikon: 'perkakas', judul: 'Flutter SDK', isi: 'Kotak perkakas berisi Flutter, Dart, dan perintah flutter. (Wajib)' },
        { ikon: 'web', judul: 'Google Chrome', isi: 'Panggung tercepat untuk menjalankan aplikasi. (Wajib)' },
        { ikon: 'hp', judul: 'Android Studio', isi: 'Android SDK untuk HP Android atau emulator. (Opsional)', warna: C.text2 },
      ],
      catatan: 'Panduan lengkap: panduan/02_instalasi_flutter_windows.md di repositori.',
    });

    d.alur({
      judul: 'Langkah Instalasi (Cara Resmi)',
      langkah: [
        { ikon: 'unduh', judul: 'Pasang Git', isi: 'git-scm.com/downloads/win; pilihan bawaan sudah tepat' },
        { ikon: 'kode', judul: 'Pasang VS Code', isi: 'code.visualstudio.com; centang "Add to PATH"' },
        { ikon: 'bintang', judul: 'Ekstensi Flutter', isi: 'Extensions (Ctrl+Shift+X), cari "Flutter" dari Dart Code' },
        { ikon: 'perkakas', judul: 'Download SDK', isi: 'Ctrl+Shift+P → Flutter: New Project → Download SDK → Clone Flutter → Add SDK to PATH' },
        { ikon: 'centang', judul: 'flutter doctor', isi: 'Tutup & buka ulang VS Code, lalu periksa di terminal', warna: C.accent4 },
      ],
      catatan: 'Jika lab sudah terpasang Flutter, langsung ke langkah 5. Ingatkan: setelah Add SDK to PATH, semua terminal dan VS Code harus ditutup lalu dibuka ulang.',
    });

    d.tabel({
      judul: 'Membaca Hasil flutter doctor',
      kepala: ['Baris', 'Wajib [✓]?', 'Keterangan'],
      lebarKolom: [3.2, 1.3, 4],
      baris: [
        ['Flutter', { text: 'Ya', options: { bold: true, color: TEMA_HIJAU } }, 'Inti dari semuanya'],
        ['Chrome - develop for the web', { text: 'Ya', options: { bold: true, color: TEMA_HIJAU } }, 'Menjalankan aplikasi di browser selama kuliah'],
        ['Android toolchain', 'Opsional', 'Hanya untuk HP Android atau emulator'],
        ['Visual Studio - develop Windows apps', 'Tidak', 'Hanya untuk aplikasi desktop Windows. Abaikan.'],
      ],
      pesan: '[✓] sehat · [!] peringatan, baca pesannya · [✗] masalah, perbaiki jika bagian itu dibutuhkan.',
      catatan: 'Tampilkan contoh output flutter doctor di laptop dosen. Yang wajib hijau minggu ini: Flutter dan Chrome.',
    });

    d.kode({
      judul: 'Membuat Proyek Pertama',
      kode: [
        '# Cara B: lewat terminal',
        'flutter create halo_flutter',
        'cd halo_flutter',
        'code .',
        '',
        '# Menjalankan di Chrome',
        'flutter devices',
        'flutter run -d chrome',
      ].join('\n'),
      shell: true,
      poin: [
        'Cara A (VS Code): Ctrl+Shift+P → Flutter: New Project → Application → pilih folder → ketik nama.',
        'Nama proyek wajib snake_case: halo_flutter ✓, Halo Flutter ✗, halo-flutter ✗, 1halo ✗.',
        'Kode Anda tinggal di lib/main.dart; identitas dan paket proyek di pubspec.yaml.',
        'Folder android/, ios/, web/ berisi pengaturan platform; jarang disentuh di awal.',
      ],
      ukuran: 17,
      lebarKode: 6.2,
      catatan: 'Demo flutter create, lalu buka struktur folder di VS Code. Tekankan dua item penting: lib/ dan pubspec.yaml. Ingatkan YAML wajib memakai spasi, bukan Tab.',
    });

    d.banding({
      judul: 'Di Mana Aplikasi Dijalankan?',
      kolom: [
        {
          ikon: 'web', judul: 'Google Chrome', warna: C.accent1, sorot: true, tag: '✓ Rekomendasi untuk lab',
          poin: ['Ringan, cocok untuk RAM 8 GB', 'VS Code: pilih Chrome, tekan F5', 'Terminal: flutter run -d chrome'],
        },
        {
          ikon: 'usb', judul: 'HP Android asli', warna: C.accent4, tag: 'Opsional, butuh Android Studio',
          poin: ['Aktifkan Opsi pengembang & Debugging USB', 'Sambungkan kabel data, ketuk Izinkan', 'flutter devices → flutter run'],
        },
        {
          ikon: 'memori', judul: 'Emulator', warna: C.accent5, tag: 'Butuh RAM besar (disarankan 16 GB)',
          poin: ['"HP palsu" di dalam komputer', 'Praktis, tetapi berat', 'Tidak disarankan untuk PC lab'],
        },
      ],
      pesan: 'Saat flutter run di terminal: r = hot reload · R = hot restart · h = bantuan · q = berhenti.',
      catatan: 'Untuk menampilkan layar HP ke proyektor, dosen bisa memakai scrcpy.',
    });

    d.kode({
      judul: 'Aplikasi Paling Sederhana',
      berkas: 'kode/01_aplikasi_pertama.dart',
      kode: [
        "import 'package:flutter/material.dart';",
        '',
        'void main() {',
        '  runApp(',
        '    const Center(',
        '      child: Text(',
        "        'Halo, Dunia Flutter!',",
        '        textDirection: TextDirection.ltr,',
        '        style: TextStyle(fontSize: 32),',
        '      ),',
        '    ),',
        '  );',
        '}',
      ].join('\n'),
      poin: [
        'main() adalah pintu masuk: program selalu mulai dari sini.',
        'runApp() memasang widget sebagai seluruh tampilan aplikasi.',
        'Center menaruh anaknya (child) di tengah; Text menampilkan tulisan.',
        'Tanpa MaterialApp, arah tulisan (textDirection) wajib ditulis sendiri.',
      ],
      catatan: 'Jalankan dan tunjukkan hasilnya: layar hitam polos dengan tulisan putih. Tanyakan: apa yang kurang dari tampilan ini dibanding aplikasi sungguhan?',
    });

    d.kode({
      judul: 'Semua Adalah Widget: MaterialApp & Scaffold',
      berkas: 'kode/02_materialapp_dan_scaffold.dart',
      kode: [
        'class AplikasiSaya extends StatelessWidget {',
        '  const AplikasiSaya({super.key});',
        '',
        '  @override',
        '  Widget build(BuildContext context) {',
        '    return const MaterialApp(',
        "      title: 'Aplikasi Pertama',",
        '      home: HalamanUtama(),',
        '    );',
        '  }',
        '}',
        '',
        '// di dalam HalamanUtama.build():',
        'return Scaffold(',
        "  appBar: AppBar(title: const Text('Halo')),",
        "  body: const Center(child: Text('Isi')),",
        ');',
      ].join('\n'),
      ukuran: 14,
      poin: [
        'Widget disusun bertingkat seperti balok Lego: pohon widget.',
        'StatelessWidget: widget buatan sendiri yang tampilannya tidak berubah sendiri.',
        'build() adalah "resep" tampilan yang dipanggil Flutter.',
        'MaterialApp = fondasi (tema, arah teks, navigasi). Scaffold = kerangka halaman: atap (appBar) dan isi (body).',
      ],
      catatan: 'Gambarkan pohon widget di papan: AplikasiSaya → MaterialApp → HalamanUtama → Scaffold → AppBar/Center → Text.',
    });

    d.kode({
      judul: 'Warna dari Tema, Bukan Ditulis Manual',
      berkas: 'kode/03_tema_warna_dan_teks.dart',
      kode: [
        'theme: ThemeData(',
        '  colorScheme: ColorScheme.fromSeed(',
        '    seedColor: Colors.indigo, // warna benih',
        '  ),',
        '),',
        '',
        '// memakai warna & gaya teks dari tema',
        'final ColorScheme warna =',
        '    Theme.of(context).colorScheme;',
        'final TextTheme gayaTeks =',
        '    Theme.of(context).textTheme;',
        '',
        "Text('Aplikasi Pertamaku',",
        '    style: gayaTeks.headlineMedium),',
      ].join('\n'),
      poin: [
        'Satu warna benih → Flutter meracik palet Material 3 yang serasi.',
        'Ambil warna dan gaya teks lewat Theme.of(context).',
        'Ingin ganti warna seluruh aplikasi? Cukup ubah satu baris seedColor.',
      ],
      catatan: 'Demo: ganti Colors.indigo dengan Colors.green lalu simpan; semua warna ikut berubah serasi.',
    });

    const sHot = d.tabel({
      judul: 'Hot Reload vs Hot Restart',
      kepala: ['', '🔥 Hot Reload', '🔄 Hot Restart'],
      lebarKolom: [2.2, 3.4, 3.4],
      baris: [
        [{ text: 'Yang terjadi', options: { bold: true } }, 'Kode baru disuntikkan ke aplikasi yang sedang berjalan', 'Aplikasi dimulai ulang dari main()'],
        [{ text: 'Data di layar', options: { bold: true } }, { text: 'TETAP (angka tidak kembali ke 0)', options: { bold: true, color: TEMA_HIJAU } }, { text: 'HILANG (kembali ke nilai awal)', options: { bold: true, color: TEMA_MERAH } }],
        [{ text: 'Kecepatan', options: { bold: true } }, 'Sangat cepat (umumnya < 1 detik)', 'Beberapa detik'],
        [{ text: 'VS Code', options: { bold: true } }, 'Simpan (Ctrl+S) atau ikon petir', 'Ikon panah melingkar (Ctrl+Shift+F5)'],
        [{ text: 'Terminal', options: { bold: true } }, 'Tekan r', 'Tekan R'],
      ],
      batasBawah: 5.7,
      catatan: 'Analogi: hot reload = mengganti baju orang yang sedang tidur tanpa membangunkannya; hot restart = membangunkannya dan menyuruh mulai hari dari awal. Demo dengan contoh 04.',
    });
    d.tombolKode(sHot, { x: 0.6, y: 6.0, w: 7.4, berkas: 'kode/04_hot_reload_vs_hot_restart.dart' });

    const sAlur = d.alur({
      judul: 'Apa yang Terjadi Saat Tombol + Ditekan?',
      pengantar: 'Aplikasi counter bawaan "flutter create" — versi berkomentar bahasa Indonesia ada di contoh 05.',
      langkah: [
        { ikon: 'sentuh', judul: 'Pengguna menekan +', isi: 'FloatingActionButton menerima sentuhan' },
        { ikon: 'fungsi', judul: 'Fungsi dipanggil', isi: '_incrementCounter() yang terdaftar di onPressed dijalankan' },
        { ikon: 'setel', judul: 'setState()', isi: 'Nilai _counter naik dan Flutter diberi tahu ada perubahan' },
        { ikon: 'ulang', judul: 'build() diulang', isi: 'Flutter menggambar ulang halaman' },
        { ikon: 'lihat', judul: 'Angka baru tampil', isi: 'Tanpa setState(), layar tidak berubah', warna: C.accent4 },
      ],
      tinggiKotak: 3.35,
      catatan: 'Jelaskan bahwa template asli memakai .center dan .fromSeed (dot shorthand Dart 3.10), artinya sama dengan MainAxisAlignment.center dan ColorScheme.fromSeed.',
    });
    d.tombolKode(sAlur, { x: 0.6, y: 5.95, w: 7.4, berkas: 'kode/05_aplikasi_counter_bawaan.dart' });

    d.tabel({
      judul: 'Kesalahan Umum Pemula',
      kepala: ['Gejala / pesan', 'Solusi'],
      lebarKolom: [4.6, 4.4],
      baris: [
        ["'flutter' is not recognized ...", 'Tutup & buka ulang terminal dan VS Code; periksa PATH'],
        ['The Flutter SDK is installed in a protected folder', 'Pindahkan SDK keluar dari C:\\Program Files\\'],
        ['Building with plugins requires symlink support', 'Jalankan start ms-settings:developers, aktifkan Developer Mode'],
        ['... is not a valid Dart package name', 'Pakai snake_case: halo_flutter'],
        ['Layar merah: No Directionality widget found.', 'Bungkus dengan MaterialApp atau beri textDirection'],
        ['Perubahan kode tidak terlihat', 'Tekan r di terminal; jika masih sama, tekan R'],
      ],
      ukuran: 16,
      catatan: 'Daftar lengkap ada di panduan/04_troubleshooting.md.',
    });

    d.ringkasan({
      poin: [
        'Aplikasi mobile harus memperhatikan layar kecil, sentuhan, baterai, koneksi, sensor, dan pengguna yang sering berpindah aplikasi.',
        'Di Indonesia: Android ±79%, iOS ±21%. Idealnya aplikasi hadir di keduanya.',
        'Tiga pendekatan: native, web/hibrida, lintas platform. Flutter termasuk lintas platform.',
        'Flutter = framework UI, Dart = bahasanya. Flutter melukis sendiri tampilannya.',
        'Siklus hidup: resumed, inactive, hidden, paused, detached.',
        'Alat wajib: Git, VS Code + ekstensi Flutter, Flutter SDK, Chrome; cek dengan flutter doctor.',
        'Semua adalah widget: MaterialApp sebagai fondasi, Scaffold sebagai kerangka halaman.',
        'Hot reload (r) menjaga data; hot restart (R) mengulang dari awal.',
      ],
      catatan: 'Minta 2-3 mahasiswa menyebutkan satu hal baru yang mereka pelajari hari ini.',
    });

    d.penutup({
      judul: 'Saatnya Praktik!',
      subjudul: 'Kerjakan Jobsheet Pertemuan 1, lalu uji pemahaman di Latihan. Pertemuan berikutnya: Dasar Pemrograman Dart.',
      tautan: [
        { teks: 'Jobsheet P1', ikon: 'tugas', url: d.urlBerkas('pertemuan_01_pengenalan_flutter/JOBSHEET.md') },
        { teks: 'Latihan P1', ikon: 'kuis', url: d.urlBerkas('pertemuan_01_pengenalan_flutter/LATIHAN.md') },
        { teks: 'Modul P1', ikon: 'buku', url: d.urlBerkas('pertemuan_01_pengenalan_flutter/README.md') },
      ],
      catatan: 'Tunjukkan lokasi jobsheet di GitHub. Bagian A-D dikerjakan di lab; Bagian F adalah tugas mandiri.',
    });
  },
};

const TEMA_HIJAU = '2E7D32';
const TEMA_MERAH = 'C62828';

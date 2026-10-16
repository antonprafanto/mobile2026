// Konten slide Pertemuan 15 — Build, Rilis & Finalisasi Proyek.
// Teks diambil dari modul bacaan (pertemuan_15_build_rilis_dan_finalisasi/README.md).
// Kode diambil dari modul dan dari folder pertemuan_15_build_rilis_dan_finalisasi/kode/
// serta templat/.
//
// Catatan kode di slide: kode disalin dari modul/berkas contoh. Jika terlalu
// panjang untuk satu slide, bagian yang dilewati ditandai "// ..." atau
// "...", dan catatan pembicara menyebutkannya.

module.exports = {
  nomor: '15',
  folder: 'pertemuan_15_build_rilis_dan_finalisasi',
  namaBerkas: 'PERTEMUAN_15_Build_Rilis_dan_Finalisasi',
  topik: 'Build, Rilis & Finalisasi Proyek',

  bangun(d) {
    const C = d.C;
    // Teks berhuruf kode (Consolas) untuk sel tabel; ukuran boleh dikecilkan.
    const kode = (teks, ukuran) => ({
      text: teks,
      options: ukuran ? { fontFace: 'Consolas', fontSize: ukuran } : { fontFace: 'Consolas' },
    });

    d.judul({
      judul: 'Build, Rilis & Finalisasi Proyek',
      subjudul: 'Pertemuan 15  ·  mode build dan --dart-define; nama, versi, ikon, layar pembuka; galat di aplikasi rilis; halaman Tentang, privasi, lisensi; rilis web (GitHub Pages) dan Android (APK, tanda tangan, App Bundle); rilis otomatis dan cek pembaruan; toko aplikasi; finalisasi proyek akhir',
      catatan: 'Selama ini aplikasi hanya kita jalankan di laptop sendiri dengan flutter run. Hari ini aplikasi itu "keluar rumah": punya nama, ikon, dan nomor versi; tahan terhadap galat; jujur soal data dan lisensinya; tersedia sebagai situs web dan APK yang bisa diunduh; serta dirilis otomatis lewat GitHub. Bekal: REST API, izin internet, dan --dart-define untuk kunci API (P10); akar komposisi dan data palsu (P12); izin dan privasi (P13); tes otomatis dan GitHub Actions (P14). Laptop RAM 8 GB cukup: rilis web hanya butuh Flutter dan Chrome. Rilis Android butuh Android SDK; yang belum punya bisa meminta robot GitHub mem-build APK (Bagian 12).',
    });

    d.tujuan({
      pengantar: 'Setelah pertemuan ini, Anda mampu:',
      poin: [
        'Membedakan mode debug, profile, dan release, termasuk yang hilang dan berubah saat rilis',
        'Memberi konfigurasi saat run/build dengan --dart-define dan membacanya dengan aman',
        'Menyiapkan identitas: nama tampilan, application ID, versi, ikon adaptif, layar pembuka',
        'Memasang jaring pengaman galat dan pengganti layar merah yang ramah',
        'Membuat halaman Tentang: versi, atribusi data, kebijakan privasi, lisensi',
        'Mem-build dan menguji rilis web, lalu menerbitkannya di GitHub Pages',
        'Mem-build APK dan App Bundle, memasangnya, dan menandatanganinya dengan kunci unggah',
        'Merilis otomatis dengan tag Git dan GitHub Actions, plus cek pembaruan',
        'Memeriksa ukuran, kecepatan, dan keamanan; mengenal Google Play dan App Store',
        'Menyelesaikan finalisasi proyek akhir: daftar periksa, README, CHANGELOG, demo UAS',
      ],
      catatan: 'Target akhir hari ini: proyek yang "jalan di laptop" menjadi aplikasi yang siap dipakai orang lain. Di jobsheet, "Tugas Kuliahku" dirilis sebagai versi 1.0.0: punya nama, ID, ikon, dan layar pembuka sendiri; tahan terhadap galat; punya halaman Tentang dan kebijakan privasi; terbit di GitHub Pages dan GitHub Releases. Menerbitkan ke Google Play TIDAK wajib; langkahnya dibahas sebagai gambaran.',
    });

    d.alur({
      judul: 'Peta Materi Hari Ini',
      langkah: [
        { ikon: 'setel', judul: 'A. Mode dan konfigurasi', isi: 'Debug, profile, release; --dart-define (Bagian 1–3)' },
        { ikon: 'label', judul: 'B. Identitas', isi: 'Nama, ID, versi, ikon, layar pembuka (4–6)' },
        { ikon: 'perisai', judul: 'C. Siap rilis dari dalam', isi: 'Galat, Tentang, privasi, lisensi (7–8)' },
        { ikon: 'unduh', judul: 'D. Rilis web dan Android', isi: 'GitHub Pages, APK, tanda tangan, AAB (9–11)', warna: C.accent5 },
        { ikon: 'sinkron', judul: 'E. Rilis otomatis', isi: 'Tag, GitHub Releases, cek pembaruan (12–13)', warna: C.accent5 },
        { ikon: 'centang', judul: 'F. Pemeriksaan akhir', isi: 'Ukuran, keamanan, toko, proyek akhir (14–17)', warna: C.accent4 },
      ],
      catatan: 'Bagian A: apa bedanya aplikasi yang dijalankan dengan flutter run dan aplikasi yang dibagikan, serta cara memberi pengaturan tanpa mengubah kode. Bagian B: aplikasi mendapat nama, nomor versi, dan ikonnya sendiri, alih-alih "flutter_application_1" berlogo Flutter. Bagian C: apa yang dilihat pengguna saat terjadi galat, dan apa yang wajib diberitahukan tentang data dan lisensi. Bagian D: membuat berkas rilis web dan Android, mengujinya, dan menandatanganinya. Bagian E: rilis yang terjadi otomatis setiap ada versi baru, dan cara pengguna tahu ada versi baru. Bagian F: pemeriksaan sebelum rilis, toko aplikasi, dan yang dikumpulkan untuk proyek akhir.',
    });

    d.tabel({
      judul: 'Kode Contoh dan Templat Hari Ini',
      kepala: ['No', 'Berkas', 'Isi', 'Jalan di'],
      lebarKolom: [0.5, 5.6, 3.6, 2.4],
      baris: [
        ['01', kode('contoh_01_versi_dan_nomor_build_dart_murni.dart', 11), 'Mengurai, membandingkan, menaikkan versi', 'DartPad, dart run'],
        ['02', kode('contoh_02_mode_build_dan_konfigurasi.dart', 11), '"Info Build": mode, assert, --dart-define', 'DartPad, proyek'],
        ['03', kode('contoh_03_menangani_galat_di_rilis.dart', 11), '"Uji Galat": jaring pengaman galat', 'DartPad, proyek'],
        ['04', kode('contoh_04_halaman_tentang_dan_lisensi.dart', 11), 'Halaman Tentang "Cuaca Kampus"', 'DartPad, proyek'],
        ['05', kode('contoh_05_cek_pembaruan.dart', 11), '"Jadwal Kuliah": lima skenario server', 'DartPad, proyek'],
        ['06', kode('contoh_06_pemeriksa_kesiapan_rilis_dart_murni.dart', 11), 'Daftar periksa rilis sebagai program', 'DartPad, dart run'],
        ['07', kode('contoh_07_studi_kasus_cuaca_kampus_siap_rilis.dart', 11), 'Studi kasus "Cuaca Kampus 1.0.0"', 'DartPad, proyek'],
        ['—', kode('templat/: web.yml, rilis.yml, README_PROYEK.md, CHANGELOG.md, KEBIJAKAN_PRIVASI.md', 10), 'Siap salin ke proyek Anda', 'Repositori Anda'],
      ],
      ukuran: 12.5,
      tinggiBaris: 0.52,
      catatan: 'Contoh 01 dan 06 adalah program Dart murni; Contoh 02–05 dan 07 berjalan di DartPad. Folder templat/ berisi berkas siap salin: web.yml (menerbitkan versi web ke GitHub Pages setiap push ke main) dan rilis.yml (mem-build APK dan membuat halaman rilis setiap push tag versi) disalin ke .github/workflows/; README_PROYEK.md, CHANGELOG.md, dan KEBIJAKAN_PRIVASI.md menjadi dokumen proyek akhir. Folder aset/ berisi ikon contoh "Tugas Kuliahku" 1024 × 1024 untuk jobsheet; proyek akhir sebaiknya memakai ikon buatan sendiri.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 1', judul: 'Dari "Jalan di Laptop" ke "Siap Dibagikan"', ikon: 'restoran', catatan: 'Aplikasi Anda sudah lama "matang" sejak Pertemuan 9: mengambil data dari internet, menyimpan data di perangkat, tertata rapi, dan teruji. Hari ini kita membuka warungnya.' });

    d.tabel({
      judul: 'Dapur Sendiri vs Warung',
      pengantar: 'Memasak di dapur sendiri berbeda dengan membuka warung. Begitu juga aplikasi yang dibagikan:',
      kepala: ['Di warung', 'Di aplikasi', 'Bagian'],
      lebarKolom: [5.2, 5.6, 1.3],
      baris: [
        ['Papan nama dan logo', 'Nama aplikasi, ikon, application ID', '4, 6'],
        ['Nomor edisi menu ("menu baru mulai 1 November")', 'Nomor versi dan nomor build', '5'],
        ['Masakan dikemas rapi, bukan dari wajan langsung', 'Build rilis: lebih kecil, lebih cepat', '2, 9–11'],
        ['Segel kemasan, agar yakin tidak ditukar orang', 'Tanda tangan digital', '11'],
        ['Daftar komposisi dan asal bahan', 'Atribusi data, lisensi, kebijakan privasi', '8'],
        ['Pelayan tetap sopan saat ada yang salah', 'Pesan galat yang ramah', '7'],
        ['Pengumuman "ada menu baru"', 'Catatan rilis dan cek pembaruan', '12, 13'],
      ],
      ukuran: 16,
      tinggiBaris: 0.58,
      catatan: 'Bayangkan Anda pandai memasak nasi goreng. Di dapur sendiri, peralatan berserakan tidak masalah, garam tanpa label pun Anda tahu isinya, dan kalau rasanya kurang, cukup ditambah saat itu juga. Suatu hari Anda membuka warung. Tiba-tiba ada hal yang tidak penting di dapur sendiri, tetapi wajib di warung. Kolom "Bagian" menunjukkan di mana setiap baris dibahas hari ini.',
    });

    d.tabel({
      judul: 'Apa yang Berbeda saat Aplikasi Dibagikan?',
      kepala: ['Hal', 'Saat flutter run (debug)', 'Saat dibagikan (rilis)'],
      lebarKolom: [3.4, 4.2, 4.5],
      baris: [
        ['Hot reload', 'Ada', 'Tidak ada'],
        ['Kecepatan dan ukuran', 'Bisa tersendat; besar', 'Lancar; jauh lebih kecil'],
        ['Galat saat membangun widget', 'Layar MERAH berisi pesan lengkap', 'Kotak ABU-ABU tanpa keterangan'],
        [kode('assert(...)', 15), 'Diperiksa', 'DILEWATI'],
        ['Izin internet di Android', 'Ada otomatis', 'Hanya jika ditulis sendiri (10.2)'],
        ['Tanda tangan digital', 'Kunci debug otomatis', 'Kunci milik Anda (Bagian 11)'],
        ['Nama di HP', kode('tugas_kuliahku', 15), 'Seharusnya "Tugas Kuliahku"'],
      ],
      ukuran: 15,
      tinggiBaris: 0.5,
      pesan: 'Aplikasi yang lancar saat flutter run belum tentu lancar saat dibagikan. Build rilis harus DIUJI SENDIRI sebelum diberikan kepada orang lain.',
      catatan: 'Selama ini aplikasi dijalankan dengan flutter run atau tombol F5 di VS Code. Cara itu menghasilkan aplikasi mode debug: dirancang untuk PEMBUATNYA, bukan untuk penggunanya. Baris yang paling sering menjebak: izin internet (Bagian 10.2) dan layar merah yang menjadi kotak abu-abu (Bagian 7). Pita "DEBUG" di pojok kanan atas juga tidak pernah tampil di build rilis.',
    });

    d.tabel({
      judul: 'Ke Mana Aplikasi Dirilis?',
      kepala: ['Jalur', 'Hasil', 'Cara orang lain memakainya', 'Biaya'],
      lebarKolom: [2.9, 3.2, 3.6, 2.4],
      baris: [
        ['Web di GitHub Pages', kode('akun.github.io/nama-repo/', 13), 'Membuka tautan di browser HP atau laptop', 'Gratis'],
        ['APK di GitHub Releases', 'Berkas .apk', 'Mengunduh, lalu memasang di HP Android', 'Gratis'],
        ['Toko aplikasi (Google Play, App Store)', 'Halaman aplikasi di toko', 'Memasang dari toko, diperbarui otomatis', 'Berbayar + peninjauan'],
      ],
      ukuran: 16,
      tinggiBaris: 0.85,
      pesan: 'Proyek akhir: versi web dan/atau APK sesuai arahan dosen. Google Play TIDAK wajib; langkahnya dibahas di Bagian 15 sebagai gambaran.',
      catatan: 'Dua jalur rilis gratis yang wajib dikuasai: web (Bagian 9) dan APK (Bagian 10–12). Jalur ketiga, toko aplikasi, cukup diketahui gambarannya agar Anda tahu jalannya saat kelak membuat aplikasi sungguhan.',
    });

    d.alur({
      judul: 'Peta Perjalanan Rilis',
      langkah: [
        { ikon: 'centang', judul: 'Kode selesai', isi: 'Fitur lengkap, tes lulus' },
        { ikon: 'label', judul: 'Identitas', isi: 'Nama, ID, versi, ikon' },
        { ikon: 'perisai', judul: 'Siap rilis dari dalam', isi: 'Konfigurasi, galat, halaman Tentang' },
        { ikon: 'jalankan', judul: 'Build dan uji rilis', isi: 'Web, APK, AAB; diuji di Chrome dan HP' },
        { ikon: 'kirim', judul: 'Terbitkan, umumkan', isi: 'GitHub Pages, Releases, README, catatan rilis', warna: C.accent5 },
        { ikon: 'ulang', judul: 'Pantau, perbaiki', isi: 'Naikkan versi, lalu kembali ke build', warna: C.accent4 },
      ],
      catatan: 'Rilis BUKAN garis akhir. Setiap perbaikan menghasilkan versi baru, dan perjalanan ini diulang: dari langkah terakhir kembali ke "build rilis". Karena diulang terus, sebagian besar langkahnya nanti dibuat OTOMATIS (Bagian 12).',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 2', judul: 'Tiga Mode Build: Debug, Profile, Release', ikon: 'setel', catatan: 'Flutter mengompilasi aplikasi dengan tiga cara yang berbeda, sesuai tahap pekerjaan Anda.' });

    d.tabel({
      judul: 'Tiga Mode, Tiga Tujuan',
      kepala: ['Mode', 'Untuk apa', 'Cara menjalankan', 'Ciri'],
      lebarKolom: [1.6, 2.8, 3.6, 4.1],
      baris: [
        ['Debug', 'Membuat dan memperbaiki aplikasi', kode('flutter run', 15), 'Hot reload, debugger, pesan galat lengkap, assert diperiksa. Bisa tersendat'],
        ['Profile', 'Mengukur kecepatan', kode('flutter run --profile', 15), 'Hampir secepat rilis; DevTools masih bisa membaca kinerjanya'],
        ['Release', 'Dibagikan ke pengguna', kode('flutter run --release\nflutter build ...', 15), 'Paling cepat dan paling kecil. Tanpa hot reload dan alat debugging'],
      ],
      ukuran: 16,
      tinggiBaris: 1.0,
      pesan: 'Emulator dan simulator hanya mendukung mode debug. Uji mode profile dan release di HP sungguhan atau di Chrome.',
      catatan: 'Perumpamaannya latihan drama. Mode debug adalah LATIHAN: sutradara boleh menghentikan adegan kapan saja dan memberi catatan. Mode profile adalah GLADI BERSIH: berjalan seperti pertunjukan, tetapi masih ada yang mencatat waktu. Mode release adalah PERTUNJUKAN: penonton hanya melihat hasil akhirnya. Perintah build: flutter build web (Bagian 9), flutter build apk (Bagian 10). Untuk web, mode juga menentukan compiler: debug memakai dartdevc (tidak diperkecil, mudah di-debug); profile memakai dart2js dengan tree shaking tetapi tidak diperkecil; release memakai dart2js dengan tree shaking DAN diperkecil (minified). Flutter juga bisa mengompilasi ke WebAssembly dengan flutter build web --wasm (Bagian 9.5).',
    });

    d.kode({
      judul: 'Mengenali Mode dari Dalam Kode',
      kode: [
        "import 'package:flutter/foundation.dart';",
        '',
        '// kDebugMode, kProfileMode, kReleaseMode:',
        '// konstanta waktu kompilasi.',
        '',
        '/// Log yang HANYA ada di mode debug.',
        'void catatDebug(String pesan) {',
        '  if (kDebugMode) {',
        "    debugPrint('[debug] \$pesan');",
        '  }',
        '}',
      ].join('\n'),
      ukuran: 16,
      lebarKode: 6.6,
      poin: [
        'Nilainya sudah ditetapkan saat build. Di build rilis, kDebugMode pasti false.',
        'Compiler pun MEMBUANG seluruh isi if (kDebugMode): tidak memperlambat dan tidak terbawa ke HP pengguna.',
        'Awas: debugPrint TIDAK otomatis hilang di build rilis, walaupun namanya diawali "debug".',
        'Jangan pernah mencetak data pribadi atau token, bahkan dengan debugPrint. print juga diperingatkan linter (avoid_print).',
      ],
      catatan: 'Tanpa if (kDebugMode), isi debugPrint tetap tertulis di log perangkat, dan orang yang menyambungkan HP ke laptop bisa membacanya. Fungsi seperti catatDebug ini dipakai di studi kasus Contoh 07 untuk menggantikan debugPrint("GET $alamat") dari Pertemuan 10.',
    });

    d.kode({
      judul: 'assert Hanya Diperiksa di Mode Debug',
      kode: [
        'bool _assertDijalankan = false;',
        '',
        'bool _tandaiAssert() {',
        '  _assertDijalankan = true;',
        '  return true;',
        '}',
        '',
        '// Di dalam build():',
        'assert(_tandaiAssert()); // dilewati di build rilis',
      ].join('\n'),
      ukuran: 15,
      lebarKode: 7.0,
      poin: [
        'assert(kondisi): pemeriksaan untuk PENGEMBANG. Jika false, aplikasi berhenti dengan pesan galat.',
        'Di build rilis, assert tidak dijalankan sama sekali, TERMASUK fungsi yang dipanggil di dalamnya.',
        'Jangan pernah menaruh kode yang HARUS jalan di dalam assert.',
        'Contoh 02 memakai sifat ini untuk menunjukkan mode yang sedang aktif.',
      ],
      catatan: 'Contoh kesalahan nyata (Latihan C2): assert(simpanPengaturan(...)). Di DartPad (debug) pengaturan tersimpan; di build rilis, simpanPengaturan tidak pernah dipanggil, sehingga pengaturan pengguna tidak pernah tersimpan. Gejala seperti ini hanya muncul pada build rilis, alasan lain mengapa build rilis harus diuji sendiri.',
    });

    d.layar({
      judul: 'Coba Sendiri: Contoh 02 "Info Build"',
      gambar: 'hasil_contoh_02a.jpg',
      kode: [
        'flutter run -d chrome --release',
      ].join('\n'),
      berkas: 'kode/contoh_02_mode_build_dan_konfigurasi.dart',
      poin: [
        'DartPad selalu memakai mode debug: layar menulis Mode build: Debug dan assert(): dijalankan.',
        'Salin ke proyek latihan, lalu jalankan dengan --release: kini Mode build: Release dan assert(): dilewati.',
        'Kode yang sama, hasil berbeda, karena mode build-nya berbeda.',
      ],
      ukuranKode: 15,
      catatan: 'Bagian bawah layar (Lingkungan produksi, Alamat API, Log rinci) adalah konfigurasi --dart-define yang dibahas di Bagian 3. Setiap nilai disertai keterangan opsi --dart-define-nya.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 3', judul: 'Konfigurasi Tanpa Mengubah Kode: --dart-define', ikon: 'sakelar', catatan: 'Nilai pengaturan diberikan saat menjalankan atau mem-build, bukan ditulis di kode. Kodenya tidak pernah berubah.' });

    d.kode({
      judul: 'Memberi Nilai dengan --dart-define',
      shell: true,
      kode: [
        '# Pertemuan 12: SATU baris kode diubah untuk data palsu',
        '#   const Lingkungan lingkungan = Lingkungan.produksi;',
        '',
        'flutter run -d chrome --dart-define=LINGKUNGAN=pengembangan',
        'flutter build web --dart-define=LINGKUNGAN=produksi',
        '',
        '# boleh berkali-kali',
        'flutter run -d chrome --dart-define=LINGKUNGAN=pengembangan \\',
        '  --dart-define=LOG_RINCI=true',
        '',
        '# banyak nilai: kumpulkan di config/pengembangan.json',
        'flutter run -d chrome \\',
        '  --dart-define-from-file=config/pengembangan.json',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.6,
      poin: [
        'Cara lama berbahaya: diubah ke pengembangan untuk mencoba, lupa dikembalikan, lalu APK untuk dosen berisi DATA PALSU.',
        'Format: --dart-define=NAMA=nilai. Nama membedakan huruf besar dan kecil.',
        'Berkas JSON: { "LINGKUNGAN": "pengembangan", "ALAMAT_API": "http://localhost:8080", "LOG_RINCI": "true" }',
      ],
      catatan: 'Cerita di modul Bagian 3.1: suatu sore Anda mengubah const Lingkungan lingkungan menjadi Lingkungan.pengembangan untuk menguji tampilan, lupa mengembalikannya, lalu mem-build APK untuk dosen. Jalan keluarnya: nilai pengaturan diberikan saat menjalankan atau mem-build. Garis miring terbalik di akhir baris hanya pemotong baris di terminal Linux/macOS; di PowerShell tulis dalam satu baris (atau pakai tanda `). Nilai --dart-define tidak berubah lewat hot reload: hentikan aplikasi, lalu jalankan ulang dengan nilai baru.',
    });

    d.kode({
      judul: 'Membaca Nilainya: Wajib const',
      kode: [
        '// Kosong / nilai bawaan jika --dart-define tidak diberikan.',
        'const String teksLingkungan = String.fromEnvironment(',
        "  'LINGKUNGAN',",
        "  defaultValue: 'produksi',",
        ');',
        "const bool logRinci = bool.fromEnvironment('LOG_RINCI');",
        "const int batasData = int.fromEnvironment(",
        "  'BATAS_DATA',",
        '  defaultValue: 20,',
        ');',
        '',
        '// Tanpa const, di web langsung galat:',
        '// Unsupported operation: String.fromEnvironment',
        '// can only be used as a const constructor',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.4,
      poin: [
        'Nilai --dart-define ditanamkan ke kode saat DIKOMPILASI.',
        'Dokumentasi Dart: fromEnvironment hanya DIJAMIN bekerja jika dipanggil sebagai const.',
        'Tanpa const: di build rilis Android/iOS nilainya tidak dijamin terbaca; di web langsung galat.',
        'bool.fromEnvironment bawaannya false; int.fromEnvironment memakai defaultValue jika teksnya bukan bilangan.',
      ],
      catatan: 'Pesan galat di slide sudah kami buktikan di DartPad (Latihan C2 memakai kesalahan ini). Perhatikan perilaku int.fromEnvironment dan bool.fromEnvironment: jika teksnya tidak bisa dibaca (BATAS_DATA=lima, LOG_RINCI=ya), nilai bawaan dipakai diam-diam. Latihan B3 membahas bahayanya.',
    });

    d.layar({
      judul: 'Nilai Bawaan yang Aman, Salah Ketik Ketahuan',
      gambar: 'hasil_contoh_02b.jpg',
      kode: [
        'static Konfigurasi dariLingkungan() {',
        "  // asNameMap(): {'pengembangan': Lingkungan.pengembangan, ...}",
        '  final Lingkungan? lingkungan = Lingkungan.values',
        '      .asNameMap()[_teksLingkungan];',
        '  if (lingkungan == null) {',
        '    throw KonfigurasiSalah(',
        "      'LINGKUNGAN \"$_teksLingkungan\" tidak dikenal. '",
        "      'Pilih: ${Lingkungan.values.map((l) => l.name).join(' atau ')}.',",
        '    );',
        '  }',
        '  // ... pemeriksaan alamat API: produksi wajib https',
        '}',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Bawaan LINGKUNGAN = produksi: lupa --dart-define tetap menghasilkan aplikasi berdata sungguhan.',
        'Salah ketik (produksii) TIDAK diam-diam dianggap nilai bawaan: aplikasi menolak berjalan dan menjelaskan sebabnya.',
      ],
      ukuranPoin: 15,
      catatan: 'Dua kebiasaan baik dari Contoh 02 (kode di slide sama dengan modul Bagian 3.4). Galat yang ketahuan saat diuji jauh lebih murah daripada galat yang ketahuan pengguna. DartPad tidak bisa diberi --dart-define; untuk mencobanya, ubah sementara defaultValue: produksi menjadi produksii.',
    });

    d.banding({
      judul: 'Pita Build Uji, Rahasia, dan Dua Titik Masuk',
      kolom: [
        {
          ikon: 'label', judul: 'Pita "BUILD UJI"', warna: C.accent4, tag: 'Build pengembangan harus terlihat beda, agar tidak tertukar saat didemokan',
          poin: [
            'Sama seperti pita "DATA PALSU" di Pertemuan 12',
          ],
          contoh: [
            'builder: (BuildContext context, Widget? child) {',
            '  if (konfigurasi.lingkungan == Lingkungan.pengembangan) {',
            '    // Pesan pita maksimal sekitar 10 huruf.',
            "    return Banner(message: 'BUILD UJI',",
            '        location: BannerLocation.topEnd, child: child!);',
            '  }',
            '  return child!;',
            '},',
          ].join('\n'),
        },
        {
          ikon: 'gembok', judul: 'Bukan tempat rahasia', warna: C.accent5, tag: 'Nilai --dart-define IKUT DIBAWA di dalam aplikasi',
          poin: [
            'APK bisa dibongkar; JavaScript versi web bisa dibaca',
            '--dart-define hanya menjaga nilai agar tidak masuk Git',
            'Kunci yang benar-benar rahasia (misalnya kunci pembayaran) tidak boleh ada di aplikasi sama sekali',
          ],
        },
      ],
      tinggiKolom: 4.45,
      ukuranPoin: 15,
      ukuranContoh: 10.5,
      pesan: 'Dua titik masuk (-t lib/main_pengembangan.dart) atau --dart-define? Keduanya benar: titik masuk cocok untuk "Tugas Kuliahku"; --dart-define untuk nilai yang sering berganti, misalnya alamat API.',
      catatan: 'Pita dipasang di builder milik MaterialApp; di slide, pemanggilan Banner diringkas menjadi dua baris (versi modul Bagian 3.5 satu argumen per baris). Tentang rahasia: lihat juga Pertemuan 10 Bagian 14.4 (kunci API jangan disimpan di repositori). Dua titik masuk (main.dart dan main_pengembangan.dart, dijalankan dengan -t) mudah dilihat di VS Code dan tiap lingkungan bisa punya kode awal berbeda; --dart-define cukup satu main.dart dan nilai apa pun bisa diberikan, termasuk alamat server dan nomor uji. Proyek besar memakai flavor: varian aplikasi dengan application ID, nama, dan ikon berbeda yang bisa terpasang berdampingan di satu HP (flutter run --flavor staging); materi ini di luar cakupan kuliah, panduannya ada di dokumentasi resmi Flutter.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 4–6', judul: 'Identitas Aplikasi: Nama, ID, Versi, Ikon', ikon: 'label', catatan: 'Proyek baru dari flutter create memakai nama paket sebagai nama tampilan, ID com.example..., versi 1.0.0+1, dan ikon berlogo Flutter. Semuanya diganti sebelum rilis.' });

    d.tabel({
      judul: 'Dua "Nama" yang Berbeda',
      kepala: ['', 'Nama tampilan', 'Application ID'],
      lebarKolom: [3.2, 4.2, 4.7],
      baris: [
        ['Contoh', 'Tugas Kuliahku', kode('com.budisantoso.tugaskuliahku', 15)],
        ['Dibaca oleh', 'Manusia (di bawah ikon, di toko)', 'Sistem operasi dan toko aplikasi'],
        ['Boleh sama dengan aplikasi lain?', 'Boleh', 'TIDAK: unik di seluruh dunia'],
        ['Boleh diganti setelah rilis?', 'Boleh', 'TIDAK: ID baru = aplikasi lain'],
        ['Perumpamaan', 'Nama panggilan', 'Nomor KTP'],
      ],
      ukuran: 17,
      tinggiBaris: 0.72,
      pesan: 'flutter create tugas_kuliahku menghasilkan nama tampilan "tugas_kuliahku" dan ID com.example.tugas_kuliahku. Keduanya harus diganti sebelum rilis.',
      catatan: 'Dua identitas yang sering tertukar. Nama tampilan untuk manusia; application ID untuk sistem operasi dan Google Play. Di iPhone, padanan application ID adalah Bundle Identifier, diatur lewat Xcode (Runner → General → Identity); karena mem-build aplikasi iPhone membutuhkan Mac, bagian ini cukup diketahui saja.',
    });

    d.tabel({
      judul: 'Nama Tampilan Ada di Beberapa Tempat',
      kepala: ['Tempat nama tampil', 'Berkas', 'Yang diubah'],
      lebarKolom: [4.2, 4.3, 3.6],
      baris: [
        ['Di bawah ikon HP Android', kode('android/app/src/main/AndroidManifest.xml', 12), kode('android:label', 14)],
        ['Di bawah ikon iPhone', kode('ios/Runner/Info.plist', 13), kode('CFBundleDisplayName', 14)],
        ['Tab browser saat aplikasi web dimuat', kode('web/index.html', 14), '<title>, description, apple-mobile-web-app-title'],
        ['Saat versi web "dipasang" di HP (PWA)', kode('web/manifest.json', 14), 'name, short_name, description'],
        ['Daftar aplikasi terbuka di Android; tab setelah aplikasi berjalan', kode('lib/...', 14), kode("MaterialApp(title: ...)", 13)],
      ],
      ukuran: 15,
      tinggiBaris: 0.74,
      catatan: 'Contoh perubahan di AndroidManifest.xml: android:label="Tugas Kuliahku". Di web/manifest.json: "name", "short_name", dan "description". Modifikasi 1 Praktikum 1 meminta mahasiswa membuktikan sendiri: judul tab saat aplikasi dimuat berasal dari web/index.html, tetapi setelah Flutter berjalan diganti oleh MaterialApp(title: ...). Jika salah satu lupa diubah, judul tab berganti-ganti.',
    });

    d.kode({
      judul: 'Application ID: Nomor KTP Aplikasi',
      kode: [
        '// android/app/build.gradle.kts (bawaan flutter create)',
        'android {',
        '    namespace = "com.example.tugas_kuliahku"',
        '    defaultConfig {',
        '        // TODO: Specify your own unique Application ID ...',
        '        applicationId = "com.example.tugas_kuliahku"',
        '    }',
        '}',
        '',
        '// Proyek baru: ID sejak awal',
        '// flutter create --org com.budisantoso tugas_kuliahku',
      ].join('\n'),
      ukuran: 12.5,
      lebarKode: 7.2,
      poin: [
        'applicationId: identitas di HP dan Google Play. GANTI sebelum rilis pertama.',
        'namespace: nama paket kode Kotlin. Tidak wajib diganti (MainActivity.kt harus ikut dipindah).',
        'Aturan: com.namaanda.namaaplikasi; minimal 2 bagian; tiap bagian diawali huruf; hanya huruf, angka, _; huruf kecil; bukan com.example.',
        '✅ com.budisantoso.tugaskuliahku, id.timpelangi.cuacakampus',
        '❌ com.budi-santoso.tugas (ada -), com.2609106001.tugas (diawali angka)',
      ],
      catatan: 'NIM tidak bisa dijadikan bagian tersendiri karena diawali angka, tetapi boleh ditempel setelah huruf, misalnya com.mhs2609106001.tugaskuliahku. Google Play menolak com.example. Bagi HP, applicationId yang berbeda adalah aplikasi yang berbeda: setelah ID diganti, aplikasi lama ber-ID com.example... tetap terpasang di HP; hapus agar tidak bingung saat mencoba. Di slide, beberapa baris bawaan Gradle diwakili "...".',
    });

    d.tabel({
      judul: 'Nomor Versi: Satu Baris, Dua Nomor',
      pengantar: 'Di pubspec.yaml: version: 1.0.0+1. Flutter menyalinnya ke Android, iPhone, dan version.json web setiap build.',
      kepala: ['Bagian', 'Naik jika ...', 'Contoh perubahan', 'Dari 1.4.2+17'],
      lebarKolom: [3.0, 3.6, 3.4, 2.1],
      baris: [
        ['PATCH (nama versi)', 'hanya memperbaiki bug', 'Tombol simpan yang macet diperbaiki', kode('1.4.3+18', 15)],
        ['MINOR (nama versi)', 'menambah fitur, yang lama tetap jalan', 'Fitur ekspor jadwal', kode('1.5.0+18', 15)],
        ['MAYOR (nama versi)', 'perubahan besar yang tidak cocok dengan versi lama', 'Format data lama tidak dipakai lagi', kode('2.0.0+18', 15)],
        ['Nomor build (+...)', 'SETIAP unggahan, apa pun perubahannya', 'Dibaca toko dan sistem operasi', '…+18'],
      ],
      ukuran: 14.5,
      tinggiBaris: 0.66,
      pesan: 'Saat satu bagian naik, bagian di kanannya kembali ke 0. Versi 0.x.y = belum rilis resmi; rilis resmi pertama 1.0.0. Nomor build yang sudah dipakai ditolak toko.',
      catatan: 'Nama versi (1.0.0) dibaca pengguna: versionName di Android, CFBundleShortVersionString di iPhone. Nomor build (1) dibaca toko aplikasi dan sistem operasi: versionCode di Android, CFBundleVersion di iPhone. Aturannya Semantic Versioning: MAYOR.MINOR.PATCH. Android juga menolak memasang pembaruan yang nomor build-nya lebih kecil daripada aplikasi terpasang. Nomor versi bisa ditimpa saat build tanpa mengubah pubspec: flutter build apk --build-name=1.0.1 --build-number=2. Dengan --split-per-abi, Flutter menambahkan 1000 × kode ABI ke nomor build agar setiap APK berbeda.',
    });

    d.kode({
      judul: 'Menampilkan Versi: package_info_plus',
      kode: [
        'class _TeksVersiState extends State<TeksVersi> {',
        '  // Future dibuat SEKALI, bukan di dalam build.',
        '  late final Future<PackageInfo> _info =',
        '      PackageInfo.fromPlatform();',
        '',
        '  @override',
        '  Widget build(BuildContext context) {',
        '    return FutureBuilder<PackageInfo>(',
        '      future: _info,',
        '      builder: (BuildContext context, hasil) {',
        '        final PackageInfo? info = hasil.data;',
        "        if (info == null) return const Text('Versi ...');",
        "        return Text('Versi \${info.version} '",
        "            '(build \${info.buildNumber})');",
        '      },',
        '    );',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 12.5,
      lebarKode: 7.2,
      poin: [
        'flutter pub add package_info_plus. Jangan tulis versi dua kali (pubspec DAN kode).',
        'version: 1.0.0+1 → info.version 1.0.0, info.buildNumber 1; info.packageName = application ID.',
        'Web: membaca version.json hasil build. Panggil DI DALAM widget, bukan sebelum runApp (bisa gagal di Android).',
        'Tes widget: PackageInfo.setMockInitialValues(...).',
      ],
      catatan: 'Saat pengguna melapor "aplikasinya galat", pertanyaan pertama adalah "versi berapa?". Versi dibaca dari aplikasinya sendiri, sehingga selalu sama dengan pubspec.yaml. DartPad tidak menyediakan paket ini, jadi Contoh 04 dan 07 menulis versinya sebagai konstanta, lengkap dengan komentar pengingat. Di slide, tipe parameter hasil (AsyncSnapshot<PackageInfo>) tidak ditulis dan teks versi dipecah dua agar muat; versi lengkapnya ada di modul Bagian 5.4.',
    });

    d.kode({
      judul: 'Jangan Membandingkan Versi sebagai Teks',
      kode: [
        '/// Urutan menurut NAMA VERSI: mayor, minor, patch.',
        '@override',
        'int compareTo(Versi lain) {',
        '  if (mayor != lain.mayor) return mayor.compareTo(lain.mayor);',
        '  if (minor != lain.minor) return minor.compareTo(lain.minor);',
        '  return patch.compareTo(lain.patch);',
        '}',
        '',
        '// Hasil Contoh 01:',
        '// 1.10.0 vs 1.9.0',
        '//   sebagai teks : 1.10.0 lebih LAMA',
        '//   sebagai Versi: 1.10.0 lebih BARU',
        '// 1.0.2+2  DITOLAK: nomor build 2 sudah dipakai',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.5,
      berkas: 'kode/contoh_01_versi_dan_nomor_build_dart_murni.dart',
      poin: [
        'Teks dibandingkan HURUF DEMI HURUF: "1" lebih kecil daripada "9", jadi "1.10.0" < "1.9.0".',
        'Bandingkan per bagian sebagai ANGKA.',
        'Nomor build tidak ikut dibandingkan: 1.4.2+17 dan 1.4.2+18 sama-sama "versi 1.4.2".',
      ],
      catatan: 'Kesalahan ini dipakai di fitur cek pembaruan (Bagian 13) dan muncul di Latihan B1, C1, dan D3. Contoh 01 juga menunjukkan riwayat unggahan ke toko: 1.0.0+1 diterima, 1.0.1+2 diterima, 1.0.2+2 ditolak (nomor build 2 sudah dipakai), 1.1.0+1 ditolak (harus lebih dari 2), 1.1.0+3 diterima.',
    });

    d.layar({
      judul: 'Ikon yang Baik dan Ikon Adaptif',
      gambar: 'jobsheet_praktikum1.jpg',
      poin: [
        'Sederhana: satu bentuk utama yang tetap jelas saat kecil (± 1 cm di HP).',
        'Persegi 1024 × 1024 piksel, PNG; untuk iPhone tidak boleh transparan.',
        'Ikon adaptif (Android 8+): lapisan belakang + lapisan depan, lalu dipotong HP (lingkaran, persegi membulat, ...).',
        'Simbol di TENGAH; pinggirannya boleh terpotong.',
        'Android 13+: themed icon, satu warna mengikuti tema HP.',
      ],
      ukuranPoin: 16,
      lebarMaks: 6.6,
      catatan: 'Gambar ini adalah gambaran hasil Praktikum 1 Jobsheet, dibuat dari tiga berkas di folder aset/: ikon biasa, ikon adaptif yang sama setelah dipotong HP menjadi lingkaran dan persegi membulat, serta layar pembuka Android 12. Ikon bawaan Flutter membuat aplikasi terlihat "belum jadi".',
    });

    d.kode({
      judul: 'Semua Ukuran Ikon: flutter_launcher_icons',
      shell: true,
      kode: [
        '# flutter pub add dev:flutter_launcher_icons',
        '# di AKHIR pubspec.yaml, sejajar dengan flutter:',
        'flutter_launcher_icons:',
        '  android: true',
        '  ios: true',
        '  remove_alpha_ios: true',
        '  image_path: "assets/ikon/ikon_tugas_kuliahku.png"',
        '  adaptive_icon_background: "#673AB7"',
        '  adaptive_icon_foreground: "assets/ikon/ikon_tugas_kuliahku_latar_depan.png"',
        '  web:',
        '    generate: true',
        '    image_path: "assets/ikon/ikon_tugas_kuliahku.png"',
        '    background_color: "#673AB7"',
        '    theme_color: "#673AB7"',
        '',
        '# lalu: dart run flutter_launcher_icons',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.9,
      poin: [
        'Dev dependency: hanya dipakai saat pengembangan, tidak ikut ke aplikasi.',
        'Menulis ulang ikon di android/.../mipmap-*, ios/.../Assets.xcassets, dan web/. Lihat dengan git status.',
        'Ikon adaptif dibuat hanya jika background DAN foreground diisi; inset bawaan 16%.',
        'Ikon lama masih tampil? Hapus aplikasi dari HP; di Chrome: Ctrl + Shift + R.',
      ],
      catatan: 'Android, iPhone, dan web membutuhkan ikon dalam belasan ukuran; paket ini membuat semuanya dari satu gambar. adaptive_icon_foreground_inset bawaan 16: paket menambahkan ruang kosong 16% di sekeliling lapisan depan agar simbol tidak terpotong. Untuk themed icon Android 13+, tambahkan adaptive_icon_monochrome berisi gambar simbol satu warna (Modifikasi 3 Praktikum 1).',
    });

    d.kode({
      judul: 'Layar Pembuka: flutter_native_splash',
      shell: true,
      kode: [
        '# flutter pub add dev:flutter_native_splash',
        'flutter_native_splash:',
        '  color: "#673AB7"        # warna latar (mode terang)',
        '  color_dark: "#311B92"   # warna latar (mode gelap)',
        '  image: assets/ikon/ikon_tugas_kuliahku_latar_depan.png',
        '  android_12:',
        '    color: "#673AB7"',
        '    color_dark: "#311B92"',
        '    # 1152 x 1152, isi di lingkaran tengah 768 piksel',
        '    image: assets/ikon/layar_pembuka_android12.png',
        '',
        '# membuat:  dart run flutter_native_splash:create',
        '# kembali:  dart run flutter_native_splash:remove',
      ].join('\n'),
      ukuran: 12.5,
      lebarKode: 7.6,
      poin: [
        'Layar pembuka mengisi jeda sampai Flutter siap menggambar layar pertama.',
        'Android 12+: sistem SELALU menampilkan layar pembuka berisi ikon di tengah.',
        'Jangan membuat "layar pembuka palsu" yang menahan pengguna 3 detik demi logo.',
      ],
      catatan: 'Bawaan Flutter berupa layar putih polos. Paket ini mengatur warna dan gambar untuk Android, iPhone, dan web sekaligus. Batasan Android 12 menurut panduan paketnya: gambar dipotong menjadi lingkaran, layar pembuka tidak tampil jika aplikasi dibuka dari notifikasi, dan peluncur HP buatan selain Google kadang menampilkannya berbeda. Pengguna membuka aplikasi untuk memakainya, bukan untuk menonton logo.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 7', judul: 'Menangani Galat di Aplikasi Rilis', ikon: 'galat', catatan: 'Layar merah adalah bantuan untuk pengembang. Di build rilis, layar itu menjadi kotak abu-abu tanpa keterangan: pengguna bingung, dan Anda tidak pernah tahu galat itu terjadi.' });

    d.tabel({
      judul: 'Galat yang Diduga dan Galat yang Tidak Terduga',
      kepala: ['', 'Diduga (Exception)', 'Tidak terduga (Error, bug)'],
      lebarKolom: [2.2, 4.9, 5.0],
      baris: [
        ['Contoh', 'Internet putus, server menjawab 500, JSON rusak, izin ditolak', 'Null check operator used on a null value, indeks di luar batas, salah tipe'],
        ['Penyebab', 'Dunia luar', 'Kode kita sendiri'],
        ['Ditangani di', 'Tempatnya: try–catch di repository/ViewModel, lalu pesan ramah (P10–12)', 'Jaring pengaman di main(), lalu dicatat dan dikirim ke pengembang'],
        ['Tujuan', 'Pengguna tahu apa yang terjadi dan bisa mencoba lagi', 'Pengembang tahu ada bug dan memperbaikinya'],
      ],
      ukuran: 15.5,
      tinggiBaris: 0.85,
      pesan: 'Jaring pengaman BUKAN pengganti try–catch. Ia lapisan terakhir untuk galat yang lolos. Dua hal disiapkan: pengganti kotak abu-abu yang sopan, dan pencatat galat.',
      catatan: 'Panduan resmi Flutter menyebutkan bahwa di build rilis, layar merah berubah menjadi kotak abu-abu. Galat yang diduga sudah kita tangani sejak Pertemuan 10–12 (Hasil dan Kegagalan). Hari ini kita menambahkan lapisan terakhir untuk galat yang tidak terduga.',
    });

    d.kode({
      judul: 'Tiga Jaring Pengaman',
      kode: [
        'void mulaiAplikasi() {',
        '  WidgetsFlutterBinding.ensureInitialized();',
        '',
        '  // 1. Galat di dalam build, layout, dan paint.',
        '  FlutterError.onError = (FlutterErrorDetails rincian) {',
        '    FlutterError.presentError(rincian); // tetap di konsol',
        "    pelapor.catat(rincian.exception, rincian.stack, sumber: 'widget');",
        '  };',
        '',
        '  // 2. Galat asinkron yang lolos (Android, iOS, desktop).',
        '  PlatformDispatcher.instance.onError = (Object galat, StackTrace jejak) {',
        "    pelapor.catat(galat, jejak, sumber: 'async (platform)');",
        '    return true; // true = galat sudah ditangani',
        '  };',
        '',
        '  // 3. Pengganti kotak merah (debug) dan kotak abu-abu (rilis).',
        '  ErrorWidget.builder = (FlutterErrorDetails rincian) =>',
        '      KotakGalatRamah(rincian: rincian);',
        '',
        '  runApp(const AplikasiUjiGalat());',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.6,
      berkas: 'kode/contoh_03_menangani_galat_di_rilis.dart',
      poin: [
        'FlutterError.onError: galat saat membangun, menata, menggambar widget (misalnya nilai! yang null di build).',
        'PlatformDispatcher.instance.onError: Future gagal yang tidak di-await siapa pun.',
        'ErrorWidget.builder: bukan penangkap, melainkan PENGGANTI TAMPILAN widget yang gagal.',
        'Aplikasi sungguhan mengirim catatan ke Crashlytics atau Sentry, TANPA data pribadi.',
      ],
      catatan: 'PelaporGalat di Contoh 03 hanya menyimpan catatan di memori dan menampilkannya di layar. Aplikasi sungguhan mengirimnya ke layanan pelaporan seperti Firebase Crashlytics atau Sentry, sehingga pengembang menerima daftar galat dari HP semua pengguna, lengkap dengan stack trace-nya. Laporan galat dikirim ke server: jangan ikutkan nama, nomor HP, isi catatan, atau token; dan jika aplikasi mengirim laporan galat, hal itu wajib disebutkan di kebijakan privasi (Bagian 8.3).',
    });

    d.kode({
      judul: 'Di Web: Tambahkan runZonedGuarded',
      kode: [
        'void main() {',
        '  if (kIsWeb) {',
        '    // Semua kode di dalam runZonedGuarded berada di satu',
        '    // "zona". Galat asinkron yang tidak ditangkap di zona ini',
        '    // diteruskan ke fungsi kedua, alih-alih hilang di konsol',
        '    // browser.',
        '    runZonedGuarded(',
        '      mulaiAplikasi,',
        '      (Object galat, StackTrace jejak) =>',
        "          pelapor.catat(galat, jejak, sumber: 'async (zona web)'),",
        '    );',
        '  } else {',
        '    mulaiAplikasi();',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.6,
      poin: [
        'Saat kami menguji di DartPad, galat asinkron yang lolos TIDAK sampai ke PlatformDispatcher.instance.onError.',
        'Galat itu hanya muncul di konsol browser, jadi web memakai zona.',
        'ensureInitialized() dan runApp() harus di DALAM zona yang sama: keduanya ada di mulaiAplikasi().',
      ],
      catatan: 'Zona adalah ruang eksekusi Dart. runZonedGuarded menangkap galat asinkron yang lolos di dalamnya. Latihan B5 memperlihatkan urutan kerjanya: Future yang di-await di dalam try ditangkap catch; Future yang tidak di-await galatnya sampai ke fungsi kedua runZonedGuarded. Di Jobsheet Praktikum 2, fungsi jalankanDenganPengaman memasang zona hanya di web, dan memanggil _mulai langsung di platform lain.',
    });

    d.kode({
      judul: 'Pengganti Layar Merah yang Ramah',
      kode: [
        'class KotakGalatRamah extends StatelessWidget {',
        '  // ... constructor dan field rincian ...',
        '  @override',
        '  Widget build(BuildContext context) {',
        '    // Bisa muncul DI MANA SAJA (bahkan di atas MaterialApp),',
        '    // jadi Directionality dan Material disediakan sendiri.',
        '    return Directionality(',
        '      textDirection: TextDirection.ltr,',
        '      child: Material(',
        '        color: Colors.orange.shade50,',
        '        child: Column(',
        '          mainAxisSize: MainAxisSize.min,',
        '          children: [',
        "            const Text('Bagian ini gagal ditampilkan. '",
        "                'Laporan sudah dicatat.'),",
        '            // Rincian teknis hanya untuk pengembang.',
        '            if (kDebugMode) Text(rincian.exceptionAsString()),',
        '          ],',
        '        ),',
        '      ),',
        '    );',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.2,
      tinggiKode: 5.0,
      poin: [
        'Dipasang lewat ErrorWidget.builder: menggantikan kotak merah (debug) dan kotak abu-abu (rilis).',
        'Hanya BAGIAN yang gagal yang diganti; sisa layar tetap bisa dipakai.',
        'Rincian teknis hanya tampil saat kDebugMode.',
      ],
      catatan: 'Versi lengkapnya di modul Bagian 7.5 juga memuat ikon wajah sedih (Icons.sentiment_dissatisfied), Padding, dan warna teks; di slide diringkas. Di Jobsheet Praktikum 2, kotak ini dipasang di "Tugas Kuliahku", lalu diuji dengan bug buatan: hanya baris "Uji galat" yang berubah menjadi kotak oranye.',
    });

    d.layar({
      judul: 'Coba Sendiri: Contoh 03 "Uji Galat"',
      gambar: ['hasil_contoh_03a.jpg', 'hasil_contoh_03b.jpg'],
      berkas: 'kode/contoh_03_menangani_galat_di_rilis.dart',
      poin: [
        'Sakelar 1 "kartu yang rusak": kartu diganti kotak oranye, sisa layar normal → tercatat "widget".',
        'Picu: tidak terlihat oleh pengguna → "async (zona web)" (di HP Android: "async (platform)").',
        'Muat: SnackBar "Data gagal dibaca. Coba lagi nanti." → "ditangani".',
      ],
      ukuranPoin: 15,
      lebarMaks: 6.8,
      catatan: 'Satu hal kecil yang menarik: pesan galat tanda ! di web berbunyi "Unexpected null value.", sedangkan di Android dan VS Code berbunyi "Null check operator used on a null value". Galatnya sama, hanya kata-katanya yang berbeda per platform. Gambar kanan: setelah tombol Muat ditekan, catatan teratas berbunyi FormatException: JSON dari server rusak, ditangani.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 8', judul: 'Halaman Tentang, Kebijakan Privasi, dan Lisensi', ikon: 'privasi', catatan: 'Aplikasi yang dipakai orang lain wajib jujur tentang dirinya: versi berapa, datanya dari mana, data pengguna diapakan, dan kode siapa saja yang dipakai.' });

    d.tabel({
      judul: 'Empat Pertanyaan yang Wajib Dijawab Aplikasi',
      kepala: ['Pertanyaan', 'Mengapa', 'Jawabannya di'],
      lebarKolom: [3.1, 5.4, 3.6],
      baris: [
        ['Ini versi berapa?', 'Laporan bug tanpa nomor versi sulit ditindaklanjuti', 'Halaman Tentang (package_info_plus)'],
        ['Datanya dari mana?', 'Banyak penyedia data MEWAJIBKAN pencantuman sumber (Open-Meteo: CC BY 4.0; BMKG)', 'Atribusi di dekat data DAN di halaman Tentang'],
        ['Data saya diapakan?', 'Hak pengguna; diwajibkan Google Play untuk SEMUA aplikasi', 'Kebijakan privasi'],
        ['Kode siapa saja yang dipakai?', 'Lisensi sumber terbuka mewajibkan pemberitahuan lisensi', 'Halaman lisensi'],
      ],
      ukuran: 15.5,
      tinggiBaris: 0.85,
      pesan: 'Kebijakan privasi: siapa pengembangnya, data apa yang diakses/dikumpulkan/dibagikan, cara menjaganya, berapa lama disimpan dan cara menghapusnya. Di alamat web PUBLIK (bukan PDF) dan di dalam aplikasi.',
      catatan: 'Open-Meteo: data berlisensi CC BY 4.0, wajib mencantumkan tautan ke Open-Meteo di dekat setiap tempat data ditampilkan, misalnya "Weather data by Open-Meteo.com". Data Terbuka BMKG: wajib mencantumkan BMKG sebagai sumber. Kebijakan Google Play: semua aplikasi wajib mencantumkan tautan kebijakan privasi di Play Console, termasuk aplikasi yang tidak mengakses data pribadi sama sekali, dan wajib menyediakan tautan atau teksnya di dalam aplikasi. Kebijakan privasi harus jujur: jika aplikasi meminta izin lokasi, menulis "tidak mengumpulkan data apa pun" adalah pelanggaran. Kerangkanya ada di templat/KEBIJAKAN_PRIVASI.md.',
    });

    d.kode({
      judul: 'Lisensi Sumber Terbuka: Dikumpulkan Otomatis',
      kode: [
        'ListTile(',
        "  title: const Text('Lisensi sumber terbuka'),",
        '  onTap: () => showLicensePage(',
        '    context: context,',
        "    applicationName: 'Cuaca Kampus',",
        "    applicationVersion: '1.0.0',",
        "    applicationLegalese: '© 2026 Tim Cuaca Kampus',",
        '  ),',
        '),',
        '',
        '// Lisensi DATA (bukan paket Dart), di main():',
        'LicenseRegistry.addLicense(() async* {',
        '  yield const LicenseEntryWithLineBreaks(',
        "    ['Data cuaca Open-Meteo'],",
        "    'Data cuaca disediakan oleh Open-Meteo.com ... (CC BY 4.0).',",
        '  );',
        '});',
      ].join('\n'),
      ukuran: 12.5,
      lebarKode: 7.4,
      poin: [
        'Flutter, provider, http, dan paket di bawahnya: lisensi BSD, MIT, Apache mewajibkan teksnya disertakan.',
        'Saat build, Flutter otomatis MENGUMPULKAN lisensi semua paket; kita cukup menyediakan pintunya.',
        'Siap pakai: AboutListTile dan showAboutDialog.',
        'Di DartPad halaman lisensi tampil aneh (entri <!DOCTYPE html>); di proyek sungguhan rapi.',
      ],
      catatan: 'Lisensi data, misalnya data Open-Meteo atau huruf dari Google Fonts, tidak terkumpul otomatis, jadi ditambahkan sendiri dengan LicenseRegistry.addLicense. Di slide, ikon ListTile dan sebagian teks lisensi diwakili "..."; versi lengkapnya ada di modul Bagian 8.4. Di DartPad, berkas daftar lisensi yang biasanya dibuat saat build tidak ada, sehingga yang terbaca adalah halaman HTML. Judul halaman berbahasa Inggris ("Licenses") selama aplikasi belum diberi dukungan bahasa Indonesia lewat flutter_localizations.',
    });

    d.layar({
      judul: 'Coba Sendiri: Contoh 04 Halaman Tentang',
      gambar: ['hasil_contoh_04a.jpg', 'hasil_contoh_04b.jpg'],
      berkas: 'kode/contoh_04_halaman_tentang_dan_lisensi.dart',
      poin: [
        'Versi 1.0.0 (build 1), dengan penanda "mode debug" yang dibuang di build rilis.',
        'Sumber data Open-Meteo.com beserta lisensinya.',
        'Kebijakan privasi DI DALAM aplikasi: data yang dikumpulkan, disimpan, dan dikirim.',
        'Surel pengembang yang bisa disalin, dan halaman lisensi.',
      ],
      ukuranPoin: 15,
      lebarMaks: 6.8,
      catatan: 'Contoh 04 membuat halaman Tentang untuk "Cuaca Kampus" (Pertemuan 10). Gambar kanan: halaman Kebijakan Privasi berisi empat bagian: data yang dikumpulkan (tidak ada), data yang disimpan di perangkat (kota terakhir yang dipilih), data yang dikirim (koordinat kota ke Open-Meteo.com), dan pertanyaan (alamat surel tim). Di Jobsheet Praktikum 2, mahasiswa membuat halaman serupa untuk "Tugas Kuliahku".',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 9', judul: 'Rilis Web', ikon: 'web', catatan: 'Rilis web cukup dengan Flutter dan Chrome; tidak butuh Android SDK. Hasilnya bisa dibuka siapa saja dari HP maupun laptop, cukup dengan sebuah tautan.' });

    d.kode({
      judul: 'Membuat Berkas Rilis Web',
      shell: true,
      kode: [
        'flutter build web          # mode release',
        '',
        'build/web/',
        '├── index.html            ← halaman yang pertama dibuka',
        '├── flutter_bootstrap.js  ← pemuat aplikasi Flutter',
        '├── main.dart.js          ← kode Dart Anda, jadi JavaScript',
        '├── manifest.json         ← nama dan ikon saat "dipasang"',
        '├── version.json          ← nama aplikasi dan nomor versi',
        '├── favicon.png, icons/   ← ikon',
        '├── assets/               ← gambar, huruf, aset lain',
        '└── canvaskit/            ← mesin penggambar Flutter',
        '',
        '# mencoba di laptop (pasang sekali, lalu jalankan):',
        'dart pub global activate dhttpd',
        'dhttpd --path build/web    # buka http://localhost:8080',
      ].join('\n'),
      ukuran: 12.5,
      lebarKode: 7.6,
      poin: [
        'Seluruh isi folder diunggah BERSAMA-SAMA; tidak ada satu berkas "aplikasi.exe".',
        'Klik dua kali index.html TIDAK berhasil: browser tidak menjalankan aplikasi web dari file://.',
        'Uji build rilis: muat dan simpan data, tutup tab lalu buka lagi, mode gelap, jendela selebar HP.',
      ],
      catatan: 'Proyek tanpa dukungan web bisa ditambahi foldernya dengan flutter create . --platforms web. Hasil build harus dibuka lewat web server; Flutter sudah membawa Dart, jadi kita bisa memasang server kecil dhttpd sekali saja. Muncul "dhttpd is not recognized"? Jalankan dart pub global run dhttpd --path build/web; atau, jika Python terpasang, python -m http.server 8000 dari folder build/web. Hentikan server dengan Ctrl + C. Di sinilah bug yang tidak muncul saat flutter run biasanya ketahuan.',
    });

    d.kode({
      judul: 'Alamat Dasar (--base-href)',
      shell: true,
      kode: [
        '# GitHub Pages untuk satu repositori ada di SUB-FOLDER:',
        '#   https://budisantoso.github.io/tugas_kuliahku/',
        '#                                └─ nama repositori',
        '',
        'flutter build web --base-href "/tugas_kuliahku/"',
        '',
        '# web/index.html:  <base href="$FLUTTER_BASE_HREF">',
        '# Wajib diawali DAN diakhiri garis miring "/", jika tidak:',
        '#   --base-href should start and end with /',
      ].join('\n'),
      ukuran: 13.5,
      lebarKode: 7.6,
      poin: [
        'Aplikasi perlu tahu sub-foldernya agar bisa memuat main.dart.js dan assets/ dari tempat yang benar.',
        'Seperti alamat kos: "Jalan Mawar No. 5" belum cukup jika kamarnya di "Gang 3". Tanpa --base-href: layar PUTIH.',
        'Build ber-base-href TIDAK bisa dicoba dengan dhttpd --path build/web. Biarkan robot GitHub yang mem-build-nya.',
      ],
      catatan: 'Untuk mencoba di laptop, build tanpa --base-href. Untuk GitHub Pages, robot GitHub mem-build dengan --base-href (slide berikutnya). Modifikasi 1 Praktikum 3 meminta mahasiswa meniru keadaan GitHub Pages di laptop dengan folder coba/tugas_kuliahku/, lalu membaca galat 404 di konsol browser.',
    });

    d.kode({
      judul: 'Terbit Otomatis di GitHub Pages',
      shell: true,
      kode: [
        'on:',
        '  push:',
        '    branches: [main]',
        '  workflow_dispatch:',
        'jobs:',
        '  build:',
        '    runs-on: ubuntu-latest',
        '    steps:',
        '      # ... ambil kode, pasang Flutter, pub get ...',
        '      - name: Analisis dan tes',
        '        run: |',
        '          flutter analyze',
        '          flutter test',
        '      - name: Build web',
        '        env:',
        '          NAMA_REPO: ${{ github.event.repository.name }}',
        '        run: flutter build web --base-href "/$NAMA_REPO/"',
        '      - uses: actions/upload-pages-artifact@v4',
        '        with:',
        '          path: build/web',
        '  terbitkan:',
        '    needs: build',
        '    steps:',
        '      - uses: actions/deploy-pages@v4',
      ].join('\n'),
      ukuran: 9.5,
      lebarKode: 6.6,
      berkas: 'templat/web.yml',
      poin: [
        'Sekali saja: Settings → Pages → Source: GitHub Actions.',
        'Salin templat/web.yml ke .github/workflows/web.yml, lalu commit dan push.',
        'Tab Actions ✅ → situs di https://<akun>.github.io/<repositori>/',
        'analyze dan test dulu: jika gagal, situs TIDAK diperbarui.',
        'Job terbitkan butuh izin pages: write dan id-token: write, serta environment github-pages.',
      ],
      catatan: 'GitHub Pages gratis untuk repositori publik; repositori privat membutuhkan GitHub Pro, yang gratis bagi mahasiswa lewat GitHub Student Developer Pack. Isi lengkap web.yml ada di folder templat/; di slide, beberapa langkah diringkas menjadi komentar (ambil kode, pasang Flutter, pub get sama seperti tes.yml Pertemuan 14; izin pages: write dan id-token: write; environment github-pages yang menampilkan tautan situs). upload-pages-artifact mengemas folder build/web; deploy-pages menerbitkannya.',
    });

    d.tabel({
      judul: 'Hal yang Perlu Diperhatikan di Web',
      kepala: ['Hal', 'Penjelasan'],
      lebarKolom: [3.2, 8.9],
      baris: [
        ['CORS', 'Ada API yang menolak dipanggil dari browser (P10 Bagian 14.1). Uji versi web dengan data sungguhan'],
        ['SQLite di web (P11)', 'web/sqlite3.wasm dan web/sqflite_sw.js harus ikut di-commit: robot mem-build dari isi repositori'],
        ['Data per browser', 'shared_preferences dan SQLite web tersimpan di browser masing-masing; data localhost tidak pindah ke GitHub Pages'],
        ['Versi lama masih tampil', 'Salinan sementara (cache): muat ulang paksa Ctrl + Shift + R, atau tunggu beberapa menit'],
        ['Alamat halaman', 'Bawaan memakai # (.../#/detail), aman di GitHub Pages; usePathUrlStrategy() bisa berujung 404'],
        ['WebAssembly', 'flutter build web --wasm butuh header server khusus yang tidak bisa diatur di GitHub Pages; JavaScript biasa sudah cukup'],
        ['Source map', 'flutter build web --source-maps: berkas .map tidak boleh diterbitkan untuk umum'],
      ],
      ukuran: 14,
      tinggiBaris: 0.62,
      catatan: 'Selain GitHub Pages, ada layanan lain yang juga gratis untuk situs kecil, misalnya Firebase Hosting (firebase deploy). Pilih satu saja yang Anda pahami. Header server yang dibutuhkan WebAssembly untuk kinerja penuhnya: Cross-Origin-Embedder-Policy dan Cross-Origin-Opener-Policy.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 10–11', judul: 'Rilis Android: APK, Tanda Tangan, App Bundle', ikon: 'hp', catatan: 'Yang dibutuhkan: Android SDK (biasanya bersama Android Studio; flutter doctor bercentang di Android toolchain), lisensi SDK yang disetujui (flutter doctor --android-licenses), dan sebaiknya HP Android dengan USB debugging. Belum punya Android SDK? Minta robot GitHub mem-build APK (Bagian 12).' });

    d.kode({
      judul: 'Sebelum Build: Izin Internet',
      shell: true,
      kode: [
        '<!-- android/app/src/main/AndroidManifest.xml -->',
        '<manifest xmlns:android="http://schemas.android.com/apk/res/android">',
        '    <uses-permission android:name="android.permission.INTERNET" />',
        '    <application',
        '        android:label="Tugas Kuliahku"',
        '        ...',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.4,
      poin: [
        'Jebakan paling terkenal: lancar saat flutter run, tetapi APK rilis tidak bisa memuat apa pun.',
        'src/debug dan src/profile berisi izin internet (dibutuhkan hot reload dan debugger).',
        'src/main dipakai SEMUA mode, termasuk rilis, dan TIDAK berisi izin internet sampai Anda menambahkannya.',
        'Di dalam <manifest>, SEBELUM <application>.',
      ],
      catatan: 'Selama pengembangan, izin itu "dipinjami" oleh berkas debug. Di build rilis, pinjaman itu hilang. Sekalian periksa daftar ini sebelum build (Contoh 06 memeriksanya otomatis): izin internet dan izin lain yang benar-benar dipakai (kamera, lokasi); android:label rapi; applicationId bukan com.example; version di pubspec sudah dinaikkan; ikon dan layar pembuka sudah diganti; semua tes lulus dan flutter analyze bersih. Di Praktikum 4, Langkah 1 (izin internet) wajib untuk semua, karena APK buatan robot GitHub juga membutuhkannya.',
    });

    d.kode({
      judul: 'Membuat dan Memasang APK',
      shell: true,
      kode: [
        'flutter build apk',
        '# build/app/outputs/flutter-apk/app-release.apk',
        '#   semua jenis prosesor: paling besar',
        '',
        'flutter build apk --split-per-abi',
        '# app-armeabi-v7a-release.apk  ← HP lama (ARM 32-bit)',
        '# app-arm64-v8a-release.apk    ← hampir semua HP masa kini',
        '# app-x86_64-release.apk       ← emulator, sebagian kecil',
        '',
        'flutter install   # lewat kabel USB',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.4,
      poin: [
        'Kabel USB: flutter install. Jika aplikasinya sudah ada, versi lama DIHAPUS dulu beserta datanya.',
        'Kirim berkas (Drive, surel, aplikasi pesan): HP meminta izin "Pasang aplikasi tidak dikenal".',
        'GitHub Releases: unduh APK lewat browser HP, lalu ketuk (Bagian 12).',
        'Memperbarui: applicationId sama, TANDA TANGAN sama, nomor build tidak lebih kecil.',
      ],
      catatan: 'Bagikan app-arm64-v8a-release.apk untuk HP masa kini, atau app-release.apk jika tidak yakin. Build rilis Android selalu diperkecil oleh R8 (membuang kode Java/Kotlin yang tidak terpakai); menurut panduan resmi, opsi lama --no-shrink tidak berpengaruh lagi. Saat memasang dari berkas, Google Play Protect bisa memperingatkan karena aplikasinya bukan dari Play Store; untuk aplikasi buatan sendiri, ini wajar. Jika tanda tangannya berbeda, pemasangan gagal dengan pesan seperti "Aplikasi tidak terpasang karena paket bentrok dengan paket yang sudah ada". Penyebab tersering di kelas: APK lama di-build di laptop A, APK baru di laptop B. Mengapa? Jawabannya di Bagian 11.',
    });

    d.kartu({
      judul: 'Menguji Build Rilis di HP',
      pengantar: 'Jangan berhenti di "aplikasinya terbuka". Uji seperti pengguna:',
      kolom: 3,
      item: [
        { ikon: 'awan', judul: 'Data internet tampil', isi: 'Jika tidak, periksa izin internet (Bagian 10.2).' },
        { ikon: 'awanputus', judul: 'Mode pesawat', isi: 'Pesan galatnya ramah, data tersimpan tetap tampil.', warna: C.accent5 },
        { ikon: 'simpan', judul: 'Tutup lalu buka lagi', isi: 'Simpan data, tutup dari daftar aplikasi terbuka, buka lagi: datanya masih ada.' },
        { ikon: 'huruf', judul: 'Putar layar, huruf besar', isi: 'Perbesar ukuran huruf di pengaturan HP: tidak ada yang meluap.', warna: C.accent4 },
        { ikon: 'gelap', judul: 'Mode gelap', isi: 'Semua teks tetap terbaca.', warna: C.accent6 },
        { ikon: 'nomor', judul: 'Halaman Tentang', isi: 'Versi yang tampil sama dengan pubspec.yaml.' },
      ],
      catatan: 'Daftar ini juga menjadi persiapan demo UAS: penguji sering bertanya "kalau internetnya mati bagaimana?". Uji yang sama juga dilakukan untuk versi web dari HP (Praktikum 3 Langkah 6).',
    });

    d.statistik({
      judul: 'Kabar 2026–2027: Verifikasi Pengembang Android',
      item: [
        { ikon: 'jam', angka: '30 Sep 2026', label: 'Mulai berlaku di Indonesia dan tiga negara lain', warna: C.accent5 },
        { ikon: 'jelajah', angka: '2027', label: 'Diperluas ke seluruh dunia', warna: C.accent1 },
        { ikon: 'hp', angka: '20 HP', label: 'Akun distribusi terbatas: gratis, tanpa KTP', warna: C.accent4 },
      ],
      ukuranAngka: 38,
      pesan: 'Aplikasi yang dipasang lewat ADB (termasuk flutter install) tidak memerlukan verifikasi. Aturan ini masih bisa berubah: baca halaman resminya sebelum membagikan APK ke banyak orang.',
      sumber: 'Sumber: developer.android.com/developer-verification (dibaca Oktober 2026)',
      catatan: 'Menurut halaman resmi Android developer verification (dibaca Oktober 2026): mulai 30 September 2026, perlindungan berlaku bagi pengguna di Brasil, Indonesia, Singapura, dan Thailand yang memasang aplikasi dari toko aplikasi yang berpartisipasi; FAQ-nya menyebutkan bahwa aplikasi yang dipasang langsung dari berkas (sideload) belum terkena aturan tenggat ini. Pada 2027, verifikasi diperluas ke seluruh dunia untuk aplikasi di perangkat Android bersertifikat. Pelajar dan penghobi bisa memakai akun distribusi terbatas (limited distribution) untuk membagikan aplikasi ke paling banyak 20 perangkat.',
    });

    d.tabel({
      judul: 'Tanda Tangan Digital: Tiga Kunci',
      pengantar: 'Setiap APK WAJIB ditandatangani, ibarat segel pabrik. Pembaruan dengan segel berbeda DITOLAK Android.',
      kepala: ['Kunci', 'Dibuat oleh', 'Dipakai untuk', 'Jika hilang'],
      lebarKolom: [2.9, 2.7, 3.6, 2.9],
      baris: [
        ['Kunci debug', 'Otomatis, di SETIAP laptop', 'Pengembangan dan APK untuk mencoba', 'Tidak apa-apa, dibuat lagi'],
        ['Kunci unggah (upload key)', 'ANDA', 'Menandatangani berkas yang diunggah ke Google Play', 'Bisa diganti lewat Play Console, setelah dikonfirmasi Google'],
        ['Kunci penandatangan aplikasi (app signing key)', 'Disimpan Google lewat Play App Signing', 'Menandatangani aplikasi yang diterima HP pengguna', 'Dijaga Google'],
      ],
      ukuran: 14.5,
      tinggiBaris: 0.92,
      pesan: 'Di luar Google Play (misalnya GitHub Releases), kunci buatan Anda sendirilah yang sampai ke HP pengguna. Kunci hilang = tidak akan pernah bisa menerbitkan pembaruan.',
      catatan: 'Sejauh ini Anda belum pernah mengurus tanda tangan, karena build.gradle.kts bawaan memakai kunci debug: signingConfig = signingConfigs.getByName("debug") dengan komentar TODO dari Flutter. Kunci debug dibuat otomatis di setiap laptop, jadi isinya berbeda di laptop A, laptop B, dan robot GitHub. Itulah penyebab gagal memperbarui di Bagian 10.4. Segel inilah yang melindungi pengguna: orang lain tidak bisa membuat APK palsu yang "memperbarui" aplikasi bank Anda. Jika kunci hilang, pengguna terpaksa menghapus aplikasi lama, termasuk datanya.',
    });

    d.kode({
      judul: 'Membuat Kunci Unggah dengan keytool',
      shell: true,
      kode: [
        '# Windows (PowerShell)',
        'keytool -genkey -v -keystore $env:USERPROFILE\\upload-keystore.jks `',
        '        -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 `',
        '        -alias upload',
        '',
        '# macOS / Linux',
        'keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \\',
        '        -storetype JKS -keysize 2048 -validity 10000 -alias upload',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.9,
      poin: [
        'Ditanya: kata sandi (dua kali, tidak terlihat), nama, unit, organisasi, kota, provinsi, kode negara ID, lalu yes.',
        'Hasil: upload-keystore.jks di folder pengguna, DI LUAR folder proyek.',
        '-alias upload: nama kunci di dalam berkas; -validity 10000: ± 27 tahun.',
        'keytool is not recognized? flutter doctor -v → "Java binary at:"; keytool ada di folder yang sama.',
      ],
      catatan: 'keytool ikut terpasang bersama Java di Android Studio; perintahnya dari panduan resmi Flutter. -keyalg RSA -keysize 2048 adalah jenis dan kekuatan kunci. Di PowerShell, panggil dengan alamat lengkapnya jika perlu, misalnya & "C:\\Program Files\\Android\\Android Studio\\jbr\\bin\\keytool.exe" .... Simpan kata sandinya di pengelola kata sandi, bukan di proyek.',
    });

    d.kode({
      judul: 'Memberi Tahu Gradle (1): key.properties',
      kode: [
        '// android/key.properties (tanpa tanda < >)',
        '//   storePassword=<kata sandi>',
        '//   keyPassword=<kata sandi>',
        '//   keyAlias=upload',
        '//   storeFile=C:\\\\Users\\\\budi\\\\upload-keystore.jks',
        '',
        '// android/app/build.gradle.kts',
        'import java.util.Properties     // baris PALING ATAS',
        'import java.io.FileInputStream',
        '',
        'plugins {',
        '    // ... biarkan seperti semula ...',
        '}',
        '',
        '// Baca key.properties JIKA ada.',
        'val keystoreProperties = Properties()',
        'val keystorePropertiesFile = rootProject.file("key.properties")',
        'if (keystorePropertiesFile.exists()) {',
        '    keystoreProperties.load(FileInputStream(keystorePropertiesFile))',
        '}',
        '',
        'android {',
        '    // ... isi bawaan ...',
      ].join('\n'),
      ukuran: 10.5,
      lebarKode: 7.4,
      poin: [
        'Di Windows, garis miring terbalik ditulis DUA KALI.',
        'Urutan wajib: import di baris paling atas, lalu plugins, lalu kode val ..., baru android {.',
        'Di Gradle berbahasa Kotlin, blok plugins harus di awal berkas; di atasnya hanya boleh import (dan komentar).',
        'Di laptop teman atau robot GitHub, key.properties tidak ada: build tetap berjalan dengan kunci debug.',
      ],
      catatan: 'Isi key.properties ditulis di slide sebagai komentar agar terbaca; di berkas aslinya tanpa tanda // . Di macOS atau Linux, baris terakhirnya misalnya storeFile=/Users/<nama pengguna>/upload-keystore.jks. Kode pembaca key.properties diambil dari panduan resmi Flutter.',
    });

    d.kode({
      judul: 'Memberi Tahu Gradle (2): signingConfigs',
      kode: [
        '// di dalam android { ... }, menggantikan buildTypes bawaan',
        'signingConfigs {',
        '    create("release") {',
        '        keyAlias = keystoreProperties.getProperty("keyAlias")',
        '        keyPassword = keystoreProperties.getProperty("keyPassword")',
        '        storeFile = keystoreProperties.getProperty("storeFile")',
        '            ?.let { file(it) }',
        '        storePassword = keystoreProperties.getProperty("storePassword")',
        '    }',
        '}',
        'buildTypes {',
        '    release {',
        '        // Kunci unggah jika key.properties ada, kunci debug jika tidak.',
        '        signingConfig = if (keystorePropertiesFile.exists()) {',
        '            signingConfigs.getByName("release")',
        '        } else {',
        '            signingConfigs.getByName("debug")',
        '        }',
        '    }',
        '}',
      ].join('\n'),
      ukuran: 10.5,
      lebarKode: 7.6,
      poin: [
        'signingConfigs dan pembaca key.properties: dari panduan resmi Flutter.',
        'Tambahan kita hanya if–else di buildTypes.',
        'Tanpa if–else, setiap orang tanpa key.properties (teman, dosen, robot GitHub) GAGAL mem-build.',
        'Build aneh setelah Gradle diubah? flutter clean, lalu build ulang.',
      ],
      catatan: 'Di slide, ekspresi storeFile dipecah dua baris agar muat (di modul satu baris: storeFile = keystoreProperties.getProperty("storeFile")?.let { file(it) }). Kesalahan umum: signingConfig selalu memakai "release" tanpa if–else, sehingga robot GitHub di Praktikum 5 gagal mem-build dengan pesan yang menyebut keystore atau signing config.',
    });

    d.kode({
      judul: 'Menjaga Kunci: Dua Aturan Mutlak',
      shell: true,
      kode: [
        '# android/.gitignore bawaan flutter create:',
        '# Remember to never publicly share your keystore.',
        '# See https://flutter.dev/to/reference-keystore',
        'key.properties',
        '**/*.keystore',
        '**/*.jks',
        '',
        '# periksa:',
        'git status',
        'git check-ignore -v android/key.properties',
        '# → baris yang menyebut android/.gitignore = aman',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.2,
      poin: [
        '1. JANGAN PERNAH meng-commit kunci: key.properties dan .jks tidak boleh muncul di git status.',
        '2. Simpan CADANGAN: .jks di dua tempat (flashdisk, cloud pribadi); kata sandi di password manager.',
        'Kunci yang hilang tidak bisa dibuat ulang: kunci baru adalah segel yang BERBEDA.',
        'Kunci yang terlanjur di-push dianggap BOCOR, walaupun commit-nya dihapus.',
      ],
      catatan: 'Kunci yang terlanjur di-push harus dianggap bocor, karena riwayat Git dan salinan orang lain masih menyimpannya. Buat kunci baru, dan jika aplikasi sudah di Google Play, minta penggantian kunci unggah lewat Play Console. Aturan rahasia di jobsheet: key.properties dan *.jks tidak pernah di-commit, tidak dikirim ke grup kelas, dan tidak ditempel ke asisten AI.',
    });

    d.tabel({
      judul: 'App Bundle (.aab) untuk Google Play',
      pengantar: 'flutter build appbundle → build/app/outputs/bundle/release/app-release.aab',
      kepala: ['', 'APK', 'App Bundle (AAB)'],
      lebarKolom: [3.6, 3.9, 4.6],
      baris: [
        ['Bisa langsung dipasang di HP?', 'Ya', 'TIDAK: diolah dulu oleh Google Play atau bundletool'],
        ['Untuk', 'Dibagikan langsung, GitHub Releases', 'Diunggah ke Google Play (aplikasi baru wajib AAB)'],
        ['Ukuran yang diunduh pengguna', 'Seluruh isi berkas', 'Hanya bagian yang dibutuhkan HP-nya'],
      ],
      ukuran: 16,
      tinggiBaris: 0.85,
      pesan: 'Sudah bertanda tangan kunci Anda? Dari folder android/: ./gradlew signingReport (Windows: .\\gradlew signingReport) → Variant: release, Store: upload-keystore.jks, Alias: upload.',
      catatan: 'App Bundle berisi semua bagian aplikasi untuk semua jenis HP. Google Play lalu meracik APK yang pas untuk setiap HP pengguna (jenis prosesor, kerapatan layar, bahasa), sehingga unduhan pengguna lebih kecil. signingReport dijalankan setelah pernah menjalankan flutter build; cari laporan untuk modul :app.',
    });

    d.kode({
      judul: 'Menyamarkan Kode (Obfuscation)',
      shell: true,
      kode: [
        'flutter build apk --obfuscate --split-debug-info=build/simbol',
        '',
        '# stack trace dari HP pengguna kini berisi nama acak.',
        '# menerjemahkannya kembali dengan berkas simbol build yang sama:',
        'flutter symbolize -i stack_trace.txt \\',
        '  -d build/simbol/app.android-arm64.symbols',
      ].join('\n'),
      ukuran: 12.5,
      lebarKode: 7.6,
      poin: [
        '--obfuscate: nama kelas dan fungsi diganti nama acak; kode lebih sulit dibaca pembongkar APK.',
        '--split-debug-info: informasi debug dipisah, APK lebih kecil.',
        'Simpan folder simbol untuk SETIAP rilis, tetapi jangan di-commit.',
        'Penyamaran BUKAN pengaman: rahasia tetap tidak boleh di aplikasi.',
      ],
      catatan: 'Panduan resmi juga mengingatkan bahwa kode yang bergantung pada nama, seperti runtimeType.toString(), akan berubah hasilnya. Untuk web, penyamaran tidak berlaku, karena build rilis web sudah diperkecil. Modifikasi 4 Praktikum 4 (tantangan) meminta mahasiswa membandingkan ukuran APK dan menjelaskan isi folder build/simbol.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 12', judul: 'Rilis Otomatis dengan GitHub', ikon: 'sinkron', catatan: 'Perjalanan rilis diulang setiap ada perbaikan. Karena itu langkahnya dibuat otomatis: cukup push tag versi, robot GitHub menguji, mem-build APK, dan membuat halaman rilis.' });

    d.kode({
      judul: 'Tag: Penanda Versi di Riwayat Git',
      shell: true,
      kode: [
        'git tag -a v1.0.0 -m "Rilis 1.0.0: versi pertama untuk UAS"',
        'git push origin v1.0.0',
        '',
        'git tag      # melihat daftar tag',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.4,
      poin: [
        'Tag: pembatas buku pada satu commit, "di sinilah versi 1.0.0". Nama: v + nama versi.',
        'git push biasa TIDAK ikut mengirim tag.',
        'Urutan yang benar: naikkan version: di pubspec.yaml → commit → push → buat tag → push tag.',
        'Nama tag sebaiknya sama dengan nama versi di pubspec.yaml.',
      ],
      catatan: 'git tag -a membuat tag beranotasi pada commit terakhir, lengkap dengan pesannya. Modifikasi 2 Praktikum 5 memperlihatkan akibat tag yang tidak sama dengan pubspec.yaml: halaman rilis menyebut v1.0.2, tetapi halaman Tentang menulis versi lama.',
    });

    d.kode({
      judul: 'Robot yang Mem-build APK dan Membuat Halaman Rilis',
      shell: true,
      kode: [
        'on:',
        '  push:',
        '    tags:',
        "      - 'v*'",
        'permissions:',
        '  contents: write  # untuk membuat halaman rilis',
        'jobs:',
        '  rilis:',
        '    runs-on: ubuntu-latest',
        '    steps:',
        '      # ... ambil kode, pasang Flutter, pub get, analyze, test ...',
        '      - name: Build APK',
        '        run: flutter build apk --release',
        '      - name: Terbitkan rilis di GitHub',
        '        env:',
        '          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}',
        '          TAG: ${{ github.ref_name }}',
        '          NAMA_REPO: ${{ github.event.repository.name }}',
        '        run: |',
        '          cp build/app/outputs/flutter-apk/app-release.apk \\',
        '            "$NAMA_REPO-$TAG.apk"',
        '          gh release create "$TAG" "$NAMA_REPO-$TAG.apk" \\',
        '            --title "$TAG" --generate-notes',
      ].join('\n'),
      ukuran: 10,
      lebarKode: 6.8,
      berkas: 'templat/rilis.yml',
      poin: [
        "tags: 'v*': hanya saat tag versi di-push.",
        'GITHUB_TOKEN: "kartu akses" otomatis dari GitHub.',
        'gh release create: GitHub CLI; --generate-notes membuat catatan rilis.',
        'APK robot bertanda tangan kunci debug ROBOT: untuk demo dan penilaian.',
      ],
      catatan: 'Di slide, perintah cp dan gh release create dipotong dengan garis miring terbalik (lanjutan baris shell) agar muat; di templat masing-masing ditulis satu baris. Salin templat/rilis.yml ke .github/workflows/rilis.yml. Setiap kali tag berawalan v di-push, robot menjalankan flutter analyze dan flutter test, mem-build APK, lalu membuat halaman Release bernama sama dengan tag dan menempelkan APK-nya. Nilai dari GitHub dititipkan lewat env, bukan ditempel langsung di perintah: kebiasaan aman di GitHub Actions. Hasilnya di https://github.com/<akun>/<repositori>/releases; tautan .../releases/latest selalu menuju rilis terbaru, cocok ditaruh di README.md. Kunci debug robot berbeda setiap kali robot bekerja: pengguna yang ingin memperbarui harus menghapus versi lama dulu. Agar robot tidak gagal mem-build, build.gradle.kts harus memakai pola "kunci rilis jika ada, kunci debug jika tidak" (Bagian 11.4). Tanpa robot, rilis bisa dibuat lewat web: Releases → Draft a new release → Choose a tag v1.0.0 → Create new tag → isi catatan (salin dari CHANGELOG.md) → seret APK ke Attach binaries → Publish release.',
    });

    d.kode({
      judul: '(Lanjutan) Robot Menandatangani dengan Kunci Unggah',
      shell: true,
      kode: [
        '# 1. berkas kunci → teks base64',
        '#    Linux: base64 -w 0 ~/upload-keystore.jks',
        '# 2. Settings → Secrets and variables → Actions:',
        '#    KUNCI_UNGGAH_BASE64 dan KUNCI_PROPERTIES',
        '#    (storeFile=upload-keystore.jks)',
        '# 3. rilis.yml: hapus tanda # pada langkah ini',
        '- name: Pasang kunci unggah',
        '  env:',
        '    KUNCI_UNGGAH_BASE64: ${{ secrets.KUNCI_UNGGAH_BASE64 }}',
        '    KUNCI_PROPERTIES: ${{ secrets.KUNCI_PROPERTIES }}',
        '  run: |',
        '    echo "$KUNCI_UNGGAH_BASE64" | base64 --decode \\',
        '      > android/app/upload-keystore.jks',
        '    echo "$KUNCI_PROPERTIES" > android/key.properties',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.4,
      poin: [
        'Secrets: dibaca workflow, tetapi tidak bisa dilihat siapa pun, termasuk Anda.',
        'storeFile tanpa folder, karena file(...) mencari relatif terhadap android/app/.',
        'Rahasia tidak pernah dicetak ke log; GitHub tidak memberi secrets ke pull request dari fork.',
      ],
      catatan: 'Di slide, perintah echo pertama dipotong dengan garis miring terbalik agar muat (di modul satu baris). Kunci tidak boleh masuk repositori, tetapi robot membutuhkannya. Mengubah berkas kunci menjadi teks base64: Windows (PowerShell) [Convert]::ToBase64String([IO.File]::ReadAllBytes("$env:USERPROFILE\\upload-keystore.jks")) | Set-Clipboard; macOS base64 -i ~/upload-keystore.jks | pbcopy; Linux base64 -w 0 ~/upload-keystore.jks. KUNCI_PROPERTIES berisi isi key.properties, tetapi baris terakhirnya storeFile=upload-keystore.jks. Langkah ini menulis kembali kedua berkas di robot, tepat sebelum build. Dengan cara ini, APK dari robot dan dari laptop bertanda tangan sama, sehingga pembaruan bisa dipasang tanpa menghapus aplikasi (Modifikasi 3 Praktikum 5).',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 13', judul: 'Cek Pembaruan untuk Aplikasi di Luar Toko', ikon: 'lonceng', catatan: 'Aplikasi dari Google Play diperbarui otomatis. Aplikasi yang dipasang dari berkas APK TIDAK: pengguna terus memakai versi lama. Lebih gawat lagi jika versi lama sudah tidak cocok dengan server, misalnya karena format datanya berubah.' });

    d.kode({
      judul: 'Polanya: Berkas Kecil Berisi Versi Terbaru',
      kode: [
        '// info_rilis.json (misalnya di repositori GitHub Anda):',
        '// {',
        '//   "versi_terbaru": "1.1.0",',
        '//   "versi_minimum": "1.0.0",',
        '//   "catatan": "...",',
        '//   "tautan": "https://github.com/..."',
        '// }',
        '',
        'Keputusan putuskanPembaruan({',
        '  required Versi terpasang,',
        '  required Versi terbaru,',
        '  required Versi minimum,',
        '}) {',
        '  if (terpasang.lebihLamaDari(minimum)) return Keputusan.wajib;',
        '  if (terpasang.lebihLamaDari(terbaru)) return Keputusan.disarankan;',
        '  return Keputusan.terbaru;',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.6,
      poin: [
        'Saat dibuka, aplikasi mengambil berkas itu dan membandingkannya dengan versinya sendiri (aturan Contoh 01).',
        'terbaru: tidak ada apa-apa.',
        'disarankan: MaterialBanner dengan tombol Nanti dan Perbarui.',
        'wajib: dialog yang TIDAK BISA DITUTUP: barrierDismissible: false + PopScope(canPop: false).',
      ],
      catatan: 'Berkas data/info_rilis_cuaca_kampus.json sungguhan ada di repositori mata kuliah ini dan dibaca oleh Contoh 07. Contoh tabel keputusan dari modul (server: terbaru 1.3.0, minimum 1.2.0): terpasang 1.3.0 → terbaru; 1.2.4 → disarankan; 1.1.9 → wajib. Alternatif tanpa membuat berkas sendiri: https://api.github.com/repos/<akun>/<repositori>/releases/latest mengembalikan JSON berisi tag_name dan html_url rilis terbaru; alamat ini dibatasi jumlah permintaannya untuk pengguna tanpa akun, jadi periksa sekali saja saat aplikasi dibuka (Latihan D3). Untuk aplikasi di Google Play ada fitur resmi in-app updates.',
    });

    d.kode({
      judul: 'Aturan Emas: Jangan Menghalangi Pengguna',
      kode: [
        '/// null = gagal memeriksa. Sengaja TIDAK melempar galat:',
        '/// cek pembaruan hanyalah fitur tambahan.',
        'Future<InfoRilis?> ambil() async {',
        '  try {',
        '    final http.Response respons = await _klien',
        '        .get(alamat)',
        '        .timeout(const Duration(seconds: 5));',
        '    if (respons.statusCode != 200) {',
        "      throw http.ClientException('kode status \${respons.statusCode}');",
        '    }',
        '    return InfoRilis.dariJson(jsonDecode(respons.body));',
        '  } on Exception catch (galat) {',
        "    if (kDebugMode) debugPrint('Cek pembaruan gagal: \$galat');",
        '    return null;',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.8,
      poin: [
        'Server mati, internet putus, atau JSON rusak: aplikasi TETAP bisa dipakai seperti biasa.',
        'Batas waktu 5 detik: pengguna tidak menunggu lama hanya karena server info rilis lambat.',
        'Log hanya di mode debug.',
      ],
      catatan: 'Latihan C3 berisi kebalikannya: ambil() yang melempar galat tanpa ditangkap dan tanpa batas waktu, sehingga tulisan "Memeriksa pembaruan ..." tidak pernah berganti saat server mati, dan dialog wajib yang bisa ditutup dengan mengetuk di luar dialog.',
    });

    d.layar({
      judul: 'Coba Sendiri: Contoh 05 "Jadwal Kuliah"',
      gambar: ['hasil_contoh_05a.jpg', 'hasil_contoh_05b.jpg'],
      berkas: 'kode/contoh_05_cek_pembaruan.dart',
      poin: [
        'Server palsu (MockClient, P10); skenario dipilih lewat ikon server di pojok kanan atas.',
        'Belum ada versi baru → tidak ada apa-apa. Ada versi 1.3.0 → banner.',
        'Versi minimum naik ke 1.3.0 → dialog wajib.',
        'Server mati (503) atau JSON rusak → "Gagal memeriksa. Aplikasi tetap bisa dipakai."',
      ],
      ukuranPoin: 15,
      lebarMaks: 6.8,
      catatan: 'Gambar kiri: MaterialBanner "Versi 1.3.0 tersedia" dengan tombol Nanti dan Perbarui; di bawahnya versi terpasang 1.2.4 (build 10), skenario server, keputusan disarankan, dan tombol Periksa lagi. Gambar kanan: dialog "Perbarui aplikasi" di atas layar yang digelapkan, dengan satu tombol Perbarui sekarang.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 14–15', judul: 'Ukuran, Kecepatan, Keamanan, dan Toko Aplikasi', ikon: 'ukur', catatan: 'Pemeriksaan terakhir sebelum rilis, lalu gambaran jalur toko aplikasi. Bagian 15 tidak wajib dipraktikkan di mata kuliah ini.' });

    d.tabel({
      judul: 'Ukuran dan Kecepatan',
      kepala: ['Masalah', 'Cara memeriksa atau memperbaiki'],
      lebarKolom: [4.8, 7.3],
      baris: [
        ['Menilai ukuran dari flutter run', 'Build debug memang besar. Ukur dari build rilis: flutter build apk --analyze-size --target-platform=android-arm64, lalu DevTools → App Size'],
        ['Unduhan besar', '--split-per-abi atau App Bundle; --split-debug-info; kompres gambar; hapus aset dan paket yang tidak dipakai'],
        ['"Aplikasi saya lambat"', 'Jangan menilai dari mode debug. Ukur: flutter run --profile di HP sungguhan + DevTools → Performance'],
        ['Daftar panjang dengan ListView(children: [...])', 'ListView.builder (Pertemuan 6)'],
        ['Pekerjaan berat di build() (mengurutkan ribuan data, mengurai JSON)', 'Pindahkan ke ViewModel, lakukan sekali saja'],
        ['Gambar internet jauh lebih besar daripada tampilannya', 'Minta ukuran kecil dari server, atau cacheWidth pada Image.network'],
        ['Widget yang tidak pernah berubah ikut dibuat ulang', 'Tambahkan const di depannya'],
      ],
      ukuran: 13.5,
      tinggiBaris: 0.66,
      catatan: 'Panduan resmi Flutter menyebutkan bahwa build debug berukuran besar karena membawa alat hot reload dan debugging. --analyze-size mencetak ringkasan ukuran per bagian dan menulis berkas *-code-size-analysis_*.json yang bisa dibuka di DevTools → App Size. Gambar PNG/JPG berukuran besar adalah penyebab tersering aplikasi yang membengkak. Modifikasi 3 Praktikum 4 meminta mahasiswa menyebutkan tiga bagian terbesar aplikasinya.',
    });

    d.banding({
      judul: 'Keamanan: Lakukan dan Hindari',
      kolom: [
        {
          ikon: 'perisai', judul: 'Lakukan', warna: C.accent4, sorot: true,
          poin: [
            'Hanya memakai https://',
            'Meminta izin seperlunya',
            'Rahasia disimpan di server',
            'Data sensitif di flutter_secure_storage',
            'Memeriksa paket usang: flutter pub outdated',
            'Mengabaikan key.properties dan *.jks di Git',
          ],
        },
        {
          ikon: 'peringatan', judul: 'Hindari', warna: C.accent5,
          poin: [
            'http:// tanpa enkripsi (diblokir bawaan sejak Android 9)',
            'Izin lokasi/kamera yang tidak dipakai, terutama sisa percobaan',
            'Kunci API rahasia di aplikasi, walaupun lewat --dart-define atau disamarkan',
            'Token masuk di shared_preferences',
            'Paket lama yang tidak pernah diperbarui',
            'Kunci unggah ikut ter-commit',
          ],
        },
      ],
      ukuranPoin: 16,
      catatan: 'Tabel ini meringkas modul Bagian 14.3. Izin yang tidak dipakai juga harus dibuang karena kebijakan privasi wajib jujur: izin yang diminta harus dijelaskan (Bagian 8.3, Pertemuan 13).',
    });

    d.tabel({
      judul: 'Google Play (Gambaran)',
      kepala: ['Hal', 'Keterangan'],
      lebarKolom: [3.4, 8.7],
      baris: [
        ['Akun pengembang', 'Biaya pendaftaran US$25, sekali bayar'],
        ['Berkas yang diunggah', 'App Bundle (.aab), ditandatangani kunci unggah'],
        ['Akun pribadi baru', 'Dibuat setelah 13 November 2023: uji tertutup minimal 12 penguji selama 14 hari berturut-turut sebelum rilis publik'],
        ['Target versi Android', 'Sejak 31 Agustus 2026: Android 16 (API 36) atau lebih baru (targetSdk = flutter.targetSdkVersion)'],
        ['Kebijakan privasi, Data safety', 'Wajib untuk SEMUA aplikasi; formulir data yang dikumpulkan dan dibagikan'],
        ['Halaman toko', 'Nama maks. 30 karakter, deskripsi singkat 80, lengkap 4.000; ikon, grafik fitur, tangkapan layar'],
        ['Peninjauan', 'Setiap rilis ditinjau Google sebelum tampil di toko'],
      ],
      ukuran: 13,
      tinggiBaris: 0.52,
      pesan: 'Urutan di Play Console: buat aplikasi → App content → halaman toko → unggah .aab ke pengujian internal → uji tertutup → produksi.',
      catatan: 'Angka dan aturan dibaca dari halaman resmi pada Oktober 2026 dan bisa berubah. App content berisi kebijakan privasi, Data safety, rating konten, dan target usia. Dengan Play App Signing, kunci penandatangan aplikasi disimpan Google; Anda cukup menjaga kunci unggah, dan kunci unggah yang hilang masih bisa diganti. App Store (iPhone): butuh Mac dengan Xcode, Apple Developer Program US$99 per tahun, Bundle ID didaftarkan lalu dibuat catatan aplikasinya di App Store Connect, flutter build ipa (hasil di build/ios/ipa/), unggah lewat aplikasi Transporter, Xcode, atau xcrun altool, uji coba lewat TestFlight, dan ditinjau sesuai App Review Guidelines.',
    });

    d.tabel({
      judul: 'Membandingkan Jalur Rilis',
      kepala: ['', 'GitHub Pages (web)', 'GitHub Releases (APK)', 'Google Play', 'App Store'],
      lebarKolom: [2.6, 2.5, 2.5, 2.2, 2.3],
      baris: [
        ['Biaya', 'Gratis', 'Gratis', 'US$25 sekali', 'US$99 per tahun'],
        ['Perangkat pengguna', 'Semua yang punya browser', 'Android', 'Android', 'iPhone, iPad'],
        ['Pembaruan', 'Otomatis saat situs dibuka', 'Manual (Bagian 13)', 'Otomatis', 'Otomatis'],
        ['Peninjauan', 'Tidak ada', 'Tidak ada', 'Ada', 'Ada'],
        ['Fitur perangkat', 'Terbatas, lewat izin browser', 'Penuh', 'Penuh', 'Penuh'],
        ['Cocok untuk', 'Demo, proyek akhir, portofolio', 'Demo dan penilaian di HP', 'Aplikasi untuk umum', 'Aplikasi untuk umum'],
      ],
      ukuran: 14.5,
      tinggiBaris: 0.7,
      catatan: 'Tabel ini menjawab pertanyaan "jalur mana untuk proyek akhir?": web untuk demo dan portofolio (dibuka dari mana saja), APK untuk demo dan penilaian di HP (fitur perangkat penuh). Keduanya gratis dan tanpa peninjauan. Fitur kamera dan lokasi di web terbatas pada izin browser, jadi aplikasi yang memakai fitur perangkat sebaiknya juga punya APK.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 16', judul: 'Studi Kasus: "Cuaca Kampus 1.0.0"', ikon: 'cuaca', catatan: 'Contoh 07 mengambil aplikasi "Cuaca Kampus" dari Pertemuan 10, lalu menyiapkannya untuk rilis. Fiturnya tidak bertambah satu pun.' });

    d.tabel({
      judul: 'Dari Pertemuan 10 ke Rilis 1.0.0',
      kepala: ['Pertemuan 10', 'Rilis 1.0.0', 'Bagian'],
      lebarKolom: [4.3, 6.6, 1.2],
      baris: [
        ['jalankanUji() setiap aplikasi dibuka', 'Dihapus; tes tinggal di folder test/ (P14)', '—'],
        ['Selalu memakai Open-Meteo', 'LINGKUNGAN=produksi: Open-Meteo; pengembangan: data palsu + pita "BUILD UJI"', '3'],
        [kode("debugPrint('GET \$alamat')", 13), 'catatDebug(...): hilang dari build rilis', '2.2'],
        ['Galat apa pun hanya ditampilkan sebagai pesan', 'Exception → pesan ramah; Error (bug) → pesan ramah DAN dilaporkan', '7.2'],
        ['Tidak ada jaring pengaman', 'FlutterError.onError, PlatformDispatcher, zona di web, ErrorWidget.builder', '7'],
        ['Atribusi di bawah daftar', 'Juga di halaman Tentang, plus lisensi data', '8'],
        ['Tidak ada halaman Tentang', 'Versi, sumber data, ringkasan privasi, lisensi', '8'],
        ['Tidak tahu ada versi baru', 'Cek pembaruan dari data/info_rilis_cuaca_kampus.json', '13'],
      ],
      ukuran: 13.5,
      tinggiBaris: 0.58,
      catatan: 'Inilah pola rilis untuk proyek akhir: fitur tetap, yang bertambah adalah hal-hal yang dibutuhkan aplikasi yang dipakai orang lain. Bandingkan dengan jobsheet: "Tugas Kuliahku" mengalami perubahan yang sama di Praktikum 1–5.',
    });

    d.kode({
      judul: 'Pilihan Implementasi Tetap di Satu Tempat',
      kode: [
        'List<SingleChildWidget> buatPenyedia(Konfigurasi konfigurasi) {',
        '  return [',
        '    Provider<Konfigurasi>.value(value: konfigurasi),',
        '    ...switch (konfigurasi.lingkungan) {',
        '      Lingkungan.produksi => [',
        '        // ... LayananOpenMeteo, RepositoriCuacaOpenMeteo ...',
        '        Provider<SumberInfoRilis>(',
        '          create: (BuildContext context) =>',
        '              LayananInfoRilis(alamat: Uri.parse(alamatInfoRilis)),',
        '          dispose: (BuildContext context, SumberInfoRilis sumber) =>',
        '              sumber.tutup(),',
        '        ),',
        '      ],',
        '      Lingkungan.pengembangan => [',
        '        Provider<RepositoriCuaca>(',
        '          create: (BuildContext context) => RepositoriCuacaPalsu(),',
        '        ),',
        '        Provider<SumberInfoRilis>(',
        '          create: (BuildContext context) => const TanpaInfoRilis(),',
        '        ),',
        '      ],',
        '    },',
        '  ];',
        '}',
      ].join('\n'),
      ukuran: 9.5,
      lebarKode: 6.8,
      berkas: 'kode/contoh_07_studi_kasus_cuaca_kampus_siap_rilis.dart',
      poin: [
        'Akar komposisi Pertemuan 12: semua pilihan dirakit di buatPenyedia(konfigurasi).',
        'Pengembangan: TanpaInfoRilis selalu menjawab null, jadi tidak ada cek pembaruan.',
        'Halaman cuaca hanya mengenal kontrak SumberInfoRilis: tidak ada satu if pun untuk membedakan lingkungan.',
      ],
      catatan: 'Lingkungan dipilih dari --dart-define (Bagian 3), bukan dari kode. Itulah sebabnya mengganti defaultValue LINGKUNGAN mengubah perilaku aplikasi tanpa menyentuh halaman mana pun (Coba sendiri 16.3 nomor 3).',
    });

    d.layar({
      judul: 'Menjalankan "Cuaca Kampus 1.0.0"',
      gambar: ['hasil_contoh_07a.jpg', 'hasil_contoh_07b.jpg'],
      poin: [
        'DartPad: data sungguhan, lalu banner "Versi 1.1.0 tersedia" (info rilis 1.1.0, aplikasi 1.0.0).',
        '--dart-define=LINGKUNGAN=pengembangan: data palsu yang selalu sama, pita "BUILD UJI", tanpa banner.',
        '--release: sama seperti DartPad, tetapi log [debug] tidak muncul lagi.',
      ],
      ukuranPoin: 15,
      lebarMaks: 6.8,
      catatan: 'Coba sendiri (modul 16.3): (1) ubah versiAplikasi menjadi Versi.urai("0.9.0+1"): dialog wajib muncul dan tidak bisa ditutup, karena 0.9.0 lebih lama daripada versi minimum; (2) ubah menjadi Versi.urai("1.1.0+2"): banner tidak muncul lagi karena sudah versi terbaru; (3) ubah defaultValue LINGKUNGAN menjadi "pengembangan": data palsu dan pita BUILD UJI, tanpa satu pun berkas halaman diubah; (4) ubah menjadi "pengembangn" (salah ketik): aplikasi menolak berjalan dan menjelaskan sebabnya, lebih baik daripada diam-diam jalan.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 17', judul: 'Finalisasi Proyek Akhir', ikon: 'roket', catatan: 'Pertemuan 15 adalah tahap finalisasi proyek akhir: aplikasi lengkap, tes lulus, dan berkas rilis siap. Bagian ini adalah daftar kerjanya.' });

    d.kartu({
      judul: 'Daftar Periksa Rilis',
      kolom: 3,
      item: [
        { ikon: 'centang', judul: 'Fungsi dan kualitas', isi: 'Fitur wajib jalan; memuat/kosong/gagal ramah; 360 dan ≥ 840, terang dan gelap, huruf besar; analyze bersih, dart format; ≥ 3 tes unit; tanpa print.' },
        { ikon: 'label', judul: 'Identitas', isi: 'Nama tampilan rapi (Android, web, MaterialApp); applicationId bukan com.example; version 1.0.0+1; ikon dan layar pembuka diganti.' },
        { ikon: 'perisai', judul: 'Rilis dari dalam', isi: 'Jaring pengaman + pengganti layar merah; halaman Tentang; izin internet di manifest utama; tanpa kunci API, key.properties, *.jks di repositori.', warna: C.accent6 },
        { ikon: 'unduh', judul: 'Berkas rilis', isi: 'Minimal satu, keduanya lebih baik: web di GitHub Pages dan/atau APK di Releases (tag v1.0.0); sudah diuji: data internet, mode pesawat, tutup-buka.', warna: C.accent5 },
        { ikon: 'dokumen', judul: 'Dokumen', isi: 'README.md final, CHANGELOG.md, KEBIJAKAN_PRIVASI.md; lisensi kode (opsional, diskusikan dengan tim).', warna: C.accent4 },
        { ikon: 'kode', judul: 'Bantuan memeriksa', isi: 'Salin isi pubspec.yaml, AndroidManifest.xml, build.gradle.kts, dan android/.gitignore ke Contoh 06, lalu jalankan.', warna: C.accent3 },
      ],
      catatan: 'Daftar lengkap ada di modul Bagian 17.1 (17 butir dalam lima kelompok). Tugas mandiri jobsheet meminta mahasiswa menyalinnya ke DAFTAR_PERIKSA_RILIS.md dan mencentang butir yang sudah terpenuhi; butir yang belum terpenuhi diberi alasan. Contoh 06 memeriksa sebagian butir secara otomatis (slide berikutnya).',
    });

    d.kode({
      judul: 'Daftar Periksa sebagai Program: Contoh 06',
      shell: true,
      kode: [
        '=== Tugas Kuliahku: sebelum dirapikan ===',
        '[OK]    Nomor versi lengkap (1.0.0+1)',
        '[SARAN] Deskripsi pubspec masih bawaan',
        '[WAJIB] Izin INTERNET belum ada',
        '[SARAN] Nama di HP masih "tugas_kuliahku"',
        '[WAJIB] applicationId masih com.example.tugas_kuliahku',
        '[SARAN] Rilis masih memakai kunci debug',
        '[SARAN] Judul tab web masih "tugas_kuliahku"',
        '[WAJIB] Kunci unggah bisa ter-commit',
        '[WAJIB] Ada kunci rahasia di lib/config/kunci.dart:2',
        '[SARAN] Ada print() di lib/data/services/layanan_dummy_json.dart:2',
        'Hasil: 4 wajib, 5 saran -> BELUM SIAP RILIS',
        '',
        '=== Tugas Kuliahku: sesudah dirapikan ===',
        '... (sepuluh baris [OK]) ...',
        'Hasil: 0 wajib, 0 saran -> SIAP RILIS',
      ].join('\n'),
      ukuran: 11.5,
      lebarKode: 7.9,
      berkas: 'kode/contoh_06_pemeriksa_kesiapan_rilis_dart_murni.dart',
      poin: [
        'Isi berkas proyek disimpan sebagai teks (Map: nama berkas → isi).',
        'Setiap pemeriksaan melapor OK, SARAN, atau WAJIB.',
        'Daftar yang sering terlupa kini tidak bergantung pada ingatan.',
      ],
      catatan: 'Program Dart murni ini memeriksa proyek "Tugas Kuliahku" dua kali: sebelum dan sesudah dirapikan. Sebelum membuat tag proyek akhir, mahasiswa bisa menempelkan isi berkas proyeknya sendiri ke program ini (tip di Jobsheet Tugas Mandiri).',
    });

    d.kode({
      judul: 'README Final dan Catatan Perubahan',
      shell: true,
      kode: [
        '# Catatan Perubahan',
        '',
        '## [1.0.1] - 2026-12-10',
        '',
        '### Diperbaiki',
        '',
        '- Tombol simpan tidak lagi macet saat judul tugas kosong.',
        '',
        '## [1.0.0] - 2026-12-03',
        '',
        '### Ditambahkan',
        '',
        '- Daftar tugas dari server DummyJSON, tersimpan di perangkat.',
        '- Halaman Tentang beserta kebijakan privasi.',
      ].join('\n'),
      ukuran: 12.5,
      lebarKode: 7.0,
      berkas: 'templat/CHANGELOG.md',
      poin: [
        'README.md = halaman depan proyek: judul, "Coba sekarang" (web + .../releases/latest), 3–5 tangkapan layar, fitur, tim, atribusi, cara menjalankan, pengujian, arsitektur, privasi.',
        'CHANGELOG.md untuk MANUSIA, bukan daftar commit: Ditambahkan, Diubah, Diperbaiki, Dihapus; terbaru di atas.',
        'KEBIJAKAN_PRIVASI.md: sesuai kenyataan; ditautkan dari README dan halaman Tentang.',
        'Tanpa berkas LICENSE, kode secara hukum "semua hak dilindungi".',
      ],
      catatan: 'Semua kerangka ada di folder templat/: README_PROYEK.md, CHANGELOG.md, KEBIJAKAN_PRIVASI.md. Isi CHANGELOG bisa langsung disalin ke catatan rilis GitHub (Bagian 12.3). Lisensi kode (Bagian 17.5) opsional: jika tim ingin kodenya boleh dipakai ulang, tambahkan berkas LICENSE (misalnya MIT) lewat tombol Choose a license template di GitHub; diskusikan dulu dengan dosen dan seluruh anggota tim.',
    });

    d.tabel({
      judul: 'Persiapan Demo UAS (Pertemuan 16)',
      kepala: ['Siapkan', 'Mengapa'],
      lebarKolom: [5.4, 6.7],
      baris: [
        ['APK sudah TERPASANG di HP yang akan dipakai demo', 'Memasang saat demo membuang waktu dan bisa gagal'],
        ['Tautan versi web sudah dicoba dari HP dan laptop lain', 'Jaringan dan browser di ruang ujian bisa berbeda'],
        ['Video demo cadangan 1–3 menit', 'Jika jaringan atau perangkat bermasalah'],
        ['Data contoh yang rapi', 'Data uji bernama "asdf" atau "tes123" mengganggu kesan'],
        ['Uji mode pesawat', 'Penguji sering bertanya, "Kalau internetnya mati bagaimana?"'],
        ['Cadangan data palsu (LINGKUNGAN=pengembangan)', 'Jika API sedang bermasalah tepat saat demo'],
        ['Alur demo 5–7 menit sudah dilatih', 'Waktu terbatas; alur yang dilatih tidak tersendat'],
        ['Setiap anggota tahu bagian kodenya', 'Bagian kode yang tidak bisa dijelaskan tidak dinilai'],
      ],
      ukuran: 14,
      tinggiBaris: 0.56,
      catatan: 'Yang dikumpulkan (modul 17.7, ikuti arahan dosen): tautan repositori dengan tag v1.0.0; tautan halaman rilis (APK) dan/atau versi web; README.md, CHANGELOG.md, dan KEBIJAKAN_PRIVASI.md yang lengkap. Penilaian UAS ada di Panduan Proyek Akhir Bagian 9.',
    });

    // ------------------------------------------------------------------
    d.tabel({
      judul: 'Kesalahan Umum Pemula',
      kepala: ['Gejala', 'Solusi'],
      lebarKolom: [6.1, 6.0],
      baris: [
        ['APK rilis tidak bisa memuat data internet', 'Izin INTERNET di android/app/src/main/AndroidManifest.xml'],
        ['GitHub Pages hanya putih, galat 404', '--base-href "/nama-repositori/", atau pakai templat/web.yml'],
        ['build/web/index.html diklik dua kali: kosong', 'dhttpd --path build/web, buka localhost:8080'],
        ['Memperbarui gagal: "paket bentrok"', 'Tanda tangan berbeda: hapus versi lama; pakai kunci unggah yang sama'],
        ['Robot/teman gagal build: keystore, signing config', 'Pola "kunci rilis jika ada, kunci debug jika tidak"'],
        ['key.properties atau .jks muncul di git status', 'Simpan di luar proyek; git check-ignore -v'],
        ['Berkas .aab tidak bisa dipasang di HP', 'AAB untuk Google Play; bagikan APK'],
        ['Cek pembaruan: 1.10.0 lebih lama dari 1.9.0', 'Bandingkan per bagian sebagai angka'],
        [kode('String.fromEnvironment can only be used as a const constructor', 11.5), 'Tambahkan const'],
        ['Tag sudah dibuat, rilis.yml tidak jalan', 'git push origin v1.0.0; nama diawali v'],
      ],
      ukuran: 13.5,
      tinggiBaris: 0.47,
      catatan: 'Tabel lengkap (27 baris) ada di modul Bagian 18, termasuk: workflow web.yml gagal di langkah Terbitkan (Source belum GitHub Actions, atau repositori privat tanpa GitHub Pro); situs masih versi lama (Ctrl + Shift + R); SQLite gagal di GitHub Pages (commit sqlite3.wasm dan sqflite_sw.js); keytool is not recognized; ikon masih logo Flutter (hapus aplikasi dari HP); nama di bawah ikon masih tugas_kuliahku; dua aplikasi kembar di HP (applicationId diganti); nomor build lupa dinaikkan; versi di halaman Tentang berbeda dengan pubspec (pakai package_info_plus); nilai --dart-define tidak terbaca; APK untuk dosen berisi data palsu; kotak abu-abu kosong; galat asinkron web tidak tercatat (runZonedGuarded); data pribadi di log; Resource not accessible by integration (kembalikan permissions: contents: write); aplikasi macet saat dibuka tanpa internet (batas waktu 5 detik, kembalikan null); "aplikasi saya lambat" diukur di mode debug.',
    });

    d.ringkasan({
      poin: [
        'Rilis bukan sekadar menjalankan: build rilis lebih kecil dan cepat, tanpa hot reload, assert dilewati, layar merah jadi abu-abu. Uji build rilis sendiri.',
        'kDebugMode konstanta waktu kompilasi: isi if (kDebugMode) dibuang. debugPrint tidak hilang sendiri.',
        '--dart-define + const fromEnvironment: bawaan aman, tolak salah ketik, bukan tempat rahasia.',
        'Identitas: nama tampilan, applicationId unik dan permanen, version MAYOR.MINOR.PATCH+BUILD.',
        'Ikon adaptif (flutter_launcher_icons) dan layar pembuka (flutter_native_splash): dev dependency.',
        'Galat diduga → pesan ramah; bug → jaring pengaman + laporan tanpa data pribadi + ErrorWidget.builder.',
        'Jujur tentang diri: versi, atribusi, kebijakan privasi (wajib), lisensi (showLicensePage).',
        'Web: build/web, dhttpd, GitHub Pages + --base-href. Android: APK/AAB, kunci unggah, jangan di-commit.',
        'Tag v1.0.0 → rilis.yml → GitHub Releases. Cek pembaruan: terbaru, disarankan, wajib; jangan menghalangi.',
        'Ukuran, kecepatan, keamanan; Google Play dan App Store; finalisasi: daftar periksa, README, CHANGELOG, demo.',
      ],
      catatan: 'Minta mahasiswa menjelaskan dengan kata-kata sendiri: mengapa APK yang lancar saat flutter run bisa gagal memuat data, dan mengapa kunci unggah yang hilang adalah masalah besar bagi aplikasi di luar Google Play.',
    });

    d.tabel({
      judul: 'Memilih Alat yang Tepat',
      kepala: ['Kebutuhan', 'Pakai'],
      lebarKolom: [4.6, 7.5],
      baris: [
        ['Mencoba rasa aplikasi rilis / mengukur kecepatan', kode('flutter run --release  /  flutter run --profile + DevTools', 11.5)],
        ['Kode yang hanya jalan saat pengembangan', kode('if (kDebugMode) { ... }', 12)],
        ['Pengaturan berbeda per build', kode('--dart-define + const String.fromEnvironment', 12)],
        ['Nomor versi; menampilkannya', kode('version: di pubspec.yaml; package_info_plus', 12)],
        ['Ikon semua ukuran; layar pembuka', kode('flutter_launcher_icons; flutter_native_splash', 12)],
        ['Galat yang lolos; pengganti layar merah', kode('FlutterError.onError, PlatformDispatcher, runZonedGuarded; ErrorWidget.builder', 10.5)],
        ['Halaman lisensi', kode('showLicensePage; LicenseRegistry.addLicense', 12)],
        ['Rilis web dan situsnya', kode('flutter build web --base-href; GitHub Pages + web.yml', 12)],
        ['Rilis Android', kode('flutter build apk / appbundle; keytool + key.properties', 12)],
        ['Rilis otomatis; rahasia robot', kode('git tag + rilis.yml; Secrets', 12)],
        ['Membaca ukuran aplikasi', kode('--analyze-size + DevTools App Size', 12)],
      ],
      ukuran: 13,
      tinggiBaris: 0.43,
      catatan: 'Tabel lengkap ada di modul Bagian 19. Minta mahasiswa memetakan proyek akhirnya: jalur rilis mana yang dipakai, dan alat apa yang dibutuhkan untuk setiap butir daftar periksa.',
    });

    d.tabel({
      judul: 'Jobsheet: Lima Praktikum dan Tugas Mandiri',
      kepala: ['Praktikum', 'Isi', 'Butuh'],
      lebarKolom: [2.2, 7.3, 2.6],
      baris: [
        ['1', 'Identitas "Tugas Kuliahku": nama, ID, versi 1.0.0+1, ikon adaptif, layar pembuka', 'Laptop'],
        ['2', 'Jaring pengaman galat, KotakGalatRamah, halaman Tentang, kebijakan privasi, lisensi', 'Laptop'],
        ['3', 'Rilis web: build, dhttpd, GitHub Pages dengan web.yml, dibuka dari HP', 'Laptop + GitHub'],
        ['4', 'APK: izin internet (wajib semua), build, pasang, kunci unggah, signingReport, AAB', 'Android SDK, HP'],
        ['5', 'Rilis 1.0.0: README, CHANGELOG, KEBIJAKAN_PRIVASI, rilis.yml, tag v1.0.0', 'Laptop + GitHub'],
        ['Tugas mandiri', 'Rilis 1.0.0 aplikasi Anda sendiri (dianjurkan "Pinjam Alat Lab" P14): web + APK + dokumen + DAFTAR_PERIKSA_RILIS.md', 'Semua di atas'],
      ],
      ukuran: 14,
      tinggiBaris: 0.66,
      catatan: 'Semua praktikum dikerjakan di satu proyek, tugas_kuliahku, diawali dan diakhiri commit. Jawaban modifikasi dicatat di CATATAN_RILIS.md. Aturan rahasia: key.properties dan *.jks tidak pernah di-commit, tidak dikirim ke grup kelas, dan tidak ditempel ke asisten AI. Belum punya Android SDK? Kerjakan Praktikum 4 Langkah 1, baca Langkah 2–7, lalu lanjut ke Praktikum 5: robot GitHub tetap mem-build APK. Padanan di modul: Praktikum 1 ↔ Bagian 4–6, Praktikum 2 ↔ Contoh 03 dan 04, Praktikum 3 ↔ Bagian 9, Praktikum 4 ↔ Bagian 10–11, Praktikum 5 ↔ Bagian 12 dan 17.',
    });

    d.penutup({
      judul: 'Saatnya Merilis!',
      subjudul: 'Kerjakan Jobsheet Pertemuan 15 (rilis "Tugas Kuliahku" 1.0.0 + rilis aplikasi Anda sendiri), lalu uji diri di Latihan. Pertemuan berikutnya: UAS, presentasi dan demo proyek akhir.',
      tautan: [
        { teks: 'Jobsheet P15', ikon: 'tugas', url: d.urlBerkas('pertemuan_15_build_rilis_dan_finalisasi/JOBSHEET.md') },
        { teks: 'Latihan P15', ikon: 'kuis', url: d.urlBerkas('pertemuan_15_build_rilis_dan_finalisasi/LATIHAN.md') },
        { teks: 'Proyek Akhir', ikon: 'roket', url: d.urlBerkas('panduan/05_proyek_akhir.md') },
      ],
      catatan: 'Proyek akhir: selesaikan daftar periksa Bagian 17.1, lalu buat tag v1.0.0. Pertemuan 16 adalah Ujian Akhir Semester: presentasi dan demo proyek akhir, dilanjutkan tanya jawab. Pelajari cara penilaiannya di Panduan Proyek Akhir Bagian 9, dan latih alur demonya sejak sekarang (Bagian 17.6).',
    });
  },
};

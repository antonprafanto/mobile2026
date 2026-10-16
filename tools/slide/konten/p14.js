// Konten slide Pertemuan 14 — Pengujian & Debugging.
// Teks diambil dari modul bacaan (pertemuan_14_pengujian_dan_debugging/README.md).
// Kode diambil dari modul dan dari folder pertemuan_14_pengujian_dan_debugging/kode/.
//
// Catatan kode di slide: kode disalin dari modul/berkas contoh. Jika terlalu
// panjang untuk satu slide, bagian yang dilewati ditandai "// ..." atau
// "...", dan catatan pembicara menyebutkannya.

module.exports = {
  nomor: '14',
  folder: 'pertemuan_14_pengujian_dan_debugging',
  namaBerkas: 'PERTEMUAN_14_Pengujian_dan_Debugging',
  topik: 'Pengujian & Debugging',

  bangun(d) {
    const C = d.C;
    // Teks berhuruf kode (Consolas) untuk sel tabel; ukuran boleh dikecilkan.
    const kode = (teks, ukuran) => ({
      text: teks,
      options: ukuran ? { fontFace: 'Consolas', fontSize: ukuran } : { fontFace: 'Consolas' },
    });

    d.judul({
      judul: 'Pengujian & Debugging',
      subjudul: 'Pertemuan 14  ·  tes unit, matcher, dan kode asinkron; ViewModel dengan data palsu; tes widget; plugin di tes; studi kasus Pinjam Ruang Kampus; pesan galat, debugger VS Code, dan DevTools; galat tata letak; cakupan dan CI',
      catatan: 'Selama ini kita menguji aplikasi dengan tangan: jalankan, ketik, ketuk, lalu lihat. Hari ini kita menulis kode kecil yang memeriksa kode lain, lalu belajar mencari penyebab bug tanpa menebak-nebak. Bekal: fungsi (P2); Future, async/await, Stream (P3); MVVM, ChangeNotifier, provider (P9); http dan MockClient (P10); kontrak, Hasil dan Kegagalan, data palsu, Perintah (P12 dan P13). Laptop RAM 8 GB cukup: flutter test tidak membutuhkan emulator, HP, maupun Chrome. Contoh 01–04 (tes unit) bahkan bisa langsung dicoba di DartPad.',
    });

    d.tujuan({
      pengantar: 'Setelah pertemuan ini, Anda mampu:',
      poin: [
        'Menjelaskan perlunya tes otomatis dan beda tes unit, widget, integrasi',
        'Menulis tes unit (siapkan → lakukan → periksa) dan menjalankannya',
        'Memakai matcher, menguji exception, setUp/tearDown/group, dan nilai batas',
        'Menguji Future dan Stream, serta kode yang menghubungi server (MockClient)',
        'Menguji ViewModel dengan data palsu yang bisa gagal, menghitung, dan ditahan',
        'Menulis tes widget: pumpWidget, finder, ketik, ketuk, lalu periksa layarnya',
        'Menguji kode yang memakai plugin tanpa HP: kontrak atau Fake',
        'Membaca pesan galat dan stack trace; memakai debugger VS Code dan DevTools',
        'Memperbaiki galat tata letak: overflow, ListView di Column, TextField di Row',
        'Menjalankan tes otomatis setiap push (CI) dan membaca cakupan kode',
      ],
      catatan: 'Target akhir hari ini: Anda mampu menulis tes unit dan tes widget, menjalankannya dengan satu perintah (di laptop maupun otomatis di GitHub), lalu menemukan penyebab bug dengan pesan galat, debugger VS Code, dan Flutter DevTools. Tes unit dijalankan di DartPad, terminal (flutter test), dan VS Code; tes widget dengan flutter test. Tes widget juga diperiksa di layar sempit, huruf besar, mode gelap, dan pedoman aksesibilitas. Tes integrasi diperkenalkan singkat di Bagian 14.3.',
    });

    d.alur({
      judul: 'Peta Materi Hari Ini',
      langkah: [
        { ikon: 'tanya', judul: 'A. Mengapa menguji?', isi: 'Bug tersembunyi dan tiga jenis tes (Bagian 1)' },
        { ikon: 'uji', judul: 'B. Tes unit', isi: 'Matcher, asinkron, MockClient, ViewModel (2–5)' },
        { ikon: 'widget', judul: 'C. Tes widget', isi: 'Finder, aksi, pump, semua keadaan layar (6–7)' },
        { ikon: 'puzzle', judul: 'D. Plugin dan studi kasus', isi: 'Fake, jam tetap, Pinjam Ruang Kampus (8–9)' },
        { ikon: 'serangga', judul: 'E. Debugging', isi: 'Pesan galat, debugger, DevTools, tata letak (10–13)', warna: C.accent5 },
        { ikon: 'sinkron', judul: 'F. CI dan proyek akhir', isi: 'Cakupan, GitHub Actions, jenis tes lain (14–16)', warna: C.accent4 },
      ],
      catatan: 'Bagian A: mengapa kode yang "sudah jalan" tetap perlu diuji, dan tes apa saja yang ada. Bagian B: menulis dan menjalankan tes untuk fungsi, kelas, kode asinkron, dan ViewModel. Bagian C: menguji tampilan seperti pengguna memakainya: mengetik, mengetuk, lalu melihat layar. Bagian D: menguji kode yang memakai kamera atau GPS, lalu menguji satu aplikasi utuh lapis demi lapis. Bagian E: saat aplikasi bermasalah, menemukan penyebabnya dengan cepat, bukan menebak-nebak. Bagian F: tes yang berjalan otomatis di GitHub, seberapa banyak kode yang sudah teruji, dan persiapan proyek akhir.',
    });

    d.tabel({
      judul: 'Kode Contoh Hari Ini',
      kepala: ['No', 'Berkas', 'Isi', 'Jalan di'],
      lebarKolom: [0.5, 5.4, 3.5, 2.7],
      baris: [
        ['01', kode('contoh_01_tes_unit_pertama_test.dart', 11), 'Nilai akhir P2 dan bug tersembunyinya', 'DartPad atau flutter test'],
        ['02', kode('contoh_02_matcher_setup_dan_group_test.dart', 11), '"Keranjang Kantin": matcher dan group', 'DartPad atau flutter test'],
        ['03', kode('contoh_03_menguji_kode_asinkron_test.dart', 11), '"Bus Kampus": Future, Stream, MockClient', 'DartPad atau flutter test'],
        ['04', kode('contoh_04_menguji_viewmodel_test.dart', 11), '"Antrean Konsultasi Dosen": ViewModel', 'DartPad atau flutter test'],
        ['05', kode('contoh_05_widget_test_pertama_test.dart', 11), '"Cek Nilai Akhir": tes widget pertama', 'flutter test'],
        ['06', kode('contoh_06_widget_test_dengan_viewmodel_test.dart', 11), '"Antrean Konsultasi": semua keadaan', 'flutter test'],
        ['07', kode('contoh_07_menguji_kode_plugin_test.dart', 11), '"Presensi Praktikum" tanpa kamera, GPS', 'flutter test'],
        ['08', kode('contoh_08_studi_kasus_menguji_pinjam_ruang_test.dart', 11), 'Studi kasus "Pinjam Ruang Kampus"', 'flutter test'],
        ['09', kode('contoh_09_mencari_bug_dengan_debugger.dart', 11), '"Kasir Kantin" dengan tiga bug', 'DartPad (gejala), VS Code'],
        ['10', kode('contoh_10_memperbaiki_tata_letak.dart', 11), '"Info Kegiatan Kampus": tata letak', 'DartPad atau proyek Flutter'],
      ],
      ukuran: 12,
      tinggiBaris: 0.47,
      catatan: 'Nama berkas tes WAJIB berakhiran _test.dart: itulah tanda bagi flutter test bahwa berkas itu berisi tes. Contoh 09 dan 10 bukan berkas tes, jadi namanya tidak berakhiran _test. Contoh 01–04 (tes unit) berjalan di DartPad. Contoh 05–08 (tes widget dan tes yang memakai plugin) dijalankan dengan flutter test di laptop; Contoh 07 dan 08 mengimpor studi kasus Pertemuan 13 dan 12. Contoh 09 dan 10 adalah aplikasi yang sengaja berisi bug: gejalanya terlihat di DartPad, tetapi debugger dengan breakpoint membutuhkan VS Code. Contoh 02 lengkapnya: matcher, exception, setUp, group, dan tabel kasus.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 1', judul: 'Mengapa Perlu Menguji?', ikon: 'uji', catatan: '"Programnya jalan" tidak sama dengan "programnya benar". Program yang jalan hanya membuktikan bahwa data yang kita coba memberi hasil yang benar.' });

    d.kode({
      judul: 'Bug yang Bersembunyi Dua Belas Minggu',
      kode: [
        '// Nilai akhir = 30% tugas + 30% UTS + 40% UAS',
        'double hitungNilaiAkhir({',
        '  required int tugas,',
        '  required int uts,',
        '  required int uas,',
        '}) {',
        '  return tugas * 0.3 + uts * 0.3 + uas * 0.4;',
        '}',
      ].join('\n'),
      ukuran: 15,
      lebarKode: 6.6,
      poin: [
        'Pertemuan 2: fungsi ini dipakai untuk merekap nilai satu kelas.',
        'Andi, Budi, Citra, dan Dewi: hasilnya benar. Kita pun lanjut ke pertemuan berikutnya.',
        'Dua belas minggu kemudian, saat fungsi ini akhirnya DIUJI, ternyata ada mahasiswa yang dirugikan.',
        'Bug lolos karena kita hanya mencoba EMPAT data, dan kebetulan keempatnya aman.',
      ],
      catatan: 'Kode ini berasal dari studi kasus Pertemuan 2 (contoh_13_studi_kasus_rekap_nilai.dart). Tanyakan dulu kepada mahasiswa: adakah yang salah dengan fungsi ini? Slide berikutnya menunjukkan data yang membuatnya salah.',
    });

    d.tabel({
      judul: 'Programnya Jalan, tetapi Belum Tentu Benar',
      pengantar: 'Fungsi yang sama, dengan data dua mahasiswa lain:',
      kepala: ['Tugas', 'UTS', 'UAS', 'Hitungan manual', 'Hasil komputer', 'Tampil', 'Huruf'],
      lebarKolom: [0.9, 0.9, 0.9, 3.1, 2.8, 1.1, 2.4],
      baris: [
        ['60', '82', '31', '18 + 24,6 + 12,4 = 55', kode('54.99999999999999', 17), '55.0', 'D (seharusnya C)'],
        ['15', '97', '16', '4,5 + 29,1 + 6,4 = 40', kode('39.99999999999999', 17), '40.0', 'E (seharusnya D)'],
      ],
      ukuran: 19,
      tinggiBaris: 0.95,
      pesan: 'toStringAsFixed(1) menampilkan 55.0, tetapi hurufnya D. Dari 1.030.301 kombinasi nilai bulat 0–100 untuk tugas, UTS, dan UAS, ada 214 yang mendapat huruf salah.',
      catatan: 'Mahasiswa yang protes akan dianggap salah lihat, karena layar menulis 55.0. Penyebabnya (bilangan desimal disimpan sedikit meleset dalam biner) dan perbaikannya dibahas di Bagian 2.6. Pelajaran pertama hari ini: "programnya jalan" tidak sama dengan "programnya benar".',
    });

    d.tabel({
      judul: 'Tiga Jenis Tes',
      pengantar: 'Tes otomatis: kode kecil yang memeriksa kode lain, diulang dalam hitungan detik setiap kode berubah.',
      kepala: ['Jenis', 'Yang diuji', 'Perumpamaan', 'Kecepatan', 'Keyakinan'],
      lebarKolom: [2.2, 3.8, 3.1, 1.5, 1.5],
      baris: [
        ['Tes unit (unit test)', 'Satu fungsi, method, atau kelas. Tanpa layar, tanpa internet', 'Memeriksa satu busi motor di meja bengkel', 'Sangat cepat', 'Rendah'],
        ['Tes widget (widget test)', 'Satu widget atau satu layar, di lingkungan uji tanpa perangkat', 'Menyalakan mesin motor di bangku uji', 'Cepat', 'Lebih tinggi'],
        ['Tes integrasi (integration test)', 'Aplikasi utuh, di HP, emulator, atau desktop sungguhan', 'Test ride di jalan raya', 'Lambat', 'Paling tinggi'],
      ],
      ukuran: 15,
      tinggiBaris: 0.88,
      pesan: 'Panduan resmi Flutter: BANYAK tes unit dan tes widget, ditambah tes integrasi SECUKUPNYA untuk alur terpenting.',
      catatan: 'Menguji dengan tangan tetap perlu, tetapi lambat, mudah lupa (setelah mengubah fitur B, siapa yang ingat mencoba ulang fitur A?), dan tidak bisa diulang persis sama. Bayangkan daftar periksa pilot: pilot yang sudah ribuan jam terbang pun tetap memeriksa setiap butir. Tes yang memastikan fitur lama TETAP benar setelah kode diubah disebut tes regresi (regression test): manfaat terbesar tes otomatis, karena kita berani mengubah kode tanpa takut merusak yang sudah jalan. Hari ini fokus pada tes unit dan tes widget; tes integrasi diperkenalkan singkat di Bagian 14.3.',
    });

    d.tabel({
      judul: 'Janji dari Pertemuan-Pertemuan Sebelumnya',
      kepala: ['Pertemuan', 'Yang sudah disiapkan', 'Dipakai hari ini di'],
      lebarKolom: [1.6, 7.6, 2.9],
      baris: [
        ['9', 'ViewModel tanpa widget, diperiksa dengan pola "siapkan, lakukan, periksa"', 'Bagian 5'],
        ['10', 'Server palsu MockClient dari package:http/testing.dart', 'Bagian 4'],
        ['11', 'Repository memori dan SQLite di memori', 'Bagian 5 dan Jobsheet'],
        ['12', 'Kontrak, data palsu, jam tetap, dan jalankanUji() yang mencetak LULUS/GAGAL', 'Bagian 9'],
        ['13', 'Fitur perangkat di balik kontrak; PemilihFotoImagePicker({ImagePicker? pemilih})', 'Bagian 8'],
      ],
      ukuran: 15,
      tinggiBaris: 0.62,
      pesan: 'jalankanUji() hanya mencetak teks. flutter test adalah test runner resmi: menemukan semua berkas tes, menjalankannya terpisah, melaporkan yang gagal beserta alasannya, dan bisa dijalankan otomatis oleh GitHub.',
      catatan: 'Beberapa pertemuan terakhir sudah menyiapkan kode agar BISA diuji; hari ini janji-janji itu kita tepati. Bedakan juga pengujian dan debugging: tes menjawab "apakah ada yang salah?" (tes merah), sedangkan debugging menjawab "di baris mana, dan mengapa?". Setelah penyebabnya ditemukan dan diperbaiki, tes kembali hijau. Alat-alat debugging dibahas di Bagian 10–13.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 2', judul: 'Tes Unit Pertama', ikon: 'centang', catatan: 'Tes unit memeriksa satu fungsi, method, atau kelas: paling murah dan paling cepat. Kita mulai dari fungsi nilai akhir Pertemuan 2 (Contoh 01).' });

    d.kode({
      judul: 'Folder test/ dan Paket flutter_test',
      shell: true,
      kode: [
        'dev_dependencies:',
        '  flutter_test:',
        '    sdk: flutter',
        '',
        'kasir_kantin/',
        '├── lib/',
        '│   ├── nilai.dart              ← kode yang diuji',
        '│   └── main.dart',
        '└── test/',
        '    └── nilai_test.dart         ← tesnya: nama sama + akhiran _test',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.8,
      poin: [
        'pubspec.yaml setiap proyek dari flutter create sudah berisi dev_dependencies ini.',
        'dev_dependencies: hanya dipakai SELAMA pengembangan, tidak ikut ke aplikasi rilis.',
        'Susunan test/ MENCERMINKAN lib/; nama berkas tes berakhiran _test.dart.',
        'test/widget_test.dart bawaan: hapus, atau ganti isinya setelah main.dart diganti.',
      ],
      catatan: 'flutter_test berisi semua yang kita butuhkan hari ini: test, expect, group, setUp, testWidgets, dan kawan-kawan. Proyek baru sudah berisi test/widget_test.dart yang menguji aplikasi penghitung bawaan, jadi tes itu pasti gagal setelah main.dart Anda ganti. Berkas contoh di repositori ini diletakkan di folder kode/, bukan test/, agar mudah ditemukan bersama modulnya. Judul // ===== BERKAS: ... ===== di dalamnya menunjukkan DI MANA setiap bagian berada pada proyek sungguhan, misalnya Contoh 01 berisi lib/nilai.dart (kode yang diuji) dan test/nilai_test.dart (tesnya).',
    });

    d.kode({
      judul: 'Anatomi Sebuah Tes',
      berkas: 'kode/contoh_01_tes_unit_pertama_test.dart',
      kode: [
        "import 'package:flutter_test/flutter_test.dart';",
        '',
        'void main() {',
        "  test('nilai 90 mendapat huruf A', () {",
        '    // 1. SIAPKAN data masukan.',
        '    const double nilai = 90;',
        '',
        '    // 2. LAKUKAN hal yang diuji.',
        '    final String huruf = nilaiHuruf(nilai);',
        '',
        '    // 3. PERIKSA hasilnya.',
        "    expect(huruf, 'A');",
        '  });',
        '}',
      ].join('\n'),
      ukuran: 14,
      lebarKode: 6.8,
      poin: [
        "test('kalimat', () { ... }) = SATU tes. Kalimatnya menjelaskan perilaku yang diharapkan.",
        'Siapkan → lakukan → periksa: pola Pertemuan 9 (Arrange → Act → Assert).',
        'expect(aktual, harapan): hasil sebenarnya di KIRI, harapan di KANAN. Berbeda → tes gagal di baris itu.',
        "Nama tes berupa kalimat: 'tepat 55 mendapat C, 54,9 mendapat D', bukan 'tes 3'.",
      ],
      catatan: 'Kalimat di test(...) itulah yang tampil saat tes gagal; kalimat yang jelas langsung menjelaskan aturan mana yang dilanggar. Jika urutan argumen expect tertukar, pesan gagalnya ikut tertukar dan membingungkan. Di proyek sungguhan, berkas tes juga mengimpor kode yang diuji dari folder lib/, misalnya import \'package:nama_proyek/nilai.dart\';.',
    });

    d.kode({
      judul: 'Tiga Cara Menjalankan Tes',
      berkas: 'kode/contoh_01_tes_unit_pertama_test.dart',
      shell: true,
      kode: [
        '# A. DartPad: tempel Contoh 01, klik Run (panel Console)',
        '00:00 +0: nilai 90 mendapat huruf A',
        '00:00 +1: nilai akhir memakai bobot 30%, 30%, dan 40%',
        '00:00 +2: tepat 85 mendapat A, 84,9 mendapat B',
        '...',
        '00:00 +8: Andi (85, 78, 90) tetap 84,9 dan mendapat B',
        '00:00 +9: All tests passed!',
        '',
        '# B. Terminal, dari folder utama proyek',
        'flutter test                       # semua tes di folder test/',
        'flutter test test/nilai_test.dart  # satu berkas saja',
        'flutter test --plain-name "tepat 55"',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.5,
      poin: [
        'Di terminal, hanya baris terakhir yang tersisa: 00:02 +9: All tests passed!',
        '--plain-name: hanya tes yang namanya memuat "tepat 55".',
        'C. VS Code: klik Run di atas test(, group(, atau void main(); atau panel Testing (ikon tabung reaksi).',
        'Laporan: 00:02 = waktu, +9 lulus, -2 gagal, ~1 dilewati (skip: true).',
      ],
      catatan: 'Label A dan B di kotak kode ditambahkan untuk slide, dan komentar perintah ketiga dipindah ke poin agar muat. Untuk berkas contoh di repositori ini, sebutkan jalurnya dari folder utama repositori, misalnya flutter test pertemuan_14_pengujian_dan_debugging/kode/contoh_01_tes_unit_pertama_test.dart, atau folder kode/ untuk semua contoh tes Pertemuan 14. VS Code hanya mengenali berkas tes di folder test/; untuk folder kode/ repositori ini, nyalakan setelan Dart: Allow Tests Outside Test Folder (dart.allowTestsOutsideTestFolder). Di VS Code, tes yang lulus diberi centang hijau, yang gagal tanda silang merah. Kesimpulan akhir laporan: All tests passed! atau Some tests failed.',
    });

    d.kode({
      judul: 'Membaca Tes yang Gagal',
      berkas: 'kode/contoh_01_tes_unit_pertama_test.dart',
      shell: true,
      kode: [
        '00:00 +6: nilai 60, 82, 31 tepat 55, jadi hurufnya C',
        '00:00 +6: nilai 60, 82, 31 tepat 55, jadi hurufnya C [E]',
        '  Expected: <55>',
        '    Actual: <54.99999999999999>',
        '  (baris-baris lokasi galat)',
        '00:00 +6 -1: nilai 15, 97, 16 tepat 40, jadi hurufnya D',
        '00:00 +6 -1: nilai 15, 97, 16 tepat 40, jadi hurufnya D [E]',
        '  Expected: <40>',
        '    Actual: <39.99999999999999>',
        '  (baris-baris lokasi galat)',
        '00:00 +6 -2: Andi (85, 78, 90) tetap 84,9 dan mendapat B',
        '00:00 +7 -2: Some tests failed.',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.4,
      poin: [
        '[E]: tes ini gagal (error).',
        'Expected: yang kita harapkan. Actual: yang sebenarnya dihasilkan kode.',
        'Lokasi galat = stack trace; di terminal menunjuk baris tes, misalnya test/nilai_test.dart 79:5.',
        '+7 -2: 7 lulus, 2 gagal.',
        'Merah dulu, baru hijau: tes yang belum pernah merah belum terbukti bisa menangkap bug.',
      ],
      catatan: 'Cara melihatnya: kembalikan hitungNilaiAkhir ke versi Pertemuan 2 (hapus pembulatannya), lalu jalankan lagi. Tes yang gagal bukan bencana: justru itulah tugasnya, berteriak SEBELUM pengguna menemukan masalahnya. Urutan yang dianjurkan setelah menemukan bug: (1) tulis tes yang membuktikan bug itu ada, jalankan, dan pastikan MERAH (jika hijau, tesnya belum menangkap bug itu); (2) perbaiki kodenya; (3) jalankan lagi sampai hijau, begitu pula semua tes lama. Tes ini sekaligus menjadi tes regresi: jika suatu hari pembulatannya terhapus, tes langsung merah lagi.',
    });

    d.tabel({
      judul: 'Mengapa 54.99999999999999?',
      pengantar: 'double disimpan dalam biner. 0,3 dan 0,4 tidak bisa disimpan tepat, seperti 1/3 = 0,3333… dalam desimal.',
      kepala: ['Cara', 'Contoh', 'Kapan dipakai'],
      lebarKolom: [2.9, 5.0, 4.2],
      baris: [
        ['Bulatkan hasilnya', kode('(akhir * 100).round() / 100', 14), 'Nilai yang ditampilkan dan dibandingkan dengan batas. Dipakai di Contoh 01'],
        ['Hitung dengan bilangan bulat', kode('(3 * tugas + 3 * uts + 4 * uas)', 14), 'Nilai × 10 dibandingkan dengan 550. Uang (rupiah sebagai int), poin, stok'],
        ['Bandingkan dengan toleransi', kode('expect(hasil, closeTo(6666.67, 0.01))', 14), 'Hasil yang memang desimal, misalnya rata-rata (Bagian 3.5)'],
      ],
      ukuran: 15,
      tinggiBaris: 0.85,
      pesan: 'Uang JANGAN memakai double: simpan rupiah sebagai int. 0.1 + 0.2 di Dart menghasilkan 0.30000000000000004.',
      catatan: 'Selisihnya sangat kecil, sekitar 0,000000000000007, tetapi cukup untuk membuat 55 menjadi 54.99999999999999, dan 54.99999999999999 >= 55 bernilai false. Setelah dibulatkan, ke-214 kombinasi yang tadinya salah menjadi benar semua: satu tes yang ditulis di nilai yang tepat menyelamatkan ratusan mahasiswa. Keranjang Kantin di Contoh 02 menyimpan harga sebagai int.',
    });

    d.kode({
      judul: 'Nilai Batas: Di Sinilah Bug Bersembunyi',
      berkas: 'kode/contoh_01_tes_unit_pertama_test.dart',
      kode: [
        'String nilaiHuruf(double angka) {',
        '  if (angka >= 85) {',
        "    return 'A';",
        '  } else if (angka >= 70) {',
        "    return 'B';",
        '  } else if (angka >= 55) {',
        "    return 'C';",
        '  } else if (angka >= 40) {',
        "    return 'D';",
        '  }',
        "  return 'E';",
        '}',
        '',
        "test('tepat 85 mendapat A, 84,9 mendapat B', () {",
        "  expect(nilaiHuruf(85), 'A');",
        "  expect(nilaiHuruf(84.9), 'B');",
        '});',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 6.6,
      poin: [
        'Pilih data TEPAT di garis pemisah, dan SATU LANGKAH di bawahnya.',
        'Nilai bulat → nilai akhir kelipatan 0,1: selangkah di bawah 85 adalah 84,9.',
        'Kesalahan tersering di batas: > dan >= tertukar. Data yang jauh dari batas (90, 60) tidak pernah menangkapnya.',
        'Pola ini muncul lagi: diskon Rp50.000 (Bagian 3), presensi 12.45 (Bagian 8), lama pinjam 30 menit (Bagian 9).',
      ],
      catatan: 'Pembagian huruf: E di bawah 40, D 40–54,9, C 55–69,9, B 70–84,9, A mulai 85. Data Andi, Budi, Citra, dan Dewi jauh dari garis pemisah, sehingga bug Pertemuan 2 tidak tertangkap: bug semacam ini hanya muncul TEPAT di garis. Kiat: untuk setiap aturan berbentuk "minimal", "maksimal", "mulai", atau "paling lambat", tulis dua tes: tepat di batas dan satu langkah di luar batas. Contoh 01 menguji keempat batas: 85, 70, 55, dan 40.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 3', judul: 'Matcher, Pengecualian, setUp, dan group', ikon: 'daftar', catatan: 'Contoh 02 menguji "Keranjang Kantin": menu bisa ditambah dan dikurangi, belanja mulai Rp50.000 mendapat diskon 10%, dan satu menu paling banyak 10 porsi.' });

    d.tabel({
      judul: 'Matcher: Cara Memeriksa yang Lebih Kaya',
      kepala: ['Matcher', 'Lulus jika', 'Contoh'],
      lebarKolom: [2.8, 3.5, 5.8],
      baris: [
        [kode('equals(x)', 12), 'Sama dengan x. List dan Map: isinya satu per satu', kode('expect(keranjang.total, 45000)', 12)],
        [kode('isTrue, isFalse', 12), 'Bernilai true / false', kode('expect(keranjang.kosong, isTrue)', 12)],
        [kode('isNull, isNotNull', 12), 'null / bukan null', kode('expect(vm.pesanKirim, isNull)', 12)],
        [kode('isEmpty, isNotEmpty', 12), 'Kosong / tidak kosong (teks, List, Map)', kode('expect(keranjang.rincian, isEmpty)', 12)],
        [kode('hasLength(n)', 12), 'Panjangnya n', kode('expect(keranjang.rincian, hasLength(1))', 12)],
        [kode('contains(x)', 12), 'Memuat x (teks atau anggota List)', kode("expect(rincian, contains('3 x Nasi goreng = Rp36.000'))", 11.5)],
        [kode('startsWith(s)', 12), 'Teks diawali s', kode("expect(alasan, startsWith('Lokasi palsu'))", 12)],
        [kode('greaterThan(n), lessThan(n)', 12), 'Lebih besar / lebih kecil dari n', kode('expect(jarak, lessThan(100))', 12)],
        [kode('closeTo(n, toleransi)', 12), 'Selisihnya dengan n tidak lebih dari toleransi', kode('expect(rataRata, closeTo(6666.67, 0.01))', 12)],
        [kode('isA<T>()', 12), 'Bertipe T', kode('expect(hasil, isA<Berhasil<List<JadwalBus>>>())', 12)],
      ],
      ukuran: 13,
      tinggiBaris: 0.46,
      catatan: 'Argumen kedua expect adalah matcher, yaitu "aturan pencocokan"; menulis nilai biasa seperti \'A\' sama dengan menulis equals(\'A\'). Dibandingkan expect(keranjang.rincian.length == 1, true), bentuk expect(keranjang.rincian, hasLength(1)) memberi pesan gagal yang jauh lebih jelas: Expected: an object with length of <1>, Actual: [\'3 x Nasi goreng = Rp36.000\', \'1 x Es teh = Rp4.000\'], Which: has length of <2>. isA<T>() bisa dilanjutkan dengan .having(...) untuk memeriksa isinya sekaligus (slide berikutnya).',
    });

    d.kode({
      judul: 'Menguji Exception: Bungkus dengan () =>',
      berkas: 'kode/contoh_02_matcher_setup_dan_group_test.dart',
      kode: [
        "test('jumlah 0 ditolak dengan ArgumentError', () {",
        '  expect(() => keranjang.tambah(esTeh, jumlah: 0), throwsArgumentError);',
        '  // Pesanan yang ditolak tidak boleh mengubah isi keranjang.',
        '  expect(keranjang.kosong, isTrue);',
        '});',
        '',
        'expect(',
        '  () => keranjang.tambah(esTeh),',
        '  throwsA(',
        '    isA<StateError>().having(',
        '      (StateError e) => e.message,',
        "      'message',",
        "      contains('Paling banyak 10 porsi Es teh'),",
        '    ),',
        '  ),',
        ');',
      ].join('\n'),
      ukuran: 11.5,
      lebarKode: 7.8,
      poin: [
        'Kode yang DIHARAPKAN melempar dibungkus () =>, agar expect sendiri yang menjalankan dan menangkapnya.',
        'throwsArgumentError: isi argumennya salah.',
        'throwsStateError: argumen wajar, tetapi keadaan objek menolak.',
        'throwsA(...) + isA<T>().having(...): jenis DAN pesannya sekaligus.',
      ],
      catatan: 'Penolakan juga perilaku yang harus diuji. Tanpa pembungkus () =>, exception dilempar SEBELUM expect sempat bekerja, dan tesnya gagal. Ada juga throwsFormatException untuk teks yang tidak sesuai format. Di Keranjang, tambah() melempar ArgumentError.value(jumlah, \'jumlah\', \'minimal 1\') untuk jumlah di bawah 1, dan StateError(\'Paling banyak $maksimalPorsi porsi ${menu.nama} sekali pesan.\') jika porsinya melebihi 10. Pola .having(ambil bagian yang diperiksa, namanya untuk pesan gagal, harapannya) juga dipakai untuk memeriksa kodeStatus ServerBermasalah di Contoh 03.',
    });

    d.kode({
      judul: 'setUp dan group: Setiap Tes Mulai dari Nol',
      berkas: 'kode/contoh_02_matcher_setup_dan_group_test.dart',
      kode: [
        'late Keranjang keranjang; // diisi di setUp, sebelum dipakai',
        '',
        "group('Keranjang', () {",
        '  setUp(() { keranjang = Keranjang(); });',
        '',
        "  test('keranjang baru masih kosong', () { ... });",
        '',
        "  group('diskon 10% mulai Rp50.000', () {",
        "    test('Rp49.000 belum mendapat diskon', () { ... });",
        "    test('tepat Rp50.000 mendapat diskon Rp5.000', () { ... });",
        '  });',
        '});',
      ].join('\n'),
      ukuran: 12.5,
      lebarKode: 7.4,
      poin: [
        'setUp: sebelum SETIAP tes di tingkatnya dan di dalamnya. tearDown: sesudah setiap tes, walaupun gagal.',
        'setUpAll / tearDownAll: sekali saja, untuk persiapan yang mahal.',
        'Tes harus MANDIRI. Buktikan dengan urutan acak: flutter test --test-randomize-ordering-seed random',
        'Nama kelompok ikut tertulis: "Keranjang diskon 10% mulai Rp50.000 tepat Rp50.000 ..."',
      ],
      catatan: 'Baris late Keranjang keranjang; berasal dari modul Bagian 3.3, kelompoknya dari Bagian 3.4; isi tes ditulis { ... } di modul. Mengapa tidak satu keranjang untuk semua tes? Jika tes kedua bergantung pada isi keranjang dari tes pertama, ia gagal saat dijalankan sendirian, atau saat urutannya berubah. tearDown cocok untuk membereskan, misalnya vm.dispose(). group boleh bersarang: setUp di kelompok luar dijalankan lebih dulu, baru setUp di kelompok dalam. Contoh baris laporan: 00:00 +13: Keranjang diskon 10% mulai Rp50.000 tepat Rp50.000 mendapat diskon Rp5.000.',
    });

    d.kode({
      judul: 'closeTo dan Tabel Kasus',
      berkas: 'kode/contoh_02_matcher_setup_dan_group_test.dart',
      kode: [
        'expect(keranjang.rataRataPerPorsi, closeTo(6666.67, 0.01));',
        '',
        "group('rupiah()', () {",
        '  const Map<int, String> kasus = {',
        "    0: 'Rp0',",
        "    500: 'Rp500',",
        "    1000: 'Rp1.000',",
        "    12500: 'Rp12.500',",
        "    150000: 'Rp150.000',",
        "    1000000: 'Rp1.000.000',",
        "    -2500: '-Rp2.500',",
        '  };',
        '  kasus.forEach((int angka, String harapan) {',
        "    test('$angka menjadi $harapan', () {",
        '      expect(rupiah(angka), harapan);',
        '    });',
        '  });',
        '});',
      ].join('\n'),
      ukuran: 11.5,
      lebarKode: 7.0,
      poin: [
        'closeTo(6666.67, 0.01): lulus jika selisihnya tidak lebih dari 0,01. Desimal jangan dibandingkan sama persis.',
        'Setiap baris tabel = satu tes bernama sendiri, misalnya rupiah() 1000 menjadi Rp1.000.',
        'Menambah kasus = menambah satu baris.',
        'Pilih dengan sengaja: nol, tanpa titik (500), batas munculnya titik (1000), titik ganda, negatif.',
      ],
      catatan: 'Rata-rata harga per porsi untuk 1 nasi goreng (Rp12.000) dan 2 es teh (Rp4.000) adalah 20.000 / 3 = 6666,666…. Contoh 02 berjalan di DartPad: 17 tes, diakhiri 00:00 +17: All tests passed!. Coba rusak kodenya dengan sengaja: ubah subtotal >= batasDiskon menjadi subtotal > batasDiskon. Tes mana yang menjadi merah? Inilah gunanya menguji tepat di batas (Rp49.000 belum mendapat diskon, tepat Rp50.000 mendapat diskon Rp5.000).',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 4', judul: 'Menguji Kode Asinkron', ikon: 'jam', catatan: 'Contoh 03 menguji "Bus Kampus": jadwal bus diambil dari server, lalu posisi bus diikuti lewat Stream. Semuanya berjalan tanpa internet dan selesai dalam sekejap.' });

    d.kode({
      judul: 'Tes async: Jangan Lupa await',
      berkas: 'kode/contoh_03_menguji_kode_asinkron_test.dart',
      kode: [
        "test('JSON yang benar menjadi daftar jadwal', () async {",
        '  final Hasil<List<JadwalBus>> hasil = await repositori.jadwalHariIni();',
        '',
        '  expect(hasil, isA<Berhasil<List<JadwalBus>>>());',
        '});',
        '',
        'class LayananBus {',
        '  // Aplikasi memberi http.Client(), tes memberi MockClient.',
        '  LayananBus({required this._klien});',
        '  final http.Client _klien;',
        '  // ...',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.8,
      poin: [
        'Fungsi tes diberi async; setiap Future di dalamnya ditunggu dengan await.',
        'Tanpa await, tes bisa selesai SEBELUM hasilnya datang: tampak lulus padahal tidak memeriksa apa-apa.',
        'Tes tidak boleh bergantung pada internet. Syaratnya: klien HTTP disuntikkan lewat constructor.',
      ],
      catatan: 'Aturan sederhana: jika memanggil sesuatu yang mengembalikan Future, tulis await di depannya. Tanpa await, galatnya juga bisa muncul di tes lain yang tidak bersalah. Server sungguhan membuat hasil tes berubah saat server sibuk atau Wi-Fi mati; karena itu LayananBus menerima klien dari luar: aplikasi memberi http.Client(), tes memberi MockClient, server palsu yang jawabannya kita tentukan sendiri (Pertemuan 10).',
    });

    d.kode({
      judul: 'Server Palsu dengan MockClient',
      berkas: 'kode/contoh_03_menguji_kode_asinkron_test.dart',
      kode: [
        '/// Server palsu yang menjawab dengan [jawab], lalu kegagalan yang',
        '/// dihasilkan repository (null jika berhasil).',
        'Future<Kegagalan?> kegagalanDari(MockClientHandler jawab) async {',
        '  final RepositoriBus repositori = RepositoriBus(',
        '    layanan: LayananBus(klien: MockClient(jawab)),',
        '  );',
        '  final Hasil<List<JadwalBus>> hasil = await repositori.jadwalHariIni();',
        '  return switch (hasil) {',
        '    Berhasil() => null,',
        '    Gagal(:final Kegagalan kegagalan) => kegagalan,',
        '  };',
        '}',
        '',
        "test('koneksi putus menjadi TanpaKoneksi', () async {",
        '  final Kegagalan? kegagalan = await kegagalanDari(',
        "    (http.Request _) async => throw http.ClientException('Terputus'),",
        '  );',
        '  expect(kegagalan, isA<TanpaKoneksi>());',
        '});',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.8,
      poin: [
        '200 + JSON yang benar → Berhasil (2 jadwal)',
        '500 → Gagal(ServerBermasalah(500))',
        'ClientException → Gagal(TanpaKoneksi())',
        'TimeoutException → Gagal(WaktuHabis())',
        'HTML, atau kolom jadwal tidak ada → Gagal(DataRusak())',
      ],
      catatan: 'Dengan MockClient, SETIAP kemungkinan kegagalan diuji dalam sekejap, tanpa menunggu server benar-benar rusak. Tabel lengkap di modul Bagian 4.2: http.Response(jsonContoh, 200) → Berhasil berisi 2 jadwal; http.Response(\'Galat server\', 500) → Gagal(ServerBermasalah(500)); throw http.ClientException(\'Terputus\') → Gagal(TanpaKoneksi()); throw TimeoutException(\'Terlalu lama\') → Gagal(WaktuHabis()); http.Response(\'<html>Perbaikan</html>\', 200) dan http.Response(\'{"data": []}\', 200) → Gagal(DataRusak()). Karena polanya berulang, Contoh 03 membuat fungsi pembantu kegagalanDari. Server palsu juga bisa MENCATAT permintaan yang diterimanya: expect(tercatat.single.method, \'GET\') dan expect(tercatat.single.url.path, \'/bus/jadwal\').',
    });

    d.kode({
      judul: 'Future yang Diharapkan Gagal: expectLater',
      berkas: 'kode/contoh_03_menguji_kode_asinkron_test.dart',
      kode: [
        'await expectLater(',
        '  layanan.ambilJadwal(), // Future, TANPA await di depannya',
        '  throwsA(',
        '    isA<ApiException>().having(',
        '      (ApiException e) => e.kodeStatus,',
        "      'kodeStatus',",
        '      404,',
        '    ),',
        '  ),',
        ');',
        '',
        'await expectLater(',
        '  layanan.ambilJadwal(),',
        "  completion(equals({'jadwal': []})), // Future yang berhasil dengan nilai tertentu",
        ');',
      ].join('\n'),
      ukuran: 10.5,
      lebarKode: 8.3,
      poin: [
        'Future yang SEHARUSNYA gagal: expectLater + throwsA.',
        'Future-nya ditulis TANPA await.',
        'expectLater mengembalikan Future → WAJIB di-await.',
        'completion(...): Future yang berhasil dengan nilai tertentu.',
      ],
      catatan: 'Perbedaannya dengan expect: expectLater mengembalikan Future yang selesai setelah pemeriksaannya selesai. Karena itu ia harus di-await. Di Contoh 03, LayananBus melempar ApiException jika kode status bukan 200; tes "kode 404 dilempar sebagai ApiException" memeriksa kodeStatus-nya dengan .having(...).',
    });

    d.kode({
      judul: 'Menguji Stream',
      berkas: 'kode/contoh_03_menguji_kode_asinkron_test.dart',
      kode: [
        "test('menghitung mundur sampai bus tiba', () async {",
        '  await expectLater(',
        '    statusKedatangan(Stream<int>.fromIterable([3, 2, 1, 0])),',
        '    emitsInOrder([',
        "      'Bus 3 halte lagi',",
        "      'Bus 2 halte lagi',",
        "      'Bus 1 halte lagi. Bersiaplah!',",
        "      'Bus tiba. Silakan naik!',",
        '      emitsDone, // lalu aliran selesai',
        '    ]),',
        '  );',
        '});',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.4,
      poin: [
        'Stream.fromIterable: aliran palsu dengan data yang kita tentukan.',
        'emits(x): isi berikutnya. emitsInOrder([...]): semua isi, berurutan.',
        'emitsDone: aliran selesai. emitsError(isArgumentError): galat di dalam aliran.',
        'neverEmits(x): tidak pernah mengeluarkan x sampai selesai.',
      ],
      catatan: 'statusKedatangan() mengubah aliran "sisa halte" menjadi kalimat untuk penumpang, lalu berhenti setelah bus tiba. Contoh 03 juga menguji bahwa aliran berhenti walaupun data masih datang ([1, 0, 5]), dan bahwa angka negatif menjadi galat di dalam aliran ([2, -1] → emitsError(isArgumentError)). Contoh 03 berjalan di DartPad (paket http tersedia di sana): 12 tes, selesai dalam sekejap tanpa internet sama sekali.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 5', judul: 'Menguji ViewModel dengan Data Palsu', ikon: 'data', catatan: 'Contoh 04 menguji "Antrean Konsultasi Dosen": mahasiswa melihat daftar antrean, lalu mengambil nomor. ViewModel-nya mengikuti pola Pertemuan 9 dan 12: memuat dari repository, menyimpan status (memuat, berhasil, gagal), menolak isian yang tidak wajar, dan menjaga agar ketukan ganda tidak mengirim dua kali.' });

    d.banding({
      judul: 'Data Palsu (fake) dan Tiruan (mock)',
      kolom: [
        {
          ikon: 'data', judul: 'Data palsu (fake)', warna: C.accent4, tag: 'Pilihan modul ini', sorot: true,
          poin: [
            'Kelas sungguhan yang memenuhi kontrak, tetapi sederhana: data di memori',
            'Contoh: RepositoriAntreanPalsu, RepositoriPeminjamanMemori (P12)',
            'Mudah dibaca, dipakai banyak tes, juga saat mengembangkan aplikasi',
            'Kekurangan: harus ditulis sendiri',
          ],
        },
        {
          ikon: 'puzzle', judul: 'Tiruan (mock)', warna: C.accent6, tag: 'Paket mocktail atau mockito (Bagian 14.4)',
          poin: [
            'Objek buatan paket; setiap jawabannya diatur di dalam tes',
            'Contoh: when(() => repo.semua()).thenAnswer(...)',
            'Cepat untuk satu kasus khusus; memeriksa panggilan dengan rinci',
            'Kekurangan: tes ikut terikat pada cara kode memanggil repository',
          ],
        },
      ],
      ukuranPoin: 16,
      pesan: 'ViewModel tidak berisi widget: hanya kelas Dart yang menerima repository lewat constructor. Karena itu ia bisa diuji TANPA layar.',
      catatan: 'Inilah alasan Pertemuan 9 memisahkan logika dari tampilan: buat ViewModel dengan repository palsu, panggil method-nya, lalu periksa isinya. Panduan arsitektur resmi Flutter memakai data palsu untuk repository, dan kita mengikutinya.',
    });

    d.kode({
      judul: 'Data Palsu dengan "Remote Control"',
      berkas: 'kode/contoh_04_menguji_viewmodel_test.dart',
      kode: [
        'class RepositoriAntreanPalsu implements RepositoriAntrean {',
        '  // 1. Pura-pura gagal.',
        '  Kegagalan? gagalSaatMemuat;',
        '  Kegagalan? gagalSaatMengambil;',
        '',
        '  // 2. Mata-mata (spy): berapa kali "server" dihubungi.',
        '  int jumlahMemuat = 0;',
        '  int jumlahMengambil = 0;',
        '',
        '  // 3. Tahan: setiap panggilan MENUNGGU sampai lepaskan() dipanggil.',
        '  bool tahan = false;',
        '  // ...',
        '  @override',
        '  Future<Hasil<List<Antrean>>> semua() async {',
        '    jumlahMemuat++;',
        '    await _mungkinDitahan();',
        '    final Kegagalan? kegagalan = gagalSaatMemuat;',
        '    if (kegagalan != null) return Gagal(kegagalan);',
        '    return Berhasil(List.of(_isi));',
        '  }',
        '  // ambilNomor() serupa.',
        '}',
      ].join('\n'),
      ukuran: 10.5,
      lebarKode: 7.4,
      poin: [
        'Pura-pura gagal: tes mengisi gagalSaatMemuat, misalnya const TanpaKoneksi().',
        'Mata-mata (spy): jumlahMemuat dan jumlahMengambil membuktikan "server" dihubungi, atau TIDAK.',
        'Tahan: keadaan di tengah jalan ("sedang memuat") bisa diperiksa (slide berikutnya).',
      ],
      catatan: 'Potongan dari Contoh 04 (modul Bagian 5.3). Bagian yang dilewati di slide (// ...): daftar _menunggu, method lepaskan(), dan _mungkinDitahan(), yang dibahas di slide berikutnya. Tes bisa mengatur ketiga "tombol" ini kapan saja. Data palsu yang sama dipakai lagi oleh tes widget di Contoh 06.',
    });

    d.kode({
      judul: 'Menahan dengan Completer',
      berkas: 'kode/contoh_04_menguji_viewmodel_test.dart',
      kode: [
        'Future<void> _mungkinDitahan() async {',
        '  if (!tahan) return;',
        '  final Completer<void> penahan = Completer<void>();',
        '  _menunggu.add(penahan);',
        '  await penahan.future; // berhenti di sini sampai complete() dipanggil',
        '}',
        '',
        "test('saat repository ditahan, status masih memuat', () async {",
        '  repositori.tahan = true;',
        '',
        '  final Future<void> proses = vm.muat(); // sengaja BELUM di-await',
        '  expect(vm.status, StatusMuat.memuat);',
        '',
        '  repositori.lepaskan(); // "server" menjawab',
        '  await proses;',
        '  expect(vm.status, StatusMuat.berhasil);',
        '});',
      ].join('\n'),
      ukuran: 11.5,
      lebarKode: 7.8,
      poin: [
        'Completer = "Future yang selesainya kita kendalikan sendiri".',
        'Selama complete() belum dipanggil, siapa pun yang menunggu ikut berhenti.',
        'lepaskan() memanggil complete() untuk semua yang menunggu.',
        'Kabar ke pendengar: addListener mencatat [memuat, berhasil]. Lupa notifyListeners() langsung ketahuan.',
      ],
      catatan: 'Tes di modul Bagian 5.4 ikut mendengarkan ViewModel: final List<StatusMuat> tercatat = []; vm.addListener(() => tercatat.add(vm.status)); await vm.muat(); expect(tercatat, [StatusMuat.memuat, StatusMuat.berhasil]);. Jika suatu hari ada yang lupa memanggil notifyListeners(), layar tidak berubah; tes ini menangkap kesalahan itu TANPA menjalankan aplikasi. lepaskan() memanggil complete() pada setiap Completer di _menunggu, lalu mengosongkannya.',
    });

    d.kode({
      judul: 'Ketukan Ganda Hanya Mengirim Sekali',
      berkas: 'kode/contoh_04_menguji_viewmodel_test.dart',
      kode: [
        "test('ketukan ganda hanya mengirim SATU kali', () async {",
        '  repositori.tahan = true;',
        '',
        '  final Future<bool> pertama = vm.ambilNomor(',
        "    nama: 'Sari',",
        "    keperluan: 'Konsultasi judul skripsi',",
        '  );',
        '  expect(vm.mengirim, isTrue); // tombol di layar seharusnya mati',
        '',
        '  final bool kedua = await vm.ambilNomor(',
        "    nama: 'Sari',",
        "    keperluan: 'Konsultasi judul skripsi',",
        '  );',
        '  expect(kedua, isFalse); // ditolak penjaga',
        '',
        '  repositori',
        '    ..tahan = false',
        '    ..lepaskan();',
        '  expect(await pertama, isTrue);',
        '  expect(repositori.jumlahMengambil, 1);',
        '});',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.2,
      poin: [
        "Nama kosong ditolak SEBELUM menghubungi server: pesanKirim 'Nama wajib diisi.', jumlahMengambil 0.",
        'Ketukan kedua selagi mengirim ditolak penjaga: server dihubungi SATU kali.',
        'ViewModel dibuang sebelum data datang: penjaga _sudahDibuang mencegah galat "... used after being disposed."',
        'tearDown(() { vm.dispose(); }): tes yang rapi membereskan apa yang ia buat.',
      ],
      catatan: 'Tes "nama kosong ditolak SEBELUM menghubungi server" memanggil vm.ambilNomor(nama: \'   \', keperluan: \'Konsultasi judul skripsi\'), lalu memeriksa berhasil isFalse, vm.pesanKirim \'Nama wajib diisi.\', dan repositori.jumlahMengambil 0: mata-mata membuktikan server tidak dihubungi. Tanpa penjaga _sudahDibuang, ViewModel memanggil notifyListeners() setelah dispose(), dan Flutter melempar galat "A AntreanViewModel was used after being disposed.". Contoh 04 berjalan di DartPad: 12 tes (00:00 +12: All tests passed!).',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 6', judul: 'Tes Widget Pertama', ikon: 'widget', catatan: 'Tes widget memeriksa TAMPILAN, dengan cara yang mirip pengguna memakainya: membangun layar, mengetik, mengetuk, lalu melihat apa yang muncul. Semuanya terjadi di lingkungan uji di dalam memori komputer: tidak ada HP, emulator, atau jendela yang terbuka, sehingga tes widget tetap berjalan cepat.' });

    d.kode({
      judul: 'testWidgets dan WidgetTester',
      berkas: 'kode/contoh_05_widget_test_pertama_test.dart',
      kode: [
        "testWidgets('tampilan awal: tiga isian dan belum ada hasil', (",
        '  WidgetTester tester,',
        ') async {',
        '  // pumpWidget: bangun dan gambar aplikasinya satu kali.',
        '  await tester.pumpWidget(const AplikasiCekNilai());',
        '',
        "  expect(find.text('Cek Nilai Akhir'), findsOneWidget);",
        '  expect(find.byType(TextFormField), findsNWidgets(3));',
        "  expect(find.text('Hitung'), findsOneWidget);",
        "  expect(find.byKey(const Key('kartu_hasil')), findsNothing);",
        '});',
      ].join('\n'),
      ukuran: 12.5,
      lebarKode: 7.4,
      poin: [
        'tester = "robot penguji": membangun layar, mengetik, mengetuk, dan menggambar ulang.',
        'pumpWidget: bangun widget lalu gambar SATU kali.',
        'find.…: finder. findsOneWidget, findsNothing, findsNWidgets(n), findsWidgets: berapa yang harus ditemukan.',
        'Widget yang diuji harus berada di dalam MaterialApp.',
      ],
      catatan: 'Contoh 05 menguji aplikasi kecil "Cek Nilai Akhir": tiga isian (Tugas, UTS, UAS), tombol Hitung, dan kartu hasil yang menampilkan nilai akhir, huruf, serta "Lulus" atau "Mengulang". Fungsi perhitungannya sama dengan Contoh 01. Fungsi testWidgets selalu async. MaterialApp dibutuhkan karena TextField, Scaffold, tema, dan arah teks membutuhkannya. Untuk menguji satu widget kecil, bungkus seperti ini: await tester.pumpWidget(const MaterialApp(home: Scaffold(body: KartuHasil(...))));',
    });

    d.tabel({
      judul: 'Finder: Mencari Widget di Layar',
      kepala: ['Finder', 'Mencari', 'Contoh'],
      lebarKolom: [3.8, 3.3, 5.0],
      baris: [
        [kode("find.text('…')", 12), 'Text bertulisan PERSIS sama', kode("find.text('Hitung')", 12)],
        [kode("find.textContaining('…')", 12), 'Tulisan yang MEMUAT potongan teks', kode("find.textContaining('tercatat')", 12)],
        [kode("find.byKey(Key('…'))", 12), 'Widget yang diberi key tersebut', kode("find.byKey(const Key('isian_tugas'))", 12)],
        [kode('find.byType(T)', 12), 'Semua widget bertipe T', kode('find.byType(TextFormField)', 12)],
        [kode('find.byIcon(ikon)', 12), 'Widget Icon dengan ikon tersebut', kode('find.byIcon(Icons.add)', 12)],
        [kode("find.byTooltip('…')", 12), 'Tombol ikon dengan tooltip tersebut', kode("find.byTooltip('Kosongkan')", 12)],
        [kode("find.widgetWithText(T, '…')", 12), 'Widget T yang memuat tulisan tersebut', kode("find.widgetWithText(TextFormField, 'UAS (40%)')", 11.5)],
        [kode('find.descendant(of: a, matching: b)', 12), 'b yang berada DI DALAM a', 'Lingkaran memuat di dalam tombol tertentu'],
        [kode('find.ancestor(of: a, matching: b)', 12), 'b yang MEMBUNGKUS a', 'Tombol yang membungkus tulisan "Ajukan"'],
      ],
      ukuran: 13,
      tinggiBaris: 0.5,
      catatan: 'Pilih finder yang mencerminkan cara pengguna melihat layar: tulisan (find.text), tooltip, atau label. Key adalah "papan nama" untuk widget: gunakan untuk widget yang tidak punya tulisan unik, misalnya beberapa isian yang mirip atau kartu hasil. Di Contoh 05, ketiga isian dibuat oleh fungsi pembantu _isian(const Key(\'isian_tugas\'), \'Tugas (30%)\', _tugas), dan TextFormField di dalamnya diberi key: kunci, papan nama yang dicari tes. find.text juga menemukan isian yang bertulisan persis sama.',
    });

    d.tabel({
      judul: 'Aksi: Mengetik, Mengetuk, Menggulir',
      kepala: ['Aksi', 'Arti'],
      lebarKolom: [6.2, 5.9],
      baris: [
        [kode('await tester.tap(finder)', 14), 'Mengetuk tengah widget'],
        [kode("await tester.enterText(finder, '60')", 14), 'Mengetik ke isian (isian lamanya diganti)'],
        [kode('await tester.drag(finder, const Offset(0, -300))', 14), 'Menyeret, misalnya menggulir daftar ke atas'],
        [kode('await tester.scrollUntilVisible(finder, 100)', 14), 'Menggulir sedikit demi sedikit sampai widget yang dicari muncul'],
        [kode('await tester.pageBack()', 14), 'Menekan tombol kembali di AppBar'],
      ],
      ukuran: 15,
      tinggiBaris: 0.62,
      pesan: 'Aksi TIDAK langsung mengubah layar. Di lingkungan uji, tes yang memutuskan kapan layar digambar ulang: await tester.pump().',
      catatan: 'Di aplikasi sungguhan, Flutter menggambar ulang layar sendiri sekitar 60 kali per detik; di lingkungan uji, tidak. Contoh dari Contoh 05: await tester.tap(find.text(\'Hitung\')); // tap() hanya mengetuk. Layar baru berubah setelah pump(). Lalu await tester.pump(); dan expect(find.text(\'Wajib diisi\'), findsNWidgets(3));. Lupa pump() adalah penyebab umum "setelah tap, expect tidak menemukan perubahan".',
    });

    d.tabel({
      judul: 'pump, pump(durasi), dan pumpAndSettle',
      kepala: ['Perintah', 'Jam palsu', 'Yang terjadi'],
      lebarKolom: [4.5, 1.9, 5.7],
      baris: [
        [kode('pump()', 13), 'TIDAK maju', 'Menggambar SATU gambar berikutnya. Perubahan dari setState dan notifyListeners muncul'],
        [kode('pump(const Duration(milliseconds: 500))', 12.5), 'Maju 500 ms', 'Timer yang jatuh tempo dijalankan, lalu satu gambar digambar'],
        [kode('pumpAndSettle()', 13), 'Maju 100 ms berulang kali', 'Terus menggambar sampai TIDAK ADA lagi yang perlu digambar: animasi halaman, lembar bawah, dan riak tombol selesai'],
      ],
      ukuran: 15,
      tinggiBaris: 0.85,
      pesan: 'Ada lingkaran memuat (CircularProgressIndicator) yang terus berputar? JANGAN pumpAndSettle(): animasinya tidak pernah selesai → pumpAndSettle timed out.',
      catatan: 'Bayangkan film animasi yang dibuat gambar demi gambar: di lingkungan uji, jam dan gambar sama-sama dikendalikan tes. Aturan praktis: setelah tap atau enterText biasa → pump(). Setelah membuka halaman, dialog, atau lembar bawah (ada animasi) → pumpAndSettle(). Ada lingkaran memuat → pump(), atau buat datanya selesai lebih dulu (Bagian 7.2); pumpAndSettle() gagal setelah 10 menit menurut jam palsu. Karena jamnya palsu, pump(const Duration(seconds: 2)) selesai seketika, tidak benar-benar menunggu 2 detik.',
    });

    d.kartu({
      judul: 'Lingkungan Uji',
      kolom: 3,
      item: [
        { ikon: 'web', judul: 'Bukan di DartPad', isi: 'Tes widget butuh lingkungan uji dari flutter test: jam palsu, layar palsu, pesan sistem tiruan.', warna: C.accent5 },
        { ikon: 'komputer', judul: 'Tetap ringan', isi: 'flutter test tidak membuka emulator maupun Chrome. Laptop RAM 8 GB cukup.', warna: C.accent4 },
        { ikon: 'layarpas', judul: 'Layar 800 × 600', isi: 'Ukuran layar uji 800 × 600 piksel logis, kecuali diubah (Bagian 7.5).' },
        { ikon: 'huruf', judul: 'Huruf kotak', isi: 'Setiap huruf digambar sebagai kotak: "Hitung" ukuran 14 = enam kotak 14 × 14.', warna: C.accent6 },
        { ikon: 'lihat', judul: 'Bukan ketepatan piksel', isi: 'Yang diperiksa: apa yang tampil dan perilakunya. Untuk piksel: golden test (Bagian 14.5).', warna: C.accent6 },
        { ikon: 'jalankan', judul: 'Contoh 05: 6 tes', isi: '00:03 +6: All tests passed! Ada fungsi pembantu isiNilai(...) dan tes "55.0 dengan huruf C".', warna: C.accent4 },
      ],
      catatan: 'Tes unit (test) tidak membutuhkan apa-apa selain Dart, sehingga berjalan baik di DartPad. Tes widget (testWidgets) membutuhkan lingkungan uji khusus yang disiapkan flutter test; DartPad menjalankan kode sebagai halaman web, dan pesan-pesan sistem milik halaman web ikut tercampur, sehingga tes widget bisa gagal walaupun kodenya benar. Huruf kotak membuat hasil tes sama di Windows, macOS, dan Linux; akibatnya lebar teks di tes tidak sama dengan di HP. Ingin MELIHAT aplikasinya di DartPad? Ganti nama main() milik tes menjadi mainTes(), lalu tambahkan void main() => runApp(const AplikasiCekNilai());. Tes \'60, 82, 31 menghasilkan 55.0 dengan huruf C\' memastikan perbaikan bug Bagian 2 juga terlihat benar DI LAYAR.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 7', judul: 'Tes Widget dengan ViewModel', ikon: 'lihat', catatan: 'Contoh 06 menguji TAMPILAN "Antrean Konsultasi Dosen" dari Contoh 04. Tampilan mendengarkan ViewModel, dan ViewModel memakai repository. Di tes, hanya repository yang diganti versi palsu; tampilan dan ViewModel-nya tetap yang asli.' });

    d.kode({
      judul: 'Aplikasi Asli, Repository Palsu',
      berkas: 'kode/contoh_06_widget_test_dengan_viewmodel_test.dart',
      kode: [
        '/// Memasang aplikasi ASLI, tetapi dengan repository palsu.',
        'Future<void> pasangAplikasi(',
        '  WidgetTester tester,',
        '  RepositoriAntreanPalsu repositori,',
        ') async {',
        '  await tester.pumpWidget(',
        '    Provider<RepositoriAntrean>.value(',
        '      value: repositori,',
        '      child: const AplikasiAntrean(),',
        '    ),',
        '  );',
        '}',
      ].join('\n'),
      ukuran: 12.5,
      lebarKode: 6.8,
      poin: [
        'Pintu yang sama dengan P9 dan P12: repository disediakan lewat provider di akar aplikasi.',
        'Memuat: repositori.tahan = true → lingkaran memuat.',
        'Berhasil: lepaskan() lalu pumpAndSettle() → daftar tampil.',
        'Gagal: gagalSaatMemuat = const TanpaKoneksi() → pesan ramah + Coba lagi.',
        'Kosong: RepositoriAntreanPalsu() tanpa isi → "Jadilah yang pertama!"',
      ],
      catatan: 'Alurnya: tes mengetuk dan mengetik pada tampilan (asli); tampilan memanggil ViewModel (asli); ViewModel memakai repository PALSU yang diatur tes (tahan, lepaskan, pura-pura gagal). Setiap layar yang memuat data punya beberapa keadaan, dan SEMUANYA harus diuji, bukan hanya keadaan "berhasil" (modul Bagian 7.2).',
    });

    d.kode({
      judul: 'Memuat, lalu Daftar',
      berkas: 'kode/contoh_06_widget_test_dengan_viewmodel_test.dart',
      kode: [
        "testWidgets('lingkaran memuat tampil, lalu berganti daftar antrean', (",
        '  WidgetTester tester,',
        ') async {',
        '  repositori.tahan = true; // "server" belum menjawab',
        '',
        '  await pasangAplikasi(tester, repositori);',
        '',
        '  expect(find.byType(CircularProgressIndicator), findsOneWidget);',
        "  expect(find.text('Rina'), findsNothing);",
        '  // Jangan pumpAndSettle() di sini: lingkaran memuat terus berputar.',
        '',
        '  repositori.lepaskan();',
        '  await tester.pumpAndSettle();',
        '',
        '  expect(find.byType(CircularProgressIndicator), findsNothing);',
        "  expect(find.text('Rina'), findsOneWidget);",
        '});',
      ].join('\n'),
      ukuran: 11.5,
      lebarKode: 7.8,
      poin: [
        'Saat ditahan: lingkaran memuat ada, daftar belum.',
        'JANGAN pumpAndSettle() selama lingkaran berputar.',
        'Setelah lepaskan(): lingkaran hilang, Rina tampil.',
        "Tes gagal juga menguji Coba lagi: gagalSaatMemuat = null, ketuk 'Coba lagi', jumlahMemuat menjadi 2.",
      ],
      catatan: 'Potongan tes "gagal" dari modul Bagian 7.2: repositori.gagalSaatMemuat = null; // koneksi kembali, lalu await tester.tap(find.text(\'Coba lagi\')); await tester.pumpAndSettle(); expect(find.text(\'Rina\'), findsOneWidget); expect(repositori.jumlahMemuat, 2); // dimuat dua kali. Tes "kosong" memasang RepositoriAntreanPalsu() tanpa isi dan mencari ajakan "Belum ada antrean. Jadilah yang pertama!".',
    });

    d.kode({
      judul: 'Tombol Mati Selama Mengirim',
      berkas: 'kode/contoh_06_widget_test_dengan_viewmodel_test.dart',
      kode: [
        'repositori.tahan = true;',
        "await tester.tap(find.text('Kirim'));",
        'await tester.pump(); // satu gambar: keadaan "sedang mengirim"',
        '',
        "final Finder tombol = find.byKey(const Key('tombol_kirim'));",
        'expect(tester.widget<ButtonStyleButton>(tombol).enabled, isFalse);',
        "expect(find.text('Mengirim...'), findsOneWidget);",
        '',
        '// Ketukan kedua pada tombol yang mati tidak berbuat apa-apa.',
        'await tester.tap(tombol, warnIfMissed: false);',
        'await tester.pump();',
        'expect(repositori.jumlahMengambil, 1);',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.6,
      poin: [
        'Janji P12: tombol kirim MATI selama permintaan berjalan.',
        'tester.widget<T>(finder): ambil objek widget-nya, lalu periksa propertinya.',
        'ButtonStyleButton: induk FilledButton, ElevatedButton, OutlinedButton, TextButton. enabled false = onPressed null.',
        'warnIfMissed: false: tombol mati tidak menerima ketukan; tanpa ini, tap mencetak peringatan.',
      ],
      catatan: 'FilledButton.icon(...) sebenarnya membuat kelas TURUNAN dari FilledButton, sehingga find.byType(FilledButton) tidak menemukannya. Cari dengan Key, dengan tulisannya, atau dengan predikat find.byWidgetPredicate((Widget w) => w is ButtonStyleButton) seperti di Contoh 08. Formulir ambil nomor muncul di lembar bawah (showModalBottomSheet); karena muncul dengan animasi, tes membukanya dengan pumpAndSettle() (fungsi bukaFormulir). Setelah nomor didapat, lembar tertutup dan SnackBar muncul; keduanya diperiksa seperti widget biasa: expect(find.text(\'Nomor antrean Anda: 3\'), findsOneWidget) dan expect(find.byType(LembarAmbilNomor), findsNothing).',
    });

    d.kode({
      judul: 'Layar Sempit dan Huruf Besar',
      berkas: 'kode/contoh_06_widget_test_dengan_viewmodel_test.dart',
      kode: [
        "testWidgets('layar sempit 320 piksel dengan huruf 200% tidak meluap', (",
        '  WidgetTester tester,',
        ') async {',
        '  // Ukuran layar dan ukuran huruf diatur, lalu dikembalikan seusai tes.',
        '  tester.view.physicalSize = const Size(320, 640);',
        '  tester.view.devicePixelRatio = 1.0;',
        '  tester.platformDispatcher.textScaleFactorTestValue = 2.0;',
        '  addTearDown(tester.view.reset);',
        '  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);',
        '',
        '  await pasangAplikasi(tester, repositori);',
        '  await tester.pumpAndSettle();',
        '  // ...',
        '});',
      ].join('\n'),
      ukuran: 11.5,
      lebarKode: 7.8,
      poin: [
        'physicalSize + devicePixelRatio 1,0 → layar 320 × 640 piksel logis.',
        'textScaleFactorTestValue = 2.0 → seolah huruf diperbesar 200% di Pengaturan.',
        'addTearDown(...): kembalikan seusai tes, agar tes berikutnya kembali ke 800 × 600.',
        'Hampir tanpa expect khusus: jika ada yang MELUAP (overflow), Flutter melaporkan galat dan tesnya otomatis gagal.',
      ],
      catatan: 'Pertemuan 7 mengingatkan bahwa pengguna memakai HP berlayar sempit dan sering memperbesar huruf. Tes ini menjaga tampilan tetap aman di layar kecil. Di Contoh 06, tes ini juga membuka formulir dan mengetuk Kirim, lalu memeriksa pesan \'Nama wajib diisi.\' (bagian yang dilewati // ...). Kesalahan umum: lupa addTearDown(tester.view.reset), sehingga tes berikutnya ikut memakai layar 320 piksel.',
    });

    d.kode({
      judul: 'Mode Gelap dan Pedoman Aksesibilitas',
      berkas: 'kode/contoh_06_widget_test_dengan_viewmodel_test.dart',
      kode: [
        'tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;',
        'addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);',
        '// ...',
        "final BuildContext konteks = tester.element(find.text('Rina'));",
        'expect(Theme.of(konteks).brightness, Brightness.dark);',
        '',
        "testWidgets('memenuhi pedoman aksesibilitas', (WidgetTester tester) async {",
        '  final SemanticsHandle pegangan = tester.ensureSemantics();',
        '',
        '  await pasangAplikasi(tester, repositori);',
        '  await tester.pumpAndSettle();',
        '',
        '  await expectLater(tester, meetsGuideline(androidTapTargetGuideline));',
        '  await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));',
        '  await expectLater(tester, meetsGuideline(textContrastGuideline));',
        '  pegangan.dispose();',
        '});',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 8.1,
      poin: [
        'tester.element(finder): BuildContext → tema yang sedang dipakai.',
        'androidTapTarget: target sentuh ≥ 48 × 48 (iOS: 44 × 44).',
        'labeledTapTarget: berlabel, misalnya tooltip pada IconButton.',
        'textContrast: kontras teks cukup.',
        'ensureSemantics(): pohon semantics untuk pembaca layar.',
      ],
      catatan: 'Mode gelap: kecerahan platform diatur gelap, lalu aplikasi dipasang dan digambar dengan pasangAplikasi dan pumpAndSettle() (baris yang dilewati // ...). AplikasiAntrean punya theme dan darkTheme, jadi di titik teks Rina tema yang dipakai harus gelap. Pemeriksaan aksesibilitas membutuhkan pohon semantics, yaitu informasi yang dibaca pembaca layar seperti TalkBack; untuk iOS ada iOSTapTargetGuideline (44 × 44). Contoh 06: 8 tes (00:04 +8: All tests passed!). Coba rusak tampilannya dengan sengaja: hapus tooltip: pada salah satu IconButton, atau buat sebuah Text panjang tanpa Expanded, lalu baca pesan gagalnya.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 8', judul: 'Menguji Kode yang Memakai Plugin', ikon: 'puzzle', catatan: 'Di Pertemuan 13, kamera dan GPS diakses lewat plugin image_picker dan geolocator. Plugin terdiri atas kode Dart dan KODE ASLI untuk Android, iOS, dan web. Saat tes dijalankan dengan flutter test, yang ada hanya Dart.' });

    d.tabel({
      judul: 'Empat Cara, dari yang Paling Dianjurkan',
      pengantar: 'Plugin dipanggil langsung dari tes → MissingPluginException(No implementation found for method pickImage on channel ...)',
      kepala: ['Urutan', 'Cara', 'Di modul ini'],
      lebarKolom: [1.2, 5.6, 5.3],
      baris: [
        ['1', 'Bungkus plugin dengan kontrak milik sendiri, lalu pakai versi palsu kontrak itu di tes', 'Kontrak PemilihFoto dan LayananLokasi (P13) beserta data palsunya'],
        ['2', 'Palsukan API publik plugin, jika plugin dipakai lewat objek, misalnya ImagePicker()', 'ImagePickerPalsu di Contoh 07'],
        ['3', 'Palsukan platform interface plugin (plugin bertipe federated)', 'Tidak dibahas'],
        ['4', 'Palsukan platform channel (TestDefaultBinaryMessenger)', 'Tidak dibahas, pilihan terakhir'],
      ],
      ukuran: 15,
      tinggiBaris: 0.7,
      pesan: 'Cara 1 sudah dipakai sejak P13: use case dan ViewModel hanya mengenal kontrak. Implementasi asli PemilihFotoImagePicker diuji dengan cara 2.',
      catatan: 'Pesan MissingPluginException artinya "tidak ada yang menjawab di seberang". Ini bukan bug aplikasi: tes memang tidak boleh bergantung pada kamera sungguhan. Urutan ini disarankan panduan resmi Flutter "Plugins in Flutter tests".',
    });

    d.kode({
      judul: 'Pintu Suntikan dan Fake',
      berkas: 'kode/contoh_07_menguji_kode_plugin_test.dart',
      kode: [
        'class PemilihFotoImagePicker implements PemilihFoto {',
        '  // ImagePicker boleh disuntikkan dari luar. Jika tidak, dibuat sendiri.',
        '  PemilihFotoImagePicker({ImagePicker? pemilih})',
        '    : _pemilih = pemilih ?? ImagePicker();',
        '  // ...',
        '}',
        '',
        'class ImagePickerPalsu extends Fake implements ImagePicker {',
        '  // Jawaban yang diatur tes.',
        '  XFile? hasil; // null = pengguna menekan "batal"',
        '  PlatformException? galat;',
        '  bool kameraAda = true;',
        '',
        '  // Mata-mata: argumen panggilan terakhir.',
        '  ImageSource? sumber;',
        '  CameraDevice? kameraDipilih;',
        '  double? lebarMaksimal;',
        '  int? kualitas;',
        '  // ...',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.8,
      poin: [
        'Aplikasi: PemilihFotoImagePicker() → ImagePicker asli. Tes: menyuntikkan ImagePicker PALSU.',
        'Kode implementasinya sama sekali TIDAK diubah.',
        'extends Fake: method yang tidak ditulis melempar UnimplementedError → panggilan tak terduga langsung ketahuan.',
        'Cukup tulis yang dipakai: pickImage dan supportsImageSource.',
      ],
      catatan: 'Constructor di atas berasal dari studi kasus Pertemuan 13; ImagePickerPalsu dari Contoh 07 (modul Bagian 8.3 dan 8.4). Bagian yang dilewati (// ...): supportsImageSource (true untuk galeri, atau jika kameraAda) dan pickImage, yang mencatat argumen ke mata-mata (sumber, kameraDipilih, lebarMaksimal, kualitas), melempar galat jika diatur, lalu mengembalikan hasil. implements ImagePicker membuatnya bisa dipakai di mana pun ImagePicker dibutuhkan; hasil, galat, dan kameraAda adalah "remote control" yang diatur tes.',
    });

    d.kode({
      judul: 'Yang Diuji: Argumen ke Plugin',
      berkas: 'kode/contoh_07_menguji_kode_plugin_test.dart',
      kode: [
        "test('kamera: kamera depan, lebar 720 px, kualitas 70', () async {",
        '  pemilih.hasil = fotoPalsu();',
        '',
        '  final Hasil<FotoBukti> hasil = await pemilihFoto.ambil(dariKamera: true);',
        '',
        '  expect(hasil, isA<Berhasil<FotoBukti>>());',
        '  expect(pemilih.sumber, ImageSource.camera);',
        '  expect(pemilih.kameraDipilih, CameraDevice.front);',
        '  expect(pemilih.lebarMaksimal, 720);',
        '  expect(pemilih.kualitas, 70);',
        '});',
      ].join('\n'),
      ukuran: 11.5,
      lebarKode: 8.0,
      poin: [
        'pickImage palsu MENCATAT argumennya: sumber, kamera, lebar, kualitas.',
        'Tes memastikan plugin dipanggil dengan argumen yang benar.',
        'Pengguna membatalkan (hasil null) → Gagal(Dibatalkan()).',
        'kameraTersedia mengikuti supportsImageSource (kameraAda).',
      ],
      catatan: 'fotoPalsu() membuat XFile tiga bita bernama selfie.jpg (XFile.fromData). Contoh 07 juga memeriksa bahwa galeri memakai ImageSource.gallery, dan bahwa metadata lengkap tidak diminta. Di Pertemuan 13, foto presensi diambil dengan kamera depan, maxWidth 720, dan imageQuality 70.',
    });

    d.tabel({
      judul: 'Terjemahan Galat: Tabel Kasus Lagi',
      kepala: ['PlatformException(code: ...)', 'Harus menjadi'],
      lebarKolom: [6.0, 6.1],
      baris: [
        [kode('camera_access_denied'), kode('IzinDiblokir(Fitur.kamera)')],
        [kode('photo_access_denied'), kode('IzinDiblokir(Fitur.galeri)')],
        [kode('no_available_camera'), kode('PerangkatTidakMendukung(Fitur.kamera)')],
        [kode('already_active'), kode("GangguanPerangkat('already_active')")],
        ['(pengguna membatalkan, pickImage mengembalikan null)', kode('Dibatalkan()')],
      ],
      ukuran: 16,
      tinggiBaris: 0.66,
      pesan: 'Kegagalan ini SULIT dicoba dengan tangan: menolak izin kamera, mencari HP tanpa kamera, membuka kamera dua kali. Dengan data palsu: hitungan milidetik.',
      catatan: 'Contoh 07 menyusun tabel kasus Map<String, Matcher>: setiap kode PlatformException dipasangkan dengan matcher isA<...>().having(...), lalu forEach membuat satu tes per baris, misalnya test(\'PlatformException "$kode" diterjemahkan\', ...). Polanya sama dengan tabel kasus rupiah() di Bagian 3.6.',
    });

    d.tabel({
      judul: 'Aturan Presensi di Nilai Batas',
      kepala: ['Aturan', 'Di dalam batas', 'Di luar batas'],
      lebarKolom: [5.6, 3.2, 3.3],
      baris: [
        ['Presensi dibuka 15 menit sebelum sesi 13.00', '12.45 dibuka', '12.44 belum dibuka'],
        ['Presensi ditutup 30 menit setelah sesi dimulai', '13.30 masih dibuka', '13.31 sudah ditutup'],
        ['Jarak maksimal 100 m dari lab', '99 m boleh', '101 m ditolak'],
        ['Akurasi GPS maksimal 50 m', '50 m boleh', '51 m ditolak'],
      ],
      ukuran: 17,
      tinggiBaris: 0.72,
      pesan: 'Mengapa 99 m, bukan tepat 100 m? Titik "tepat 100 m di utara lab" dihitung rumus haversine sebagai 100,00000000000001 m. Uji nilai yang JELAS di dalam dan JELAS di luar.',
      catatan: 'Pembulatan bilangan desimal lagi, seperti di Bagian 2.6! Untuk batas yang dihitung dengan bilangan desimal, uji nilai yang jelas di dalam dan jelas di luar. Di Contoh 07, posisi uji dibuat dengan menggeser lintang sejauh sekian meter ke utara laboratorium (fungsi berjarak(meter)).',
    });

    d.kode({
      judul: 'Use Case dengan Data Palsu dan Jam Tetap',
      berkas: 'kode/contoh_07_menguji_kode_plugin_test.dart',
      kode: [
        '// Jam tetap: Senin, 19 Oktober 2026 pukul 13.10.',
        'final Jam jam = Jam(() => DateTime(2026, 10, 19, 13, 10));',
        '',
        "test('tanpa foto: ditolak dan GPS TIDAK dinyalakan', () async {",
        '  final Hasil<Presensi> hasil = await catat.jalankan(sesi: sesiLab, foto: null);',
        '',
        '  expect(hasil, gagalDengan(isA<AturanDilanggar>()));',
        '  expect(lokasi.dipanggil, 0); // mata-mata: GPS tidak pernah diminta',
        '});',
      ].join('\n'),
      ukuran: 11.5,
      lebarKode: 8.4,
      poin: [
        'Jam tetap: hasil tidak bergantung pada kapan tes dijalankan.',
        'Foto diperiksa DULU: GPS yang boros baterai tidak dinyalakan percuma.',
        'Contoh 07: 18 tes, nol kamera, nol GPS; kode P13 tidak diubah.',
      ],
      catatan: 'CatatPresensi diuji dengan data palsu Pertemuan 13 (LayananLokasiPalsu, RepositoriPresensiMemori) ditambah jam tetap. Tes ini membuktikan URUTAN pemeriksaan di use case. Tes yang memakai DateTime.now() hasilnya bisa berbeda tergantung hari dan jam dijalankannya; inilah alasan Pertemuan 12 dan 13 menyuntikkan jam ke use case. Contoh 07 memakai image_picker dan MENGIMPOR studi kasus Pertemuan 13, persis seperti folder test/ mengimpor folder lib/, sehingga dijalankan dari folder utama repositori: flutter test pertemuan_14_pengujian_dan_debugging/kode/contoh_07_menguji_kode_plugin_test.dart → 00:07 +18: All tests passed!',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 9', judul: 'Studi Kasus: Menguji "Pinjam Ruang Kampus"', ikon: 'gedung', catatan: 'Di Pertemuan 12, studi kasus Pinjam Ruang Kampus memeriksa dirinya sendiri dengan jalankanUji() yang mencetak LULUS atau GAGAL. Contoh 08 memindahkan semua pemeriksaan itu ke flutter test, lalu melengkapinya dengan tes widget yang dijanjikan.' });

    d.tabel({
      judul: 'Dari jalankanUji() ke flutter test',
      kepala: ['Lapisan', 'Pertemuan 12 (jalankanUji)', 'Contoh 08 (flutter test)'],
      lebarKolom: [2.3, 4.2, 5.6],
      baris: [
        ['Entitas dan aturan', '"Sabtu ditolak", rentang waktu bertumpuk', "group('RentangWaktu') dan group('aturan peminjaman'): 13 tes, sebagian besar di nilai batas"],
        ['Use case', '"Bentrok ditolak dan tidak disimpan"', "group('AjukanPeminjaman'): 5 tes"],
        ['Repository server', '"Kode 500 menjadi ServerBermasalah"', "group('RepositoriRuangServer'): 6 tes dengan MockClient"],
        ['ViewModel', '"Setelah mengajukan, jadwal dibaca ulang"', "group('JadwalRuangViewModel'): 4 tes"],
        ['View', 'JANJI: "Tombol Ajukan mati selama menyimpan"', "group('HalamanDaftarRuang') dan group('HalamanJadwalRuang'): 5 tes widget"],
        ['Seluruh aplikasi', '—', 'Satu tes alur lengkap'],
      ],
      ukuran: 14,
      tinggiBaris: 0.6,
      pesan: 'Kode aplikasinya TIDAK diubah sama sekali: Contoh 08 mengimpor berkas studi kasus Pertemuan 12. Di proyek, test/ mencerminkan lib/; bahan bersama di testing/.',
      catatan: 'Di proyek sungguhan, Contoh 08 terpecah menjadi beberapa berkas (lihat judul // ===== BERKAS: ... ===== di dalamnya): test/domain/models/rentang_waktu_test.dart dan aturan_peminjaman_test.dart, test/domain/use_cases/ajukan_peminjaman_test.dart, test/data/repositories/repositori_ruang_server_test.dart, test/ui/... untuk halaman daftar ruang, ViewModel dan halaman jadwal ruang, serta alur_pinjam_ruang_test.dart; ditambah testing/data_uji.dart (jam tetap, pengguna, ruang contoh) dan testing/fakes/repositori_uji.dart (data palsu khusus tes). testing/ berada di luar test/ karena isinya bukan tes, melainkan BAHAN yang dipakai banyak tes; susunan ini mengikuti aplikasi contoh resmi Flutter.',
    });

    d.kode({
      judul: 'Matcher Buatan Sendiri',
      berkas: 'kode/contoh_08_studi_kasus_menguji_pinjam_ruang_test.dart',
      kode: [
        '/// Matcher: Hasil yang Gagal dengan kegagalan tertentu.',
        'Matcher gagalDengan(Matcher kegagalan) => isA<Gagal<Object?>>().having(',
        '  (Gagal<Object?> g) => g.kegagalan,',
        "  'kegagalan',",
        '  kegagalan,',
        ');',
        '',
        '/// Matcher: ditolak aturan dengan alasan tertentu.',
        'Matcher ditolak(Object? alasan) => gagalDengan(',
        '  isA<AturanDilanggar>().having(',
        '    (AturanDilanggar k) => k.alasan,',
        "    'alasan',",
        '    alasan,',
        '  ),',
        ');',
        '',
        "expect(hasil, ditolak('Ruang tidak ditemukan.'));",
        'expect(hasil, gagalDengan(isA<TanpaKoneksi>()));',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.8,
      poin: [
        'Banyak tes memeriksa: "Gagal karena aturan dilanggar, dengan alasan tertentu".',
        'Daripada isA<...>().having(...) bertingkat berulang kali: dua fungsi matcher.',
        'Hasilnya, tes terbaca seperti kalimat.',
        'gagalDengan juga dipakai di Contoh 07.',
      ],
      catatan: 'Dua baris expect paling bawah adalah contoh pemakaian dari modul Bagian 9.3. Di Contoh 08, kedua fungsi ini berada di bagian testing/data_uji.dart, bersama jamTetap() (Rabu, 14 Oktober 2026 pukul 10.00), budi, dan ruangDiskusi.',
    });

    d.kode({
      judul: 'Lapis demi Lapis: Use Case',
      berkas: 'kode/contoh_08_studi_kasus_menguji_pinjam_ruang_test.dart',
      kode: [
        "test('kegagalan repository ruang diteruskan apa adanya', () async {",
        '  final AjukanPeminjaman tanpaInternet = AjukanPeminjaman(',
        '    ruang: RepositoriRuangUji()..gagal = const TanpaKoneksi(),',
        '    peminjaman: peminjaman,',
        '    sekarang: jamTetap,',
        '  );',
        '',
        '  final Hasil<Peminjaman> hasil = await tanpaInternet.jalankan(',
        "    pengajuan('C-110', rentang(kamis(9), 60)),",
        '    budi,',
        '  );',
        '',
        '  expect(hasil, gagalDengan(isA<TanpaKoneksi>()));',
        "  expect(await jumlahDiRuang('C-110'), 0); // tidak ada yang tersimpan",
        '});',
      ].join('\n'),
      ukuran: 11.5,
      lebarKode: 7.8,
      poin: [
        'Aturan di nilai batas: 29 menit ditolak, 30 lolos; 3 jam lolos, 3 jam 1 menit ditolak.',
        'Mulai 07.00 lolos, 06.30 ditolak; 12 peserta (kapasitas) lolos, 13 ditolak; Jumat lolos, Sabtu ditolak.',
        '"Sekarang" dibuat tetap: Rabu, 14 Oktober 2026 pukul 10.00.',
        'RepositoriRuangUji: data palsu kecil yang bisa pura-pura gagal.',
      ],
      catatan: 'Use case AjukanPeminjaman diuji dengan RepositoriPeminjamanMemori dari Pertemuan 12 dan RepositoriRuangUji. Repository server diuji dengan "server" yang diatur dari dalam tes: setUp menyimpan jawaban, kodeStatus, dan galat di variabel, lalu MockClient mencatat permintaan dan menjawab sesuai variabel itu; setiap tes cukup mengubah satu variabel, misalnya kodeStatus = 500. ViewModel diuji tanpa layar: JadwalRuangViewModel langsung memuat jadwal di constructor-nya, jadi setUp menunggu dengan await pumpEventQueue(), yang memberi kesempatan semua Future yang sedang antre untuk selesai.',
    });

    d.kode({
      judul: 'Rem pada simpan(): RepositoriPeminjamanDitahan',
      berkas: 'kode/contoh_08_studi_kasus_menguji_pinjam_ruang_test.dart',
      kode: [
        'class RepositoriPeminjamanDitahan extends RepositoriPeminjamanMemori {',
        '  RepositoriPeminjamanDitahan({super.sekarang});',
        '',
        '  Completer<void>? penahan;',
        '  int jumlahSimpan = 0;',
        '',
        '  @override',
        '  Future<Hasil<Peminjaman>> simpan(',
        '    PengajuanPeminjaman pengajuan,',
        '    Pengguna peminjam,',
        '  ) async {',
        '    jumlahSimpan++;',
        '    final Completer<void>? tahan = penahan;',
        '    if (tahan != null) await tahan.future; // berhenti sampai dilepas',
        '    return super.simpan(pengajuan, peminjam);',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 11.5,
      lebarKode: 7.8,
      poin: [
        'Mewarisi RepositoriPeminjamanMemori dari Pertemuan 12, lalu menambahkan "rem".',
        'penahan diisi Completer → simpan() berhenti sampai complete() dipanggil.',
        'jumlahSimpan: mata-mata untuk ketukan ganda.',
      ],
      catatan: 'Polanya sama dengan tahan dan lepaskan di Contoh 04, tetapi kali ini hanya simpan() yang ditahan. Data palsu ini dipakai tes ViewModel ("ketukan ganda: Perintah hanya menyimpan sekali") dan tes widget di slide berikutnya.',
    });

    d.kode({
      judul: 'Menepati Janji: Tombol Ajukan Mati',
      berkas: 'kode/contoh_08_studi_kasus_menguji_pinjam_ruang_test.dart',
      kode: [
        "testWidgets('tombol Ajukan MATI selama menyimpan', (",
        '  WidgetTester tester,',
        ') async {',
        '  await pasang(tester);',
        "  await isiFormulir(tester, peserta: '8');",
        '  repositori.penahan = Completer<void>();',
        '',
        "  await tester.tap(tombol('Ajukan'));",
        '  await tester.pump(); // satu gambar: keadaan "sedang menyimpan"',
        '',
        "  expect(aktif(tester, tombol('Ajukan')), isFalse);",
        '  // ...',
        '  // Ketukan kedua pada tombol yang mati diabaikan.',
        "  await tester.tap(tombol('Ajukan'), warnIfMissed: false);",
        '  await tester.pump();',
        '  expect(repositori.jumlahSimpan, 1);',
        '',
        '  repositori.penahan!.complete(); // "server" selesai menyimpan',
        '  await tester.pumpAndSettle();',
        '',
        "  expect(find.textContaining('Peminjaman PJ-001 tercatat'), findsOneWidget);",
        '});',
      ].join('\n'),
      ukuran: 10.5,
      lebarKode: 7.8,
      poin: [
        'tombol(teks): tombol yang MEMBUNGKUS tulisan itu (find.ancestor).',
        'aktif(...): membaca .enabled tombol (Bagian 7.3).',
        'Ketukan kedua diabaikan: jumlahSimpan tetap 1.',
        'Setelah complete(): "Peminjaman PJ-001 tercatat".',
        'Jebakan: Future.delayed + pump() tanpa durasi → simpan() belum terpanggil.',
      ],
      catatan: 'Baris pertama ditulis dalam tiga baris seperti di berkas Contoh 08. Bagian yang dilewati (// ...): expect(find.descendant(of: tombol(\'Ajukan\'), matching: find.byType(CircularProgressIndicator)), findsOneWidget), yaitu lingkaran memuat di dalam tombol. Jebakan yang ditemui modul saat menulis tes ini: versi pertama memakai RepositoriRuangMemori(jeda: Duration.zero), dan tesnya gagal karena jumlahSimpan masih 0. Repository itu tetap menunggu Future.delayed(jeda) walaupun jedanya nol; Future.delayed memakai timer, dan timer baru berjalan jika jam palsu dimajukan. pump() tanpa durasi tidak memajukan jam, sehingga use case masih tertahan dan simpan() belum terpanggil. Dua jalan keluar: data palsu TANPA jeda (RepositoriRuangUji, pilihan Contoh 08), atau await tester.pump(Duration.zero).',
    });

    d.kode({
      judul: 'Satu Tes untuk Seluruh Alur',
      berkas: 'kode/contoh_08_studi_kasus_menguji_pinjam_ruang_test.dart',
      kode: [
        'await tester.pumpWidget(',
        '  MultiProvider(',
        '    providers: buatPenyedia(Lingkungan.pengembangan),',
        '    child: const AplikasiPinjamRuang(lingkungan: Lingkungan.pengembangan),',
        '  ),',
        ');',
        'await tester.pumpAndSettle();',
        '',
        '// 1. Ruang Diskusi C.110 berada di bawah: gulir dulu, baru ketuk.',
        "await tester.scrollUntilVisible(find.text('Ruang Diskusi C.110'), 100);",
        'await tester.pumpAndSettle();',
        "await tester.tap(find.text('Ruang Diskusi C.110'));",
        'await tester.pumpAndSettle();',
        '',
        '// 2. Pilih hari kerja BERIKUTNYA, 3. isi formulir, ajukan, ...',
        '// 4. Kembali, buka tab Peminjaman Saya, periksa isinya.',
        "expect(find.textContaining('2 dari 2 peminjaman aktif'), findsOneWidget);",
      ].join('\n'),
      ukuran: 11.5,
      lebarKode: 7.8,
      poin: [
        'Akar komposisi yang SAMA dengan aplikasi (lingkungan pengembangan P12).',
        'Tes berperan sebagai pengguna dari awal sampai akhir.',
        'pumpAndSettle() setelah scrollUntilVisible: tanpa itu, ketukan mendarat di posisi lama.',
        'Contoh 08: 34 tes, selesai dalam belasan detik.',
      ],
      catatan: 'Tanpa pumpAndSettle() setelah scrollUntilVisible, tes gagal dengan peringatan "derived an Offset ... that would not hit test on the specified widget": guliran terakhir belum digambar, sehingga ketukan mendarat di posisi lama yang ternyata tertutup bilah navigasi bawah. Jalankan: flutter test pertemuan_14_pengujian_dan_debugging/kode/contoh_08_studi_kasus_menguji_pinjam_ruang_test.dart → 00:13 +34: All tests passed!. Hanya ingin menjalankan satu kelompok? Gunakan --plain-name, misalnya flutter test --plain-name "aturan peminjaman" .... Setiap kali kode Pinjam Ruang diubah, cukup jalankan perintah ini untuk tahu apakah ada yang rusak.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 10', judul: 'Debugging (1): Membaca Pesan Galat', ikon: 'galat', catatan: 'Tes memberi tahu ADA yang salah. Sekarang kita belajar mencari DI MANA dan MENGAPA. Contoh 09 adalah aplikasi "Kasir Kantin" yang SENGAJA berisi tiga bug, satu untuk setiap wajah bug yang paling sering ditemui.' });

    d.tabel({
      judul: 'Tiga Wajah Bug: Kasir Kantin',
      kepala: ['Gejala', 'Wajah bug', 'Petunjuk', 'Alat yang paling membantu'],
      lebarKolom: [1.0, 5.1, 2.5, 3.5],
      baris: [
        ['1', 'Layar merah: ketuk tombol + pada menu mana pun', 'Pesan galat dan stack trace', 'Membaca pesan galat, lalu debugger'],
        ['2', 'Angka salah tanpa galat: pesan tepat Rp50.000 (misalnya 2 Nasi Goreng), diskonnya Rp0', 'Tidak ada pesan apa pun', 'Breakpoint bersyarat dan Debug Console'],
        ['3', 'Layar tidak berubah: ketik uang yang dibayar, kembalian tetap "-" sampai tombol lain diketuk', 'Tidak ada pesan apa pun', 'Logpoint dan breakpoint di build'],
      ],
      ukuran: 15,
      tinggiBaris: 0.95,
      pesan: 'Siapkan: flutter create kasir_kantin, ganti lib/main.dart dengan Contoh 09, hapus test/widget_test.dart, pilih Chrome atau emulator, lalu tekan F5.',
      catatan: 'Bug kedua dan ketiga paling berbahaya: aplikasinya tampak baik-baik saja, padahal hasilnya salah. Langkah menyiapkan (modul Bagian 10.2): buka folder kasir_kantin di VS Code (File → Open Folder), ganti seluruh isi lib/main.dart dengan Contoh 09 lalu simpan, hapus test/widget_test.dart (berkas itu menguji aplikasi bawaan), pilih perangkat di pojok kanan bawah VS Code (Chrome atau emulator Android), lalu tekan F5 (Run → Start Debugging). Tanpa VS Code? Tempel Contoh 09 di DartPad untuk MELIHAT gejalanya; pesan galat juga tampil di panel Console DartPad. Yang tidak ada di DartPad hanyalah breakpoint.',
    });

    d.kode({
      judul: 'Layar Merah: Baca Pesannya dari Atas',
      berkas: 'kode/contoh_09_mencari_bug_dengan_debugger.dart',
      shell: true,
      kode: [
        '════════ Exception caught by widgets library ═══════════════════════════════════',
        'The following IndexError was thrown building',
        'HalamanKasir(dirty, state: _HalamanKasirState#a41e2):',
        'RangeError (index): Index out of range: index should be less than 1: 1',
        '',
        'The relevant error-causing widget was:',
        '    HalamanKasir HalamanKasir:file:///D:/kasir_kantin/lib/main.dart:103:19',
        '',
        'When the exception was thrown, this was the stack:',
        '#0      List.[] (dart:core-patch/growable_array.dart)',
        '#1      _HalamanKasirState._barisRincian (package:kasir_kantin/main.dart:164:42)',
        '#2      _HalamanKasirState.build (package:kasir_kantin/main.dart:207:16)',
        '#3      StatefulElement.build (package:flutter/src/widgets/framework.dart)',
        '#4      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart)',
        '...',
        '════════════════════════════════════════════════════════════════════════════════',
      ].join('\n'),
      ukuran: 10.5,
      lebarKode: 8.6,
      poin: [
        'Judul: galat terjadi saat MEMBANGUN widget (widgets library).',
        'Jenis: IndexError, saat membangun HalamanKasir.',
        'Isi: meminta nomor 1 dari daftar yang isinya hanya satu.',
        'Stack: jalan yang ditempuh program sampai galat.',
      ],
      catatan: 'Ketuk tombol + di samping Nasi Goreng: seluruh layar berubah merah dengan tulisan kuning. Inilah ErrorWidget: Flutter menggantikan widget yang gagal dibangun dengan kotak merah berisi pesan galatnya, hanya saat pengembangan (debug mode). Di aplikasi yang sudah dirilis, kotaknya abu-abu polos, sehingga pengguna hanya melihat layar kosong tanpa penjelasan. Jangan panik dan jangan langsung menebak: pesan lengkapnya ada di Debug Console VS Code (atau panel Console DartPad). Baca dari atas ke bawah dengan empat pertanyaan: bagian Flutter mana yang menangkap galatnya? apa jenis galatnya, dan saat membangun widget apa? apa isi galatnya? jalan mana yang ditempuh program? Di slide, baris kedua pesan dipecah dua agar muat. Nomor baris dan kode #a41e2 di komputer Anda bisa sedikit berbeda.',
    });

    d.kode({
      judul: 'Membaca Stack Trace',
      berkas: 'kode/contoh_09_mencari_bug_dengan_debugger.dart',
      kode: [
        '#0  List.[]                          ← milik Dart (operator [] pada List)',
        '#1  _HalamanKasirState._barisRincian ← KODE KITA, baris 164   ◀ mulai dari sini',
        '#2  _HalamanKasirState.build         ← kode kita, baris 207 (yang memanggil #1)',
        '#3  StatefulElement.build            ← milik Flutter',
        '...',
      ].join('\n'),
      ukuran: 11.5,
      lebarKode: 8.2,
      poin: [
        '#0 = fungsi PALING DALAM, yang terakhir dipanggil.',
        'Cari baris PERTAMA yang menunjuk berkas Anda sendiri (package:kasir_kantin/...).',
        'Baris dart: dan package:flutter/ hampir tidak pernah menjadi penyebabnya.',
        'Di VS Code, main.dart:164:42 bisa diklik: baris 164, kolom 42.',
        'Galat lanjutan (Another exception was thrown: ...) hanyalah akibat: baca galat PERTAMA.',
      ],
      catatan: 'Stack trace adalah daftar fungsi yang sedang berjalan saat galat terjadi, dari yang paling dalam (#0) sampai yang paling luar. Bayangkan tumpukan piring: piring paling atas (#0) adalah fungsi terakhir yang dipanggil. Satu kesalahan sering memicu galat lanjutan, yang di Debug Console ditulis singkat, misalnya Another exception was thrown: RenderBox was not laid out: RenderViewport#4c2a1 NEEDS-PAINT. Pemula sering membaca galat TERAKHIR di layar, padahal galat lanjutan hanyalah akibat; gulir ke atas dan baca galat PERTAMA yang dicetak lengkap dengan garis ════.',
    });

    d.kode({
      judul: 'Off-by-One dan Perbaikannya',
      berkas: 'kode/contoh_09_mencari_bug_dengan_debugger.dart',
      kode: [
        'for (int i = 0; i <= _pesanan.length; i++) {',
        '  final BarisPesanan baris = _pesanan[i]; // ← baris 164',
        '',
        '// Pilihan 1: < bukan <=',
        'for (int i = 0; i < _pesanan.length; i++) {',
        '  final BarisPesanan baris = _pesanan[i];',
        '  // ...',
        '}',
        '',
        '// Pilihan 2 (dianjurkan): biarkan Dart yang menghitung nomornya.',
        '// indexed menghasilkan pasangan (nomor, isi) untuk setiap anggota.',
        'for (final (int i, BarisPesanan baris) in _pesanan.indexed) {',
        '  // ...',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.6,
      poin: [
        'Isi List dinomori mulai 0: daftar berisi 1 pesanan hanya punya nomor 0.',
        'i <= _pesanan.length berjalan sampai i = 1, satu langkah terlalu jauh: off-by-one error.',
        'Pilihan 2 tidak memakai [i] sama sekali, jadi off-by-one tidak mungkin terjadi.',
        'Simpan (Ctrl+S) → hot reload: layar merah langsung hilang.',
      ],
      catatan: 'Kesalahan "lebih satu" ini sangat umum, sampai punya nama sendiri: off-by-one error. Setelah disimpan, VS Code melakukan hot reload, dan layar merah langsung hilang tanpa memulai ulang aplikasi. Untuk mengetahui apakah sebuah baris dijalankan, kita juga bisa mencatat ke konsol: print (paling sederhana, tetapi linter memberi peringatan avoid_print; cocok untuk percobaan sesaat, lalu dihapus), debugPrint dari package:flutter/foundation.dart (tidak memotong pesan panjang di Android; tetap tercetak di aplikasi rilis kecuali dibungkus if (kDebugMode)), atau developer.log(\'pesan\', name: \'kasir\') dari dart:developer, yang diberi nama kategori dan bisa disaring di tab Logging DevTools. Contoh 09 memakai developer.log di _tambah(); di DartPad, catatannya tidak tampil di panel Console. Bagian 11 memperkenalkan logpoint: catatan yang sama tanpa mengubah kode.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 11–12', judul: 'Debugger VS Code dan Flutter DevTools', ikon: 'serangga', catatan: 'Debugger adalah alat untuk MENGHENTIKAN aplikasi di baris tertentu, lalu melihat isi semua variabel pada saat itu, dan menjalankan kode baris demi baris. Bayangkan menonton video pertandingan dengan tombol pause dan putar-lambat: kita bisa berhenti tepat sebelum gol, lalu memeriksa posisi setiap pemain.' });

    d.tabel({
      judul: 'Bilah Alat Debug',
      pengantar: 'Aplikasi dijalankan dengan F5 → debugger aktif, bilah status berubah warna, dan bilah alat debug muncul di atas.',
      kepala: ['Tombol', 'Pintasan', 'Arti'],
      lebarKolom: [2.6, 2.4, 7.1],
      baris: [
        ['Continue', 'F5', 'Lanjutkan sampai breakpoint berikutnya'],
        ['Step Over', 'F10', 'Jalankan baris ini, lalu berhenti di baris BERIKUTNYA (tanpa masuk ke fungsi yang dipanggil)'],
        ['Step Into', 'F11', 'MASUK ke dalam fungsi yang dipanggil di baris ini'],
        ['Step Out', 'Shift+F11', 'Selesaikan fungsi ini, lalu berhenti di tempat pemanggilnya'],
        ['Hot Reload', 'Ctrl+S (simpan berkas)', 'Terapkan perubahan kode tanpa mengulang aplikasi; isi layar dipertahankan'],
        ['Hot Restart', 'Ctrl+Shift+F5', 'Mulai ulang aplikasi dari awal; isi layar hilang'],
        ['Stop', 'Shift+F5', 'Hentikan aplikasi'],
      ],
      ukuran: 15,
      tinggiBaris: 0.56,
      catatan: 'Panel Run and Debug (ikon segitiga dengan serangga di bilah kiri) berisi beberapa bagian: Variables (semua variabel di fungsi yang sedang berhenti, termasuk isi objek this), Watch (ekspresi pilihan Anda yang selalu dihitung ulang, misalnya _pesanan.length), Call Stack (stack trace versi hidup: klik sebuah baris untuk melihat variabel di fungsi pemanggilnya), dan Breakpoints (daftar semua breakpoint, plus kotak centang Uncaught Exceptions dan All Exceptions).',
    });

    d.alur({
      judul: 'Breakpoint Pertama',
      pengantar: 'Panel Run and Debug: Variables (isi variabel), Watch, Call Stack (stack trace versi hidup), dan Breakpoints.',
      langkah: [
        { ikon: 'pin', judul: 'Pasang breakpoint', isi: 'Klik di KIRI nomor baris 178 di build: muncul titik merah' },
        { ikon: 'sentuh', judul: 'Ketuk tombol +', isi: 'Aplikasi membeku; baris 178 disorot kuning' },
        { ikon: 'lihat', judul: 'Lihat isinya', isi: 'Panel Variables: this, _pesanan. Arahkan kursor ke nama variabel' },
        { ikon: 'jalankan', judul: 'F10, lalu F5', isi: 'F10: baris demi baris. F5: lanjutkan. Klik titik merah untuk menghapus', warna: C.accent4 },
        { ikon: 'galat', judul: 'Galat? Berhenti sendiri', isi: 'Uncaught Exceptions tercentang: berhenti di _pesanan[i], Variables: i = 1', warna: C.accent5 },
      ],
      catatan: 'Baris 178: final int subtotal = _subtotal;. Selama aplikasi berhenti di breakpoint, aplikasinya memang tidak bisa diketuk; itu normal, tekan F5 (Continue) untuk melanjutkan. Langkah 5 (Gejala 1 dengan debugger, modul Bagian 11.3): jika Gejala 1 belum diperbaiki, pastikan Uncaught Exceptions tercentang di panel Breakpoints (biasanya sudah), lalu ketuk +. Kali ini aplikasi tidak langsung merah: VS Code BERHENTI SENDIRI di baris yang melempar galat, final BarisPesanan baris = _pesanan[i];, dengan kotak keterangan RangeError. Panel Variables menunjukkan i bernilai 1, sedangkan _pesanan hanya berisi 1 anggota: penyebabnya terlihat tanpa menebak. Jika yang tersorot justru berkas milik Dart atau Flutter, lihat panel Call Stack dan klik baris teratas yang berasal dari main.dart.',
    });

    d.kode({
      judul: 'Gejala 2: Breakpoint Bersyarat',
      berkas: 'kode/contoh_09_mencari_bug_dengan_debugger.dart',
      kode: [
        '/// Diskon 10% untuk belanja MINIMAL Rp50.000.',
        'const int batasDiskon = 50000;',
        '',
        'int hitungDiskon(int subtotal) {',
        '  if (subtotal > batasDiskon) { // ← baris 65',
        '    return subtotal ~/ 10;',
        '  }',
        '  return 0;',
        '}',
        '',
        "test('diskon mulai tepat Rp50.000', () {",
        '  expect(hitungDiskon(50000), 5000); // tepat di batas',
        '  expect(hitungDiskon(49999), 0); // selangkah di bawah batas',
        '});',
      ].join('\n'),
      ukuran: 12.5,
      lebarKode: 7.0,
      poin: [
        'Breakpoint biasa berhenti TERUS, karena build memanggil hitungDiskon setiap kali.',
        'Klik kanan di kiri baris 65 → Add Conditional Breakpoint... → Expression: subtotal == 50000.',
        'F10: baris kuning MELOMPATI return subtotal ~/ 10 → syarat if bernilai false.',
        'Debug Console: subtotal > batasDiskon → false; subtotal >= batasDiskon → true. Perbaiki menjadi >=.',
        'Kunci dengan tes regresi; lihat merah dulu.',
      ],
      catatan: 'Penanda // ← baris 65 ditambahkan di slide. Pesan 2 Nasi Goreng: subtotal Rp50.000, tetapi diskonnya Rp0, tanpa pesan galat apa pun; kecurigaan pertama jatuh pada fungsi hitungDiskon. Dengan breakpoint bersyarat, aplikasi baru berhenti saat subtotal TEPAT Rp50.000 (ketuk + pada Nasi Goreng dua kali), tidak saat subtotal masih Rp25.000 yang tidak menarik. Arahkan kursor: subtotal bernilai 50000, batasDiskon juga 50000. Aturannya "diskon mulai Rp50.000", tetapi kodenya memakai >, yang berarti "lebih dari Rp50.000". Tes regresi di bawah kode diambil dari modul Bagian 11.4: jalankan SEBELUM memperbaiki kodenya, dan pastikan merah dulu (Bagian 2.5).',
    });

    d.kode({
      judul: 'Gejala 3: Logpoint',
      berkas: 'kode/contoh_09_mencari_bug_dengan_debugger.dart',
      kode: [
        '// SALAH',
        'onChanged: (String isian) {',
        '  _dibayar = int.tryParse(isian) ?? 0; // ← baris 222',
        '},',
        '',
        '// BENAR',
        'onChanged: (String isian) {',
        '  setState(() {',
        '    _dibayar = int.tryParse(isian) ?? 0;',
        '  });',
        '},',
      ].join('\n'),
      ukuran: 14,
      lebarKode: 7.0,
      poin: [
        'Logpoint = breakpoint yang TIDAK menghentikan aplikasi, hanya mencetak pesan.',
        'Klik kanan baris 222 → Add Logpoint... → onChanged terpanggil, isian = {isian}',
        'Debug Console mencetak setiap ketikan: onChanged BERJALAN, _dibayar sudah benar.',
        'Breakpoint di build (baris 178) TIDAK berhenti saat mengetik → build tidak dijalankan ulang → setState.',
        'Tanpa mengubah kode, berbeda dengan print, debugPrint, atau developer.log.',
      ],
      catatan: 'Ketik 100000 di isian Uang dibayar: kembaliannya tetap "-". Lalu ketuk + pada Es Teh: kembaliannya TIBA-TIBA berubah. Pertanyaannya: apakah kode di onChanged dijalankan saat kita mengetik? Teks di dalam { } pada logpoint dihitung sebagai ekspresi. Ingat Pertemuan 5: layar hanya digambar ulang jika perubahan dibungkus setState. Ketuk + "memperbaiki" layar karena _tambah memanggil setState, yang ikut membangun ulang seluruh halaman beserta kembaliannya; bug semacam ini sering membuat pemula bingung karena muncul-hilang. Label // SALAH, // BENAR, dan penanda baris ditambahkan di slide. Mencatat ke konsol juga berguna, tetapi mengubah kode dan harus diingat untuk dihapus; logpoint memberi catatan yang sama tanpa mengubah satu baris kode pun.',
    });

    d.alur({
      judul: 'Kebiasaan Detektif',
      pengantar: 'Tes gagal, tetapi alasannya belum jelas? Pasang breakpoint, lalu klik Debug (bukan Run) di atas test( atau testWidgets(.',
      langkah: [
        { ikon: 'ulang', judul: 'Ulangi bug-nya', isi: 'Catat langkah persisnya: "pesan 2 Nasi Goreng, diskon Rp0"' },
        { ikon: 'galat', judul: 'Baca galat pertama', isi: 'Beserta stack trace-nya, jika ada', warna: C.accent5 },
        { ikon: 'lampu', judul: 'Buat dugaan', isi: '"Mungkin syarat diskonnya salah"', warna: C.accent3 },
        { ikon: 'cari', judul: 'Buktikan dugaan', isi: 'Breakpoint, logpoint, atau Debug Console. Jangan mengubah kode berdasarkan tebakan' },
        { ikon: 'perisai', judul: 'Perbaiki, lalu kunci', isi: 'Perbaikan sekecil mungkin, lalu kunci dengan tes regresi', warna: C.accent4 },
      ],
      catatan: 'Alat secanggih apa pun tidak membantu tanpa cara berpikir yang runtut. Debugger untuk tes: tes berhenti di breakpoint, dan semua panel di atas bisa dipakai seperti biasa. Buntu? Coba jelaskan kodenya baris demi baris kepada teman, atau kepada boneka bebek di meja; sering kali bug-nya ketemu di tengah penjelasan. Teknik ini dikenal sebagai rubber duck debugging.',
    });

    d.tabel({
      judul: 'Flutter DevTools: Inspector',
      pengantar: 'Buka dari VS Code (F5, Ctrl+Shift+P → Dart: Open DevTools) atau dari alamat yang dicetak flutter run. Inspector berfungsi di semua platform, termasuk web.',
      kepala: ['Alat di Inspector', 'Kegunaan'],
      lebarKolom: [3.3, 8.8],
      baris: [
        ['Pohon widget', 'Susunan widget yang benar-benar dibangun; klik untuk melihat ukuran, padding, warna'],
        ['Select Widget Mode', 'Nyalakan, lalu ketuk sesuatu di aplikasi: widget itu langsung terpilih di pohon'],
        ['Flex explorer', 'Row/Column: sumbu, ukuran setiap anak, bagian yang meluap; coba flex tanpa mengubah kode'],
        ['Show Guidelines', 'Menggambar garis batas setiap kotak, padding, dan perataan'],
        ['Slow Animations', 'Memperlambat semua animasi 5 kali, untuk memeriksa transisi'],
        ['Highlight Oversized Images', 'Menandai gambar yang jauh lebih besar daripada ukuran tampilnya'],
      ],
      ukuran: 14,
      tinggiBaris: 0.5,
      pesan: 'Tab lain: Performance (ukur dengan flutter run --profile), CPU Profiler, Memory, Network, Logging. Dari VS Code, tab Debugger disembunyikan.',
      catatan: 'DevTools ikut terpasang bersama Flutter SDK. Dari terminal, flutter run mencetak alamat DevTools, misalnya http://127.0.0.1:9100?uri=...; buka alamat itu di Chrome. Select Widget Mode adalah cara tercepat menjawab "kotak ini sebenarnya widget apa?". Flex explorer muncul saat yang dipilih adalah Row atau Column; nilai mainAxisAlignment atau flex bisa dicoba langsung. Inspector paling berguna untuk galat tata letak di Bagian 13: pilih Row yang meluap, lalu lihat di Flex explorer anak mana yang terlalu lebar. Alat lain (modul Bagian 12.3): Performance mencari bagian yang tersendat (jank), diukur dengan profile mode, bukan debug mode (untuk web pakai tab Performance di Chrome DevTools); CPU Profiler: fungsi mana yang paling menyita waktu; Memory: mencari kebocoran memori; Network: permintaan HTTP yang dikirim aplikasi (untuk web pakai tab Network di Chrome DevTools, F12); Logging: membaca developer.log, debugPrint, dan catatan Flutter, bisa disaring berdasarkan nama kategori. Tab Debugger disembunyikan karena VS Code sudah punya debugger sendiri.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 13', judul: 'Galat Tata Letak yang Paling Sering', ikon: 'bingkai', catatan: 'Hampir semua galat tata letak berasal dari satu aturan. Contoh 10 "Info Kegiatan Kampus" berisi tiga kasus; setiap kasus dibuka di halamannya sendiri, dan sakelar Perbaiki di AppBar menukar versi bermasalah dengan versi yang benar.' });

    d.alur({
      judul: 'Aturan Emas Tata Letak Flutter',
      pengantar: '"Batasan mengalir ke bawah. Ukuran mengalir ke atas. Induk menentukan posisi." (Constraints go down. Sizes go up. Parent sets position.)',
      langkah: [
        { ikon: 'ukur', judul: 'Batasan turun', isi: 'Orang tua: "lebarmu boleh 0 sampai 360, tinggimu 0 sampai 640"' },
        { ikon: 'widget', judul: 'Ukuran naik', isi: 'Anak memilih ukurannya sendiri, di dalam batasan itu' },
        { ikon: 'grid', judul: 'Induk menentukan posisi', isi: 'Orang tua menentukan letak anak di dalam ruangannya' },
        { ikon: 'peringatan', judul: 'Masalah: tak terbatas', isi: 'Row: lebar tak terbatas; Column: tinggi tak terbatas. Teks panjang meluap; ListView, TextField galat', warna: C.accent5 },
        { ikon: 'centang', judul: 'Obat: Expanded', isi: '"Beri anak ini SISA ruang, bukan ruang tak terbatas"', warna: C.accent4 },
      ],
      catatan: 'Bayangkan orang tua dan anak memilih kamar. Masalah muncul saat batasannya tidak terbatas: Row memberi anak-anaknya lebar tidak terbatas ("silakan selebar yang kamu mau"), dan Column memberi tinggi tidak terbatas. Kebanyakan widget tidak keberatan, tetapi widget yang terlalu lebar untuk ruang yang tersedia (teks panjang) akan MELUAP, dan widget yang ingin seluas ruang yang tersedia (ListView, TextField) menghasilkan GALAT. Di Contoh 10, isi setiap halaman dibatasi selebar ponsel (360 piksel), agar galatnya juga muncul di jendela Chrome yang lebar. Cara mencoba Contoh 10: tempel di DartPad atau lib/main.dart proyek baru; untuk setiap kasus, amati gejalanya, baca galat pertama di panel Console DartPad atau Debug Console VS Code, buka Inspector dan Flex explorer (VS Code), lalu nyalakan sakelar Perbaiki dan bandingkan dengan kodenya.',
    });

    d.banding({
      judul: 'Kasus 1: Teks Panjang di dalam Row',
      kolom: [
        {
          ikon: 'galat', judul: 'SALAH', warna: C.accent5, tag: 'A RenderFlex overflowed by 306 pixels on the right.',
          poin: ['Pita kuning-hitam; tersedia 296 piksel, isinya kelebihan 306 piksel'],
          contoh: [
            'Row(',
            '  children: [',
            '    Icon(Icons.event),',
            '    SizedBox(width: 12),',
            '    Text(judul), // judul sangat panjang',
            '    SizedBox(width: 12),',
            "    Text('08.00'),",
            '  ],',
            ')',
          ].join('\n'),
        },
        {
          ikon: 'centang', judul: 'BENAR', warna: C.accent4, sorot: true, tag: 'Expanded memberi Text SISA lebar Row',
          poin: ['Judul turun baris; pesan galatnya sendiri menyarankan Expanded'],
          contoh: [
            'Row(',
            '  children: [',
            '    Icon(Icons.event),',
            '    SizedBox(width: 12),',
            '    Expanded(child: Text(judul)),',
            '    SizedBox(width: 12),',
            "    Text('08.00'),",
            '  ],',
            ')',
          ].join('\n'),
        },
      ],
      ukuranPoin: 16,
      ukuranContoh: 13,
      catatan: 'Pesan lengkapnya di Debug Console (modul Bagian 13.2): Exception caught by rendering library; The following assertion was thrown during layout: A RenderFlex overflowed by 306 pixels on the right. The relevant error-causing widget was: Row ...main.dart:164:24. ... Consider applying a flex factor (e.g. using an Expanded widget) to force the children of the RenderFlex to fit within the available space instead of being sized to their natural size. ... constraints: BoxConstraints(0.0<=w<=296.0, 0.0<=h<=440.0). RenderFlex adalah nama "mesin" di balik Row dan Column. Angka-angkanya bisa sedikit berbeda di layar Anda. Jika teksnya harus tetap satu baris, tambahkan maxLines: 1 dan overflow: TextOverflow.ellipsis pada Text, sehingga ujungnya diganti "…".',
    });

    d.banding({
      judul: 'Kasus 2: ListView di dalam Column',
      kolom: [
        {
          ikon: 'galat', judul: 'SALAH', warna: C.accent5, tag: 'Vertical viewport was given unbounded height.',
          poin: ['Daftar peserta tidak tampil sama sekali', 'Belasan galat: baca hanya yang PERTAMA'],
          contoh: [
            'Column(',
            '  children: [',
            "    Text('30 peserta terdaftar'),",
            '    ListView(children: [...]), // 30 ListTile',
            '  ],',
            ')',
          ].join('\n'),
        },
        {
          ikon: 'centang', judul: 'BENAR', warna: C.accent4, sorot: true, tag: 'Expanded memberi ListView SISA tinggi Column',
          poin: ['Daftar PENDEK: ListView(shrinkWrap: true, ...) setinggi isinya', 'Jangan untuk daftar panjang: semua isinya dibangun sekaligus'],
          contoh: [
            'Column(',
            '  children: [',
            "    Text('30 peserta terdaftar'),",
            '    Expanded(child: ListView(children: [...])),',
            '  ],',
            ')',
          ].join('\n'),
        },
      ],
      ukuranPoin: 16,
      ukuranContoh: 12.5,
      catatan: 'Viewport adalah "jendela" milik ListView, dan ia ingin setinggi ruang yang tersedia. Column memberinya tinggi tak terbatas, sehingga ListView tidak tahu harus setinggi apa. Galat pertamanya: The following assertion was thrown during performResize(): Vertical viewport was given unbounded height. ... This situation typically happens when a scrollable widget is nested inside another scrollable widget. Sesudahnya menyusul galat lanjutan, misalnya Another exception was thrown: RenderBox was not laid out: RenderViewport#.... Dalam percobaan modul, satu kesalahan ini menghasilkan belasan galat; yang perlu dibaca hanya yang pertama (Bagian 10.6).',
    });

    d.kode({
      judul: 'Kasus 3: TextField di dalam Row',
      berkas: 'kode/contoh_10_memperbaiki_tata_letak.dart',
      kode: [
        '// SALAH',
        'Row(',
        '  children: [',
        "    TextField(decoration: InputDecoration(hintText: 'Tulis komentar')),",
        '    SizedBox(width: 8),',
        "    IconButton.filled(tooltip: 'Kirim komentar', onPressed: ..., icon: ...),",
        '  ],',
        ')',
        '',
        '// BENAR',
        'Row(',
        '  children: [',
        '    Expanded(',
        "      child: TextField(decoration: InputDecoration(hintText: 'Tulis komentar')),",
        '    ),',
        '    SizedBox(width: 8),',
        "    IconButton.filled(tooltip: 'Kirim komentar', onPressed: ..., icon: ...),",
        '  ],',
        ')',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 8.4,
      poin: [
        'Gejala: kolom komentar dan tombol kirim tidak tampil.',
        'Galat: An InputDecorator ... cannot have an unbounded width.',
        'Pesannya sudah menyebut obatnya: Expanded atau SizedBox.',
        'Lebar tetap: SizedBox(width: 200, child: TextField(...)).',
      ],
      catatan: 'TextField ingin selebar ruang yang tersedia, padahal Row memberinya lebar tak terbatas. Galat pertamanya: The following assertion was thrown during performLayout(): An InputDecorator, which is typically created by a TextField, cannot have an unbounded width. This happens when the parent widget does not provide a finite width constraint. For example, if the InputDecorator is contained by a Row, then its width must be constrained. An Expanded widget or a SizedBox can be used to constrain the width of the InputDecorator or the TextField that contains it.',
    });

    d.tabel({
      judul: 'Galat Lain yang Sering Muncul',
      kepala: ['Pesan galat', 'Penyebab umum', 'Solusi'],
      lebarKolom: [4.3, 4.1, 3.7],
      baris: [
        [kode('A RenderFlex overflowed by ... pixels on the bottom', 12), 'Isi Column lebih tinggi dari layar, sering saat papan ketik muncul', 'SingleChildScrollView, atau ListView'],
        [kode('Incorrect use of ParentDataWidget', 12), 'Expanded/Flexible di luar Row/Column/Flex; Positioned di luar Stack', 'Jadikan Expanded anak LANGSUNG Row/Column'],
        [kode('RenderBox was not laid out', 12), 'Hampir selalu AKIBAT galat lain', 'Gulir ke atas, baca galat pertama'],
        [kode('setState() or markNeedsBuild() called during build', 12), 'setState, showDialog, atau Navigator.push langsung di dalam build', 'Panggil dari callback tombol, atau addPostFrameCallback'],
        [kode('Horizontal viewport was given unbounded width', 12), 'ListView mendatar di dalam Row', 'Expanded, atau ukuran tetap dengan SizedBox'],
        [kode('BoxConstraints forces an infinite width', 12), 'Widget yang ingin selebar mungkin (misalnya SizedBox(width: double.infinity)) di dalam Row', 'Expanded, atau lebar yang pasti'],
      ],
      ukuran: 13,
      tinggiBaris: 0.7,
      catatan: 'Solusi lengkap dari modul Bagian 13.5: overflow di bawah → bungkus isi halaman dengan SingleChildScrollView, atau pakai ListView. ParentDataWidget → pindahkan Expanded agar menjadi anak langsung Row/Column. setState during build → panggil dari callback tombol, atau setelah gambar selesai dengan WidgetsBinding.instance.addPostFrameCallback. Ingat Bagian 7.5: tes widget di layar sempit dengan huruf 200% menangkap galat overflow secara otomatis, SEBELUM pengguna melihat pita kuning-hitam.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 14–16', judul: 'Cakupan, CI, Jenis Tes Lain, dan Proyek Akhir', ikon: 'sinkron', catatan: 'Melangkah lebih jauh: seberapa banyak kode yang sudah teruji, tes yang berjalan otomatis setiap push, dan jenis tes lain. Lalu kesalahan umum pemula, dan apa yang perlu disiapkan untuk proyek akhir.' });

    d.kartu({
      judul: 'Cakupan Kode (Coverage)',
      kolom: 3,
      item: [
        { ikon: 'tanya', judul: 'Apa itu cakupan?', isi: 'Baris kode mana saja yang PERNAH dijalankan oleh tes.' },
        { ikon: 'terminal', judul: 'Jalankan', isi: 'Hasil: coverage/lcov.info (setiap baris di lib/ + berapa kali).', kode: 'flutter test --coverage' },
        { ikon: 'lihat', judul: 'Baca di VS Code', isi: 'Panel Testing → Run Tests with Coverage: hijau dijalankan, merah tidak pernah; persentase per berkas.', warna: C.accent6 },
        { ikon: 'peringatan', judul: '100% ≠ bebas bug', isi: 'Dijalankan belum tentu DIPERIKSA: tes tanpa expect pun menaikkan cakupan.', warna: C.accent5 },
        { ikon: 'cari', judul: 'Pakai untuk...', isi: 'Menemukan bagian yang BELUM diuji, misalnya cabang kegagalan yang terlupa. Bukan target angka semata.', warna: C.accent4 },
        { ikon: 'folder', judul: 'Jangan di-commit', isi: 'Folder hasil buatan alat: tambahkan ke .gitignore.', kode: 'coverage/', warna: C.accent3 },
      ],
      catatan: 'Cakupan kode menjawab pertanyaan: "baris kode mana saja yang pernah dijalankan oleh tes?". flutter test --coverage menghasilkan berkas coverage/lcov.info, daftar setiap baris di lib/ beserta berapa kali baris itu dijalankan. Cara termudah membacanya adalah VS Code: buka panel Testing, lalu pilih Run Tests with Coverage; persentase cakupan setiap berkas ikut ditampilkan. Cakupan 100% TIDAK berarti bebas bug: baris yang "dijalankan" belum tentu "diperiksa". Gunakan cakupan untuk menemukan bagian yang belum diuji, bukan sebagai target angka semata.',
    });

    d.kode({
      judul: 'Tes Otomatis di GitHub (CI)',
      shell: true,
      kode: [
        'name: Tes Otomatis',
        'on:',
        '  push:',
        '    branches: [main]',
        '  pull_request:',
        'jobs:',
        '  tes:',
        '    runs-on: ubuntu-latest',
        '    steps:',
        '      - name: Ambil isi repositori',
        '        uses: actions/checkout@v5',
        '      - name: Pasang Flutter',
        '        uses: subosito/flutter-action@v2',
        '        with:',
        '          channel: stable',
        '          cache: true',
        '      - name: Unduh paket',
        '        run: flutter pub get',
        '      - name: Analisis kode',
        '        run: flutter analyze',
        '      - name: Jalankan semua tes',
        '        run: flutter test',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 5.6,
      tinggiKode: 4.9,
      poin: [
        'CI (Continuous Integration): "robot" yang menjalankan pemeriksaan SETIAP kali kode baru di-push.',
        'Berkas: .github/workflows/tes.yml di repositori proyek Anda.',
        'on: setiap push ke main dan setiap pull request. runs-on: komputer Linux milik GitHub.',
        'checkout mengambil kode, flutter-action memasang Flutter stable, lalu flutter analyze dan flutter test: sama seperti di laptop.',
        'Tab Actions: setiap commit diberi tanda centang (semua lulus) atau silang (ada yang gagal).',
      ],
      catatan: 'GitHub menyediakan CI lewat GitHub Actions, gratis untuk repositori publik. Jika ada tes yang merah, semua anggota tim langsung tahu, sebelum kesalahan menumpuk. Klik tanda di samping commit untuk membaca laporannya, persis seperti di terminal. Di slide, baris kosong pemisah antarbagian YAML dihapus agar muat. Repositori mata kuliah ini juga punya pemeriksaan otomatis yang menjalankan dart format, flutter analyze, dan flutter test untuk semua contoh tes Pertemuan 14 setiap ada perubahan.',
    });

    d.kode({
      judul: 'Tes Integrasi: Aplikasi Utuh di Perangkat',
      kode: [
        "import 'package:flutter_test/flutter_test.dart';",
        "import 'package:integration_test/integration_test.dart';",
        "import 'package:kasir_kantin/main.dart' as aplikasi;",
        '',
        'void main() {',
        '  IntegrationTestWidgetsFlutterBinding.ensureInitialized();',
        '',
        "  testWidgets('pesan dua nasi goreng mendapat diskon', (",
        '    WidgetTester tester,',
        '  ) async {',
        '    aplikasi.main();',
        '    await tester.pumpAndSettle();',
        '',
        "    await tester.tap(find.byTooltip('Tambah Nasi Goreng'));",
        "    await tester.tap(find.byTooltip('Tambah Nasi Goreng'));",
        '    await tester.pumpAndSettle();',
        '',
        "    expect(find.text('Rp5.000'), findsWidgets);",
        '  });',
        '}',
      ].join('\n'),
      ukuran: 11.5,
      lebarKode: 7.0,
      poin: [
        'pubspec.yaml: integration_test (sdk: flutter) di dev_dependencies; tes di folder integration_test/.',
        'flutter test integration_test/app_test.dart → pilih HP, emulator, atau desktop.',
        'Paling meyakinkan (huruf, ukuran layar, dan plugin sungguhan), tetapi jauh lebih lambat.',
        'Contoh ini mengandaikan ketiga bug Kasir Kantin sudah diperbaiki.',
      ],
      catatan: 'Paket integration_test ikut Flutter SDK. Tes ditulis dengan testWidgets yang sudah Anda kenal, tetapi aplikasinya benar-benar dijalankan di perangkat. Dua keterbatasan yang perlu diketahui: tes integrasi di Chrome membutuhkan chromedriver dan perintah flutter drive, dan tes integrasi tidak bisa mengetuk tampilan asli sistem operasi seperti dialog izin; untuk kebutuhan itu ada paket pihak ketiga seperti patrol.',
    });

    d.banding({
      judul: 'Tiruan (mock) dan Golden Test',
      kolom: [
        {
          ikon: 'puzzle', judul: 'mocktail / mockito', warna: C.accent6, tag: 'Tiruan (mock) yang dibuat paket',
          poin: [
            'when(...).thenAnswer(...) mengatur jawaban; verify(...).called(1) memeriksa jumlah panggilan',
            'Praktis untuk kasus yang sangat khusus; data palsu tetap pilihan modul ini',
          ],
          contoh: [
            'when(() => repositori.semua()).thenAnswer(',
            '  (_) async => const Berhasil(<Antrean>[]),',
            ');',
            '// ...',
            'verify(() => repositori.semua()).called(1);',
          ].join('\n'),
        },
        {
          ikon: 'galeri', judul: 'Golden test', warna: C.accent1, tag: 'Dibandingkan dengan gambar acuan, piksel demi piksel',
          poin: [
            'flutter test --update-goldens: membuat atau memperbarui gambar acuan',
            'Huruf kotak dan beda OS: buat dan periksa di OS yang sama, misalnya di CI',
          ],
          contoh: [
            'await expectLater(',
            '  find.byType(KartuHasil),',
            "  matchesGoldenFile('goldens/kartu_hasil.png'),",
            ');',
          ].join('\n'),
        },
      ],
      ukuranPoin: 16,
      ukuranContoh: 12.5,
      catatan: 'mocktail tidak memakai pembangkit kode; mockito memakai. Contoh di modul Bagian 14.4: class RepositoriAntreanTiruan extends Mock implements RepositoriAntrean {}, lalu di dalam tes when(...).thenAnswer(...) mengatur jawaban, AntreanViewModel dibuat dan muat() dipanggil (baris yang dilewati // ...), dan verify(...).called(1) memeriksa bahwa semua() dipanggil satu kali. Paketnya dipasang dengan flutter pub add dev:mocktail. Untuk repository yang dipakai banyak tes, data palsu biasanya lebih mudah dibaca dan dirawat: itulah pilihan panduan arsitektur resmi Flutter, dan pilihan modul ini. Golden test cocok untuk menjaga tampilan yang tidak boleh berubah tanpa sengaja; flutter test (tanpa pilihan) membandingkan dengan gambar acuan. Ingat, di lingkungan uji hurufnya kotak (Bagian 6.7), dan gambar bisa sedikit berbeda antara Windows, macOS, dan Linux.',
    });

    d.tabel({
      judul: 'Kesalahan Umum Pemula',
      kepala: ['Gejala', 'Solusi'],
      lebarKolom: [6.1, 6.0],
      baris: [
        ['flutter test berkata No tests ran, atau berkasnya dilewati', 'Nama berakhiran _test.dart, letakkan di folder test/'],
        ['Tes lulus padahal kodenya jelas salah', 'await di depan setiap Future, termasuk expectLater'],
        [kode('Expected: <55>  Actual: <54.99999999999999>', 13), 'Bulatkan, hitung dengan int, atau closeTo'],
        ['expect(kode(), throwsA(...)) gagal dengan exception', 'Bungkus dengan fungsi: expect(() => kode(), throwsA(...))'],
        ['Lulus jika dijalankan sendiri, gagal jika bersama', 'Buat objek baru di setUp'],
        ['Hasil tes berubah tergantung hari atau jam', 'Suntikkan jam, lalu buat tetap di tes'],
        ['Setelah tap, expect tidak menemukan perubahan', 'await tester.pump() setelah setiap aksi'],
        [kode('pumpAndSettle timed out', 13), 'pump(), atau buat datanya selesai dulu'],
        ['MissingPluginException di tes', 'Bungkus plugin di balik kontrak, atau palsukan dengan Fake'],
        ['Debug Console penuh galat merah', 'Gulir ke atas, baca galat PERTAMA'],
      ],
      ukuran: 14,
      tinggiBaris: 0.48,
      catatan: 'Tabel lengkap (17 baris) ada di modul Bagian 15, termasuk: test/widget_test.dart gagal setelah main.dart diganti (hapus berkas itu atau ganti isinya); tes gagal saat internet mati (pakai MockClient atau data palsu); kode setelah Future.delayed tidak pernah jalan di tes widget (pump(durasi) atau data palsu tanpa jeda); peringatan "would not hit test on the specified widget" (scrollUntilVisible lalu pumpAndSettle); tes berikutnya ikut memakai layar 320 piksel (addTearDown(tester.view.reset)); memperbaiki bug dengan menebak lalu muncul bug baru (ulangi bug, buat dugaan, buktikan dengan debugger, lalu kunci dengan tes); dan peringatan avoid_print (pakai debugPrint atau developer.log).',
    });

    d.banding({
      judul: 'Pengujian untuk Proyek Akhir',
      kolom: [
        {
          ikon: 'centang', judul: 'Wajib', warna: C.accent1, tag: 'Minimal tiga tes unit yang bermakna dan lulus', sorot: true,
          poin: [
            'Untuk ATURAN PENTING aplikasi, bukan hal sepele: diskon, validasi isian, total, penyaringan',
            'Setiap aturan berbatas diuji tepat di batas DAN selangkah di luarnya',
            'flutter test lulus di laptop Anda',
          ],
        },
        {
          ikon: 'bintang', judul: 'Dianjurkan', warna: C.accent4, tag: 'Melampaui syarat minimal',
          poin: [
            'Tes ViewModel dengan data palsu: memuat, berhasil, gagal',
            'Satu-dua tes widget layar utama, termasuk layar sempit + huruf besar',
            'Workflow GitHub Actions: setiap commit bertanda centang',
            'Setiap bug yang ditemukan saat demo dikunci dengan satu tes regresi',
          ],
        },
      ],
      ukuranPoin: 15,
      pesan: 'Komponen Pengujian bernilai 10 dari 100 poin. Contoh: keuangan → saldo dan batas anggaran; UMKM → harga diskon dan stok 0; presensi → jam buka-tutup; jadwal kuliah → bentrok.',
      catatan: 'Panduan Proyek Akhir mewajibkan minimal tiga tes unit yang bermakna dan lulus, termasuk menguji nilai batas. Contoh tes bermakna menurut tema (modul Bagian 16): pencatat keuangan mahasiswa → saldo setelah pemasukan dan pengeluaran, pengeluaran melebihi saldo ditolak, batas anggaran bulanan tepat tercapai; katalog produk UMKM → harga setelah diskon, stok 0 tidak bisa dipesan, jumlah pesanan maksimal; presensi kegiatan organisasi → jam buka dan tutup presensi, presensi ganda ditolak; informasi jadwal kuliah → jadwal bentrok terdeteksi, kelas berikutnya dihitung dari jam sekarang yang disuntikkan.',
    });

    d.tabel({
      judul: 'Memilih Alat yang Tepat',
      kepala: ['Kebutuhan', 'Pakai'],
      lebarKolom: [4.9, 7.2],
      baris: [
        ['Memeriksa fungsi atau kelas', kode('test() + expect()', 12)],
        ['Memeriksa exception', kode('expect(() => ..., throwsA(...))', 12)],
        ['Menguji Future yang gagal atau Stream', kode('await expectLater(..., throwsA / emitsInOrder)', 12)],
        ['Server palsu', kode('MockClient', 12)],
        ['Memeriksa keadaan "sedang memuat"', 'Data palsu yang ditahan dengan Completer'],
        ['Menguji layar', kode('testWidgets + pumpWidget + finder', 12)],
        ['Layar sempit, huruf besar, mode gelap', kode('tester.view, textScaleFactorTestValue, platformBrightnessTestValue', 11.5)],
        ['Plugin di tes', 'Kontrak + data palsu; extends Fake implements ...'],
        ['Angka salah tanpa galat', 'Breakpoint bersyarat + Debug Console'],
        ['Layar tidak berubah', 'Logpoint + breakpoint di build; periksa setState/notifyListeners'],
        ['Galat tata letak', 'Baca pesannya, Inspector + Flex explorer, Expanded'],
        ['Tes otomatis setiap push', 'GitHub Actions'],
      ],
      ukuran: 13,
      tinggiBaris: 0.4,
      catatan: 'Tabel lengkap di modul Bagian 17 juga memuat: membandingkan bilangan desimal → closeTo(nilai, toleransi); objek baru untuk setiap tes → setUp (dan tearDown untuk membereskan); repository palsu → data palsu yang memenuhi kontrak; mencari penyebab galat → galat pertama, stack trace, debugger. Minta mahasiswa memetakan proyek akhirnya ke tabel ini: bagian mana yang paling berisiko rusak, dan alat apa yang akan dipakai untuk mengujinya (Refleksi 3 di Jobsheet).',
    });

    d.ringkasan({
      poin: [
        '"Programnya jalan" bukan "programnya benar": 214 dari 1.030.301 kombinasi nilai mendapat huruf salah.',
        'Tiga jenis tes: unit, widget, integrasi. Banyak tes unit dan widget, integrasi secukupnya.',
        'Tes di test/ berakhiran _test.dart, pola siapkan → lakukan → periksa, dijalankan dengan flutter test.',
        'Matcher, throwsA, setUp/tearDown, group, tabel kasus; nilai batas adalah tempat bug bersembunyi.',
        'Asinkron: async/await, expectLater, matcher Stream. MockClient dan data palsu yang bisa gagal dan ditahan.',
        'Tes widget: pumpWidget, finder, tap/enterText, pump/pumpAndSettle; layar uji 800 × 600, huruf kotak.',
        'Uji semua keadaan layar, tombol mati, layar sempit + huruf besar, mode gelap, aksesibilitas.',
        'Plugin: bungkus di balik kontrak, atau palsukan dengan Fake yang disuntikkan lewat constructor.',
        'Debugging: galat pertama, stack trace, breakpoint (bersyarat), logpoint, Debug Console, DevTools.',
        'Tata letak: batasan turun, ukuran naik, induk menentukan posisi; obatnya Expanded. Cakupan + CI.',
      ],
      catatan: 'Minta mahasiswa menjelaskan dengan kata-kata sendiri: mengapa tes harus dilihat merah dulu sebelum hijau, dan apa bedanya pump() dengan pumpAndSettle().',
    });

    d.tabel({
      judul: 'Jobsheet: Lima Praktikum dan Tugas Mandiri',
      kepala: ['Praktikum', 'Isi', 'Tempat'],
      lebarKolom: [2.2, 7.0, 2.9],
      baris: [
        ['1', 'Aturan Kas Kelas dan tes unit pertama: nilai batas, membaca tes yang merah', 'DartPad atau VS Code'],
        ['2', 'ViewModel kas dengan repository palsu: tahan, lepaskan, jam palsu', 'DartPad atau VS Code'],
        ['3', 'Proyek "Kas Kelas": tampilan dan tes widget, layar 320 piksel, aksesibilitas', 'Proyek kas_kelas'],
        ['4', 'Kiriman Raka: empat bug, satu per satu, dikunci dengan tes regresi', 'Proyek kas_kelas'],
        ['5', '"Tugas Kuliahku" punya tes sendiri: cakupan dan GitHub Actions', 'Proyek tugas_kuliahku'],
        ['Tugas mandiri', '"Pinjam Alat Lab": aplikasi yang datang bersama tesnya (12 tes unit, 5 tes ViewModel, 5 tes widget, 1 tes aksesibilitas, CI)', 'Proyek pinjam_alat'],
      ],
      ukuran: 14,
      tinggiBaris: 0.66,
      catatan: 'Praktikum 1–4 membangun satu aplikasi secara bertahap: aturan kas (Praktikum 1) → ViewModel dan data palsu (Praktikum 2) → tampilan dan tes widget (Praktikum 3) → memburu bug kiriman teman (Praktikum 4). Praktikum 5 kembali ke proyek "Tugas Kuliahku" yang beristirahat sejak Pertemuan 12. Padanan di modul: Praktikum 1 ↔ Contoh 01 dan 02, Praktikum 2 ↔ Contoh 04, Praktikum 3 ↔ Contoh 05 dan 06, Praktikum 4 ↔ Contoh 09 dan 10, Praktikum 5 ↔ Contoh 08. Aturan hari ini: nama setiap tes berupa kalimat; lihat merah dulu, baru hijau; jika tes merah, perbaiki kodenya, bukan tesnya; setiap bug dikunci dengan tes regresi. Tugas mandiri juga meminta laporan cakupan lib/main.dart, workflow .github/workflows/tes.yml, dan CATATAN_DEBUGGING.md.',
    });

    d.penutup({
      judul: 'Saatnya Praktik!',
      subjudul: 'Kerjakan Jobsheet Pertemuan 14 (lima praktikum "Kas Kelas" dan "Tugas Kuliahku" + tugas Pinjam Alat Lab), lalu uji diri di Latihan. Pertemuan berikutnya: build, rilis, dan finalisasi proyek.',
      tautan: [
        { teks: 'Jobsheet P14', ikon: 'tugas', url: d.urlBerkas('pertemuan_14_pengujian_dan_debugging/JOBSHEET.md') },
        { teks: 'Latihan P14', ikon: 'kuis', url: d.urlBerkas('pertemuan_14_pengujian_dan_debugging/LATIHAN.md') },
        { teks: 'Proyek Akhir', ikon: 'roket', url: d.urlBerkas('panduan/05_proyek_akhir.md') },
      ],
      catatan: 'Proyek akhir: tulis minimal tiga tes unit yang bermakna untuk aturan terpenting aplikasi Anda, lengkap dengan nilai batas (Bagian 16). Pertemuan 15 membahas build, rilis, dan finalisasi proyek: identitas aplikasi, ikon, berkas rilis APK/AAB dan web, serta daftar periksa sebelum aplikasi sampai ke tangan pengguna. Tes yang Anda tulis hari ini menjadi pemeriksaan terakhir sebelum rilis.',
    });
  },
};

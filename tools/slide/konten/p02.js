// Konten slide Pertemuan 2 — Dasar Pemrograman Dart.
// Teks diambil dari modul bacaan (pertemuan_02_dasar_dart/README.md).

const MERAH = 'C62828';

module.exports = {
  nomor: '02',
  folder: 'pertemuan_02_dasar_dart',
  namaBerkas: 'PERTEMUAN_02_Dasar_Dart',
  topik: 'Dasar Pemrograman Dart',

  bangun(d) {
    const C = d.C;
    const MONO = { bold: true, fontFace: 'Consolas' };

    d.judul({
      judul: 'Dasar Pemrograman Dart',
      subjudul: 'Pertemuan 2  ·  Variabel, null safety, operator, percabangan, perulangan, fungsi, dan koleksi data',
      catatan: 'Hari ini fokus pada bahasa Dart murni (tanpa tampilan). Semua contoh bisa dijalankan di DartPad, jadi mahasiswa bisa berlatih dari HP sekalipun.',
    });

    d.tujuan({
      pengantar: 'Setelah pertemuan ini, Anda mampu:',
      poin: [
        'Menjalankan program Dart di DartPad maupun terminal',
        'Memakai variabel, tipe data, final, dan const dengan tepat',
        'Menangani nilai kosong dengan null safety',
        'Mengatur alur program dengan percabangan dan perulangan',
        'Membuat fungsi dengan parameter posisi maupun bernama',
        'Mengolah banyak data dengan List, Set, dan Map',
      ],
      catatan: 'Sampaikan bahwa materi ini adalah fondasi: setiap baris kode Flutter berikutnya ditulis dalam Dart.',
    });

    d.alur({
      judul: 'Peta Materi Hari Ini',
      langkah: [
        { ikon: 'kotak', judul: 'Menyimpan data', isi: 'Variabel, tipe data, final/const, null safety' },
        { ikon: 'hitung', judul: 'Mengolah data', isi: 'Operator aritmatika, perbandingan, logika' },
        { ikon: 'cabang', judul: 'Mengatur alur', isi: 'Percabangan dan perulangan' },
        { ikon: 'fungsi', judul: 'Membungkus logika', isi: 'Fungsi dan jenis-jenis parameter' },
        { ikon: 'daftar', judul: 'Banyak data', isi: 'List, Set, dan Map' },
        { ikon: 'tabel', judul: 'Studi kasus', isi: 'Rekap nilai satu kelas', warna: C.accent4 },
      ],
      catatan: 'Urutannya seperti tangga: setiap anak tangga memakai anak tangga sebelumnya.',
    });

    d.banding({
      judul: 'Dua Cara Menjalankan Kode Dart',
      kolom: [
        {
          ikon: 'web', judul: 'DartPad', warna: C.accent1, sorot: true, tag: '✓ Disarankan untuk pertemuan ini',
          poin: ['Buka dartpad.dev di browser (bisa dari HP)', 'Tempel kode, klik Run', 'Hasil muncul di panel Output', 'Tanpa instalasi apa pun'],
        },
        {
          ikon: 'terminal', judul: 'Terminal', warna: C.text2, tag: 'Dart sudah ikut terpasang bersama Flutter',
          poin: ['Cek: dart --version', 'Simpan kode sebagai halo.dart', 'Jalankan: dart run halo.dart', 'Di VS Code: klik Run di atas void main()'],
        },
      ],
      pesan: 'DartPad menampilkan 100.0 sebagai 100, sedangkan terminal menampilkan 100.0. Nilainya sama; hanya tampilannya yang berbeda.',
      catatan: 'Demo cepat: buka DartPad, tempel contoh 01, klik Run.',
    });

    d.kode({
      judul: 'Anatomi Program Dart',
      berkas: 'kode/01_halo_dart.dart',
      kode: [
        '// Komentar satu baris: diabaikan komputer',
        '',
        '/* Komentar',
        '   beberapa baris */',
        '',
        'void main() {',
        "  print('Halo, Dart!');",
        '  print(10 + 5); // hasilnya 15',
        '}',
      ].join('\n'),
      ukuran: 17,
      poin: [
        'main() adalah pintu masuk: program selalu mulai dari sini.',
        '{ } membentuk blok: kumpulan perintah yang menjadi satu kesatuan.',
        'Setiap perintah diakhiri titik koma ( ; ). Lupa titik koma adalah kesalahan paling umum!',
        'Dart membedakan huruf besar dan kecil: main, Main, dan MAIN adalah tiga nama berbeda.',
      ],
      catatan: 'Tekankan titik koma dan case-sensitive. Minta mahasiswa menebak apa yang terjadi jika main ditulis Main.',
    });

    d.bagian({ label: 'BAGIAN 1', judul: 'Menyimpan Data', ikon: 'kotak' });

    d.kode({
      judul: 'Variabel = Toples Berlabel',
      berkas: 'kode/02_variabel_dan_tipe_data.dart',
      kode: [
        "String nama = 'Siti Aminah'; // teks",
        'int umur = 19;               // bilangan bulat',
        'double ipk = 3.75;           // desimal (titik!)',
        'bool sudahLulus = false;     // true / false',
        '',
        "var kota = 'Samarinda';      // ditebak: String",
        'umur = 20;                   // boleh: tetap int',
        "// umur = 'dua puluh';       // ERROR: beda tipe",
        '',
        "int tahun = int.parse('2026');  // teks -> int",
        'print(ipk.toStringAsFixed(1));  // 3.8',
      ].join('\n'),
      poin: [
        'Setiap toples punya label (nama) dan jenis isi (tipe). Kopi tidak dituang ke toples garam.',
        'var: Dart menebak tipe dari nilai awal, lalu tipenya terkunci.',
        'Kesalahan tipe langsung ditandai garis merah sebelum program dijalankan.',
        'Data dari formulir berupa teks; ubah dengan int.parse() atau double.parse().',
      ],
      catatan: 'Gunakan analogi toples di dapur. Tunjukkan bahwa membuka komentar baris umur = dua puluh langsung memunculkan error di editor.',
    });

    d.tabel({
      judul: 'Tipe Data Dasar',
      kepala: ['Tipe', 'Isi', 'Contoh'],
      lebarKolom: [1.4, 4, 3],
      baris: [
        [{ text: 'int', options: MONO }, 'Bilangan bulat', '19, -5, 2026'],
        [{ text: 'double', options: MONO }, 'Bilangan desimal (memakai titik, bukan koma)', '3.75, 165.5'],
        [{ text: 'num', options: MONO }, 'Boleh int atau double', '30, 30.5'],
        [{ text: 'String', options: MONO }, 'Teks, diapit tanda kutip', "'Samarinda'"],
        [{ text: 'bool', options: MONO }, 'Hanya dua kemungkinan', 'true, false'],
        [{ text: 'dynamic', options: Object.assign({ color: MERAH }, MONO) }, { text: 'Boleh berganti tipe sesuka hati: HINDARI', options: { color: MERAH } }, 'Pemeriksa tipe jadi tidak bisa melindungi Anda'],
      ],
      pesan: 'Nama variabel memakai lowerCamelCase dan harus bermakna: jumlahMahasiswa, bukan x atau jml2.',
      catatan: 'Tipe koleksi (List, Set, Map) dibahas di Bagian 5.',
    });

    d.kode({
      judul: 'String dan Interpolasi',
      berkas: 'kode/03_string_dan_interpolasi.dart',
      kode: [
        "String namaDepan = 'Budi';",
        '',
        "print('Halo, $namaDepan!');",
        '// Halo, Budi!',
        "print('Panjang: ${namaDepan.length} huruf');",
        '// Panjang: 4 huruf',
        "print('5 x 4 = ${5 * 4}');",
        '// 5 x 4 = 20',
        '',
        "print('  Hai  '.trim());           // Hai",
        "print('Flutter'.substring(0, 3));  // Flu",
        "print('a,b'.split(','));           // [a, b]",
      ].join('\n'),
      poin: [
        '$nama menyisipkan isi variabel ke dalam teks.',
        '${...} menyisipkan ekspresi, misalnya perhitungan 5 * 4 atau namaDepan.length.',
        'Interpolasi lebih dianjurkan daripada menggabung teks dengan tanda +.',
        "Gaya Dart: kutip tunggal, kecuali teksnya berisi kutip tunggal (\"Jum'at\").",
      ],
      catatan: 'Tunjukkan bahwa linter akan menyarankan interpolasi jika mahasiswa menulis "Halo, " + nama.',
    });

    d.kode({
      judul: 'final dan const: Nilai yang Terkunci',
      berkas: 'kode/04_final_dan_const.dart',
      kode: [
        '// const: pasti SEBELUM program berjalan',
        'const int jumlahHariSeminggu = 7;',
        "const List<String> hari = ['Senin', 'Rabu'];",
        '',
        '// final: diisi SEKALI saat program berjalan',
        'final DateTime waktuMulai = DateTime.now();',
        "final String namaPengguna = 'Rina';",
        '',
        "// namaPengguna = 'Andi';        // ERROR",
        '// const waktu = DateTime.now(); // ERROR',
      ].join('\n'),
      poin: [
        'const ibarat tanggal Proklamasi: sudah pasti sejak awal.',
        'final ibarat nomor antrean bank: baru diketahui saat mengambil tiket, lalu tidak berubah.',
        'Kebiasaan baik: jika nilainya tidak akan berubah, jadikan final atau const.',
        'Di Flutter, widget const membuat Flutter bisa menghemat kerja saat menggambar ulang.',
      ],
      catatan: 'Tanyakan ke mahasiswa: waktu login, batas nilai maksimal, dan nama hari, masing-masing cocok memakai apa?',
    });

    d.bagian({ label: 'BAGIAN 2', judul: 'Null Safety: Aman dari Kotak Kosong', ikon: 'gembok' });

    d.tabel({
      judul: 'Perkakas Null Safety',
      pengantar: 'Secara bawaan, variabel Dart TIDAK BOLEH null. Jika boleh kosong, wajib ditandai ? (nullable).',
      kepala: ['Operator', 'Dibaca', 'Contoh', 'Jika x null'],
      lebarKolom: [1.2, 3.2, 2.2, 2.6],
      baris: [
        [{ text: '?', options: MONO }, 'boleh kosong', { text: 'String? x;', options: { fontFace: 'Consolas' } }, '—'],
        [{ text: '??', options: MONO }, 'jika kosong, pakai cadangan', { text: "x ?? 'Tamu'", options: { fontFace: 'Consolas' } }, "'Tamu'"],
        [{ text: '?.', options: MONO }, 'akses hanya jika ada isinya', { text: 'x?.length', options: { fontFace: 'Consolas' } }, 'null (tidak crash)'],
        [{ text: '??=', options: MONO }, 'isi hanya jika masih kosong', { text: "x ??= 'Tamu';", options: { fontFace: 'Consolas' } }, "x menjadi 'Tamu'"],
        [{ text: '!', options: Object.assign({ color: MERAH }, MONO) }, 'saya JAMIN tidak kosong', { text: 'x!.length', options: { fontFace: 'Consolas' } }, { text: 'CRASH', options: { bold: true, color: MERAH } }],
      ],
      pesan: 'Hemat memakai ! dan late. Keduanya janji kepada Dart; jika dilanggar, aplikasi crash saat berjalan.',
      catatan: 'Analogi kotak kado kosong. Tony Hoare, penemu referensi null, menyebutnya "kesalahan miliaran dolar".',
    });

    d.kode({
      judul: 'Null Safety dalam Praktik',
      berkas: 'kode/05_null_safety.dart',
      kode: [
        "String nama = 'Dewi';                  // tak boleh null",
        'String? panggilan = cariPanggilan(nama); // boleh null',
        '',
        'print(panggilan ?? nama);   // Dewi',
        'print(panggilan?.length);   // null, tidak crash',
        "panggilan ??= 'Dede';       // isi jika masih null",
        '',
        "int? umur = int.tryParse('dua puluh'); // null",
        'print(umur ?? 0);           // 0',
        '',
        "String? email = cariEmail('Andi');",
        'if (email != null) {',
        '  print(email.length);      // aman: sudah dicek',
        '}',
      ].join('\n'),
      ukuran: 14,
      poin: [
        'int.tryParse() menghasilkan null jika teks gagal diubah menjadi angka.',
        'Membaca isi Map juga menghasilkan nilai nullable, karena kuncinya bisa saja tidak ada.',
        'Setelah dicek if (x != null), Dart tahu x aman dipakai (type promotion).',
        'Pemeriksaan if lebih aman daripada tanda !.',
      ],
      catatan: 'Contoh 05 di repositori memakai fungsi cariNamaPanggilan() dan cariKota() agar nilai null benar-benar berasal dari data.',
    });

    d.bagian({ label: 'BAGIAN 3', judul: 'Mengolah Data & Mengatur Alur', ikon: 'cabang' });

    const sOp = d.tabel({
      judul: 'Operator Aritmatika',
      kepala: ['Operator', 'Arti', 'Contoh', 'Hasil'],
      lebarKolom: [1.3, 4.2, 2, 1.5],
      baris: [
        [{ text: '+', options: MONO }, 'Tambah', '17 + 5', '22'],
        [{ text: '-', options: MONO }, 'Kurang', '17 - 5', '12'],
        [{ text: '*', options: MONO }, 'Kali', '17 * 5', '85'],
        [{ text: '/', options: MONO }, 'Bagi (hasilnya SELALU double)', '17 / 5', '3.4'],
        [{ text: '~/', options: MONO }, 'Bagi bulat (desimal dibuang)', '17 ~/ 5', '3'],
        [{ text: '%', options: MONO }, 'Sisa bagi (modulo); genap jika x % 2 == 0', '17 % 5', '2'],
      ],
      batasBawah: 5.55,
      catatan: 'Lanjutkan dengan operator perbandingan (==, !=, >, <, >=, <=) dan logika: && (DAN), || (ATAU), ! (BUKAN). Ingatkan: = mengisi nilai, == membandingkan.',
    });
    d.tombolKode(sOp, { x: 0.6, y: 5.85, w: 7.4, berkas: 'kode/06_operator.dart' });

    d.kode({
      judul: 'Percabangan: if dan switch',
      berkas: 'kode/07_percabangan.dart',
      kode: [
        'String huruf;',
        'if (nilai >= 85) {',
        "  huruf = 'A';",
        '} else if (nilai >= 70) {',
        "  huruf = 'B';",
        '} else {',
        "  huruf = 'C';",
        '}',
        '',
        '// switch ekspresi (gaya Dart 3)',
        'String keterangan = switch (huruf) {',
        "  'A' => 'Sangat baik',",
        "  'B' => 'Baik',",
        "  _ => 'Perlu perbaikan',",
        '};',
      ].join('\n'),
      ukuran: 14,
      poin: [
        'Syarat diperiksa dari atas; berhenti di syarat PERTAMA yang benar.',
        'Biasakan selalu memakai kurung kurawal { } pada if.',
        'switch ekspresi langsung menghasilkan nilai; _ berarti "selain semua pilihan di atas".',
        'Di Dart 3, switch pernyataan tidak memerlukan break.',
      ],
      catatan: 'Telusuri alur untuk nilai 82: >= 85 salah, >= 70 benar, jadi huruf B.',
    });

    const sLoop = d.kartu({
      judul: 'Empat Jenis Perulangan',
      kolom: 4,
      tinggiKartu: 3.95,
      item: [
        { ikon: 'putar', judul: 'for', isi: 'Jumlah putaran sudah diketahui sejak awal.', kode: 'for (int i = 1;\n    i <= 3; i++) {\n  ...\n}' },
        { ikon: 'daftar', judul: 'for-in', isi: 'Mengolah setiap isi sebuah daftar satu per satu.', kode: 'for (String b\n    in buah) {\n  ...\n}' },
        { ikon: 'riwayat', judul: 'while', isi: 'Ulangi SELAMA syarat benar; bisa saja 0 kali.', kode: 'while (uang\n    >= 15000) {\n  ...\n}' },
        { ikon: 'ulang', judul: 'do-while', isi: 'Jalankan dulu, baru periksa; minimal 1 kali.', kode: 'do {\n  ...\n} while (x < 3);' },
      ],
      catatan: 'Jelaskan continue (lewati putaran ini) dan break (hentikan perulangan). Peringatkan infinite loop: hentikan dengan Ctrl+C di terminal atau muat ulang DartPad.',
    });
    d.tombolKode(sLoop, { x: 0.6, y: 5.85, w: 7.4, berkas: 'kode/08_perulangan.dart' });

    d.bagian({ label: 'BAGIAN 4', judul: 'Fungsi: Membungkus Logika', ikon: 'fungsi' });

    d.kode({
      judul: 'Fungsi Itu Seperti Mesin Jus',
      berkas: 'kode/09_fungsi_dasar.dart',
      kode: [
        '// tipe hasil, nama, parameter',
        'int tambah(int a, int b) {',
        '  return a + b; // serahkan hasilnya',
        '}',
        '',
        '// tidak mengembalikan nilai',
        'void sapa(String nama) {',
        "  print('Halo, $nama!');",
        '}',
        '',
        '// fungsi panah: isinya SATU ekspresi',
        'bool apakahLulus(int nilai) => nilai >= 60;',
      ].join('\n'),
      poin: [
        'Masukkan buah (parameter), mesin memproses, keluarlah jus (return).',
        'Fungsi tanpa nilai kembali bertipe void.',
        'Fungsi panah (=>) adalah ringkasan untuk isi satu ekspresi.',
        'Fungsi diberi nama agar bisa dipakai berulang: tambah(7, 8) menghasilkan 15.',
      ],
      catatan: 'Minta mahasiswa membuat fungsi kecil sendiri, misalnya kelilingPersegi(int sisi).',
    });

    const sParam = d.tabel({
      judul: 'Jenis-Jenis Parameter',
      kepala: ['Jenis', 'Penulisan', 'Cara memanggil'],
      lebarKolom: [1.8, 4, 3.4],
      baris: [
        [{ text: 'Posisi (wajib)', options: { bold: true } }, { text: 'perkenalan(String nama)', options: { fontFace: 'Consolas' } }, { text: "perkenalan('Andi')", options: { fontFace: 'Consolas' } }],
        [{ text: 'Posisi opsional', options: { bold: true } }, { text: 'perkenalan(String nama, [String? asal])', options: { fontFace: 'Consolas' } }, { text: "perkenalan('Andi', 'Balikpapan')", options: { fontFace: 'Consolas' } }],
        [{ text: 'Bernama', options: { bold: true } }, { text: 'hitungTotal({required int harga, int jumlah = 1})', options: { fontFace: 'Consolas' } }, { text: 'hitungTotal(harga: 15000, jumlah: 3)', options: { fontFace: 'Consolas' } }],
      ],
      ukuran: 15,
      batasBawah: 4.3,
      catatan: 'Hubungkan dengan Flutter: AppBar(title: ...) dan Text(..., style: ...) adalah parameter bernama. Fungsi anonim seperti onPressed: () { ... } adalah fungsi yang dikirim sebagai parameter.',
    });
    d.ikonBulat(sParam, { x: 0.6, y: 4.65, d: 0.6, ikon: 'lampu', warna: C.accent3 });
    sParam.addText([
      { text: 'Inilah kunci membaca kode Flutter! ', options: { bold: true } },
      { text: 'AppBar(title: ...) dan Text(\'Hai\', style: ...) memakai parameter bernama. Urutannya bebas dan maknanya langsung terbaca.' },
    ], { x: 1.4, y: 4.55, w: 11.3, h: 0.85, fontSize: 17, color: C.text1, valign: 'middle', margin: 0, isTextBox: true });
    d.tombolKode(sParam, { x: 0.6, y: 5.85, w: 7.4, berkas: 'kode/10_parameter_fungsi.dart' });

    d.bagian({ label: 'BAGIAN 5', judul: 'Koleksi: Mengelola Banyak Data', ikon: 'daftar' });

    const sKoleksi = d.banding({
      judul: 'List, Set, dan Map',
      tinggiKolom: 4.15,
      ukuranPoin: 18,
      kolom: [
        {
          ikon: 'daftar', judul: 'List', warna: C.accent1, tag: 'Antrean bernomor',
          poin: ['Berurutan, indeks mulai dari 0', 'Boleh ada isi kembar'],
          contoh: "['Apel', 'Mangga']",
        },
        {
          ikon: 'label', judul: 'Set', warna: C.accent6, tag: 'Daftar hadir unik',
          poin: ['Tidak ada isi kembar', 'Tidak memakai indeks'],
          contoh: "{'Andi', 'Budi'}",
        },
        {
          ikon: 'kunci', judul: 'Map', warna: C.accent4, tag: 'Kamus',
          poin: ['Pasangan kunci → nilai', 'Kunci tak ada → null'],
          contoh: "{'Apel': 12,\n 'Mangga': 5}",
        },
      ],
      catatan: 'Tanda <...> seperti List<String> menyatakan jenis isi koleksi.',
    });
    d.tombolKode(sKoleksi, { x: 0.6, y: 5.85, w: 5.85, berkas: 'kode/11_list.dart' });
    d.tombolKode(sKoleksi, { x: 6.85, y: 5.85, w: 5.85, berkas: 'kode/12_map_dan_set.dart' });

    d.kode({
      judul: 'Menyaring dan Mengubah Isi List',
      kode: [
        'List<int> nilai = [80, 65, 92, 47, 75];',
        'print(nilai[0]);    // 80 (indeks mulai 0!)',
        'nilai.add(88);      // tambah di akhir',
        '',
        '// where = SARING',
        'List<int> lulus =',
        '    nilai.where((int n) => n >= 60).toList();',
        '',
        '// map = UBAH setiap isi',
        'List<String> label =',
        "    nilai.map((int n) => 'Nilai $n').toList();",
        '',
        "Map<String, int> stok = {'Apel': 12};",
        "print(stok['Salak'] ?? 0);  // kunci tak ada -> 0",
      ].join('\n'),
      ukuran: 14,
      poin: [
        'where menyaring isi yang memenuhi syarat.',
        'map mengubah setiap isi menjadi bentuk lain.',
        'Akhiri dengan toList() agar hasilnya kembali menjadi List.',
        'Dua method ini akan sangat sering dipakai untuk menampilkan daftar data di Flutter.',
      ],
      catatan: 'Fungsi (int n) => n >= 60 adalah fungsi anonim yang dikirim sebagai parameter.',
    });

    d.kode({
      judul: 'Studi Kasus: Rekap Nilai Satu Kelas',
      berkas: 'kode/13_studi_kasus_rekap_nilai.dart',
      kode: [
        'Map<String, List<int>> kelas = {',
        "  'Andi': [85, 78, 90],",
        "  'Budi': [60, 55, 48],",
        '};',
        '',
        'for (MapEntry<String, List<int>> data in kelas.entries) {',
        '  List<int> n = data.value;',
        '  double akhir = hitungNilaiAkhir(',
        '      tugas: n[0], uts: n[1], uas: n[2]);',
        '  String huruf = nilaiHuruf(akhir);',
        '  // hitung jumlah lulus, total, nilai tertinggi',
        '}',
      ].join('\n'),
      ukuran: 14,
      poin: [
        'Pecah masalah besar menjadi kecil: satu fungsi menghitung nilai akhir (30% tugas, 30% UTS, 40% UAS), satu fungsi mengubah angka menjadi huruf.',
        'Data kelas disimpan dalam Map: nama → [tugas, UTS, UAS].',
        'Hasil: Andi 84,9 (B), Budi 53,7 (D), Citra 91,7 (A), Dewi 56,5 (C); rata-rata kelas 71,70.',
      ],
      catatan: 'Bahas Andi: 84,9 nyaris A, tetapi syaratnya >= 85. Dalam pemrograman, batas harus ditentukan dengan jelas sejak awal.',
    });

    d.tabel({
      judul: 'Kesalahan Umum Pemula',
      kepala: ['Pesan error', 'Penyebab dan solusi'],
      lebarKolom: [5, 4.2],
      baris: [
        ["Expected to find ';'.", 'Lupa titik koma; tambahkan ;'],
        ["A value of type 'double' can't be assigned to a variable of type 'int'.", 'Hasil / selalu double; pakai ~/ atau tipe double'],
        ["The argument type 'int' can't be assigned to the parameter type 'String'.", "Menggabung teks + angka; pakai interpolasi 'Umur: $umur'"],
        ["The non-nullable local variable 'x' must be assigned before it can be used.", 'Variabel dipakai sebelum diisi; beri nilai awal'],
        ['Null check operator used on a null value / Unexpected null value.', 'Tanda ! pada nilai null; pakai ?? atau cek if'],
        ['RangeError (index): Index out of range', 'Indeks mulai dari 0; indeks terakhir = length - 1'],
      ],
      ukuran: 16,
      catatan: 'Biasakan membaca baris pertama pesan error. Tabel lengkap ada di modul bagian 15.',
    });

    d.kartu({
      judul: 'Menulis Kode yang Rapi',
      kolom: 3,
      item: [
        { ikon: 'teks', judul: 'lowerCamelCase', isi: 'Untuk variabel dan fungsi: nilaiAkhir, hitungTotal()' },
        { ikon: 'label', judul: 'UpperCamelCase', isi: 'Untuk nama kelas: Mahasiswa, HalamanUtama' },
        { ikon: 'dokumen', judul: 'snake_case', isi: 'Untuk nama berkas: rekap_nilai.dart' },
        { ikon: 'lampu', judul: 'Nama bermakna', isi: 'jumlahLulus, bukan x atau jml2', warna: C.accent3 },
        { ikon: 'fungsi', judul: 'Satu fungsi, satu tugas', isi: 'nilaiHuruf() hanya mengubah angka menjadi huruf' },
        { ikon: 'kuas', judul: 'Format otomatis', isi: 'Shift+Alt+F di VS Code, tombol Format di DartPad', warna: C.accent6 },
      ],
      catatan: 'Kode dibaca jauh lebih sering daripada ditulis, termasuk oleh diri sendiri beberapa minggu kemudian.',
    });

    d.ringkasan({
      poin: [
        'Program Dart dimulai dari main(); setiap perintah diakhiri ; dan huruf besar/kecil dibedakan.',
        'Variabel punya tipe tetap: int, double, num, String, bool. var menebak tipe; hindari dynamic.',
        'Interpolasi $nama dan ${ekspresi} adalah cara terbaik menyusun teks.',
        'final diisi sekali saat berjalan; const pasti sejak sebelum berjalan.',
        'Null safety: tandai ? jika boleh null; pakai ??, ?., ??=, dan cek if. Hemat memakai !.',
        '/ selalu menghasilkan double, ~/ membagi bulat, % memberi sisa bagi; = berbeda dengan ==.',
        'Alur program: if, switch, for, for-in, while, do-while, break, continue.',
        'Fungsi + parameter bernama adalah kunci membaca kode Flutter; List, Set, Map untuk banyak data.',
      ],
      catatan: 'Minta mahasiswa menyebutkan satu operator null safety dan kapan memakainya.',
    });

    d.penutup({
      judul: 'Saatnya Praktik!',
      subjudul: 'Kerjakan Jobsheet Pertemuan 2 (lima praktikum + tantangan Kasir Kantin), lalu uji diri di Latihan. Pertemuan berikutnya: OOP dan pemrograman asinkron.',
      tautan: [
        { teks: 'Jobsheet P2', ikon: 'tugas', url: d.urlBerkas('pertemuan_02_dasar_dart/JOBSHEET.md') },
        { teks: 'Latihan P2', ikon: 'kuis', url: d.urlBerkas('pertemuan_02_dasar_dart/LATIHAN.md') },
        { teks: 'Modul P2', ikon: 'buku', url: d.urlBerkas('pertemuan_02_dasar_dart/README.md') },
      ],
      catatan: 'Praktikum dikerjakan di DartPad. Ingatkan untuk mengetik sendiri kode terbimbing, bukan menyalin.',
    });
  },
};


// Konten slide Pertemuan 7 — Material Design 3 & UI Responsif.
// Teks diambil dari modul bacaan (pertemuan_07_material3_dan_responsif/README.md).
// Tangkapan layar diambil dari folder pertemuan_07_material3_dan_responsif/gambar/.

module.exports = {
  nomor: '07',
  folder: 'pertemuan_07_material3_dan_responsif',
  namaBerkas: 'PERTEMUAN_07_Material3_dan_Responsif',
  topik: 'Material 3 & UI Responsif',

  bangun(d) {
    const C = d.C;

    d.judul({
      judul: 'Material Design 3 & UI Responsif',
      subjudul: 'Pertemuan 7  ·  tema, skema warna, tipografi, tema komponen, mode gelap, MediaQuery, LayoutBuilder, breakpoint, navigasi adaptif, dan pola daftar–detail',
      catatan: 'Hari ini ada dua tantangan tampilan: membuat semua halaman seragam (warna, huruf, bentuk) dari satu sumber, dan membuat tata letak menyesuaikan ukuran layar dari ponsel sampai laptop. Bekal: Row/Column/Expanded dan constraints (P4), setState dan SegmentedButton (P5), ListView/GridView dan Navigator (P6).',
    });

    d.tujuan({
      pengantar: 'Setelah pertemuan ini, Anda mampu:',
      poin: [
        'Mengatur tema dengan ThemeData dan membacanya lewat Theme.of(context)',
        'Membuat skema warna dari satu benih dan memakai peran warna beserta pasangan "on"',
        'Memakai 15 gaya huruf TextTheme, tema komponen, dan tema lokal',
        'Menyediakan mode gelap dan warna khusus (ThemeExtension)',
        'Membedakan MediaQuery dan LayoutBuilder, lalu memakai breakpoint Material 3',
        'Membuat navigasi adaptif dan pola daftar–detail, serta mengujinya di berbagai lebar',
      ],
      catatan: 'Target akhir hari ini: aplikasi Pustaka Kampus yang warnanya bisa diganti, punya mode gelap, memakai NavigationBar di ponsel dan NavigationRail di layar lebar, serta menampilkan daftar dan detail buku berdampingan mulai lebar 840.',
    });

    d.alur({
      judul: 'Peta Materi Hari Ini',
      langkah: [
        { ikon: 'palet', judul: 'A. Tampilan seragam', isi: 'Material 3, tema, skema warna, tipografi, tema komponen' },
        { ikon: 'gelap', judul: 'B. Tema yang berganti', isi: 'Mode gelap dan warna khusus' },
        { ikon: 'ukur', judul: 'C. Mengukur ruang', isi: 'MediaQuery, LayoutBuilder, breakpoint' },
        { ikon: 'responsif', judul: 'D. Tata letak adaptif', isi: 'NavigationBar ↔ NavigationRail, daftar–detail, ukuran huruf' },
        { ikon: 'buku', judul: 'E. Merangkai', isi: 'Studi kasus Pustaka Kampus', warna: C.accent4 },
      ],
      catatan: 'Bagian A dan B membuat semua halaman mengambil warna dan huruf dari satu sumber, sehingga mudah diganti, termasuk ke mode gelap. Bagian C dan D membuat tata letak menyesuaikan ukuran layar. Bagian E merangkai semuanya.',
    });

    d.tabel({
      judul: 'Dua Tantangan Tampilan dan Alatnya',
      kepala: ['Kebutuhan', 'Alat di Flutter'],
      lebarKolom: [6.0, 5.6],
      baris: [
        ['Warna dan huruf seragam di semua halaman', { text: 'ThemeData + Theme.of(context)', options: { fontFace: 'Consolas' } }],
        ['Satu warna merek menjadi palet lengkap', { text: 'ColorScheme.fromSeed', options: { fontFace: 'Consolas' } }],
        ['Semua tombol/kartu bergaya sama', 'Tema komponen (…ThemeData)'],
        ['Mode gelap', { text: 'darkTheme + themeMode', options: { fontFace: 'Consolas' } }],
        ['Mengetahui lebar jendela atau ruang widget', { text: 'MediaQuery, LayoutBuilder', options: { fontFace: 'Consolas' } }],
        ['Menu di bawah ↔ menu di samping', { text: 'NavigationBar ↔ NavigationRail', options: { fontFace: 'Consolas' } }],
      ],
      ukuran: 17,
      tinggiBaris: 0.62,
      pesan: 'Analogi: tema = buku panduan identitas visual kampus. Ganti panduannya sekali, semua spanduk ikut berubah.',
      catatan: 'Minta mahasiswa membuka Gmail atau Google Drive di ponsel dan di laptop, lalu bandingkan: warna dan huruf tetap seragam, tetapi susunannya berubah (menu bawah vs menu samping, satu panel vs dua panel).',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 1', judul: 'Material Design 3 dan Tema Aplikasi', ikon: 'palet', catatan: 'Sistem desain di balik Flutter, lalu cara memasang dan membaca tema.' });

    d.kartu({
      judul: 'Material Design 3: Sistem Desain Bawaan Flutter',
      pengantar: 'Sistem desain = aturan + komponen siap pakai agar tampilan konsisten. M3 menjadi bawaan sejak Flutter 3.16.',
      kolom: 3,
      tinggiKartu: 2.15,
      item: [
        { ikon: 'widget', judul: 'Komponen', isi: 'Tombol, kartu, kolom teks, navigasi, dialog: bentuk dan perilakunya sudah diatur.' },
        { ikon: 'palet', judul: 'Warna', isi: 'Setiap warna punya peran: primary, surface, error, dan pasangan "on"-nya.' },
        { ikon: 'huruf', judul: 'Tipografi', isi: 'Skala 15 gaya huruf untuk judul, isi bacaan, dan tulisan tombol.' },
        { ikon: 'bingkai', judul: 'Bentuk', isi: 'Sudut membulat dengan ukuran tertentu, misalnya kartu bersudut 12.' },
        { ikon: 'responsif', judul: 'Tata letak', isi: 'Breakpoint untuk ponsel, tablet, dan layar lebar.' },
        { ikon: 'kode', judul: 'Token desain', isi: 'Komponen membaca nilai bernama dari tema, bukan angka sembarangan.' },
      ],
      catatan: 'Panduan lengkap: m3.material.io. Mulai Flutter 3.47 tersedia juga paket material_ui (Material dipisah dari inti Flutter). Kuliah ini tetap memakai package:flutter/material.dart; nama class-nya sama persis, yang berbeda hanya baris import.',
    });

    d.tabel({
      judul: 'Komponen Membaca Token dari Tema',
      kepala: ['Komponen', 'Warna latar bawaan', 'Gaya huruf bawaan'],
      lebarKolom: [3.4, 4.6, 3.6],
      baris: [
        [{ text: 'AppBar', options: { fontFace: 'Consolas' } }, 'surface', 'judul: titleLarge'],
        [{ text: 'FilledButton', options: { fontFace: 'Consolas' } }, 'primary', 'labelLarge'],
        [{ text: 'FilledButton.tonal', options: { fontFace: 'Consolas' } }, 'secondaryContainer', 'labelLarge'],
        [{ text: 'FloatingActionButton', options: { fontFace: 'Consolas' } }, 'primaryContainer', '—'],
        [{ text: 'Card', options: { fontFace: 'Consolas' } }, 'surfaceContainerLow', '—'],
        [{ text: 'NavigationBar', options: { fontFace: 'Consolas' } }, 'surfaceContainer (indikator: secondaryContainer)', 'labelMedium'],
        [{ text: 'SnackBar', options: { fontFace: 'Consolas' } }, 'inverseSurface', '—'],
      ],
      ukuran: 15,
      tinggiBaris: 0.55,
      pesan: 'Karena semua komponen membaca tema, mengganti tema = mengganti tampilan seluruh aplikasi.',
      catatan: 'Nilai di tabel ini dibuktikan dari kode sumber Flutter 3.47 (kelas _...DefaultsM3). Mahasiswa tidak perlu menghafal; yang penting paham bahwa komponen tidak memakai warna acak.',
    });

    d.layar({
      judul: 'Tema Dipasang Sekali, Dibaca di Mana Saja',
      gambar: ['hasil_contoh_01a.jpg', 'hasil_contoh_01b.jpg'],
      lebarMaks: 5.6,
      berkas: 'kode/contoh_01_tema_dan_theme_of.dart',
      kode: [
        'MaterialApp(',
        '  theme: ThemeData(',
        '    colorScheme: ColorScheme.fromSeed(',
        '      seedColor: warnaBenih, // teal / deepOrange',
        '    ),',
        '  ),',
        ')',
        '',
        '// di dalam build() sebuah widget:',
        'final ColorScheme warna =',
        '    Theme.of(context).colorScheme;',
        'final TextTheme gayaTeks =',
        '    Theme.of(context).textTheme;',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        'Kiri: benih teal. Kanan: benih deepOrange.',
        'Kartu A (dari tema) ikut berubah; Kartu B (warna ditulis langsung) tetap biru.',
      ],
      ukuranPoin: 15,
      catatan: 'Jalankan contoh 01, lalu ganti warnaBenih dan jalankan ulang. Theme.of(context) mencari tema terdekat di atas widget. titleLarge bertipe TextStyle?, maka dipakai ?.copyWith(color: ...).',
    });

    d.banding({
      judul: 'Warna Ditulis Langsung vs Diambil dari Tema',
      ukuranContoh: 12,
      kolom: [
        {
          ikon: 'galat', judul: 'Ditulis langsung', warna: C.accent5, tag: 'Tidak seragam dan sulit diganti',
          poin: [
            'Halaman lain bisa memakai biru yang sedikit berbeda',
            'Mengganti warna = mencari setiap Color(...)',
            'Rusak di mode gelap',
          ],
          contoh: "color: const Color(0xFFE3F2FD),\nstyle: TextStyle(\n  fontSize: 22,\n  color: Color(0xFF0D47A1),\n),",
        },
        {
          ikon: 'centang', judul: 'Dari tema', warna: C.accent4, tag: 'Satu sumber, ikut berganti', sorot: true,
          poin: [
            'Warna dari peran ColorScheme',
            'Ukuran dari gaya TextTheme',
            'Otomatis cocok di mode gelap',
          ],
          contoh: 'color: warna.primaryContainer,\nstyle: gayaTeks.titleLarge?.copyWith(\n  color: warna.onPrimaryContainer,\n),',
        },
      ],
      catatan: 'Aturan hari ini: di dalam halaman jangan menulis Colors.xxx, Color(0xFF...), maupun fontSize. Pengecualian hanya di ThemeData.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 2', judul: 'Skema Warna: Satu Benih, Banyak Peran', ikon: 'kontras', catatan: 'ColorScheme.fromSeed, peran warna, dan aturan pasangan "on".' });

    d.tabel({
      judul: 'Warna Punya Peran, Bukan Sekadar Nama',
      kepala: ['Peran', 'Kegunaan', 'Contoh pemakaian bawaan'],
      lebarKolom: [3.6, 3.9, 4.1],
      baris: [
        [{ text: 'primary', options: { fontFace: 'Consolas' } }, 'Aksi paling penting', 'FilledButton, bilah kemajuan'],
        [{ text: 'primaryContainer', options: { fontFace: 'Consolas' } }, 'Wadah yang ditonjolkan', 'FloatingActionButton'],
        [{ text: 'secondary(Container)', options: { fontFace: 'Consolas' } }, 'Unsur pendukung', 'FilledButton.tonal, chip terpilih'],
        [{ text: 'tertiary(Container)', options: { fontFace: 'Consolas' } }, 'Aksen pembeda', 'Penanda khusus'],
        [{ text: 'error(Container)', options: { fontFace: 'Consolas' } }, 'Kesalahan, aksi berbahaya', 'Pesan error TextField, Badge'],
        [{ text: 'surface…Container…', options: { fontFace: 'Consolas' } }, 'Latar halaman dan latar bertingkat', 'Scaffold, Card, NavigationBar'],
        [{ text: 'outline(Variant)', options: { fontFace: 'Consolas' } }, 'Garis tepi dan pemisah', 'TextField, Divider'],
      ],
      ukuran: 15,
      tinggiBaris: 0.55,
      pesan: 'Teks atau ikon DI ATAS warna X memakai warna onX: onPrimary, onPrimaryContainer, onSurface, ...',
      catatan: 'Analogi: peran dalam pentas seni. Kostum boleh berganti setiap tahun (biru, hijau, mode gelap), perannya tetap. Pasangan "on" dijamin kontras di mode terang maupun gelap.',
    });

    d.layar({
      judul: 'ColorScheme.fromSeed: Palet Lengkap dari Satu Warna',
      gambar: ['hasil_contoh_02a.jpg', 'hasil_contoh_02b.jpg'],
      lebarMaks: 5.6,
      berkas: 'kode/contoh_02_peran_warna.dart',
      kode: [
        'final ColorScheme skema =',
        '    ColorScheme.fromSeed(',
        '  seedColor: _benih.warna,',
        '  brightness: _gelap',
        '      ? Brightness.dark',
        '      : Brightness.light,',
        '  dynamicSchemeVariant: _varian,',
        ');',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        'tonalSpot (bawaan) menjinakkan benih: primary tidak sama persis dengan benih.',
        'fidelity = setia pada benih; monochrome = abu-abu saja.',
        'contrastLevel -1.0 sampai 1.0 untuk kontras lebih tinggi.',
      ],
      ukuranPoin: 15,
      catatan: 'Coba: ganti benih Biru ke Oranye, nyalakan Mode gelap, pilih varian monochrome lalu vibrant. Gulir ke bawah untuk melihat tangga surfaceContainer (Lowest sampai Highest).',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 3', judul: 'Tipografi dan Tema Komponen', ikon: 'huruf', catatan: '15 gaya huruf siap pakai, lalu mengatur semua komponen sejenis sekaligus.' });

    d.tabel({
      judul: 'Skala Huruf Material 3',
      kepala: ['Kelompok', 'Large', 'Medium', 'Small', 'Dipakai untuk'],
      lebarKolom: [2.1, 1.3, 1.5, 1.4, 5.3],
      baris: [
        [{ text: 'display', options: { bold: true } }, '57', '45', '36', 'Angka/teks pendek yang sangat besar'],
        [{ text: 'headline', options: { bold: true } }, '32', '28', '24', 'Judul halaman atau bagian penting'],
        [{ text: 'title', options: { bold: true } }, '22', '16 · tebal', '14 · tebal', 'Judul AppBar, kartu, bagian kecil'],
        [{ text: 'body', options: { bold: true } }, '16', '14', '12', 'Isi bacaan: paragraf, keterangan'],
        [{ text: 'label', options: { bold: true } }, '14 · tebal', '12 · tebal', '11 · tebal', 'Tulisan tombol, chip, keterangan kecil'],
      ],
      ukuran: 16,
      tinggiBaris: 0.62,
      pesan: 'Pilih gaya berdasarkan PERAN teks, bukan ukuran yang "kelihatannya pas". Contoh: Theme.of(context).textTheme.headlineSmall',
      catatan: '"Tebal" = FontWeight.w500. Komponen sudah memilih gayanya sendiri: judul AppBar titleLarge, tulisan tombol labelLarge, judul ListTile bodyLarge, subjudul bodyMedium.',
    });

    d.layar({
      judul: 'Membuktikan Skala Huruf',
      gambar: ['hasil_contoh_03a.jpg', 'hasil_contoh_03b.jpg'],
      lebarMaks: 5.6,
      berkas: 'kode/contoh_03_tipografi.dart',
      kode: [
        "Text('BERITA PRODI',",
        '  style: t.labelLarge?.copyWith(',
        '    color: warna.primary,',
        '  ),',
        ')',
        "Text('Mahasiswa Informatika ...',",
        '  style: t.headlineSmall,',
        ')',
        '// ukuran dibaca dari gayanya:',
        '(gaya?.fontSize ?? 0).toStringAsFixed(0)',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        'Atas: artikel yang memakai gaya sesuai perannya.',
        'Bawah: ke-15 gaya beserta ukuran aslinya.',
      ],
      ukuranPoin: 15,
      catatan: 'Mengganti jenis huruf (pengayaan): daftarkan berkas huruf di pubspec.yaml lalu ThemeData(fontFamily: ...), atau pakai paket google_fonts.',
    });

    d.layar({
      judul: 'Tema Komponen: Atur Sekali untuk Semua',
      gambar: 'hasil_contoh_04.jpg',
      lebarMaks: 2.9,
      berkas: 'kode/contoh_04_tema_komponen.dart',
      kode: [
        'ThemeData(',
        '  colorScheme: skema,',
        '  appBarTheme: AppBarThemeData(',
        '    backgroundColor: skema.primaryContainer,',
        '    foregroundColor: skema.onPrimaryContainer,',
        '  ),',
        '  cardTheme: CardThemeData(elevation: 0, ...),',
        '  inputDecorationTheme: const InputDecorationThemeData(',
        '    filled: true,',
        '    border: OutlineInputBorder(),',
        '  ),',
        '  filledButtonTheme: FilledButtonThemeData(',
        '    style: FilledButton.styleFrom(',
        '      minimumSize: const Size.fromHeight(52),',
        '    ),',
        '  ),',
        ')',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Halaman formulir tidak berisi warna, garis, atau tinggi tombol sama sekali.',
        'Sejak Flutter 3.35 namanya berakhiran Data: AppBarThemeData, InputDecorationThemeData.',
      ],
      ukuranPoin: 15,
      catatan: 'Urutan prioritas: properti di widget > tema terdekat (tema lokal) > tema aplikasi > nilai bawaan M3. Hati-hati: Size.fromHeight(52) berarti lebar sebesar-besarnya; di dalam Row memicu error "BoxConstraints forces an infinite width" — bungkus dengan Expanded.',
    });

    d.kode({
      judul: 'Tema Lokal: Hanya untuk Sebagian Layar',
      berkas: 'kode/contoh_04_tema_komponen.dart',
      kode: [
        'Theme(',
        '  data: Theme.of(context).copyWith(',
        '    colorScheme: warna.copyWith(',
        '      primary: warna.error,',
        '      onPrimary: warna.onError,',
        '    ),',
        '  ),',
        '  child: FilledButton.icon(',
        '    onPressed: () {},',
        '    icon: const Icon(Icons.delete_outline),',
        "    label: const Text('Batalkan semua pendaftaran'),",
        '  ),',
        ')',
      ].join('\n'),
      ukuran: 15,
      lebarKode: 7.0,
      poin: [
        'copyWith = ambil tema yang berlaku, ganti sebagian isinya.',
        'Widget di dalam Theme membaca tema terdekat: tema lokal ini.',
        'Jebakan: Theme.of(context) di build yang SAMA dengan widget Theme baru masih membaca tema lama. Pindahkan bagian itu ke class tersendiri.',
      ],
      catatan: 'Tombol merah ini tetap selebar layar dan setinggi 52, karena filledButtonTheme ikut tersalin oleh copyWith. Yang diganti hanya colorScheme.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 4', judul: 'Mode Gelap dan Warna Khusus', ikon: 'gelap', catatan: 'theme, darkTheme, themeMode, state di akar aplikasi, dan ThemeExtension.' });

    d.layar({
      judul: 'Mode Gelap: Dua Tema, Satu Pilihan',
      gambar: ['hasil_contoh_05a.jpg', 'hasil_contoh_05b.jpg'],
      lebarMaks: 5.6,
      berkas: 'kode/contoh_05_mode_gelap.dart',
      kode: [
        'theme: ThemeData(colorScheme:',
        '  ColorScheme.fromSeed(seedColor: benih)),',
        'darkTheme: ThemeData(colorScheme:',
        '  ColorScheme.fromSeed(',
        '    seedColor: benih,',
        '    brightness: Brightness.dark,',
        '  )),',
        'themeMode: _mode, // system/light/dark',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        'Benih SAMA, brightness berbeda.',
        'Teks hitam dan kotak putih yang ditulis langsung rusak di mode gelap.',
      ],
      ukuranPoin: 15,
      catatan: 'Jika darkTheme tidak diisi, theme (terang) dipakai untuk semua pilihan. Jika brightness: Brightness.dark terlupa, "tema gelap" ternyata terang. Mode gelap M3 bukan hitam pekat: surface gelapnya sedikit bernuansa warna benih.',
    });

    d.alur({
      judul: 'Pilihan Mode Disimpan di Akar Aplikasi',
      pengantar: 'Nilai dipakai MaterialApp, tombolnya ada di halaman pengaturan → angkat state ke widget teratas yang membutuhkannya (Pertemuan 5).',
      langkah: [
        { ikon: 'pohon', judul: 'Akar (StatefulWidget)', isi: 'Menyimpan ThemeMode _mode' },
        { ikon: 'widget', judul: 'MaterialApp', isi: 'themeMode: _mode' },
        { ikon: 'setel', judul: 'Halaman pengaturan', isi: 'Menerima mode + onModeBerubah' },
        { ikon: 'tombol', judul: 'SegmentedButton', isi: 'Ketukan memanggil onModeBerubah' },
        { ikon: 'sinkron', judul: 'setState di akar', isi: 'Seluruh aplikasi berganti tema', warna: C.accent4 },
      ],
      catatan: 'Pilihan ini hilang saat aplikasi ditutup karena hanya disimpan di memori. Menyimpannya ke perangkat dipelajari di Pertemuan 11 (penyimpanan lokal).',
    });

    d.layar({
      judul: 'Warna Khusus dengan ThemeExtension',
      gambar: ['hasil_contoh_06a.jpg', 'hasil_contoh_06b.jpg'],
      lebarMaks: 5.6,
      berkas: 'kode/contoh_06_warna_khusus_theme_extension.dart',
      kode: [
        '// 1. class ... extends ThemeExtension<WarnaStatus>',
        '//    + copyWith() + lerp()',
        '// 2. daftarkan di tema terang & gelap:',
        'extensions: <ThemeExtension<dynamic>>[',
        '  WarnaStatus(',
        '    sukses: hijau.primaryContainer,',
        '    onSukses: hijau.onPrimaryContainer, ...',
        '  ),',
        '],',
        '// 3. baca di widget:',
        'tema.extension<WarnaStatus>()!',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'ColorScheme tidak punya "sukses" atau "peringatan".',
        'Pasangan warnanya dipinjam dari ColorScheme.fromSeed(seedColor: Colors.green) agar kontras terjamin.',
      ],
      ukuranPoin: 15,
      catatan: 'lerp = linear interpolation: mencampur dua warna saat tema berganti agar perubahannya halus. Label status juga menulis teks ("Aman", "Segera", "Terlambat"), bukan hanya warna, agar terbaca oleh pengguna yang sulit membedakan warna.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 5', judul: 'Tampilan yang Menyesuaikan Layar', ikon: 'responsif', catatan: 'Mengukur ruang, breakpoint Material 3, navigasi adaptif, daftar–detail, dan ukuran huruf.' });

    d.tabel({
      judul: 'Ragam Ukuran Layar (dalam Piksel Logis)',
      kepala: ['Perangkat', 'Lebar umum'],
      lebarKolom: [6.6, 5.0],
      baris: [
        ['Ponsel kecil / umum', '320–360 / 360–430'],
        ['Ponsel lanskap', '± 700–930'],
        ['Ponsel lipat yang dibuka', '± 600–850'],
        ['Tablet', '± 600–1400'],
        ['Laptop dan monitor', '1000 ke atas'],
      ],
      ukuran: 17,
      tinggiBaris: 0.6,
      pesan: 'Responsif = tampilan MUAT di ruang yang ada. Adaptif = komponen dan tata letak yang paling NYAMAN DIPAKAI di ruang itu.',
      catatan: 'Ponsel 1080 piksel fisik dengan rasio kerapatan 3 = 360 piksel logis. Prinsip dari dokumentasi Flutter: putuskan berdasarkan lebar jendela (bukan "apakah ini tablet"), jangan mengunci orientasi, jangan memilih tata letak dari orientasi, batasi lebar isi di layar lebar, dan pertahankan state saat ukuran berubah.',
    });

    d.banding({
      judul: 'Mengukur: MediaQuery vs LayoutBuilder',
      ukuranContoh: 12,
      kolom: [
        {
          ikon: 'layarpas', judul: 'MediaQuery', warna: C.accent1, tag: 'Seberapa besar JENDELA aplikasi?',
          poin: [
            'Keputusan tingkat halaman: navigasi, satu/dua panel',
            'sizeOf / widthOf: bangun ulang hanya saat ukuran/lebar berubah',
            'Hindari MediaQuery.of(context).size',
          ],
          contoh: 'final double lebar =\n    MediaQuery.widthOf(context);',
        },
        {
          ikon: 'ukur', judul: 'LayoutBuilder', warna: C.accent6, tag: 'Seberapa besar RUANG untuk widget ini?',
          poin: [
            'Widget yang dipakai di banyak tempat',
            'Membaca batasan (constraints) dari induk',
            'Ingat analogi panitia bazar (Pertemuan 4)',
          ],
          contoh: 'LayoutBuilder(\n  builder: (context, batasan) {\n    final bool sempit =\n        batasan.maxWidth < 240;',
        },
      ],
      catatan: 'Kartu di panel kanan selebar 400 pada jendela 1200: jika memakai MediaQuery ia mengira punya ruang 1200. Untuk keputusan seperti itu, pakai LayoutBuilder.',
    });

    d.layar({
      judul: 'Membuktikan: Jendela Sama, Ruang Berbeda',
      gambar: ['hasil_contoh_07a.jpg', 'hasil_contoh_07b.jpg'],
      lebarMaks: 7.2,
      berkas: 'kode/contoh_07_mediaquery_dan_layoutbuilder.dart',
      poin: [
        'Di lebar 360: "Kartu lebar" (ruang 296) mendatar, kartu Kiri/Kanan (ruang 128) tegak.',
        '296 = 360 − 32 (padding) − 8 (margin Card) − 24 (padding kartu).',
        'Di lebar 700 semua kartu cukup lega untuk mendatar.',
      ],
      ukuranPoin: 15,
      catatan: 'Kartu yang sama persis (class KartuAdaptif) menyesuaikan diri dengan ruangnya sendiri. SafeArea: bungkus isi yang menempel di tepi agar tidak tertutup poni kamera; perbedaannya baru terlihat di ponsel sungguhan.',
    });

    d.tabel({
      judul: 'Breakpoint Material 3',
      kepala: ['Breakpoint', 'Lebar jendela', 'Perangkat umum', 'Panel', 'Navigasi'],
      lebarKolom: [2.4, 2.0, 3.3, 1.5, 2.4],
      baris: [
        [{ text: 'Ringkas', options: { bold: true } }, '< 600', 'Ponsel tegak', '1', 'Navigation bar'],
        [{ text: 'Sedang', options: { bold: true } }, '600–839', 'Tablet tegak, lipat terbuka', '1 (atau 2)', 'Bar atau rail'],
        [{ text: 'Lebar', options: { bold: true } }, '840–1199', 'Ponsel/tablet lanskap, laptop', '2', 'Navigation rail'],
        [{ text: 'Besar', options: { bold: true } }, '1200–1599', 'Laptop, monitor', '2', 'Rail diperlebar'],
        [{ text: 'Ekstra besar', options: { bold: true } }, '≥ 1600', 'Monitor lebar', '1–3', 'Rail diperlebar'],
      ],
      ukuran: 15,
      tinggiBaris: 0.6,
      pesan: 'Satu baris tulisan sebaiknya 40–60 karakter di semua breakpoint → batasi lebar isi di layar besar.',
      catatan: 'Sumber: halaman Breakpoints di m3.material.io. Istilah lama: window size class. Batas bawah setiap kelas ikut masuk ke kelas itu: 840 sudah "lebar".',
    });

    d.layar({
      judul: 'Breakpoint sebagai enum',
      gambar: ['hasil_contoh_08a.jpg', 'hasil_contoh_08b.jpg'],
      lebarMaks: 6.4,
      berkas: 'kode/contoh_08_breakpoint_material3.dart',
      kode: [
        'enum KelasUkuran {',
        "  ringkas('Ringkas', kolom: 1, margin: 16),",
        "  sedang('Sedang', kolom: 2, margin: 24),",
        '  // ... lebar, besar, ekstraBesar',
        '  static KelasUkuran dari(double lebar) {',
        '    if (lebar < 600) {',
        '      return KelasUkuran.ringkas;',
        '    }',
        '    // ... 840, 1200, 1600',
        '  }',
        '}',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Kolom grid, margin, dan lebar isi maksimum mengikuti kelas.',
        'Center + ConstrainedBox(maxWidth: 1200) agar isi tidak membentang.',
      ],
      ukuranPoin: 14,
      catatan: 'Metode static dari(...) dipanggil sebagai KelasUkuran.dari(lebar). Kiri: lebar 360 (1 kolom); kanan: lebar 700 (2 kolom). Di jendela 1000 (gambar di modul) halaman memakai 3 kolom.',
    });

    d.layar({
      judul: 'Navigasi Adaptif: Abstraksi → Ukur → Cabangkan',
      gambar: ['hasil_contoh_09a.jpg', 'hasil_contoh_09b.jpg'],
      lebarMaks: 6.4,
      berkas: 'kode/contoh_09_navigasi_adaptif.dart',
      kode: [
        'final double lebar =',
        '    MediaQuery.widthOf(context);',
        'if (lebar < 600) {',
        '  return Scaffold(',
        '    bottomNavigationBar: NavigationBar(...),',
        '  );',
        '}',
        'final bool railLebar = lebar >= 1200;',
        'return Scaffold(body: Row(children: [',
        '  NavigationRail(extended: railLebar, ...),',
        '  const VerticalDivider(width: 1),',
        '  Expanded(child: isi),',
        ']));',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Data tujuan ditulis SEKALI (class Tujuan), dipakai kedua navigasi.',
        '_terpilih disimpan di atas percabangan: pilihan tetap saat ukuran berubah.',
      ],
      ukuranPoin: 14,
      catatan: 'Badge.count(count: 3, child: Icon(...)) memberi lencana angka. Peringatan: extended: true wajib labelType null atau none; jika .all → assertion error.',
    });

    d.layar({
      judul: 'Pola Daftar–Detail',
      gambar: ['hasil_contoh_10a.jpg', 'hasil_contoh_10c.jpg'],
      lebarMaks: 6.4,
      berkas: 'kode/contoh_10_daftar_detail.dart',
      kode: [
        'final bool duaPanel =',
        '    MediaQuery.widthOf(context) >= 840;',
        '// < 840: ketuk -> Navigator.push',
        '// >= 840: ketuk -> setState(_idTerpilih)',
        'Row(children: [',
        '  SizedBox(width: 360, child: DaftarPesan(...)),',
        '  const VerticalDivider(width: 1),',
        '  Expanded(child: DetailPesan(...)),',
        '])',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'DetailPesan dipakai di halaman detail DAN panel kanan.',
        'Baris terpilih ditandai: ListTile(selected: ..., selectedTileColor: ...).',
      ],
      ukuranPoin: 14,
      catatan: 'DaftarPesan tidak perlu tahu tata letaknya; ia hanya memanggil onPilih yang diberikan. Jika jendela diperlebar saat halaman detail terbuka, halaman itu tetap di atas sampai pengguna kembali — wajar untuk aplikasi latihan.',
    });

    d.layar({
      judul: 'Ukuran Huruf Pilihan Pengguna',
      gambar: ['hasil_contoh_11a.jpg', 'hasil_contoh_11b.jpg'],
      lebarMaks: 5.6,
      berkas: 'kode/contoh_11_ukuran_huruf_pengguna.dart',
      poin: [
        'Pengguna bisa memperbesar huruf di pengaturan ponsel; Flutter menerapkannya otomatis.',
        'Jangan mematok tinggi wadah teks; teks panjang di Row dibungkus Expanded.',
        'Uji di 1,5× dan 2×. Garis kuning-hitam di contoh ini disengaja.',
      ],
      ukuranPoin: 16,
      catatan: 'Kebiasaan aksesibilitas lain: pasangan onX untuk kontras, jangan hanya mengandalkan warna, target sentuh minimal 48 × 48 di ponsel, tooltip pada IconButton, jangan mengunci orientasi.',
    });

    d.tabel({
      judul: 'Cara Menguji dan Daftar Periksa',
      kepala: ['Uji', 'Yang diperiksa'],
      lebarKolom: [3.8, 7.8],
      baris: [
        ['Lebar 320 dan 360', 'Tanpa garis kuning-hitam; teks terpotong rapi atau turun baris'],
        ['Lebar 600, 840, 1200', 'Tata letak berganti tepat di breakpoint; isi tidak membentang'],
        ['Mode terang dan gelap', 'Semua teks terbaca; tidak ada kotak putih/teks hitam tertulis langsung'],
        ['Huruf 1,5× dan 2×', 'Tidak terpotong di tengah kata, tanpa overflow'],
        ['Ubah ukuran saat berjalan', 'Tab aktif, item terpilih, isian tidak hilang'],
      ],
      ukuran: 15,
      tinggiBaris: 0.6,
      pesan: 'Chrome: seret tepi jendela atau F12 → Ctrl+Shift+M. SizedBox di MaterialApp.builder TIDAK mengubah MediaQuery.',
      catatan: 'Trik SizedBox(width: 320) dari Pertemuan 6 hanya memengaruhi LayoutBuilder/batasan induk. Untuk menguji breakpoint yang memakai MediaQuery.widthOf, ubah ukuran jendelanya.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 6', judul: 'Studi Kasus: Pustaka Kampus', ikon: 'buku', catatan: 'Merangkai tema, mode gelap, navigasi adaptif, daftar–detail, dan LayoutBuilder.' });

    d.layar({
      judul: 'Pustaka Kampus di Ponsel',
      gambar: ['hasil_contoh_12a.jpg', 'hasil_contoh_12b.jpg', 'hasil_contoh_12c.jpg'],
      lebarMaks: 7.6,
      berkas: 'kode/contoh_12_studi_kasus_pustaka_kampus.dart',
      poin: [
        'Akar aplikasi: _mode dan _benih → theme/darkTheme dari buatTema(benih, kecerahan).',
        'HalamanUtama: _tujuan, _idTerpilih, _dipinjam (lencana = nilai turunan).',
        'Satu panel: detail lewat Navigator.push<bool> + mounted.',
      ],
      ukuranPoin: 14,
      catatan: 'Kiri: katalog dengan NavigationBar dan lencana Pinjaman. Tengah: halaman detail (sampul di atas karena ruangnya sempit). Kanan: Pengaturan dalam mode gelap dengan warna Hijau.',
    });

    d.layar({
      judul: 'Pustaka Kampus di Layar Lebar',
      gambar: 'hasil_contoh_12d.jpg',
      lebarMaks: 7.4,
      kode: [
        'final bool lega =',
        '    batasan.maxWidth >= 520;',
        'if (lega)',
        '  Row(children: [sampul, ...])',
        'else ...[',
        '  Center(child: sampul),',
        '  keterangan,',
        '],',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'NavigationRail di samping; katalog dua panel mulai 840.',
        'DetailBuku memakai LayoutBuilder: 840 → panel ± 398 (sampul di atas), 1000 → ± 558 (sampul di kiri).',
      ],
      ukuranPoin: 14,
      catatan: 'Coba: pinjam satu buku (lencana bertambah), pilih Gelap lalu Hijau di Pengaturan, perlebar jendela perlahan dan amati tiga perubahan di 600, 840, dan 1200.',
    });

    d.tabel({
      judul: 'Kesalahan Umum Pemula',
      kepala: ['Gejala', 'Solusi'],
      lebarKolom: [6.2, 5.4],
      baris: [
        ['Sebagian kartu/teks tidak ikut berganti warna', 'Ambil warna dari Theme.of(context).colorScheme'],
        ['Teks hilang/kotak putih di mode gelap', 'Pakai surface/onSurface dan peran warna lain'],
        ['Memilih Gelap tetapi tetap terang', 'Isi darkTheme dengan brightness: Brightness.dark'],
        ['BoxConstraints forces an infinite width', 'Tombol Size.fromHeight di Row → bungkus Expanded'],
        ['Assertion error di NavigationRail', 'extended: true → labelType none/null'],
        ['Tab kembali ke awal saat ukuran berubah', 'Simpan state di atas percabangan'],
        ['Overflow saat huruf diperbesar', 'Jangan patok tinggi; teks di Row → Expanded'],
      ],
      ukuran: 14,
      tinggiBaris: 0.55,
      catatan: 'Tutorial lama: AppBarTheme(color: ...) → AppBarThemeData(backgroundColor: ...); background/onBackground/surfaceVariant → surface/onSurface/surfaceContainerHighest.',
    });

    d.ringkasan({
      poin: [
        'M3 = sistem desain bawaan; komponen membaca token dari tema.',
        'Tema dipasang sekali di MaterialApp, dibaca dengan Theme.of(context).',
        'fromSeed: satu benih → semua peran warna; teks di atas X memakai onX.',
        '15 gaya TextTheme; tema komponen (…ThemeData); tema lokal dengan Theme.',
        'Mode gelap = theme + darkTheme + themeMode; state di akar aplikasi.',
        'MediaQuery = jendela; LayoutBuilder = ruang widget.',
        'Breakpoint: < 600, 600–839, 840–1199, 1200–1599, ≥ 1600.',
        'NavigationBar ↔ NavigationRail; daftar–detail; uji lebar, mode, huruf.',
      ],
      catatan: 'Minta mahasiswa menjelaskan: apa yang terjadi pada Pustaka Kampus saat jendela diperlebar dari 360 ke 1280, dan widget mana yang membuat keputusan dengan MediaQuery serta mana yang dengan LayoutBuilder.',
    });

    d.penutup({
      judul: 'Saatnya Praktik!',
      subjudul: 'Kerjakan Jobsheet Pertemuan 7 (lima praktikum + tugas Direktori UKM Kampus), lalu uji diri di Latihan. Pertemuan berikutnya: Ujian Tengah Semester (ujian praktik).',
      tautan: [
        { teks: 'Jobsheet P7', ikon: 'tugas', url: d.urlBerkas('pertemuan_07_material3_dan_responsif/JOBSHEET.md') },
        { teks: 'Latihan P7', ikon: 'kuis', url: d.urlBerkas('pertemuan_07_material3_dan_responsif/LATIHAN.md') },
        { teks: 'Modul P7', ikon: 'buku', url: d.urlBerkas('pertemuan_07_material3_dan_responsif/README.md') },
      ],
      catatan: 'Ingatkan: tugas mandiri wajib diuji di lebar 320, 360, 700, 1000, dan 1280, dalam mode terang dan gelap. UTS menguji Pertemuan 1–7, terutama 4–7 (tata letak, state, daftar, navigasi, dan tema). Panduan, simulasi, dan latihan persiapannya ada di folder pertemuan_08_uts.',
    });
  },
};

// Konten slide Pertemuan 4 — Widget & Tata Letak (Layout).
// Teks diambil dari modul bacaan (pertemuan_04_widget_dan_layout/README.md).
// Tangkapan layar diambil dari folder pertemuan_04_widget_dan_layout/gambar/.

module.exports = {
  nomor: '04',
  folder: 'pertemuan_04_widget_dan_layout',
  namaBerkas: 'PERTEMUAN_04_Widget_dan_Layout',
  topik: 'Widget & Tata Letak',

  bangun(d) {
    const C = d.C;
    const KODE = { fontFace: 'Consolas' };

    d.judul({
      judul: 'Widget & Tata Letak (Layout)',
      subjudul: 'Pertemuan 4  ·  Widget dasar, Row & Column, Expanded, Stack, constraints, overflow, dan memecah widget',
      catatan: 'Kembali ke Flutter. Konsep Pertemuan 3 (class, parameter bernama, required, final, const, extends, @override, enum) langsung dipakai hari ini. Semua contoh bisa dijalankan di DartPad tanpa instalasi.',
    });

    d.tujuan({
      pengantar: 'Setelah pertemuan ini, Anda mampu:',
      poin: [
        'Membaca pohon widget dan memakai widget dasar dengan gaya dari tema',
        'Mengatur jarak, ukuran, dan posisi dengan Padding, SizedBox, dan Align',
        'Menyusun tampilan dengan Row, Column, Expanded, dan Stack',
        'Menjelaskan aturan constraints untuk menebak ukuran widget',
        'Mengenali overflow dan memilih cara memperbaikinya',
        'Memecah tampilan menjadi widget kecil yang bisa dipakai ulang',
      ],
      catatan: 'Target akhir hari ini: halaman Detail Menu Kantin yang tetap rapi di layar sempit (320) maupun lebar.',
    });

    d.alur({
      judul: 'Peta Materi Hari Ini',
      langkah: [
        { ikon: 'pohon', judul: 'Pohon widget', isi: 'Induk, anak, child, dan children' },
        { ikon: 'teks', judul: 'Widget dasar', isi: 'Teks, ikon, gambar, jarak, Container' },
        { ikon: 'kolom', judul: 'Row & Column', isi: 'Sumbu utama dan sumbu silang' },
        { ikon: 'lapisan', judul: 'Expanded & Stack', isi: 'Membagi ruang dan menumpuk' },
        { ikon: 'ukur', judul: 'Constraints & overflow', isi: 'Mengapa tampilan berantakan dan cara memperbaikinya' },
        { ikon: 'dasbor', judul: 'Memecah widget', isi: 'Kode rapi, lalu studi kasus menu kantin', warna: C.accent4 },
      ],
      catatan: 'Bagian awal mengenalkan "bahan bangunan", bagian tengah cara menyusunnya, bagian akhir cara memahami ukuran dan merapikan kode.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 1', judul: 'Semua Adalah Widget', ikon: 'widget', catatan: 'Mulai dari konsep paling dasar: di Flutter, semua yang tampil di layar adalah widget, dan widget tersusun bertingkat seperti pohon.' });

    d.kode({
      judul: 'Pohon Widget: Induk dan Anak',
      kode: [
        'Scaffold(',
        "  appBar: AppBar(title: const Text('Profil')),",
        '  body: const Center(',
        '    child: Column(',
        '      children: [',
        '        Icon(Icons.person, size: 64),',
        "        Text('Rina Amelia'),",
        "        Text('Informatika 2026'),",
        '      ],',
        '    ),',
        '  ),',
        ')',
      ].join('\n'),
      poin: [
        'Widget tersusun bertingkat seperti balok Lego.',
        'Center adalah induk (parent) dari Column; Column punya tiga anak.',
        [{ text: 'child:', options: KODE }, { text: ' untuk satu anak, misalnya Center dan Padding.' }],
        [{ text: 'children: [ ... ]', options: KODE }, { text: ' untuk banyak anak, misalnya Row dan Column.' }],
        'Jarak (Padding) dan posisi (Center) pun berupa widget.',
      ],
      catatan: 'Gambar pohonnya di papan tulis: Scaffold bercabang ke AppBar dan Center; Center ke Column; Column ke tiga anak. Tanyakan: siapa induk Column? Berapa anaknya?',
    });

    d.tabel({
      judul: 'Satu Anak, Banyak Anak, atau Tanpa Anak?',
      kepala: ['Jenis widget', 'Contoh', 'Cara menulis anaknya'],
      lebarKolom: [2.6, 5.4, 3.2],
      baris: [
        [{ text: 'Punya satu anak', options: { bold: true } }, 'Padding, Center, Align, SizedBox, Container, Card, Expanded', { text: 'child: ...', options: KODE }],
        [{ text: 'Punya banyak anak', options: { bold: true } }, 'Row, Column, Stack, Wrap', { text: 'children: [ ... ]', options: KODE }],
        [{ text: 'Tanpa anak', options: { bold: true } }, 'Text, Icon, Image, Divider, Spacer', '—'],
      ],
      ukuran: 17,
      tinggiBaris: 0.85,
      pesan: "Tertukar? Column(child: ...) ditolak editor: The named parameter 'child' isn't defined. Tips VS Code: Ctrl+. lalu Wrap with Padding/Center/Column.",
      catatan: 'Peragakan fitur Wrap with... dan Remove this widget di VS Code. Fitur ini menghemat waktu dan mencegah kurung yang tidak berpasangan.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 2', judul: 'Widget Dasar dan Jarak', ikon: 'teks', catatan: 'Kenalkan bahan bangunan: teks, ikon, dan gambar, lalu cara memberi jarak, ukuran, posisi, dan kotak berhias.' });

    d.layar({
      judul: 'Teks, Ikon, dan Gambar',
      gambar: 'hasil_contoh_01.jpg',
      berkas: 'kode/contoh_01_widget_dasar.dart',
      kode: [
        'final TextTheme gayaTeks = Theme.of(context).textTheme;',
        'final ColorScheme warna = Theme.of(context).colorScheme;',
        '',
        "Text('Judul Besar', style: gayaTeks.headlineMedium),",
        'Icon(Icons.favorite, color: warna.error, size: 32),',
        "const CircleAvatar(child: Text('RA')),",
        'Image.network(',
        "  'https://picsum.photos/600/300?image=9',",
        '  fit: BoxFit.cover,',
        '  errorBuilder: (context, error, jejak) => ...,',
        '),',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        'Gaya teks dan warna diambil dari tema, bukan ditulis sendiri.',
        'maxLines + TextOverflow.ellipsis memotong teks yang terlalu panjang.',
        'errorBuilder: tampilan cadangan jika gambar gagal dimuat.',
      ],
      ukuranPoin: 16,
      catatan: 'Kebiasaan dari Pertemuan 1: Theme.of(context). Gambar dari internet butuh koneksi. Image.asset butuh pendaftaran di pubspec.yaml dan tidak bisa dicoba di DartPad.',
    });

    d.banding({
      judul: 'Gaya Teks dan Warna Diambil dari Tema',
      ukuranContoh: 13,
      kolom: [
        {
          ikon: 'teks', judul: 'Gaya teks (TextTheme)', warna: C.accent1, tag: 'Theme.of(context).textTheme',
          poin: [
            'headlineMedium (28): judul besar',
            'titleLarge (22), titleMedium (16): judul',
            'bodyMedium (14): isi, gaya bawaan Text',
            'labelSmall (11): keterangan kecil',
          ],
          contoh: "Text('Halo', style: gayaTeks.titleLarge)",
        },
        {
          ikon: 'palet', judul: 'Warna (ColorScheme)', warna: C.accent6, tag: 'Theme.of(context).colorScheme',
          poin: [
            'primary + onPrimary: tombol utama, banner',
            'primaryContainer + onPrimaryContainer: kotak sorotan',
            'surface + onSurface: latar halaman, teks biasa',
            'error + onError: lencana peringatan, pesan galat',
          ],
          contoh: 'Icon(Icons.star, color: warna.primary)',
        },
      ],
      pesan: 'Aturan warna: onX dipakai untuk isi di atas warna X. Transparan: warna.primary.withValues(alpha: 0.2), bukan withOpacity() yang sudah usang.',
      catatan: 'Tanyakan: mengapa color: warna.primary, bukan Colors.blue? Jawaban: agar serasi dengan tema. Jika seedColor diganti atau aplikasi memakai mode gelap (Pertemuan 7), semua warna ikut menyesuaikan. Ingat juga: titleLarge bertipe TextStyle?, jadi copyWith dipanggil dengan ?.copyWith(...).',
    });

    d.layar({
      judul: 'Padding, SizedBox, dan Align',
      gambar: 'hasil_contoh_02.jpg',
      berkas: 'kode/contoh_02_padding_sizedbox_align.dart',
      poin: [
        [{ text: 'EdgeInsets.all(16)', options: KODE }, { text: ': 16 di keempat sisi.' }],
        [{ text: 'EdgeInsets.symmetric(horizontal: 48, vertical: 8)', options: KODE }, { text: ': kiri-kanan dan atas-bawah.' }],
        [{ text: 'EdgeInsets.only(left: 96, top: 8)', options: KODE }, { text: ': sisi tertentu saja.' }],
        [{ text: 'SizedBox(height: 24)', options: KODE }, { text: ' sebagai jarak kosong; jika punya anak, ia memaksa ukuran anaknya.' }],
        [{ text: 'Align', options: KODE }, { text: ' memakai Alignment(x, y) dari -1 sampai 1. Center sama dengan Align(alignment: Alignment.center).' }],
        'Satuan ukuran = piksel logis (±38 per cm). Pakai kelipatan 4 atau 8; target sentuh minimal 48 × 48.',
      ],
      ukuranPoin: 16,
      catatan: 'Pita berwarna pada gambar adalah area padding, kotak putih adalah anaknya. Minta mahasiswa menebak EdgeInsets untuk jarak 24 di kiri-kanan saja (EdgeInsets.symmetric(horizontal: 24)).',
    });

    d.layar({
      judul: 'Container dan Card',
      gambar: 'hasil_contoh_03.jpg',
      berkas: 'kode/contoh_03_container_dan_dekorasi.dart',
      kode: [
        'Container(',
        '  margin: const EdgeInsets.only(bottom: 16), // luar',
        '  padding: const EdgeInsets.all(16), // dalam',
        '  decoration: BoxDecoration(',
        '    color: warna.primaryContainer,',
        '    borderRadius: BorderRadius.circular(16),',
        '    border: Border.all(color: warna.primary, width: 2),',
        '    boxShadow: [BoxShadow(blurRadius: 8, ...)],',
        '  ),',
        '  child: Text(...),',
        ')',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        'margin = jarak di luar kotak, padding = jarak di dalam kotak.',
        'color dan decoration tidak boleh diisi bersamaan.',
        'Card, Card.filled, Card.outlined: kartu Material 3 siap pakai.',
      ],
      ukuranPoin: 16,
      catatan: 'Analogi kotak kado: margin = jarak ke benda lain, border = kardus, padding = busa pelindung, child = hadiah. Jika hanya butuh satu kemampuan, pakai widget khususnya (Padding, SizedBox, ColoredBox) agar kode lebih jelas.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 3', judul: 'Row dan Column', ikon: 'kolom', catatan: 'Row dan Column adalah widget tata letak yang paling sering dipakai. Kuasai dulu dua sumbunya: sumbu utama dan sumbu silang.' });

    d.banding({
      judul: 'Sumbu Utama dan Sumbu Silang',
      ukuranContoh: 13,
      kolom: [
        {
          ikon: 'baris', judul: 'Row', warna: C.accent1, tag: 'Menyusun anak mendatar (kiri ke kanan)',
          poin: [
            'Sumbu utama: mendatar ↔, diatur mainAxisAlignment',
            'Sumbu silang: tegak ↕, diatur crossAxisAlignment',
            'Contoh: ikon di samping teks, deretan tombol',
          ],
          contoh: 'Row(\n  spacing: 8,\n  children: [Icon(...), Text(...)],\n)',
        },
        {
          ikon: 'kolom', judul: 'Column', warna: C.accent6, tag: 'Menyusun anak menurun (atas ke bawah)',
          poin: [
            'Sumbu utama: tegak ↕, diatur mainAxisAlignment',
            'Sumbu silang: mendatar ↔, diatur crossAxisAlignment',
            'Contoh: judul di atas isi, susunan satu halaman',
          ],
          contoh: 'Column(\n  spacing: 8,\n  children: [Text(...), Text(...)],\n)',
        },
      ],
      pesan: 'Ingat: "utama" = arah susunan, "silang" = arah sebaliknya. Isi Column ada di tengah? Bawaan crossAxisAlignment adalah center; pakai CrossAxisAlignment.start agar rata kiri.',
      catatan: 'Peragakan dengan tangan: Row = tangan mendatar, Column = tangan tegak. Parameter spacing tersedia sejak Flutter 3.27 dan menggantikan SizedBox di antara setiap anak.',
    });

    d.layar({
      judul: 'mainAxisAlignment: Posisi di Sumbu Utama',
      gambar: 'hasil_contoh_04a.jpg',
      berkas: 'kode/contoh_04_row_dan_column.dart',
      poin: [
        'start / center / end: anak merapat ke awal, tengah, atau akhir.',
        'spaceBetween: sisa ruang dibagi di antara anak; tepi tanpa jarak.',
        'spaceAround: jarak di tepi = setengah jarak antaranak.',
        'spaceEvenly: semua jarak sama, termasuk di kedua tepi.',
        [{ text: 'Keenam baris pada gambar dibuat dengan ' }, { text: 'for', options: KODE }, { text: ' di dalam daftar children dan ' }, { text: 'MainAxisAlignment.values', options: KODE }, { text: ' (enum, Pertemuan 3).' }],
      ],
      ukuranPoin: 17,
      catatan: 'Jelaskan "for di dalam daftar": ditulis di dalam kurung siku, tanpa kurung kurawal dan titik koma; setiap putaran menambah satu widget. Hitung bersama: lebar 300, tiga kotak 60, spaceBetween → sisa 120 dibagi 2 celah = 60.',
    });

    d.layar({
      judul: 'crossAxisAlignment dan spacing',
      gambar: 'hasil_contoh_04b.jpg',
      berkas: 'kode/contoh_04_row_dan_column.dart',
      kode: [
        'Row(',
        '  crossAxisAlignment: CrossAxisAlignment.start,',
        '  spacing: 8, // jarak 8 di antara setiap anak',
        '  children: const [',
        '    KotakKecil(tinggi: 24),',
        '    KotakKecil(tinggi: 40),',
        '    KotakKecil(tinggi: 56),',
        '  ],',
        ')',
      ].join('\n'),
      ukuranKode: 14,
      poin: [
        'Pada Row, sumbu silang = tegak: start = rata atas, center = tengah, end = rata bawah.',
        'stretch: anak ditarik setinggi Row (64); tinggi 24/40/56 diabaikan. Alasannya dijelaskan di Bagian 5.',
      ],
      ukuranPoin: 17,
      catatan: 'Pada contoh, setiap Row dibungkus SizedBox(height: 64) agar perbedaan start/center/end terlihat. Tanyakan: jika Row diganti Column, crossAxisAlignment mengatur arah mana? (kiri–kanan).',
    });

    d.layar({
      judul: 'Jebakan: Kartu Memanjang sampai Bawah',
      gambar: 'jebakan_card_column.jpg',
      kode: [
        'Card.outlined(',
        '  child: Column(',
        '    // Tanpa baris ini, kartu memanjang',
        '    // sampai bawah layar.',
        '    mainAxisSize: MainAxisSize.min,',
        '    children: [',
        "      Text('Baris 1'),",
        "      Text('Baris 2'),",
        '    ],',
        '  ),',
        ')',
      ].join('\n'),
      ukuranKode: 14,
      poin: [
        'Row dan Column bawaannya mengambil ruang sebanyak mungkin (MainAxisSize.max).',
        'Jebakan ini tidak muncul jika kartu berada di dalam Column lain atau SingleChildScrollView.',
      ],
      ukuranPoin: 16,
      catatan: 'Kiri: Card berisi Column langsung sebagai body, kartu memanjang. Kanan: setelah mainAxisSize.min. Alasan lengkapnya (batasan tak terbatas) dibahas di Bagian 5.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 4', judul: 'Membagi Ruang dan Menumpuk', ikon: 'lapisan', catatan: 'Setelah bisa menyusun berderet, sekarang membagi sisa ruang (Expanded) dan menumpuk widget (Stack).' });

    d.layar({
      judul: 'Expanded, Flexible, dan Spacer',
      gambar: 'hasil_contoh_05.jpg',
      berkas: 'kode/contoh_05_expanded_flexible_spacer.dart',
      kode: [
        'Row(',
        '  children: [',
        '    Expanded(',
        '      flex: 2, // mendapat 2 bagian',
        "      child: KotakLabel(teks: 'flex: 2', ...),",
        '    ),',
        '    Expanded( // flex bawaan = 1 bagian',
        "      child: KotakLabel(teks: 'flex: 1', ...),",
        '    ),',
        '  ],',
        ')',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        'Expanded = ambil sisa ruang, dibagi menurut flex. Lebar 300 → 3 bagian → 200 dan 100.',
        'Ukuran pasti diberi tempat dulu; sisanya untuk Expanded.',
        'Flexible boleh lebih kecil dari jatahnya; Expanded wajib penuh.',
        'Spacer: pendorong kosong ke ujung.',
      ],
      ukuranPoin: 16,
      catatan: 'Expanded, Flexible, dan Spacer hanya boleh menjadi anak langsung Row/Column. Di tempat lain muncul Incorrect use of ParentDataWidget. Pola paling sering di aplikasi nyata: ikon + Expanded(teks dengan ellipsis) + harga.',
    });

    d.layar({
      judul: 'Stack dan Positioned',
      gambar: 'hasil_contoh_06.jpg',
      tinggiGambar: 4.7,
      berkas: 'kode/contoh_06_stack_dan_positioned.dart',
      kode: [
        'Stack(',
        '  children: [',
        '    // 1) paling bawah',
        '    Container(height: 160, color: warna.primary),',
        '    // 2) di atasnya',
        "    Positioned(left: 16, bottom: 16, child: Text('Diskon 20%')),",
        '    // 3) paling atas',
        '    const Positioned(top: 12, right: 12, child: Chip(...)),',
        '  ],',
        ')',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        'Seperti stiker di sampul buku: yang ditulis terakhir berada paling atas.',
        'Positioned: jarak dari tepi (top, right, bottom, left); boleh negatif + Clip.none.',
        'Ukuran Stack mengikuti anak terbesar yang tidak memakai Positioned.',
      ],
      ukuranPoin: 16,
      catatan: 'ClipRRect memotong seluruh isi Stack mengikuti sudut bulat (lihat banner). Positioned hanya boleh menjadi anak langsung Stack. Badge adalah lencana angka siap pakai dari Material 3.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 5', judul: 'Constraints dan Overflow', ikon: 'ukur', catatan: 'Bagian terpenting hari ini: mengapa ukuran widget kadang tidak sesuai harapan, dan mengapa muncul garis kuning-hitam.' });

    d.alur({
      judul: 'Batasan Turun, Ukuran Naik, Induk Menentukan Posisi',
      pengantar: '"Constraints go down. Sizes go up. Parent sets position." Bayangkan panitia bazar kampus dan pemilik stan.',
      langkah: [
        { ikon: 'ukur', judul: 'Induk memberi batasan', isi: 'Panitia: "Lebar stanmu boleh 2 sampai 4 meter." Induk memberi lebar dan tinggi minimum–maksimum.' },
        { ikon: 'kotak', judul: 'Anak memilih ukuran', isi: 'Pemilik stan memilih 3 meter, lalu melapor. Ukuran anak wajib berada di dalam batasan.' },
        { ikon: 'rata', judul: 'Induk menentukan posisi', isi: 'Panitia yang menentukan letak stan. Anak tidak tahu posisinya sendiri.', warna: C.accent4 },
      ],
      tinggiKotak: 3.6,
      catatan: 'Contoh di modul: Center → Padding(16) → Text di layar 360 × 640. Padding meneruskan batasan lebar 0–328 kepada Text. Jika Text memilih 40 × 20, Padding melapor 72 × 52 (ditambah 16 di setiap sisi), lalu Center menaruhnya di tengah.',
    });

    d.layar({
      judul: 'Ketat, Longgar, dan Tak Terbatas',
      gambar: 'hasil_contoh_07.jpg',
      berkas: 'kode/contoh_07_constraints.dart',
      poin: [
        [{ text: 'Ketat (tight): ', options: { bold: true } }, { text: 'minimum = maksimum. Di dalam SizedBox 260 × 60, anak wajib selebar 260.' }],
        [{ text: 'Longgar (loose): ', options: { bold: true } }, { text: 'minimum 0. Di dalam Center, anak boleh selebar 0 sampai 328 (360 − 2 × 16).' }],
        [{ text: 'Tak terbatas (unbounded): ', options: { bold: true } }, { text: 'Row memberi lebar Infinity kepada anak yang bukan Expanded.' }],
        'Itulah sebabnya teks panjang di Row meluber, padahal di Column turun baris.',
        'LayoutBuilder menampilkan batasan yang diterima sebuah widget.',
      ],
      ukuranPoin: 16,
      catatan: 'Angka maksimum bergantung pada lebar layar. Jalankan contoh 07 di jendela yang berbeda ukuran, lalu minta mahasiswa menjelaskan mengapa angkanya berubah.',
    });

    d.kode({
      judul: '"Kenapa Ukuran yang Saya Tulis Diabaikan?"',
      kode: [
        'Column(',
        '  crossAxisAlignment: CrossAxisAlignment.stretch,',
        '  children: [',
        '    // Lebar 100 DIABAIKAN: stretch',
        '    // memberi batasan lebar yang ketat.',
        '    Container(width: 100, height: 50),',
        '',
        '    // Lebar 100 DIPATUHI: Align',
        '    // melonggarkan batasan.',
        '    Align(',
        '      alignment: Alignment.centerLeft,',
        '      child: Container(width: 100, height: 50),',
        '    ),',
        '  ],',
        ')',
      ].join('\n'),
      ukuran: 14,
      poin: [
        'Ukuran anak wajib berada di dalam batasan induknya.',
        'Induk dengan batasan ketat (stretch, SizedBox, Expanded) mengalahkan width/height anak.',
        'Align dan Center menerima batasan ketat, lalu meneruskan batasan longgar kepada anaknya.',
        'Bingung? Cari tahu batasan yang diterima widget itu (LayoutBuilder atau Flutter Inspector).',
      ],
      catatan: 'Hubungkan dengan slide crossAxisAlignment di Bagian 3: tinggi 24/40/56 diabaikan karena alasan yang sama. Di modul, Container diberi color: warna.primary agar terlihat; di sini disingkat.',
    });

    d.layar({
      judul: 'Overflow: Garis Kuning-Hitam',
      gambar: 'hasil_contoh_08_masalah.jpg',
      berkas: 'kode/contoh_08_mengatasi_overflow.dart',
      poin: [
        [{ text: 'A RenderFlex overflowed by 344 pixels on the right.', options: KODE }],
        'right = meluber ke kanan (biasanya Row), bottom = meluber ke bawah (biasanya Column). Angkanya bergantung lebar layar.',
        'Baris bergaris pada gambar = masalah; baris di bawahnya = versi yang sudah diperbaiki.',
        'Garis hanya tampil saat debug. Di aplikasi rilis, isinya terpotong diam-diam.',
      ],
      ukuranPoin: 16,
      catatan: 'Buka contoh 08, hapus // di dua baris MASALAH, jalankan, lalu tunjukkan pesan di konsol. Jangan pernah mengabaikan overflow, sekecil apa pun angkanya.',
    });

    d.tabel({
      judul: 'Memilih Obat yang Tepat untuk Overflow',
      kepala: ['Gejala', 'Penyebab', 'Solusi'],
      lebarKolom: [3.6, 3.8, 4.0],
      baris: [
        ['... on the right, berisi satu teks panjang', 'Teks di Row menerima lebar tak terbatas', { text: 'Expanded (+ maxLines dan TextOverflow.ellipsis)', options: { bold: true } }],
        ['... on the right, berisi banyak item kecil', 'Row tidak pernah pindah baris', { text: 'Wrap (spacing, runSpacing)', options: { bold: true } }],
        ['... on the bottom', 'Column lebih tinggi daripada layar', { text: 'SingleChildScrollView', options: { bold: true } }],
      ],
      ukuran: 16,
      tinggiBaris: 0.85,
      pesan: 'Daftar data yang panjang (puluhan sampai ribuan baris) memakai ListView, dibahas di Pertemuan 6.',
      catatan: 'Kuis cepat: 12 chip hobi meluber ke kanan → Wrap. Alamat panjang di samping ikon → Expanded. Halaman detail yang tinggi → SingleChildScrollView.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 6', judul: 'Merapikan Tampilan dan Kode', ikon: 'dasbor', catatan: 'Terakhir: ListTile yang siap pakai, cara memecah kode panjang menjadi widget kecil, lalu studi kasus yang menggabungkan semuanya.' });

    d.layar({
      judul: 'ListTile: Baris Informasi Siap Pakai',
      gambar: 'hasil_contoh_09.jpg',
      berkas: 'kode/contoh_09_card_dan_listtile.dart',
      kode: [
        'Card(',
        '  child: ListTile(',
        '    leading: const CircleAvatar(child: Icon(Icons.menu_book)),',
        "    title: const Text('Pemrograman Piranti Bergerak'),",
        "    subtitle: const Text('Senin, 08.00-10.30 · Lab 2'),",
        '    trailing: Icon(Icons.chevron_right, color: warna.outline),',
        '  ),',
        ')',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        'Empat slot: leading (kiri), title, subtitle, trailing (kanan).',
        'Judul panjang otomatis turun baris tanpa overflow.',
        'Di dalam Row, ListTile wajib dibungkus Expanded.',
      ],
      ukuranPoin: 16,
      catatan: 'ListTile di dalam Row tanpa Expanded memunculkan BoxConstraints forces an infinite width. Beberapa ListTile dalam satu Card dipisah dengan Divider(height: 1).',
    });

    d.layar({
      judul: 'Memecah Tampilan Menjadi Widget Kecil',
      gambar: 'hasil_contoh_10.jpg',
      berkas: 'kode/contoh_10_memecah_widget.dart',
      kode: [
        'class KartuStatistik extends StatelessWidget {',
        '  const KartuStatistik({',
        '    super.key,',
        '    required this.ikon,',
        '    required this.angka,',
        '    required this.label,',
        '  });',
        '',
        '  final IconData ikon;',
        '  final String angka;',
        '  final String label;',
        '  // build(): Card berisi ikon, angka, label',
        '}',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        "Dipakai: KartuStatistik(ikon: Icons.task_alt, angka: '12', label: 'Tugas')",
        'Properti final + constructor const: widget tidak berubah (immutable).',
      ],
      ukuranPoin: 15,
      catatan: 'Hubungkan dengan Pertemuan 3: parameter bernama, required, final, const. Peragakan Ctrl+. → Extract Widget di VS Code untuk memecah widget secara otomatis.',
    });

    d.kartu({
      judul: 'Mengapa Class Widget, Bukan Fungsi Pembantu?',
      pengantar: 'Dokumentasi Flutter menyarankan: untuk potongan tampilan yang dipakai ulang, buat widget (class), bukan fungsi pembantu (helper method).',
      kolom: 2,
      item: [
        { ikon: 'kilat', judul: 'Bisa const', isi: 'Flutter tidak perlu membangun ulang widget const ketika induknya berubah.' },
        { ikon: 'pohon', judul: 'Punya context sendiri', isi: 'Letaknya tepat di pohon widget, sehingga Theme.of(context) dan sejenisnya bekerja benar.' },
        { ikon: 'lihat', judul: 'Terlihat di Inspector', isi: 'Muncul dengan namanya sendiri (KartuStatistik), mudah dilacak saat debugging.' },
        { ikon: 'folder', judul: 'Mudah dipakai ulang', isi: 'Bisa dipindah ke berkas tersendiri dan dipakai di halaman lain.' },
      ],
      catatan: 'Sumber: dokumentasi StatelessWidget di api.flutter.dev ("prefer using a widget rather than a helper method"). Tunjukkan perbedaan di Inspector: widget class muncul dengan namanya sendiri, fungsi pembantu tidak.',
    });

    d.layar({
      judul: 'Studi Kasus: Halaman Detail Menu Kantin',
      gambar: ['hasil_contoh_11a.jpg', 'hasil_contoh_11b.jpg'],
      lebarMaks: 6.1,
      berkas: 'kode/contoh_11_studi_kasus_detail_menu.dart',
      poin: [
        'Banner: Stack + dua Positioned, dipotong ClipRRect.',
        'Nama menu: Expanded agar harga tetap terlihat.',
        'Rating: for di dalam daftar + operator ? :.',
        'Label: Wrap + Chip. Info: tiga KotakInfo dalam Expanded.',
        'Tombol: bottomNavigationBar + SafeArea.',
        'Uji di lebar 320: tombol "Simpan" diganti tombol ikon.',
      ],
      ukuranPoin: 15,
      catatan: 'Pecah sketsa menjadi kotak-kotak dulu: mendatar (Row), menurun (Column), atau bertumpuk (Stack)? Ceritakan pelajaran uji layar sempit: versi pertama terlihat bagus di 360 tetapi rusak di 320.',
    });

    d.layar({
      judul: 'Alat Bantu Melihat Tata Letak',
      gambar: 'hasil_garis_bantu.jpg',
      lebarMaks: 5.6,
      kode: [
        "import 'package:flutter/rendering.dart';",
        '',
        'void main() {',
        '  debugPaintSizeEnabled = true;',
        '  runApp(const AplikasiSaya());',
        '}',
      ].join('\n'),
      ukuranKode: 14,
      poin: [
        [{ text: 'Garis bantu: ', options: { bold: true } }, { text: 'garis toska = batas widget, biru muda = padding. Bisa dipakai di DartPad; hapus lagi setelah selesai.' }],
        [{ text: 'Flutter Inspector: ', options: { bold: true } }, { text: 'Start Debugging (F5), lalu F1 → Open DevTools. Select Widget Mode menampilkan size, constraints, dan Flex explorer.' }],
        [{ text: 'Layar ponsel di Chrome: ', options: { bold: true } }, { text: 'F12 → Ctrl+Shift+M → Dimensions: Responsive; uji lebar 360 dan 320.' }],
      ],
      ukuranPoin: 16,
      catatan: 'Biasakan menguji tampilan di lebar 320–360 piksel logis. Pengguna aplikasi kita memakai ponsel, bukan monitor lebar. Inspector tidak tersedia di DartPad; di DartPad pakai garis bantu.',
    });

    d.tabel({
      judul: 'Kesalahan Umum Pemula',
      kepala: ['Pesan error / gejala', 'Penyebab dan solusi'],
      lebarKolom: [6.0, 5.2],
      baris: [
        ["The named parameter 'child' isn't defined.", 'Widget banyak anak: pakai children: [ ... ]'],
        ["The argument type 'int' can't be assigned to the parameter type 'EdgeInsetsGeometry'.", 'Tulis padding: const EdgeInsets.all(16)'],
        ['Invalid constant value.', 'Hapus const pada widget yang memakai warna/gaya dari tema'],
        ['Incorrect use of ParentDataWidget.', 'Expanded/Positioned bukan anak langsung Row/Column/Stack'],
        ['RenderFlex children have non-zero flex but incoming height constraints are unbounded.', 'Expanded di dalam Column yang bisa digulir; hapus Expanded'],
        ['BoxConstraints forces an infinite width.', 'ListTile di dalam Row; bungkus dengan Expanded'],
        ['Cannot provide both a color and a decoration.', 'Pindahkan warna ke BoxDecoration(color: ...)'],
      ],
      ukuran: 14,
      catatan: 'Satu kesalahan bisa memicu puluhan pesan berantai (RenderBox was not laid out). Selalu baca dan perbaiki pesan PERTAMA dulu. Tabel lengkap ada di modul bagian 15.',
    });

    d.ringkasan({
      poin: [
        'Semua adalah widget; child untuk satu anak, children untuk banyak anak.',
        'Gaya teks dan warna diambil dari tema; onX untuk isi di atas warna X.',
        'Padding/EdgeInsets, SizedBox, Align/Center; Container (margin, padding, dekorasi) dan Card.',
        'Row/Column: mainAxisAlignment, crossAxisAlignment, spacing, mainAxisSize.',
        'Expanded (wajib penuh, flex), Flexible (boleh lebih kecil), Spacer; Stack + Positioned.',
        'Batasan turun, ukuran naik, induk menentukan posisi: ketat, longgar, tak terbatas.',
        'Overflow: Expanded + ellipsis, Wrap, atau SingleChildScrollView.',
        'ListTile siap pakai; pecah tampilan menjadi class widget; uji di lebar 320–360.',
      ],
      catatan: 'Minta mahasiswa menyebutkan widget yang dipakai halaman Detail Menu Kantin beserta alasannya.',
    });

    d.penutup({
      judul: 'Saatnya Praktik!',
      subjudul: 'Kerjakan Jobsheet Pertemuan 4 (lima praktikum + tantangan Profil Kedai Kopi Kampus), lalu uji diri di Latihan. Pertemuan berikutnya: interaksi pengguna dan state lokal.',
      tautan: [
        { teks: 'Jobsheet P4', ikon: 'tugas', url: d.urlBerkas('pertemuan_04_widget_dan_layout/JOBSHEET.md') },
        { teks: 'Latihan P4', ikon: 'kuis', url: d.urlBerkas('pertemuan_04_widget_dan_layout/LATIHAN.md') },
        { teks: 'Modul P4', ikon: 'buku', url: d.urlBerkas('pertemuan_04_widget_dan_layout/README.md') },
      ],
      catatan: 'Ingatkan: tugas mandiri wajib bebas garis kuning-hitam di lebar 360 dan 320, dan dikumpulkan bersama screenshot kedua ukuran tersebut.',
    });
  },
};

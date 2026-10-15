// Konten slide Pertemuan 6 — Daftar Data & Navigasi Antarhalaman.
// Teks diambil dari modul bacaan (pertemuan_06_daftar_dan_navigasi/README.md).
// Tangkapan layar diambil dari folder pertemuan_06_daftar_dan_navigasi/gambar/.

module.exports = {
  nomor: '06',
  folder: 'pertemuan_06_daftar_dan_navigasi',
  namaBerkas: 'PERTEMUAN_06_Daftar_dan_Navigasi',
  topik: 'Daftar Data & Navigasi',

  bangun(d) {
    const C = d.C;
    const KODE = { fontFace: 'Consolas' };
    const BENAR = { bold: true, color: '2E7D32' };
    const SALAH = { bold: true, color: 'C62828' };

    d.judul({
      judul: 'Daftar Data & Navigasi Antarhalaman',
      subjudul: 'Pertemuan 6  ·  class model, ListView.builder, GridView, Dismissible & Key, pencarian, Navigator, PopScope, dan go_router',
      catatan: 'Sampai Pertemuan 5 semua aplikasi kita hanya satu halaman dengan isi yang sudah pasti. Hari ini kita menampilkan data dalam jumlah banyak dan berpindah antarhalaman sambil membawa data. Bekal yang dipakai: class dan List (Pertemuan 2–3), ListTile dan Expanded (Pertemuan 4), setState, dialog, dan mounted (Pertemuan 5).',
    });

    d.tujuan({
      pengantar: 'Setelah pertemuan ini, Anda mampu:',
      poin: [
        'Menyimpan data sebagai class model dan menampilkannya dengan ListView.builder',
        'Membuat ListView.separated dan GridView yang menyesuaikan lebar layar',
        'Menaruh daftar di dalam Column tanpa error unbounded height',
        'Menghapus item dengan geser, memakai Key yang benar, dan menyediakan "Urungkan"',
        'Membuat pencarian dan saringan tanpa mengubah data asli',
        'Berpindah halaman, mengirim data, menerima hasil, dan menahan tombol kembali',
        'Menyusun peta rute go_router dengan parameter alamat',
      ],
      catatan: 'Target akhir hari ini: aplikasi Katalog Menu Kantin yang terdiri dari beberapa halaman: daftar menu yang bisa dicari dan disaring, halaman detail beralamat /menu/:id, jumlah porsi yang dikirim balik, dan keranjang belanja.',
    });

    d.alur({
      judul: 'Peta Materi Hari Ini',
      langkah: [
        { ikon: 'daftar', judul: 'A. Menampilkan daftar', isi: 'Class model, ListView.builder, separated, GridView' },
        { ikon: 'geser', judul: 'B. Daftar yang hidup', isi: 'Geser untuk menghapus, Key, pencarian' },
        { ikon: 'lapisan', judul: 'C. Berpindah halaman', isi: 'Navigator, kirim data, terima hasil, PopScope' },
        { ikon: 'rute', judul: 'D. Alamat halaman', isi: 'go_router, parameter alamat, halaman tidak ditemukan' },
        { ikon: 'keranjang', judul: 'E. Merangkai', isi: 'Studi kasus Katalog Menu Kantin', warna: C.accent4 },
      ],
      catatan: 'Bagian A menampilkan data dalam jumlah banyak dengan rapi dan ringan. Bagian B membuat daftar itu bisa diubah dan dicari. Bagian C membawa pengguna ke halaman lain sambil membawa data. Bagian D memberi setiap halaman alamat seperti situs web. Bagian E merangkai semuanya.',
    });

    d.tabel({
      judul: 'Dua Kemampuan yang Dimiliki Hampir Semua Aplikasi',
      kepala: ['Aplikasi', 'Daftar yang tampil', 'Setelah item diketuk'],
      lebarKolom: [2.6, 3.9, 5.1],
      baris: [
        [{ text: 'WhatsApp', options: { bold: true } }, 'Daftar obrolan', 'Pindah ke halaman obrolan dengan orang itu'],
        [{ text: 'Aplikasi belanja', options: { bold: true } }, 'Kotak-kotak produk', 'Pindah ke halaman detail produk'],
        [{ text: 'Ojek daring', options: { bold: true } }, 'Daftar layanan', 'Pindah ke halaman layanan tersebut'],
        [{ text: 'Galeri foto', options: { bold: true } }, 'Kotak-kotak foto', 'Foto dibuka besar; tombol kembali menuju galeri lagi'],
      ],
      ukuran: 17,
      tinggiBaris: 0.75,
      pesan: 'Pola yang sama: menampilkan daftar data, lalu berpindah halaman sambil membawa data item yang diketuk.',
      catatan: 'Minta mahasiswa membuka aplikasi favorit di ponselnya dan menyebutkan daftar apa yang tampil serta apa yang terjadi saat item diketuk.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 1', judul: 'Class Model dan ListView.builder', ikon: 'daftar', catatan: 'Menyiapkan data dengan rapi, lalu menampilkannya sebagai daftar yang tetap ringan walaupun datanya ribuan.' });

    d.banding({
      judul: 'Menyiapkan Data: Satu Class untuk Satu Jenis Data',
      ukuranContoh: 12,
      kolom: [
        {
          ikon: 'galat', judul: 'Beberapa list terpisah', warna: C.accent5, tag: 'Rawan tertukar',
          poin: [
            'Empat list harus selalu sejajar',
            'Hapus satu judul tetapi lupa penulisnya → data bergeser',
            'Makin banyak keterangan, makin besar peluang salah',
          ],
          contoh: "const List<String> judul = [...];\nconst List<String> penulis = [...];\nconst List<int> tahun = [...];",
        },
        {
          ikon: 'centang', judul: 'Class model + satu List', warna: C.accent4, tag: 'Satu buku = satu paket utuh', sorot: true,
          poin: [
            'Semua keterangan buku dibungkus satu class',
            'Properti final, constructor const',
            'Menghapus buku = menghapus semua keterangannya',
          ],
          contoh: 'class Buku {\n  final String judul;\n  final String penulis;\n  // ... tahun, tersedia\n}\nconst List<Buku> daftarBuku = [...];',
        },
      ],
      catatan: 'Class model memodelkan (mewakili) benda dari dunia nyata. Pola yang dipakai sepanjang hari ini: data disimpan di satu List, lalu untuk setiap nomor baris kita mengambil satu objek dan menyerahkannya ke widget kecil yang menggambar satu baris.',
    });

    d.layar({
      judul: 'ListView.builder: Bangun Hanya yang Terlihat',
      gambar: 'hasil_contoh_01.jpg',
      lebarMaks: 3.4,
      berkas: 'kode/contoh_01_listview_builder.dart',
      kode: [
        'ListView.builder(',
        '  // berapa banyak baris seluruhnya',
        '  itemCount: 1000,',
        '  // resep untuk membuat SATU baris',
        '  itemBuilder: (BuildContext context, int index) {',
        '    final int nomor = index + 1; // index mulai 0',
        '    return ListTile(',
        "      title: Text('Nomor antrean $nomor'),",
        '    );',
        '  },',
        ')',
      ].join('\n'),
      ukuranKode: 14,
      poin: [
        'Seperti juru masak warung: memasak sesuai pesanan, bukan seribu porsi sekaligus.',
        'Saat dibuka, konsol hanya mencatat belasan baris pertama (yang terlihat + cadangan ±250 piksel).',
        'Jangan simpan data penting di widget baris: baris bisa dibuang lalu dibuat ulang.',
      ],
      ukuranPoin: 16,
      catatan: 'Jalankan contoh 01 dan buka konsol: catatan "membangun baris ke-..." hanya muncul untuk baris yang terlihat. Gulir pelan-pelan: catatan baru muncul sedikit demi sedikit. Gulir kembali ke atas: baris lama dibangun ulang. ListView(children: [...]) biasa hanya untuk isi yang sedikit dan sudah pasti, misalnya menu pengaturan.',
    });

    d.layar({
      judul: 'ListView.separated dan Widget Satu Baris',
      gambar: 'hasil_contoh_02.jpg',
      lebarMaks: 3.4,
      berkas: 'kode/contoh_02_model_dan_listview_separated.dart',
      kode: [
        'ListView.separated(',
        '  itemCount: daftarBuku.length,',
        '  separatorBuilder: (context, index) =>',
        '      const Divider(height: 1),',
        '  itemBuilder: (context, index) {',
        '    return BarisBuku(buku: daftarBuku[index]);',
        '  },',
        ')',
        '',
        '// di dalam BarisBuku: data menentukan tampilan',
        'trailing: Text(',
        "  buku.tersedia ? 'Tersedia' : 'Dipinjam',",
        ')',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        '7 buku → 6 garis pemisah (hanya di antara baris).',
        'Satu aturan untuk semua baris, bukan tujuh ListTile yang ditulis satu per satu.',
        "Judul 'Rak Buku (7 judul)' diambil dari daftarBuku.length.",
      ],
      ukuranPoin: 16,
      catatan: 'Isi itemBuilder sengaja pendek: ambil satu objek, serahkan ke BarisBuku. Pada contoh di slide, parameter fungsi ditulis tanpa tipe agar ringkas; di kode lengkap tipenya ditulis (BuildContext context, int index). Tambahkan satu buku ke daftar: judul AppBar ikut berubah dengan sendirinya.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 2', judul: 'GridView dan Daftar di Dalam Column', ikon: 'grid', catatan: 'Menyusun data sebagai kotak-kotak yang jumlah kolomnya menyesuaikan layar, lalu menaruh daftar di bawah ringkasan tanpa error.' });

    d.layar({
      judul: 'GridView: Daftar Berbentuk Kotak',
      gambar: ['hasil_contoh_03a.jpg', 'hasil_contoh_03b.jpg'],
      lebarMaks: 5.8,
      berkas: 'kode/contoh_03_gridview.dart',
      kode: [
        'GridView.builder(',
        '  padding: const EdgeInsets.all(16),',
        '  gridDelegate: const',
        '      SliverGridDelegateWithMaxCrossAxisExtent(',
        '    maxCrossAxisExtent: 180, // lebar maks',
        '    mainAxisExtent: 160, // tinggi tetap',
        '    mainAxisSpacing: 12,',
        '    crossAxisSpacing: 12,',
        '  ),',
        '  itemCount: daftarProduk.length,',
        '  itemBuilder: ...,',
        ')',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Ponsel: 2 kolom. Layar lebar: 3 kolom atau lebih.',
        'Kotak = Card + InkWell (Clip.antiAlias).',
      ],
      ukuranPoin: 15,
      catatan: 'Jumlah kolom kira-kira: lebar tersedia dibagi (lebar maksimal + jarak), dibulatkan ke atas. Di layar 360 dengan padding 16, lebar tersedia 328, sehingga 328 / 192 = 1,7 → 2 kolom. Nama produk dibatasi maxLines: 2 dan TextOverflow.ellipsis.',
    });

    d.banding({
      judul: 'Mengatur Jumlah Kolom dan Tinggi Kotak',
      kolom: [
        {
          ikon: 'kolom', judul: 'Jumlah kolom', warna: C.accent1, tag: 'Pilih MaxCrossAxisExtent',
          poin: [
            [{ text: 'FixedCrossAxisCount', options: { ...KODE, bold: true } }, { text: ': kolom selalu sama; di tablet kotaknya jadi sangat lebar.' }],
            [{ text: 'MaxCrossAxisExtent', options: { ...KODE, bold: true } }, { text: ': lebar maksimal kotak; jumlah kolom dihitung sendiri.' }],
          ],
        },
        {
          ikon: 'ukur', judul: 'Tinggi kotak', warna: C.accent4, tag: 'Pilih mainAxisExtent', sorot: true,
          poin: [
            [{ text: 'childAspectRatio', options: { ...KODE, bold: true } }, { text: ': tinggi ikut menyusut di layar sempit → teks bisa overflow.' }],
            [{ text: 'mainAxisExtent', options: { ...KODE, bold: true } }, { text: ': tinggi tetap dalam piksel, isi kotak selalu muat.' }],
          ],
        },
      ],
      pesan: 'Kuis: galeri foto 2 kolom di ponsel tetapi 5 kolom di monitor lebar → SliverGridDelegateWithMaxCrossAxisExtent.',
      catatan: 'Jobsheet Praktikum 2 punya eksperimen childAspectRatio: 1. Di lebar 360 kotaknya masih muat, tetapi di 320 semua kotak menampilkan garis kuning-hitam. Pelajaran yang sama dengan Pertemuan 5: selalu uji di lebar 320.',
    });

    d.layar({
      judul: 'Daftar di Dalam Column: Wajib Expanded',
      gambar: ['hasil_contoh_04_masalah.jpg', 'hasil_contoh_04.jpg'],
      lebarMaks: 5.6,
      berkas: 'kode/contoh_04_daftar_dalam_column.dart',
      kode: [
        'Column(',
        '  children: [',
        '    KartuRingkasan(...), // diam',
        '    Expanded(',
        '      // pakai SEMUA sisa tinggi layar',
        '      child: ListView.builder(...),',
        '    ),',
        '  ],',
        ')',
      ].join('\n'),
      ukuranKode: 14,
      poin: [
        [{ text: 'Tanpa Expanded (kiri): ' }, { text: 'Vertical viewport was given unbounded height.', options: KODE }],
        'Column berkata "setinggi apa pun boleh", ListView ingin setinggi mungkin → tinggi tak hingga.',
        'Seperti memesan lemari "setinggi mungkin" di ruangan tanpa atap.',
      ],
      ukuranPoin: 15,
      catatan: 'Ingat aturan constraints Pertemuan 4: induk memberi batas, anak memilih ukuran. Pilihan lain: SizedBox(height: 200) untuk daftar kecil di tengah halaman, atau menjadikan judul baris pertama ListView jika boleh ikut tergulir. shrinkWrap: true hanya untuk daftar yang sangat pendek, karena keunggulan builder hilang.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 3', judul: 'Geser untuk Menghapus dan Peran Key', ikon: 'geser', catatan: 'Daftar yang bisa berubah: menghapus dengan gerakan geser, memilih Key yang aman, dan menyediakan tombol Urungkan.' });

    d.layar({
      judul: 'Dismissible: Item yang Bisa "Diusir"',
      gambar: 'hasil_contoh_05.jpg',
      lebarMaks: 3.4,
      berkas: 'kode/contoh_05_dismissible_dan_urungkan.dart',
      kode: [
        'Dismissible(',
        '  key: ValueKey<int>(tugas.id), // wajib',
        '  direction: DismissDirection.endToStart,',
        '  background: Container(',
        '    color: warna.errorContainer,',
        '    alignment: Alignment.centerRight,',
        '    child: const Icon(Icons.delete),',
        '  ),',
        '  onDismissed: (DismissDirection arah) {',
        '    _hapus(index); // hapus dari daftar!',
        '  },',
        '  child: ListTile(...),',
        ')',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        [{ text: 'Lupa menghapus: ' }, { text: 'A dismissed Dismissible widget is still part of the tree.', options: KODE }],
        'Di browser: tahan klik, tarik ke kiri, lepaskan.',
      ],
      ukuranPoin: 15,
      catatan: 'onDismissed hanya memberi tahu bahwa item sudah digeser; ia tidak menghapus data kita. Item wajib dihapus dari daftar di dalam setState. Daftar kosong diganti tampilan ramah (TampilanKosong), agar layar tidak terlihat seperti aplikasi rusak.',
    });

    d.tabel({
      judul: 'Mengapa Key Wajib Unik dan Tetap?',
      pengantar: 'Analogi: dosen yang mengenali mahasiswa dari nomor kursi. Jika satu mahasiswa keluar, semua di belakangnya bergeser dan salah dikenali. Key adalah nama di punggung mahasiswa.',
      kepala: ['Pilihan key', 'Bagus?', 'Alasan'],
      lebarKolom: [3.6, 1.4, 6.6],
      baris: [
        [{ text: 'ValueKey<int>(tugas.id)', options: KODE }, { text: '✅', options: BENAR }, 'id unik dan tidak pernah berubah'],
        [{ text: 'ValueKey<int>(index)', options: KODE }, { text: '❌', options: SALAH }, 'index berubah setiap kali ada item yang dihapus ("nomor kursi")'],
        [{ text: 'UniqueKey()', options: KODE }, { text: '❌', options: SALAH }, 'key baru setiap build, item tidak pernah dikenali sebagai item yang sama'],
      ],
      ukuran: 17,
      tinggiBaris: 0.8,
      pesan: 'Karena itu class model Tugas diberi properti id.',
      catatan: 'Jobsheet Praktikum 3 punya eksperimen ValueKey(index): menghapus item pertama memunculkan layar error "A dismissed Dismissible widget is still part of the tree.", karena item berikutnya pindah ke index 0 dan mendapat key yang sama. Menghapus item terakhir tidak error, karena tidak ada item yang pindah ke posisinya.',
    });

    d.kode({
      judul: 'Tombol "Urungkan": Catat Dulu, Baru Hapus',
      kode: [
        'void _hapus(int indeks) {',
        '  // 1) catat DULU barang dan posisinya',
        '  final Tugas terhapus = _daftar[indeks];',
        '  // 2) baru hapus',
        '  setState(() { _daftar.removeAt(indeks); });',
        '',
        '  pesan.showSnackBar(SnackBar(',
        "    content: Text('\"${terhapus.judul}\" dihapus.'),",
        '    action: SnackBarAction(',
        "      label: 'Urungkan',",
        '      onPressed: () => setState(() {',
        '        _daftar.insert(indeks, terhapus);',
        '      }),',
        '    ),',
        '    persist: false,',
        '  ));',
        '}',
      ].join('\n'),
      ukuran: 13,
      berkas: 'kode/contoh_05_dismissible_dan_urungkan.dart',
      poin: [
        'insert(indeks, ...) mengembalikan ke posisi semula; add selalu ke ujung daftar.',
        'persist: false membuat SnackBar bertombol tetap hilang sendiri (Pertemuan 5).',
        'Sebelum showSnackBar, panggil hideCurrentSnackBar() agar pesan tidak antre.',
      ],
      catatan: 'Menghapus dengan geser itu cepat, sehingga mudah tidak sengaja. Aplikasi yang ramah menyediakan Urungkan. Untuk penghapusan permanen yang tidak bisa dikembalikan, pakai dialog konfirmasi (Pertemuan 5).',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 4', judul: 'Mencari dan Menyaring Daftar', ikon: 'cari', catatan: 'Prinsip utamanya: data asli tidak pernah diubah. Yang tampil dihitung ulang dari data asli dan pilihan pengguna.' });

    d.alur({
      judul: 'Data Asli Tidak Pernah Diubah',
      pengantar: 'Hasil pencarian adalah nilai turunan (Pertemuan 5): dihitung ulang setiap build().',
      langkah: [
        { ikon: 'data', judul: 'Data asli', isi: 'semuaUkm (const), tidak pernah berubah.' },
        { ikon: 'cari', judul: 'State', isi: 'Hanya _kataKunci dan _kategori.' },
        { ikon: 'saring', judul: 'Getter _hasil', isi: 'where(...).toList() dari data asli + state.' },
        { ikon: 'daftar', judul: 'Daftar yang tampil', isi: 'Menyesuaikan setiap kali state berubah.', warna: C.accent4 },
      ],
      tinggiKotak: 3.2,
      catatan: 'Mengapa tidak langsung menghapus item yang tidak cocok dari data? Karena begitu kata kunci dihapus, item yang tadi terhapus tidak bisa kembali. Dengan nilai turunan, data asli selalu tersedia.',
    });

    d.layar({
      judul: 'SearchBar, ChoiceChip, dan Hasil Kosong',
      gambar: ['hasil_contoh_06a.jpg', 'hasil_contoh_06b.jpg'],
      lebarMaks: 6.0,
      berkas: 'kode/contoh_06_pencarian_dan_filter.dart',
      kode: [
        'List<Ukm> get _hasil {',
        '  final String kunci =',
        '      _kataKunci.trim().toLowerCase();',
        '  return semuaUkm.where((Ukm ukm) {',
        '    final bool cocokNama =',
        '        ukm.nama.toLowerCase().contains(kunci);',
        '    final bool cocokKategori =',
        '        _kategori == null ||',
        '        ukm.kategori == _kategori;',
        '    return cocokNama && cocokKategori;',
        '  }).toList();',
        '}',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Kata kunci DAN nama sama-sama toLowerCase().',
        'clear() tidak memanggil onChanged: kosongkan juga _kataKunci.',
      ],
      ukuranPoin: 15,
      catatan: 'Kiri: kategori Seni dipilih. Kanan: kata kunci "renang" tidak cocok dengan UKM mana pun, sehingga tampil pesan yang menjelaskan mengapa kosong dan tombol Tampilkan semua. Deretan chip dibungkus SingleChildScrollView mendatar agar tidak terpotong di layar sempit. Chip sengaja tanpa ikon: pada Material 3, ikon chip yang terpilih ditutup lingkaran gelap dan tanda centangnya nyaris tidak terlihat.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 5', judul: 'Navigator: Berpindah Halaman', ikon: 'lapisan', catatan: 'Halaman disimpan sebagai tumpukan. Kita belajar membuka, menutup, mengirim data, menerima hasil, dan menahan tombol kembali.' });

    d.layar({
      judul: 'Halaman Ditumpuk Seperti Piring',
      gambar: 'hasil_contoh_07.jpg',
      lebarMaks: 3.4,
      berkas: 'kode/contoh_07_navigator_push_pop.dart',
      kode: [
        '// push: taruh halaman baru di ATAS',
        'Navigator.push(',
        '  context,',
        '  MaterialPageRoute<void>(',
        '    builder: (BuildContext context) =>',
        '        const HalamanProfil(),',
        '  ),',
        ');',
        '',
        '// pop: ambil halaman teratas',
        'Navigator.pop(context);',
      ].join('\n'),
      ukuranKode: 14,
      poin: [
        'Halaman di bawah tidak dibuang; state-nya tetap ada.',
        'AppBar otomatis menampilkan panah kembali selama masih ada halaman di bawah.',
        'Yang terakhir masuk, yang pertama keluar.',
      ],
      ukuranPoin: 16,
      catatan: 'Contoh 07 menggambar isi tumpukan saat itu. Tekan Tumpuk halaman baru beberapa kali, lalu tekan panah kembali: halaman muncul kembali dalam urutan terbalik. Halaman pertama tidak boleh di-pop, sehingga tombol Kembali dinonaktifkan di Halaman 1 (onPressed: null).',
    });

    d.tabel({
      judul: 'Perintah Navigator',
      kepala: ['Perintah', 'Yang terjadi', 'Contoh penggunaan'],
      lebarKolom: [2.8, 4.3, 4.5],
      baris: [
        [{ text: 'push', options: KODE }, 'Tambah halaman di atas', 'Membuka halaman detail'],
        [{ text: 'pop', options: KODE }, 'Ambil halaman teratas', 'Kembali dari halaman detail'],
        [{ text: 'popUntil', options: KODE }, 'Terus pop sampai syarat terpenuhi', '"Kembali ke beranda" dari halaman yang dalam'],
        [{ text: 'pushReplacement', options: KODE }, 'Ganti halaman teratas', 'Dari login ke beranda, agar tidak bisa kembali ke login'],
        [{ text: 'maybePop', options: KODE }, 'pop jika diizinkan', 'Dipakai panah kembali; menghormati PopScope'],
        [{ text: 'canPop', options: KODE }, 'Masih ada halaman di bawah?', 'Menentukan perlu tidaknya tombol Kembali'],
      ],
      ukuran: 15,
      catatan: 'Kuis: tumpukan Beranda → Daftar → Detail (Detail tampil). Panah kembali ditekan dua kali. Halaman apa yang tampil? Jawab: Beranda.',
    });

    d.layar({
      judul: 'Mengirim Data lewat Constructor',
      gambar: ['hasil_contoh_08a.jpg', 'hasil_contoh_08b.jpg'],
      lebarMaks: 6.0,
      berkas: 'kode/contoh_08_mengirim_data.dart',
      kode: [
        'class HalamanDetailGedung',
        '    extends StatelessWidget {',
        '  const HalamanDetailGedung({',
        '    super.key,',
        '    required this.gedung,',
        '  });',
        '  final Gedung gedung; // data masuk',
        '  // build(): gedung.nama, gedung.jamBuka',
        '}',
        '',
        '// di halaman daftar, saat diketuk:',
        'builder: (BuildContext context) =>',
        '    HalamanDetailGedung(gedung: gedung),',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Halaman = widget biasa (Pertemuan 4).',
        'Hindari variabel global untuk data.',
      ],
      ukuranPoin: 15,
      catatan: 'Ikon chevron_right (›) di ujung baris adalah isyarat Material: baris ini bisa diketuk dan akan membuka halaman baru. Halaman detail cukup StatelessWidget karena hanya menampilkan. Variabel global sulit dilacak: halaman mana yang mengubahnya, dan kapan? Data masuk dari pintu depan, yaitu constructor.',
    });

    d.layar({
      judul: 'Menerima Hasil dari Halaman',
      gambar: ['hasil_contoh_09a.jpg', 'hasil_contoh_09b.jpg'],
      lebarMaks: 6.0,
      berkas: 'kode/contoh_09_menerima_hasil.dart',
      kode: [
        '// Halaman pertama: TUNGGU hasilnya',
        'final String? kota =',
        '    await Navigator.push<String>(',
        '  context,',
        '  MaterialPageRoute<String>(builder: ...),',
        ');',
        'if (!mounted) return;',
        'if (kota == null) return; // tanpa memilih',
        'setState(() { _kotaTujuan = kota; });',
        '',
        '// Halaman kedua: tutup SAMBIL membawa hasil',
        'Navigator.pop(context, kota);',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Tipe hasil ditulis dua kali: push<String> dan MaterialPageRoute<String>.',
        'Panah kembali = hasil null.',
      ],
      ukuranPoin: 15,
      catatan: 'Analogi menitip pesan kepada teman yang ke toko: kita menunggu, dan ia bisa kembali membawa jawaban atau tanpa kabar. Persis seperti dialog di Pertemuan 5 yang ditutup dengan mengetuk area gelap. Kuis: halaman B ditutup dengan Navigator.pop(context, 5), tetapi A memakai push<String>. Apa yang salah? Jenis datanya tidak cocok.',
    });

    d.layar({
      judul: 'PopScope: Menahan Tombol Kembali',
      gambar: 'hasil_contoh_10.jpg',
      lebarMaks: 3.4,
      berkas: 'kode/contoh_10_popscope.dart',
      kode: [
        'PopScope(',
        '  // false = tombol kembali DITAHAN',
        '  canPop: !_adaIsi,',
        '  onPopInvokedWithResult:',
        '      (bool sudahTertutup, Object? hasil) async {',
        '    if (sudahTertutup) return;',
        '    final bool buang = await _tanyaBuang();',
        '    if (!mounted) return;',
        '    if (buang) Navigator.pop(context);',
        '  },',
        '  child: Scaffold(...),',
        ')',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        'Kosong → langsung tertutup. Ada tulisan → tanya dulu.',
        'Navigator.pop buatan kita sendiri (tombol Simpan) tidak ditahan.',
        'WillPopScope dan onPopInvoked sudah usang.',
      ],
      ukuranPoin: 15,
      catatan: 'PopScope hanya menahan tombol dan gerakan kembali (panah AppBar, tombol kembali Android). WillPopScope usang sejak Flutter 3.12, onPopInvoked usang sejak Flutter 3.22; jika VS Code mencoret kode Anda, berarti memakai versi yang lama.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 6', judul: 'go_router: Setiap Halaman Punya Alamat', ikon: 'rute', catatan: 'Paket dari tim Flutter untuk navigasi berbasis alamat. Semua alamat ditulis di satu peta rute.' });

    d.kartu({
      judul: 'Mengapa Halaman Butuh Alamat?',
      pengantar: 'Analogi: denah gedung kampus di pintu masuk. Cukup sebut alamatnya ("Gedung B, lantai 2"), denah yang menentukan jalannya.',
      kolom: 3,
      tinggiKartu: 2.6,
      item: [
        { ikon: 'web', judul: 'Alamat di browser', isi: 'Setiap halaman punya alamat seperti …/menu/3 yang bisa disalin dan dibagikan.' },
        { ikon: 'tautan', judul: 'Deep linking', isi: 'Notifikasi atau tautan langsung membuka halaman tertentu di dalam aplikasi.' },
        { ikon: 'rambu', judul: 'Satu peta rute', isi: 'Semua halaman dan alamatnya terkumpul di satu tempat, tidak tersebar.' },
      ],
      catatan: 'Istilah: alamat (path) seperti /tentang; rute (GoRoute) = pasangan alamat dan halaman; peta rute (GoRouter) = kumpulan semua rute; parameter alamat seperti /fakultas/:kode yang isinya berubah-ubah.',
    });

    d.kode({
      judul: 'Memasang go_router dan Menulis Peta Rute',
      kode: [
        'final GoRouter petaRute = GoRouter(',
        '  routes: [',
        '    GoRoute(',
        "      path: '/',",
        '      builder: (context, state) => const HalamanBeranda(),',
        '      routes: [',
        '        GoRoute(',
        "          path: 'fakultas/:kode', // tanpa / di depan",
        '          builder: (context, state) => HalamanFakultas(',
        "              kode: state.pathParameters['kode']!),",
        '        ),',
        '      ],',
        '    ),',
        '  ],',
        ');',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.0,
      berkas: 'kode/contoh_11_go_router.dart',
      poin: [
        [{ text: 'pubspec.yaml: ' }, { text: 'go_router: ^17.5.0', options: KODE }, { text: ', lalu import package:go_router/go_router.dart.' }],
        'Mengapa versi 17? Mulai versi 18, go_router dibuat untuk paket material_ui; proyek Flutter 3.47 masih memakai flutter/material.dart.',
        'DartPad sudah memakai versi 18: perpindahan tampil tanpa animasi, wajar.',
        'Aplikasi memakai MaterialApp.router dengan routerConfig: petaRute, menggantikan home:.',
      ],
      catatan: 'Tanda ^ pada ^17.5.0 berarti versi 17.5.0 atau lebih baru selama masih versi 17. Rute anak (tanpa garis miring di depan) berarti halaman itu ditumpuk di atas induknya, sehingga otomatis punya panah kembali menuju beranda. Di DartPad paket sudah tersedia; cukup tulis import.',
    });

    d.banding({
      judul: 'context.go atau context.push?',
      ukuranContoh: 13,
      kolom: [
        {
          ikon: 'rambu', judul: "context.go('/tentang')", warna: C.accent1, tag: 'Pindah tempat',
          poin: [
            'Tumpukan disusun ulang mengikuti peta rute',
            'Tentang adalah anak "/" → di bawahnya Beranda',
            'Untuk berpindah ke "tempat" lain di aplikasi',
          ],
          contoh: 'Tentang  ← tampil\nBeranda',
        },
        {
          ikon: 'lapisan', judul: "context.push('/tentang')", warna: C.accent4, tag: 'Menumpuk', sorot: true,
          poin: [
            'Ditumpuk di atas halaman sekarang, seperti Navigator.push',
            'Panah kembali menuju halaman sebelumnya',
            'Bisa ditunggu hasilnya: await context.push<int>(...)',
          ],
          contoh: 'Tentang  ← tampil\nFakultas Teknik\nBeranda',
        },
      ],
      pesan: 'context.pop(hasil) bekerja seperti Navigator.pop. Untuk halaman pemilih yang hasilnya ditunggu, selalu push.',
      catatan: 'Contoh di slide: dari halaman Fakultas Teknik membuka halaman Tentang. Setelah go, panah kembali menuju Beranda. Setelah push, panah kembali menuju Fakultas Teknik.',
    });

    d.layar({
      judul: 'Parameter Alamat dan Halaman Tidak Ditemukan',
      gambar: ['hasil_contoh_11a.jpg', 'hasil_contoh_11b.jpg', 'hasil_contoh_11c.jpg'],
      lebarMaks: 7.0,
      berkas: 'kode/contoh_11_go_router.dart',
      kode: [
        '// isi alamat SELALU String',
        'final String teks =',
        "    state.pathParameters['id']!;",
        'final int? id = int.tryParse(teks);',
        '// null → halaman "tidak ditemukan"',
        '',
        '// alamat yang tidak ada di peta rute:',
        'errorBuilder: (context, state) =>',
        '    HalamanTidakDitemukan(',
        '      alamat: state.uri.toString(),',
        '    ),',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        '/menu/abc dan /menu/99 tetap cocok dengan rute: periksa datanya.',
        'Kirim id di alamat, bukan objek di extra.',
      ],
      ukuranPoin: 14,
      catatan: 'Tanpa errorBuilder, go_router menampilkan halaman bawaan Page Not Found dengan pesan no routes for location: /beasiswa. Parameter kueri seperti /cari?q=soto dibaca dengan state.uri.queryParameters["q"]. Objek di extra tidak tertulis di alamat, sehingga hilang saat halaman web dimuat ulang atau dibuka dari tautan.',
    });

    d.tabel({
      judul: 'Navigator atau go_router?',
      kepala: ['', 'Navigator.push', 'go_router'],
      lebarKolom: [3.6, 3.9, 4.1],
      baris: [
        [{ text: 'Cara membuka halaman', options: { bold: true } }, 'Menunjuk widget langsung', 'Menyebut alamat'],
        [{ text: 'Paket tambahan', options: { bold: true } }, 'Tidak perlu', 'Perlu (go_router)'],
        [{ text: 'Alamat & deep linking', options: { bold: true } }, 'Tidak', 'Ya'],
        [{ text: 'Daftar semua halaman', options: { bold: true } }, 'Tersebar di banyak tempat', 'Terkumpul di satu peta rute'],
        [{ text: 'Cocok untuk', options: { bold: true } }, 'Aplikasi kecil, latihan, halaman sementara', 'Aplikasi nyata, apalagi yang berjalan di web'],
      ],
      ukuran: 16,
      pesan: 'Keduanya bisa dipakai bersama: dialog dan bottom sheet tetap dibuka dengan cara Pertemuan 5.',
      catatan: 'Pesan error yang sering muncul: No GoRouter found in context (masih memakai MaterialApp biasa), dan The method go isn\'t defined for the type BuildContext (lupa import go_router).',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 7', judul: 'Studi Kasus: Katalog Menu Kantin', ikon: 'keranjang', catatan: 'Merangkai semua materi hari ini menjadi aplikasi beberapa halaman dengan pencarian, alamat, hasil yang dikirim balik, dan keranjang.' });

    d.tabel({
      judul: 'Rancangan: Di Mana State Disimpan?',
      kepala: ['Data', 'Disimpan di', 'Jenis'],
      lebarKolom: [5.0, 3.9, 2.7],
      baris: [
        ['Daftar menu', 'const daftarMenu', 'data tetap'],
        ['Kata kunci & kategori', 'State katalog', 'state'],
        ['Isi keranjang (id menu → jumlah porsi)', { text: 'Map<int, int>', options: KODE }, 'state'],
        ['Hasil pencarian, total porsi, total harga', 'getter di State katalog', { text: 'nilai turunan', options: { bold: true } }],
        ['Jumlah porsi yang sedang dipilih', 'State halaman detail', 'state'],
      ],
      ukuran: 16,
      tinggiBaris: 0.72,
      pesan: 'Keranjang menyimpan id menu, bukan objeknya: id unik dan tetap, alasannya sama seperti key di Bagian 3.',
      catatan: 'Halaman dan alamatnya: / untuk HalamanKatalog (StatefulWidget), /menu/:id untuk HalamanDetailMenu (StatefulWidget, jumlah porsi), alamat lain untuk HalamanTidakDitemukan. Biasakan membuat tabel ini sebelum menulis kode.',
    });

    d.alur({
      judul: 'Alur Data Antarhalaman',
      langkah: [
        { ikon: 'sentuh', judul: '1. push', isi: "Ketuk menu → push<int>('/menu/1')." },
        { ikon: 'hitung', judul: '2. Pilih porsi', isi: 'Pengguna memilih 2 porsi di halaman detail.' },
        { ikon: 'kembali', judul: '3. pop(2)', isi: 'context.pop(_jumlah) membawa jumlah pulang.' },
        { ikon: 'keranjang', judul: '4. Keranjang', isi: '_keranjang[1] = 2 → tombol "2 porsi · Rp30.000".' },
        { ikon: 'centang', judul: '5. Pesan', isi: 'Bottom sheet → keranjang kosong → SnackBar.', warna: C.accent4 },
      ],
      tinggiKotak: 3.2,
      catatan: 'Baris kuncinya: _keranjang[menu.id] = (_keranjang[menu.id] ?? 0) + jumlah; artinya ambil jumlah yang sudah ada (atau 0 jika belum pernah dipesan), lalu tambahkan jumlah baru. Selalu periksa mounted dan null setelah await.',
    });

    d.layar({
      judul: 'Studi Kasus: Katalog Menu Kantin',
      gambar: ['hasil_contoh_12a.jpg', 'hasil_contoh_12b.jpg', 'hasil_contoh_12c.jpg'],
      lebarMaks: 6.6,
      berkas: 'kode/contoh_12_studi_kasus_katalog_menu.dart',
      poin: [
        'Pencarian + chip kategori (Bagian 4).',
        'Kartu bertanda ×2 dan ×1.',
        'Detail /menu/:id + TombolJumlah.',
        'Tombol keranjang muncul jika ada isi.',
        'Cek: 2 × 15.000 + 1 × 4.000 = Rp34.000.',
      ],
      ukuranPoin: 14,
      catatan: 'Skenario uji di modul Bagian 14.4: cari "es", pilih chip Camilan, tambah 2 Nasi Goreng Spesial, buka Es Teh Manis lalu kembali tanpa menambah (tidak ada yang berubah), tambah 1 Es Teh Manis, buka keranjang, pesan. Di Chrome, coba juga alamat /#/menu/3 dan /#/menu/99.',
    });

    d.tabel({
      judul: 'Kesalahan Umum Pemula',
      kepala: ['Pesan error / gejala', 'Penyebab dan solusi'],
      lebarKolom: [6.0, 5.6],
      baris: [
        ['Vertical viewport was given unbounded height.', 'ListView di dalam Column: bungkus dengan Expanded'],
        ['RangeError (index): Index out of range', 'itemCount kosong atau salah: itemCount: daftar.length'],
        ['A dismissed Dismissible widget is still part of the tree.', 'Item tidak dihapus di onDismissed, atau key memakai index'],
        ['Kolom pencarian kosong, daftar masih tersaring', 'clear() tidak memanggil onChanged: kosongkan juga kata kuncinya'],
        ['Hasil dari halaman kedua selalu null', 'Kirim dengan Navigator.pop(context, nilai); tangani null'],
        ['No GoRouter found in context', 'Gunakan MaterialApp.router(routerConfig: petaRute)'],
        ['Perpindahan go_router tanpa animasi', 'Pakai go_router: ^17.5.0 di proyek (di DartPad wajar)'],
      ],
      ukuran: 14,
      catatan: 'Tabel lengkap ada di modul bagian 15, termasuk WillPopScope yang usang dan peringatan use_build_context_synchronously.',
    });

    d.ringkasan({
      poin: [
        'Data dibungkus class model dan disimpan sebagai satu List objek.',
        'ListView.builder hanya membangun baris yang dibutuhkan; isi itemCount.',
        'separated menambah pemisah; GridView + MaxCrossAxisExtent + mainAxisExtent.',
        'Daftar di dalam Column wajib Expanded.',
        'Dismissible: hapus item di onDismissed, key unik dan tetap, Urungkan dengan insert.',
        'Pencarian = nilai turunan; data asli tidak diubah.',
        'Navigator: push/pop; data masuk lewat constructor, hasil lewat await + pop(nilai).',
        'PopScope menahan tombol kembali; go_router memberi setiap halaman alamat.',
      ],
      catatan: 'Minta mahasiswa menjelaskan perjalanan data saat menambah menu ke keranjang: dari katalog ke detail lewat apa, dan kembali lewat apa.',
    });

    d.penutup({
      judul: 'Saatnya Praktik!',
      subjudul: 'Kerjakan Jobsheet Pertemuan 6 (lima praktikum + tugas Agenda Acara Kampus), lalu uji diri di Latihan. Pertemuan berikutnya: Material Design 3 dan tampilan responsif.',
      tautan: [
        { teks: 'Jobsheet P6', ikon: 'tugas', url: d.urlBerkas('pertemuan_06_daftar_dan_navigasi/JOBSHEET.md') },
        { teks: 'Latihan P6', ikon: 'kuis', url: d.urlBerkas('pertemuan_06_daftar_dan_navigasi/LATIHAN.md') },
        { teks: 'Modul P6', ikon: 'buku', url: d.urlBerkas('pertemuan_06_daftar_dan_navigasi/README.md') },
      ],
      catatan: 'Ingatkan: praktikum 5 memakai go_router; di VS Code tambahkan go_router: ^17.5.0 di pubspec.yaml. Tugas mandiri wajib diuji seperti pengguna sungguhan (cari yang tidak ada, daftar lalu batalkan, kembali tanpa memilih, sembunyikan lalu urungkan) dan bebas overflow di 360 dan 320.',
    });
  },
};

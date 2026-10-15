// Konten slide Pertemuan 9 — Manajemen State & Pola MVVM.
// Teks diambil dari modul bacaan (pertemuan_09_state_dan_mvvm/README.md).
// Tangkapan layar diambil dari folder pertemuan_09_state_dan_mvvm/gambar/.

module.exports = {
  nomor: '09',
  folder: 'pertemuan_09_state_dan_mvvm',
  namaBerkas: 'PERTEMUAN_09_State_dan_MVVM',
  topik: 'Manajemen State & MVVM',

  bangun(d) {
    const C = d.C;
    const KODE = { fontFace: 'Consolas' };
    const kode = (teks) => ({ text: teks, options: KODE });

    d.judul({
      judul: 'Manajemen State & Pola MVVM',
      subjudul: 'Pertemuan 9  ·  ChangeNotifier, ListenableBuilder, ValueNotifier, paket provider (watch, read, select, Consumer, MultiProvider), MVVM, repository, status memuat, cakupan provider, dan menguji ViewModel',
      catatan: 'Sampai Pertemuan 7, data yang berubah selalu disimpan di State milik sebuah widget. Hari ini kita mengeluarkan data yang dipakai banyak halaman dari widget, lalu menata aplikasi dengan pola MVVM yang direkomendasikan panduan arsitektur resmi Flutter. Bekal: class, getter, Future/async (P3), setState, mengangkat state, dispose (P5), Navigator.push (P6), tema dan mode gelap (P7).',
    });

    d.tujuan({
      pengantar: 'Setelah pertemuan ini, Anda mampu:',
      poin: [
        'Membedakan state lokal dan state aplikasi, lalu memilih tempatnya',
        'Membuat ChangeNotifier: data privat, getter, dan notifyListeners()',
        'Mendengarkan perubahan dengan ListenableBuilder dan ValueNotifier',
        'Berbagi state dengan provider: watch, read, select, dan Consumer',
        'Menata aplikasi dengan MVVM dan repository (memuat, berhasil, gagal)',
        'Mengatur cakupan provider: seluruh aplikasi atau satu halaman',
        'Memeriksa logika ViewModel tanpa mengetuk layar',
        'Memecah proyek menjadi folder MVVM yang rapi',
      ],
      catatan: 'Target akhir hari ini: aplikasi Kuis Kampus. Soal diambil dari repository, skor dihitung oleh ViewModel, dan skor terbaik setiap topik tetap tampil di beranda walaupun halaman kuisnya sudah ditutup. Mulai hari ini proyek akhir juga dimulai: proposal dikumpulkan sesuai arahan dosen.',
    });

    d.alur({
      judul: 'Peta Materi Hari Ini',
      langkah: [
        { ikon: 'peringatan', judul: 'A. Masalah setState', isi: 'Data dioper berantai, halaman usang, state lokal vs aplikasi' },
        { ikon: 'pengeras', judul: 'B. Mengumumkan perubahan', isi: 'ChangeNotifier, ListenableBuilder, ValueNotifier' },
        { ikon: 'gedung', judul: 'C. Paket provider', isi: 'Menitipkan objek; watch, read, select, Consumer, MultiProvider' },
        { ikon: 'lapisan', judul: 'D. Pola MVVM', isi: 'ViewModel, repository, status memuat, cakupan, pengujian, folder' },
        { ikon: 'kuis', judul: 'E. Merangkai', isi: 'Studi kasus Kuis Kampus', warna: C.accent4 },
      ],
      catatan: 'Bagian A menunjukkan mengapa setState saja tidak cukup untuk data yang dipakai banyak halaman. Bagian B membuat objek yang bisa mengumumkan perubahan. Bagian C membuat objek itu bisa diambil widget mana pun. Bagian D menata kode agar rapi dan mudah diuji. Bagian E merangkai semuanya.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 1', judul: 'Mengapa setState Saja Tidak Cukup?', ikon: 'peringatan', catatan: 'Dua masalah dalam satu contoh, lalu cara memilih: state lokal atau state aplikasi.' });

    d.lapisan({
      judul: 'Masalah 1: Data Dioper Berantai (Prop Drilling)',
      lapisan: [
        { ikon: 'pohon', judul: 'HalamanToko (StatefulWidget)', isi: 'Menyimpan _keranjang, _tambah, dan _hapus' },
        { ikon: 'daftar', judul: 'DaftarBarang', isi: 'Tidak memakai onTambah, hanya MENERUSKAN', warna: C.accent5 },
        { ikon: 'baris', judul: 'BarisBarang', isi: 'Baru di sini onTambah benar-benar dipakai', warna: C.accent4 },
      ],
      keterangan: [
        'Contoh 01: toko belanja yang isi keranjangnya disimpan di HalamanToko.',
        'Setiap tingkat harus menerima dan meneruskan data yang tidak dipakainya.',
        'Bayangkan lima tingkat widget: kelimanya ikut menerima onTambah.',
      ],
      catatan: 'Prop drilling = mengoper data lewat constructor dari tingkat ke tingkat, termasuk melewati widget yang tidak memakainya. Di Contoh 01 baru tiga tingkat, jadi masih terasa wajar; masalahnya membesar seiring aplikasi.',
    });

    d.layar({
      judul: 'Masalah 2: Halaman Keranjang Tidak Ikut Berubah',
      gambar: 'hasil_contoh_01.jpg',
      berkas: 'kode/contoh_01_masalah_state_bertingkat.dart',
      kode: [
        '// Di HalamanToko: membuka halaman Keranjang',
        'Navigator.push(',
        '  context,',
        '  MaterialPageRoute<void>(',
        '    builder: (BuildContext context) =>',
        '        HalamanKeranjang(keranjang: _keranjang, onHapus: _hapus),',
        '  ),',
        ');',
      ].join('\n'),
      poin: [
        'Tambah 3 barang, buka Keranjang, hapus 1: barangnya tetap terlihat, judul tetap "Keranjang (3)".',
        'setState hanya membangun ulang HalamanToko. Halaman yang di-push seperti fotokopi saat dibuka.',
        'Bahaya: tombol hapus di layar usang menunjuk posisi yang salah (RangeError, atau barang lain yang terhapus).',
      ],
      ukuranPoin: 16,
      catatan: 'Cek cepat: mengapa lencana jumlah barang di AppBar ikut berubah, padahal halaman Keranjang tidak? Karena lencana itu bagian dari HalamanToko yang dibangun ulang oleh setState. Halaman Keranjang adalah halaman lain di atasnya. Demo: hapus barang ketiga lalu tekan lagi tombol hapusnya → RangeError di konsol.',
    });

    d.banding({
      judul: 'State Lokal vs State Aplikasi',
      ukuranContoh: 13,
      kolom: [
        {
          ikon: 'orang', judul: 'State lokal', warna: C.accent6, tag: 'Satu widget atau halaman, boleh hilang',
          poin: [
            'Teks yang sedang diketik di formulir',
            'Tab atau chip yang sedang dipilih',
            'Jumlah porsi sebelum dipesan',
          ],
          contoh: 'setState(() {\n  _tabTerpilih = 1;\n});',
        },
        {
          ikon: 'grup', judul: 'State aplikasi', warna: C.accent1, tag: 'Banyak halaman, harus tetap ada', sorot: true,
          poin: [
            'Isi keranjang belanja',
            'Pengguna yang masuk, pilihan mode gelap',
            'Data dari server, skor yang dicapai',
          ],
          contoh: 'context.read<Keranjang>()\n    .tambah(nama);',
        },
      ],
      pesan: 'Tanyakan: dipakai lebih dari satu halaman? Harus tetap ada setelah halamannya ditutup? Jika salah satunya "ya" → state aplikasi.',
      catatan: 'Istilah dokumentasi Flutter: ephemeral state dan app state. Satu aplikasi hampir selalu memakai keduanya: di Contoh 07 nanti, isi formulir tambah tugas tetap memakai setState, sedangkan daftar tugasnya disimpan di luar widget.',
    });

    d.kartu({
      judul: 'Ide Penyelesaian: Objek Tersendiri',
      pengantar: 'Keluarkan data yang dipakai bersama dari widget, lalu simpan di objek yang:',
      kolom: 3,
      tinggiKartu: 3.6,
      item: [
        { ikon: 'kotak', judul: 'Menyimpan data', isi: 'Datanya dan semua cara mengubahnya berada di satu objek, di luar widget.', kode: 'class Keranjang\n    extends ChangeNotifier' },
        { ikon: 'pengeras', judul: 'Mengumumkan perubahan', isi: 'Memberi tahu semua yang mendengarkan bahwa datanya berubah. (Bagian 3–5)', kode: 'notifyListeners();' },
        { ikon: 'gedung', judul: 'Bisa diambil di mana saja', isi: 'Widget mana pun, di halaman mana pun, mengambilnya sendiri. (Bagian 6–8)', kode: 'context.watch<Keranjang>()' },
      ],
      catatan: 'Ketiga sifat ini yang akan kita bangun satu per satu. Poin 1 dan 2 dipenuhi ChangeNotifier (bawaan Flutter); poin 3 dipenuhi paket provider.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 2', judul: 'ChangeNotifier, ListenableBuilder, dan ValueNotifier', ikon: 'pengeras', catatan: 'Objek yang bisa mengumumkan perubahan, widget yang mendengarkannya, dan versi siap pakai untuk satu nilai.' });

    d.tabel({
      judul: 'Analogi: Petugas Antrean dengan Pengeras Suara',
      kepala: ['Di ruang layanan akademik', 'Di Flutter'],
      lebarKolom: [6.0, 5.6],
      baris: [
        ['Petugas yang memegang daftar antrean', kode('Objek turunan ChangeNotifier')],
        ['Mengumumkan lewat pengeras suara', kode('notifyListeners()')],
        ['Papan nomor, mahasiswa, petugas loket yang mendengarkan', 'Widget pendengar (listener)'],
      ],
      ukuran: 18,
      tinggiBaris: 0.95,
      pesan: 'Tidak ada yang perlu bertanya terus-menerus "nomor berapa sekarang?". Cukup mendengarkan pengumuman.',
      catatan: 'ChangeNotifier adalah class bawaan Flutter (package:flutter/foundation.dart). Tidak perlu paket tambahan.',
    });

    d.kode({
      judul: 'Anatomi Sebuah ChangeNotifier',
      berkas: 'kode/contoh_02_changenotifier_dasar.dart',
      kode: [
        'class AntreanLayanan extends ChangeNotifier { // 1',
        '  int _nomorTerakhir = 0; // 2',
        '  int _dipanggil = 0;',
        '',
        '  int get dipanggil => _dipanggil; // 3',
        '  int get menunggu =>',
        '      _nomorTerakhir - _dipanggil; // 4',
        '',
        '  void ambilNomor() { // 5',
        '    _nomorTerakhir++;',
        '    notifyListeners(); // 6',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 15,
      lebarKode: 7.0,
      poin: [
        '1  extends ChangeNotifier: bisa menyimpan pendengar dan mengumumkan.',
        '2  Data diawali _ (privat): tidak bisa diubah langsung dari luar.',
        '3  Getter: dari luar hanya bisa DIBACA.',
        '4  Nilai turunan dihitung, tidak disimpan.',
        '5  Satu-satunya cara mengubah data: lewat metode.',
        '6  Setiap metode pengubah diakhiri notifyListeners().',
      ],
      catatan: 'Mengapa privat? Jika _dipanggil publik, kode lain bisa menulis antrean.dipanggil = 5 tanpa notifyListeners(): data berubah, tetapi layar tidak. Objek ini dibuat sekali di State dan dibuang di dispose(). Jika dipakai setelah dibuang: "A AntreanLayanan was used after being disposed." Cek cepat: void reset() { _nomorTerakhir = 0; _dipanggil = 0; } kurang apa? notifyListeners().',
    });

    d.layar({
      judul: 'ListenableBuilder: Membangun Ulang Sebagian Layar',
      gambar: 'hasil_contoh_02.jpg',
      berkas: 'kode/contoh_02_changenotifier_dasar.dart',
      kode: [
        'ListenableBuilder(',
        '  listenable: antrean, // objek yang didengarkan',
        '  builder: (BuildContext context, Widget? child) {',
        '    // Dijalankan lagi SETIAP KALI antrean',
        '    // memanggil notifyListeners().',
        "    return Text('${antrean.menunggu} orang menunggu');",
        '  },',
        ')',
      ].join('\n'),
      poin: [
        'Halaman ini TIDAK memanggil setState sama sekali.',
        'Tiga widget mendengarkan objek antrean yang sama: PapanPanggilan, PanelPetugas, dan sebagian PanelMahasiswa.',
        'Letakkan ListenableBuilder serendah mungkin: hanya bagian yang berubah.',
      ],
      ukuranPoin: 16,
      catatan: 'PanelMahasiswa hanya membungkus teks nomor terakhir dengan ListenableBuilder; tombolnya cukup memanggil antrean.ambilNomor dan tidak perlu dibangun ulang. Di tutorial lama, AnimatedBuilder dipakai untuk tujuan yang sama; sekarang AnimatedBuilder adalah turunan ListenableBuilder.',
    });

    d.layar({
      judul: 'ValueNotifier dan Jebakan List',
      gambar: 'hasil_contoh_03.jpg',
      berkas: 'kode/contoh_03_valuenotifier.dart',
      kode: [
        'final ValueNotifier<int> _jumlahTiket =',
        '    ValueNotifier<int>(1);',
        '_jumlahTiket.value++; // otomatis mengumumkan',
        '',
        'final ValueNotifier<List<String>> _peserta =',
        '    ValueNotifier<List<String>>([]);',
        '// SALAH: isi bertambah, tanpa pengumuman.',
        "_peserta.value.add('Peserta baru');",
        '// BENAR: List BARU, lalu ganti .value.',
        "_peserta.value = [..._peserta.value, 'Peserta baru'];",
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        'Ditampilkan dengan ValueListenableBuilder<int>.',
        'Satu nilai sederhana → ValueNotifier. Beberapa data, nilai turunan, atau aturan → class ChangeNotifier sendiri.',
        'Bukti: 2× "cara salah", lalu 1× "cara benar" → tiba-tiba muncul 3 peserta.',
      ],
      ukuranPoin: 16,
      catatan: 'ValueNotifier hanya mengumumkan jika .value DIGANTI dengan nilai yang berbeda. .add(...) tidak mengganti objek List-nya, jadi tidak ada pengumuman. Dua nama yang ditambahkan diam-diam ikut terlihat saat tampilan akhirnya dibangun ulang oleh cara yang benar. Cek cepat: ValueNotifier<int> bernilai 3, lalu notifier.value = 3. Apakah pendengarnya dibangun ulang? Tidak, karena 3 == 3. ValueNotifier juga harus dibuang di dispose().',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 3', judul: 'Paket provider: Menitipkan Objek di Pohon Widget', ikon: 'gedung', catatan: 'Membuat objek bisa diambil widget mana pun tanpa dioper lewat constructor.' });

    d.kartu({
      judul: 'Analogi: Penitipan di Resepsionis Gedung',
      pengantar: 'Barang dititipkan di lobi. Siapa pun DI DALAM gedung itu, di lantai berapa pun, bisa memintanya.',
      kolom: 3,
      tinggiKartu: 3.4,
      item: [
        { ikon: 'gedung', judul: 'Meja resepsionis', isi: 'Widget ChangeNotifierProvider: tempat objek dititipkan.', kode: 'ChangeNotifierProvider(\n  create: ...,\n  child: ...,\n)' },
        { ikon: 'grup', judul: 'Seisi gedung', isi: 'Semua widget DI BAWAH provider itu di pohon widget.' },
        { ikon: 'tanya', judul: 'Meminta barang', isi: 'Cukup sebut jenisnya:', kode: 'context.watch<Keranjang>()\ncontext.read<Keranjang>()' },
      ],
      catatan: 'Orang di gedung lain tidak bisa memintanya: widget yang tidak berada di bawah provider tidak bisa mengambil objeknya. Paket provider dipakai dokumentasi resmi Flutter di panduan simple app state management dan di contoh panduan arsitekturnya.',
    });

    d.alur({
      judul: 'Tiga Langkah Memakai provider',
      pengantar: 'Pasang paketnya sekali: flutter pub add provider (DartPad sudah menyediakannya).',
      langkah: [
        { ikon: 'kelas', judul: '1. Buat class', isi: 'Turunan ChangeNotifier: data privat, getter, metode + notifyListeners()' },
        { ikon: 'gedung', judul: '2. Titipkan', isi: 'ChangeNotifierProvider di atas MaterialApp' },
        { ikon: 'lonceng', judul: '3. Ambil', isi: 'watch untuk menampilkan, read untuk memanggil metode', warna: C.accent4 },
      ],
      tinggiKotak: 3.6,
      catatan: 'flutter pub add provider menambahkan baris provider: ^6.1.5 (angka mengikuti versi terbaru) di bagian dependencies pada pubspec.yaml. Setiap berkas yang memakainya menulis import \'package:provider/provider.dart\';. Contoh 04 adalah toko yang sama dengan Contoh 01, ditulis ulang dengan provider.',
    });

    d.kode({
      judul: 'Langkah 1: Class Keranjang',
      berkas: 'kode/contoh_04_provider_dasar.dart',
      kode: [
        'class Keranjang extends ChangeNotifier {',
        '  final List<String> _isi = [];',
        '',
        '  UnmodifiableListView<String> get isi =>',
        '      UnmodifiableListView(_isi);',
        '  int get jumlah => _isi.length;',
        '',
        '  void tambah(String barang) {',
        '    _isi.add(barang);',
        '    notifyListeners();',
        '  }',
        '',
        '  // hapus(int indeks) dan kosongkan()',
        '  // juga diakhiri notifyListeners().',
        '}',
      ].join('\n'),
      ukuran: 15,
      lebarKode: 6.6,
      poin: [
        'Mengapa tidak mengembalikan _isi langsung? List bisa diubah siapa pun yang memegangnya.',
        'UnmodifiableListView (dari dart:collection) = kaca etalase: isinya bisa dilihat, tidak bisa diubah.',
        'keranjang.isi.add(...) dari luar → error Unsupported operation: Cannot add to an unmodifiable list.',
      ],
      catatan: 'Tanpa UnmodifiableListView, kode lain bisa menulis keranjang.isi.add(\'Sabun\') dan isi keranjang berubah tanpa notifyListeners(). Dengan kaca etalase, kesalahan seperti itu langsung ketahuan saat dijalankan.',
    });

    d.kode({
      judul: 'Langkah 2: Titipkan di Atas MaterialApp',
      berkas: 'kode/contoh_04_provider_dasar.dart',
      kode: [
        'void main() {',
        '  runApp(',
        '    ChangeNotifierProvider(',
        '      create: (BuildContext context) => Keranjang(),',
        '      child: const AplikasiBelanja(),',
        '    ),',
        '  );',
        '}',
      ].join('\n'),
      ukuran: 15,
      lebarKode: 7.2,
      poin: [
        'create: membuat objek, dipanggil SEKALI saat objek pertama kali diminta.',
        'child: semua widget di dalamnya, termasuk semua halaman, bisa mengambil Keranjang.',
        'Saat provider dilepas, dispose() objeknya dipanggil otomatis.',
        'Di atas MaterialApp, karena halaman hasil Navigator.push diletakkan oleh Navigator yang berada DI DALAM MaterialApp.',
      ],
      catatan: 'Gambar pohonnya: ChangeNotifierProvider → MaterialApp → Navigator → HalamanToko (watch jumlah) dan HalamanKeranjang (watch isi). Semua halaman berada "di dalam gedung yang sama".',
    });

    d.layar({
      judul: 'Langkah 3: Ambil di Widget yang Membutuhkan',
      gambar: 'hasil_contoh_04.jpg',
      berkas: 'kode/contoh_04_provider_dasar.dart',
      kode: [
        '// HalamanToko (kini StatelessWidget):',
        'final int jumlah =',
        '    context.watch<Keranjang>().jumlah;',
        '',
        '// BarisBarang, tombol tambah:',
        'onPressed: () =>',
        '    context.read<Keranjang>().tambah(nama),',
        '',
        '// HalamanKeranjang:',
        'final Keranjang keranjang =',
        '    context.watch<Keranjang>();',
      ].join('\n'),
      poin: [
        'watch: ambil DAN dengarkan perubahan. read: cukup ambil, lalu panggil metodenya.',
        'DaftarBarang (perantara) tidak dibutuhkan lagi.',
        'Barang yang dihapus langsung hilang: "Keranjang (2)".',
      ],
      ukuranPoin: 16,
      catatan: 'Cek cepat: HalamanToko berubah dari StatefulWidget menjadi StatelessWidget. Mengapa tetap bisa menampilkan jumlah barang yang selalu baru? Datanya kini di objek Keranjang, dan context.watch mendaftarkan HalamanToko sebagai pendengar.',
    });

    d.banding({
      judul: 'Buat Objek di create, Bukan di .value',
      ukuranContoh: 13,
      kolom: [
        {
          ikon: 'centang', judul: 'create', warna: C.accent4, tag: 'Objek BARU dibuat di sini', sorot: true,
          poin: [
            'Dipanggil sekali; objek bertahan walaupun widget dibangun ulang',
            'Dibuang otomatis saat provider dilepas',
          ],
          contoh: 'ChangeNotifierProvider(\n  create: (BuildContext context) =>\n      Keranjang(),\n  child: const AplikasiBelanja(),\n)',
        },
        {
          ikon: 'galat', judul: '.value', warna: C.accent5, tag: 'Hanya untuk objek yang SUDAH ADA',
          poin: [
            'Objek baru di .value + di dalam build → keranjang baru setiap dibangun ulang, isinya kosong lagi',
            '.value tidak memanggil dispose()',
          ],
          contoh: '// SALAH: objek baru di .value\nChangeNotifierProvider.value(\n  value: Keranjang(),\n  child: const AplikasiBelanja(),\n)',
        },
      ],
      catatan: 'Pemakaian .value yang benar (meneruskan ViewModel yang sudah ada ke halaman berikutnya) dibahas di Bagian 11 modul.',
    });

    d.tabel({
      judul: 'watch, select, read, dan Consumer',
      kepala: ['Cara', 'Analogi grup obrolan kelas', 'Dibangun ulang saat'],
      lebarKolom: [3.3, 4.6, 3.7],
      baris: [
        [kode('context.watch<T>()'), 'Notifikasi aktif: setiap pesan baru, ponsel berbunyi', 'Setiap notifyListeners()'],
        [kode('context.select(...)'), 'Ponsel berbunyi hanya jika nama Anda disebut', 'Nilai yang dipilih berubah'],
        [kode('context.read<T>()'), 'Notifikasi dimatikan; grup dibuka saat perlu mengirim', 'Tidak pernah'],
        [kode('Consumer<T>'), 'Seperti watch, tetapi hanya satu bagian kecil layar', 'Setiap perubahan, hanya isi builder'],
      ],
      ukuran: 16,
      tinggiBaris: 0.72,
      pesan: 'Menampilkan data → watch atau select (di dalam build). Memanggil metode → read (di onPressed, onChanged, initState).',
      catatan: 'Contoh select: context.select((Pertandingan p) => p.skorBiru). Consumer dipakai di tengah sebuah widget untuk membungkus bagian kecil yang berubah.',
    });

    d.layar({
      judul: 'Membuktikan: Menghitung Berapa Kali Widget Dibangun',
      gambar: 'hasil_contoh_05.jpg',
      berkas: 'kode/contoh_05_watch_read_select.dart',
      kode: [
        '// KartuSkorBiru: hanya peduli skor Tim Biru.',
        'final int skor =',
        '    context.select((Pertandingan p) => p.skorBiru);',
        '',
        '// KartuKeterangan: dibangun ulang SETIAP perubahan.',
        'final Pertandingan pertandingan =',
        '    context.watch<Pertandingan>();',
        '',
        '// PanelTombol: tombol hanya MEMANGGIL metode.',
        'onPressed: () =>',
        '    context.read<Pertandingan>().golBiru(),',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        'Jalankan, lalu tekan "Gol Tim Biru" tiga kali.',
        'Setiap kartu menuliskan berapa kali ia sudah dibangun.',
      ],
      ukuranPoin: 16,
      catatan: 'Penghitung build di Contoh 05 hanya untuk pembuktian. Pada aplikasi sungguhan jangan menaruh perhitungan atau efek samping di dalam build, karena Flutter boleh memanggil build kapan saja.',
    });

    d.tabel({
      judul: 'Hasil Setelah 3 Gol Tim Biru',
      kepala: ['Kartu', 'Cara', 'Dibangun', 'Mengapa'],
      lebarKolom: [2.6, 1.8, 1.5, 5.7],
      baris: [
        ['Tim Biru', kode('select'), { text: '4×', options: { bold: true } }, 'Skor Biru berubah tiga kali'],
        ['Tim Merah', kode('select'), { text: '1×', options: { bold: true } }, 'Skor Merah tidak berubah'],
        ['Keterangan', kode('watch'), { text: '4×', options: { bold: true, color: C.accent5 } }, 'Setiap perubahan, walaupun tulisannya hanya berubah sekali'],
        ['Total gol', kode('Consumer'), { text: '4×', options: { bold: true } }, 'Isi builder dibangun ulang setiap perubahan'],
        ['Logo di Consumer', kode('child'), { text: '1×', options: { bold: true } }, 'Dibuat sekali di luar builder, lalu dipakai ulang'],
        ['Panel tombol', kode('read'), { text: '1×', options: { bold: true } }, 'read tidak mendengarkan'],
      ],
      ukuran: 16,
      tinggiBaris: 0.6,
      pesan: 'Harga watch: kartu Keterangan dibangun 4 kali padahal tulisannya ("Tim Biru unggul") hanya berubah sekali.',
      catatan: 'Angka "1×" adalah build pertama saat halaman dibuka. Di Latihan, mahasiswa mengganti watch di KartuKeterangan dengan select lalu memprediksi angkanya.',
    });

    d.kode({
      judul: 'Consumer dan Parameter child',
      berkas: 'kode/contoh_05_watch_read_select.dart',
      kode: [
        'Consumer<Pertandingan>(',
        '  builder: (BuildContext context, Pertandingan p,',
        '      Widget? child) {',
        '    return Row(',
        '      children: [',
        '        child!, // logo, tidak dibuat ulang',
        '        const SizedBox(width: 16),',
        '        Expanded(',
        "          child: Text('Total gol: ${p.totalGol}'),",
        '        ),',
        '      ],',
        '    );',
        '  },',
        '  child: const LogoLiga(),',
        ')',
      ].join('\n'),
      ukuran: 14,
      lebarKode: 7.0,
      poin: [
        'context: posisi Consumer di pohon widget.',
        'p: objek Pertandingan yang sudah didengarkan.',
        'child: widget yang dibuat SEKALI, lalu diberikan lagi setiap builder dijalankan.',
        'Cocok saat yang berubah hanya sebagian kecil dari widget besar.',
      ],
      catatan: 'Kode di slide disederhanakan; di Contoh 05, teks Consumer juga menuliskan berapa kali Consumer dibangun.',
    });

    d.tabel({
      judul: 'Pesan Error yang Sering Muncul',
      kepala: ['Kesalahan', 'Yang muncul', 'Solusi'],
      lebarKolom: [2.9, 6.2, 2.5],
      baris: [
        ['watch di dalam onPressed', kode('Tried to listen to a value exposed with provider, from outside of the widget tree.'), 'Pakai read'],
        ['select di dalam callback', kode('Tried to use `context.select` outside of the `build` method of a widget.'), 'Pakai read'],
        ['read di dalam build untuk menampilkan data', 'Tidak ada error, tetapi layar TIDAK PERNAH berubah', 'Pakai watch atau select'],
      ],
      ukuran: 15,
      tinggiBaris: 0.85,
      pesan: 'Kesalahan ketiga paling sulit ditemukan justru karena tidak ada pesan apa pun.',
      catatan: 'Cek cepat: di Contoh 05, jika tombol Ulang ditulis context.watch<Pertandingan>().ulang(), lalu ditekan? Konsol menampilkan error pertama di tabel, dan skor tidak kembali ke 0 karena error terjadi sebelum ulang() sempat dipanggil.',
    });

    d.kode({
      judul: 'MultiProvider: Beberapa Objek Sekaligus',
      berkas: 'kode/contoh_06_multiprovider.dart',
      kode: [
        'void main() {',
        '  runApp(',
        '    MultiProvider(',
        '      providers: [',
        '        ChangeNotifierProvider(',
        '          create: (BuildContext context) =>',
        '              PengaturanTampilan(),',
        '        ),',
        '        ChangeNotifierProvider(',
        '          create: (BuildContext context) =>',
        '              ProfilPengguna(),',
        '        ),',
        '      ],',
        '      child: const AplikasiKu(),',
        '    ),',
        '  );',
        '}',
      ].join('\n'),
      ukuran: 14,
      lebarKode: 6.4,
      poin: [
        'Hasilnya sama dengan menyusun provider bertingkat, tetapi tidak semakin dalam.',
        'PengaturanTampilan: mode terang/gelap dan warna benih.',
        'ProfilPengguna: nama yang sudah disimpan.',
      ],
      catatan: 'Versi bertingkat: ChangeNotifierProvider(create: ... PengaturanTampilan(), child: ChangeNotifierProvider(create: ... ProfilPengguna(), child: const AplikasiKu())). Semakin banyak objek, semakin dalam tingkatannya.',
    });

    d.layar({
      judul: 'MaterialApp pun Bisa Mendengarkan',
      gambar: ['hasil_contoh_06a.jpg', 'hasil_contoh_06b.jpg'],
      lebarMaks: 5.6,
      berkas: 'kode/contoh_06_multiprovider.dart',
      kode: [
        'final PengaturanTampilan atur =',
        '    context.watch<PengaturanTampilan>();',
        'return MaterialApp(',
        '  theme: ThemeData(colorScheme:',
        '    ColorScheme.fromSeed(seedColor: atur.benih)),',
        '  darkTheme: ... // benih sama, Brightness.dark',
        '  themeMode: atur.mode,',
        '  home: const HalamanBeranda(),',
        ');',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Pengaturan memanggil read<PengaturanTampilan>().gantiMode(...): seluruh aplikasi berganti.',
        'Teks yang sedang diketik = state lokal; nama yang sudah disimpan = state aplikasi.',
      ],
      ukuranPoin: 15,
      catatan: 'Dibandingkan P7: dulu mode disimpan di State akar dan halaman pengaturan menerima mode + onModeBerubah lewat constructor. Kini halaman pengaturan tidak menerima apa pun; ia mengambil sendiri dengan watch dan read. Nilai awal kolom nama diambil dengan context.read<ProfilPengguna>().nama di initState. Judul beranda baru berubah setelah tombol ✓ ditekan.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 4', judul: 'Pola MVVM', ikon: 'lapisan', catatan: 'Memisahkan bentuk data, tampilan, dan logika halaman.' });

    d.tabel({
      judul: 'MVVM: Model–View–ViewModel',
      pengantar: 'Satu class State berisi semuanya → sulit dibaca, sulit diuji, sulit diubah. MVVM memisahkan perannya.',
      kepala: ['Peran', 'Analogi restoran', 'Di kode'],
      lebarKolom: [2.4, 5.4, 3.8],
      baris: [
        [{ text: 'Model', options: { bold: true } }, 'Bahan makanan: bentuknya jelas, tidak memasak sendiri', 'Class data: Tugas, enum Prioritas'],
        [{ text: 'View', options: { bold: true } }, 'Pelayan: menyajikan dan mencatat pesanan, TIDAK memasak', 'Widget'],
        [{ text: 'ViewModel', options: { bold: true } }, 'Dapur: mengolah pesanan menjadi hidangan siap saji', 'Turunan ChangeNotifier'],
        [{ text: 'Repository', options: { bold: true } }, 'Pemasok bahan: dapur tidak peduli dibeli di pasar mana', 'Class Repositori...'],
      ],
      ukuran: 16,
      tinggiBaris: 0.7,
      pesan: 'MVVM adalah pola yang direkomendasikan panduan arsitektur resmi Flutter.',
      catatan: 'Sampai P7, satu class State biasanya berisi data, aturan menyaring, perhitungan, dan widget sekaligus. Untuk aplikasi kecil itu wajar; saat aplikasi membesar, satu berkas berisi ratusan baris campuran logika dan tampilan.',
    });

    d.alur({
      judul: 'Alur Data Satu Arah',
      pengantar: 'Kejadian mengalir dari View ke ViewModel. Data mengalir dari ViewModel ke View. View tidak pernah mengubah data sendiri.',
      langkah: [
        { ikon: 'sentuh', judul: '1. View', isi: 'Meneruskan perintah: cari, tambah, ubahStatus' },
        { ikon: 'restoran', judul: '2. ViewModel', isi: 'Meminta data ke repository' },
        { ikon: 'gudang', judul: '3. Repository', isi: 'Mengembalikan Model' },
        { ikon: 'pengeras', judul: '4. ViewModel', isi: 'Mengolah, lalu notifyListeners()', warna: C.accent4 },
        { ikon: 'hp', judul: '5. View', isi: 'Membangun ulang dengan data siap tampil', warna: C.accent4 },
      ],
      tinggiKotak: 3.5,
      catatan: 'Istilahnya unidirectional data flow, sangat disarankan dokumentasi resmi Flutter. Karena arahnya selalu sama, sumber masalah mudah dilacak: data salah → periksa ViewModel; tampilan salah → periksa View.',
    });

    d.kartu({
      judul: 'Aturan MVVM yang Kita Pakai',
      kolom: 3,
      item: [
        { ikon: 'banding', judul: 'Satu View, satu ViewModel', isi: 'Setiap halaman punya ViewModel-nya sendiri.' },
        { ikon: 'hp', judul: 'View: logika tampilan saja', isi: 'if sederhana, animasi, tata letak menurut ukuran layar, navigasi sederhana.' },
        { ikon: 'restoran', judul: 'ViewModel: data + perintah', isi: 'Data privat, getter untuk dibaca View, dan perintah (metode) yang dipanggil View.' },
        { ikon: 'gudang', judul: 'Data dari repository', isi: 'ViewModel tidak membuat atau mengambil data sendiri.' },
        { ikon: 'gembok', judul: 'Tanpa BuildContext', isi: 'ViewModel tidak menyimpan context dan tidak membuat widget. SnackBar, dialog, navigasi: tugas View.', warna: C.accent6 },
      ],
      catatan: 'Aturan 1–4 diringkas dari panduan arsitektur resmi Flutter; aturan 5 adalah kebiasaan baik untuk mata kuliah ini. Di pertemuan ini, perintah cukup berupa metode biasa. Contoh 07 masih menyimpan data awal di ViewModel agar sederhana; Bagian 10 menunjukkan cara yang benar dengan repository.',
    });

    d.layar({
      judul: 'Membedah Contoh 07: Tugas Kuliahku',
      gambar: 'hasil_contoh_07.jpg',
      berkas: 'kode/contoh_07_mvvm_dasar.dart',
      kode: [
        'class DaftarTugasViewModel extends ChangeNotifier {',
        '  final List<Tugas> _semua = [/* empat tugas */];',
        "  String _kataKunci = '';",
        '  Prioritas? _saringan; // null = semua',
        '',
        '  void cari(String teks) {',
        '    _kataKunci = teks;',
        '    notifyListeners();',
        '  }',
        '}',
        '',
        '// View: membaca vm.tampil, meneruskan ketikan',
        'onChanged: (String teks) =>',
        '    context.read<DaftarTugasViewModel>().cari(teks),',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        'Getter tampil: tugas yang cocok dengan kata kunci dan saringan, siap tampil.',
        'BarisTugas tidak mengenal ViewModel: hanya menerima tugas, selesai, dan onUbah.',
      ],
      ukuranPoin: 15,
      catatan: 'Getter tampil hampir sama dengan _hasil di P6 Bagian 8.1; yang berbeda hanya tempatnya: dulu di State halaman, kini di ViewModel. Model Tugas immutable: semua field final dan constructor const; status selesai disimpan di _selesai milik ViewModel. HalamanTambahTugas: isi kolom dan pilihan prioritas tetap state lokal (setState); saat disimpan memanggil vm.tambah(...). Cek cepat: tugas Tinggi harus selalu di atas → ubah getter tampil di ViewModel; View tidak berubah sama sekali.',
    });

    d.kartu({
      judul: 'Apa Untungnya?',
      kolom: 2,
      item: [
        { ikon: 'uji', judul: 'Mudah diuji', isi: 'Logika di ViewModel bisa diperiksa tanpa layar (Bagian 12).', warna: C.accent4 },
        { ikon: 'buku', judul: 'Mudah dibaca', isi: 'Setiap class punya satu tugas yang jelas.' },
        { ikon: 'ubah', judul: 'Mudah diubah', isi: 'Tampilan dirombak tanpa menyentuh logika; sumber data diganti tanpa menyentuh tampilan.' },
        { ikon: 'grup', judul: 'Mudah dikerjakan bersama', isi: 'Satu orang mengerjakan View, yang lain ViewModel, dengan kesepakatan getter dan perintah.', warna: C.accent6 },
      ],
      catatan: 'Catatan untuk yang membaca studi kasus resmi Flutter: di sana ViewModel diberikan ke View lewat constructor lalu didengarkan dengan ListenableBuilder, dan provider dipakai untuk menitipkan repository. Cara itu dan cara context.watch di modul ini sama-sama benar.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 5', judul: 'Repository dan Status Memuat', ikon: 'gudang', catatan: 'Sumber data yang bisa diganti, dan tiga keadaan data yang butuh waktu.' });

    d.kode({
      judul: 'Kontrak dan Implementasi Repository',
      berkas: 'kode/contoh_08_repository_dan_status_muat.dart',
      kode: [
        'abstract class RepositoriPengumuman {',
        '  Future<List<Pengumuman>> ambilSemua();',
        '}',
        '',
        'class RepositoriPengumumanPalsu',
        '    implements RepositoriPengumuman {',
        '  int _percobaan = 0;',
        '',
        '  @override',
        '  Future<List<Pengumuman>> ambilSemua() async {',
        '    _percobaan++;',
        '    await Future<void>.delayed(',
        '        const Duration(milliseconds: 1500));',
        '    if (_percobaan.isEven) {',
        "      throw Exception('Server tidak dapat dihubungi');",
        '    }',
        '    return const [/* empat pengumuman */];',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 6.8,
      poin: [
        'Kontrak (abstract class): APA yang bisa diminta, tanpa isi (P3).',
        'Implementasi palsu untuk latihan; implements = janji menyediakan semua metode kontrak.',
        'delayed 1,5 detik meniru waktu tunggu internet.',
        'isEven: percobaan ke-2, ke-4, ... sengaja gagal agar tampilan gagal bisa dilihat.',
      ],
      catatan: 'Data bisa datang dari kode (sekarang), REST API (P10), atau penyimpanan perangkat (P11). Jika ViewModel mengambil data sendiri, setiap sumber berganti ViewModel harus ditulis ulang. Repository = pemasok bahan; dapur tetap memasak dengan cara yang sama.',
    });

    d.kode({
      judul: 'Tiga Status: memuat, berhasil, gagal',
      berkas: 'kode/contoh_08_repository_dan_status_muat.dart',
      kode: [
        'enum StatusMuat { memuat, berhasil, gagal }',
        '',
        'Future<void> muat() async {',
        '  _status = StatusMuat.memuat;',
        '  notifyListeners();',
        '  try {',
        '    _daftar = await _repositori.ambilSemua();',
        '    _status = StatusMuat.berhasil;',
        '  } catch (galat) {',
        "    debugPrint('Galat saat memuat: $galat');",
        "    _pesanGalat = 'Pengumuman gagal dimuat. ...';",
        '    _status = StatusMuat.gagal;',
        '  }',
        '  if (_sudahDibuang) {',
        '    return;',
        '  }',
        '  notifyListeners();',
        '}',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 6.6,
      poin: [
        'enum, bukan beberapa bool yang bisa bertentangan ("memuat" dan "gagal" sekaligus).',
        'Pesan teknis ke konsol, pesan ramah ke pengguna.',
        '_sudahDibuang: halaman bisa sudah ditutup selama menunggu.',
      ],
      catatan: 'Tanpa penjaga _sudahDibuang, kembali sebelum 1,5 detik membuat muat() memanggil notifyListeners() pada ViewModel yang sudah dibuang: "A PengumumanViewModel was used after being disposed." Penjaganya: di dispose() set _sudahDibuang = true lalu super.dispose(); periksa tanda itu setelah setiap await.',
    });

    d.layar({
      judul: 'View Memilih Tampilan dengan switch',
      gambar: ['hasil_contoh_08a.jpg', 'hasil_contoh_08b.jpg', 'hasil_contoh_08c.jpg'],
      lebarMaks: 7.0,
      berkas: 'kode/contoh_08_repository_dan_status_muat.dart',
      kode: [
        'final Widget isi = switch (vm.status) {',
        '  StatusMuat.memuat =>',
        '      const TampilanMemuat(),',
        '  StatusMuat.gagal => TampilanGagal(',
        '    pesan: vm.pesanGalat,',
        '    onCobaLagi: () => context',
        '        .read<PengumumanViewModel>()',
        '        .muat(),',
        '  ),',
        '  StatusMuat.berhasil =>',
        '      DaftarPengumuman(daftar: vm.daftar),',
        '};',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Muat ulang (percobaan 2) → gagal; Coba lagi (percobaan 3) → berhasil.',
        'Status baru, misalnya kosong → analyzer menandai setiap switch yang belum menanganinya.',
      ],
      ukuranPoin: 14,
      catatan: 'Selama memuat, ikon muat ulang di AppBar nonaktif (onPressed: null), sehingga data tidak dimuat dua kali bersamaan. Saat gagal, konsol menampilkan: Galat saat memuat: Exception: Server tidak dapat dihubungi.',
    });

    d.kode({
      judul: 'Menitipkan Repository dan Menyerahkannya ke ViewModel',
      berkas: 'kode/contoh_08_repository_dan_status_muat.dart',
      kode: [
        '// main(): untuk seluruh aplikasi',
        'Provider<RepositoriPengumuman>(',
        '  create: (BuildContext context) =>',
        '      RepositoriPengumumanPalsu(),',
        '  child: const AplikasiPengumuman(),',
        ')',
        '',
        '// home: di AplikasiPengumuman',
        'ChangeNotifierProvider(',
        '  create: (BuildContext context) =>',
        '      PengumumanViewModel(',
        '        repositori:',
        '            context.read<RepositoriPengumuman>(),',
        '      )..muat(),',
        '  child: const HalamanPengumuman(),',
        ')',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 6.4,
      poin: [
        'Provider biasa: repository tidak mengumumkan perubahan.',
        'Tipe provider = KONTRAK. P10 cukup mengganti satu baris create.',
        'Dependency injection: ViewModel menerima repository lewat constructor.',
        '..muat() (cascade): buat objek, panggil muat(), kembalikan objeknya.',
      ],
      catatan: 'Cek cepat: P10 membuat RepositoriPengumumanApi. Selain menulis class barunya, apa yang diubah? Hanya baris create di main. ViewModel dan View hanya mengenal kontrak RepositoriPengumuman. Dependency injection dibahas lebih dalam di P12.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 6', judul: 'Cakupan dan Umur Provider', ikon: 'rute', catatan: 'Letak provider menentukan siapa yang bisa memakai objeknya dan berapa lama objek itu hidup.' });

    d.layar({
      judul: 'Dua Letak Provider dalam Satu Aplikasi',
      gambar: 'hasil_contoh_09.jpg',
      berkas: 'kode/contoh_09_cakupan_provider.dart',
      kode: [
        'Navigator.push(',
        '  context,',
        '  MaterialPageRoute<void>(',
        '    // Provider DI DALAM rute: hanya halaman ini',
        '    // yang memakainya; dibuang saat ditutup.',
        '    builder: (BuildContext context) =>',
        '        ChangeNotifierProvider(',
        '          create: (BuildContext context) =>',
        '              PendaftaranViewModel(workshop),',
        '          child: const HalamanPendaftaran(),',
        '        ),',
        '  ),',
        ');',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        'Simpanan di atas MaterialApp: hidup selama aplikasi berjalan.',
        'Buka workshop lagi → "ViewModel ke-2", peserta kembali 1, tetapi tetap "Tersimpan".',
      ],
      ukuranPoin: 15,
      catatan: 'Langkah demo: ketuk Desain UI dengan Figma (ViewModel ke-1), tambah peserta menjadi 3 (Rp150.000), Simpan workshop ini, kembali (lencana simpanan 1), buka lagi. Konsol: ViewModel ke-1 DIBUAT untuk "Desain UI dengan Figma" / ViewModel ke-1 DIBUANG / ViewModel ke-2 DIBUAT untuk "Desain UI dengan Figma".',
    });

    d.tabel({
      judul: 'Memilih Letak yang Tepat',
      kepala: ['Letak provider', 'Siapa yang bisa memakai', 'Umur objek', 'Cocok untuk'],
      lebarKolom: [2.6, 2.7, 2.4, 3.9],
      baris: [
        ['Di atas MaterialApp', 'Semua halaman', 'Selama aplikasi berjalan', 'State aplikasi: keranjang, pengguna, pengaturan, riwayat skor, repository'],
        ['Di dalam builder sebuah rute', 'Halaman itu dan widget di bawahnya', 'Selama halaman itu terbuka', 'ViewModel halaman: formulir, jalannya satu kuis, detail satu barang'],
      ],
      ukuran: 17,
      tinggiBaris: 0.9,
      pesan: 'Pertanyaan penentunya: apakah datanya harus tetap ada setelah halamannya ditutup?',
      catatan: 'Cek cepat Kuis Kampus: RiwayatSkor di atas MaterialApp (skor terbaik harus tetap ada setelah kuis ditutup); KuisViewModel di dalam rute halaman kuis (setiap kuis mulai dari soal pertama).',
    });

    d.tabel({
      judul: 'Saat Provider Tidak Ditemukan',
      pengantar: 'Error: Could not find the correct Provider<PendaftaranViewModel> above this HalamanRingkasan Widget',
      kepala: ['Penyebab', 'Solusi'],
      lebarKolom: [6.0, 5.6],
      baris: [
        ['Provider belum dipasang sama sekali', 'Pasang di main atau di rute yang tepat'],
        ['Provider baru ditambahkan di main, lalu hanya hot reload', 'Hot restart (R besar): hot reload tidak menjalankan ulang main'],
        ['Provider dipasang di rute halaman LAIN (halaman hasil push bersaudara, bukan anak)', 'Pindahkan ke atas MaterialApp, atau teruskan objeknya dengan .value'],
        ['context berada DI ATAS provider (membaca di build yang sama tempat provider dibuat)', 'Pindahkan ke class tersendiri di bawahnya, atau bungkus dengan Consumer'],
      ],
      ukuran: 15,
      tinggiBaris: 0.82,
      catatan: 'Pengantar tabel adalah pesan error aslinya; nama class menyesuaikan. Dua penyebab terakhir dibahas di slide berikutnya.',
    });

    d.banding({
      judul: 'Dua Perbaikan untuk Provider yang Tidak Ditemukan',
      ukuranContoh: 12,
      kolom: [
        {
          ikon: 'pindah', judul: 'Meneruskan objek dengan .value', warna: C.accent1, tag: 'Halaman baru "meminjam" ViewModel yang sudah ada',
          poin: [
            'Ambil dengan read, titipkan lagi dengan .value',
            'Yang membuang tetap provider pembuatnya',
          ],
          contoh: 'final PendaftaranViewModel vm =\n    context.read<PendaftaranViewModel>();\n// di builder rute baru:\nChangeNotifierProvider.value(\n  value: vm, // objek yang SUDAH ADA\n  child: const HalamanRingkasan(),\n)',
        },
        {
          ikon: 'widget', judul: 'context di bawah provider', warna: C.accent6, tag: 'Consumer punya context sendiri',
          poin: [
            'SALAH: context.watch<Keranjang>() di build yang sama dengan ChangeNotifierProvider-nya',
          ],
          contoh: 'ChangeNotifierProvider(\n  create: (BuildContext context) => Keranjang(),\n  child: Consumer<Keranjang>(\n    builder: (BuildContext context,\n        Keranjang keranjang, Widget? child) {\n      return Text(\'${keranjang.jumlah} barang\');\n    },\n  ),\n)',
        },
      ],
      catatan: 'Pada kolom kanan, context milik widget yang membuat provider berada DI ATAS provider itu, sehingga context.watch di sana tidak menemukannya. Consumer (atau class widget tersendiri) punya context baru yang berada di bawah provider.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 7', judul: 'Menguji ViewModel dan Menata Folder', ikon: 'uji', catatan: 'ViewModel adalah class Dart biasa, sehingga logikanya bisa diperiksa tanpa layar. Lalu memecah proyek ke banyak berkas.' });

    d.kode({
      judul: 'Pola Siapkan–Lakukan–Periksa',
      berkas: 'kode/contoh_10_menguji_viewmodel.dart',
      kode: [
        '// SIAPKAN dan LAKUKAN',
        'final KeranjangViewModel kopi = KeranjangViewModel()',
        "  ..tambah('Kopi', 15000)",
        "  ..tambah('Kopi', 15000);",
        '// PERIKSA',
        "hasil.add(periksa('Total 2 kopi', kopi.total, 30000));",
        '',
        '// Memeriksa kapan notifyListeners() dipanggil',
        'final KeranjangViewModel teh = KeranjangViewModel();',
        'int jumlahPengumuman = 0;',
        'teh.addListener(() => jumlahPengumuman++);',
        "teh.tambah('Teh', 5000);",
        "hasil.add(periksa('Tambah: tepat 1 pengumuman',",
        '    jumlahPengumuman, 1));',
      ].join('\n'),
      ukuran: 14,
      lebarKode: 7.0,
      poin: [
        'ViewModel = class Dart biasa: tanpa widget, tanpa BuildContext.',
        'Buat objek → panggil perintah → bandingkan hasil dengan yang diharapkan.',
        'P14: cara resminya dengan flutter_test (test dan expect).',
      ],
      catatan: 'Fungsi periksa hanya membandingkan dua nilai dan mencatat hasilnya (HasilUji: nama, lulus, keterangan). Contoh 10 menampilkan hasil di layar agar mudah diamati di DartPad. Mengumumkan perubahan padahal tidak ada yang berubah tidak merusak tampilan, tetapi membuat widget dibangun ulang tanpa perlu.',
    });

    d.layar({
      judul: 'Menemukan Bug Nilai Batas',
      gambar: 'hasil_contoh_10.jpg',
      berkas: 'kode/contoh_10_menguji_viewmodel.dart',
      kode: [
        '// Aturan: belanja MULAI Rp100.000 diskon 10%',
        'int get diskon =>',
        '    total > 100000 ? total ~/ 10 : 0; // bug',
        '',
        '// Perbaikan: lebih dari ATAU SAMA DENGAN',
        'int get diskon =>',
        '    total >= 100000 ? total ~/ 10 : 0;',
      ].join('\n'),
      poin: [
        '7 dari 8 uji lulus. Gagal: "Diskon belanja TEPAT Rp100.000", diharapkan 10000, hasilnya 0.',
        'Uji tiga nilai di setiap batas: Rp99.999, Rp100.000, Rp100.001.',
      ],
      ukuranPoin: 16,
      catatan: 'Bug nilai batas (boundary bug) sangat sering terjadi. Cek cepat: tulis pemeriksaan bahwa Rp99.999 tidak mendapat diskon: final KeranjangViewModel buku = KeranjangViewModel()..tambah(\'Buku\', 99999); hasil.add(periksa(\'Belanja Rp99.999 tanpa diskon\', buku.diskon, 0)); — jangan lupa membuang buku di akhir.',
    });

    d.kode({
      judul: 'Menata Folder Proyek MVVM',
      kode: [
        'lib/',
        '├── main.dart',
        '├── domain/models/',
        '│   └── tugas.dart',
        '├── data/repositories/',
        '│   ├── repositori_tugas.dart',
        '│   └── repositori_tugas_lokal.dart',
        '└── ui/',
        '    ├── core/tema.dart',
        '    ├── daftar_tugas/',
        '    │   ├── view_models/',
        '    │   │   └── daftar_tugas_view_model.dart',
        '    │   └── widgets/',
        '    │       ├── halaman_tugas.dart',
        '    │       └── baris_tugas.dart',
        '    └── tambah_tugas/widgets/',
        '        └── halaman_tambah_tugas.dart',
      ].join('\n'),
      shell: true,
      ukuran: 13,
      lebarKode: 5.6,
      poin: [
        'domain/models: Model (bentuk data).',
        'data/repositories: kontrak dan implementasi.',
        'ui/core: tema dan widget bersama.',
        'ui/<fitur>/: view_models/ dan widgets/ milik satu fitur.',
        'Berkas snake_case, class UpperCamelCase.',
        "import 'package:tugas_kuliahku/...' (nama di pubspec.yaml).",
        'ViewModel cukup mengimpor foundation.dart, bukan material.dart.',
      ],
      catatan: 'Struktur ini disederhanakan dari studi kasus panduan arsitektur resmi Flutter. Semua contoh hari ini satu berkas agar bisa jalan di DartPad; Praktikum 5 Jobsheet memecah Tugas Kuliahku ke struktur ini. Jangan membuat folder yang belum dibutuhkan; data/services/ misalnya baru muncul di P10.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 8', judul: 'Studi Kasus: Kuis Kampus', ikon: 'kuis', catatan: 'Merangkai Model, repository, state aplikasi, ViewModel halaman, dan View.' });

    d.lapisan({
      judul: 'Peta Arsitektur Kuis Kampus',
      lapisan: [
        { ikon: 'hp', judul: 'View', isi: 'HalamanBeranda, HalamanKuis, TampilanSoal, TampilanHasil, ...' },
        { ikon: 'restoran', judul: 'KuisViewModel (di rute halaman kuis)', isi: 'Status, soal, jawaban, skor; perintah muat, pilih, lanjut, ulangi', warna: C.accent6 },
        { ikon: 'gudang', judul: 'RepositoriSoal + RiwayatSkor (di atas MaterialApp)', isi: 'Menyediakan soal; menyimpan skor terbaik selama aplikasi berjalan', warna: C.accent4 },
        { ikon: 'data', judul: 'Model', isi: 'enum Topik (label + ikon), Soal, Skor', warna: C.text2 },
      ],
      keterangan: [
        'Beranda: watch RiwayatSkor (jumlah kuis, skor terbaik).',
        'Halaman kuis: watch/read KuisViewModel.',
        'KuisViewModel: ambilSoal(topik) dari repository, catat(topik, skor) ke RiwayatSkor.',
      ],
      catatan: 'RiwayatSkor adalah state aplikasi yang dipanggil langsung oleh KuisViewModel agar contoh sederhana. Saat skor perlu disimpan permanen (P11), data seperti ini sebaiknya dipindahkan ke repository.',
    });

    d.kode({
      judul: 'Aturan Permainan Dijaga ViewModel',
      berkas: 'kode/contoh_11_studi_kasus_kuis_kampus.dart',
      kode: [
        'void pilih(int indeksPilihan) {',
        '  if (_status != StatusKuis.menjawab || sudahDijawab) {',
        '    return; // jawaban tidak bisa diganti',
        '  }',
        '  _jawaban[_indeks] = indeksPilihan;',
        '  notifyListeners();',
        '}',
        'void lanjut() {',
        '  if (!sudahDijawab) {',
        '    return;',
        '  }',
        '  if (soalTerakhir) {',
        '    _status = StatusKuis.selesai;',
        '    _riwayat.catat(topik, Skor(benar: skor, jumlahSoal: jumlahSoal));',
        '  } else {',
        '    _indeks++;',
        '  }',
        '  notifyListeners();',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.4,
      poin: [
        'Walaupun View lupa menonaktifkan tombol, aturannya tetap berlaku.',
        'keadaanPilihan(i) → biasa, benar, atau salah: View tinggal memilih warna.',
        'pesanHasil: skor * 10 >= jumlahSoal * 6 berarti minimal 60%.',
      ],
      catatan: 'Data privat KuisViewModel: _status (memuat, gagal, menjawab, selesai), _soal, _jawaban (List<int?>, null = belum dijawab), _indeks. Perintah: muat, pilih, lanjut, ulangi (mengosongkan jawaban tanpa memuat ulang soal).',
    });

    d.layar({
      judul: 'Kuis Kampus Berjalan',
      gambar: ['hasil_contoh_11a.jpg', 'hasil_contoh_11b.jpg', 'hasil_contoh_11c.jpg'],
      lebarMaks: 7.6,
      berkas: 'kode/contoh_11_studi_kasus_kuis_kampus.dart',
      poin: [
        'KuisViewModel dibuat di rute: setiap kuis mulai dari soal pertama.',
        'Benar dan salah dibedakan dengan warna DAN ikon berlabel.',
        'Halaman hasil: skor, pesan sesuai skor, ringkasan jawaban.',
      ],
      ukuranPoin: 15,
      catatan: 'Kiri: beranda awal (0 kuis, semua topik belum dicoba). Tengah: soal 2 setelah menjawab salah (pilihan salah errorContainer + ikon silang, jawaban benar primaryContainer + ikon centang, kartu pembahasan). Kanan: hasil 3/5 "Bagus! Tinggal sedikit lagi."',
    });

    d.layar({
      judul: 'Skor Terbaik Tetap Ada',
      gambar: 'hasil_contoh_11d.jpg',
      berkas: 'kode/contoh_11_studi_kasus_kuis_kampus.dart',
      kode: [
        'class RiwayatSkor extends ChangeNotifier {',
        '  final Map<Topik, Skor> _terbaik = {};',
        '  int _jumlahKuis = 0;',
        '  int get jumlahKuis => _jumlahKuis;',
        '  Skor? terbaik(Topik topik) => _terbaik[topik];',
        '  void catat(Topik topik, Skor skor) {',
        '    _jumlahKuis++;',
        '    final Skor? lama = _terbaik[topik];',
        '    if (lama == null || skor.benar > lama.benar) {',
        '      _terbaik[topik] = skor;',
        '    }',
        '    notifyListeners();',
        '  }',
        '}',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        'Uji mandiri: ulangi kuis dengan skor lebih rendah; skor terbaik tidak turun.',
        'Tekan kembali saat soal masih dimuat: tidak ada error (berkat _sudahDibuang).',
      ],
      ukuranPoin: 15,
      catatan: 'Daftar uji mandiri lengkap ada di modul Bagian 14.8. Status gagal belum pernah muncul karena RepositoriSoalLokal tidak pernah gagal; status itu disiapkan untuk P10 saat soal diambil dari internet.',
    });

    d.tabel({
      judul: 'Kesalahan Umum Pemula',
      kepala: ['Gejala', 'Solusi'],
      lebarKolom: [6.2, 5.4],
      baris: [
        [kode("Target of URI doesn't exist: 'package:provider/provider.dart'"), 'flutter pub add provider'],
        ['Data berubah, tetapi layar tidak', 'Akhiri setiap metode pengubah dengan notifyListeners()'],
        ['Layar tidak pernah berubah walaupun sudah notifyListeners()', 'Di build pakai watch/select, bukan read'],
        [kode('A ... was used after being disposed.'), 'Penjaga _sudahDibuang setelah await'],
        ['Isi state tiba-tiba kosong lagi', 'Buat objek di create, bukan .value(value: Objek())'],
        ['Data hilang setiap halaman ditutup', 'Pindahkan provider ke atas MaterialApp'],
        ['ViewModel menyimpan BuildContext untuk SnackBar', 'ViewModel mengubah data; SnackBar dikerjakan View'],
      ],
      ukuran: 14,
      tinggiBaris: 0.65,
      catatan: 'Tabel lengkap ada di modul Bagian 15, termasuk pesan error watch/select di luar build, ProviderNotFound, jebakan ValueNotifier<List>, dan watch di widget besar.',
    });

    d.tabel({
      judul: 'Memilih Alat yang Tepat',
      kepala: ['Kebutuhan', 'Pakai'],
      lebarKolom: [6.0, 5.6],
      baris: [
        ['Data yang hanya dipakai satu widget atau satu halaman', 'StatefulWidget + setState'],
        ['Satu nilai yang didengarkan beberapa widget di satu halaman', 'ValueNotifier + ValueListenableBuilder'],
        ['Beberapa data dan aturan untuk satu halaman', 'ViewModel (ChangeNotifier) di rute halaman itu'],
        ['Data yang dipakai banyak halaman', 'ChangeNotifier + ChangeNotifierProvider di atas MaterialApp'],
        ['Sumber data (kode, API, penyimpanan perangkat)', 'Repository (kontrak abstract class) + Provider'],
      ],
      ukuran: 16,
      tinggiBaris: 0.68,
      pesan: 'Tidak ada satu alat untuk semua kebutuhan. Mulailah dari yang paling sederhana yang mencukupi.',
      catatan: 'Minta mahasiswa memetakan aplikasi proyek akhir mereka: data apa saja yang lokal, data apa saja yang dipakai banyak halaman, dan dari mana datanya berasal.',
    });

    d.ringkasan({
      poin: [
        'State lokal → setState. State aplikasi → di luar widget.',
        'ChangeNotifier: data privat, getter, notifyListeners(); buang dengan dispose().',
        'ListenableBuilder/ValueListenableBuilder membangun ulang sebagian layar.',
        'provider menitipkan objek; create membuat dan membuang otomatis.',
        'Menampilkan → watch/select. Memanggil metode → read. Consumer membatasi rebuild.',
        'MVVM: Model, View, ViewModel; data mengalir satu arah.',
        'Repository + kontrak; status memuat–berhasil–gagal sebagai enum.',
        'Letak provider = cakupan dan umur. ViewModel bisa diuji tanpa layar.',
      ],
      catatan: 'Minta mahasiswa menjelaskan dengan kata-kata sendiri: di Kuis Kampus, mengapa RiwayatSkor dititipkan di atas MaterialApp sedangkan KuisViewModel di rute, dan apa yang terjadi jika keduanya ditukar.',
    });

    d.penutup({
      judul: 'Saatnya Praktik!',
      subjudul: 'Kerjakan Jobsheet Pertemuan 9 (lima praktikum + tugas Lapor Fasilitas Kampus), lalu uji diri di Latihan. Proyek akhir dimulai: bentuk tim dan kumpulkan proposal. Pertemuan berikutnya: asinkron dan REST API.',
      tautan: [
        { teks: 'Jobsheet P9', ikon: 'tugas', url: d.urlBerkas('pertemuan_09_state_dan_mvvm/JOBSHEET.md') },
        { teks: 'Latihan P9', ikon: 'kuis', url: d.urlBerkas('pertemuan_09_state_dan_mvvm/LATIHAN.md') },
        { teks: 'Proyek Akhir', ikon: 'roket', url: d.urlBerkas('panduan/05_proyek_akhir.md') },
      ],
      catatan: 'Praktikum 5 Jobsheet dikerjakan di VS Code (flutter create, flutter pub add provider), bukan DartPad. Ingatkan: tugas mandiri wajib punya jalankanUji() yang dijalankan sebelum runApp dan diuji di lebar 360 dalam mode terang dan gelap. Di P10, repository palsu diganti repository yang benar-benar mengambil data dari internet tanpa mengubah ViewModel dan View.',
    });
  },
};

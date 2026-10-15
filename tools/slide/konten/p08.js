// Konten slide Pertemuan 8 — Persiapan Ujian Tengah Semester (UTS).
// Teks diambil dari panduan UTS (pertemuan_08_uts/README.md) dan
// simulasi UTS (pertemuan_08_uts/SIMULASI_UTS.md).
// Tangkapan layar diambil dari folder pertemuan_08_uts/gambar/.

module.exports = {
  nomor: '08',
  folder: 'pertemuan_08_uts',
  namaBerkas: 'PERTEMUAN_08_Persiapan_UTS',
  topik: 'Persiapan UTS',

  bangun(d) {
    const C = d.C;
    const kodeTabel = (teks) => ({ text: teks, options: { fontFace: 'Consolas' } });

    d.judul({
      judul: 'Persiapan Ujian Tengah Semester',
      subjudul: 'Pertemuan 8  ·  ujian praktik 120 menit: satu aplikasi Flutter multi-halaman, sembilan ketentuan, dan tanya jawab pemahaman',
      catatan: 'Slide ini ditayangkan di akhir Pertemuan 7 atau sepekan sebelum UTS. Tujuannya: mahasiswa tahu persis bentuk soal, aturan, cara dinilai, dan cara berlatih (simulasi + latihan persiapan). Semua yang diujikan sudah dipraktikkan di jobsheet Pertemuan 1–7.',
    });

    d.statistik({
      judul: 'UTS dalam Angka',
      item: [
        { ikon: 'jam', angka: '120', label: 'menit mengerjakan', warna: C.accent1 },
        { ikon: 'daftar', angka: '9', label: 'ketentuan dalam satu soal', warna: C.accent6 },
        { ikon: 'bintang', angka: '80', label: 'poin dari ketentuan inti', warna: C.accent4 },
        { ikon: 'dokumen', angka: '1', label: 'berkas .dart dikumpulkan', warna: C.accent5 },
      ],
      pesan: 'Ujian praktik individu, buku terbuka terbatas: boleh membuka materi dan berkas praktikum sendiri, tanpa AI dan tanpa bantuan orang lain.',
      catatan: 'Tekankan: tidak ada materi baru. Bahan awal (enum, class model, 8 data) diberikan, jadi waktu dipakai untuk tampilan dan logika. Paket soal berbeda tema tetapi setara tingkat kesulitan dan rubriknya.',
    });

    d.tabel({
      judul: 'Materi yang Diujikan',
      kepala: ['Pertemuan', 'Kemampuan yang diuji'],
      lebarKolom: [1.6, 10],
      baris: [
        ['1', 'Menjalankan aplikasi (DartPad atau Chrome), MaterialApp dan Scaffold'],
        ['2', 'Tipe data, null safety (?, ??, !), percabangan, List dan Set, fungsi'],
        ['3', 'Class dan constructor bernama, enum berproperti, async/await'],
        ['4', 'Row, Column, Expanded, Padding, ListTile, Card, mengatasi overflow'],
        ['5', 'setState, ChoiceChip, Switch, Slider, Form + validator, dropdown, SnackBar'],
        ['6', 'Class model, ListView.builder, SearchBar, nilai turunan, Navigator + hasil, mounted'],
        ['7', 'ColorScheme.fromSeed, darkTheme/themeMode, peran warna, MediaQuery, daftar–detail'],
      ],
      ukuran: 16,
      pesan: 'Tidak diujikan: Stream, go_router, NavigationRail, ThemeExtension, dan paket di luar Flutter.',
      catatan: 'Kisi-kisi lengkap ada di Panduan UTS Bagian 2. Sarankan mahasiswa menandai pertemuan yang masih lemah dan mengulang jobsheet-nya tanpa melihat kode terbimbing.',
    });

    d.tabel({
      judul: 'Satu Aplikasi, Sembilan Ketentuan',
      kepala: ['No', 'Ketentuan', 'Jenis', 'Bobot'],
      lebarKolom: [0.8, 7.6, 1.8, 1.4],
      baris: [
        ['1', 'Tema dari warna benih dan tombol mode gelap', 'Inti', '10'],
        ['2', 'Halaman daftar: ListView.builder, baris = class, label status', 'Inti', '15'],
        ['3', 'Pencarian dan saringan kategori, tampilan kosong', 'Inti', '15'],
        ['4', 'Halaman detail dan perubahan status (hasil true)', 'Inti', '15'],
        ['5', 'Formulir tambah data dengan validasi', 'Inti', '15'],
        ['6', 'Kualitas kode, lebar 320/360, mode gelap', 'Inti', '10'],
        ['7', 'Ringkasan (angka dihitung dari data)', 'Pengayaan', '5'],
        ['8', 'Fitur khusus paket', 'Pengayaan', '5'],
        ['9', 'Dua panel mulai lebar 840', 'Pengayaan', '10'],
      ],
      ukuran: 15,
      pesan: 'Inti (1–6) = 80 poin, cukup ± 90 menit bagi yang menuntaskan jobsheet P5–P7 sendiri. Pengayaan (7–9) = 20 poin.',
      catatan: 'Pola sembilan ketentuan ini sama persis dengan Simulasi UTS (Sewa Alat Mapala). Yang berbeda di hari ujian: tema, data, kalimat SnackBar, dan fitur khusus.',
    });

    d.alur({
      judul: 'Jalannya Ujian',
      langkah: [
        { ikon: 'unduh', judul: 'Terima soal dan bahan', isi: 'Paket soal dan berkas bahan awal dari pengawas' },
        { ikon: 'orang', judul: 'Isi identitas', isi: 'Nama, NIM, paket, dan pernyataan di atas berkas' },
        { ikon: 'kode', judul: 'Kerjakan 120 menit', isi: 'Pengingat di sisa 30 dan 10 menit' },
        { ikon: 'simpan', judul: 'Kumpulkan', isi: 'Satu berkas .dart sebelum waktu habis' },
        { ikon: 'tanya', judul: 'Tanya jawab', isi: '3–5 menit menjelaskan kode Anda sendiri', warna: C.accent4 },
      ],
      catatan: 'Jalankan bahan sekali sampai muncul "Bahan siap: 8 ...". Itu tanda berkas bahan terbaca. Aplikasi yang gagal dijalankan dinilai maksimal 40.',
    });

    d.banding({
      judul: 'Tata Tertib',
      ukuranPoin: 16,
      kolom: [
        {
          ikon: 'centang', judul: 'Boleh', warna: C.accent4, tag: 'Buku terbuka terbatas', sorot: true,
          poin: [
            'Membuka repositori materi: modul, kode contoh, jobsheet',
            'Membuka berkas praktikum milik sendiri',
            'Dokumentasi resmi: docs.flutter.dev, api.flutter.dev, dart.dev',
            'Menyalin pola lalu menyesuaikannya, asalkan paham setiap barisnya',
          ],
        },
        {
          ikon: 'galat', judul: 'Tidak boleh', warna: C.accent5, tag: 'Ditangani sesuai peraturan akademik',
          poin: [
            'Asisten AI dalam bentuk apa pun, termasuk fitur AI di editor',
            'Bertanya, berdiskusi, atau bertukar berkas dengan orang lain',
            'Situs tanya jawab, forum, atau kode internet di luar daftar kiri',
            'Mengumpulkan kode yang tidak bisa dijelaskan',
          ],
        },
      ],
      pesan: 'Matikan fitur pelengkap kode berbasis AI (misalnya GitHub Copilot) SEBELUM ujian dimulai.',
      catatan: 'Jelaskan alasannya: UTS mengukur kemampuan individu. Menyalin pola dari modul diizinkan karena yang dinilai pemahaman; itu dibuktikan lewat tanya jawab setelah mengumpulkan.',
    });

    d.tabel({
      judul: 'Strategi 120 Menit',
      kepala: ['Menit', 'Kegiatan', 'Ketentuan'],
      lebarKolom: [1.6, 8.4, 1.6],
      baris: [
        ['0–10', 'Baca SELURUH soal, salin bahan, jalankan', '—'],
        ['10–20', 'Akar aplikasi, tema dari benih, darkTheme, tombol mode', '1'],
        ['20–50', 'Halaman daftar, widget baris, pencarian, ChoiceChip, tampilan kosong', '2, 3'],
        ['50–70', 'Widget detail, halaman detail, perubahan status', '4'],
        ['70–90', 'Formulir tambah data', '5'],
        ['90–110', 'Pengayaan, mulai dari yang paling mudah bagi Anda', '7, 8, 9'],
        ['110–120', 'Format, hilangkan peringatan, uji 320 dan mode gelap, kumpulkan', '6'],
      ],
      ukuran: 16,
      pesan: 'Macet lebih dari 10 menit di satu bagian? Pindah ke ketentuan lain dulu.',
      catatan: 'Minta mahasiswa memakai tabel ini saat mengerjakan simulasi dan mencatat menit selesainya setiap ketentuan. Dari situ mereka tahu bagian mana yang perlu dilatih.',
    });

    d.kartu({
      judul: 'Delapan Kebiasaan Penyelamat Nilai',
      kolom: 4,
      item: [
        { ikon: 'jalankan', judul: 'Selalu bisa jalan', isi: 'Tambah satu bagian, jalankan, baru lanjut. Gagal jalan = maks 40.' },
        { ikon: 'simpan', judul: 'Simpan versi', isi: 'uts_v1.dart, uts_v2.dart setiap selesai satu ketentuan.' },
        { ikon: 'data', judul: 'State dulu', isi: 'Tentukan variabel yang berubah dan di class mana ia tinggal.' },
        { ikon: 'hitung', judul: 'Hitung, jangan simpan', isi: 'Hasil cari, jumlah, total = nilai turunan.' },
        { ikon: 'buku', judul: 'Pakai pola modul', isi: 'Studi kasus P6 dan P7 memuat hampir semua pola.' },
        { ikon: 'peringatan', judul: 'Jangan terjebak', isi: 'Lebih dari 10 menit macet → kerjakan bagian lain.' },
        { ikon: 'gelap', judul: 'Uji dua mode', isi: 'Terang dan gelap, lebar 320 dan 360.' },
        { ikon: 'jam', judul: '10 menit terakhir', isi: 'Untuk merapikan dan menguji, bukan fitur baru.' },
      ],
      catatan: 'Kebiasaan nomor 1 dan 2 paling sering menyelamatkan nilai: banyak mahasiswa kehilangan nilai karena perubahan terakhir membuat aplikasi tidak bisa dijalankan dan versi sebelumnya tidak tersimpan.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'POLA KUNCI', judul: 'Empat Pola yang Pasti Dipakai', ikon: 'kunci', catatan: 'Empat potongan kode ini muncul di setiap paket soal. Semuanya sudah dipelajari di Pertemuan 5–7.' });

    d.kode({
      judul: 'Pola 1 — Hasil Pencarian sebagai Nilai Turunan',
      kode: [
        'List<Alat> get _hasil {',
        '  final String kunci =',
        '      _kataKunci.trim().toLowerCase();',
        '  return _semuaAlat.where((Alat alat) {',
        '    final bool cocokNama =',
        '        alat.nama.toLowerCase().contains(kunci);',
        '    final bool cocokJenis =',
        '        _jenis == null || alat.jenis == _jenis;',
        '    return cocokNama && cocokJenis;',
        '  }).toList();',
        '}',
      ].join('\n'),
      ukuran: 15,
      lebarKode: 6.8,
      poin: [
        'State sebenarnya: _semuaAlat, _kataKunci, _jenis.',
        'Hasil dihitung ulang setiap build, jadi selalu sinkron, termasuk setelah data baru ditambahkan.',
        '_jenis == null berarti "Semua".',
        'toLowerCase() di kedua sisi: pencarian tidak membedakan huruf besar/kecil.',
      ],
      catatan: 'Modul P6 Bagian 8. Kesalahan yang paling sering: menyimpan hasil sebagai List di state lalu lupa memperbaruinya saat chip berganti atau saat data baru ditambahkan.',
    });

    d.kode({
      judul: 'Pola 2 — Detail yang Mengirim Hasil',
      kode: [
        'Future<void> _bukaDetail(Alat alat) async {',
        '  final bool? ubah = await Navigator.push<bool>(',
        '    context,',
        '    MaterialPageRoute<bool>(',
        '      builder: (BuildContext context) =>',
        '          HalamanDetail(alat: alat, ...),',
        '    ),',
        '  );',
        '  if (!mounted) return;',
        '  if (ubah == true) _ubahSewa(alat);',
        '}',
        '',
        '// di halaman detail:',
        'onTombol: () => Navigator.pop(context, true),',
      ].join('\n'),
      ukuran: 14,
      lebarKode: 7.0,
      poin: [
        'await menunggu sampai halaman detail ditutup.',
        'Tombol kembali → hasil null → status tidak berubah.',
        'ubah == true, bukan if (ubah): bool? tidak boleh langsung jadi kondisi.',
        'mounted dicek dulu sebelum setState atau context.',
      ],
      catatan: 'Modul P6 Bagian 11. Tanya jawab sering menanyakan urutan kejadian dari ketukan sampai label berubah, dan apa yang terjadi jika baris mounted dihapus.',
    });

    d.kode({
      judul: 'Pola 3 — Formulir: Validasi, lalu Kirim Objek',
      kode: [
        'void _simpan() {',
        '  if (!_kunciForm.currentState!.validate()) {',
        '    return;',
        '  }',
        '  final Alat baru = Alat(',
        '    id: widget.idBaru,',
        '    nama: _kontrolNama.text.trim(),',
        '    jenis: _jenis!,',
        '    hargaPerHari:',
        '        int.parse(_kontrolHarga.text.trim()),',
        '    keterangan: ...,',
        '  );',
        '  Navigator.pop(context, baru);',
        '}',
      ].join('\n'),
      ukuran: 14,
      lebarKode: 6.8,
      poin: [
        'Validator: kembalikan null jika benar, teks pesan jika salah.',
        'Angka: int.tryParse di validator, baru int.parse setelah lolos.',
        'Halaman daftar menerima objek lewat await Navigator.push<Alat>, lalu setState menambahkannya.',
        'Controller dibuat sebagai field State dan dibuang di dispose.',
      ],
      catatan: 'Modul P5 Bagian 9 dan P6 Bagian 11. Ingatkan: data awal adalah List const; salin dulu dengan List.of(dataAwal) agar bisa ditambah.',
    });

    d.kode({
      judul: 'Pola 4 — Satu Widget Detail, Dua Tempat',
      kode: [
        'final bool duaPanel =',
        '    MediaQuery.widthOf(context) >= 840;',
        '',
        'if (duaPanel)',
        '  Row(children: [',
        '    SizedBox(width: 400, child: daftar),',
        '    const VerticalDivider(width: 1),',
        '    Expanded(child: DetailAlat(',
        '      alat: terpilih, ...,',
        '      onTombol: () => _ubahSewa(terpilih),',
        '    )),',
        '  ])',
        '// halaman detail: DetailAlat(',
        '//   onTombol: () => Navigator.pop(context, true))',
      ].join('\n'),
      ukuran: 14,
      lebarKode: 6.8,
      poin: [
        'Ketukan di layar sempit: buka halaman detail.',
        'Ketukan di layar lebar: setState mengganti _idTerpilih, panel kanan berganti.',
        'Widget detail menerima data dan callback, jadi bisa dipakai di dua tempat.',
        '_idTerpilih tetap tersimpan walaupun lebar jendela berubah.',
      ],
      catatan: 'Modul P7 Bagian 13 dan studi kasus Pustaka Kampus (Bagian 16). Ini ketentuan pengayaan bernilai 10, jadi kerjakan setelah inti selesai.',
    });

    // ------------------------------------------------------------------
    d.layar({
      judul: 'Simulasi UTS: Sewa Alat Mapala',
      gambar: ['hasil_simulasi_a.jpg', 'hasil_simulasi_b.jpg', 'hasil_simulasi_c.jpg'],
      lebarMaks: 7.6,
      berkas: 'kode/bahan_simulasi_sewa_alat.dart',
      poin: [
        'Pola soalnya sama dengan UTS; temanya berbeda.',
        'Kerjakan 120 menit, tanpa AI, lalu nilai sendiri dengan rubrik.',
        'Catat menit selesainya setiap ketentuan.',
      ],
      ukuranPoin: 15,
      catatan: 'Kiri: daftar alat dengan ringkasan sewa dan label Disewa. Tengah: halaman detail. Kanan: formulir dengan pesan validasi. Contoh jawaban dibahas setelah mahasiswa mencoba sendiri.',
    });

    d.layar({
      judul: 'Simulasi di Layar Lebar',
      gambar: 'hasil_simulasi_d.jpg',
      lebarMaks: 7.6,
      poin: [
        'Mulai lebar 840: daftar di kiri, detail di kanan.',
        'Ketukan hanya mengganti panel kanan; baris ditandai terpilih.',
        'Detail di panel kanan = widget yang sama dengan halaman detail.',
      ],
      ukuranPoin: 15,
      catatan: 'Ketentuan 9 (pengayaan). Uji dengan mengubah lebar jendela Chrome atau device toolbar (F12, lalu Ctrl+Shift+M).',
    });

    d.tabel({
      judul: 'Rubrik Penilaian',
      kepala: ['No', 'Ketentuan', 'Bobot', 'Nilai penuh jika ...'],
      lebarKolom: [0.6, 2.9, 0.9, 7.2],
      baris: [
        ['1', 'Tema dan mode gelap', '10', 'theme + darkTheme dari benih sama; tombol mode; tanpa Colors.xxx/fontSize'],
        ['2', 'Halaman daftar', '15', 'ListView.builder; baris = class; label peran warna + tulisan'],
        ['3', 'Pencarian dan saringan', '15', 'tidak peka huruf besar/kecil; chip dari .values; nilai turunan; tampilan kosong'],
        ['4', 'Detail dan status', '15', 'push membawa objek; pop(true); mounted; kembali tidak mengubah apa pun'],
        ['5', 'Formulir', '15', 'Form + GlobalKey; validator sesuai soal; dropdown; dispose; data baru muncul'],
        ['6', 'Kualitas dan uji', '10', 'terformat, tanpa peringatan, tanpa overflow 320/360, terbaca di mode gelap'],
        ['7–9', 'Pengayaan', '20', 'ringkasan (5), fitur khusus (5), dua panel (10)'],
      ],
      ukuran: 14,
      pesan: 'Dinilai per ketentuan: yang baru sebagian berjalan tetap mendapat sebagian nilai. Aplikasi gagal dijalankan: maksimal 40.',
      catatan: 'Rubrik lengkap ada di Panduan UTS Bagian 8. Minta mahasiswa memakai rubrik ini untuk menilai hasil simulasinya sendiri.',
    });

    d.tabel({
      judul: 'Tanya Jawab Pemahaman',
      pengantar: 'Setelah mengumpulkan, dosen menunjuk 2–3 bagian kode Anda. Contoh pertanyaannya:',
      kepala: ['Pertanyaan', 'Yang ingin diketahui'],
      lebarKolom: [7.0, 4.6],
      baris: [
        ['"Variabel apa saja yang menjadi state? Mengapa hasil pencarian tidak termasuk?"', 'Paham state vs nilai turunan'],
        ['"Apa yang terjadi jika if (!mounted) return; dihapus?"', 'Paham await dan siklus hidup'],
        ['"Mengapa ditulis ubah == true, bukan if (ubah)?"', 'Paham null safety pada hasil'],
        ['"Ganti warna benih. Apa saja yang ikut berubah?"', 'Paham tema dan peran warna'],
        ['"Mengapa daftar ini dibungkus Expanded?"', 'Paham constraints'],
      ],
      ukuran: 15,
      pesan: 'Bagian yang sama sekali tidak bisa dijelaskan tidak diberi nilai. Latih dengan bagian B Latihan Persiapan.',
      catatan: 'Tanya jawab bukan hafalan istilah. Jawaban dengan bahasa sendiri tentang apa yang terjadi saat kode berjalan sudah cukup. Mahasiswa boleh menjalankan atau mengubah kodenya untuk menjelaskan.',
    });

    d.tabel({
      judul: 'Daftar Periksa Sebelum Mengumpulkan',
      kepala: ['Periksa', 'Caranya'],
      lebarKolom: [5.0, 6.6],
      baris: [
        ['Identitas terisi', 'Nama, NIM, paket, pernyataan di atas berkas'],
        ['Berjalan tanpa layar merah', 'Jalankan dari awal sampai formulir'],
        ['Terformat, tanpa peringatan', 'DartPad: Format · VS Code: Shift+Alt+F, panel Problems kosong'],
        ['Lebar 320 dan 360', 'Daftar, detail, formulir tanpa garis kuning-hitam'],
        ['Mode gelap', 'Semua teks terbaca, tidak ada kotak putih'],
        ['Cari + saring bersamaan', 'Tampilan kosong muncul jika tidak ada yang cocok'],
        ['Tombol kembali di detail', 'Status tidak berubah'],
        ['Nama berkas', kodeTabel('uts_nim_namapanggilan.dart')],
      ],
      ukuran: 15,
      catatan: 'Sisakan 10 menit terakhir untuk daftar ini. Setelah mengunggah, buka lagi berkas yang terunggah untuk memastikan isinya lengkap.',
    });

    d.tabel({
      judul: 'Rencana Belajar Satu Minggu',
      kepala: ['Hari', 'Kegiatan'],
      lebarKolom: [1.2, 10.4],
      baris: [
        ['1', 'Tulis ulang praktikum P5 (state, formulir, validasi) tanpa melihat jobsheet'],
        ['2', 'Ulangi daftar, pencarian, dan navigasi dengan hasil (P6 Bagian 8–11 dan 14)'],
        ['3', 'Ulangi tema, mode gelap, dan daftar–detail (P7 Bagian 7, 13, dan 16)'],
        ['4', 'Kerjakan Simulasi UTS 120 menit dengan pengatur waktu'],
        ['5', 'Nilai hasil simulasi dengan rubrik, perbaiki bagian yang kurang'],
        ['6', 'Kerjakan Latihan Persiapan, terutama bagian B'],
        ['7', 'Persiapan teknis (Flutter/Chrome atau DartPad, akun LMS) dan istirahat'],
      ],
      ukuran: 16,
      catatan: 'Hari ke-4 adalah yang terpenting: simulasi berbatas waktu memberi gambaran paling jujur tentang kesiapan.',
    });

    d.ringkasan({
      poin: [
        'Ujian praktik 120 menit: satu aplikasi, sembilan ketentuan.',
        'Inti 80 poin (tema, daftar, cari, detail, formulir, kualitas).',
        'Pengayaan 20 poin (ringkasan, fitur khusus, dua panel).',
        'Buku terbuka terbatas; tanpa AI, tanpa bantuan orang lain.',
        'Empat pola kunci: nilai turunan, hasil dari detail, formulir, detail dua tempat.',
        'Jaga aplikasi selalu bisa dijalankan; simpan versi.',
        'Tanya jawab: jelaskan kode Anda sendiri.',
        'Berlatih: simulasi 120 menit + latihan persiapan.',
      ],
      catatan: 'Tutup dengan mengingatkan jadwal, ruang, tempat pengumpulan, dan apa yang harus dibawa (laptop + pengisi daya bila memakai laptop sendiri).',
    });

    d.penutup({
      judul: 'Siap Menghadapi UTS!',
      subjudul: 'Baca panduannya, kerjakan simulasi dalam 120 menit, lalu latihan persiapan. Setelah UTS, Pertemuan 9 membahas manajemen state dengan pola MVVM.',
      tautan: [
        { teks: 'Panduan UTS', ikon: 'buku', url: d.urlBerkas('pertemuan_08_uts/README.md') },
        { teks: 'Simulasi UTS', ikon: 'tugas', url: d.urlBerkas('pertemuan_08_uts/SIMULASI_UTS.md') },
        { teks: 'Latihan Persiapan', ikon: 'kuis', url: d.urlBerkas('pertemuan_08_uts/LATIHAN.md') },
      ],
      catatan: 'Ingatkan bahwa simulasi tidak dinilai (kecuali diumumkan lain) dan contoh jawabannya dibahas setelah mahasiswa mencoba sendiri.',
    });
  },
};

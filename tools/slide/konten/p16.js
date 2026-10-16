// Konten slide Pertemuan 16 — UAS: Presentasi dan Demo Proyek Akhir.
// Teks diambil dari Panduan UAS (pertemuan_16_uas/README.md), Gladi Resik
// (GLADI_RESIK.md), dan kode contoh di pertemuan_16_uas/kode/.
//
// Dek ini dipakai untuk MEMBEKALI mahasiswa sebelum UAS (misalnya di akhir
// Pertemuan 15 atau seminggu sebelum ujian), bukan diputar saat UAS.

const { TEMA } = require('../desain');

module.exports = {
  nomor: '16',
  folder: 'pertemuan_16_uas',
  namaBerkas: 'PERTEMUAN_16_Persiapan_UAS',
  topik: 'UAS: Presentasi dan Demo Proyek Akhir',

  bangun(d) {
    const C = d.C;
    // Teks berhuruf kode (Consolas) untuk sel tabel; ukuran boleh dikecilkan.
    const kode = (teks, ukuran) => ({
      text: teks,
      options: ukuran ? { fontFace: 'Consolas', fontSize: ukuran } : { fontFace: 'Consolas' },
    });

    d.judul({
      judul: 'UAS: Presentasi dan Demo Proyek Akhir',
      subjudul: 'Pertemuan 16  ·  bentuk ujian dan pembagian waktu; slide singkat dan demo yang bercerita; uji langsung; tanya jawab tentang kode sendiri; rubrik dan nilai setiap anggota; rencana cadangan; persiapan satu minggu',
      catatan: 'Dek ini membekali mahasiswa SEBELUM UAS, idealnya di akhir Pertemuan 15 atau seminggu sebelum ujian. Pesan utamanya: UAS tidak menguji materi baru. Yang diuji adalah aplikasi buatan tim sendiri dan pemahaman setiap anggota tentang kodenya. Semua yang ditanyakan sudah dipelajari di Pertemuan 1–15 dan sudah diterapkan di proyek akhir. Ketentuan teknis (jadwal giliran, ruang, durasi, tempat pengumpulan, tenggat) diumumkan dosen dan berlaku di atas isi dek ini.',
    });

    d.tujuan({
      pengantar: 'Setelah sesi ini, Anda mampu:',
      poin: [
        'Menjelaskan bentuk, alur, dan pembagian waktu UAS',
        'Menyusun slide (paling banyak enam) dan demo yang bercerita dalam 7 menit',
        'Menyiapkan perangkat, layar, dan rencana cadangan',
        'Memperagakan permintaan uji langsung dari penguji',
        'Menjawab pertanyaan sambil menunjuk kode sendiri',
        'Menghitung nilai proyek akhir dan memahami faktor individu',
      ],
      catatan: 'Tekankan bahwa keenam kemampuan ini bisa DILATIH. Gladi Resik (GLADI_RESIK.md) memberi satu kali "ujian" lengkap dengan teman sebagai penguji, dan Latihan Persiapan (LATIHAN.md) melatih menjelaskan kode, menalar "bagaimana jika", dan ubah kecil langsung.',
    });

    d.statistik({
      judul: 'UAS dalam Angka',
      item: [
        { ikon: 'timer', angka: '± 20', label: 'menit per tim (individu ± 15)', warna: C.accent1 },
        { ikon: 'jalankan', angka: '7', label: 'menit presentasi dan demo', warna: C.accent6 },
        { ikon: 'presentasi', angka: '≤ 6', label: 'slide, selesai ± 2 menit', warna: C.accent4 },
        { ikon: 'piala', angka: '40%', label: 'nilai akhir: proyek akhir + UAS', warna: C.accent5 },
      ],
      pesan: 'UAS tidak menguji materi baru. Yang diuji adalah APLIKASI ANDA dan PEMAHAMAN ANDA tentang aplikasi itu.',
      catatan: 'Durasi per tim: 7 menit presentasi dan demo, 3 menit uji langsung, 8 menit tanya jawab, 2 menit catatan penguji. Proyek individu ± 15 menit. Bobot 40% berasal dari Silabus Bagian 6 (praktikum 25%, kuis 10%, UTS 25%, proyek akhir + UAS 40%).',
    });

    d.alur({
      judul: 'Peta Materi Hari Ini',
      langkah: [
        { ikon: 'piala', judul: 'A. Gambaran dan penilaian', isi: 'Bentuk UAS, syarat, kisi-kisi (Bagian 1–2)' },
        { ikon: 'timer', judul: 'B. Hari-H', isi: 'Alur dan pembagian waktu (3)' },
        { ikon: 'presentasi', judul: 'C. Slide dan demo', isi: 'Enam slide, demo bercerita, scrcpy (4–5)' },
        { ikon: 'tanya', judul: 'D. Uji langsung dan tanya jawab', isi: 'Peragaan, jawaban kuat, ubah kecil (6–7)', warna: C.accent6 },
        { ikon: 'bintang', judul: 'E. Rubrik dan nilai', isi: 'Patokan skor, faktor individu (8–9)', warna: C.accent6 },
        { ikon: 'perisai', judul: 'F. Cadangan dan persiapan', isi: 'Kendala, tata tertib, daftar periksa (10–15)', warna: C.accent4 },
      ],
      catatan: 'Nomor bagian di setiap kotak merujuk ke Panduan UAS (pertemuan_16_uas/README.md). Bagian A dan E menjawab "apa yang dinilai"; Bagian B–D menjawab "apa yang terjadi saat giliran kita"; Bagian F menjawab "apa yang harus disiapkan mulai hari ini".',
    });

    d.tabel({
      judul: 'Bahan Persiapan',
      kepala: ['Berkas', 'Isi', 'Dipakai saat'],
      lebarKolom: [5.4, 4.6, 2.3],
      baris: [
        [kode('README.md (Panduan UAS)', 13), 'Aturan main, rubrik, daftar periksa', 'Dibaca tim'],
        [kode('GLADI_RESIK.md', 13), 'Tujuh kegiatan, termasuk satu "ujian" dengan tim lain', 'Seminggu sebelum'],
        [kode('LATIHAN.md', 13), 'Pilihan ganda, jelaskan kode, bagaimana jika, ubah kecil', 'Latihan mandiri'],
        [kode('kode/contoh_01_hitung_nilai_proyek_akhir_dart_murni.dart', 10.5), 'Menghitung nilai tim dan nilai setiap anggota', 'DartPad'],
        [kode('kode/contoh_02_pengatur_waktu_presentasi.dart', 11), 'Pengatur waktu empat bagian', 'Gladi dan hari-H'],
        [kode('kode/contoh_03_kartu_latihan_tanya_jawab.dart', 11), '21 kartu pertanyaan, tujuh kategori', 'Latihan berpasangan'],
        [kode('templat/', 13), 'Naskah demo, kontribusi tim, umpan balik gladi, slide UAS', 'Disalin ke proyek'],
      ],
      ukuran: 14,
      tinggiBaris: 0.6,
      catatan: 'Contoh 01 adalah program Dart murni; Contoh 02 dan 03 berjalan di DartPad atau proyek Flutter. Folder templat/ berisi NASKAH_DEMO.md, KONTRIBUSI_TIM.md, LEMBAR_UMPAN_BALIK_GLADI.md, dan TEMPLAT_SLIDE_UAS.pptx (enam slide dengan petunjuk di catatan pembicara).',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 1–2', judul: 'Gambaran UAS dan Apa yang Dinilai', ikon: 'piala', catatan: 'Mulai dari gambaran besar: apa yang terjadi saat UAS, apa yang dibuktikan, dan bahan apa yang mungkin ditanyakan.' });

    d.alur({
      judul: 'Dari Denah sampai Serah Terima Kunci',
      langkah: [
        { ikon: 'dokumen', judul: 'Proposal (P9)', isi: 'Denah: masalah, fitur, sumber data, rencana' },
        { ikon: 'lapisan', judul: 'Laporan kemajuan (P12)', isi: 'Rangka: alur utama berjalan dari ujung ke ujung' },
        { ikon: 'roket', judul: 'Rilis 1.0.0 (P15)', isi: 'Rumah siap huni: web/APK, dokumen, tag versi', warna: C.accent4 },
        { ikon: 'kunci', judul: 'UAS (P16)', isi: 'Serah terima kunci: tunjukkan setiap ruangan, buka panel listriknya', warna: C.accent6 },
      ],
      catatan: 'Panduan Proyek Akhir mengibaratkan proyek akhir sebagai membangun rumah. UAS adalah serah terima kunci: tim mengajak penguji berkeliling, menunjukkan setiap ruangan (fitur), membuka panel listrik (kode), lalu menjawab pertanyaan calon penghuni dengan tenang, karena tim sendiri yang membangunnya.',
    });

    d.tabel({
      judul: 'Gambaran UAS',
      kepala: ['Hal', 'Keterangan'],
      lebarKolom: [2.3, 9.8],
      baris: [
        ['Bentuk', 'Presentasi dan demo langsung, uji langsung oleh penguji, lalu tanya jawab'],
        ['Peserta', 'Per tim (atau per orang untuk proyek individu), sesuai pembagian sejak Pertemuan 9'],
        ['Durasi', '± 20 menit per tim: 7 presentasi dan demo, 3 uji langsung, 8 tanya jawab, 2 catatan penguji'],
        ['Yang dinilai', 'Aplikasi, kode, repositori, berkas rilis, presentasi, dan pemahaman setiap anggota'],
        ['Yang dibawa', 'Laptop + pengisi daya, HP yang sudah terpasang APK, kabel data, adaptor HDMI bila perlu'],
        ['Sifat', 'Setiap anggota menjelaskan kode bagiannya sendiri; penguji boleh bertanya kepada siapa saja'],
        ['Bobot', 'Proyek akhir + UAS = 40% nilai akhir'],
      ],
      ukuran: 16,
      tinggiBaris: 0.62,
      catatan: 'Jika ada perbedaan antara Panduan UAS dan pengumuman dosen (jadwal, ruang, durasi, tempat pengumpulan, tenggat), pengumuman dosen yang berlaku.',
    });

    d.tabel({
      judul: 'Enam Syarat: Dibuktikan, Bukan Diceritakan',
      kepala: ['No', 'Syarat', 'Cara membuktikannya saat UAS'],
      lebarKolom: [0.6, 5.0, 6.5],
      baris: [
        ['1', 'Minimal tiga halaman, navigasi jelas', 'Berpindah antarhalaman sambil membawa data, lalu kembali'],
        ['2', 'Material 3, nyaman di layar berbeda', 'Lebar 360 dan ≥ 840, mode terang dan gelap'],
        ['3', 'REST API dan data di perangkat', 'Data internet tampil; data simpanan tetap ada setelah dibuka ulang'],
        ['4', 'MVVM atau Clean Architecture', 'Folder lib/: View, ViewModel, repository terpisah'],
        ['5', 'Minimal tiga tes unit yang lulus', 'flutter test di depan penguji, semuanya hijau'],
        ['6', 'Git rapi dan README.md yang jelas', 'Commit setiap anggota, tag versi, README bisa diikuti'],
        ['+', 'Berkas rilis', 'APK dari halaman rilis dan/atau versi web dari HP penguji'],
      ],
      ukuran: 15,
      tinggiBaris: 0.6,
      catatan: 'Enam syarat minimal berasal dari Panduan Proyek Akhir Bagian 2; berkas rilis dari Pertemuan 15 Bagian 17. Kata kuncinya: DIBUKTIKAN. Penguji tidak cukup mendengar "data kami tersimpan"; penguji ingin melihat aplikasi ditutup, dibuka lagi, dan datanya masih ada.',
    });

    d.tabel({
      judul: 'Kisi-kisi Tanya Jawab',
      pengantar: 'Pertanyaan selalu dikaitkan dengan KODE ANDA SENDIRI. Bahan yang paling sering muncul:',
      kepala: ['Pertemuan', 'Yang mungkin ditanyakan atau diminta'],
      lebarKolom: [1.6, 10.5],
      baris: [
        ['5–7', 'StatefulWidget dan siklus hidupnya, formulir dan validasi, navigasi membawa data, tema, mode gelap, responsif'],
        ['9', 'State lokal dan state aplikasi, ChangeNotifier, watch/read, pembagian View–ViewModel–repository'],
        ['10', 'Perjalanan data dari API ke layar, JSON menjadi model, galat jaringan, async/await'],
        ['11', 'shared_preferences atau SQLite, whereArgs, migrasi versi database, cache luring'],
        ['12', 'Lapisan dan aturan ketergantungan, kontrak dan dependency injection, Hasil dan Kegagalan'],
        ['13', '(Jika dipakai) izin akses, alur izin ditolak, privasi'],
        ['14', 'Isi tes Anda, nilai batas, repository palsu, membaca pesan galat, GitHub Actions'],
        ['15', 'Nomor versi, mode rilis, --dart-define, halaman Tentang, kunci unggah, tag dan rilis'],
      ],
      ukuran: 14,
      tinggiBaris: 0.5,
      catatan: 'Tidak ada pertanyaan tentang hal yang tidak dipakai tim. Tim yang tidak memakai kamera atau lokasi tidak akan ditanya tentang izin; tim yang memakai shared_preferences akan ditanya alasannya, bukan detail SQLite.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 3', judul: 'Alur Hari-H dan Pembagian Waktu', ikon: 'timer', catatan: 'Dua puluh menit terasa panjang saat berlatih sendiri, tetapi sangat singkat saat ujian. Pembagian waktu yang jelas membuat tim tidak kehabisan waktu di tengah demo.' });

    d.alur({
      judul: 'Dua Puluh Menit Milik Tim Anda',
      langkah: [
        { ikon: 'usb', judul: 'Bersiap', isi: 'Sebelum giliran: layar, HP, aplikasi, terminal siap' },
        { ikon: 'presentasi', judul: 'Presentasi dan demo', isi: 'Menit 0–7: slide ± 2 menit, lalu demo alur utama' },
        { ikon: 'uji', judul: 'Uji langsung', isi: 'Menit 7–10: mode pesawat, layar lebar, flutter test', warna: C.accent6 },
        { ikon: 'tanya', judul: 'Tanya jawab', isi: 'Menit 10–18: setiap anggota, lalu pertanyaan silang', warna: C.accent6 },
        { ikon: 'catatan', judul: 'Catatan penguji', isi: 'Menit 18–20: penguji mengisi nilai; tim melepas sambungan', warna: C.accent4 },
      ],
      catatan: 'Bersiap terjadi SEBELUM pengatur waktu berjalan: laptop tersambung ke layar, HP tersambung ke laptop, aplikasi dan terminal sudah terbuka. Tim yang baru menyambungkan kabel saat gilirannya dimulai kehilangan waktu demo.',
    });

    d.layar({
      judul: 'Berlatih dengan Pengatur Waktu (Contoh 02)',
      gambar: ['hasil_contoh_02a.jpg', 'hasil_contoh_02b.jpg'],
      lebarMaks: 5.9,
      kode: [
        'PengaturWaktuViewModel({',
        '  required this._rencana,',
        '  DateTime Function()? jam,',
        '  this.ambangHampirHabis =',
        '      const Duration(minutes: 1),',
        '}) : _jam = jam ?? DateTime.now;',
        '',
        'Duration get terpakai {',
        '  final DateTime? mulai = _mulaiBerjalan;',
        '  if (mulai == null) return _terpakaiSebelumJeda;',
        '  return _terpakaiSebelumJeda +',
        '      _jam().difference(mulai);',
        '}',
      ].join('\n'),
      ukuranKode: 12,
      berkas: 'kode/contoh_02_pengatur_waktu_presentasi.dart',
      poin: [
        'Jam disuntikkan: di tes memakai jam palsu.',
        'Sisa waktu dihitung dari selisih jam, bukan jumlah detak Timer.',
      ],
      ukuranPoin: 15,
      catatan: 'Kiri: sebelum dimulai, bagian 1 dari 4, angka 07:00 di kartu "Waktu masih cukup". Kanan: saat berjalan, 00:42 di kartu "Hampir habis". Tiga hal penting (Panduan UAS 15.2): jam disuntikkan lewat constructor; sisa waktu dihitung dari selisih jam, sehingga tetap tepat walaupun layar sempat tertunda atau laptop tertidur (Latihan C5); Timer.periodic di State hanya "mengetuk" ViewModel agar layar digambar ulang, dan dibatalkan di dispose().',
    });

    d.layar({
      judul: 'Di Proyektor: Mulai Lebar 840',
      gambar: 'hasil_contoh_02c.jpg',
      lebarMaks: 8.3,
      tinggiGambar: 4.65,
      poin: [
        'Daftar bagian pindah ke samping.',
        'Angka besar, mudah dibaca dari jauh.',
        'Lewat waktu: merah, dengan tanda +.',
        'Keterangan berupa TULISAN, tidak hanya warna.',
      ],
      ukuranPoin: 16,
      catatan: 'Gambar menunjukkan bagian 3 dari 4 (Tanya jawab) yang sudah lewat 24 detik: angka +00:24 berwarna merah tua di kartu "Lewat waktu". Di kanan, rencana 20 menit: dua bagian pertama bercentang, tanya jawab sedang berjalan. Saat gladi, putar pengatur waktu ini di laptop kedua atau HP yang menghadap tim.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 4–5', judul: 'Slide Singkat dan Demo yang Bercerita', ikon: 'presentasi', catatan: 'Bintang UAS adalah aplikasi Anda, bukan slide. Slide hanya pengantar agar penguji cepat paham apa yang akan didemokan.' });

    d.tabel({
      judul: 'Enam Slide, ± 2 Menit',
      kepala: ['Slide', 'Isi', 'Contoh kalimat pembuka'],
      lebarKolom: [0.9, 4.6, 6.6],
      baris: [
        ['1', 'Nama aplikasi, ikon, anggota dan perannya', '"Kami tim Resep Hemat Anak Kos: Rina di tampilan, Bima di data, Sari di ViewModel dan tes."'],
        ['2', 'Masalah dan pengguna sasaran', '"Mahasiswa kos sering bingung memasak dengan bahan seadanya..."'],
        ['3', 'Fitur utama dan alur yang didemokan', '"Kami akan menunjukkan: mencari resep, membuka detail, menyimpan favorit."'],
        ['4', 'Arsitektur: lapisan dan folder lib/', '"Data dari DummyJSON masuk lewat repository, diolah ViewModel, ditampilkan View."'],
        ['5', 'Kualitas dan rilis: tes, CI, tautan, versi', '"17 tes lulus, versi 1.0.1 ada di GitHub Releases."'],
        ['6', 'Pelajaran terpenting dan rencana berikutnya', '"Kalau dilanjutkan, kami ingin menambah pengingat memasak."'],
      ],
      ukuran: 13.5,
      tinggiBaris: 0.6,
      pesan: 'Kerangka siap pakai: templat/TEMPLAT_SLIDE_UAS.pptx. Huruf minimal 24 pt, satu gagasan per slide, tangkapan layar ASLI.',
      catatan: 'Boleh membuat slide sendiri di Google Slides atau Canva, lalu simpan sebagai PDF untuk dikumpulkan (uas_<nama-tim>.pdf). Jangan membacakan slide; ceritakan dengan kalimat sendiri. Tulis tautan versi web dan halaman rilis di slide 5 agar penguji bisa langsung membukanya dari HP.',
    });

    d.banding({
      judul: 'Demo yang Mudah Diingat Itu Bercerita',
      kolom: [
        {
          ikon: 'daftar', judul: 'Membosankan', warna: C.accent5, tag: 'Daftar halaman',
          poin: [
            '"Ini halaman satu, ini halaman dua, ini tombol tiga."',
            'Penguji harus menebak gunanya sendiri',
            'Tidak ada alasan untuk peduli',
          ],
        },
        {
          ikon: 'orang', judul: 'Mudah diingat', warna: C.accent4, tag: 'Seseorang, masalahnya, dan langkah demi langkah', sorot: true,
          poin: [
            '"Ini Dimas, mahasiswa semester tiga. Pukul tujuh malam ia lapar; di kosnya hanya ada telur dan nasi."',
            '"Ia membuka Resep Hemat, mengetik \'telur\'..."',
            'Setiap fitur muncul karena tokohnya membutuhkannya',
          ],
        },
      ],
      pesan: 'Tulis ceritanya sebagai naskah demo (templat/NASKAH_DEMO.md); contoh lengkap "Tugas Kuliahku 1.0.0" ada di Gladi Resik Kegiatan 2.',
      catatan: 'Cerita satu "hari" pengguna membuat demo mengalir. Penguji melihat aplikasi menyelesaikan masalah nyata, bukan sekadar deretan layar. Satu tokoh dan satu masalah sudah cukup.',
    });

    d.tabel({
      judul: 'Urutan Demo yang Disarankan',
      kepala: ['Urutan', 'Isi', 'Lama'],
      lebarKolom: [1.2, 9.4, 1.5],
      baris: [
        ['1', 'Alur utama dari awal sampai tujuan tercapai (jalan yang paling sering dipakai pengguna)', '± 2,5 menit'],
        ['2', 'Data tetap ada: tutup aplikasi, buka lagi, data yang disimpan masih ada', '± 0,5 menit'],
        ['3', 'Satu keadaan sulit: hasil pencarian kosong, internet mati, atau isian formulir salah', '± 1 menit'],
        ['4', 'Tampilan: mode gelap dan layar lebar (atau HP diputar)', '± 0,5 menit'],
        ['5', 'Halaman Tentang: versi, atribusi sumber data, kebijakan privasi', '± 0,5 menit'],
      ],
      ukuran: 16,
      tinggiBaris: 0.7,
      pesan: 'Total ± 5 menit demo + ± 2 menit slide = 7 menit. Data contoh rapi dan realistis, bukan "asdf" atau "tes123".',
      catatan: 'Urutan ini sudah memperagakan sebagian besar syarat minimal sebelum penguji memintanya. Keadaan sulit (nomor 3) adalah kesempatan menunjukkan bahwa aplikasi tetap sopan saat ada masalah.',
    });

    d.tabel({
      judul: 'Menyiapkan Perangkat Demo',
      kepala: ['Siapkan', 'Mengapa'],
      lebarKolom: [6.4, 5.7],
      baris: [
        ['Data contoh yang rapi dan realistis', 'Kesan pertama penguji datang dari data yang tampil'],
        ['Mode Jangan Ganggu di HP dan laptop', 'Notifikasi pribadi tidak muncul di proyektor'],
        ['Kecerahan penuh, baterai penuh, pengisi daya siap', 'Layar redup sulit terlihat di proyektor'],
        ['Waktu tunggu layar HP diperpanjang (misalnya 10 menit)', 'Layar tidak mati sendiri saat Anda berbicara'],
        ['Ukuran huruf sistem kembali normal', 'Tampilan sama dengan saat berlatih'],
        ['Terminal terbuka di folder proyek', 'Saat diminta flutter test, tinggal mengetik'],
        ['Tab browser: repositori, Actions, halaman rilis', 'Bukti CI hijau dan rilis dalam hitungan detik'],
      ],
      ukuran: 15,
      tinggiBaris: 0.6,
      catatan: 'Jalankan flutter test sekali sebelum giliran, agar saat diminta penguji tidak perlu menunggu kompilasi pertama yang lama.',
    });

    d.tabel({
      judul: 'Pilih Cara Menampilkan Aplikasi',
      kepala: ['Cara', 'Cocok untuk', 'Catatan'],
      lebarKolom: [4.3, 3.6, 4.2],
      baris: [
        ['Chrome di laptop (--release atau versi web)', 'Laptop RAM 8 GB, semua jenis aplikasi', 'Perbesar dengan Ctrl + + agar terbaca dari belakang'],
        ['HP Android dicerminkan dengan scrcpy', 'Aplikasi yang memakai kamera, lokasi, sentuhan', 'Paling meyakinkan: aplikasi sungguhan di HP'],
        ['HP di depan kamera dokumen', 'Ruang yang menyediakan kamera dokumen', 'Jaga agar layar HP tidak memantulkan cahaya'],
        ['Emulator Android', 'Laptop RAM 16 GB', 'Berat; jalankan jauh sebelum giliran'],
      ],
      ukuran: 15,
      tinggiBaris: 0.85,
      catatan: 'Versi web di Chrome adalah pilihan teraman untuk sebagian besar tim. Aplikasi yang memakai kamera atau lokasi lebih meyakinkan jika didemokan di HP sungguhan lewat scrcpy.',
    });

    d.kode({
      judul: 'Layar HP di Proyektor: scrcpy',
      shell: true,
      kode: [
        '# Pasang (sekali saja), sekaligus memasang ADB',
        'winget install --exact Genymobile.scrcpy',
        '',
        '# Sambungkan HP dengan kabel data,',
        '# ketuk "Izinkan" pada pertanyaan debugging USB',
        'scrcpy --stay-awake',
        '',
        '# Sekaligus merekam video demo cadangan',
        'scrcpy --record=demo_uas.mp4',
      ].join('\n'),
      ukuran: 15,
      lebarKode: 6.9,
      poin: [
        'Gratis dan bersumber terbuka; tidak perlu memasang apa pun di HP.',
        'Syarat: Android 5.0+ dan Debugging USB aktif (sama seperti flutter run di HP).',
        'Pasang manual? Unduh hanya dari rilis resmi github.com/Genymobile/scrcpy.',
        '--stay-awake: HP tetap menyala selama tersambung.',
        'Masalah umum: Troubleshooting bagian K.',
      ],
      catatan: 'Jendela berisi layar HP muncul di laptop, dan jendela itulah yang tampil di proyektor. Pemasangan manual: unduh scrcpy-win64-v<versi>.zip dari halaman rilis resmi, ekstrak, lalu klik dua kali open_a_terminal_here.bat. Coba sambungan scrcpy di ruang ujian jika diizinkan.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 6–7', judul: 'Uji Langsung dan Tanya Jawab', ikon: 'tanya', catatan: 'Uji langsung membuktikan aplikasi bekerja bukan hanya di jalan yang sudah dilatih. Tanya jawab membuktikan setiap anggota memahami kodenya.' });

    d.tabel({
      judul: 'Permintaan Uji Langsung: Latih Semuanya',
      kepala: ['Permintaan penguji', 'Yang diharapkan terlihat', 'Cara memperagakan'],
      lebarKolom: [3.7, 4.4, 4.0],
      baris: [
        ['"Matikan internetnya, lalu muat ulang."', 'Pesan ramah + Coba lagi; data cache tetap tampil', 'Mode pesawat; Chrome: F12 → Network → Offline'],
        ['"Tutup aplikasinya, lalu buka lagi."', 'Data yang disimpan masih ada', 'Tutup dari daftar aplikasi terbaru'],
        ['"Coba layar lebar dan sempit."', 'Berubah di ≥ 840; tanpa pita kuning-hitam di 360', 'F12 → Ctrl + Shift + M; HP diputar'],
        ['"Tunjukkan mode gelap."', 'Semua teks terbaca', 'Tombol mode atau pengaturan tema'],
        ['"Jalankan tesnya."', 'flutter test → All tests passed!', 'Terminal di folder proyek'],
        ['"Jalankan analisisnya."', 'flutter analyze → No issues found!', 'Terminal yang sama'],
        ['"Versi berapa ini?"', 'Halaman Tentang: versi, atribusi, privasi', 'Ketuk tombol Tentang'],
        ['"Saya mau memasang dari HP saya."', 'Halaman rilis atau web terbuka di HP penguji', 'Kode QR atau tautan di slide 5'],
        ['"Tunjukkan commit Anda."', 'Riwayat commit atas nama Anda', 'git log --author="Nama" --oneline'],
      ],
      ukuran: 13,
      tinggiBaris: 0.52,
      catatan: 'Daftar lengkap ada di Panduan UAS Bagian 6, termasuk "Perbesar ukuran hurufnya" dan "Ubah sedikit, lalu jalankan". Jika ada permintaan yang membuat aplikasi gagal: jangan panik dan jangan berbohong. Jelaskan apa yang terjadi dan bagaimana memperbaikinya. Menemukan dan menjelaskan kelemahan sendiri adalah tanda pemahaman, dan itu ikut dinilai.',
    });

    d.tabel({
      judul: 'Jenis Pertanyaan',
      pengantar: 'Setiap anggota mendapat 2–3 pertanyaan tentang bagiannya sendiri, lalu pertanyaan silang tentang bagian teman.',
      kepala: ['Jenis', 'Contoh pertanyaan'],
      lebarKolom: [2.6, 9.5],
      baris: [
        ['Perjalanan kode', '"Ceritakan apa yang terjadi sejak tombol ini diketuk sampai daftar berubah."'],
        ['Alasan desain', '"Mengapa data ini disimpan di SQLite, bukan shared_preferences?"'],
        ['Bagaimana jika', '"Apa yang terjadi jika server mengembalikan kode 500?"'],
        ['Membaca kode', '"Baris if (!mounted) return; untuk apa? Apa akibatnya jika dihapus?"'],
        ['Pengujian', '"Tes mana yang menjaga aturan ini? Apa yang terjadi jika aturannya diubah?"'],
        ['Proses dan tim', '"Masalah tersulit apa yang Anda temui, dan bagaimana menyelesaikannya?"'],
        ['Kejujuran', '"Bagian mana yang dibantu AI, dan bagaimana Anda memastikan hasilnya benar?"'],
      ],
      ukuran: 15,
      tinggiBaris: 0.56,
      catatan: 'Penguji membuka repositori dan KONTRIBUSI_TIM.md untuk melihat pembagian kerja, lalu memilih pertanyaan dari bagian setiap anggota. Untuk pertanyaan silang, setiap anggota cukup paham GARIS BESAR bagian temannya: apa tugasnya, bagaimana datanya mengalir ke bagian sendiri, dan di folder mana ia berada.',
    });

    d.banding({
      judul: '"Apa yang Terjadi Kalau Internet Mati?"',
      kolom: [
        {
          ikon: 'galat', judul: 'Jawaban lemah', warna: C.accent5,
          poin: [
            '"Nanti error, Pak."',
            'Tidak menunjuk kode',
            'Tidak menjelaskan apa yang dilihat pengguna',
          ],
        },
        {
          ikon: 'centang', judul: 'Jawaban kuat', warna: C.accent4, sorot: true,
          poin: [
            '"Di repositori_tugas_server.dart baris 42, http.get dibungkus try. Kalau koneksinya gagal, repository mengembalikan Gagal(TanpaKoneksi())."',
            '"ViewModel mengubah status menjadi gagal; halaman menampilkan pesan dan tombol Coba lagi. Tugas di SQLite tetap tampil."',
            '"Boleh saya peragakan dengan mode pesawat?"',
          ],
        },
      ],
      ukuranPoin: 15,
      tinggiKolom: 4.25,
      pesan: 'Jawaban kuat tidak harus panjang: ia MENUNJUK TEMPATNYA, MENCERITAKAN URUTAN KEJADIANNYA, dan MENAWARKAN BUKTI.',
      catatan: 'Contoh dari Panduan UAS Bagian 7.3. Pesan yang tampil di layar pada contoh ini: "Tidak dapat terhubung. Periksa koneksi internet Anda." Jawaban kuat menceritakan perjalanan dari repository ke ViewModel ke View, persis seperti yang terjadi saat kode berjalan.',
    });

    d.tabel({
      judul: 'Menjawab dengan Baik',
      kepala: ['Lakukan', 'Hindari'],
      lebarKolom: [6.05, 6.05],
      baris: [
        ['Tunjuk berkas dan barisnya di layar', 'Menjawab dengan istilah tanpa menunjukkan kodenya'],
        ['Ceritakan apa yang terjadi saat kode berjalan, dengan bahasa sendiri', 'Menghafal definisi dari buku atau AI'],
        ['Jawab pendek dulu, lalu tambah rincian jika diminta', 'Berbicara terus sampai waktu habis'],
        ['Jujur jika tidak tahu, lalu sebutkan cara mencari tahu', 'Menebak asal-asalan atau mengalihkan ke teman'],
        ['Boleh menjalankan atau mengubah kode untuk menjelaskan', 'Panik saat aplikasi berperilaku tidak terduga'],
      ],
      ukuran: 16,
      tinggiBaris: 0.7,
      catatan: 'Mahasiswa yang gugup sering pulih begitu melihat kodenya sendiri. Biasakan membuka berkas lebih dulu sebelum menjawab: "Boleh saya tunjukkan berkasnya?"',
    });

    d.layar({
      judul: 'Berlatih Berpasangan: Kartu Latihan (Contoh 03)',
      gambar: ['hasil_contoh_03a.jpg', 'hasil_contoh_03b.jpg', 'hasil_contoh_03c.jpg'],
      lebarMaks: 8.1,
      berkas: 'kode/contoh_03_kartu_latihan_tanya_jawab.dart',
      poin: [
        'Satu membacakan, satu menjawab sambil menunjuk kode.',
        'Buka poin jawaban, lalu tandai.',
        'Kartu "Perlu diulang" dikumpulkan beserta bagian modul yang perlu dibaca.',
      ],
      ukuranPoin: 15,
      catatan: 'Kiri: 21 kartu dari tujuh kategori, semua chip terpilih. Tengah: kartu State dengan dua poin jawaban yang sudah dibuka dan rujukan "Baca ulang: P9 Bagian 7". Kanan: ringkasan setelah hanya kategori Arsitektur yang dipilih, "Sudah bisa 2 dari 3 kartu", dengan satu kartu perlu diulang. Pengacaknya disuntikkan (Random? acak) agar urutan kartu bisa dibuat tetap saat diuji, pola yang sama dengan jam palsu di Contoh 02.',
    });

    d.kartu({
      judul: 'Ubah Kecil Langsung (± 3 Menit)',
      pengantar: 'Tujuannya bukan menjebak: penguji ingin melihat Anda TAHU TEMPATNYA dan PAHAM AKIBATNYA.',
      kolom: 3,
      tinggiKartu: 3.6,
      item: [
        { ikon: 'palet', judul: 'Ganti warna benih', isi: 'Semua warna ikut berubah setelah hot reload: bukti warna diambil dari tema.', kode: 'ColorScheme.fromSeed(\n  seedColor: Colors.green,\n)' },
        { ikon: 'uji', judul: 'Ubah batas, lalu tes', isi: 'Perkirakan dulu tes mana yang akan merah, baru jalankan.', kode: 'const maksimalPinjam = 5;\n// flutter test', warna: C.accent6 },
        { ikon: 'teks', judul: 'Ubah pesan galat', isi: 'Kalimat untuk pengguna ada di lapisan UI, bukan di repository.', kode: "TanpaKoneksi() =>\n  'Tidak ada internet.',", warna: C.accent4 },
      ],
      catatan: 'Latih kemampuan ini dengan Latihan Persiapan bagian D (tujuh perubahan kecil pada Contoh 02 dan 03, masing-masing dengan batas waktu). Contoh di kartu kedua bersifat ilustrasi: nama konstanta di proyek setiap tim berbeda.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 8–9', judul: 'Rubrik dan Nilai Setiap Anggota', ikon: 'bintang', catatan: 'Mahasiswa yang tahu cara dinilai bisa menyiapkan buktinya sejak awal.' });

    d.tabel({
      judul: 'Komponen Nilai Proyek Akhir',
      kepala: ['Komponen', 'Bobot', 'Kapan dinilai', 'Dinilai per'],
      lebarKolom: [5.4, 1.4, 3.0, 2.3],
      baris: [
        ['Proposal', '5', 'Pertemuan 9', 'Tim'],
        ['Laporan kemajuan', '10', 'Pertemuan 12', 'Tim'],
        ['Fungsionalitas', '25', 'UAS', 'Tim'],
        ['Arsitektur dan kualitas kode', '15', 'UAS', 'Tim'],
        ['UI/UX', '10', 'UAS', 'Tim'],
        ['Pengujian', '10', 'UAS', 'Tim'],
        ['Repositori, rilis, dan dokumentasi', '10', 'UAS', 'Tim'],
        [{ text: 'Presentasi dan tanya jawab', options: { bold: true } }, { text: '15', options: { bold: true } }, 'UAS', { text: 'Orang', options: { bold: true, color: TEMA.colors.accent5 } }],
        [{ text: 'Total', options: { bold: true } }, { text: '100', options: { bold: true } }, '', ''],
      ],
      ukuran: 15,
      tinggiBaris: 0.5,
      catatan: 'Komponen mengikuti Panduan Proyek Akhir Bagian 9. Tujuh komponen pertama dinilai per tim (nilai tim, paling tinggi 85). Hanya presentasi dan tanya jawab yang dinilai per orang.',
    });

    d.tabel({
      judul: 'Seperti Apa Nilai "Sangat Baik"?',
      kepala: ['Komponen', 'Ciri tingkat Sangat baik'],
      lebarKolom: [3.4, 8.7],
      baris: [
        ['Fungsionalitas (22–25)', 'Enam syarat terpenuhi; memuat, kosong, gagal, dan luring ditangani; tanpa crash'],
        ['Arsitektur (13–15)', 'View hanya menampilkan, logika di ViewModel, data lewat repository; analyze bersih'],
        ['UI/UX (9–10)', 'Konsisten dari tema; mode gelap terbaca; tanpa overflow di 360; menyesuaikan di ≥ 840'],
        ['Pengujian (9–10)', '≥ 3 tes bermakna (nilai batas, repository palsu) lulus; CI hijau'],
        ['Repositori (9–10)', 'Commit bertahap setiap anggota; tag versi; rilis bisa dipakai; dokumen lengkap; tanpa kunci'],
        ['Presentasi (13–15, per orang)', 'Demo lancar sesuai waktu; menjawab dengan menunjuk kode dan urutan kejadiannya'],
      ],
      ukuran: 14,
      tinggiBaris: 0.6,
      pesan: 'Fitur yang dikerjakan dengan cara lain dari modul tetap dinilai penuh selama benar dan Anda bisa menjelaskannya.',
      catatan: 'Patokan lengkap keempat tingkat (Sangat baik, Baik, Cukup, Kurang) ada di Panduan UAS Bagian 8. Ajak tim menilai diri dengan Latihan Persiapan bagian E: komponen yang diperkirakan Cukup atau Kurang menjadi prioritas minggu ini.',
    });

    d.kode({
      judul: 'Nilai Setiap Anggota Bisa Berbeda',
      shell: true,
      kode: [
        'nilai proyek akhir =',
        '  nilai tim × faktor individu + presentasi',
        '  (maks 85)  (0 sampai 1,0)    (maks 15)',
        '',
        '# Contoh 01, nilai tim 73:',
        'Rina  (73 x 1,0) + 14 = 87,0',
        'Bima  (73 x 1,0) + 12 = 85,0',
        'Sari  (73 x 0,8) +  9 = 67,4',
      ].join('\n'),
      ukuran: 16,
      lebarKode: 6.6,
      berkas: 'kode/contoh_01_hitung_nilai_proyek_akhir_dart_murni.dart',
      poin: [
        '1,0: menjelaskan bagiannya dengan benar; kontribusi jelas.',
        '0,8: sebagian penjelasan kurang tepat, atau kontribusi kecil.',
        '0,5: banyak bagian sendiri tidak bisa dijelaskan.',
        '0: sama sekali tidak bisa menjelaskan, atau tidak berkontribusi.',
        'Sari kehilangan hampir 20 poin, padahal nilai timnya sama.',
      ],
      catatan: 'Faktor individu hanya mengalikan nilai TIM; nilai presentasi ditambahkan utuh. Buktinya dari jawaban tanya jawab, riwayat commit, dan KONTRIBUSI_TIM.md. Pesan Panduan Proyek Akhir: setiap anggota harus bisa menjelaskan setiap baris kode di bagiannya. Contoh 01 menghitung dengan bilangan bulat dalam satuan persepuluhan (674 berarti 67,4), sehingga tidak muncul angka seperti 58.400000000000006.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 10–14', judul: 'Cadangan, Tata Tertib, dan Persiapan', ikon: 'perisai', catatan: 'Kendala teknis di hari-H bukan alasan nilai turun, asalkan tim punya cadangan dan tetap bisa menunjukkan aplikasinya.' });

    d.tabel({
      judul: 'Rencana Cadangan Saat Ada Kendala',
      kepala: ['Kendala', 'Rencana cadangan'],
      lebarKolom: [4.1, 8.0],
      baris: [
        ['Internet ruang ujian mati atau lambat', 'Cache luring; hotspot dari HP lain; versi data palsu (main_pengembangan.dart)'],
        ['API sedang bermasalah', 'Data palsu, lalu jelaskan: hanya satu baris di akar komposisi yang diganti'],
        ['HP tidak terbaca di laptop', 'Periksa kabel dan izin debugging USB; jika gagal, demo versi web'],
        ['Proyektor tidak menampilkan layar', 'Windows + P → Duplikat; jika gagal, demo menghadap penguji'],
        ['Aplikasi crash saat demo', 'Tenang, baca pesan galatnya, jelaskan, ulangi dari awal alur'],
        ['Laptop mati atau rusak', 'Putar video demo cadangan; tanya jawab dengan repositori di GitHub'],
        ['Anggota sakit atau keperluan resmi', 'Kabari dosen SEBELUM UAS dengan bukti; dijadwalkan ulang'],
      ],
      ukuran: 15,
      tinggiBaris: 0.6,
      catatan: 'Versi data palsu bisa dijalankan dengan main_pengembangan.dart atau --dart-define=LINGKUNGAN=pengembangan (Pertemuan 12 dan 15). Video demo cadangan 1–3 menit dibuat di Gladi Resik Kegiatan 4.',
    });

    d.banding({
      judul: 'Tata Tertib dan Kejujuran Akademik',
      kolom: [
        {
          ikon: 'centang', judul: 'Boleh', warna: C.accent4,
          poin: [
            'Memakai AI SELAMA PENGEMBANGAN sebagai tutor, lalu mencatatnya',
            'Memakai potongan kode yang Anda pahami, dengan menyebut sumbernya',
            'Membawa catatan kecil berisi urutan demo',
            'Mengakui fitur yang belum selesai',
          ],
        },
        {
          ikon: 'galat', judul: 'Tidak boleh', warna: C.accent5,
          poin: [
            'Memakai AI atau bantuan orang lain SAAT TANYA JAWAB',
            'Menyalin proyek utuh milik orang lain atau tim lain',
            'Membacakan jawaban dari catatan',
            'Memalsukan data, tangkapan layar, hasil tes, atau kontribusi',
          ],
        },
      ],
      ukuranPoin: 15,
      tinggiKolom: 4.1,
      pesan: 'Kode yang sama sekali tidak bisa Anda jelaskan dianggap bukan hasil kerja Anda dan tidak dinilai.',
      catatan: 'Kemiripan mencolok antartim diperiksa lebih lanjut dan ditangani sesuai peraturan akademik kampus. Tulis kontribusi setiap anggota dengan jujur di KONTRIBUSI_TIM.md: jangan menulis nama teman yang tidak ikut bekerja, atau sebaliknya.',
    });

    d.tabel({
      judul: 'Yang Dikumpulkan (Paling Lambat H-2)',
      kepala: ['No', 'Yang dikumpulkan', 'Keterangan'],
      lebarKolom: [0.7, 5.2, 6.2],
      baris: [
        ['1', 'Tautan repositori GitHub', 'Dengan tag versi rilis (v1.0.0 atau lebih baru)'],
        ['2', 'Tautan halaman rilis (APK) dan/atau versi web', 'Sudah dicoba dibuka dari HP lain'],
        ['3', 'Slide dalam bentuk PDF', 'Nama berkas: uas_<nama-tim>.pdf (huruf kecil, tanpa spasi)'],
        ['4', 'Tautan video demo cadangan (1–3 menit)', 'Google Drive atau YouTube (tidak publik); bisa diputar orang lain'],
        ['5', 'KONTRIBUSI_TIM.md di repositori', 'Peran, berkas yang dikerjakan, catatan pemakaian AI'],
      ],
      ukuran: 15,
      tinggiBaris: 0.66,
      pesan: 'Setelah tenggat, JANGAN mengubah riwayat Git (git push --force). Perbaikan kecil dikirim sebagai rilis 1.0.1 dengan catatan di CHANGELOG.md.',
      catatan: 'Tenggat dan tempat pengumpulan mengikuti pengumuman dosen. Penguji menilai versi yang dikumpulkan dan dapat menanyakan perubahan sesudahnya. Latihan C3 membahas apa yang terjadi jika seseorang menjalankan git push --force setelah tenggat.',
    });

    d.banding({
      judul: 'Daftar Periksa H-7, H-1, dan Hari-H',
      kolom: [
        {
          ikon: 'tugas', judul: 'H-7', warna: C.accent1,
          poin: [
            'Fitur wajib selesai',
            'analyze bersih, test hijau',
            'Rilis bertag dicoba di HP',
            'Dokumen lengkap',
            'Naskah demo dan slide',
          ],
        },
        {
          ikon: 'timer', judul: 'H-1', warna: C.accent6,
          poin: [
            'Gladi lengkap ≤ 7 menit',
            '10 kartu tanya jawab per anggota',
            'Video cadangan diunggah',
            'APK terakhir terpasang',
            'Semua berkas terkumpul',
          ],
        },
        {
          ikon: 'piala', judul: 'Hari-H', warna: C.accent4,
          poin: [
            'Datang 30 menit lebih awal',
            'Mode Jangan Ganggu',
            'flutter test sudah sekali',
            'Tab: repo, Actions, rilis, web',
            'scrcpy sudah dicoba',
          ],
        },
      ],
      ukuranPoin: 16,
      catatan: 'Versi lengkap dengan kotak centang ada di Panduan UAS Bagian 13. Dokumen yang dimaksud: README.md, CHANGELOG.md, KEBIJAKAN_PRIVASI.md, dan KONTRIBUSI_TIM.md.',
    });

    d.tabel({
      judul: 'Rencana Persiapan Satu Minggu',
      kepala: ['Hari', 'Kegiatan', 'Bahan'],
      lebarKolom: [0.9, 7.6, 3.6],
      baris: [
        ['1', 'Audit repositori: analisis, tes, tag, rilis, dokumen; catat yang kurang', 'Gladi Resik Kegiatan 1'],
        ['2', 'Perbaiki kekurangan; jika ada perubahan, rilis 1.0.1', 'Pertemuan 15 Bagian 12'],
        ['3', 'Tulis naskah demo, buat slide, isi KONTRIBUSI_TIM.md', 'Folder templat/'],
        ['4', 'Gladi berpasangan dengan tim lain: saling menguji dengan rubrik', 'Gladi Resik Kegiatan 6'],
        ['5', 'Latihan tanya jawab: kartu latihan dan Latihan bagian B–D', 'Contoh 03, LATIHAN.md'],
        ['6', 'Rekam video cadangan; siapkan perangkat; kumpulkan berkas', 'Gladi Resik Kegiatan 3–4'],
        ['7', 'Gladi terakhir sekali saja, lalu ISTIRAHAT', 'Daftar periksa H-1'],
      ],
      ukuran: 15,
      tinggiBaris: 0.6,
      catatan: 'Hari ketujuh sengaja ringan. Tim yang beristirahat cukup menjawab lebih tenang daripada tim yang begadang memperbaiki fitur di malam terakhir.',
    });

    d.tabel({
      judul: 'Gladi Resik: Tujuh Kegiatan',
      kepala: ['Kegiatan', 'Isi', 'Hasil'],
      lebarKolom: [3.0, 5.4, 3.7],
      baris: [
        ['1. Audit repositori', 'Perintah pemeriksaan: analyze, test, shortlog, berkas kunci', 'Lembar audit terisi'],
        ['2. Peta demo dan naskah', 'Tokoh, cerita, pembagian peran', 'NASKAH_DEMO.md'],
        ['3. Perangkat dan layar', 'HP demo, scrcpy, latihan semua uji langsung', 'Perangkat siap'],
        ['4. Video demo cadangan', 'Merekam 1–3 menit, mengunggah, menguji tautan', 'Tautan video'],
        ['5. Slide', 'Enam slide dari templat, disimpan sebagai PDF', 'uas_<nama-tim>.pdf'],
        ['6. Gladi berpasangan', 'Ujian 20 menit dengan tim lain sebagai penguji', 'Lembar umpan balik'],
        ['7. Perbaikan terakhir', 'Perbaikan kecil sebagai rilis 1.0.1 (opsional)', 'Tag v1.0.1'],
      ],
      ukuran: 15,
      tinggiBaris: 0.6,
      catatan: 'Gladi resik tidak dinilai, kecuali dosen mengumumkan lain. Hasil setiap kegiatan dicatat di docs/gladi_resik.md di repositori proyek. Proyek individu tetap mengerjakan semua kegiatan; untuk Kegiatan 6, berpasanganlah dengan mahasiswa lain.',
    });

    // ------------------------------------------------------------------
    d.tabel({
      judul: 'Pertanyaan yang Sering Diajukan',
      kepala: ['Pertanyaan', 'Jawaban singkat'],
      lebarKolom: [4.6, 7.5],
      baris: [
        ['Ada fitur yang belum selesai?', 'Katakan jujur, tunjukkan sejauh mana, jelaskan rencananya; jangan mendemokan yang bisa crash'],
        ['Boleh memperbaiki setelah v1.0.0?', 'Boleh, sebagai rilis baru 1.0.1+2 dengan CHANGELOG dan tag v1.0.1'],
        ['Hanya punya versi web, tanpa APK?', 'Boleh: minimal satu berkas rilis; keduanya lebih baik'],
        ['Bolehkah demo di emulator?', 'Boleh jika laptop kuat; Chrome atau HP sungguhan biasanya lebih aman'],
        ['Ditanya tentang bagian teman?', 'Cukup garis besarnya; rincian ditanyakan kepada pembuatnya'],
        ['Aplikasi crash tepat saat demo?', 'Baca pesan galatnya, jelaskan dugaan penyebab, ulangi atau putar video'],
        ['Slide wajib? Boleh berbahasa Inggris?', 'Ikuti pengumuman dosen; yang terpenting penjelasan jelas'],
      ],
      ukuran: 14,
      tinggiBaris: 0.62,
      catatan: 'Jawaban lengkap ada di Panduan UAS Bagian 16.',
    });

    d.ringkasan({
      poin: [
        'UAS tidak menguji materi baru: yang diuji aplikasi Anda dan pemahaman Anda tentangnya.',
        '± 20 menit: 7 presentasi dan demo, 3 uji langsung, 8 tanya jawab, 2 catatan penguji.',
        'Paling banyak enam slide (± 2 menit); bintangnya adalah aplikasi.',
        'Demo bercerita: satu tokoh, satu masalah, alur utama, data tetap ada, satu keadaan sulit.',
        'Latih semua permintaan uji langsung: mode pesawat, layar lebar, mode gelap, flutter test.',
        'Jawaban kuat: tunjuk tempatnya, ceritakan urutan kejadian, tawarkan bukti.',
        'Nilai proyek akhir = nilai tim × faktor individu + presentasi; setiap anggota bisa berbeda.',
        'Siapkan cadangan: data palsu, video demo, versi web; kendala bukan alasan nilai turun.',
        'Kumpulkan lima berkas paling lambat H-2; setelah tenggat, jangan mengubah riwayat Git.',
        'Gladi resik dengan tim lain adalah persiapan paling ampuh.',
      ],
      catatan: 'Tutup dengan pengingat: semua yang ditanyakan sudah Anda buat sendiri. Persiapan terbaik adalah membuka kode sendiri dan menjelaskannya dengan suara keras kepada teman.',
    });

    d.tabel({
      judul: 'Perjalanan Satu Semester',
      kepala: ['Pertemuan', 'Sekarang Anda bisa ...'],
      lebarKolom: [1.8, 10.3],
      baris: [
        ['1–2', 'memasang Flutter, menjalankan aplikasi pertama, dan menulis program Dart yang rapi'],
        ['3', 'memakai class, enum, penanganan galat, dan kode asinkron'],
        ['4–5', 'menyusun tampilan dari widget dan membuatnya bereaksi terhadap sentuhan'],
        ['6–7', 'membuat daftar, navigasi, tema Material 3, mode gelap, dan tata letak responsif'],
        ['8', 'membangun aplikasi multi-halaman dalam waktu terbatas (UTS)'],
        ['9–12', 'memisahkan tampilan dan logika, mengambil data internet, menyimpannya, dan menata lapisan'],
        ['13–15', 'memakai fitur perangkat, membuktikan kode dengan tes, dan merilis aplikasi'],
        [{ text: '16', options: { bold: true } }, { text: 'mempertanggungjawabkan aplikasi buatan sendiri di depan orang lain', options: { bold: true } }],
      ],
      ukuran: 15,
      tinggiBaris: 0.56,
      catatan: 'Enam belas minggu lalu, sebagian mahasiswa belum pernah menulis satu baris kode aplikasi. Hari ini mereka membawa aplikasi yang bisa dipasang orang lain, punya tes, punya riwayat pengerjaan, dan bisa dijelaskan baris demi baris. Itu pencapaian yang nyata.',
    });

    d.penutup({
      judul: 'Selamat Menempuh UAS!',
      subjudul: 'Lakukan Gladi Resik bersama tim lain, kerjakan Latihan Persiapan (terutama bagian B dan D), lalu kumpulkan semua berkas sebelum tenggat.',
      tautan: [
        { teks: 'Panduan UAS', ikon: 'buku', url: d.urlBerkas('pertemuan_16_uas/README.md') },
        { teks: 'Gladi Resik', ikon: 'tugas', url: d.urlBerkas('pertemuan_16_uas/GLADI_RESIK.md') },
        { teks: 'Latihan', ikon: 'kuis', url: d.urlBerkas('pertemuan_16_uas/LATIHAN.md') },
      ],
      catatan: 'Setelah UAS: rapikan halaman depan repositori (tangkapan layar, tautan web dan APK), sematkan repositori di profil GitHub, dan catat ide lanjutan sebagai Issues. Proyek akhir ini adalah portofolio pertama mahasiswa sebagai pengembang aplikasi.',
    });
  },
};

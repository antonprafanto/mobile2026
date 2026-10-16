// Konten slide Pertemuan 12 — Arsitektur Aplikasi: Clean Architecture.
// Teks diambil dari modul bacaan (pertemuan_12_clean_architecture/README.md).
// Tangkapan layar diambil dari folder pertemuan_12_clean_architecture/gambar/.

module.exports = {
  nomor: '12',
  folder: 'pertemuan_12_clean_architecture',
  namaBerkas: 'PERTEMUAN_12_Clean_Architecture',
  topik: 'Clean Architecture',

  bangun(d) {
    const C = d.C;
    const KODE = { fontFace: 'Consolas' };
    const kode = (teks) => ({ text: teks, options: KODE });
    const kodeKecil = (teks) => ({ text: teks, options: { fontFace: 'Consolas', fontSize: 13 } });

    d.judul({
      judul: 'Arsitektur Aplikasi: Clean Architecture',
      subjudul: 'Pertemuan 12  ·  lapisan UI, domain, dan data; aturan ketergantungan; entitas dan aturan bisnis dalam Dart murni; kontrak + dependency injection; model API; Hasil dan Kegagalan; use case; Perintah (Command); menguji setiap lapisan',
      catatan: 'Sejak Pertemuan 9 kita memakai MVVM + repository. Hari ini kita merapikannya dengan gagasan Clean Architecture: di mana setiap kode diletakkan, siapa boleh mengenal siapa, dan bagaimana menguji setiap bagian. Bekal: class, abstract class, sealed class, Future (P3); MVVM, provider, repository (P9); layanan, JSON, exception, MockClient (P10); repository yang menyimpan di perangkat (P11). Semua contoh hari ini bisa dijalankan di DartPad, karena paket http dan provider tersedia di sana. Pertemuan ini juga tahap laporan kemajuan proyek akhir.',
    });

    d.tujuan({
      pengantar: 'Setelah pertemuan ini, Anda mampu:',
      poin: [
        'Menjelaskan lapisan dan aturan ketergantungan (Dependency Rule)',
        'Menempatkan class di lapisan UI, domain, atau data dengan tepat',
        'Menulis entitas dan aturan bisnis dalam Dart murni yang bisa diuji',
        'Membuat kontrak di domain dan menyuntikkan implementasinya dari satu akar komposisi',
        'Memisahkan model API dari entitas dengan pemetaan keDomain()',
        'Menyampaikan kegagalan dengan Hasil<T> dan Kegagalan, bukan exception yang bocor',
        'Menulis use case dan Perintah (Command), lalu mengujinya dengan data palsu',
        'Menata folder proyek akhir secukupnya, tanpa berlebihan (YAGNI)',
      ],
      catatan: 'Target akhir hari ini: aplikasi "Pinjam Ruang Kampus" yang ditata menjadi tiga lapisan, bisa berpindah dari data palsu ke data server hanya dengan mengubah satu baris, dan memeriksa semua aturannya sendiri tanpa layar maupun internet (23 pemeriksaan sebelum runApp).',
    });

    d.alur({
      judul: 'Peta Materi Hari Ini',
      langkah: [
        { ikon: 'puzzle', judul: 'A. Mengapa berlapis?', isi: 'Kode kusut, lapisan, aturan ketergantungan (Bagian 1–2)' },
        { ikon: 'buku', judul: 'B. Domain', isi: 'Entitas, aturan bisnis, jam disuntikkan (3)' },
        { ikon: 'tautan', judul: 'C. Kontrak & data', isi: 'Dependency injection, akar komposisi, model API (4–5)' },
        { ikon: 'galat', judul: 'D. Hasil, use case, Perintah', isi: 'Kegagalan yang jujur, satu tindakan, satu status (6–8)' },
        { ikon: 'folder', judul: 'E. Uji, folder, studi kasus', isi: 'Pinjam Ruang Kampus dan YAGNI (9–14)', warna: C.accent4 },
      ],
      catatan: 'Bagian A: apa salahnya menumpuk semua kode di satu widget, dan bagaimana Clean Architecture membaginya? Bagian B: di mana aturan seperti "maksimal 2 peminjaman" ditulis, dan bagaimana mengujinya? Bagian C: bagaimana menukar sumber data tanpa menyentuh tampilan, dan di mana JSON diterjemahkan? Bagian D: bagaimana kegagalan sampai ke layar tanpa UI ikut mengenal HTTP, di mana logika yang memakai beberapa repository ditulis, dan bagaimana setiap tombol tahu statusnya sendiri? Bagian E: menguji, menata folder, merangkai semuanya, dan kapan semua ini justru berlebihan.',
    });

    d.tabel({
      judul: 'Kode Contoh Hari Ini',
      kepala: ['No', 'Berkas', 'Isi', 'Internet'],
      lebarKolom: [0.6, 6.1, 4.1, 0.9],
      baris: [
        ['01', kode('contoh_01_kode_kusut.dart'), 'Semua pekerjaan di satu widget (jangan ditiru)', '✔'],
        ['02', kode('contoh_02_domain_dart_murni.dart'), 'Entitas, objek nilai, aturan bisnis', '—'],
        ['03', kode('contoh_03_kontrak_dan_dependency_injection.dart'), 'Satu kontrak, dua implementasi', '✔'],
        ['04', kode('contoh_04_model_api_dan_pemetaan.dart'), 'Model API ⇄ entitas, server versi 2', '—'],
        ['05', kode('contoh_05_hasil_dan_kegagalan.dart'), 'Hasil dan Kegagalan, lima skenario', '—'],
        ['06', kode('contoh_06_use_case_dan_data_palsu.dart'), 'Use case AjukanPeminjaman dan pengujiannya', '—'],
        ['07', kode('contoh_07_perintah_command.dart'), 'Tombol yang tidak mengirim dua kali', '—'],
        ['08', kode('contoh_08_studi_kasus_pinjam_ruang.dart'), 'Studi kasus "Pinjam Ruang Kampus"', '✔'],
      ],
      ukuran: 14,
      tinggiBaris: 0.56,
      catatan: 'Semua contoh berjalan di DartPad. Contoh 01, 03, dan 08 membaca data ruang dari berkas data/ruang_kampus.json di repositori GitHub mata kuliah, jadi membutuhkan internet. Contoh lain memakai data palsu atau server palsu (MockClient), jadi berjalan tanpa internet.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 1', judul: 'Mengapa Aplikasi Perlu Arsitektur?', ikon: 'puzzle', catatan: 'Aplikasi jarang berhenti di versi pertama. Fitur yang selalu ditempel di tempat terdekat membuat kode tumbuh seperti kabel di bawah meja.' });

    d.kartu({
      judul: 'Arsitektur = Tiga Kesepakatan',
      kolom: 3,
      item: [
        { ikon: 'folder', judul: 'Di mana kode diletakkan?', isi: 'Aturan "maksimal dua peminjaman" ditulis di tombol, di ViewModel, atau di tempat lain?' },
        { ikon: 'tautan', judul: 'Siapa boleh mengenal siapa?', isi: 'Bolehkah halaman daftar ruang tahu alamat server dan nama kolom JSON-nya?', warna: C.accent6 },
        { ikon: 'uji', judul: 'Bagaimana mengujinya?', isi: 'Bisakah aturan peminjaman diuji tanpa membuka aplikasi dan menekan tombol?', warna: C.accent4 },
        { ikon: 'lampu', judul: 'Mudah dipahami', isi: 'Setiap bagian punya SATU tugas: teman satu tim bisa menebak di berkas mana aturan ditulis.', warna: C.accent3 },
        { ikon: 'ubah', judul: 'Mudah diubah', isi: 'Server diganti, tetapi halaman tidak disentuh sama sekali.', warna: C.accent3 },
        { ikon: 'centang', judul: 'Mudah diuji', isi: 'Aturan "Sabtu ditolak" bisa diuji pada hari Senin.', warna: C.accent3 },
      ],
      catatan: 'Sejak Pertemuan 9 Anda sudah memakai satu bentuk arsitektur: MVVM dengan repository. Hari ini kita merapikannya lebih jauh. Panduan resmi Flutter menyebut sifat yang ingin dicapai: mudah dipahami (setiap bagian punya satu tugas, separation of concerns), mudah diubah (mengganti server tidak merembet ke halaman), dan mudah diuji (aturan "Sabtu ditolak" bisa diuji pada hari Senin).',
    });

    d.layar({
      judul: 'Contoh 01: Berjalan, tetapi Kusut',
      gambar: ['hasil_contoh_01a.jpg', 'hasil_contoh_01b.jpg'],
      lebarMaks: 5.6,
      berkas: 'kode/contoh_01_kode_kusut.dart',
      kode: [
        'Future<void> _ambilRuang() async {',
        '  try {',
        '    // MASALAH 1: alamat server di widget',
        '    final respons = await http.get(Uri.parse(...));',
        '    // MASALAH 2: JSON dibaca dengan "as"',
        '    final json = jsonDecode(respons.body)',
        '        as Map<String, dynamic>;',
        '  } catch (e) {',
        "    _galat = 'Error: $e'; // MASALAH 6",
        '  }',
        '}',
        '// MASALAH 3: aturan bisnis di penanganan tombol',
        'void _pinjam(Map<String, dynamic> ruang) {',
        '  // MASALAH 4: jam langsung dari DateTime.now()',
        '  final besok = DateTime.now().add(...);',
      ].join('\n'),
      ukuranKode: 11,
      poin: [
        'Kiri: dijalankan hari Jumat → "besok" Sabtu → ditolak.',
        'Kanan: berkas JSON belum ada (404) → pesan teknis.',
      ],
      ukuranPoin: 14,
      catatan: 'Aplikasinya berjalan dengan baik; masalahnya ada di dalam: seluruh pekerjaan ditumpuk di satu State. MASALAH 5: data disimpan di State halaman, sehingga halaman lain tidak bisa memakainya. Gambar kiri diambil hari Jumat: tombol yang sama menghasilkan "Berhasil" hari Senin. Gambar kanan: server menjawab 404: Not Found, kode mencoba membaca teks itu sebagai JSON, lalu pesan exception-nya ditampilkan apa adanya: Error: FormatException: SyntaxError... Di slide, tipe variabel dipersingkat dengan final; di berkas aslinya tipe ditulis lengkap.',
    });

    d.tabel({
      judul: 'Enam Masalah, Enam Jawaban',
      kepala: ['Masalah di Contoh 01', 'Akibatnya', 'Dirapikan di'],
      lebarKolom: [4.3, 4.9, 2.4],
      baris: [
        ['1. Urusan HTTP dan alamat server di widget', 'Server pindah = berkas tampilan ikut diubah', 'Bagian 4'],
        ['2. JSON dibaca dengan as di tengah tampilan', 'Nama kolom berubah = gagal di tengah layar', 'Bagian 5'],
        ['3. Aturan bisnis di penanganan tombol', 'Satu-satunya cara menguji: menekan tombol', 'Bagian 3 dan 7'],
        ['4. Jam dari DateTime.now()', 'Hasil berbeda setiap hari, tidak bisa diuji pasti', 'Bagian 3.3'],
        ['5. Data disimpan di State halaman', 'Halaman lain tidak bisa memakainya', 'Bagian 4 dan 11'],
        ['6. Pesan teknis untuk pengguna', 'Pengguna membaca FormatException: ...', 'Bagian 6'],
      ],
      ukuran: 15,
      tinggiBaris: 0.66,
      catatan: 'Setiap masalah punya bagian modul yang merapikannya. Di akhir pertemuan, keenam masalah ini sudah terjawab di studi kasus Contoh 08.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 2', judul: 'Clean Architecture dalam Satu Gambar', ikon: 'lapisan', catatan: 'Gagasan Robert C. Martin (2012), dirumuskan ulang oleh panduan arsitektur resmi Flutter menjadi tiga lapisan.' });

    d.tabel({
      judul: 'Analogi Rumah Makan',
      kepala: ['Di rumah makan', 'Tugasnya', 'Di aplikasi', 'Lapisan'],
      lebarKolom: [2.6, 4.0, 3.2, 1.8],
      baris: [
        ['Pelayan', 'Mencatat pesanan, mengantar, memberi tahu jika menu habis', 'View dan ViewModel', 'UI'],
        ['Juru masak + buku resep', 'Memasak sesuai resep dan aturan dapur', 'Entitas, aturan bisnis, use case', 'Domain'],
        ['Gudang dan pemasok', 'Menyediakan bahan, dari pasar mana pun', 'Layanan, model API, repository', 'Data'],
        ['Daftar belanja baku', 'Bahan yang dibutuhkan, tanpa menyebut pasarnya', 'Kontrak (abstract class)', 'Domain'],
      ],
      ukuran: 15,
      tinggiBaris: 0.82,
      pesan: 'Pemasok sayur diganti, RESEPNYA TIDAK BERUBAH. Bagian terpenting dilindungi dari bagian yang paling sering berganti.',
      catatan: 'Pelayan tidak masuk gudang. Juru masak tidak menelepon pemasok; ia cukup menulis daftar belanja. Inilah inti Clean Architecture: aturan bisnis (resep) dilindungi dari pemasok, server, database, bahkan tampilan.',
    });

    d.lapisan({
      judul: 'Lingkaran dan Aturan Ketergantungan',
      lapisan: [
        { ikon: 'perkakas', judul: 'Kerangka dan perangkat', isi: 'Flutter, http, sqflite, server', warna: C.text2 },
        { ikon: 'tautan', judul: 'Penghubung', isi: 'View, ViewModel, repository, model API', warna: C.accent6 },
        { ikon: 'tugas', judul: 'Use case', isi: 'AjukanPeminjaman', warna: C.accent4 },
        { ikon: 'buku', judul: 'Entitas dan aturan bisnis', isi: 'Ruang, Peminjaman, periksaPengajuan()', warna: C.accent1 },
      ],
      keterangan: [
        '"Source code dependencies can only point inwards." (Robert C. Martin)',
        'Lingkaran dalam TIDAK BOLEH menyebut apa pun dari lingkaran luar.',
        'Semakin ke dalam: semakin penting dan semakin jarang berubah.',
        'ViewModel boleh memakai Ruang; Ruang tidak boleh mengenal ViewModel.',
      ],
      catatan: 'Gambar ini dibaca dari luar ke dalam; panah menunjuk arah ketergantungan yang diizinkan. Berkas berisi Ruang dan periksaPengajuan() tidak boleh mengimpor flutter, http, sqflite, provider, atau class ViewModel. Mengapa ke dalam? Karena yang di luar paling sering berganti: Flutter merilis versi baru, server pindah, database diganti. Jika aturan bisnis bergantung pada hal-hal itu, setiap pergantian ikut merusak aturan bisnis.',
    });

    d.tabel({
      judul: 'Versi Flutter: Tiga Lapisan',
      kepala: ['Lapisan', 'Isinya', 'Contoh di "Pinjam Ruang Kampus"', 'Boleh mengimpor'],
      lebarKolom: [1.5, 3.6, 3.9, 2.6],
      baris: [
        ['UI', 'View (widget) dan ViewModel', 'HalamanJadwalRuang, JadwalRuangViewModel', 'Domain, Flutter, provider'],
        ['Domain', 'Entitas, aturan bisnis, kontrak, use case, Hasil', 'Ruang, periksaPengajuan(), RepositoriRuang, AjukanPeminjaman', 'Hanya Dart dan domain itu sendiri'],
        ['Data', 'Layanan, model API, implementasi repository', 'LayananApiKampus, RuangApiModel, RepositoriRuangServer', 'Domain, http, sqflite, shared_preferences'],
      ],
      ukuran: 15,
      tinggiBaris: 1.0,
      pesan: 'UI menunjuk ke domain, dan data JUGA menunjuk ke domain. Tidak ada panah dari domain ke luar. Lapisan domain disebut opsional: dipakai jika aplikasinya membutuhkan.',
      catatan: 'Panduan resmi Flutter berulang kali menegaskan bahwa rekomendasinya adalah pedoman, bukan aturan mati. Modul ini sengaja memperlihatkan versi lengkap agar mahasiswa mengenal setiap bagian; Bagian 12 membahas kapan sebuah bagian layak dipakai.',
    });

    d.banding({
      judul: 'Membalik Arah Ketergantungan',
      kolom: [
        {
          ikon: 'peringatan', judul: 'Tanpa kontrak', warna: C.accent5, tag: 'ViewModel → RepositoriRuangServer → http',
          poin: [
            'ViewModel terikat pada server',
            'Tidak bisa diuji tanpa internet',
            'Server diganti = ViewModel ikut diubah',
          ],
          contoh: 'class DaftarRuangViewModel {\n  final _repo = RepositoriRuangServer(...);\n}',
        },
        {
          ikon: 'centang', judul: 'Dengan kontrak milik domain', warna: C.accent4, tag: 'Keduanya bergantung pada KONTRAK', sorot: true,
          poin: [
            'ViewModel → RepositoriRuang (kontrak, domain)',
            'RepositoriRuangServer (data) implements kontrak itu',
            'Implementasi bisa ditukar: palsu ⇄ server ⇄ SQLite',
          ],
          contoh: 'abstract class RepositoriRuang {\n  Future<List<Ruang>> semuaRuang();\n}',
        },
      ],
      ukuranPoin: 16,
      ukuranContoh: 13,
      pesan: 'Dependency Inversion Principle (huruf D dalam SOLID). Seperti stop kontak: bentuknya ditentukan rumah (domain), setrika merek apa pun (lapisan data) menyesuaikan.',
      catatan: 'Di Pertemuan 9–11 kita sudah memakai kontrak, tetapi kontrak itu disimpan di folder data/. Hari ini kontrak dipindahkan ke domain, dan arah panahnya berbalik: lapisan data kini bergantung pada domain, bukan sebaliknya.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 3', judul: 'Lapisan Domain: Entitas dan Aturan Bisnis', ikon: 'buku', catatan: 'Lapisan domain adalah "buku resep" aplikasi. Contoh 02 menulisnya tanpa Flutter, tanpa internet, dan tanpa database.' });

    d.kode({
      judul: 'Entitas dan Objek Nilai',
      berkas: 'kode/contoh_02_domain_dart_murni.dart',
      kode: [
        'class RentangWaktu {',
        '  const RentangWaktu({required this.mulai, required this.selesai});',
        '  final DateTime mulai;',
        '  final DateTime selesai;',
        '',
        '  Duration get durasi => selesai.difference(mulai);',
        '',
        '  // Objek tidak diubah; yang dibuat adalah objek BARU.',
        '  RentangWaktu geser(Duration selisih) => RentangWaktu(',
        '      mulai: mulai.add(selisih), selesai: selesai.add(selisih));',
        '',
        '  bool bertumpukDengan(RentangWaktu lain) =>',
        '      mulai.isBefore(lain.selesai) && lain.mulai.isBefore(selesai);',
        '',
        '  @override',
        '  bool operator ==(Object other) => other is RentangWaktu &&',
        '      other.mulai == mulai && other.selesai == selesai;',
        '  @override',
        '  int get hashCode => Object.hash(mulai, selesai);',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.6,
      poin: [
        'Entitas: punya jati diri (Ruang dikenali dari kodenya).',
        'Objek nilai: dikenali dari ISINYA. Dua rentang 09.00–11.00 adalah rentang yang sama.',
        'Semua field final (immutable): "mengubah" = membuat objek baru.',
        '09.00–11.00 dan 11.00–13.00 bersambung, TIDAK bertumpuk.',
        'Tanpa ==, Dart membandingkan alamat memori.',
      ],
      catatan: 'Kode di slide dirapatkan (geser dan bertumpukDengan ditulis dengan =>); di berkas aslinya memakai blok return. hashCode wajib ditulis bersama ==, agar objek bekerja benar di Set dan sebagai kunci Map. Object.hash menggabungkan nilai-nilai field.',
    });

    d.kode({
      judul: 'Aturan Bisnis sebagai Fungsi Biasa',
      berkas: 'kode/contoh_02_domain_dart_murni.dart',
      kode: [
        'const int jamBuka = 7; // 07.00',
        'const int jamTutup = 21; // 21.00',
        'const Duration durasiMaksimal = Duration(hours: 3);',
        '',
        '// Alasan penolakan, atau null jika pengajuan wajar.',
        'String? periksaPengajuan(',
        '  PengajuanPeminjaman pengajuan, {',
        '  required Ruang ruang,',
        '  required DateTime sekarang,',
        '}) {',
        '  if (pengajuan.keperluan.trim().isEmpty) {',
        "    return 'Keperluan wajib diisi.';",
        '  }',
        '  if (pengajuan.jumlahPeserta > ruang.kapasitas) {',
        "    return 'Peserta (...) melebihi kapasitas ...';",
        '  }',
        '  // ... durasi, Senin–Jumat, jam buka dan tutup ...',
        '  if (!pengajuan.waktu.mulai.isAfter(sekarang)) {',
        "    return 'Waktu mulai sudah lewat. ...';",
        '  }',
        '  return null;',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.4,
      poin: [
        'Kebijakan KAMPUS, bukan urusan tampilan.',
        'Angka kebijakan = konstanta bernama: jam tutup berubah, cukup satu baris.',
        'Mengembalikan alasan → mudah ditampilkan dan diuji.',
        'Tidak mengimpor apa pun: bisa dijalankan dengan dart run.',
      ],
      catatan: 'Aturan lengkapnya: keperluan tidak boleh kosong (spasi saja dianggap kosong); peserta 1 orang sampai kapasitas ruang; lama 30 menit sampai 3 jam; hanya Senin–Jumat pukul 07.00–21.00; tidak boleh di masa lalu. Di slide, isi pesan dipersingkat dengan "...".',
    });

    d.kode({
      judul: 'Waktu "Sekarang" sebagai Parameter',
      berkas: 'kode/contoh_02_domain_dart_murni.dart',
      kode: [
        '=== 2. Aturan bisnis ===',
        '"Diskusi kelompok" 13.00-14.30 -> LOLOS',
        '"Rapat angkatan" 13.00-14.00 -> Peserta (30) melebihi',
        '    kapasitas Ruang Diskusi C.110 (12 orang).',
        '"Belajar bersama" 09.00-10.00 -> Ruang hanya bisa',
        '    dipinjam Senin sampai Jumat.',
        '"   " 09.00-10.00 -> Keperluan wajib diisi.',
        '',
        '=== 3. Jam disuntikkan ===',
        'Diperiksa 16/10 pukul 10.00 -> LOLOS',
        'Diperiksa 19/10 pukul 14.00 -> Waktu mulai sudah',
        '    lewat. Pilih jam yang akan datang.',
      ].join('\n'),
      shell: true,
      ukuran: 13,
      lebarKode: 7.4,
      poin: [
        'Fungsi TIDAK memanggil DateTime.now() sendiri.',
        'Aplikasi: "sekarang" = jam sungguhan.',
        'Pemeriksaan: jam tetap (Jumat 16/10 pukul 10.00) → hasil selalu sama, dijalankan hari apa pun.',
        'Inilah dependency injection paling sederhana: kebutuhan diberikan dari luar.',
      ],
      catatan: 'Keluaran Contoh 02 (sebagian; baris panjang dilipat di slide). Bagian 3 memeriksa pengajuan yang SAMA ("Diskusi kelompok", Senin 19 Oktober pukul 13.00) pada dua "waktu sekarang" berbeda. Diperiksa Jumat pagi: lolos. Diperiksa Senin pukul 14.00: sudah lewat. Tidak perlu menunggu hari Senin untuk membuktikannya. Inilah jawaban MASALAH 4 di Contoh 01.',
    });

    d.tabel({
      judul: 'Ciri Kode Domain yang Sehat',
      kepala: ['Ciri', 'Cara memeriksanya'],
      lebarKolom: [6.4, 5.2],
      baris: [
        ['Tidak mengimpor flutter, http, sqflite, shared_preferences, provider', 'Lihat baris import di folder domain/'],
        ['Bisa dijalankan dengan dart run, tanpa Flutter', 'Contoh 02 adalah buktinya'],
        ['Nama milik aplikasi (kapasitas), bukan nama server (capacity)', 'Nama kolom JSON hanya di lapisan data'],
        ['Field final; perubahan menghasilkan objek baru', 'Tidak ada setter atau field tanpa final'],
        ['Tidak memanggil DateTime.now(), Random(), atau internet', 'Semua yang berubah-ubah diterima sebagai parameter'],
      ],
      ukuran: 15,
      tinggiBaris: 0.7,
      pesan: 'Entitas butuh ikon atau warna? Simpan enum Fasilitas di domain, lalu tentukan ikonnya di lapisan UI: IconData ikonFasilitas(Fasilitas f).',
      catatan: 'IconData dan Color milik Flutter. Jika entitas menyimpannya, domain terpaksa mengimpor Flutter dan tidak lagi bisa dijalankan dengan dart run.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 4', judul: 'Kontrak Repository dan Dependency Injection', ikon: 'tautan', catatan: 'Kontrak hanya menyebut APA yang tersedia. Yang baru hari ini: letaknya di lapisan domain.' });

    d.kode({
      judul: 'Satu Kontrak, Dua Implementasi',
      berkas: 'kode/contoh_03_kontrak_dan_dependency_injection.dart',
      kode: [
        '// domain/repositories/repositori_ruang.dart',
        'abstract class RepositoriRuang {',
        '  Future<List<Ruang>> semuaRuang();',
        '}',
        '',
        '// data/: data palsu, tiga ruang, tanpa internet',
        'class RepositoriRuangMemori implements RepositoriRuang {',
        '  @override',
        '  Future<List<Ruang>> semuaRuang() async {',
        '    await Future<void>.delayed(const Duration(milliseconds: 500));',
        '    return _data;',
        '  }',
        '}',
        '',
        '// data/: server + salinan di memori',
        'class RepositoriRuangServer implements RepositoriRuang {',
        '  RepositoriRuangServer({required this._klien, this.saatMeminta});',
        '  // ... salinan != null ? salinan : ambil dari internet ...',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.6,
      poin: [
        'Kontrak menyebut entitas Ruang dan dipakai ViewModel maupun use case → milik DOMAIN.',
        'Lapisan data cukup "berjanji memenuhinya" lewat implements.',
        'Versi server menyimpan salinan; panggilan kedua tanpa internet.',
        'ViewModel tidak tahu-menahu soal salinan itu.',
      ],
      catatan: 'Kebutuhan khusus implementasi server (klien HTTP dan penghitung saatMeminta) ikut disuntikkan dari luar. ViewModel tidak perlu tahu. Isi data palsu: Lab Komputer 1 (40 orang), Kelas B.204 (45), Diskusi C.110 (12).',
    });

    d.tabel({
      judul: 'Dependency Injection: Bahan Diantar, Bukan Dicari',
      kepala: ['Cara', 'Kode di ViewModel', 'Akibatnya'],
      lebarKolom: [2.2, 5.6, 3.8],
      baris: [
        ['Membuat sendiri', kodeKecil('final _repo = RepositoriRuangServer(...);'), '❌ Terikat pada server; tidak bisa diuji tanpa internet'],
        ['Variabel global', kodeKecil('final _repo = repositoriGlobal;'), '❌ Objek tersembunyi yang dibagi bersama; sulit diganti saat pengujian'],
        ['Menerima dari luar', kodeKecil('DaftarRuangViewModel({required this._repositori})'), '✅ Hanya mengenal kontrak; implementasi bisa ditukar'],
      ],
      ukuran: 15,
      tinggiBaris: 0.95,
      pesan: 'Dari luar, parameternya ditulis TANPA garis bawah: DaftarRuangViewModel(repositori: ...). Juru masak tidak ke pasar; bahan diantar ke dapurnya.',
      catatan: 'Cara ketiga disebut dependency injection (DI): kebutuhan sebuah objek disuntikkan dari luar, biasanya lewat constructor. Parameter required this._repositori (bernama, berawalan garis bawah) mengisi field privat _repositori. Karena field-nya privat, View tidak bisa memanggil repository secara langsung lewat ViewModel.',
    });

    d.layar({
      judul: 'Akar Komposisi: Satu Tempat yang Memilih',
      gambar: ['hasil_contoh_03a.jpg', 'hasil_contoh_03b.jpg'],
      lebarMaks: 5.6,
      berkas: 'kode/contoh_03_kontrak_dan_dependency_injection.dart',
      kode: [
        'Provider<RepositoriRuang>.value(',
        '  key: ValueKey(_sumber),',
        '  value: _repositori, // memori atau server',
        '  child: ChangeNotifierProvider(',
        '    create: (BuildContext context) =>',
        '        DaftarRuangViewModel(',
        '          repositori:',
        '              context.read<RepositoriRuang>(),',
        '        )..muat(),',
        '    child: const TampilanDaftarRuang(),',
        '  ),',
        ')',
      ].join('\n'),
      ukuranKode: 11,
      poin: [
        'Jenis yang dititipkan = KONTRAK.',
        'Server → angka 1. Palsu → Server lagi: tetap 1 (salinan).',
      ],
      ukuranPoin: 14,
      catatan: 'Akar komposisi (composition root): satu-satunya tempat yang membuat implementasi. Di aplikasi biasa: main() dengan MultiProvider. Contoh 03 memakai sebuah widget agar sumbernya bisa ditukar saat aplikasi berjalan. Provider.value untuk objek yang sudah ada (dibuat dengan late final). key: ValueKey(_sumber): saat sumber berganti, Flutter membuang provider lama beserta ViewModel-nya. Yang patut diperhatikan: DaftarRuangViewModel dan TampilanDaftarRuang tidak berubah sedikit pun saat sumber ditukar. Kiri: Data palsu, 0 permintaan, tiga ruang. Kanan: Server, 1 permintaan, tujuh ruang.',
    });

    d.kode({
      judul: 'Memilih Implementasi menurut Lingkungan',
      berkas: 'kode/contoh_08_studi_kasus_pinjam_ruang.dart',
      kode: [
        'enum Lingkungan { pengembangan, produksi }',
        '',
        'List<SingleChildWidget> buatPenyedia(Lingkungan lingkungan) {',
        '  return [',
        '    Provider<Pengguna>.value(value: penggunaAktif),',
        '    ...switch (lingkungan) {',
        '      Lingkungan.pengembangan => [',
        '        Provider<RepositoriRuang>(',
        '          create: (context) => RepositoriRuangMemori()),',
        '      ],',
        '      Lingkungan.produksi => [',
        '        Provider<LayananApiKampus>(/* ... + dispose */),',
        '        Provider<RepositoriRuang>(',
        '          create: (context) => RepositoriRuangServer(',
        '              layanan: context.read<LayananApiKampus>())),',
        '      ],',
        '    },',
        '    // ... RepositoriPeminjaman, use case AjukanPeminjaman ...',
        '  ];',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.5,
      poin: [
        'Pengembangan: data palsu (server belum siap, tanpa internet).',
        'Produksi: server dan database sungguhan.',
        '...switch menyisipkan (spread) daftar yang dipilih.',
        'Letaknya: lib/config/dependensi.dart.',
      ],
      catatan: 'SingleChildWidget adalah jenis setiap provider; diimpor dari package:provider/single_child_widget.dart. Di slide, parameter (BuildContext context) disingkat menjadi (context). Di proyek dengan banyak berkas, setiap lingkungan bisa punya titik masuk sendiri (Bagian 10.3).',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 5', judul: 'Model API, Entitas, dan Pemetaan', ikon: 'pindah', catatan: 'Server dan aplikasi sering berbicara dalam bahasa yang berbeda. Lapisan data bertugas sebagai penerjemah.' });

    d.banding({
      judul: 'Dua Bahasa yang Berbeda',
      kolom: [
        {
          ikon: 'server', judul: 'Bahasa server', warna: C.accent6, tag: 'data/ruang_kampus.json',
          poin: [
            'Nama kolom Inggris: room_code, capacity',
            'Kode fasilitas berupa teks',
            'Kolom teknis is_active',
          ],
          contoh: '{"room_code": "AULA",\n "capacity": 200,\n "facilities": ["projector", "stage"],\n "is_active": true}',
        },
        {
          ikon: 'hp', judul: 'Bahasa aplikasi', warna: C.accent4, tag: 'Entitas di domain', sorot: true,
          poin: [
            'Nama milik aplikasi: kode, kapasitas',
            'enum Fasilitas dengan label ramah ("AC")',
            'Ruang tidak aktif: cukup tidak ditampilkan',
            'Fasilitas yang belum dikenal (stage): dilewati',
          ],
          contoh: 'Ruang(kode: \'AULA\', kapasitas: 200,\n  fasilitas: [Fasilitas.proyektor])',
        },
      ],
      ukuranPoin: 16,
      ukuranContoh: 13,
      catatan: 'Contoh 04 memperlihatkan penerjemahan dalam dua langkah: JSON menjadi model API, lalu model API menjadi entitas. Di slide, baris JSON dipersingkat (room_name, building, dan floor tidak ditampilkan).',
    });

    d.kode({
      judul: 'Langkah 1: JSON Menjadi Model API',
      berkas: 'kode/contoh_04_model_api_dan_pemetaan.dart',
      kode: [
        'class RuangApiModel { // bentuknya MENGIKUTI SERVER',
        '  factory RuangApiModel.fromJson(Object? json) {',
        '    return switch (json) {',
        '      {',
        "        'room_code': final String roomCode,",
        "        'room_name': final String roomName,",
        "        'building': final String building,",
        "        'floor': final int floor,",
        "        'capacity': final int capacity,",
        "        'facilities': final List<Object?> facilities,",
        "        'is_active': final bool isActive,",
        '      } =>',
        '        RuangApiModel(roomCode: roomCode, /* ... */),',
        "      _ => throw const FormatException('Data ruang tidak sesuai'),",
        '    };',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.6,
      poin: [
        'Model API (DTO) tinggal di lapisan data: lib/data/models/.',
        'Cabang pertama dipilih hanya jika SEMUA kunci ada dan tipenya cocok.',
        'capacity berisi "empat puluh"? FormatException dilempar di lapisan DATA, bukan di tengah tampilan.',
      ],
      catatan: 'Pola map ini sudah dikenal dari Pertemuan 10. DTO = data transfer object. Di berkas aslinya, constructor RuangApiModel ditulis lengkap dan facilities diubah dengan whereType<String>().toList().',
    });

    d.kode({
      judul: 'Langkah 2: Model API Menjadi Entitas',
      berkas: 'kode/contoh_04_model_api_dan_pemetaan.dart',
      kode: [
        'const Map<String, Fasilitas> petaFasilitas = {',
        "  'projector': Fasilitas.proyektor,",
        "  'air_conditioner': Fasilitas.pendinginRuangan,",
        "  'computer': Fasilitas.komputer,",
        '  // ...',
        '};',
        '',
        '// Di dalam class RuangApiModel:',
        'Ruang keDomain() {',
        '  return Ruang(',
        '    kode: roomCode,',
        '    nama: roomName,',
        "    gedung: 'Gedung $building',",
        '    lantai: floor,',
        '    kapasitas: capacity,',
        '    fasilitas: [for (final String f in facilities) ?petaFasilitas[f]],',
        '  );',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.6,
      poin: [
        'keDomain() (sering juga toDomain() atau toEntity()).',
        '?petaFasilitas[f]: elemen null-aware (Dart 3.8), masuk daftar hanya jika tidak null → "stage" dilewati.',
        'Teks tampilan disusun SEKALI di sini.',
        'Ruang tidak aktif disaring: if (m.isActive) m.keDomain().',
      ],
      catatan: 'Membaca Map dengan kunci yang tidak ada menghasilkan null, bukan exception. Elemen null-aware ? menghindari if (x != null) x yang ditulis berulang. Penyaringan ruang aktif dilakukan oleh repository (atau, di Contoh 04, oleh kode yang memanggil keDomain()).',
    });

    d.kode({
      judul: 'Saat Server Berganti Versi',
      berkas: 'kode/contoh_04_model_api_dan_pemetaan.dart',
      kode: [
        '// Server versi 2: nama dan bentuk kolom berubah total',
        '{"code": "LAB-1", "name": "Laboratorium Komputer 1",',
        ' "location": {"building": "B", "floor": 2}, "seats": 40,',
        ' "amenities": ["projector", "air_conditioner", "computer"],',
        ' "status": "active"}',
        '',
        '=== 3. Server versi 2 mengganti nama kolom ===',
        'LAB-1 | Laboratorium Komputer 1 | Gedung B, lantai 2',
        '      | 40 orang | Proyektor, AC, Komputer',
        'Entitas dari versi 1 dan versi 2 sama: true',
      ].join('\n'),
      shell: true,
      ukuran: 13,
      lebarKode: 7.6,
      poin: [
        'Yang dibuat hanya SATU model API baru (RuangApiModelV2) + keDomain()-nya.',
        'Entitas, aturan bisnis, ViewModel, dan semua widget TIDAK berubah.',
        'Arah sebaliknya (POST): pengajuanKeJson() juga di lapisan data.',
      ],
      catatan: 'Keluaran Contoh 04 bagian 3 (baris pertama dilipat di slide). Bagian 4 keluaran yang sama mencetak JSON untuk dikirim: {"room_code":"C-105","purpose":"Seminar Proposal","participants":60,...}. Bagian 5: kapasitas berupa teks → FormatException: Data ruang tidak sesuai.',
    });

    d.tabel({
      judul: 'Jadi, fromJson Diletakkan di Mana?',
      kepala: ['Situasi', 'Pilihan yang disarankan'],
      lebarKolom: [6.2, 5.4],
      baris: [
        ['Aplikasi kecil, JSON hampir sama dengan kebutuhan tampilan, satu sumber data', 'fromJson di class Model (Pertemuan 10)'],
        ['Model ingin bersih dari JSON, bentuk datanya sederhana', 'Fungsi pengubah di repository (_dariJson, _dariBaris)'],
        ['Nama kolom berbeda bahasa, kolom teknis, kode yang perlu diterjemahkan, server berganti versi', 'Model API terpisah + keDomain()'],
        ['Satu entitas dari dua sumber (server dan SQLite)', 'Satu entitas; setiap sumber punya pemetaannya sendiri'],
      ],
      ukuran: 15,
      tinggiBaris: 0.85,
      pesan: 'Ketiganya benar. Panduan Flutter menyebut pemisahan model API sebagai rekomendasi BERSYARAT: berguna untuk aplikasi besar, menambah kode untuk aplikasi kecil.',
      catatan: 'Dalam Clean Architecture yang ketat, entitas tidak pernah berisi fromJson maupun toJson, karena JSON adalah urusan lapisan luar.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 6', judul: 'Hasil dan Kegagalan: Galat yang Menyeberangi Lapisan', ikon: 'galat', catatan: 'Bagaimana kegagalan dari internet sampai ke layar tanpa membuat tampilan ikut mengenal urusan HTTP?' });

    d.banding({
      judul: 'Masalahnya: Exception yang "Bocor"',
      kolom: [
        {
          ikon: 'awanputus', judul: 'UI ikut mengenal HTTP', warna: C.accent5,
          poin: [
            'ViewModel dan berkas pesan mengimpor package:http hanya untuk mengenali ClientException',
            'Repository diganti SQLite → daftar exception berubah → UI ikut diubah',
          ],
        },
        {
          ikon: 'peringatan', judul: 'Kegagalan tidak terlihat', warna: C.accent5,
          poin: [
            'Future<List<Ruang>> semuaRuang() tidak berkata "saya bisa gagal"',
            'Lupa satu try–catch → layar merah',
          ],
        },
      ],
      ukuranPoin: 18,
      pesan: 'Jawabannya: repository mengembalikan Hasil<T> berisi nilai ATAU Kegagalan milik aplikasi.',
      catatan: 'Di Pertemuan 10, ViewModel menangkap exception sendiri, lalu fungsi pesanRamah menerjemahkan ClientException, TimeoutException, dan FormatException menjadi kalimat. Cara itu berjalan, tetapi menyisakan dua masalah ini.',
    });

    d.kode({
      judul: 'Hasil<T> dan Kegagalan',
      berkas: 'kode/contoh_05_hasil_dan_kegagalan.dart',
      kode: [
        'sealed class Hasil<T> { const Hasil(); }',
        '',
        'final class Berhasil<T> extends Hasil<T> {',
        '  const Berhasil(this.nilai);',
        '  final T nilai;',
        '}',
        'final class Gagal<T> extends Hasil<T> {',
        '  const Gagal(this.kegagalan);',
        '  final Kegagalan kegagalan;',
        '}',
        '',
        '// Bahasa kegagalan milik aplikasi, bebas istilah HTTP.',
        'sealed class Kegagalan { const Kegagalan(); }',
        'final class TanpaKoneksi extends Kegagalan { ... }',
        'final class WaktuHabis extends Kegagalan { ... }',
        'final class ServerBermasalah extends Kegagalan {',
        '  const ServerBermasalah(this.kodeStatus);',
        '  final int kodeStatus;',
        '}',
        'final class DataRusak extends Kegagalan { ... }',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.4,
      poin: [
        'Future<Hasil<List<Ruang>>>: tanda tangan yang JUJUR.',
        'Seperti amplop hasil laboratorium: isinya normal atau catatan masalah, dan wajib dibuka.',
        'sealed → switch wajib menangani semua kemungkinan.',
        'Studi kasus menambah AturanDilanggar(alasan).',
      ],
      catatan: 'Gagasan yang sama sudah dikenal dari Pertemuan 3 (pengayaan): sealed class HasilMuat dengan Berhasil dan Gagal. Panduan resmi Flutter menamai pola ini Result (Ok dan Error). Di slide, constructor const ditulis ringkas; di berkas aslinya setiap class ditulis lengkap.',
    });

    d.tabel({
      judul: 'Dari Exception Menjadi Kalimat',
      kepala: ['Exception teknis (data)', 'Kegagalan (domain)', 'Kalimat untuk pengguna (UI)'],
      lebarKolom: [3.3, 3.3, 5.0],
      baris: [
        [kode('http.ClientException'), kode('TanpaKoneksi()'), 'Tidak dapat terhubung. Periksa koneksi internet Anda.'],
        [kode('TimeoutException'), kode('WaktuHabis()'), 'Server terlalu lama menjawab. Coba lagi sebentar lagi.'],
        [kode('ApiException(500)'), kode('ServerBermasalah(500)'), 'Server sedang bermasalah (kode 500). Coba lagi nanti.'],
        [kode('FormatException'), kode('DataRusak()'), 'Data dari server tidak bisa dibaca.'],
        ['— (aturan bisnis)', kode('AturanDilanggar(alasan)'), 'Isi alasan, misalnya "Bentrok dengan ..."'],
      ],
      ukuran: 15,
      tinggiBaris: 0.72,
      catatan: 'Tiga lapisan, tiga bahasa: lapisan data berbicara exception, domain berbicara Kegagalan, UI berbicara kalimat. Penerjemahan dari exception ke Kegagalan terjadi sekali, di repository (slide berikutnya).',
    });

    d.kode({
      judul: 'Repository: Satu-satunya Penerjemah',
      berkas: 'kode/contoh_08_studi_kasus_pinjam_ruang.dart',
      kode: [
        '@override',
        'Future<Hasil<List<Ruang>>> semuaRuang() async {',
        '  try {',
        '    final Object? json = await _layanan.ambilDataRuang();',
        '    final List<Ruang> daftar = switch (json) {',
        "      {'rooms': final List<Object?> rooms} => [",
        '        for (final Object? baris in rooms) _bacaRuang(baris),',
        '      ],',
        "      _ => throw const FormatException('Kolom rooms ...'),",
        '    };',
        '    return Berhasil(daftar);',
        '  } on TimeoutException {',
        '    return const Gagal(WaktuHabis());',
        '  } on http.ClientException {',
        '    return const Gagal(TanpaKoneksi());',
        '  } on ApiException catch (galat) {',
        '    return Gagal(ServerBermasalah(galat.kodeStatus));',
        '  } on FormatException {',
        '    return const Gagal(DataRusak());',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.4,
      poin: [
        'Layanan boleh melempar exception; tidak ada yang lolos ke luar repository.',
        'on X: hanya jenis itu. Urutan on menentukan cabang yang dicoba lebih dulu.',
        'Tidak ada catch (e) umum, DISENGAJA: exception lain = bug di kode kita, dan bug harus terlihat.',
      ],
      catatan: 'on ApiException catch (galat) menangkap sekaligus menamai objeknya, agar kodeStatus-nya bisa dibawa. Nilai yang tidak membawa data boleh const. Jika catch (e) umum dipakai, salah indeks pun tampil sebagai "tanpa koneksi": pengguna disuruh memeriksa internet, dan pengembang tidak pernah tahu ada bug.',
    });

    d.kode({
      judul: 'ViewModel dan View Membaca Hasil',
      berkas: 'kode/contoh_05_hasil_dan_kegagalan.dart',
      kode: [
        '// ViewModel: tanpa try-catch, tanpa import http',
        'final Hasil<List<Ruang>> hasil = await _repositori.semuaRuang();',
        '',
        '// UI: SATU tempat untuk kalimat. switch wajib lengkap.',
        'String pesanKegagalan(Kegagalan kegagalan) {',
        '  return switch (kegagalan) {',
        "    TanpaKoneksi() => 'Tidak dapat terhubung. ...',",
        "    WaktuHabis() => 'Server terlalu lama menjawab. ...',",
        '    ServerBermasalah(:final int kodeStatus) =>',
        "      'Server sedang bermasalah (kode $kodeStatus). ...',",
        "    DataRusak() => 'Data dari server tidak bisa dibaca.',",
        '  };',
        '}',
        '',
        '// View: membuka Hasil dengan pola objek',
        '...switch (hasil) {',
        '  Berhasil(:final List<Ruang> nilai) => [ /* daftar */ ],',
        '  Gagal(:final Kegagalan kegagalan) => [',
        '    Text(pesanKegagalan(kegagalan)), /* tombol Coba lagi */',
        '  ],',
        '},',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.6,
      poin: [
        'Kalimat = urusan tampilan: versi bahasa Inggris cukup mengubah UI.',
        'Kegagalan baru (misalnya TidakBerwenang)? Analyzer langsung menandai switch yang tidak lengkap.',
        ':final nilai → nama variabel sama dengan nama field.',
      ],
      catatan: 'Berhasil(:final List<Ruang> nilai) dibaca: "jika hasil adalah Berhasil, ambil isi field nilai-nya dan beri nama nilai". Pesannya jika switch tidak lengkap: The type \'Kegagalan\' isn\'t exhaustively matched by the switch cases since it doesn\'t match the pattern \'TidakBerwenang()\'. Galat ini justru melindungi kita.',
    });

    d.layar({
      judul: 'Contoh 05: Lima Skenario Server Palsu',
      gambar: ['hasil_contoh_05a.jpg', 'hasil_contoh_05b.jpg', 'hasil_contoh_05c.jpg'],
      lebarMaks: 8.1,
      berkas: 'kode/contoh_05_hasil_dan_kegagalan.dart',
      poin: [
        'Normal → Berhasil(3 ruang)',
        'Lambat 5 detik (batas 3) → Gagal(WaktuHabis())',
        'Server error → Gagal(ServerBermasalah(500))',
        'Bukan JSON → Gagal(DataRusak())',
        'Tanpa koneksi → Gagal(TanpaKoneksi())',
      ],
      ukuranPoin: 14,
      catatan: 'Contoh 05 memakai MockClient (Pertemuan 10) sebagai server palsu, jadi tidak butuh internet. Pilih chip skenario dan perhatikan kartu "Yang diterima ViewModel". Gambar: Normal, Server error, dan Lambat 5 detik (setelah tiga detik). Alamat servernya, api.kampus.example, memakai akhiran .example yang memang dicadangkan untuk contoh (RFC 2606); permintaannya tidak pernah meninggalkan aplikasi.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 7', judul: 'Use Case: Satu Tindakan, Lengkap dengan Aturannya', ikon: 'tugas', catatan: 'Aturan bentrok dan batas dua peminjaman membutuhkan data dari LUAR pengajuan.' });

    d.tabel({
      judul: 'Kapan Butuh Use Case?',
      pengantar: 'Use case: class kecil di domain yang mewakili SATU tindakan pengguna, lengkap dengan aturannya.',
      kepala: ['Keadaan (panduan resmi Flutter)', 'Di "Pinjam Ruang Kampus"'],
      lebarKolom: [5.8, 5.8],
      baris: [
        ['Menggabungkan data dari BEBERAPA repository', '✔ Ruang (kapasitas) + peminjaman (jadwal dan kuota)'],
        ['Logikanya sangat RUMIT', '✔ Lima langkah pemeriksaan berurutan'],
        ['DIPAKAI ULANG oleh beberapa ViewModel', 'Kelak tombol "ajukan cepat" di halaman lain'],
      ],
      ukuran: 16,
      tinggiBaris: 0.8,
      pesan: 'Tidak satu pun terpenuhi (ViewModel hanya meneruskan repositori.semuaRuang())? Use case tidak diperlukan.',
      catatan: 'Aturan di Bagian 3 cukup dilihat dari pengajuannya sendiri. Dua aturan lain butuh data dari luar: tidak boleh bentrok dengan peminjaman lain di ruang yang sama (butuh jadwal dari RepositoriPeminjaman), dan satu orang paling banyak punya dua peminjaman aktif (butuh daftar peminjaman orang itu). Untuk kapasitas, butuh data ruang dari RepositoriRuang.',
    });

    d.kode({
      judul: 'AjukanPeminjaman Langkah demi Langkah',
      berkas: 'kode/contoh_06_use_case_dan_data_palsu.dart',
      kode: [
        'class AjukanPeminjaman {',
        '  AjukanPeminjaman({required this._ruang, required this._peminjaman,',
        '      DateTime Function()? sekarang})',
        '      : _sekarang = sekarang ?? DateTime.now;',
        '',
        '  Future<Hasil<Peminjaman>> jalankan(',
        '      PengajuanPeminjaman pengajuan, Pengguna peminjam) async {',
        '    // 1. Data ruang (kapasitas)',
        '    final Hasil<List<Ruang>> hasilRuang = await _ruang.semuaRuang();',
        '    // ... Gagal? teruskan. Ruang tidak ada? AturanDilanggar ...',
        '    // 2. Aturan yang cukup dilihat dari pengajuannya',
        '    final String? masalah = periksaPengajuan(',
        '        pengajuan, ruang: ruang, sekarang: _sekarang());',
        '    if (masalah != null) return Gagal(AturanDilanggar(masalah));',
        '    // 3. Tidak bentrok   4. Paling banyak 2 aktif',
        '    // 5. Semua aturan terpenuhi: SIMPAN',
        '    return _peminjaman.simpan(pengajuan, peminjam);',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.8,
      poin: [
        'Yang disuntikkan: FUNGSI jam. DateTime.now tanpa kurung = fungsinya.',
        'Pemeriksaan murah didahulukan.',
        'simpan hanya dipanggil jika SEMUA aturan lolos.',
      ],
      catatan: 'Langkah 1 di berkas aslinya: switch (hasilRuang) { case Gagal(): return Gagal(hasilRuang.kegagalan); case Berhasil(): semuaRuang = hasilRuang.nilai; }. Objek Gagal baru dibuat karena jenisnya berbeda: Gagal<List<Ruang>> diteruskan sebagai Gagal<Peminjaman>. .firstOrNull mencari ruangnya tanpa melempar exception. Langkah 3 memakai lain.waktu.bertumpukDengan(pengajuan.waktu) dan menolak dengan "Bentrok dengan ... pukul ...".',
    });

    d.banding({
      judul: 'Mengapa Tidak Ditulis di ViewModel?',
      kolom: [
        {
          ikon: 'peringatan', judul: 'Di ViewModel', warna: C.accent5,
          poin: [
            'ViewModel butuh dua repository + jam, dan ikut memuat semua aturan',
            'Halaman lain harus menyalin kodenya',
            'Menguji aturan = membuat ViewModel (yang memakai Flutter)',
          ],
        },
        {
          ikon: 'centang', judul: 'Sebagai use case', warna: C.accent4, sorot: true,
          poin: [
            'ViewModel cukup memanggil ajukanPeminjaman.jalankan(...)',
            'Halaman lain cukup memakai use case yang sama',
            'Diuji sebagai Dart murni dengan data palsu',
          ],
        },
      ],
      ukuranPoin: 18,
      pesan: 'Cek cepat: aturan "maksimal dua peminjaman aktif" ditaruh di onPressed tombol Ajukan. Kerugiannya? Hanya bisa diuji dengan menekan tombol, dan cara lain mengajukan harus menyalin aturannya.',
      catatan: 'Cek cepat: seorang teman menaruh pemeriksaan "maksimal dua peminjaman aktif" di onPressed tombol Ajukan. Dua kerugiannya: aturan hanya bisa diuji dengan menekan tombol, dan cara lain untuk mengajukan harus menyalin aturannya (salinan yang terlupa menjadi celah).',
    });

    d.kode({
      judul: 'Menguji dengan Data Palsu dan Mata-mata',
      berkas: 'kode/contoh_06_use_case_dan_data_palsu.dart',
      kode: [
        'class RepositoriRuangPalsu implements RepositoriRuang {',
        '  bool putus = false; // true = pura-pura internet mati',
        '  @override',
        '  Future<Hasil<List<Ruang>>> semuaRuang() async {',
        '    if (putus) return const Gagal(TanpaKoneksi());',
        '    return const Berhasil([ /* C-105, C-110, LAB-1 */ ]);',
        '  }',
        '}',
        '',
        'class RepositoriPeminjamanPalsu implements RepositoriPeminjaman {',
        '  int jumlahSimpan = 0; // MATA-MATA (spy)',
        '  // ... milikRuang, milikPengguna, simpan di memori ...',
        '}',
        '',
        '// jam tetap: Jumat, 16 Oktober 2026 pukul 10.00',
        'DateTime jumatPagi() => DateTime(2026, 10, 16, 10);',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.6,
      poin: [
        'Data palsu (fake): implementasi kontrak yang sederhana, di memori.',
        'Mata-mata (spy): data palsu yang juga MENCATAT apa yang terjadi.',
        'Bukti tak terlihat di layar: pengajuan yang DITOLAK tidak pernah disimpan (jumlahSimpan tetap 0).',
      ],
      catatan: 'Tanpa internet dan tanpa database. Data palsu cepat (semuanya di memori), pasti (isinya kita tentukan), dan bisa pura-pura gagal sesuai kebutuhan. Istilah test double lainnya dibahas di Pertemuan 14.',
    });

    d.kode({
      judul: 'Hasil Contoh 06',
      berkas: 'kode/contoh_06_use_case_dan_data_palsu.dart',
      kode: [
        '=== A. Budi mengajukan peminjaman ===',
        'C-105 Senin 10.00-11.00 -> Ditolak: Bentrok dengan',
        '    "Seminar Proposal Skripsi" pukul 09.00-11.00.',
        'C-105 Senin 11.00-12.00 -> Berhasil: PJ-003 tersimpan',
        'C-110 Senin 13.00-14.00, 20 orang -> Ditolak: Peserta',
        '    (20) melebihi kapasitas Ruang Diskusi C.110 (12 orang).',
        'LAB-1 Senin 08.00-09.00 -> Ditolak: Anda sudah punya',
        '    2 peminjaman aktif. Batalkan salah satu dulu.',
        '',
        '=== B. Pengujian otomatis dengan data palsu ===',
        'LULUS  Bentrok ditolak',
        'LULUS  Pengajuan yang ditolak tidak disimpan',
        'LULUS  Jam bersambung (11.00-12.00) diterima',
        'LULUS  Disimpan tepat satu kali',
        'LULUS  Internet mati -> Gagal(TanpaKoneksi), bukan exception',
        'Ringkasan: 5 dari 5 uji lulus',
      ].join('\n'),
      shell: true,
      ukuran: 12,
      lebarKode: 8.0,
      poin: [
        'Pengajuan LAB-1 sendiri wajar, tetapi Budi sudah punya dua peminjaman aktif (PJ-002 dan PJ-003).',
        'Aturan seperti ini HANYA bisa diperiksa use case: butuh data dari repository.',
      ],
      catatan: 'Jam tetap bagian A: Jumat 16/10 pukul 10.00. Baris panjang dilipat di slide. PJ-002 berasal dari data awal, PJ-003 baru saja berhasil di baris kedua.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 8', judul: 'Perintah (Command): Status Milik Setiap Aksi', ikon: 'tombol', catatan: 'Pengguna yang tidak sabar mengetuk Ajukan tiga kali. Tanpa penjaga, tiga peminjaman tercatat untuk satu niat.' });

    d.kode({
      judul: 'Isi Class Perintah',
      berkas: 'kode/contoh_07_perintah_command.dart',
      kode: [
        'abstract class Perintah<T> extends ChangeNotifier {',
        '  bool _sedangBerjalan = false;',
        '  Hasil<T>? _hasil;',
        '  bool get sedangBerjalan => _sedangBerjalan;',
        '  Hasil<T>? get hasil => _hasil;',
        '',
        '  void bersihkanHasil() { _hasil = null; _kabari(); }',
        '',
        '  Future<void> _jalankan(Future<Hasil<T>> Function() aksi) async {',
        '    if (_sedangBerjalan) return; // PENJAGA',
        '    _sedangBerjalan = true;',
        '    _hasil = null;',
        '    _kabari();',
        '    try {',
        '      _hasil = await aksi();',
        '    } finally { // tetap dijalankan walau aksi melempar',
        '      _sedangBerjalan = false;',
        '      _kabari();',
        '    }',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.6,
      poin: [
        'sedangBerjalan: mematikan tombol dan memutar lingkaran DI TOMBOL ITU SAJA.',
        'Penjaga: ketukan kedua dan ketiga diabaikan.',
        'finally: tombol tidak terkunci selamanya.',
        'bersihkanHasil(): tanggapan (SnackBar) tidak muncul berulang.',
      ],
      catatan: 'Panduan resmi Flutter menganjurkan pola Command: setiap aksi ViewModel dibungkus objek yang menyimpan statusnya sendiri. Di slide dipersingkat: berkas aslinya juga punya getter berhasil dan gagal, penjaga _sudahDibuang di _kabari(), dan dispose(). Perintah extends ChangeNotifier, sehingga bisa didengarkan sendiri, terpisah dari ViewModel-nya.',
    });

    d.kode({
      judul: 'Perintah0, Perintah1, dan ViewModel',
      berkas: 'kode/contoh_07_perintah_command.dart',
      kode: [
        'class Perintah0<T> extends Perintah<T> { // tanpa argumen',
        '  Perintah0(this._aksi);',
        '  final Future<Hasil<T>> Function() _aksi;',
        '  Future<void> jalankan() => _jalankan(_aksi);',
        '}',
        'class Perintah1<T, A> extends Perintah<T> { // satu argumen',
        '  Perintah1(this._aksi);',
        '  final Future<Hasil<T>> Function(A) _aksi;',
        '  Future<void> jalankan(A argumen) =>',
        '      _jalankan(() => _aksi(argumen));',
        '}',
        '',
        'class FormulirViewModel extends ChangeNotifier {',
        '  FormulirViewModel({required this._repositori}) {',
        '    ajukan = Perintah1<String, String>(_kirim);',
        '  }',
        '  late final Perintah1<String, String> ajukan;',
        '  // dispose(): ajukan.dispose() juga!',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.4,
      poin: [
        'Perintah1<Peminjaman, PengajuanPeminjaman>: menerima pengajuan, menghasilkan Hasil<Peminjaman>.',
        'Dua argumen? Bungkus dalam satu objek atau record.',
        'late final: diisi sekali di constructor, karena _kirim butuh this.',
      ],
      catatan: 'Aksi ada yang tanpa argumen (muat) dan ada yang membutuhkan satu argumen (ajukan). Perintah juga ChangeNotifier, jadi wajib di-dispose di dispose() ViewModel.',
    });

    d.kode({
      judul: 'Memakai Perintah di View',
      berkas: 'kode/contoh_07_perintah_command.dart',
      kode: [
        'ListenableBuilder( // hanya tombol ini yang dibangun ulang',
        '  listenable: vm.ajukan,',
        '  builder: (BuildContext context, Widget? child) {',
        '    final bool sibuk = vm.ajukan.sedangBerjalan;',
        '    return FilledButton.icon(',
        '      onPressed: sibuk ? null : () => vm.ajukan.jalankan(...),',
        '      icon: sibuk ? /* lingkaran kecil */ : const Icon(Icons.send),',
        "      label: Text(sibuk ? 'Menyimpan...' : 'Ajukan'),",
        '    );',
        '  },',
        '),',
        '',
        '// SnackBar: lewat LISTENER, sekali jalan',
        'void _saatAjukanBerubah() {',
        '  final Hasil<String>? hasil = _vm.ajukan.hasil;',
        '  if (hasil == null) return; // belum selesai / sudah ditanggapi',
        '  _vm.ajukan.bersihkanHasil();',
        "  _tampilkan('B', hasil);",
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.6,
      poin: [
        'onPressed null = tombol mati (abu-abu).',
        'Listener dipasang di initState, DILEPAS di dispose.',
        'JANGAN menampilkan SnackBar dari build(): build() bisa dipanggil berkali-kali.',
      ],
      catatan: 'Di slide, ikon lingkaran dipersingkat; di berkas aslinya: SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)). Listener: _vm.ajukan.addListener(_saatAjukanBerubah) di initState dan removeListener di dispose.',
    });

    d.layar({
      judul: 'Contoh 07: Tanpa dan dengan Perintah',
      gambar: ['hasil_contoh_07a.jpg', 'hasil_contoh_07b.jpg'],
      lebarMaks: 6.4,
      berkas: 'kode/contoh_07_perintah_command.dart',
      poin: [
        'Setiap tombol diketuk tiga kali dengan cepat (server palsu butuh 2 detik).',
        'Kartu A (tanpa Perintah): 3 terkirim, tombol tetap aktif, SnackBar tiga kali.',
        'Kartu B (dengan Perintah): 1 terkirim, abu-abu "Menyimpan...", SnackBar sekali.',
        'Angka 4 = 3 (kartu A) + 1 (kartu B).',
      ],
      ukuranPoin: 16,
      catatan: 'Kiri: saat kartu B masih menyimpan. Kanan: keadaan akhir, SnackBar terakhir "Kartu B: PJ-004 tersimpan." Tanda abu-abu hanyalah bantuan untuk mata. Yang benar-benar mencegah pengiriman ganda adalah penjaga if (_sedangBerjalan) return;, yang tetap bekerja walaupun ketukan kedua terjadi sebelum layar sempat digambar ulang. Di aplikasi peminjaman sungguhan, kartu A berarti tiga ruang terpakai untuk satu rapat.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 9–10', judul: 'Menguji Setiap Lapisan dan Menata Folder', ikon: 'uji', catatan: 'Keuntungan terbesar arsitektur berlapis terasa saat menguji.' });

    d.tabel({
      judul: 'Apa yang Diuji di Setiap Lapisan',
      kepala: ['Yang diuji', 'Diganti dengan', 'Contoh pemeriksaan', 'Di modul'],
      lebarKolom: [2.5, 3.0, 4.2, 1.9],
      baris: [
        ['Entitas, aturan bisnis', 'Tidak perlu apa pun', '"Sabtu ditolak"', 'Contoh 02'],
        ['Use case', 'Repository palsu + jam tetap', '"Bentrok ditolak dan tidak disimpan"', 'Contoh 06'],
        ['Repository server', 'Server palsu (MockClient)', '"Kode 500 → ServerBermasalah"', 'Contoh 08'],
        ['ViewModel', 'Repository palsu', '"Jadwal dibaca ulang setelah mengajukan"', 'Contoh 08'],
        ['View (widget)', 'ViewModel dengan data palsu', '"Tombol mati selama menyimpan"', 'Pertemuan 14'],
      ],
      ukuran: 15,
      tinggiBaris: 0.72,
      pesan: 'Data palsu: CEPAT (di memori), PASTI (isinya kita tentukan), dan bisa PURA-PURA GAGAL. Internet sungguhan membuat pengujian rapuh.',
      catatan: 'Pengujian yang memakai database asli bisa merusak data pengguna. Karena semua lapisan hanya mengenal kontrak, internet dan database bisa diganti data palsu. Di DartPad, contoh hari ini memeriksa dirinya sendiri dengan periksa(...) yang mencetak LULUS atau GAGAL. Di proyek sungguhan: folder test/ dan flutter test (Pertemuan 14), dengan data palsu bersama di testing/fakes/.',
    });

    d.kode({
      judul: 'Struktur Folder Lengkap',
      berkas: 'kode/contoh_08_studi_kasus_pinjam_ruang.dart',
      kode: [
        'lib/',
        '├── main.dart, main_pengembangan.dart  ← titik masuk',
        '├── config/dependensi.dart             ← akar komposisi',
        '├── domain/',
        '│   ├── hasil.dart',
        '│   ├── models/        ← entitas, objek nilai, aturan',
        '│   ├── repositories/  ← KONTRAK',
        '│   └── use_cases/     ← satu berkas per tindakan',
        '├── data/',
        '│   ├── services/      ← HTTP, SQLite',
        '│   ├── models/        ← model API + keDomain()',
        '│   └── repositories/  ← IMPLEMENTASI',
        '└── ui/',
        '    ├── core/          ← perintah, pesan_kegagalan, ...',
        '    ├── daftar_ruang/  ← view_models/ + widgets/',
        '    ├── jadwal_ruang/',
        '    └── peminjaman_saya/',
      ].join('\n'),
      shell: true,
      ukuran: 13,
      lebarKode: 7.6,
      poin: [
        'domain/ dan data/: dikelompokkan menurut JENIS.',
        'ui/: dikelompokkan menurut FITUR (halaman).',
        'Studi kasus ditulis satu berkas; setiap bagian berjudul BERKAS: lib/...',
      ],
      catatan: 'Pohon lengkap ada di modul Bagian 10.1, termasuk nama setiap berkas: ruang.dart, rentang_waktu.dart, aturan_peminjaman.dart, repositori_ruang_server.dart, layanan_api_kampus.dart, dan seterusnya.',
    });

    d.tabel({
      judul: 'Siapa Boleh Mengimpor Siapa',
      kepala: ['Berkas di folder', 'Boleh mengimpor', 'TIDAK boleh mengimpor'],
      lebarKolom: [3.0, 4.1, 4.5],
      baris: [
        [kode('domain/'), 'Domain lain, pustaka Dart (dart:async)', 'flutter, provider, http, sqflite, shared_preferences, data/, ui/'],
        [kode('data/'), 'domain/, http, sqflite, shared_preferences', 'ui/, package:flutter/material.dart'],
        [kode('ui/'), 'domain/, Flutter, provider', 'Implementasi di data/ (cukup kontrak di domain/)'],
        [kode('config/, main*.dart'), 'Semuanya', '—'],
      ],
      ukuran: 15,
      tinggiBaris: 0.85,
      pesan: 'Cek cepat di VS Code: Ctrl + Shift + F, cari package:flutter, isi "files to include" dengan lib/domain. Kosong = domain bersih.',
      catatan: 'Pengecualian kecil yang lazim: lapisan data boleh mengimpor package:flutter/foundation.dart hanya untuk debugPrint. Jangan sampai material.dart masuk ke data/ atau domain/. Analyzer tidak menjaga aturan ini (Praktikum 5 Modifikasi 1): yang menjaga adalah tim, lewat kesepakatan folder, code review, dan pencarian rutin.',
    });

    d.kode({
      judul: 'Dua Titik Masuk',
      berkas: 'kode/contoh_08_studi_kasus_pinjam_ruang.dart',
      kode: [
        '// lib/main.dart: aplikasi sungguhan',
        'void main() {',
        '  runApp(MultiProvider(',
        '    providers: buatPenyedia(Lingkungan.produksi),',
        '    child: const AplikasiPinjamRuang(lingkungan: Lingkungan.produksi),',
        '  ));',
        '}',
        '',
        '// lib/main_pengembangan.dart: data palsu + pita "DATA PALSU"',
        '//   ... sama, dengan Lingkungan.pengembangan ...',
        '',
        '# Pilih titik masuk dengan -t (target):',
        'flutter run -d chrome --web-port=8080',
        'flutter run -d chrome --web-port=8080 -t lib/main_pengembangan.dart',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.8,
      poin: [
        'Tidak perlu mengganti satu baris setiap kali.',
        'Studi kasus resmi Flutter ("Compass"): main_development.dart dan main_staging.dart.',
        'Tim bekerja paralel: tampilan dengan data palsu, server disambung orang lain.',
      ],
      catatan: 'Contoh 08 berupa satu berkas, sehingga memakai konstanta const Lingkungan lingkungan = Lingkungan.produksi; di bagian atas. Di proyek sungguhan, dua berkas main lebih praktis. Studi kasus resmi Flutter menaruh kontrak repository di data/repositories/, dan itu juga sah; modul ini memindahkannya ke domain/ karena mengikuti aturan ketergantungan secara ketat. Yang terpenting: konsisten dalam satu proyek.',
    });

    d.tabel({
      judul: 'Pindah dari Struktur Pertemuan 9–11',
      kepala: ['Pertemuan 9–11', 'Hari ini', 'Alasannya'],
      lebarKolom: [3.6, 3.9, 4.1],
      baris: [
        ['Kontrak di data/repositories/', 'Kontrak di domain/repositories/', 'Domain tidak boleh bergantung pada data'],
        ['Repository melempar exception', 'Repository mengembalikan Hasil<T>', 'Kegagalan terlihat; UI bebas dari http'],
        ['fromJson di Model atau repository', 'Bisa di model API (data/models/)', 'Jika JSON jauh berbeda dari kebutuhan'],
        ['MultiProvider di main.dart', 'buatPenyedia() di config/dependensi.dart', 'Satu tempat memilih implementasi'],
        ['bool memuat di ViewModel', 'Perintah (ui/core/perintah.dart)', 'Setiap aksi punya status sendiri'],
        ['—', 'domain/use_cases/ (jika perlu)', 'Logika yang memakai beberapa repository'],
      ],
      ukuran: 15,
      tinggiBaris: 0.74,
      catatan: 'Praktikum 5 Jobsheet melatih perpindahan ini pada proyek "Tugas Kuliahku", tanpa menambah fitur, dengan langkah-langkah aman: commit dulu, pindahkan kontrak, ubah satu repository, lalu ViewModel, lalu akar komposisi.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 11', judul: 'Studi Kasus: Pinjam Ruang Kampus', ikon: 'gedung', catatan: 'Contoh 08 merangkai semua materi hari ini menjadi satu aplikasi peminjaman ruang kampus.' });

    d.tabel({
      judul: 'Fitur dan Aturan',
      kepala: ['Halaman', 'Fitur'],
      lebarKolom: [2.8, 8.8],
      baris: [
        ['Ruang', 'Daftar ruang aktif dari server: gedung, lantai, fasilitas, kapasitas. Saringan: Semua, ≥ 20, ≥ 40, ≥ 80'],
        ['Jadwal ruang', 'Lima hari kerja, jadwal yang sudah terisi, tombol Ajukan peminjaman'],
        ['Lembar pengajuan', 'Keperluan, peserta, jam mulai (07.00–20.00), lama (1, 1½, 2, 3 jam). Penolakan di kartu merah tanpa menutup lembar'],
        ['Peminjaman Saya', 'Peminjaman milik pengguna aktif, jumlah yang masih aktif (dari batas 2), tombol batal'],
      ],
      ukuran: 15,
      tinggiBaris: 0.8,
      pesan: 'Aturan: keperluan wajib; peserta 1 sampai kapasitas; 30 menit sampai 3 jam; Senin–Jumat 07.00–21.00; tidak di masa lalu; tidak bentrok; paling banyak 2 peminjaman aktif.',
      catatan: 'JadwalRuangViewModel memakai use case untuk MENGAJUKAN (karena butuh banyak aturan), tetapi membaca jadwal langsung dari RepositoriPeminjaman (karena hanya membaca, tanpa aturan). Mencampur keduanya seperti ini wajar.',
    });

    d.alur({
      judul: 'Perjalanan Satu Ketukan "Ajukan"',
      langkah: [
        { ikon: 'sentuh', judul: 'LembarPengajuan', isi: 'Hanya mengumpulkan isian, lalu menjalankan Perintah' },
        { ikon: 'tombol', judul: 'Perintah ajukan', isi: 'sedangBerjalan = true: tombol mati', warna: C.accent6 },
        { ikon: 'restoran', judul: 'JadwalRuang ViewModel', isi: 'Meneruskan ke use case bersama pengguna aktif' },
        { ikon: 'tugas', judul: 'AjukanPeminjaman', isi: 'Membaca repository; melanggar aturan → Gagal, lolos → simpan', warna: C.accent4 },
        { ikon: 'ulang', judul: 'Baca ulang', isi: 'Jadwal dibaca ulang; kartu merah, atau lembar ditutup + SnackBar', warna: C.accent3 },
      ],
      catatan: 'Benar atau tidaknya pengajuan diputuskan domain, bukan lembar pengajuan. Setelah berhasil, ViewModel membaca ulang jadwal dari repository (sumber kebenaran), bukan menambahkan sendiri ke daftarnya, sehingga tampilan selalu sama dengan isi repository. Cara ini sama dengan "tulis, lalu baca ulang" di Pertemuan 11. Diagram urutan lengkap ada di modul Bagian 11.3.',
    });

    d.layar({
      judul: 'Contoh 08: Ruang, Jadwal, dan Penolakan',
      gambar: ['hasil_contoh_08a.jpg', 'hasil_contoh_08b.jpg', 'hasil_contoh_08c.jpg'],
      lebarMaks: 8.1,
      berkas: 'kode/contoh_08_studi_kasus_pinjam_ruang.dart',
      poin: [
        'Daftar ruang dengan saringan kapasitas.',
        'Jadwal Ruang Seminar C.105, Senin 19 Okt.',
        'Rapat pukul 09.00 → kartu merah "Bentrok dengan "Seminar Proposal Skripsi" pukul 09.00–11.00."',
      ],
      ukuranPoin: 15,
      catatan: 'Lingkungan produksi: data ruang dari berkas JSON di GitHub. Fasilitas tampil sebagai label ramah (Proyektor · AC · Komputer). Lembar pengajuan tidak ditutup saat ditolak, jadi pengguna cukup mengganti jamnya.',
    });

    d.layar({
      judul: 'Contoh 08: Berhasil, Peminjaman Saya, Data Palsu',
      gambar: ['hasil_contoh_08d.jpg', 'hasil_contoh_08e.jpg', 'hasil_contoh_08f.jpg'],
      lebarMaks: 8.1,
      berkas: 'kode/contoh_08_studi_kasus_pinjam_ruang.dart',
      poin: [
        'Jam diganti 11.00 → "Peminjaman PJ-005 tercatat".',
        'Budi: "2 dari 2 peminjaman aktif" → pengajuan ketiga ditolak.',
        'Lingkungan pengembangan: pita DATA PALSU, saringan ≥ 40.',
      ],
      ukuranPoin: 15,
      catatan: 'Pengajuan ketiga ditolak dengan "Anda sudah punya 2 peminjaman aktif. Batalkan salah satu dulu." Batalkan satu di Peminjaman Saya, lalu coba lagi. Gambar kanan: const Lingkungan lingkungan = Lingkungan.pengembangan; daftar ruang dari RepositoriRuangMemori, tanpa internet. Tidak ada satu baris pun di domain maupun UI yang berubah.',
    });

    d.kode({
      judul: 'Dua Lingkungan dan 23 Pemeriksaan',
      berkas: 'kode/contoh_08_studi_kasus_pinjam_ruang.dart',
      kode: [
        '// Satu-satunya baris yang diubah untuk memakai data palsu',
        'const Lingkungan lingkungan = Lingkungan.produksi;',
        '',
        '// Konsol sebelum aplikasi tampil (sebagian dari 23 baris):',
        '// LULUS  Rentang 09.00-11.00 dan 11.00-12.00 tidak bertumpuk',
        '// LULUS  Sabtu ditolak',
        '// LULUS  Bentrok dengan jadwal lain ditolak',
        '// LULUS  Peminjaman ketiga yang masih aktif ditolak',
        '// LULUS  Fasilitas yang belum dikenal (stage) dilewati',
        '// LULUS  Panggilan kedua memakai salinan memori',
        '// LULUS  Kode 500 -> ServerBermasalah',
        '// LULUS  Tanpa koneksi -> TanpaKoneksi',
        '// LULUS  Jadwal Kamis dibaca ulang setelah mengajukan',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 8.0,
      poin: [
        'Jam tetap: Rabu, 14 Oktober 2026 pukul 10.00.',
        'Empat bagian: domain, use case, repository server (MockClient), ViewModel.',
        'Semua LULUS = lapisannya benar, sebelum satu tombol pun diketuk.',
      ],
      catatan: 'Pita DATA PALSU dipasang di builder MaterialApp: Banner(message: \'DATA PALSU\', location: BannerLocation.topEnd, child: child!) hanya jika lingkungan == Lingkungan.pengembangan. Uji mandiri modul 11.7: jam tutup menjadi 22.00? Cukup satu konstanta di aturan_peminjaman.dart. Server mengganti kolom menjadi code, name, seats? Hanya lapisan data.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 12–14', judul: 'Secukupnya, Kesalahan Umum, dan Proyek Akhir', ikon: 'rambu', catatan: 'Arsitektur adalah alat, bukan tujuan. Setiap lapisan tambahan berarti berkas, nama, dan hal tambahan yang harus dipahami tim.' });

    d.tabel({
      judul: 'Kapan Cukup? (YAGNI)',
      kepala: ['Ukuran aplikasi', 'Yang cukup'],
      lebarKolom: [6.2, 5.4],
      baris: [
        ['Satu halaman, data tetap, untuk belajar atau percobaan', 'StatefulWidget + setState (Pertemuan 5)'],
        ['Beberapa halaman, satu sumber data', 'MVVM + repository (Pertemuan 9–11)'],
        ['Data server DAN perangkat, ada aturan bisnis, dikerjakan beberapa orang', '+ kontrak di domain, Hasil, akar komposisi, dua lingkungan'],
        ['Aturan rumit dari beberapa repository, dipakai ulang', '+ use case'],
      ],
      ukuran: 15,
      tinggiBaris: 0.85,
      pesan: 'YAGNI (You Aren\'t Gonna Need It): jangan membangun sesuatu sebelum benar-benar dibutuhkan.',
      catatan: 'Untuk proyek akhir: MVVM + repository sudah memenuhi syarat. Tambahkan bagian dari hari ini yang benar-benar membantu, misalnya kontrak di domain, Hasil, dan main_pengembangan.dart, terutama jika tim bekerja paralel.',
    });

    d.tabel({
      judul: 'Tanda-tanda Berlebihan',
      kepala: ['Tanda', 'Contohnya', 'Sebaiknya'],
      lebarKolom: [3.8, 4.2, 3.6],
      baris: [
        ['Use case yang hanya meneruskan satu panggilan', 'AmbilSemuaRuang: return _repositori.semuaRuang();', 'ViewModel langsung memakai repository'],
        ['Model API sama persis dengan entitas', 'RuangApiModel dan Ruang punya field dan nama yang sama', 'fromJson di repository sudah cukup'],
        ['Kontrak yang tidak pernah diganti, bahkan untuk pengujian', '—', 'Kontrak berguna untuk pengujian; jika tak pernah diuji, pertimbangkan ulang'],
        ['Folder kosong "untuk nanti"', 'domain/use_cases/ tanpa isi', 'Buat folder saat berkas pertamanya dibutuhkan'],
      ],
      ukuran: 14,
      tinggiBaris: 0.92,
      catatan: 'Modul ini sengaja memperlihatkan versi lengkap agar setiap bagian dikenal. Di proyek sendiri, pilih secukupnya dan jelaskan alasannya.',
    });

    d.tabel({
      judul: 'Kesalahan Umum Pemula',
      kepala: ['Gejala', 'Solusi'],
      lebarKolom: [6.6, 5.0],
      baris: [
        [kode('ProviderNotFoundException ... Provider<RepositoriRuang>'), 'Provider<RepositoriRuang>(create: ...)'],
        ['domain/ mengimpor package:flutter/material.dart', 'enum di domain; ikon/warna di UI'],
        [kode("The method 'fromJson' isn't defined for the type 'Ruang'"), 'RuangApiModel.fromJson(json).keDomain()'],
        [kode("The type 'Kegagalan' isn't exhaustively matched ..."), 'Tambahkan cabangnya: galat ini melindungi Anda'],
        ['Layar merah padahal repository mengembalikan Hasil', 'Setiap jenis exception punya on ...'],
        ['Tombol tetap mengirim dua kali', 'Selalu lewat perintah.jalankan(...)'],
        ['SnackBar muncul berulang-ulang', 'Listener + bersihkanHasil(), bukan build()'],
        ['Pemeriksaan lulus hari ini, gagal besok', 'Suntikkan jam: DateTime Function()'],
      ],
      ukuran: 13,
      tinggiBaris: 0.56,
      catatan: 'Tabel lengkap di modul Bagian 13, termasuk "A ... was used after being disposed" (dispose setiap Perintah dan pakai penjaga _sudahDibuang), "mengganti data palsu ke server harus mengubah banyak berkas" (satu akar komposisi), dan "banyak use case yang isinya hanya satu baris" (kriteria Bagian 7.1).',
    });

    d.kartu({
      judul: 'Laporan Kemajuan Proyek Akhir',
      pengantar: 'Yang dinilai: fitur utama yang sudah berjalan dari ujung ke ujung, bukan kelengkapan arsitektur.',
      kolom: 3,
      item: [
        { ikon: 'centang', judul: 'Daftar periksa', isi: 'Minimal 3 halaman; data API + memuat/gagal; minimal 1 data tersimpan di perangkat; folder MVVM; flutter analyze bersih; setiap anggota punya commit.', warna: C.accent4 },
        { ikon: 'jalankan', judul: 'Demo 3–5 menit', isi: 'Alur utama; struktur lib/ dan lapisan setiap folder; satu aturan bisnis (berkasnya dan cara memeriksanya); rencana sampai Pertemuan 15.' },
        { ikon: 'cabang', judul: 'Menata ulang dengan aman', isi: 'Commit dulu; pindahkan kontrak; satu repository ke Hasil<T>, lalu ViewModel-nya; buat dependensi.dart + main_pengembangan.dart. flutter analyze + commit setiap langkah.', warna: C.accent6 },
      ],
      catatan: 'Pertemuan ini adalah tahap laporan kemajuan proyek akhir (Panduan Proyek Akhir, Bagian 3). Rencana sampai Pertemuan 15 termasuk unit test yang akan dibuat (Pertemuan 14). Praktikum 5 Jobsheet melatih langkah menata ulang ini pada proyek "Tugas Kuliahku".',
    });

    d.tabel({
      judul: 'Memilih Alat yang Tepat',
      kepala: ['Kebutuhan', 'Pakai'],
      lebarKolom: [5.8, 5.8],
      baris: [
        ['Aturan bisnis yang bisa diuji tanpa layar', 'Fungsi dan entitas Dart murni di domain/'],
        ['Sumber data yang bisa ditukar (palsu ⇄ server ⇄ SQLite)', 'Kontrak di domain/repositories/ + implementasi di data/'],
        ['Memilih implementasi menurut lingkungan', 'config/dependensi.dart + main_pengembangan.dart'],
        ['JSON yang bentuknya jauh berbeda dari kebutuhan', 'Model API (data/models/) + keDomain()'],
        ['Kegagalan yang tidak boleh lupa ditangani', 'Hasil<T> dan sealed class Kegagalan'],
        ['Logika yang memakai beberapa repository', 'Use case (domain/use_cases/)'],
        ['Tombol yang tidak boleh mengirim dua kali', 'Perintah (ui/core/perintah.dart)'],
      ],
      ukuran: 15,
      tinggiBaris: 0.62,
      catatan: 'Minta mahasiswa memetakan proyek akhirnya: aturan bisnis apa yang ada, sumber data apa saja (API, perangkat), dan bagian mana yang benar-benar perlu (YAGNI).',
    });

    d.ringkasan({
      poin: [
        'Arsitektur: di mana kode diletakkan, siapa mengenal siapa, bagaimana mengujinya.',
        'Aturan ketergantungan: kode hanya bergantung ke DALAM. Domain = Dart murni.',
        'Kontrak milik domain; implementasi di data; DI lewat constructor; satu akar komposisi.',
        'Model API mengikuti server; entitas mengikuti aplikasi; keDomain() menerjemahkan.',
        'Repository menerjemahkan exception SEKALI menjadi Hasil<T> berisi Kegagalan.',
        'Use case untuk logika yang menggabungkan beberapa repository; jam disuntikkan.',
        'Perintah: status per aksi, penjaga ketukan ganda, tanggapan sekali jalan.',
        'Uji setiap lapisan dengan data palsu. Tambahkan lapisan saat dibutuhkan (YAGNI).',
      ],
      catatan: 'Minta mahasiswa menjelaskan dengan kata-kata sendiri: mengapa ketergantungan harus mengarah ke dalam, dan apa yang berubah di aplikasi jika server mengganti nama kolomnya.',
    });

    d.penutup({
      judul: 'Saatnya Praktik!',
      subjudul: 'Kerjakan Jobsheet Pertemuan 12 (lima praktikum + tugas Koperasi Mahasiswa), lalu uji diri di Latihan. Siapkan demo laporan kemajuan proyek akhir. Pertemuan berikutnya: fitur perangkat dan izin akses.',
      tautan: [
        { teks: 'Jobsheet P12', ikon: 'tugas', url: d.urlBerkas('pertemuan_12_clean_architecture/JOBSHEET.md') },
        { teks: 'Latihan P12', ikon: 'kuis', url: d.urlBerkas('pertemuan_12_clean_architecture/LATIHAN.md') },
        { teks: 'Proyek Akhir', ikon: 'roket', url: d.urlBerkas('panduan/05_proyek_akhir.md') },
      ],
      catatan: 'Praktikum 1: aturan perpustakaan dalam Dart murni (objek nilai Rupiah, denda, jam disuntikkan). Praktikum 2: Direktori Mahasiswa Pertukaran (kontrak, dua implementasi, model API, akar komposisi). Praktikum 3: Hasil dan Kegagalan + MockClient. Praktikum 4: use case PinjamBuku dan Perintah. Praktikum 5: "Tugas Kuliahku" ditata ulang. Tugas mandiri Koperasi Mahasiswa: pesan sekarang, ambil nanti (DummyJSON, kurs rupiah di lapisan data, use case BuatPesanan, Perintah, minimal 12 pemeriksaan). Pertemuan 13: kamera, galeri, dan lokasi hanyalah sumber data baru, cukup dibungkus layanan dan repository.',
    });
  },
};

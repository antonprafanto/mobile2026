// Konten slide Pertemuan 3 — Dart Lanjutan: OOP & Pemrograman Asinkron.
// Teks diambil dari modul bacaan (pertemuan_03_dart_lanjutan/README.md).

const MERAH = 'C62828';

module.exports = {
  nomor: '03',
  folder: 'pertemuan_03_dart_lanjutan',
  namaBerkas: 'PERTEMUAN_03_Dart_Lanjutan',
  topik: 'Dart Lanjutan: OOP & Pemrograman Asinkron',

  bangun(d) {
    const C = d.C;
    const MONO = { bold: true, fontFace: 'Consolas' };
    const KODE = { fontFace: 'Consolas' };

    d.judul({
      judul: 'Dart Lanjutan: OOP & Pemrograman Asinkron',
      subjudul: 'Pertemuan 3  ·  Class, constructor, enkapsulasi, pewarisan, mixin, enum, exception, Future, dan Stream',
      catatan: 'Pertemuan terakhir yang fokus pada Dart murni. Semua contoh tetap bisa dijalankan di DartPad. Mulai Pertemuan 4 kita kembali ke Flutter, dan semua konsep hari ini akan langsung dipakai.',
    });

    d.tujuan({
      pengantar: 'Setelah pertemuan ini, Anda mampu:',
      poin: [
        'Membuat class dengan properti, constructor, dan method',
        'Melindungi data dengan anggota privat, getter, dan setter',
        'Menerapkan pewarisan, override, dan polimorfisme',
        'Memilih antara abstract class, interface, dan mixin',
        'Memakai enum dan menangani error dengan exception',
        'Menulis kode asinkron dengan Future dan Stream',
      ],
      catatan: 'Tekankan bahwa OOP adalah kunci membaca kode Flutter, sedangkan asinkron adalah kunci aplikasi yang tidak membeku saat menunggu data.',
    });

    d.alur({
      judul: 'Peta Materi Hari Ini',
      langkah: [
        { ikon: 'kelas', judul: 'Class & objek', isi: 'Cetakan dan hasil cetakannya' },
        { ikon: 'gembok', judul: 'Constructor & enkapsulasi', isi: 'Membuat objek dan menjaga datanya' },
        { ikon: 'pohon', judul: 'Pewarisan', isi: 'extends, @override, polimorfisme' },
        { ikon: 'puzzle', judul: 'Abstract & mixin', isi: 'Kontrak, interface, dan kemampuan tambahan' },
        { ikon: 'perisai', judul: 'Enum & exception', isi: 'Pilihan pasti dan penanganan error' },
        { ikon: 'aliran', judul: 'Future & Stream', isi: 'Asinkron, lalu studi kasus kantin', warna: C.accent4 },
      ],
      catatan: 'Bagian awal menata kode (OOP). Bagian akhir membuat program tangguh (exception) dan tidak macet saat menunggu (asinkron).',
    });

    const sOop = d.kode({
      judul: 'Flutter Dibangun dengan OOP',
      kode: [
        'class HalamanUtama extends StatelessWidget {',
        '  const HalamanUtama({super.key});',
        '',
        '  @override',
        '  Widget build(BuildContext context) {',
        '    return Scaffold(',
        "      appBar: AppBar(title: const Text('Halo')),",
        "      body: const Center(child: Text('Isi')),",
        '    );',
        '  }',
        '}',
      ].join('\n'),
      poin: [
        'class HalamanUtama: membuat class (cetakan).',
        'extends StatelessWidget: pewarisan, mewarisi kemampuan widget.',
        'const HalamanUtama({super.key}): constructor const dengan parameter bernama.',
        '@override: mengganti method build() milik induk.',
        'Scaffold(appBar: ..., body: ...): membuat objek memakai parameter bernama.',
      ],
      catatan: 'Kode ini sudah mahasiswa lihat di Pertemuan 1. Janjikan bahwa di akhir pertemuan, setiap kata di dalamnya bisa mereka jelaskan sendiri.',
    });
    d.tombol(sOop, {
      x: 0.6, y: 5.09, w: 7.4,
      teks: 'Kode Pertemuan 1  ·  contoh_02_materialapp_dan_scaffold.dart',
      url: d.urlBerkas('pertemuan_01_pengenalan_flutter/kode/contoh_02_materialapp_dan_scaffold.dart'),
    });

    d.bagian({ label: 'BAGIAN 1', judul: 'Class dan Objek', ikon: 'kelas' });

    d.banding({
      judul: 'Class = Cetakan, Objek = Hasil Cetakan',
      tinggiKolom: 4.4,
      ukuranPoin: 16,
      kolom: [
        {
          ikon: 'kelas', judul: 'Class', warna: C.accent1, tag: 'Cetakan atau rancangan',
          poin: ['Menentukan data (properti) dan aksi (method)', 'Nama memakai UpperCamelCase'],
          contoh: 'class Mahasiswa {\n  String nama;\n  void perkenalan() { ... }\n}',
        },
        {
          ikon: 'orang', judul: 'Objek', warna: C.accent6, tag: 'Hasil cetakan (instance)',
          poin: ['Menyimpan datanya sendiri-sendiri', 'Bisa dibuat sebanyak yang dibutuhkan'],
          contoh: "Mahasiswa andi =\n    Mahasiswa('Andi', '2609106001', 1);\nandi.perkenalan();",
        },
      ],
      pesan: 'Satu cetakan kue bisa menghasilkan banyak kue. Menaikkan semester Andi tidak mengubah semester Sari.',
      catatan: 'Analogi cetakan kue berbentuk ikan: cetakannya bukan kue, tetapi menentukan bentuk setiap kue.',
    });

    d.kode({
      judul: 'Anatomi Sebuah Class',
      berkas: 'kode/contoh_01_class_dan_objek.dart',
      kode: [
        'class Mahasiswa {',
        '  // Properti: data milik setiap objek',
        '  String nama;',
        '  String nim;',
        '  int semester;',
        '',
        '  // Constructor: mengisi properti',
        '  Mahasiswa(this.nama, this.nim, this.semester);',
        '',
        '  // Method: aksi yang bisa dilakukan',
        '  void naikSemester() {',
        '    semester++;',
        '  }',
        '}',
        '',
        "Mahasiswa andi = Mahasiswa('Andi', '2609106001', 1);",
        'andi.naikSemester(); // semester Andi: 2',
      ].join('\n'),
      ukuran: 14,
      poin: [
        'Properti (field) adalah data yang dimiliki setiap objek.',
        'Constructor adalah "mesin pencetak": this.nama mengisi properti nama.',
        'Method adalah fungsi di dalam class, dipanggil dengan tanda titik.',
        'Objek dibuat tanpa kata new, dan setiap objek menyimpan datanya sendiri.',
      ],
      catatan: 'Tanyakan: jika budi.naikSemester() dipanggil dua kali dari semester 5, berapa semesternya? (7)',
    });

    d.bagian({ label: 'BAGIAN 2', judul: 'Constructor dan Enkapsulasi', ikon: 'pabrik' });

    d.kode({
      judul: 'Constructor dengan Parameter Bernama',
      berkas: 'kode/contoh_02_constructor.dart',
      kode: [
        'class Buku {',
        '  final String judul;',
        '  final String penulis;',
        '  final int halaman;',
        '',
        '  // Parameter bernama, seperti widget Flutter',
        '  Buku({required this.judul, required this.penulis,',
        '      this.halaman = 100});',
        '',
        '  // Named constructor',
        '  Buku.anonim(String judul)',
        "      : this(judul: judul, penulis: 'Anonim');",
        '}',
        '',
        "Buku(penulis: 'Budi', judul: 'Dasar Dart');",
      ].join('\n'),
      ukuran: 14,
      poin: [
        'Parameter bernama { }: urutan bebas dan maknanya jelas. required berarti wajib diisi.',
        'halaman = 100 adalah nilai bawaan jika tidak diisi.',
        'final: properti hanya diisi sekali, saat objek dibuat.',
        'Named constructor memberi cara lain membuat objek, seperti EdgeInsets.all() dan ListView.builder() di Flutter.',
      ],
      catatan: 'Hubungkan dengan Text(\'Halo\', style: ...) dan Padding(padding: ..., child: ...). Mahasiswa sudah memakai parameter bernama tanpa menyadarinya.',
    });

    const sKtor = d.tabel({
      judul: 'Lima Jenis Constructor',
      kepala: ['Jenis', 'Contoh penulisan', 'Kapan dipakai', 'Di Flutter'],
      lebarKolom: [1.7, 3.3, 3.1, 2.6],
      baris: [
        [{ text: 'Biasa', options: { bold: true } }, { text: 'Mahasiswa(this.nama, ...)', options: KODE }, 'Cara standar, parameter sedikit', '—'],
        [{ text: 'Bernama', options: { bold: true } }, { text: 'Buku({required this.judul})', options: KODE }, 'Parameter banyak, agar mudah dibaca', 'Hampir semua widget'],
        [{ text: 'Named', options: { bold: true } }, { text: "Buku.anonim('...')", options: KODE }, 'Cara lain membuat objek', { text: 'EdgeInsets.all(16)', options: KODE }],
        [{ text: 'const', options: MONO }, { text: 'const Warna(255, 0, 0)', options: KODE }, 'Objek tetap yang tak pernah berubah', { text: "const Text('Halo')", options: KODE }],
        [{ text: 'factory', options: MONO }, { text: "Produk.dariTeks('...')", options: KODE }, 'Perlu mengolah data dulu', 'fromJson (Pertemuan 10)'],
      ],
      ukuran: 16,
      batasBawah: 5.55,
      catatan: 'Dart 3.13 menambah primary constructor: class Titik(final int x, final int y); Kenalkan bentuknya saja. Di mata kuliah ini kita tetap memakai gaya klasik karena paling banyak dijumpai di dokumentasi Flutter.',
    });
    d.tombolKode(sKtor, { x: 0.6, y: 5.85, w: 7.4, berkas: 'kode/contoh_03_constructor_lainnya.dart' });

    d.kode({
      judul: 'const dan factory',
      berkas: 'kode/contoh_03_constructor_lainnya.dart',
      kode: [
        '// const: objek beku, dibuat sekali, dipakai bersama',
        'class Warna {',
        '  final int merah, hijau, biru;',
        '  const Warna(this.merah, this.hijau, this.biru);',
        '}',
        'const Warna a = Warna(255, 0, 0);',
        'const Warna b = Warna(255, 0, 0);',
        'print(identical(a, b)); // true: objek yang SAMA',
        '',
        '// factory: olah data dulu, baru buat objek',
        'factory Produk.dariTeks(String teks) {',
        "  List<String> bagian = teks.split(';');",
        '  return Produk(bagian[0], int.parse(bagian[1]));',
        '}',
      ].join('\n'),
      ukuran: 14,
      poin: [
        'Syarat const: semua properti final. Inilah alasan Flutter menyarankan const Text(...): hemat memori dan tidak perlu dibuat ulang.',
        'identical(a, b) memeriksa apakah a dan b objek yang sama persis di memori.',
        'factory boleh "berpikir dulu": memecah teks atau memeriksa data, lalu return objek.',
        'Pola factory dipakai lagi di Pertemuan 10: fromJson untuk data dari internet.',
      ],
      catatan: 'Tunjukkan bahwa tanpa const, dua objek Warna dengan isi sama adalah dua objek berbeda (identical bernilai false).',
    });

    d.kode({
      judul: 'Enkapsulasi: Seperti Mesin ATM',
      berkas: 'kode/contoh_04_enkapsulasi.dart',
      kode: [
        'class RekeningTabungan {',
        '  int _saldo = 0; // privat: diawali _',
        '',
        '  int get saldo => _saldo; // getter: lihat saja',
        '',
        '  void setor(int jumlah) {',
        '    if (jumlah <= 0) {',
        "      print('Setoran ditolak.');",
        '      return;',
        '    }',
        '    _saldo += jumlah;',
        '  }',
        '}',
        '',
        'rekening.setor(-5000); // ditolak "penjaga"',
        'print(rekening.saldo); // getter, tanpa ()',
      ].join('\n'),
      ukuran: 14,
      poin: [
        'Data penting disembunyikan; perubahannya hanya lewat "pintu resmi" yang memeriksa aturan.',
        'Nama berawalan _ bersifat privat per berkas (library), bukan per class.',
        'Getter = jendela untuk melihat. Setter (set) = pintu masuk yang dijaga validasi.',
        [
          { text: 'Tanpa setter, rekening.saldo = 1000000; ditolak: ' },
          { text: "There isn't a setter named 'saldo'...", options: { color: MERAH, fontFace: 'Consolas', fontSize: 14 } },
        ],
      ],
      catatan: 'Analogi ATM: nasabah tidak bisa membuka brankas. Ingatkan bahwa main() di berkas yang sama masih bisa menyentuh _saldo; perlindungan terasa saat class disimpan di berkas sendiri, seperti di proyek Flutter.',
    });

    d.bagian({ label: 'BAGIAN 3', judul: 'Pewarisan, Abstract, dan Mixin', ikon: 'pohon' });

    d.kode({
      judul: 'Pewarisan: Kucing Adalah Hewan',
      berkas: 'kode/contoh_05_pewarisan.dart',
      kode: [
        'class Hewan {',
        '  final String nama;',
        '  Hewan(this.nama);',
        '',
        '  void bersuara() {',
        "    print('$nama mengeluarkan suara.');",
        '  }',
        '}',
        '',
        'class Kucing extends Hewan {',
        '  Kucing(super.nama); // teruskan ke induk',
        '',
        '  @override',
        '  void bersuara() {',
        "    print('$nama: Meong!');",
        '  }',
        '}',
      ].join('\n'),
      ukuran: 14,
      poin: [
        'extends: mewarisi semua isi class induk. Satu class hanya boleh punya satu induk.',
        'super.nama: teruskan nilai ke constructor induk.',
        '@override: sengaja mengganti method induk. super.bersuara() menjalankan versi induk.',
        'Pakai pewarisan jika hubungannya "X adalah Y". Semua class adalah keturunan Object.',
      ],
      catatan: 'Analogi buku resep keluarga: anak mewarisi semua resep, boleh menambah atau memodifikasi. Kaitkan dengan HalamanUtama extends StatelessWidget yang meng-override build().',
    });

    d.kode({
      judul: 'Polimorfisme dan Operator is',
      berkas: 'kode/contoh_05_pewarisan.dart',
      kode: [
        'List<Hewan> kebunBinatang = [',
        "  Kucing('Oyen'),",
        "  Burung('Kiki', bisaBicara: true),",
        "  Hewan('Sapi'),",
        '];',
        '',
        'for (Hewan hewan in kebunBinatang) {',
        '  hewan.bersuara(); // menyesuaikan jenisnya',
        '',
        '  if (hewan is Burung) {',
        '    hewan.terbang(); // aman: pasti Burung',
        '  }',
        '}',
      ].join('\n'),
      poin: [
        'Polimorfisme: satu perintah yang sama, setiap objek menjalankannya dengan caranya sendiri.',
        'Di Flutter, Column(children: [...]) berisi Text, Icon, dan tombol; semuanya diperlakukan sebagai Widget.',
        'is memeriksa jenis objek. Setelah dicek, method khusus jenis itu boleh dipanggil (type promotion).',
        [
          { text: 'Tanpa cek is: ' },
          { text: "The method 'terbang' isn't defined for the type 'Hewan'.", options: { color: MERAH, fontFace: 'Consolas', fontSize: 14 } },
        ],
      ],
      catatan: 'Analogi dosen berkata "perkenalkan diri masing-masing": setiap mahasiswa memperkenalkan diri dengan caranya sendiri.',
    });

    d.kode({
      judul: 'Abstract Class dan Interface',
      berkas: 'kode/contoh_06_abstract_dan_interface.dart',
      kode: [
        'abstract class Pengiriman {',
        '  String get nama; // abstrak',
        '  int hitungOngkir(int beratKg); // abstrak',
        '}',
        '',
        'class Reguler extends Pengiriman {',
        '  @override',
        "  String get nama => 'Reguler (3-5 hari)';",
        '  @override',
        '  int hitungOngkir(int beratKg) => beratKg * 9000;',
        '}',
        '',
        'abstract class BisaDilacak {',
        '  String lacak(String nomorResi);',
        '}',
        '',
        'class Kilat extends Pengiriman implements BisaDilacak {',
        '  // wajib menulis nama, hitungOngkir, DAN lacak',
        '}',
      ].join('\n'),
      ukuran: 13,
      poin: [
        'Abstract class = kontrak sekaligus kerangka. Objeknya tidak bisa dibuat langsung.',
        [
          { text: 'Pengiriman() ditolak: ' },
          { text: "Abstract classes can't be instantiated.", options: { color: MERAH, fontFace: 'Consolas', fontSize: 14 } },
        ],
        'Anggota abstrak wajib diisi class anak. Jika lupa: Missing concrete implementation...',
        'implements = berjanji punya semua kemampuan dan menulis sendiri semua isinya. Boleh lebih dari satu.',
      ],
      catatan: 'Analogi toko online yang mewajibkan setiap jasa pengiriman punya nama layanan dan cara menghitung ongkir.',
    });

    d.kode({
      judul: 'Mixin: Menempelkan Kemampuan',
      berkas: 'kode/contoh_07_mixin.dart',
      kode: [
        'mixin BisaBerenang on Hewan {',
        "  void berenang() => print('$nama berenang.');",
        '}',
        '',
        'mixin BisaTerbang on Hewan {',
        '  int ketinggianMaks = 100;',
        "  void terbang() => print('$nama terbang.');",
        '}',
        '',
        'class Bebek extends Hewan',
        '    with BisaBerjalan, BisaBerenang, BisaTerbang {',
        '  Bebek(super.nama);',
        '}',
        '',
        'class Ikan extends Hewan with BisaBerenang {',
        '  Ikan(super.nama);',
        '}',
      ].join('\n'),
      ukuran: 14,
      poin: [
        'Satu class hanya punya satu induk, tetapi boleh memakai banyak mixin dengan with.',
        'Analogi lencana keahlian pramuka: menambah kemampuan tanpa mengubah siapa dirinya.',
        'on Hewan: mixin khusus keluarga Hewan, sehingga boleh memakai properti nama.',
        'Di Flutter: with SingleTickerProviderStateMixin saat membuat animasi.',
      ],
      catatan: 'Tanyakan: apa yang terjadi jika koki.terbang() dipanggil pada objek Ikan? (ditolak editor karena Ikan tidak memakai BisaTerbang).',
    });

    d.tabel({
      judul: 'extends, implements, atau with?',
      kepala: ['', 'extends', 'implements', 'with'],
      lebarKolom: [1.9, 2.5, 2.7, 4.1],
      baris: [
        [{ text: 'Dibaca', options: { bold: true } }, '"adalah sebuah ..."', '"berjanji bisa ..."', '"punya kemampuan tambahan ..."'],
        [{ text: 'Jumlah per class', options: { bold: true } }, 'Hanya 1', 'Boleh banyak', 'Boleh banyak'],
        [{ text: 'Isi method diwarisi?', options: { bold: true } }, { text: 'Ya', options: { color: C.accent4, bold: true } }, { text: 'Tidak, wajib tulis ulang', options: { color: MERAH } }, { text: 'Ya', options: { color: C.accent4, bold: true } }],
        [{ text: 'Contoh', options: { bold: true } }, { text: 'Kucing extends Hewan', options: KODE }, { text: 'Kilat implements BisaDilacak', options: KODE }, { text: 'Bebek with BisaTerbang', options: KODE }],
        [{ text: 'Di Flutter', options: { bold: true } }, { text: 'extends StatelessWidget', options: KODE }, 'Jarang ditulis pemula', { text: 'with SingleTickerProviderStateMixin', options: { fontFace: 'Consolas', fontSize: 14 } }],
      ],
      ukuran: 15,
      catatan: 'Tanyakan contoh lain: Mahasiswa extends Orang (adalah), Ponsel implements BisaDiisiDaya (berjanji), Bebek with BisaBerenang (kemampuan tambahan).',
    });

    d.bagian({ label: 'BAGIAN 4', judul: 'Enum dan Exception', ikon: 'perisai' });

    d.kode({
      judul: 'Enum: Pilihan yang Pasti',
      berkas: 'kode/contoh_08_enum.dart',
      kode: [
        'enum StatusPesanan {',
        "  menunggu('Menunggu konfirmasi'),",
        "  diproses('Sedang dimasak'),",
        "  siap('Siap diambil'),",
        "  selesai('Pesanan selesai');",
        '',
        '  const StatusPesanan(this.label);',
        '  final String label;',
        '}',
        '',
        'String saran(StatusPesanan s) => switch (s) {',
        "  StatusPesanan.menunggu => 'Mohon tunggu.',",
        "  StatusPesanan.diproses => 'Sedang dibuat.',",
        "  StatusPesanan.siap => 'Ambil di loket.',",
        "  StatusPesanan.selesai => 'Terima kasih!',",
        '};',
      ].join('\n'),
      ukuran: 14,
      poin: [
        'Enum seperti pilihan ganda: nilainya pasti dan terbatas, salah ketik langsung ketahuan.',
        '.name, .index (mulai 0), dan .values (daftar semua nilai).',
        'Enum boleh membawa properti, seperti label, dan getter.',
        "switch tanpa _ memastikan semua nilai ditangani. Nilai baru yang terlupa memunculkan error isn't exhaustively matched.",
        'Di Flutter: MainAxisAlignment.center dan TextAlign.center adalah enum.',
      ],
      catatan: 'Bandingkan dengan teks ajaib: status == \'diprosess\' (salah ketik) tidak memunculkan error, tetapi syaratnya tidak pernah benar.',
    });

    d.kode({
      judul: 'Exception: try, on, catch, finally',
      berkas: 'kode/contoh_09_exception.dart',
      kode: [
        'int tarikTunai(int saldo, int jumlah) {',
        '  if (jumlah > saldo) {',
        '    throw SaldoTidakCukupException(jumlah - saldo);',
        '  }',
        '  return saldo - jumlah;',
        '}',
        '',
        'try {',
        '  tarikTunai(50000, 80000);',
        "  print('Tidak dicetak');",
        '} on SaldoTidakCukupException catch (e) {',
        "  print('Penarikan gagal: $e');",
        '} finally {',
        "  print('Struk transaksi dicetak.');",
        '}',
      ].join('\n'),
      ukuran: 14,
      poin: [
        'throw melempar masalah ke pemanggil; fungsi langsung berhenti di baris itu.',
        'on = tangkap jenis tertentu. catch (e) = simpan objek error ke variabel e.',
        'finally selalu dijalankan: menutup koneksi atau menyembunyikan loading.',
        'Exception buatan sendiri: class SaldoTidakCukupException implements Exception.',
      ],
      catatan: 'Analogi payung: hujan (server mati, input salah) tidak bisa dicegah, tetapi kita bisa menyiapkan payung.',
    });

    d.kartu({
      judul: 'Aturan Menangani Error',
      kolom: 3,
      item: [
        { ikon: 'perisai', judul: 'Exception: tangani', isi: 'Masalah wajar yang memang perlu ditangani: input salah, koneksi putus, stok habis.', warna: C.accent4 },
        { ikon: 'serangga', judul: 'Error: perbaiki kode', isi: 'Tanda ada bug, misalnya RangeError karena indeks di luar batas. Jangan ditangkap.', warna: C.accent5 },
        { ikon: 'peringatan', judul: 'Jangan catch kosong', isi: 'catch (e) {} menelan error diam-diam, sehingga penyebab masalah sulit dilacak.', warna: C.accent3 },
        { ikon: 'saring', judul: 'Spesifik dulu', isi: 'Tulis on JenisKhusus lebih dulu, baru catch umum sebagai jaring pengaman.' },
        { ikon: 'centang', judul: 'Cegah jika bisa', isi: 'Untuk mengubah teks menjadi angka, int.tryParse() menghindari exception sama sekali.' },
        { ikon: 'jam', judul: 'Ingat await', isi: 'try-catch hanya menangkap error dari Future yang di-await.', warna: C.accent6 },
      ],
      catatan: 'Contoh 09 sengaja menangkap RangeError hanya untuk menunjukkan catch tanpa on. Di kode sungguhan, bug seperti itu diperbaiki, bukan ditangkap.',
    });

    d.bagian({ label: 'BAGIAN 5', judul: 'Pemrograman Asinkron', ikon: 'jam' });

    d.kode({
      judul: 'Future, async, dan await',
      berkas: 'kode/contoh_10_future_async_await.dart',
      kode: [
        '// Future = "pager" di food court:',
        '// janji bahwa hasilnya tersedia NANTI.',
        'Future<String> ambilNamaPengguna() async {',
        '  await Future.delayed(Duration(seconds: 1));',
        "  return 'Rina';",
        '}',
        '',
        'Future<void> main() async {',
        "  print('Memuat...');",
        '  String nama = await ambilNamaPengguna();',
        "  print('Halo, $nama!');",
        '}',
      ].join('\n'),
      poin: [
        'Memakai await? Fungsinya wajib ditandai async.',
        'Fungsi async selalu mengembalikan Future<TipeHasil>, atau Future<void>.',
        'await hanya menunda fungsi itu sendiri; tombol dan animasi tetap berjalan.',
        'Future.delayed hanya pura-pura menunggu, pengganti proses internet di Pertemuan 10.',
      ],
      catatan: 'Analogi pager food court: Anda bebas duduk atau membeli minum, pager bergetar saat makanan siap. Future juga bisa gagal, seperti makanan yang ternyata habis.',
    });

    d.tabel({
      judul: 'then() vs await: Siapa yang Duluan?',
      pengantar: 'Nama diambil dua kali (tanpa await lewat then, lalu dengan await), kemudian jumlah notifikasi. Setiap pengambilan butuh 1 detik.',
      kepala: ['Waktu', 'Yang terjadi', 'Output'],
      lebarKolom: [1.3, 6.4, 2.5],
      baris: [
        [{ text: '0 detik', options: { bold: true } }, 'Panggilan tanpa await langsung lanjut. Panggilan dengan await membuat main() menunggu.', '1. dan 2.'],
        [{ text: '1 detik', options: { bold: true } }, 'Kedua pengambilan nama selesai: isi then() dijalankan, main() lanjut meminta jumlah notifikasi.', '3. (then)'],
        [{ text: '2 detik', options: { bold: true } }, 'Jumlah notifikasi tiba.', '4. dan 5.'],
      ],
      pesan: 'Hasilnya sama-sama didapat, tetapi await terbaca dari atas ke bawah seperti kode biasa, sehingga lebih dianjurkan.',
      catatan: 'Jalankan contoh 10 di DartPad dan minta mahasiswa menebak urutan output sebelum menekan Run.',
    });

    d.kode({
      judul: 'Future.wait dan Error Asinkron',
      berkas: 'kode/contoh_11_future_paralel_dan_error.dart',
      kode: [
        '// Tiga pekerjaan @1 detik -> selesai ±1 detik',
        'List<int> stok = await Future.wait([',
        "  cekStokGudang('Samarinda'),",
        "  cekStokGudang('Balikpapan'),",
        "  cekStokGudang('Bontang'),",
        ']);',
        'print(stok); // [12, 8, 5]',
        '',
        'try {',
        '  int saldo = await ambilSaldo(serverAktif: false);',
        "  print('Saldo: Rp$saldo');",
        '} catch (e) {',
        "  print('Gagal memuat saldo: $e');",
        '} finally {',
        "  print('Indikator loading disembunyikan.');",
        '}',
      ].join('\n'),
      ukuran: 14,
      poin: [
        'Future.wait menjalankan semuanya bersamaan; total waktunya kira-kira sama dengan pekerjaan paling lama.',
        'Urutan hasil = urutan daftar, bukan urutan selesai.',
        'Error dari Future ditangkap dengan try-catch biasa, asalkan di-await.',
        'Pola "coba, tampilkan pesan gagal, sembunyikan loading" dipakai mulai Pertemuan 10.',
      ],
      catatan: 'Analogi memesan di tiga kios sekaligus, bukan mengantre satu per satu.',
    });

    d.banding({
      judul: 'Future vs Stream',
      tinggiKolom: 4.4,
      ukuranPoin: 16,
      kolom: [
        {
          ikon: 'jam', judul: 'Future', warna: C.accent1, tag: 'Paket kiriman: datang SEKALI',
          poin: ['Dibuat dengan async + return', 'Diambil dengan await', 'Widget: FutureBuilder (P10)'],
          contoh: "Future<String> ambilNama() async {\n  return 'Rina';\n}",
        },
        {
          ikon: 'aliran', judul: 'Stream', warna: C.accent6, tag: 'Langganan: datang BERKALI-KALI',
          poin: ['Dibuat dengan async* + yield', 'Didengar dengan await for atau listen', 'Widget: StreamBuilder (P10)'],
          contoh: 'Stream<int> hitung() async* {\n  yield 3;\n  yield 2;\n}',
        },
      ],
      pesan: 'Contoh Stream: progres unduhan, lokasi GPS saat navigasi, pesan chat baru, status pesanan ojek online.',
      catatan: 'Kuis cepat: data profil saat aplikasi dibuka (Future), lokasi GPS saat navigasi (Stream), progres unggah foto (Stream), menyimpan satu catatan (Future).',
    });

    d.kode({
      judul: 'Stream: async*, yield, await for, listen',
      berkas: 'kode/contoh_12_stream.dart',
      kode: [
        'Stream<int> hitungMundur(int dari) async* {',
        '  for (int i = dari; i >= 1; i--) {',
        '    await Future.delayed(Duration(milliseconds: 500));',
        '    yield i; // kirim satu nilai',
        '  }',
        '}',
        '',
        'await for (int detik in hitungMundur(3)) {',
        "  print('$detik...'); // 3... 2... 1...",
        '}',
        '',
        'hitungMundur(2).listen(',
        "  (int sisa) => print('Tinggal $sisa'),",
        "  onDone: () => print('Stream selesai.'),",
        ');',
        "print('Baris ini muncul duluan!');",
      ].join('\n'),
      ukuran: 14,
      poin: [
        'async* + yield: fungsi yang mengalirkan banyak nilai, satu per satu.',
        'await for: ikuti aliran sampai selesai; fungsinya ikut menunggu.',
        'listen: berlangganan tanpa menunggu. onDone dipanggil saat aliran selesai.',
        'where dan map juga bisa dipakai pada stream, sama seperti pada List.',
      ],
      catatan: 'Tekankan urutan output: baris setelah listen dicetak lebih dulu daripada notifikasinya.',
    });

    d.kode({
      judul: 'Studi Kasus: Sistem Pesanan Kantin',
      berkas: 'kode/contoh_13_studi_kasus_pesanan_kantin.dart',
      kode: [
        'for (String namaMenu in antreanPesanan) {',
        '  try {',
        '    int nomor = await kantin.pesan(namaMenu);',
        "    print('Pesanan #$nomor: $namaMenu');",
        '    await for (StatusPesanan status',
        '        in kantin.pantauStatus(nomor)) {',
        "      print('  #$nomor -> ${status.label}');",
        '    }',
        '  } on StokHabisException catch (e) {',
        "    print('Gagal memesan: $e');",
        '  } catch (e) {',
        "    print('Gagal memesan: $e');",
        '  }',
        '}',
      ].join('\n'),
      ukuran: 14,
      poin: [
        'enum StatusPesanan: diterima, dimasak, lalu siap diambil.',
        'class Menu + _daftarMenu yang privat; StokHabisException saat stok habis.',
        'Future<int> pesan(): mengirim pesanan ke dapur butuh waktu.',
        'Stream<StatusPesanan> pantauStatus(): status berubah beberapa kali.',
        'Tangkap yang spesifik dulu (on), baru yang umum (catch).',
      ],
      catatan: 'Bandingkan dengan Kasir Kantin Pertemuan 2: data dan perilaku kini terbungkus rapi dalam class, status tidak mungkin salah ketik, dan program tidak crash saat stok habis.',
    });

    d.tabel({
      judul: 'Kesalahan Umum Pemula',
      kepala: ['Pesan error', 'Penyebab dan solusi'],
      lebarKolom: [5.4, 3.8],
      baris: [
        ["Non-nullable instance field 'nama' must be initialized.", 'Properti belum diisi; isi lewat constructor (this.nama)'],
        ["The named parameter 'penulis' is required, but there's no corresponding argument.", 'Argumen required belum diisi saat membuat objek'],
        ["Abstract classes can't be instantiated.", 'Buat objek dari class anaknya'],
        ["The implicitly invoked unnamed constructor from 'Hewan' has required parameters.", 'Teruskan ke induk: Kucing(super.nama);'],
        ["The method 'terbang' isn't defined for the type 'Hewan'.", 'Periksa dulu: if (h is Burung)'],
        ['The await expression can only be used in an async function.', 'Tambahkan async pada fungsinya'],
        ["A value of type 'Future<String>' can't be assigned to a variable of type 'String'.", 'Lupa menulis await'],
      ],
      ukuran: 14,
      catatan: 'Tabel lengkap ada di modul bagian 14, termasuk tanda lupa await: tercetak Instance of Future.',
    });

    d.ringkasan({
      poin: [
        'Class = cetakan, objek = hasil cetakan. Properti = data, method = aksi.',
        'Constructor: biasa, parameter bernama, named, const, dan factory.',
        'Enkapsulasi: _ privat per berkas; getter untuk melihat, setter untuk validasi.',
        'extends (satu induk), super, @override; polimorfisme dan operator is.',
        'Abstract class = kontrak; implements = janji; mixin (with) = tempel kemampuan.',
        'Enum = pilihan pasti; switch memastikan semua nilai ditangani.',
        'Exception: throw, try, on, catch, finally. Jangan tangkap Error, jangan biarkan catch kosong.',
        'Future = satu hasil (async/await, Future.wait). Stream = banyak hasil (async*, yield, await for).',
      ],
      catatan: 'Minta mahasiswa menjelaskan ulang setiap kata pada kode HalamanUtama di awal pertemuan.',
    });

    d.penutup({
      judul: 'Saatnya Praktik!',
      subjudul: 'Kerjakan Jobsheet Pertemuan 3 (lima praktikum + tantangan Laundry Kampus), lalu uji diri di Latihan. Pertemuan berikutnya: widget dan tata letak Flutter.',
      tautan: [
        { teks: 'Jobsheet P3', ikon: 'tugas', url: d.urlBerkas('pertemuan_03_dart_lanjutan/JOBSHEET.md') },
        { teks: 'Latihan P3', ikon: 'kuis', url: d.urlBerkas('pertemuan_03_dart_lanjutan/LATIHAN.md') },
        { teks: 'Modul P3', ikon: 'buku', url: d.urlBerkas('pertemuan_03_dart_lanjutan/README.md') },
      ],
      catatan: 'Praktikum 5 dan tugas mandiri memakai Future.delayed, jadi output muncul bertahap. Ingatkan mahasiswa untuk menunggu sampai program selesai.',
    });
  },
};

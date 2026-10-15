// Konten slide Pertemuan 5 — Interaksi Pengguna & State Lokal.
// Teks diambil dari modul bacaan (pertemuan_05_interaksi_dan_state/README.md).
// Tangkapan layar diambil dari folder pertemuan_05_interaksi_dan_state/gambar/.

module.exports = {
  nomor: '05',
  folder: 'pertemuan_05_interaksi_dan_state',
  namaBerkas: 'PERTEMUAN_05_Interaksi_dan_State',
  topik: 'Interaksi Pengguna & State Lokal',

  bangun(d) {
    const C = d.C;
    const KODE = { fontFace: 'Consolas' };

    d.judul({
      judul: 'Interaksi Pengguna & State Lokal',
      subjudul: 'Pertemuan 5  ·  StatefulWidget, setState, tombol & sentuhan, pemilih nilai, siklus hidup, formulir, dialog, dan mengangkat state',
      catatan: 'Pada Pertemuan 4 semua tombol masih onPressed: () {}. Hari ini tombol-tombol itu benar-benar bekerja. Bekal yang dipakai: class, getter, enum, async/await (Pertemuan 3) dan menyusun tampilan (Pertemuan 4).',
    });

    d.tujuan({
      pengantar: 'Setelah pertemuan ini, Anda mampu:',
      poin: [
        'Menjelaskan arti state dan memilih StatelessWidget atau StatefulWidget',
        'Memperbarui tampilan dengan setState() dan menonaktifkan tombol',
        'Memakai tombol, sentuhan, SnackBar, dan widget pemilih nilai',
        'Menjelaskan siklus hidup State: initState, build, dispose',
        'Membuat formulir dengan validator, dialog, dan pemeriksaan mounted',
        'Mengangkat state ke induk dan memakai callback dari widget anak',
      ],
      catatan: 'Target akhir hari ini: halaman Pesan Menu Kantin yang benar-benar bisa dipakai, dengan total harga yang ikut berubah dan dialog konfirmasi.',
    });

    d.alur({
      judul: 'Peta Materi Hari Ini',
      langkah: [
        { ikon: 'sinkron', judul: 'Apa itu state', isi: 'Tampilan = f(state) dan StatefulWidget' },
        { ikon: 'tombol', judul: 'Tombol & sentuhan', isi: 'Jenis tombol, InkWell, SnackBar' },
        { ikon: 'sakelar', judul: 'Pemilih nilai', isi: 'Switch, Checkbox, Radio, Slider, Chip' },
        { ikon: 'siklus', judul: 'Siklus hidup', isi: 'initState, build, dispose' },
        { ikon: 'formulir', judul: 'Formulir & dialog', isi: 'Controller, validator, await + mounted' },
        { ikon: 'angkat', judul: 'Mengangkat state', isi: 'Callback, nilai turunan, studi kasus', warna: C.accent4 },
      ],
      catatan: 'Alurnya: pahami dulu apa itu state, lalu buat aplikasi menanggapi sentuhan, intip siklus hidupnya, terima masukan pengguna dengan aman, dan akhirnya rangkai semuanya.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 1', judul: 'Apa Itu State?', ikon: 'sinkron', catatan: 'Mulai dari konsep: data yang berubah selama aplikasi dibuka, dan cara Flutter memperbarui layar.' });

    d.alur({
      judul: 'Tampilan = f(State)',
      pengantar: 'Analogi papan skor futsal: bentuk papannya tetap, yang berubah hanya angka skornya. Angka itulah state.',
      langkah: [
        { ikon: 'sentuh', judul: 'Pengguna menekan', isi: 'Tombol "Minum 1 gelas" ditekan.' },
        { ikon: 'ubah', judul: 'setState() mengubah data', isi: '_gelas berubah dari 2 menjadi 3.' },
        { ikon: 'putar', judul: 'build() dijalankan lagi', isi: 'Flutter menyusun ulang tampilan dari data terbaru.' },
        { ikon: 'hp', judul: 'Layar diperbarui', isi: 'Tulisan menjadi "3 / 8 gelas".', warna: C.accent4 },
      ],
      tinggiKotak: 3.4,
      catatan: 'Gaya deklaratif: kita tidak memerintah "ganti tulisan itu", tetapi mengubah data lalu Flutter menggambar ulang. Akibatnya tampilan tidak mungkin berbeda dengan datanya. Contoh state: angka penghitung, status centang, isi kolom yang sedang diketik, pilihan ukuran gelas.',
    });

    d.kode({
      judul: 'Mengapa StatelessWidget Tidak Cukup?',
      kode: [
        '// ❌ JANGAN ditiru',
        'class Penghitung extends StatelessWidget {',
        '  Penghitung({super.key});',
        '',
        '  int angka = 0; // tidak final!',
        '',
        '  @override',
        '  Widget build(BuildContext context) {',
        '    return TextButton(',
        '      onPressed: () => angka++,',
        "      child: Text('$angka'),",
        '    );',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 14,
      poin: [
        [{ text: 'Peringatan ' }, { text: 'must_be_immutable', options: KODE }, { text: ': properti StatelessWidget wajib final.' }],
        'angka++ mengubah memori, tetapi tidak ada yang memberi tahu Flutter untuk menggambar ulang.',
        'Saat induknya digambar ulang, objek Penghitung dibuat baru dan angka kembali ke 0.',
        'Solusi: StatefulWidget. Datanya disimpan di objek State yang tetap hidup, dan setState() menjadi "bel pemberi tahu".',
      ],
      catatan: 'Tanyakan kepada mahasiswa: apa yang terlihat di layar jika tombol ini ditekan 5 kali? (Tetap 0.) Tekankan kebiasaan: mulai dengan StatelessWidget, ubah menjadi StatefulWidget hanya jika ada data yang perlu berubah.',
    });

    d.banding({
      judul: 'State Lokal dan State Aplikasi',
      kolom: [
        {
          ikon: 'widget', judul: 'State lokal (ephemeral)', warna: C.accent1, tag: 'Hari ini: StatefulWidget + setState',
          poin: [
            'Dipakai oleh satu widget atau satu halaman',
            'Tab yang dipilih, isi kolom teks, status centang',
            'Kartu yang sedang dibuka atau ditutup',
          ],
        },
        {
          ikon: 'grup', judul: 'State aplikasi (app state)', warna: C.accent6, tag: 'Pertemuan 9: ChangeNotifier + provider',
          poin: [
            'Dipakai bersama oleh banyak halaman',
            'Isi keranjang belanja, data pengguna yang masuk',
            'Daftar favorit yang dibuka dari mana saja',
          ],
        },
      ],
      pesan: 'Mulai dari state lokal. Jika ternyata dibutuhkan oleh beberapa widget, "naikkan" state-nya. Langkah pertamanya dipelajari di Bagian 7 hari ini.',
      catatan: 'Pembedaan ini berasal dari dokumentasi Flutter (Differentiate between ephemeral state and app state). Batasnya tidak selalu tegas; jangan habiskan waktu memperdebatkannya.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 2', judul: 'Anatomi StatefulWidget', ikon: 'kelas', catatan: 'Bedah contoh 01 (Pengingat Minum Air): dua class yang berpasangan dan cara kerja setState.' });

    d.layar({
      judul: 'Dua Class yang Berpasangan',
      gambar: ['hasil_contoh_01a.jpg', 'hasil_contoh_01b.jpg', 'hasil_contoh_01c.jpg'],
      berkas: 'kode/contoh_01_stateful_dasar.dart',
      kode: [
        '// 1) Class widget: pengaturan, final',
        'class HalamanMinumAir extends StatefulWidget {',
        '  final int target;',
        '  @override',
        '  State<HalamanMinumAir> createState() =>',
        '      _HalamanMinumAirState();',
        '}',
        '',
        '// 2) Class State: data yang berubah',
        'class _HalamanMinumAirState',
        '    extends State<HalamanMinumAir> {',
        '  int _gelas = 0; // STATE',
        '  // build() ada di sini',
        '}',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Class widget = kartu identitas; class State = buku catatan yang tetap hidup.',
        'State membaca pengaturan lewat widget.target.',
      ],
      ukuranPoin: 15,
      catatan: 'Kiri ke kanan: 0, 3, dan 8 dari 8 gelas. Di VS Code ketik stful lalu Enter untuk membuat kerangka dua class ini. Tipe kembalian createState ditulis State<HalamanMinumAir> (aturan library_private_types_in_public_api), dan createState tidak boleh berisi logika lain (no_logic_in_create_state).',
    });

    d.alur({
      judul: 'Apa yang Terjadi Saat setState() Dipanggil?',
      langkah: [
        { ikon: 'ubah', judul: '1. Data diubah', isi: 'Fungsi di dalam setState dijalankan: _gelas++.' },
        { ikon: 'label', judul: '2. Ditandai', isi: 'Flutter menandai widget ini "perlu digambar ulang".' },
        { ikon: 'putar', judul: '3. build() lagi', isi: 'Pada frame berikutnya, build() berjalan dengan nilai baru.' },
        { ikon: 'centang', judul: '4. Layar diperbarui', isi: 'Hanya bagian yang berubah yang digambar ulang.', warna: C.accent4 },
      ],
      tinggiKotak: 3.3,
      catatan: 'Contoh kode: void _tambahGelas() { setState(() { _gelas++; }); }. Jika _gelas++ ditulis tanpa setState, nilainya berubah di memori tetapi layar tidak ikut berubah: aplikasi terlihat macet. Peragakan di DartPad.',
    });

    d.tabel({
      judul: 'Menulis Aksi Tombol dengan Benar',
      kepala: ['Penulisan', 'Artinya', 'Hasil'],
      lebarKolom: [5.0, 4.8, 1.9],
      baris: [
        [{ text: 'onPressed: _tambahGelas', options: KODE }, 'Ini fungsinya, jalankan nanti saat ditekan', { text: '✅ Benar', options: { bold: true, color: '2E7D32' } }],
        [{ text: 'onPressed: () => _catat(\'A\')', options: KODE }, 'Fungsi tanpa nama, berguna jika perlu argumen', { text: '✅ Benar', options: { bold: true, color: '2E7D32' } }],
        [{ text: 'onPressed: _tambahGelas()', options: KODE }, 'Dijalankan sekarang, saat build()', { text: '❌ Error void', options: { bold: true, color: 'C62828' } }],
        [{ text: 'onPressed: _gelas > 0 ? _kurangi : null', options: KODE }, 'null = tombol nonaktif (abu-abu)', { text: '✅ Benar', options: { bold: true, color: '2E7D32' } }],
      ],
      ukuran: 15,
      tinggiBaris: 0.8,
      pesan: "Hot reload mempertahankan state. Mengubah nilai awal (int _gelas = 5) baru terlihat setelah hot restart: tekan R di terminal.",
      catatan: "Pesan error baris ketiga: This expression has a type of 'void' so its value can't be used. Menonaktifkan tombol lebih baik daripada membiarkannya aktif lalu menolak di dalam fungsi: pengguna langsung melihat bahwa aksinya belum tersedia.",
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 3', judul: 'Tombol dan Sentuhan', ikon: 'tombol', catatan: 'Memilih jenis tombol yang tepat, membuat apa saja bisa diketuk, dan memberi umpan balik.' });

    d.layar({
      judul: 'Lima Tombol Material 3',
      gambar: ['hasil_contoh_02a.jpg', 'hasil_contoh_02b.jpg'],
      berkas: 'kode/contoh_02_jenis_tombol.dart',
      poin: [
        [{ text: 'FilledButton', options: { bold: true } }, { text: ': aksi utama, cukup satu per layar.' }],
        [{ text: 'FilledButton.tonal', options: { bold: true } }, { text: ': aksi penting kedua.' }],
        [{ text: 'ElevatedButton', options: { bold: true } }, { text: ': di atas latar bergambar.' }],
        [{ text: 'OutlinedButton', options: { bold: true } }, { text: ': aksi pendamping (Batal).' }],
        [{ text: 'TextButton', options: { bold: true } }, { text: ': paling ringan, juga di dialog.' }],
        'Versi berikon: .icon(icon: ..., label: ...).',
        'IconButton (+ filled, filledTonal, outlined): selalu isi tooltip.',
        'Toggle: isSelected + icon + selectedIcon.',
      ],
      ukuranPoin: 15,
      catatan: 'Tooltip juga dibacakan oleh pembaca layar (TalkBack) untuk pengguna tunanetra. Kuis cepat: halaman pembayaran punya tombol Bayar dan Kembali ke keranjang. Jawaban: FilledButton dan OutlinedButton/TextButton.',
    });

    d.layar({
      judul: 'InkWell, GestureDetector, dan SnackBar',
      gambar: ['hasil_contoh_03a.jpg', 'hasil_contoh_03b.jpg'],
      berkas: 'kode/contoh_03_sentuhan_dan_snackbar.dart',
      kode: [
        'pesan.showSnackBar(SnackBar(',
        "  content: const Text('Pengumuman dihapus.'),",
        '  action: SnackBarAction(',
        "    label: 'Batalkan',",
        '    onPressed: () { /* kembalikan */ },',
        '  ),',
        '  persist: false, // tetap hilang sendiri',
        '));',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'InkWell: bisa diketuk + efek riak; butuh Material di atasnya.',
        'GestureDetector: ketuk dua kali, geser, cubit; tanpa efek.',
        'hideCurrentSnackBar() dulu agar pesan tidak antre.',
      ],
      ukuranPoin: 15,
      catatan: 'Card diberi clipBehavior: Clip.antiAlias agar riak mengikuti sudut kartu. SnackBar yang punya action secara bawaan tidak hilang sendiri; persist: false membuatnya hilang setelah ±4 detik. Pola Batalkan dipakai untuk aksi yang mudah dikembalikan; untuk aksi permanen gunakan dialog (Bagian 6).',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 4', judul: 'Memilih Nilai', ikon: 'sakelar', catatan: 'Switch, Checkbox, Radio, SegmentedButton, Slider, dan Chip memakai pola yang sama: value + onChanged.' });

    d.kode({
      judul: 'Pola yang Sama: value + onChanged',
      kode: [
        'SwitchListTile(',
        "  title: const Text('Notifikasi'),",
        '  value: _notifikasi, // yang SEDANG tampil',
        '  onChanged: (bool nilaiBaru) {',
        '    // Flutter memberi tahu nilai baru;',
        '    // kita yang menyimpannya.',
        '    setState(() {',
        '      _notifikasi = nilaiBaru;',
        '    });',
        '  },',
        ')',
      ].join('\n'),
      ukuran: 15,
      poin: [
        'Widget pemilih nilai tidak menyimpan pilihannya sendiri; ia selalu menampilkan isi value.',
        'Lupa setState di onChanged → sakelar tidak mau bergeser.',
        'onChanged: null → pemilih nilai nonaktif (abu-abu).',
        [{ text: 'Checkbox mengirim ' }, { text: 'bool?', options: KODE }, { text: ' → simpan dengan ' }, { text: 'nilaiBaru ?? false', options: KODE }, { text: '.' }],
      ],
      catatan: 'Gambar alurnya di papan: state → value → tampil → pengguna mengubah → onChanged → setState → state baru → build. Versi ListTile (SwitchListTile, CheckboxListTile, RadioListTile) membuat seluruh baris bisa diketuk.',
    });

    d.layar({
      judul: 'Switch, Checkbox, dan RadioGroup',
      gambar: ['hasil_contoh_04a.jpg', 'hasil_contoh_04b.jpg', 'hasil_contoh_04c.jpg'],
      berkas: 'kode/contoh_04_switch_checkbox_radio.dart',
      kode: [
        'RadioGroup<UkuranTeks>(',
        '  groupValue: _ukuran,',
        '  onChanged: (UkuranTeks? pilihan) {',
        '    if (pilihan == null) return;',
        '    setState(() { _ukuran = pilihan; });',
        '  },',
        '  child: Column(children: [',
        '    for (UkuranTeks u in UkuranTeks.values)',
        '      RadioListTile<UkuranTeks>(',
        '        value: u, title: Text(u.label)),',
        '  ]),',
        ')',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Radio cara lama (groupValue di setiap Radio) sudah usang.',
        'Ringkasan dihitung dari state: nilai turunan.',
      ],
      ukuranPoin: 15,
      catatan: 'Gambar kanan: saat Notifikasi dimatikan, kotak centang ikut nonaktif karena onChanged-nya bernilai null. Peringatan cara lama: groupValue is deprecated and shouldn\'t be used. Use a RadioGroup ancestor to manage group value instead.',
    });

    d.layar({
      judul: 'SegmentedButton, Slider, dan Chip',
      gambar: ['hasil_contoh_05a.jpg', 'hasil_contoh_05b.jpg'],
      berkas: 'kode/contoh_05_slider_segmented_chip.dart',
      poin: [
        [{ text: 'SegmentedButton', options: { bold: true } }, { text: ': selected berupa Set → {_ukuran}, ambil dengan pilihan.first.' }],
        [{ text: 'Slider', options: { bold: true } }, { text: ': nilai double; divisions membuatnya berhenti di titik tertentu; tampilkan dengan .round().' }],
        [{ text: 'ChoiceChip', options: { bold: true } }, { text: ' pilih satu; ' }, { text: 'FilterChip', options: { bold: true } }, { text: ' pilih banyak (Set + add/remove).' }],
        'Uji layar 320: ikon centang membuat "Sedang" terpotong, jadi dipakai showSelectedIcon: false.',
      ],
      ukuranPoin: 16,
      catatan: 'Pelajaran dari pengujian: masalah label terpotong hanya terlihat di lebar 320, tidak di 360. Kumpulan chip dibungkus Wrap (Pertemuan 4) agar pindah baris. Tanda (_) pada onSelected berarti nilai yang dikirim tidak dipakai.',
    });

    d.tabel({
      judul: 'Memilih Widget Pemilih yang Tepat',
      kepala: ['Kebutuhan', 'Widget yang cocok'],
      lebarKolom: [5.4, 6.0],
      baris: [
        ['Nyala/mati, langsung berlaku', 'Switch / SwitchListTile'],
        ['Boleh memilih banyak dari daftar', 'Checkbox / CheckboxListTile, atau FilterChip'],
        ['Pilih satu dari 2–5 pilihan, berdampingan', 'SegmentedButton atau ChoiceChip'],
        ['Pilih satu dari daftar yang tersusun ke bawah', 'RadioGroup + RadioListTile'],
        ['Pilih satu dari banyak pilihan (lebih dari 5)', 'DropdownButtonFormField'],
        ['Angka dalam suatu rentang', 'Slider'],
      ],
      ukuran: 17,
      catatan: 'Kuis cepat: kelas paralel A/B/C (SegmentedButton atau Radio), bidang lomba yang diminati (Checkbox atau FilterChip), persetujuan newsletter (Switch).',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 5', judul: 'Siklus Hidup State', ikon: 'siklus', catatan: 'Objek State lahir, bekerja, menerima arahan baru, lalu dibuang. Mengetahui urutannya membuat kita tahu di mana menaruh kode.' });

    d.lapisan({
      judul: 'Perjalanan Hidup Sebuah State',
      lapisan: [
        { ikon: 'masuk', judul: 'createState() → initState()', isi: 'Dibuat, lalu persiapan SEKALI: nilai awal, controller.' },
        { ikon: 'putar', judul: 'build()', isi: 'Berkali-kali: setiap setState dan setiap ada perubahan.' },
        { ikon: 'ubah', judul: 'didUpdateWidget()', isi: 'Induk memberi widget baru (parameter baru); State yang sama tetap dipakai.' },
        { ikon: 'keluar', judul: 'deactivate() → dispose()', isi: 'Widget dilepas dari layar; bersih-bersih, lalu dibuang.', warna: C.accent5 },
      ],
      keterangan: [
        'Analogi mahasiswa magang: datang, orientasi sekali, bekerja setiap hari, menerima arahan baru, pamit, mengembalikan kartu akses.',
        'super.initState() di baris PERTAMA, super.dispose() di baris TERAKHIR.',
        'Jangan memakai Theme.of(context) di initState(); bacalah di build().',
      ],
      catatan: 'didChangeDependencies() dipanggil setelah initState() dan saat data dari atas (misalnya tema) berubah; jarang dipakai pemula. Pesan error jika Theme.of dipakai di initState: dependOnInheritedWidgetOfExactType ... was called before ...initState() completed.',
    });

    d.layar({
      judul: 'Melihat Siklus Hidup di Konsol',
      gambar: 'hasil_contoh_06.jpg',
      lebarMaks: 4.6,
      berkas: 'kode/contoh_06_siklus_hidup_state.dart',
      kode: [
        '1. createState(): objek State dibuat',
        '2. initState(): persiapan SEKALI',
        '3. didChangeDependencies(): ...',
        'build(): menggambar kartu (_jumlah = 0)',
        '--- tombol + ditekan ---',
        'build(): menggambar kartu (_jumlah = 1)',
        '--- judul baru dikirim ---',
        'didUpdateWidget(): "Kartu versi 1" -> "Kartu versi 2"',
        'build(): menggambar kartu (_jumlah = 1)',
        '--- kartu disembunyikan ---',
        'deactivate(): kartu dilepas dari pohon widget',
        'dispose(): State dibuang selamanya',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'setState hanya menjalankan build(), bukan initState().',
        'Parameter baru → State yang sama; _jumlah tetap 1.',
        'Ditampilkan lagi → State baru; _jumlah kembali 0.',
      ],
      ukuranPoin: 15,
      catatan: 'Jalankan contoh 06, buka panel Console di DartPad, lalu tekan tombolnya satu per satu sambil membaca catatan bersama mahasiswa. Catatan memakai debugPrint, bukan print (aturan avoid_print). Pertanyaan pancingan: jika _jumlah = 0 ditulis di dalam build(), apa yang terjadi? (Angka selalu 0.)',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 6', judul: 'Teks, Formulir, dan Dialog', ikon: 'formulir', catatan: 'Menerima ketikan pengguna, memeriksa isiannya, lalu meminta konfirmasi dengan dialog.' });

    d.layar({
      judul: 'TextField dan Controller',
      gambar: ['hasil_contoh_07a.jpg', 'hasil_contoh_07b.jpg'],
      berkas: 'kode/contoh_07_textfield_controller.dart',
      kode: [
        '// 1) BUAT sekali, sebagai properti State',
        'final TextEditingController _kontrolNama =',
        '    TextEditingController();',
        '',
        '// 2) PAKAI',
        'final String nama = _kontrolNama.text.trim();',
        '_kontrolNama.clear();',
        '',
        '// 3) BUANG',
        '@override',
        'void dispose() {',
        '  _kontrolNama.dispose();',
        '  super.dispose();',
        '}',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'onChanged: bereaksi setiap huruf (pratinjau).',
        'clear() tidak memanggil onChanged.',
      ],
      ukuranPoin: 15,
      catatan: 'Controller = remote TV untuk kolom teks. Tanpa dispose, memorinya tidak pernah dikembalikan (memory leak). Controller yang dibuat di dalam build() membuat ketikan hilang dan kursor melompat. Atur keyboard dengan keyboardType, textInputAction, textCapitalization, maxLength, dan obscureText.',
    });

    d.banding({
      judul: 'Menutup Keyboard: Pelajaran dari Pengujian',
      ukuranContoh: 12,
      kolom: [
        {
          ikon: 'galat', judul: 'Sering ditemukan di tutorial', warna: C.accent5, tag: 'Keyboard muncul lagi setelah dialog ditutup',
          poin: [
            'FocusScope masih "mengingat" kolom terakhir',
            'Setelah dialog konfirmasi ditutup, kolom aktif lagi',
            'Di ponsel, keyboard tiba-tiba muncul kembali',
          ],
          contoh: 'onTapOutside: (_) =>\n    FocusScope.of(context).unfocus(),',
        },
        {
          ikon: 'centang', judul: 'Dipakai di modul ini', warna: C.accent4, tag: 'Lepas fokus dari kolom itu sendiri',
          poin: [
            'primaryFocus = kolom yang sedang diketik',
            'Kolom tidak aktif lagi setelah dialog ditutup',
            'Tombol di dalam kolom dibungkus ExcludeFocus',
          ],
          contoh: 'onTapOutside: (_) =>\n    FocusManager.instance.primaryFocus?.unfocus(),',
        },
      ],
      pesan: 'Masalah ini ditemukan saat mencoba studi kasus sampai ke dialog konfirmasi, bukan saat membaca kode. Selalu uji alur lengkapnya.',
      catatan: 'ExcludeFocus pada tombol hapus (×) di dalam kolom membuat tombol "lanjut" di keyboard langsung memindahkan fokus ke kolom berikutnya, bukan ke tombol ×.',
    });

    d.layar({
      judul: 'Formulir dan Validator',
      gambar: ['hasil_contoh_08a.jpg', 'hasil_contoh_08b.jpg', 'hasil_contoh_08c.jpg'],
      berkas: 'kode/contoh_08_form_validasi.dart',
      kode: [
        'String? _cekNama(String? isian) {',
        "  final String teks = isian?.trim() ?? '';",
        "  if (teks.isEmpty) return 'Nama wajib diisi';",
        "  if (teks.length < 3) return 'Minimal 3 huruf';",
        '  return null; // null = BENAR',
        '}',
        '',
        'void _daftar() {',
        '  if (!_kunciForm.currentState!.validate()) {',
        '    return;',
        '  }',
        '  // simpan, SnackBar, lalu reset()',
        '}',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Form + GlobalKey<FormState> + TextFormField.',
        'validate() memeriksa semua; reset() mengosongkan.',
      ],
      ukuranPoin: 15,
      catatan: 'Tulis pesan error yang menunjukkan cara memperbaikinya, misalnya "Contoh email yang benar: rina@kampus.ac.id". Kolom khusus: NIM dengan digitsOnly + maxLength, kata sandi dengan obscureText + tombol mata, DropdownButtonFormField (pakai initialValue, bukan value yang usang), dan FormField<bool> untuk kotak centang persetujuan.',
    });

    d.layar({
      judul: 'Kapan Pesan Error Muncul?',
      gambar: 'hasil_contoh_08_masalah.jpg',
      lebarMaks: 4.0,
      kode: [
        'Form(',
        '  key: _kunciForm,',
        '  autovalidateMode:',
        '      AutovalidateMode.onUserInteractionIfError,',
        '  child: ...,',
        ')',
      ].join('\n'),
      ukuranKode: 14,
      poin: [
        [{ text: 'disabled', options: KODE }, { text: ' (bawaan): hanya saat validate().' }],
        [{ text: 'onUserInteraction', options: KODE }, { text: ' pada Form: satu huruf diketik, SEMUA kolom langsung merah (gambar).' }],
        [{ text: 'onUserInteractionIfError', options: KODE }, { text: ': error baru muncul setelah tombol Daftar ditekan, lalu hilang begitu kolomnya diperbaiki.' }],
        'Validasi di aplikasi membantu pengguna; server tetap harus memeriksa ulang.',
      ],
      ukuranPoin: 16,
      catatan: 'Gambar adalah versi pertama contoh 08: baru satu huruf R diketik di kolom Nama, tetapi semua kolom sudah merah. Pengguna dimarahi sebelum sempat mengisi. Mode lain: always (terus-menerus) dan onUnfocus (saat meninggalkan kolom).',
    });

    d.layar({
      judul: 'Dialog dan Bottom Sheet',
      gambar: ['hasil_contoh_09c.jpg', 'hasil_contoh_09b.jpg'],
      berkas: 'kode/contoh_09_dialog_dan_bottom_sheet.dart',
      lebarMaks: 6.0,
      kode: [
        'final bool? yakin = await showDialog<bool>(',
        '  context: context,',
        '  builder: (BuildContext context) {',
        '    // Batal → Navigator.pop(context, false)',
        '    // Hapus → Navigator.pop(context, true)',
        '    return AlertDialog(...);',
        '  },',
        ');',
        'if (!mounted) return; // halaman masih ada?',
        'if (yakin != true) return; // false atau null',
        'setState(() { _daftar.remove(tugas); });',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Hasil bool?: null jika area gelap diketuk.',
        'await membuka celah waktu (async gap).',
      ],
      ukuranPoin: 15,
      catatan: 'showModalBottomSheet<Prioritas> bekerja dengan cara yang sama: Navigator.pop(context, p) mengirim pilihan. Aturan linter use_build_context_synchronously memperingatkan pemakaian context setelah await tanpa pemeriksaan mounted. Di luar class State, gunakan context.mounted.',
    });

    d.tabel({
      judul: 'Dialog, Bottom Sheet, atau SnackBar?',
      kepala: ['Komponen', 'Sifatnya', 'Cocok untuk'],
      lebarKolom: [2.6, 4.0, 5.0],
      baris: [
        [{ text: 'Dialog', options: { bold: true } }, 'Menghentikan pengguna sampai ia menjawab', 'Keputusan penting yang tidak bisa dibatalkan: hapus permanen, konfirmasi bayar'],
        [{ text: 'Bottom sheet', options: { bold: true } }, 'Muncul dari bawah, dekat jempol', 'Pilihan tambahan: pilih prioritas, bagikan, urutkan'],
        [{ text: 'SnackBar', options: { bold: true } }, 'Muncul sebentar, tidak menghentikan', 'Kabar bahwa aksi sudah berhasil, termasuk tombol Batalkan'],
      ],
      ukuran: 17,
      tinggiBaris: 0.95,
      pesan: 'Jangan terlalu sering memakai dialog: pengguna jadi terbiasa menekan OK tanpa membaca.',
      catatan: 'Kuis cepat: konfirmasi keluar dari akun (dialog), memilih urutan daftar (bottom sheet), pesan "Tugas tersimpan" (SnackBar).',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 7', judul: 'Mengangkat State dan Studi Kasus', ikon: 'angkat', catatan: 'Ketika beberapa widget membutuhkan data yang sama, state dipindah ke induknya. Lalu semua konsep dirangkai dalam studi kasus.' });

    d.layar({
      judul: 'Data Turun, Laporan Naik',
      gambar: 'hasil_contoh_10.jpg',
      lebarMaks: 4.4,
      berkas: 'kode/contoh_10_mengangkat_state.dart',
      kode: [
        'class KartuMenu extends StatelessWidget {',
        '  // ... constructor',
        '  final Menu menu;',
        '  final int jumlah; // data TURUN',
        '  final VoidCallback onTambah; // laporan NAIK',
        '  final VoidCallback onKurang;',
        '}',
        '',
        '// di halaman induk (pemilik state):',
        'KartuMenu(',
        '  menu: daftarMenu[i],',
        '  jumlah: _jumlah[i],',
        '  onTambah: () => _ubahJumlah(i, 1),',
        '  onKurang: () => _ubahJumlah(i, -1),',
        ')',
      ].join('\n'),
      ukuranKode: 13,
      poin: [
        'Jika setiap kartu menyimpan jumlahnya sendiri, halaman tidak bisa menghitung total.',
        'VoidCallback = void Function(), sama seperti onPressed.',
      ],
      ukuranPoin: 15,
      catatan: 'Semboyan: data down, events up. Kartu tidak tahu apa yang terjadi saat tombolnya ditekan; ia hanya meneruskan fungsi dari induk, sehingga bisa dipakai di halaman lain dengan perilaku berbeda.',
    });

    d.kode({
      judul: 'Total sebagai Nilai Turunan',
      kode: [
        'final List<int> _jumlah =',
        '    List<int>.filled(daftarMenu.length, 0);',
        '',
        'int get _totalHarga {',
        '  int hasil = 0;',
        '  for (int i = 0; i < daftarMenu.length; i++) {',
        '    hasil += daftarMenu[i].harga * _jumlah[i];',
        '  }',
        '  return hasil;',
        '}',
        '',
        '// Tombol Bayar ikut memakai nilai turunan:',
        'onPressed: _totalPorsi > 0 ? _bayar : null,',
      ].join('\n'),
      ukuran: 14,
      poin: [
        'Total tidak disimpan di variabel sendiri, tetapi dihitung dari _jumlah lewat getter.',
        'Satu kali lupa memperbarui variabel _total sudah cukup membuat angkanya salah. Getter tidak mungkin ketinggalan.',
        'Prinsip: simpan state sesedikit mungkin; hitung sisanya.',
      ],
      catatan: 'Tanyakan sebelum menambah variabel state: bisakah nilai ini dihitung dari state yang sudah ada? Jika bisa, jadikan getter atau variabel lokal di build(). formatRupiah(15000) menghasilkan Rp15.000 dengan menyisipkan titik setiap tiga angka dari kanan.',
    });

    d.layar({
      judul: 'Studi Kasus: Memesan Menu Kantin',
      gambar: ['hasil_contoh_11b.jpg', 'hasil_contoh_11c.jpg'],
      lebarMaks: 6.0,
      berkas: 'kode/contoh_11_studi_kasus_pesan_menu.dart',
      poin: [
        'State: porsi, level pedas, tambahan, catatan, jumlah, favorit.',
        'Nilai turunan: harga satuan, total, keterangan pedas.',
        'SegmentedButton, Slider, FilterChip, TextField, TombolJumlah.',
        'Label tombol Pesan ikut menampilkan total.',
        'Pesan → dialog → mounted → SnackBar → kembali ke awal.',
        'Cek manual: (18.000 + 5.000 + 3.000 + 2.000) × 2 = 56.000.',
      ],
      ukuranPoin: 15,
      catatan: 'Mulai dari tabel: daftar state dulu, lalu nilai turunannya. Favorit sengaja tidak dikembalikan setelah memesan, karena favorit adalah tanda menyukai menu, bukan bagian dari satu pesanan.',
    });

    d.kartu({
      judul: 'Pelajaran dari Pengujian',
      pengantar: 'Tiga masalah di contoh hari ini ditemukan dengan mencoba aplikasinya, bukan dengan membaca kode:',
      kolom: 3,
      tinggiKartu: 2.6,
      item: [
        { ikon: 'formulir', judul: 'Keyboard muncul lagi', isi: 'Setelah dialog ditutup, kolom catatan aktif lagi. Diperbaiki dengan primaryFocus?.unfocus().' },
        { ikon: 'ukur', judul: 'Label terpotong di 320', isi: '"Sedang" pecah menjadi dua baris. Diperbaiki dengan showSelectedIcon: false.' },
        { ikon: 'peringatan', judul: 'Formulir terlalu galak', isi: 'Satu huruf diketik, semua kolom merah. Diperbaiki dengan onUserInteractionIfError.' },
      ],
      catatan: 'Ajak mahasiswa membiasakan diri: tekan setiap tombol, isi lalu tutup dialog, batalkan pilihan, coba nilai terkecil dan terbesar, dan uji di lebar 320 serta 360.',
    });

    d.tabel({
      judul: 'Kesalahan Umum Pemula',
      kepala: ['Pesan error / gejala', 'Penyebab dan solusi'],
      lebarKolom: [6.0, 5.2],
      baris: [
        ["The method 'setState' isn't defined for the type '...'.", 'setState di StatelessWidget: ubah menjadi StatefulWidget'],
        ['Variabel berubah, layar tidak', 'Lupa setState: bungkus perubahannya dengan setState'],
        ["This expression has a type of 'void' so its value can't be used.", 'onPressed: _fungsi() → onPressed: _fungsi'],
        ['setState() called after dispose()', 'Setelah await: tambahkan if (!mounted) return;'],
        ['Switch tidak bergeser, Checkbox tidak tercentang', 'onChanged tidak menyimpan nilai baru dengan setState'],
        ['Ketikan hilang, kursor melompat', 'Controller dibuat di build(): buat sekali sebagai properti State'],
        ['SnackBar dengan Batalkan tidak pernah hilang', 'Tambahkan persist: false'],
      ],
      ukuran: 14,
      catatan: 'Tabel lengkap ada di modul bagian 14, termasuk pesan deprecated untuk Radio cara lama dan DropdownButtonFormField(value:).',
    });

    d.ringkasan({
      poin: [
        'State = data yang berubah dan terlihat di layar; tampilan = f(state).',
        'StatefulWidget: class widget (final) + class State (data + build).',
        'setState() mengubah data lalu build() berjalan lagi; onPressed: null = nonaktif.',
        'Tombol Material 3, InkWell, GestureDetector, SnackBar + Batalkan.',
        'Pemilih nilai: value + onChanged; RadioGroup, SegmentedButton, Slider, Chip.',
        'Siklus hidup: initState sekali, build berkali-kali, dispose untuk bersih-bersih.',
        'Controller dibuang di dispose; validator null = benar; periksa mounted setelah await.',
        'Angkat state ke induk: data turun, laporan naik; hitung nilai turunan.',
      ],
      catatan: 'Minta mahasiswa menyebutkan state dan nilai turunan pada halaman Pesan Menu Kantin.',
    });

    d.penutup({
      judul: 'Saatnya Praktik!',
      subjudul: 'Kerjakan Jobsheet Pertemuan 5 (lima praktikum + tugas Peminjaman Alat Lab), lalu uji diri di Latihan. Pertemuan berikutnya: daftar data dan navigasi antarhalaman.',
      tautan: [
        { teks: 'Jobsheet P5', ikon: 'tugas', url: d.urlBerkas('pertemuan_05_interaksi_dan_state/JOBSHEET.md') },
        { teks: 'Latihan P5', ikon: 'kuis', url: d.urlBerkas('pertemuan_05_interaksi_dan_state/LATIHAN.md') },
        { teks: 'Modul P5', ikon: 'buku', url: d.urlBerkas('pertemuan_05_interaksi_dan_state/README.md') },
      ],
      catatan: 'Ingatkan: tugas mandiri wajib diuji seperti pengguna sungguhan (isian salah, batal dialog, ajukan sampai berhasil) dan bebas overflow di lebar 360 dan 320.',
    });
  },
};

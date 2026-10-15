// Konten slide Pertemuan 10 — Asinkron & Integrasi REST API.
// Teks diambil dari modul bacaan (pertemuan_10_async_dan_rest_api/README.md).
// Tangkapan layar diambil dari folder pertemuan_10_async_dan_rest_api/gambar/.

module.exports = {
  nomor: '10',
  folder: 'pertemuan_10_async_dan_rest_api',
  namaBerkas: 'PERTEMUAN_10_Async_dan_REST_API',
  topik: 'Asinkron & REST API',

  bangun(d) {
    const C = d.C;
    const KODE = { fontFace: 'Consolas' };
    const kode = (teks) => ({ text: teks, options: KODE });

    d.judul({
      judul: 'Asinkron & Integrasi REST API',
      subjudul: 'Pertemuan 10  ·  HTTP dan JSON, paket http, pola Dart 3 untuk fromJson, FutureBuilder, galat jaringan, layanan dan repository, parameter query, debounce, POST/PATCH/DELETE, dan menguji dengan MockClient',
      catatan: 'Sampai Pertemuan 9, semua data ditulis di kode, termasuk repository palsu. Hari ini data diambil dari server sungguhan lewat internet. Bekal: Future, async/await, dan exception (P3); ListView (P6); ChangeNotifier, provider, MVVM, repository, dan status memuat (P9). Hampir semua contoh butuh internet; server latihan: DummyJSON dan Open-Meteo (gratis, tanpa pendaftaran).',
    });

    d.tujuan({
      pengantar: 'Setelah pertemuan ini, Anda mampu:',
      poin: [
        'Menjelaskan alamat, metode, header, kode status, dan body HTTP',
        'Mengirim GET, POST, PATCH, dan DELETE dengan paket http',
        'Mengubah JSON menjadi Model dengan pola Dart 3, dan sebaliknya',
        'Menampilkan data yang butuh waktu dengan FutureBuilder atau ViewModel',
        'Membedakan jenis galat jaringan dan menampilkan pesan yang ramah',
        'Menata lapisan data menjadi layanan dan repository',
        'Membuat pencarian dengan query, debounce, dan "muat lebih banyak"',
        'Menguji lapisan data tanpa internet dengan MockClient',
      ],
      catatan: 'Target akhir hari ini: aplikasi Cuaca Kampus. Prakiraan cuaca delapan kota diambil dari internet, ditata dengan MVVM, menampilkan status memuat dan pesan galat yang ramah, bisa ditarik untuk menyegarkan, dan diuji tanpa koneksi internet. Untuk proyek akhir: hari ini adalah saat yang tepat untuk mencoba API pilihan tim.',
    });

    d.alur({
      judul: 'Peta Materi Hari Ini',
      langkah: [
        { ikon: 'awan', judul: 'A. Dasar komunikasi', isi: 'HTTP dan JSON (Bagian 1–3)' },
        { ikon: 'unduh', judul: 'B. Paket http & model', isi: 'Permintaan pertama, membaca jawaban, fromJson (4–6)' },
        { ikon: 'jam', judul: 'C. Menunggu & galat', isi: 'FutureBuilder, empat jenis kegagalan, pesan ramah (7–8)' },
        { ikon: 'lapisan', judul: 'D. Lapisan data', isi: 'Layanan, repository, query, POST/PATCH/DELETE, MockClient (9–12)' },
        { ikon: 'cuaca', judul: 'E. Studi kasus', isi: 'Cuaca Kampus, web dan Android (13–14)', warna: C.accent4 },
      ],
      catatan: 'Bagian A menjawab: bagaimana aplikasi berbicara dengan server, dan apa bahasanya? Bagian B: bagaimana mengirim permintaan dari Flutter dan mengubah jawabannya menjadi objek Dart. Bagian C: bagaimana menampilkan data yang butuh waktu dan menangani kegagalan. Bagian D: di mana kode jaringan sebaiknya ditulis agar rapi, mudah diganti, dan mudah diuji. Bagian E: merangkai semuanya.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 1', judul: 'Aplikasi yang Berbicara dengan Server', ikon: 'awan', catatan: 'Data aplikasi sungguhan tinggal di server. Aplikasi (klien) memintanya lewat internet setiap kali dibutuhkan.' });

    d.tabel({
      judul: 'Analogi: Loket Layanan Akademik',
      kepala: ['Di loket layanan akademik', 'Di dunia aplikasi'],
      lebarKolom: [5.9, 5.7],
      baris: [
        ['Mengisi formulir permintaan, menyerahkannya ke loket tertentu', 'Aplikasi mengirim permintaan (request) ke alamat tertentu'],
        ['"Minta transkrip", "ajukan cuti", "batalkan cuti"', 'Metode: GET (minta), POST (kirim baru), PATCH (ubah), DELETE (hapus)'],
        ['Petugas memproses lalu memberi jawaban', 'Server mengirim jawaban (response)'],
        ['Stempel: "selesai", "tidak ditemukan", "loket tutup"', 'Kode status: 200 (berhasil), 404 (tidak ditemukan), 503 (tidak tersedia)'],
        ['Dokumen yang diterima', 'Body: isi jawaban, biasanya JSON'],
        ['Menunggu sambil tetap bisa melakukan hal lain', 'await: aplikasi menunggu tanpa membeku'],
      ],
      ukuran: 15,
      tinggiBaris: 0.7,
      catatan: 'Keuntungan data di server: cukup diperbarui di satu tempat, semua pengguna langsung melihat data terbaru tanpa memperbarui aplikasinya. Coba langsung di kelas: buka https://dummyjson.com/todos/1 di browser. Yang tampil bukan halaman web yang indah, melainkan teks data. Itulah yang akan dibaca aplikasi.',
    });

    d.tabel({
      judul: 'REST API: Alamat untuk Data, Metode untuk Tindakan',
      pengantar: 'API = "loket" yang disediakan server. Contoh dari server latihan DummyJSON:',
      kepala: ['Permintaan', 'Artinya'],
      lebarKolom: [6.4, 5.2],
      baris: [
        [kode('GET https://dummyjson.com/todos'), 'Minta daftar tugas'],
        [kode('GET https://dummyjson.com/todos/1'), 'Minta tugas nomor 1'],
        [kode('POST https://dummyjson.com/todos/add'), 'Kirim tugas baru'],
        [kode('PATCH https://dummyjson.com/todos/1'), 'Ubah sebagian isi tugas nomor 1'],
        [kode('DELETE https://dummyjson.com/todos/1'), 'Hapus tugas nomor 1'],
      ],
      ukuran: 16,
      tinggiBaris: 0.58,
      pesan: 'Cek cepat: menghapus produk nomor 7? → DELETE https://dummyjson.com/products/7',
      catatan: 'REST adalah gaya API yang paling umum: setiap jenis data punya alamat sendiri, dan metode menentukan apa yang ingin dilakukan terhadap data itu. Server lain (misalnya API kampus) memakai pola yang sama, hanya alamatnya berbeda.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 2', judul: 'Anatomi Permintaan dan Jawaban HTTP', ikon: 'server', catatan: 'HTTP adalah aturan percakapan antara klien dan server: alamat, metode, header, kode status, dan body.' });

    d.kode({
      judul: 'Alamat (URL) dan Metode',
      kode: [
        'https://dummyjson.com/products/search?q=phone&limit=10',
        '',
        '# dipecah menjadi:',
        'skema  : https',
        'host   : dummyjson.com',
        'jalur  : /products/search',
        'query  : q=phone & limit=10',
      ].join('\n'),
      shell: true,
      ukuran: 14,
      lebarKode: 7.6,
      poin: [
        'Skema: selalu https (terenkripsi).',
        'Host: nama server. Jalur: data yang diminta.',
        'Query: nama=nilai setelah ?, dipisah &.',
        'GET mengambil, POST mengirim data baru, PUT mengganti seluruh data, PATCH mengubah sebagian, DELETE menghapus.',
      ],
      catatan: 'PUT jarang dipakai di contoh kita: untuk mengubah satu kolom (misalnya mencentang tugas), PATCH lebih hemat karena hanya mengirim kolom yang berubah. Parameter query nanti dibuat dengan Uri.https agar spasi dan huruf khusus dikodekan otomatis (Bagian 10).',
    });

    d.tabel({
      judul: 'Kode Status: Stempel pada Jawaban',
      kepala: ['Kode', 'Arti', 'Kelompok'],
      lebarKolom: [1.4, 6.6, 3.6],
      baris: [
        [kode('200'), 'OK: permintaan berhasil', '2xx: berhasil'],
        [kode('201'), 'Created: data baru berhasil dibuat', '2xx: berhasil'],
        [kode('400'), 'Bad Request: permintaan salah bentuk', '4xx: salah di sisi aplikasi'],
        [kode('401'), 'Unauthorized: belum masuk (login)', '4xx: salah di sisi aplikasi'],
        [kode('404'), 'Not Found: data tidak ditemukan', '4xx: salah di sisi aplikasi'],
        [kode('429'), 'Too Many Requests: terlalu sering meminta', '4xx: salah di sisi aplikasi'],
        [kode('500'), 'Internal Server Error: server mengalami galat', '5xx: salah di sisi server'],
        [kode('503'), 'Service Unavailable: server sedang tidak tersedia', '5xx: salah di sisi server'],
      ],
      ukuran: 14,
      tinggiBaris: 0.47,
      pesan: '2xx berhasil, 4xx periksa permintaan kita, 5xx tunggu servernya pulih.',
      catatan: 'Tabel lengkap di modul Bagian 2.4 juga memuat 204 No Content dan 403 Forbidden. Cek cepat: server menjawab 401. Siapa yang perlu memperbaiki sesuatu? Aplikasi (kelompok 4xx): permintaan dikirim tanpa tanda pengenal yang sah, misalnya pengguna belum masuk atau tokennya kedaluwarsa.',
    });

    d.kartu({
      judul: 'Header dan Body',
      pengantar: 'Header = keterangan tambahan berbentuk "Nama: nilai", seperti kolom "perihal" pada formulir.',
      kolom: 3,
      tinggiKartu: 3.3,
      item: [
        { ikon: 'unduh', judul: 'Accept', isi: 'Dikirim klien: "Tolong jawab dalam format JSON."', kode: 'Accept: application/json' },
        { ikon: 'kirim', judul: 'Content-Type', isi: 'Saat mengirim data: "Isi yang saya kirim berformat JSON."', kode: 'Content-Type:\n  application/json' },
        { ikon: 'kunci', judul: 'Authorization', isi: 'Tanda pengenal pengguna yang sudah masuk, untuk API yang butuh akun.', kode: 'Authorization:\n  Bearer ...' },
      ],
      catatan: 'Body adalah isi utama permintaan atau jawaban. Pada GET, permintaan biasanya tanpa body, sedangkan jawabannya berisi data. Pada POST dan PATCH, permintaan berisi data yang dikirim. Hampir semua REST API modern memakai JSON untuk body. Lupa Content-Type saat mengirim JSON adalah kesalahan yang sangat sering (Praktikum 4 membuktikannya).',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 3', judul: 'JSON: Bahasa Pertukaran Data', ikon: 'data', catatan: 'Format teks untuk data terstruktur, sangat mirip Map dan List di Dart.' });

    d.kode({
      judul: 'Bentuk JSON',
      kode: [
        '{',
        '  "id": 1,',
        '  "todo": "Do something nice for someone you care about",',
        '  "completed": false,',
        '  "userId": 152',
        '}',
      ].join('\n'),
      shell: true,
      ukuran: 13,
      lebarKode: 7.6,
      poin: [
        'Objek { } → Map<String, dynamic>',
        'Larik [ ] → List<dynamic>',
        'Teks "..." → String; angka → int/double',
        'true/false → bool; null → null',
        'Wajib petik dua; tidak boleh ada koma setelah unsur terakhir.',
      ],
      catatan: 'Ini jawaban GET https://dummyjson.com/todos/1 (isinya bisa berbeda di server). {\'id\': 1} (petik satu) atau {"id": 1,} (koma terakhir) bukan JSON yang sah. Data dari DummyJSON berbahasa Inggris; tulisan di aplikasi kita tetap berbahasa Indonesia.',
    });

    d.banding({
      judul: 'jsonDecode dan jsonEncode (dart:convert)',
      ukuranContoh: 13,
      kolom: [
        {
          ikon: 'unduh', judul: 'jsonDecode', warna: C.accent1, tag: 'Teks JSON → Map/List (MENERIMA)',
          poin: [
            'Hasilnya bertipe dynamic',
            'as Map<String, dynamic> = "saya yakin isinya objek"',
            'Jika teksnya bukan JSON: FormatException',
          ],
          contoh: "final Map<String, dynamic> tugas =\n    jsonDecode('{\"id\": 1}')\n        as Map<String, dynamic>;",
        },
        {
          ikon: 'kirim', judul: 'jsonEncode', warna: C.accent6, tag: 'Map/List → teks JSON (MENGIRIM)',
          poin: [
            'Dipakai sebelum POST dan PATCH',
            'Kunci dan teks otomatis berpetik dua',
            'Hasilnya satu baris tanpa spasi',
          ],
          contoh: "jsonEncode({'todo': 'Tidur',\n  'completed': true});\n// {\"todo\":\"Tidur\",\"completed\":true}",
        },
      ],
      pesan: 'as hanya "janji". Jika ternyata bukan objek, aplikasi error saat berjalan. Bagian 6 menunjukkan cara yang lebih aman: pola.',
      catatan: 'Keduanya ada di pustaka bawaan dart:convert, tidak perlu paket tambahan.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 4', judul: 'Paket http: Permintaan Pertama', ikon: 'unduh', catatan: 'Paket resmi tim Dart untuk mengirim permintaan HTTP.' });

    d.kode({
      judul: 'Memasang dan Memakai Paket http',
      kode: [
        '# sekali, di folder proyek',
        'flutter pub add http',
        '',
        '// di bagian atas berkas Dart',
        "import 'package:http/http.dart' as http;",
        '',
        'http.get(...)      // fungsi dari paket',
        'http.Response      // class dari paket',
      ].join('\n'),
      shell: true,
      ukuran: 15,
      lebarKode: 6.6,
      poin: [
        'as http = awalan (prefix): semua isi paket dipanggil dengan http.',
        'Tanpa awalan, get bisa tertukar dengan nama lain, dan pembaca sulit tahu asalnya.',
        'DartPad sudah menyediakan paket http.',
      ],
      catatan: 'Flutter tidak membawa alat pengirim permintaan HTTP yang praktis secara bawaan, jadi kita memakai paket resmi http. flutter pub add menambahkan baris http di bagian dependencies pada pubspec.yaml.',
    });

    d.layar({
      judul: 'Contoh 01: Kutipan Acak',
      gambar: 'hasil_contoh_01.jpg',
      berkas: 'kode/contoh_01_permintaan_pertama.dart',
      kode: [
        'final http.Response respons = await http.get(',
        "  Uri.parse('https://dummyjson.com/quotes/random'),",
        "  headers: {'Accept': 'application/json'},",
        ');',
        'if (!mounted) return;',
        'if (respons.statusCode == 200) {',
        '  final Map<String, dynamic> json =',
        '      jsonDecode(respons.body) as Map<String, dynamic>;',
        "  setState(() => _kutipan = json['quote'] as String);",
        '} else {',
        '  // "Server menjawab dengan kode ..."',
        '}',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'http.get menerima Uri, bukan String. Hasilnya Future<http.Response>.',
        'statusCode = kode status; body = teks JSON.',
        'catch menangkap kegagalan saat TIDAK ADA jawaban (misalnya tanpa internet).',
      ],
      ukuranPoin: 15,
      catatan: 'Potongan ini diringkas dari _ambilKutipan di Contoh 01 (kode lengkap memakai blok try/catch dan mengubah _memuat/_galat). if (!mounted) return; mencegah setState pada halaman yang sudah ditutup selama menunggu (P5). Mengapa aplikasi tidak membeku? Fungsi berhenti sejenak di await, sementara Flutter tetap menggambar layar. Cek cepat: mengapa tombol Kutipan lain dinonaktifkan selama memuat? Agar tidak terkirim beberapa permintaan sekaligus yang jawabannya datang dalam urutan tak pasti.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 5', judul: 'Membedah Jawaban Server', ikon: 'lihat', catatan: 'Contoh 02 adalah "penjelajah respons": kode status, jenis isi, lama menunggu, dan isi jawaban.' });

    d.layar({
      judul: 'Contoh 02: Penjelajah Respons',
      gambar: ['hasil_contoh_02a.jpg', 'hasil_contoh_02b.jpg'],
      lebarMaks: 6.4,
      berkas: 'kode/contoh_02_anatomi_respons.dart',
      poin: [
        '/quotes/1 → 200, JSON satu kutipan.',
        '/quotes/99999 → 404, JSON berisi pesan "not found".',
        '/http/500/... → 500 (alamat latihan galat server).',
        '/quotes/2?delay=3000 → 200 setelah ± 3 detik.',
        'Host .invalid → TIDAK ADA kode status: yang muncul exception.',
      ],
      ukuranPoin: 15,
      catatan: 'Kiri: percobaan Tidak ditemukan (kode 404 berwarna merah, isi JSON pesan galat). Kanan: percobaan Alamat salah (tulisan merah Tidak ada jawaban, exception ClientException). Parameter delay adalah fitur DummyJSON untuk meniru server yang lambat.',
    });

    d.banding({
      judul: 'Dua Pelajaran Terpenting',
      kolom: [
        {
          ikon: 'server', judul: 'Kode 404 dan 500 tetap JAWABAN', warna: C.accent4, tag: 'Periksa statusCode',
          poin: [
            'Paket http tidak melempar exception untuk kode status apa pun',
            'Tanpa pemeriksaan, isi pesan galat dibaca seolah-olah data',
          ],
          contoh: 'if (respons.statusCode != 200) {\n  throw ApiException(\n      respons.statusCode);\n}',
        },
        {
          ikon: 'awanputus', judul: 'Exception = tidak ada jawaban', warna: C.accent5, tag: 'Tangkap dengan catch',
          poin: [
            'Alamat server tidak ada atau koneksi putus',
            'Di web: server menolak dipanggil dari browser (CORS, Bagian 14)',
          ],
          contoh: 'try {\n  ...\n} catch (galat) {\n  // tidak ada jawaban\n}',
        },
      ],
      catatan: 'Cek cepat: teman menulis final data = jsonDecode(respons.body); tanpa memeriksa statusCode. Saat server menjawab 404? Tidak ada exception dari http; jsonDecode membaca JSON pesan galat, lalu data[\'quote\'] bernilai null. Aplikasi menampilkan data kosong atau pesan yang membingungkan.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 6', judul: 'Dari JSON Menjadi Model', ikon: 'kelas', catatan: 'Ubah data menjadi objek Model satu kali, di satu tempat, lalu seluruh aplikasi memakai objek itu.' });

    d.kode({
      judul: 'Factory fromJson dengan Pola Dart 3',
      berkas: 'kode/contoh_03_json_dan_model.dart',
      kode: [
        'factory Produk.fromJson(Map<String, dynamic> json) {',
        '  return switch (json) {',
        '    {',
        "      'id': int id,",
        "      'title': String judul,",
        "      'price': num harga,",
        "      'stock': int stok,",
        "      'rating': num rating,",
        '    } =>',
        '      Produk(',
        '        id: id, judul: judul,',
        '        harga: harga.toDouble(),',
        '        stok: stok, rating: rating.toDouble(),',
        '      ),',
        "    _ => throw const FormatException(",
        "        'Bentuk data produk tidak sesuai'),",
        '  };',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 6.6,
      poin: [
        'Pola map: cabang dipilih jika SEMUA kunci yang disebut ada DAN tipenya cocok.',
        "'id': int id = memeriksa sekaligus mengambil.",
        'num + toDouble(): JSON tidak membedakan 15 dan 9.99.',
        '_ => throw: bentuk salah langsung ketahuan.',
        'Kunci JSON (title) boleh berbeda dari nama properti (judul).',
      ],
      catatan: 'Kode di slide sedikit dirapatkan; versi lengkapnya di Contoh 03. Jangan memakai pola double untuk angka dari JSON: di web, angka 15 bisa ikut dianggap double sehingga kesalahan tidak terlihat di Chrome, tetapi di Android 15 adalah int, polanya tidak cocok, dan muncul FormatException. Mengapa tidak memakai Map langsung? json[\'qoute\'] (salah ketik) diam-diam menghasilkan null, editor tidak memberi saran, dan pemeriksaan tipe tersebar di banyak tempat.',
    });

    d.kode({
      judul: 'Membaca Daftar dan Data yang Bentuknya Salah',
      berkas: 'kode/contoh_03_json_dan_model.dart',
      kode: [
        'final List<Produk> daftar = switch (data) {',
        "  {'products': List<dynamic> isi} =>",
        '    isi',
        '        .map((dynamic item) =>',
        '            Produk.fromJson(item as Map<String, dynamic>))',
        '        .toList(),',
        "  _ => throw const FormatException(",
        "      'Kunci \"products\" tidak ditemukan'),",
        '};',
        '',
        '// Output Contoh 03, bagian 3:',
        '// Harga berupa teks -> FormatException: ...',
        '// Kolom tidak lengkap -> FormatException: ...',
        '// Teks bukan JSON yang sah -> FormatException',
        '// Salah tulis kunci "produk" -> hasilnya null',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.2,
      poin: [
        'Jawaban daftar biasanya objek yang berisi larik: {"products": [...], "total": 194}.',
        'Paling berbahaya: salah tulis kunci TIDAK menimbulkan error, hanya null.',
        'Kebalikannya: toJson() → jsonEncode untuk mengirim.',
      ],
      ukuranPoin: 15,
      catatan: 'Contoh 03 adalah program konsol tanpa internet. Cek cepat: server mengubah stock dari 99 menjadi "99" (teks). Apa yang terjadi? Pola \'stock\': int stok tidak cocok, cabang _ dipilih, FormatException dilempar. Kesalahan langsung ketahuan di satu tempat. Untuk puluhan model, ada pembuat kode otomatis seperti json_serializable; di kuliah ini kita menulisnya sendiri agar paham.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 7', judul: 'FutureBuilder dan Jebakannya', ikon: 'jam', catatan: 'Widget bawaan yang menampilkan tampilan berbeda sesuai keadaan sebuah Future.' });

    d.kode({
      judul: 'FutureBuilder: Tiga Keadaan',
      berkas: 'kode/contoh_04_futurebuilder.dart',
      kode: [
        'FutureBuilder<List<Tugas>>(',
        '  future: _tugas, // Future yang SUDAH disimpan',
        '  builder: (BuildContext context,',
        '      AsyncSnapshot<List<Tugas>> snapshot) {',
        '    if (snapshot.connectionState != ConnectionState.done) {',
        '      return const Center(',
        '          child: CircularProgressIndicator());',
        '    }',
        '    if (snapshot.hasError) {',
        "      return Text('Gagal memuat: ${snapshot.error}');",
        '    }',
        '    final List<Tugas> daftar = snapshot.data!;',
        '    return ListView.builder(/* ... */);',
        '  },',
        ')',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.0,
      poin: [
        'snapshot = "potret" keadaan Future saat ini.',
        'connectionState: waiting (menunggu) atau done (selesai).',
        'hasError / error: selesai dengan error.',
        'data: hasilnya jika berhasil.',
      ],
      catatan: 'Contoh 04 menampilkan sepuluh tugas dari https://dummyjson.com/todos. Untuk meminta data baru dengan sengaja (tombol muat ulang), GANTI Future yang disimpan di dalam setState: setState(() { _tugas = ambilTugas(); });',
    });

    d.layar({
      judul: 'Jebakan: Membuat Future di Dalam build',
      gambar: 'hasil_contoh_04.jpg',
      berkas: 'kode/contoh_04_futurebuilder.dart',
      kode: [
        '// SALAH: permintaan baru setiap build()',
        'Widget build(BuildContext context) {',
        '  return FutureBuilder<List<Tugas>>(',
        '    future: ambilTugas(),',
        '    builder: /* ... */,',
        '  );',
        '}',
        '',
        '// BENAR: dibuat sekali, lalu disimpan',
        'late Future<List<Tugas>> _tugas;',
        'void initState() {',
        '  super.initState();',
        '  _tugas = ambilTugas();',
        '}',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'build boleh berjalan kapan saja: setState, ukuran layar berubah, tema berganti.',
        'Nyalakan sakelar "cara salah", tekan Bangun ulang layar: angka Permintaan terkirim terus bertambah.',
      ],
      ukuranPoin: 15,
      catatan: 'Cek cepat: FutureBuilder menampilkan lingkaran memuat setiap kali pengguna mengetik di kolom pencarian. Penyebabnya? Future dibuat di build: setiap ketikan memanggil setState, build berjalan lagi, Future baru dibuat. Simpan Future di initState, atau pindahkan logikanya ke ViewModel. Pilihan alat: FutureBuilder untuk halaman sederhana yang hanya menampilkan hasil satu permintaan; ViewModel jika ada pencarian, saringan, muat lebih banyak, mengirim data, atau logika yang perlu diuji.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 8', judul: 'Menangani Galat Jaringan', ikon: 'awanputus', catatan: 'Setiap kegagalan diubah menjadi exception yang jelas jenisnya, lalu diterjemahkan menjadi pesan yang ramah.' });

    d.tabel({
      judul: 'Empat Jenis Kegagalan',
      kepala: ['Yang terjadi', 'Exception', 'Dari mana'],
      lebarKolom: [4.6, 3.4, 3.6],
      baris: [
        ['Tidak ada koneksi, alamat server salah', kode('http.ClientException'), 'Paket http'],
        ['Server terlalu lama menjawab', kode('TimeoutException'), '.timeout(...) yang kita pasang'],
        ['Kode status bukan 200', kode('ApiException'), 'Pemeriksaan statusCode (buatan kita)'],
        ['Isi bukan JSON, atau bentuknya salah', kode('FormatException'), 'jsonDecode atau pola di fromJson'],
      ],
      ukuran: 16,
      tinggiBaris: 0.75,
      pesan: 'Tanpa batas waktu, permintaan ke server yang tidak menjawab bisa menggantung sangat lama. Aplikasi sungguhan: 10–15 detik.',
      catatan: 'Contoh 05 menyiapkan enam skenario: normal, lambat 5 detik (batas waktu contoh 3 detik agar mudah diamati), tidak ditemukan, server error 503, bukan JSON (gambar), dan tanpa koneksi.',
    });

    d.kode({
      judul: 'Fungsi Pengambil yang Melempar Galat yang Jelas',
      berkas: 'kode/contoh_05_menangani_galat.dart',
      kode: [
        'class ApiException implements Exception {',
        '  const ApiException(this.kodeStatus);',
        '  final int kodeStatus;',
        '}',
        '',
        'Future<Map<String, dynamic>> ambilJson(Uri alamat) async {',
        '  final http.Response respons = await http',
        "      .get(alamat, headers: {'Accept': 'application/json'})",
        '      .timeout(batasWaktu); // TimeoutException',
        '  if (respons.statusCode != 200) {',
        '    throw ApiException(respons.statusCode);',
        '  }',
        '  // FormatException jika bukan JSON',
        '  final Object? data = jsonDecode(respons.body);',
        '  if (data is! Map<String, dynamic>) {',
        "    throw const FormatException('Bentuk JSON tidak dikenal');",
        '  }',
        '  return data;',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.6,
      poin: [
        'Kode status diperiksa SEBELUM jsonDecode.',
        'Satu fungsi, empat kemungkinan exception yang jelas.',
      ],
      ukuranPoin: 16,
      catatan: 'Versi lengkap ApiException juga punya toString() => \'ApiException: kode status $kodeStatus\' agar mudah dibaca di konsol. Fungsi ini nanti dipindahkan ke layanan (Bagian 9).',
    });

    d.layar({
      judul: 'Dari Exception Menjadi Pesan yang Ramah',
      gambar: ['hasil_contoh_05a.jpg', 'hasil_contoh_05b.jpg'],
      lebarMaks: 5.6,
      berkas: 'kode/contoh_05_menangani_galat.dart',
      kode: [
        'String pesanRamah(Object galat) {',
        '  return switch (galat) {',
        "    TimeoutException() =>",
        "      'Server terlalu lama menjawab...',",
        "    ApiException(kodeStatus: 404) =>",
        "      'Data yang dicari tidak ditemukan.',",
        "    ApiException(kodeStatus: >= 500) =>",
        "      'Server sedang bermasalah...',",
        "    ApiException() => 'Permintaan ditolak...',",
        "    FormatException() => 'Data ... tidak bisa dibaca.',",
        "    http.ClientException() =>",
        "      'Tidak dapat terhubung...',",
        "    _ => 'Terjadi kesalahan yang tidak terduga.',",
        '  };',
        '}',
      ].join('\n'),
      ukuranKode: 11,
      poin: [
        'Pola objek: tipe DAN isi properti (kodeStatus: 404, >= 500).',
        'Urutan penting: yang khusus SEBELUM yang umum.',
        'Detail teknis → debugPrint; pengguna → kalimat jelas + Coba lagi.',
      ],
      ukuranPoin: 15,
      catatan: 'Teks pesan di slide disingkat dengan ...; kalimat lengkapnya di modul Bagian 8.2. Cek cepat: jika ApiException() ditulis sebelum ApiException(kodeStatus: 404), pesan untuk 404? "Permintaan ditolak oleh server." karena switch berhenti di cabang pertama yang cocok; analyzer juga memberi peringatan bahwa cabang 404 tidak mungkin tercapai. Contoh 05 menampilkan detail teknis di layar hanya untuk belajar.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 9', judul: 'Lapisan Data: Layanan dan Repository', ikon: 'lapisan', catatan: 'Panduan arsitektur resmi Flutter membagi lapisan data menjadi layanan (service) dan repository.' });

    d.lapisan({
      judul: 'Siapa Mengerjakan Apa?',
      lapisan: [
        { ikon: 'hp', judul: 'View (widget)', isi: 'Menampilkan dan meneruskan perintah pengguna' },
        { ikon: 'restoran', judul: 'ViewModel', isi: 'State halaman dan perintah (Pertemuan 9)', warna: C.accent6 },
        { ikon: 'gudang', judul: 'Repository', isi: 'Sumber data bagi ViewModel: JSON → Model', warna: C.accent4 },
        { ikon: 'kurir', judul: 'Layanan (service)', isi: 'HTTP + JSON: alamat, permintaan, kode status. Tanpa state, tanpa Model', warna: C.accent5 },
        { ikon: 'server', judul: 'Server (REST API)', isi: 'DummyJSON, Open-Meteo, API kampus, ...', warna: C.text2 },
      ],
      keterangan: [
        'Analogi restoran P9 berlanjut: repository = bagian pembelian bahan.',
        'Layanan = KURIR ke pasar: tahu cara pergi, membeli, dan membawa pulang.',
        'Kurir tidak memutuskan menu apa yang dimasak.',
      ],
      catatan: 'Contoh 06 mengambil pengumuman dari https://dummyjson.com/posts dengan susunan ini. Cek cepat: server pengumuman pindah ke api.kampus.ac.id. Yang diubah? Hanya layanan (misalnya konstanta _host). Jika bentuk JSON-nya juga berbeda, cukup repository.',
    });

    d.kode({
      judul: 'Layanan: Satu Tempat untuk Urusan HTTP',
      berkas: 'kode/contoh_06_layanan_dan_repository.dart',
      kode: [
        'class LayananDummyJson {',
        '  LayananDummyJson({http.Client? klien})',
        '      : _klien = klien ?? http.Client();',
        "  static const String _host = 'dummyjson.com';",
        '  final http.Client _klien;',
        '',
        '  Future<Map<String, dynamic>> ambilJson(String jalur,',
        '      {Map<String, String>? query}) async {',
        '    final Uri alamat = Uri.https(_host, jalur, query);',
        '    final http.Response respons = await _klien',
        "        .get(alamat, headers: {'Accept': 'application/json'})",
        '        .timeout(_batasWaktu);',
        '    if (respons.statusCode != 200) {',
        '      throw ApiException(respons.statusCode);',
        '    }',
        '    return switch (jsonDecode(utf8.decode(respons.bodyBytes))) {',
        '      final Map<String, dynamic> data => data,',
        "      _ => throw const FormatException('...'),",
        '    };',
        '  }',
        '  void tutup() => _klien.close();',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.4,
      poin: [
        'http.Client: satu "saluran" untuk banyak permintaan; WAJIB ditutup.',
        'Diterima lewat constructor → bisa diganti server tiruan (Bagian 12).',
        'Uri.https: alamat aman dari potongan-potongannya.',
        'utf8.decode(bodyBytes): huruf é atau ° tidak menjadi Ã©.',
      ],
      ukuranPoin: 14,
      catatan: 'Kode di slide sedikit dirapatkan. Di main, layanan dititipkan dengan Provider<LayananDummyJson>(create: ..., dispose: (context, layanan) => layanan.tutup()), sehingga ditutup otomatis saat aplikasi selesai. Jika server lupa menyebutkan charset di Content-Type, respons.body membacanya dengan aturan lama sehingga huruf seperti é menjadi tulisan aneh.',
    });

    d.layar({
      judul: 'Repository: JSON Menjadi Model',
      gambar: 'hasil_contoh_06.jpg',
      berkas: 'kode/contoh_06_layanan_dan_repository.dart',
      kode: [
        'class RepositoriPengumumanApi',
        '    implements RepositoriPengumuman {',
        '  @override',
        '  Future<List<Pengumuman>> ambilSemua() async {',
        '    final Map<String, dynamic> json =',
        '        await _layanan.ambilJson(',
        "      '/posts',",
        "      query: {'limit': '10',",
        "              'select': 'title,body,views'},",
        '    );',
        '    return switch (json) {',
        "      {'posts': final List<dynamic> isi} =>",
        '        isi.map(_dariJson).toList(),',
        "      _ => throw const FormatException('...'),",
        '    };',
        '  }',
        '}',
      ].join('\n'),
      ukuranKode: 11,
      poin: [
        'Kontrak, ViewModel, dan View SAMA PERSIS dengan Contoh 08 Pertemuan 9.',
        'Yang berubah hanya satu baris create di main: Palsu → Api.',
      ],
      ukuranPoin: 15,
      catatan: 'select=title,body,views adalah fitur DummyJSON untuk meminta kolom tertentu saja. Di contoh ini pengubahan JSON ditulis di repository, sehingga class Pengumuman bersih dari urusan JSON; cara lain yang juga umum (Contoh 03 dan 04) menaruh fromJson di Model. Pertemuan 12 membahas kapan masing-masing lebih tepat. Contoh 06 menyimpan kedua repository: ubah satu baris create untuk berpindah.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 10', judul: 'Parameter Query, Pencarian, dan Muat Lebih Banyak', ikon: 'cari', catatan: 'Contoh 07: katalog produk dengan kotak pencarian dan tombol Muat lebih banyak.' });

    d.kode({
      judul: 'Uri.https dan Halaman demi Halaman',
      berkas: 'kode/contoh_07_pencarian_dan_muat_lagi.dart',
      kode: [
        "final Uri alamat = Uri.https('dummyjson.com',",
        "    '/products/search', {",
        "  'q': 'gaming laptop',",
        "  'limit': '10',",
        "  'skip': '0',",
        '});',
        '// https://dummyjson.com/products/search',
        '//   ?q=gaming+laptop&limit=10&skip=0',
        '',
        '// Jawaban juga berisi total:',
        'bool get masihAda => _produk.length < _total;',
      ].join('\n'),
      ukuran: 14,
      lebarKode: 6.8,
      poin: [
        'Jangan menyambung teks sendiri: spasi, &, ?, # punya arti khusus dan harus dikodekan.',
        'Semua nilai query berupa String: tulis \'$jumlah\'.',
        'limit=10&skip=0 → halaman 1; skip=10 → halaman 2; skip=20 → halaman 3.',
      ],
      ukuranPoin: 15,
      catatan: 'Cek cepat: halaman ketiga, 10 produk per halaman, skip berapa? 20, yaitu jumlah produk yang sudah ditampilkan. Di Contoh 07 nilainya diambil dari _produk.length, sehingga selalu tepat. Server tidak mengirim 194 produk sekaligus; kita memintanya per halaman.',
    });

    d.kode({
      judul: 'Debounce dan Jawaban yang Datang Terlambat',
      berkas: 'kode/contoh_07_pencarian_dan_muat_lagi.dart',
      kode: [
        'void cari(String teks) {',
        '  _kataKunci = teks.trim();',
        '  _penunda?.cancel(); // batalkan penunda lama',
        '  _penunda = Timer(',
        '      const Duration(milliseconds: 400), muat);',
        '}',
        '',
        'Future<void> muat() async {',
        '  final int nomor = ++_nomorPermintaan;',
        '  // ... tunggu jawaban ...',
        '  if (_sudahDibuang || nomor != _nomorPermintaan) {',
        '    return; // jawaban terlambat',
        '  }',
        '  // ... tampilkan ...',
        '}',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 6.8,
      poin: [
        'Debounce: kirim hanya setelah pengguna berhenti mengetik 400 ms (seperti lift menunggu orang terakhir masuk).',
        'Tanpa debounce, mengetik "laptop" = enam permintaan.',
        'Nomor permintaan: jawaban milik pencarian lama diabaikan.',
        'Batalkan Timer di dispose ViewModel.',
      ],
      ukuranPoin: 15,
      catatan: 'Timer berasal dari dart:async. Garis waktu tanpa penjaga: 0 ms kirim "phone" (nomor 1), 300 ms kirim "laptop" (nomor 2), 600 ms jawaban laptop tiba dan tampil, 900 ms jawaban phone tiba dan MENIMPA (salah!). Dengan nomor permintaan: 1 ≠ 2, diabaikan. Penjaga yang sama dipakai di studi kasus agar cuaca kota lama tidak tampil setelah pengguna memilih kota lain.',
    });

    d.layar({
      judul: 'Gambar dari Internet: Image.network',
      gambar: ['hasil_contoh_07a.jpg', 'hasil_contoh_07b.jpg'],
      lebarMaks: 6.0,
      berkas: 'kode/contoh_07_pencarian_dan_muat_lagi.dart',
      kode: [
        'Image.network(',
        '  alamat,',
        '  fit: BoxFit.cover,',
        '  loadingBuilder: (context, child, proses) {',
        '    if (proses == null) return child;',
        '    return const CircularProgressIndicator(',
        '        strokeWidth: 2);',
        '  },',
        '  errorBuilder: (context, galat, jejak) =>',
        '      const Icon(Icons.broken_image_outlined),',
        ')',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Tampilan saat mengunduh dan saat gagal.',
        'Gambar yang sudah diunduh disimpan sementara di memori.',
      ],
      ukuranPoin: 15,
      catatan: 'Kiri: katalog awal dengan tulisan Menampilkan 10 dari 194 produk dan tombol Muat lebih banyak. Kanan: hasil pencarian phone. Di slide, tipe parameter builder disingkat; kode lengkapnya menuliskan tipe BuildContext, Widget, ImageChunkEvent?, Object, dan StackTrace?.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 11', judul: 'Mengirim Data: POST, PATCH, dan DELETE', ikon: 'kirim', catatan: 'Contoh 08 mengirim data baru; Contoh 09 mengubah dan menghapus.' });

    d.layar({
      judul: 'POST: Menambah Data Baru',
      gambar: 'hasil_contoh_08.jpg',
      berkas: 'kode/contoh_08_mengirim_data_post.dart',
      kode: [
        'final http.Response respons = await http.post(',
        "  Uri.parse('https://dummyjson.com/todos/add'),",
        "  headers: {'Content-Type': 'application/json'},",
        '  body: jsonEncode({',
        "    'todo': judul, 'completed': selesai, 'userId': 1,",
        '  }),',
        ').timeout(const Duration(seconds: 10));',
        '',
        'if (respons.statusCode < 200 ||',
        '    respons.statusCode >= 300) {',
        '  throw ApiException(respons.statusCode);',
        '}',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Content-Type: tanpa ini, banyak server tidak bisa membaca datanya.',
        'Data baru dijawab 201 → periksa KELOMPOK 2xx.',
        'DummyJSON hanya BERPURA-PURA menyimpan: id selalu sama.',
      ],
      ukuranPoin: 15,
      catatan: 'Kode di slide diringkas; di Contoh 08 teks JSON disimpan dulu di variabel body, header juga berisi Accept, dan .timeout dipasang dengan gaya berantai. Layar Contoh 08 menampilkan apa yang dikirim dan apa yang diterima kembali: data yang sama ditambah id baru. Karena DummyJSON server latihan, tugas baru tidak muncul saat daftar dimuat ulang. Cek cepat: mengapa tombol Kirim dinonaktifkan selama mengirim? Agar data yang sama tidak terkirim dua kali; di server sungguhan ketukan ganda bisa membuat dua tugas kembar.',
    });

    d.layar({
      judul: 'PATCH dan DELETE: Ubah Tampilan Setelah Server Setuju',
      gambar: 'hasil_contoh_09.jpg',
      berkas: 'kode/contoh_09_ubah_dan_hapus.dart',
      kode: [
        '// PATCH: kirim HANYA kolom yang berubah.',
        'await http.patch(',
        "  Uri.https(_host, '/todos/$id'),",
        '  headers: _header,',
        "  body: jsonEncode({'completed': selesai}),",
        ');',
        '',
        '// DELETE: jawaban berisi isDeleted.',
        'final Map<String, dynamic> json =',
        '    _baca(await http.delete(',
        "        Uri.https(_host, '/todos/$id'),",
        '        headers: _header));',
        "if (json['isDeleted'] != true) { /* gagal */ }",
      ].join('\n'),
      ukuranKode: 11,
      poin: [
        '1. Saat dicentang: baris menampilkan lingkaran kecil, tidak bisa diketuk.',
        '2. Server menjawab berhasil → baru tanda centang berubah + SnackBar.',
        '3. Gagal → tampilan tidak berubah, SnackBar memberi tahu.',
      ],
      ukuranPoin: 15,
      catatan: 'Kode di slide diringkas dari Contoh 09 (fungsi _baca melempar ApiException jika bukan 2xx). Cara sebaliknya disebut optimistic update: tampilan langsung diubah lalu dikembalikan jika server menolak. Terasa lebih cepat tetapi lebih rumit; untuk pemula, cara "tunggu server dulu" lebih aman dan mudah diperiksa.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 12', judul: 'Menguji Tanpa Internet dengan MockClient', ikon: 'uji', catatan: 'Server tiruan yang jawabannya kita tentukan sendiri.' });

    d.kode({
      judul: 'MockClient: Server Tiruan',
      berkas: 'kode/contoh_10_menguji_dengan_mockclient.dart',
      kode: [
        "import 'package:http/testing.dart';",
        '',
        'http.Request? terakhir;',
        'final MockClient serverBaik =',
        '    MockClient((http.Request permintaan) async {',
        '  terakhir = permintaan; // catat permintaan',
        '  return http.Response(jsonDuaProduk, 200);',
        '});',
        '',
        'final RepositoriProdukApi repo = RepositoriProdukApi(',
        '  layanan: LayananDummyJson(klien: serverBaik),',
        ');',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.0,
      poin: [
        'Server sungguhan: butuh internet, hasil berubah, sulit memaksa 404 atau jawaban lambat.',
        'MockClient adalah http.Client palsu.',
        'Bisa dipakai karena layanan menerima http.Client lewat constructor (dependency injection).',
        'Server lambat: Future.delayed di dalam MockClient + batas waktu pendek.',
      ],
      ukuranPoin: 15,
      catatan: 'Pola pemeriksaannya sama dengan Pertemuan 9 Bagian 12: siapkan, lakukan, periksa. Yang diperiksa: JSON → Model (jumlah dan judul), alamat yang dikirim (jalur, q, skip), dan jenis galat (404 → ApiException, bukan JSON → FormatException, kolom hilang → FormatException, lambat → TimeoutException).',
    });

    d.layar({
      judul: 'Contoh 10: Pengujian Menemukan Bug',
      gambar: 'hasil_contoh_10.jpg',
      berkas: 'kode/contoh_10_menguji_dengan_mockclient.dart',
      kode: [
        'Future<String> galatDari(',
        '    Future<Object?> Function() aksi) async {',
        '  try {',
        '    await aksi();',
        "    return 'tidak ada galat';",
        '  } on ApiException catch (galat) {',
        "    return 'ApiException ${galat.kodeStatus}';",
        '  } on FormatException {',
        "    return 'FormatException';",
        '  } on TimeoutException {',
        "    return 'TimeoutException';",
        '  }',
        '}',
      ].join('\n'),
      ukuranKode: 12,
      poin: [
        'Hasil: 8 dari 9 uji lulus.',
        '"Halaman ketiga: skip=20 — Diharapkan 20, tetapi hasilnya 10".',
        'Cari penyebabnya di RepositoriProdukApi.cari: nilai apa yang dikirim untuk skip?',
      ],
      ukuranPoin: 15,
      catatan: 'Bug kecil seperti ini membuat tombol Muat lebih banyak menampilkan produk yang SAMA berulang-ulang, dan sulit ditemukan dengan mencoba aplikasi sekilas. Contoh 10 menampilkan hasil uji di layar agar mudah diamati di DartPad; Pertemuan 14 memakai cara resmi: flutter_test dan flutter test, dengan MockClient yang sama.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 13', judul: 'Studi Kasus: Cuaca Kampus', ikon: 'cuaca', catatan: 'Contoh 11 merangkai semua materi hari ini menjadi aplikasi prakiraan cuaca delapan kota kampus.' });

    d.kartu({
      judul: 'Cuaca Kampus: Fitur dan Sumber Data',
      pengantar: 'Data dari Open-Meteo: gratis tanpa kunci API untuk keperluan nonkomersial, berlisensi CC BY 4.0 (wajib menyebut sumber).',
      kolom: 2,
      item: [
        { ikon: 'rute', judul: 'Pilihan kota', isi: 'Chip Jakarta, Bandung, Yogyakarta, Surabaya, Denpasar, Samarinda, Makassar, Medan.' },
        { ikon: 'cuaca', judul: 'Cuaca saat ini', isi: 'Suhu, kondisi, kelembapan, angin, dan jam diperbarui.' },
        { ikon: 'jam', judul: 'Prakiraan 7 hari', isi: 'Kondisi, suhu tertinggi dan terendah, peluang hujan.' },
        { ikon: 'ulang', judul: 'Interaksi', isi: 'Tarik untuk menyegarkan; Coba lagi saat gagal.' },
      ],
      catatan: 'Permintaan: Uri.https(\'api.open-meteo.com\', \'/v1/forecast\', {latitude, longitude, current: \'temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m\', daily: \'weather_code,temperature_2m_max,temperature_2m_min,precipitation_probability_max\', timezone: \'auto\', forecast_days: \'7\'}). timezone=auto membuat tanggal dan jam mengikuti zona waktu kota itu (WIB, WITA, atau WIT).',
    });

    d.kode({
      judul: 'Repository: Menyatukan Larik Sejajar',
      berkas: 'kode/contoh_11_studi_kasus_cuaca_kampus.dart',
      kode: [
        'if (json case {',
        "  'time': final List<dynamic> tanggal,",
        "  'weather_code': final List<dynamic> kode,",
        "  'temperature_2m_max': final List<dynamic> maks,",
        '  // ... min dan peluang ...',
        '}) {',
        '  // periksa: semua larik sama panjang',
        '  return [',
        '    for (int i = 0; i < tanggal.length; i++)',
        '      PrakiraanHarian(',
        '        tanggal: DateTime.parse(tanggal[i] as String),',
        '        kondisi: Kondisi.dariKode((kode[i] as num).toInt()),',
        '        suhuMaks: (maks[i] as num).toDouble(),',
        '        peluangHujan: (peluang[i] as num?)?.round(),',
        '      ),',
        '  ];',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.4,
      poin: [
        'daily bukan daftar objek, melainkan beberapa LARIK SEJAJAR: unsur ke-i milik hari ke-i.',
        'if-case: seperti switch, tetapi satu pola.',
        'Data nyata tidak rapi: nilai bisa null, angka bisa 31 atau 32.1.',
      ],
      ukuranPoin: 15,
      catatan: 'Contoh jawaban daily: "time": ["2026-10-15", ...], "weather_code": [3, 95, 61], "precipitation_probability_max": [20, 85, null]. Jika panjang lariknya berbeda, kode [i] bisa melampaui batas; lebih baik berhenti dengan FormatException(\'Panjang data harian tidak sama\'). (peluang[i] as num?)?.round(): null tetap null, angka dibulatkan.',
    });

    d.kode({
      judul: 'Kode Cuaca WMO Menjadi Kondisi',
      berkas: 'kode/contoh_11_studi_kasus_cuaca_kampus.dart',
      kode: [
        'static Kondisi dariKode(int kode) {',
        '  return switch (kode) {',
        '    0 => Kondisi.cerah,',
        '    1 || 2 => Kondisi.cerahBerawan,',
        '    3 => Kondisi.berawan,',
        '    45 || 48 => Kondisi.berkabut,',
        '    >= 51 && <= 57 => Kondisi.gerimis,',
        '    61 || 80 => Kondisi.hujanRingan,',
        '    63 || 66 || 81 => Kondisi.hujan,',
        '    65 || 67 || 82 => Kondisi.hujanLebat,',
        '    >= 71 && <= 77 || 85 || 86 => Kondisi.salju,',
        '    >= 95 && <= 99 => Kondisi.badaiPetir,',
        '    _ => Kondisi.tidakDiketahui,',
        '  };',
        '}',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 6.8,
      poin: [
        '1 || 2: pola "atau".',
        '>= 51 && <= 57: pola "dan" dengan relasional.',
        '_: kode yang tidak dikenal tetap ditangani, bukan error.',
        'enum Kondisi menyimpan label dan ikonnya.',
      ],
      ukuranPoin: 16,
      catatan: 'Kode cuaca WMO adalah angka standar Organisasi Meteorologi Dunia. Ikon kondisi di View diberi semanticLabel, sehingga kondisi tidak hanya ditunjukkan ikon tetapi juga dibaca pembaca layar.',
    });

    d.kode({
      judul: 'ViewModel: Semua Pola dalam Satu Tempat',
      berkas: 'kode/contoh_11_studi_kasus_cuaca_kampus.dart',
      kode: [
        'Future<void> muat({bool tampilkanMemuat = true}) async {',
        '  final int nomor = ++_nomorPermintaan;',
        '  if (tampilkanMemuat) {',
        '    _status = StatusMuat.memuat;',
        '    notifyListeners();',
        '  }',
        '  try {',
        '    final Cuaca cuaca = await _repositori.ambil(_kota);',
        '    if (_sudahDibuang || nomor != _nomorPermintaan) return;',
        '    _cuaca = cuaca;',
        '    _status = StatusMuat.berhasil;',
        '  } catch (galat) {',
        '    if (_sudahDibuang || nomor != _nomorPermintaan) return;',
        "    debugPrint('Galat saat memuat cuaca: $galat');",
        '    _pesanGalat = pesanRamah(galat);',
        '    _status = StatusMuat.gagal;',
        '  }',
        '  notifyListeners();',
        '}',
        'Future<void> segarkan() => muat(tampilkanMemuat: false);',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.6,
      poin: [
        'Status, pesanRamah, nomor permintaan, _sudahDibuang.',
        'segarkan: data lama tetap terlihat; RefreshIndicator punya lingkarannya sendiri.',
      ],
      ukuranPoin: 15,
      catatan: 'Kode di slide sedikit dirapatkan (return di baris yang sama); di berkas aslinya ditulis dalam blok. Di View: StatusMuat.berhasil => RefreshIndicator(onRefresh: () => context.read<CuacaViewModel>().segarkan(), ...). ListView memakai AlwaysScrollableScrollPhysics agar tetap bisa ditarik walaupun isinya pendek. PilihanKota memakai context.select agar hanya dibangun ulang saat kota berganti.',
    });

    d.kode({
      judul: 'Pemeriksaan Sebelum Aplikasi Tampil',
      berkas: 'kode/contoh_11_studi_kasus_cuaca_kampus.dart',
      kode: [
        'GET https://api.open-meteo.com/v1/forecast?latitude=-0.5&...',
        'LULUS  Alamat memakai lintang kota',
        'LULUS  Kode 3 = Berawan',
        'LULUS  Suhu saat ini',
        'LULUS  Tiga hari prakiraan',
        'LULUS  Hari kedua badai petir',
        'LULUS  Suhu maks 31 terbaca',
        'LULUS  Peluang hujan kosong',
        'LULUS  Kode 42 tidak dikenal',
        'GET https://api.open-meteo.com/v1/forecast?latitude=-6.2&...',
        'Galat saat memuat cuaca: ApiException: kode status 500',
        'LULUS  Kode 500: status gagal',
        'LULUS  Kode 500: pesan ramah',
        'GET https://api.open-meteo.com/v1/forecast?latitude=-6.2&...',
      ].join('\n'),
      shell: true,
      ukuran: 12,
      lebarKode: 7.8,
      poin: [
        'GET ...: alamat dibuat sungguhan, yang menjawab MockClient.',
        'Baris Galat memang diharapkan (uji kode 500).',
        'GET terakhir: permintaan sungguhan saat aplikasi tampil (Jakarta).',
        'Koma ditulis %2C: Uri.https mengodekannya.',
      ],
      ukuranPoin: 14,
      catatan: 'Seperti Praktikum 4 di Pertemuan 9: main menjalankan jalankanUji() sebelum runApp. Repository dan ViewModel diperiksa dengan MockClient berisi JSON contoh. Sepuluh baris LULUS menjadi syarat pertama uji mandiri.',
    });

    d.layar({
      judul: 'Cuaca Kampus Berjalan',
      gambar: ['hasil_contoh_11a.jpg', 'hasil_contoh_11b.jpg', 'hasil_contoh_11c.jpg'],
      lebarMaks: 7.6,
      berkas: 'kode/contoh_11_studi_kasus_cuaca_kampus.dart',
      poin: [
        'Memilih dua kota dengan sangat cepat: cuaca kota PERTAMA tidak pernah tampil.',
        'Tarik ke bawah: jam "Diperbarui pukul" berubah.',
        'Mode pesawat lalu ganti kota: pesan ramah + Coba lagi.',
      ],
      ukuranPoin: 15,
      catatan: 'Kiri: Jakarta (kartu cuaca saat ini dan prakiraan Hari ini, Besok, dan seterusnya). Tengah: mode gelap untuk Samarinda. Kanan: gagal memuat (ikon awan tercoret, pesan, Coba lagi). Daftar uji mandiri lengkap di modul Bagian 13.9.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 14', judul: 'Menjalankan di Web dan di Android', ikon: 'perangkat', catatan: 'Dua jebakan yang sering membuat aplikasi lancar di satu tempat tetapi gagal di tempat lain.' });

    d.banding({
      judul: 'CORS di Web, Izin Internet di Android',
      ukuranContoh: 12,
      kolom: [
        {
          ikon: 'web', judul: 'Web (Chrome, DartPad)', warna: C.accent1, tag: 'CORS',
          poin: [
            'Browser hanya mengizinkan mengambil data dari server lain yang secara tegas mengizinkannya',
            'Lancar di Android tetapi ClientException di Chrome → CORS',
            'DummyJSON dan Open-Meteo mengizinkan dipanggil dari browser',
            'Uji API proyek akhir di Chrome sejak awal',
          ],
        },
        {
          ikon: 'hp', judul: 'Android', warna: C.accent6, tag: 'Izin internet', sorot: true,
          poin: [
            'flutter run (debug): izin sudah ada otomatis',
            'APK rilis (P15): hanya jika baris ini ada di AndroidManifest.xml',
            'Pakai https; localhost laptop dari emulator = 10.0.2.2',
          ],
          contoh: '<uses-permission\n  android:name=\n  "android.permission.INTERNET" />',
        },
      ],
      pesan: 'Jangan mengakali CORS dengan proxy gratis yang tidak jelas pemiliknya: semua data yang lewat, termasuk token pengguna, bisa dibaca pemiliknya.',
      catatan: 'Baris izin internet ditulis di dalam tag <manifest> dan SEBELUM tag <application>. Tanpa baris ini, aplikasi rilis tidak bisa memuat data apa pun, padahal saat diuji dengan flutter run semuanya lancar. Android menolak koneksi http:// (tanpa s) secara bawaan. Kunci API (Bagian 14.4): jangan ditulis di kode yang masuk GitHub; berikan saat menjalankan dengan flutter run --dart-define=KUNCI_API=... lalu baca dengan String.fromEnvironment(\'KUNCI_API\').',
    });

    d.tabel({
      judul: 'Kesalahan Umum Pemula',
      kepala: ['Gejala', 'Solusi'],
      lebarKolom: [6.4, 5.2],
      baris: [
        [kode("The argument type 'String' can't be assigned to the parameter type 'Uri'"), 'Uri.parse(...) atau Uri.https(...)'],
        ['Data kosong atau null saat server menjawab 404/500', 'Periksa statusCode sebelum membaca body'],
        [kode("type 'List<dynamic>' is not a subtype of type 'Map<String, dynamic>'"), 'Lihat bentuk JSON-nya di browser dulu'],
        ['Lingkaran memuat muncul terus, permintaan berulang-ulang', 'Future di initState, bukan di build'],
        ['Hasil pencarian lama menimpa yang baru', 'Nomor permintaan (Bagian 10.4)'],
        ['Server menolak POST (400) atau data tidak terbaca', "jsonEncode + 'Content-Type': 'application/json'"],
        ['Huruf aneh seperti Ã© atau Â°', 'utf8.decode(respons.bodyBytes)'],
        ['Pesan galat teknis tampil ke pengguna', 'Terjemahkan dengan pesanRamah'],
      ],
      ukuran: 13,
      tinggiBaris: 0.58,
      catatan: 'Tabel lengkap di modul Bagian 15, termasuk paket http yang belum dipasang, FormatException karena pola double, setState() called after dispose(), tidak ada batas waktu, CORS, dan izin internet APK rilis.',
    });

    d.tabel({
      judul: 'Memilih Alat yang Tepat',
      kepala: ['Kebutuhan', 'Pakai'],
      lebarKolom: [6.0, 5.6],
      baris: [
        ['Coba-coba satu permintaan di halaman sederhana', 'http.get + setState (Contoh 01)'],
        ['Menampilkan hasil satu Future tanpa banyak aturan', 'FutureBuilder dengan Future dari initState'],
        ['Pencarian, saringan, muat lebih banyak, kirim data', 'ViewModel + repository + layanan'],
        ['Banyak permintaan ke server yang sama', 'Satu http.Client di layanan, ditutup saat selesai'],
        ['Menguji tanpa internet', 'MockClient dari package:http/testing.dart'],
      ],
      ukuran: 16,
      tinggiBaris: 0.68,
      pesan: 'Mulailah dari yang paling sederhana yang mencukupi.',
      catatan: 'Minta mahasiswa memetakan proyek akhir: API apa yang dipakai, endpoint apa saja, bentuk JSON-nya, dan bagian mana yang akan diuji dengan MockClient.',
    });

    d.ringkasan({
      poin: [
        'Klien meminta data ke server lewat REST API: alamat + metode.',
        'Kode status: 2xx berhasil, 4xx salah di aplikasi, 5xx salah di server.',
        'jsonDecode + pola map di fromJson; angka JSON dibaca dengan num.',
        'Kode 404/500 BUKAN exception; exception = tidak ada jawaban.',
        'FutureBuilder: Future dibuat sekali di initState.',
        'Empat galat: ClientException, TimeoutException, ApiException, FormatException → pesan ramah.',
        'Layanan (HTTP + JSON) dan repository (JSON → Model); ViewModel tidak tahu asal datanya.',
        'Uri.https, debounce, limit/skip/total, nomor permintaan, MockClient.',
      ],
      catatan: 'Minta mahasiswa menjelaskan dengan kata-kata sendiri: apa bedanya "server menjawab 404" dengan "tidak ada jawaban sama sekali", dan di bagian kode mana keduanya ditangani.',
    });

    d.penutup({
      judul: 'Saatnya Praktik!',
      subjudul: 'Kerjakan Jobsheet Pertemuan 10 (lima praktikum + tugas Formulir Alamat Pendaftaran), lalu uji diri di Latihan. Untuk proyek akhir: buat layanan dan repository untuk API pilihan tim, lalu uji dengan MockClient. Pertemuan berikutnya: penyimpanan lokal.',
      tautan: [
        { teks: 'Jobsheet P10', ikon: 'tugas', url: d.urlBerkas('pertemuan_10_async_dan_rest_api/JOBSHEET.md') },
        { teks: 'Latihan P10', ikon: 'kuis', url: d.urlBerkas('pertemuan_10_async_dan_rest_api/LATIHAN.md') },
        { teks: 'Proyek Akhir', ikon: 'roket', url: d.urlBerkas('panduan/05_proyek_akhir.md') },
      ],
      catatan: 'Praktikum 1–4 bisa di DartPad; Praktikum 5 di VS Code (flutter pub add http, izin internet di AndroidManifest.xml). Semua praktikum membutuhkan internet. Tugas mandiri memakai API Wilayah Indonesia (emsifa) dan wajib punya jalankanUji() dengan MockClient. Pertemuan 11 membahas penyimpanan lokal: menyimpan kota favorit, pengaturan, dan data cadangan agar aplikasi tetap berguna tanpa internet.',
    });
  },
};

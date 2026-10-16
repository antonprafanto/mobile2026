// Konten slide Pertemuan 13 — Fitur Perangkat & Izin Akses.
// Teks diambil dari modul bacaan (pertemuan_13_fitur_perangkat_dan_izin/README.md).
// Tangkapan layar diambil dari folder pertemuan_13_fitur_perangkat_dan_izin/gambar/.
//
// Catatan kode di slide: kode disalin dari modul/berkas contoh. Jika terlalu
// panjang untuk satu slide, bagian yang dilewati ditandai "// ..." atau
// "/* ... */", dan catatan pembicara menyebutkannya.

module.exports = {
  nomor: '13',
  folder: 'pertemuan_13_fitur_perangkat_dan_izin',
  namaBerkas: 'PERTEMUAN_13_Fitur_Perangkat_dan_Izin',
  topik: 'Fitur Perangkat & Izin Akses',

  bangun(d) {
    const C = d.C;
    const KODE = { fontFace: 'Consolas' };
    const kode = (teks) => ({ text: teks, options: KODE });

    d.judul({
      judul: 'Fitur Perangkat & Izin Akses',
      subjudul: 'Pertemuan 13  ·  kamera dan galeri (image_picker); lokasi (geolocator); izin akses dan statusnya; jarak, arah, dan zona; alur izin yang sopan; lokasi terus-menerus; fitur perangkat di balik kontrak; privasi',
      catatan: 'Sampai Pertemuan 12, aplikasi kita mengolah data yang diketik, diambil dari internet, atau disimpan di perangkat. Hari ini aplikasi mulai memakai bagian FISIK HP: kamera, galeri, dan lokasi. Bekal: Future/async/Stream (P3), StatefulWidget, initState, dispose (P5), MVVM dan provider (P9), kontrak, Hasil, Kegagalan, data palsu, Perintah (P12). Tidak punya HP Android? Tetap bisa mengikuti: Contoh 01, 04, 05, dan 07 berjalan di DartPad; sisanya di Chrome dengan flutter run -d chrome.',
    });

    d.tujuan({
      pengantar: 'Setelah pertemuan ini, Anda mampu:',
      poin: [
        'Menjelaskan izin akses: siapa yang menyimpan keputusannya dan arti setiap status izin',
        'Menyiapkan proyek: paket, AndroidManifest.xml, Info.plist, dan perbedaan perilaku di web',
        'Mengambil foto dari galeri dan kamera, termasuk batal, galat, dan perangkat tanpa kamera',
        'Mengambil lokasi lewat tiga pemeriksaan berurutan: layanan, izin, lalu posisi',
        'Menghitung jarak dan arah, lalu menulis aturan zona yang memeriksa akurasi dan lokasi palsu',
        'Merancang alur izin yang sopan, dan mengikuti lokasi dengan Stream tanpa menguras baterai',
        'Membungkus fitur perangkat di balik kontrak, lalu mengujinya dengan data palsu tanpa HP',
        'Menerapkan prinsip privasi: ambil seperlunya, saat dibutuhkan, dan jelaskan pemakaiannya',
      ],
      catatan: 'Target akhir hari ini: aplikasi "Presensi Praktikum" yang mengambil foto selfie dan lokasi, meminta izin dengan sopan, tetap bisa dipakai saat izin ditolak, dan bisa dikembangkan serta diuji di laptop tanpa GPS dan kamera (18 pemeriksaan sebelum runApp).',
    });

    d.alur({
      judul: 'Peta Materi Hari Ini',
      langkah: [
        { ikon: 'gembok', judul: 'A. Izin dan persiapan', isi: 'Plugin, percakapan izin, status, AndroidManifest, Info.plist (Bagian 1–3)' },
        { ikon: 'kamera', judul: 'B. Kamera dan galeri', isi: 'pickImage, tiga kemungkinan hasil, Image.memory (4)' },
        { ikon: 'lokasi', judul: 'C. Lokasi', isi: 'Layanan, izin, posisi; jarak, arah, zona (5–6)' },
        { ikon: 'dialog', judul: 'D. Izin yang sopan', isi: 'Minta saat dipakai, ditolak, diblokir; Stream lokasi (7–8)' },
        { ikon: 'lapisan', judul: 'E. Kontrak dan studi kasus', isi: 'Data palsu, Presensi Praktikum, privasi (9–15)', warna: C.accent4 },
      ],
      catatan: 'Bagian A: mengapa aplikasi harus minta izin, siapa yang memutuskan, dan apa yang perlu disiapkan di proyek. Bagian B dan C: mengambil foto dan lokasi, lalu mengolah koordinat menjadi jarak, arah, dan keputusan "di dalam area". Bagian D: meminta izin tanpa membuat pengguna kesal, dan mengikuti lokasi tanpa menguras baterai. Bagian E: bagaimana fitur perangkat masuk ke arsitektur Pertemuan 12 sehingga bisa diuji tanpa HP, lalu privasi dan kesalahan umum.',
    });

    d.tabel({
      judul: 'Kode Contoh Hari Ini',
      kepala: ['No', 'Berkas', 'Isi', 'Jalan di'],
      lebarKolom: [0.6, 5.6, 3.9, 1.5],
      baris: [
        ['01', kode('contoh_01_status_izin_dart_murni.dart'), 'Status izin dan sistem operasi tiruan', 'DartPad'],
        ['02', kode('contoh_02_galeri_dan_kamera.dart'), '"Foto Profil" dengan image_picker', 'Proyek'],
        ['03', kode('contoh_03_lokasi_sekarang.dart'), '"Di Mana Saya?" dengan geolocator', 'Proyek'],
        ['04', kode('contoh_04_jarak_dan_zona_dart_murni.dart'), 'Jarak, arah, dan zona presensi', 'DartPad'],
        ['05', kode('contoh_05_alur_izin_yang_sopan.dart'), '"Ruang Belajar": simulasi alur izin', 'DartPad'],
        ['06', kode('contoh_06_lokasi_terus_menerus.dart'), '"Jalan Pagi" dengan Stream lokasi', 'Proyek'],
        ['07', kode('contoh_07_kontrak_perangkat_dan_data_palsu.dart'), '"Catatan Lapangan": kontrak + data palsu', 'DartPad'],
        ['08', kode('contoh_08_studi_kasus_presensi.dart'), 'Studi kasus "Presensi Praktikum"', 'Proyek'],
      ],
      ukuran: 14,
      tinggiBaris: 0.56,
      catatan: 'image_picker dan geolocator tidak tersedia di DartPad, jadi Contoh 02, 03, 06, dan 08 dijalankan di proyek Flutter (flutter run -d chrome --web-port=8080). Contoh 05 dan 07 sengaja dibuat tanpa kedua paket itu (memakai simulasi dan data palsu), sehingga alurnya bisa dicoba langsung di DartPad.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 1', judul: 'Aplikasi yang Menyentuh Dunia Nyata', ikon: 'sensor', catatan: 'Banyak aplikasi sehari-hari memakai bagian fisik HP. Polanya selalu sama: periksa izin, ambil data, tangani kegagalan.' });

    d.tabel({
      judul: 'Fitur Perangkat di Aplikasi Sehari-hari',
      kepala: ['Aplikasi', 'Fitur perangkat', 'Untuk apa'],
      lebarKolom: [3.4, 2.9, 5.3],
      baris: [
        ['Ojek dan pesan-antar', 'Lokasi (GPS)', 'Menjemput di titik yang tepat, menghitung ongkos dari jarak'],
        ['Presensi kampus atau kantor', 'Kamera + lokasi', 'Orangnya benar, dan berada di tempat yang benar'],
        ['Laporan fasilitas rusak', 'Kamera + lokasi', 'Foto bukti beserta titik kerusakannya'],
        ['Dompet digital', 'Kamera', 'Memindai kode QR untuk membayar'],
        ['Media sosial', 'Galeri', 'Mengunggah foto yang sudah ada di HP'],
        ['Peta dan olahraga', 'Lokasi terus-menerus', 'Menunjukkan posisi dan mencatat jarak selama bergerak'],
      ],
      ukuran: 15,
      tinggiBaris: 0.62,
      pesan: 'Hari ini: kamera/galeri dan lokasi. Pola "periksa izin → ambil data → tangani kegagalan" berlaku juga untuk mikrofon, Bluetooth, NFC, dan lainnya.',
      catatan: 'Tanyakan kepada mahasiswa: aplikasi apa di HP mereka yang memakai lokasi atau kamera, dan kapan aplikasi itu meminta izin?',
    });

    d.alur({
      judul: 'Plugin: Jembatan ke Perangkat',
      pengantar: 'Kode Dart tidak bisa langsung menyalakan kamera. Plugin = kode Dart yang kita panggil + kode asli setiap platform.',
      langkah: [
        { ikon: 'kode', judul: 'Kode kita (Dart)', isi: 'pickImage(...) atau getCurrentPosition(...)' },
        { ikon: 'tautan', judul: 'Plugin (bagian Dart)', isi: 'image_picker 1.2.4 · geolocator 14.1.1' },
        { ikon: 'hp', judul: 'Android / iOS', isi: 'Kotlin/Java, Swift: Photo Picker, kamera bawaan, GPS' },
        { ikon: 'web', judul: 'Web', isi: 'JavaScript: pemilih berkas dan Geolocation API browser' },
      ],
      catatan: 'Analogi: penerjemah di konferensi internasional. Kita cukup berbicara satu bahasa (Dart); penerjemah meneruskannya ke bahasa setiap negara. image_picker dibuat tim Flutter; geolocator dibuat Baseflow. Versi di slide adalah versi terbaru per 16 Oktober 2026; flutter pub add selalu memasang versi terbaru yang cocok.',
    });

    d.tabel({
      judul: 'Tiga Tempat Mencoba',
      kepala: ['Tempat', 'Kamera dan galeri', 'Lokasi', 'Cocok untuk'],
      lebarKolom: [2.6, 3.4, 3.0, 2.6],
      baris: [
        ['Chrome (flutter run -d chrome)', 'Pemilih berkas komputer; tombol kamera di laptop biasanya juga pemilih berkas', 'Dari browser; bisa diatur lewat DevTools → Sensors', 'Laptop RAM 8 GB; latihan alur dan tampilan'],
        ['Emulator Android', 'Kamera virtual milik emulator', 'Extended controls → Location', 'Mencoba dialog izin Android tanpa HP'],
        ['HP Android (kabel USB)', 'Kamera dan galeri sungguhan', 'GPS sungguhan', 'Pengalaman paling lengkap'],
      ],
      ukuran: 15,
      tinggiBaris: 1.0,
      pesan: 'Tidak punya HP Android? Contoh 01, 04, 05, dan 07 berjalan di DartPad; contoh lainnya di Chrome (flutter run -d chrome).',
      catatan: 'Cara mengatur lokasi di Chrome dan emulator dibahas di Bagian 11. HP Android tetap memberi pengalaman paling lengkap: dialog izin asli, GPS asli, dan kamera asli.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 2', judul: 'Izin Akses: Percakapan Tiga Pihak', ikon: 'gembok', catatan: 'Foto di galeri dan lokasi adalah data pribadi. Dari riwayat lokasi seseorang, orang lain bisa menebak alamat rumahnya dan jam berangkatnya.' });

    d.alur({
      judul: 'Aplikasi, Sistem Operasi, dan Pengguna',
      pengantar: 'Tamu (aplikasi) ingin masuk ruang arsip (lokasi). Satpam (sistem operasi) bertanya kepada pemilik ruangan (pengguna), lalu mencatat jawabannya.',
      langkah: [
        { ikon: 'tanya', judul: 'Periksa', isi: 'checkPermission() → denied. Tanpa dialog' },
        { ikon: 'dialog', judul: 'Minta', isi: 'requestPermission() → sistem menampilkan dialog' },
        { ikon: 'orang', judul: 'Pengguna memutuskan', isi: '"Saat aplikasi digunakan"' },
        { ikon: 'lokasi', judul: 'Ambil posisi', isi: 'whileInUse → getCurrentPosition() → koordinat', warna: C.accent4 },
      ],
      catatan: 'Tiga hal penting. (1) Catatan izin disimpan oleh SISTEM OPERASI, bukan oleh aplikasi; aplikasi tidak bisa mengubahnya sendiri. (2) Memeriksa izin tidak pernah memunculkan dialog; meminta izin memunculkan dialog, tetapi hanya jika masih boleh diminta. (3) Pengguna bisa mencabut izin kapan saja lewat Pengaturan, jadi aplikasi harus memeriksa SETIAP KALI akan memakai fiturnya.',
    });

    d.banding({
      judul: 'Izin Biasa dan Izin yang Ditanyakan',
      kolom: [
        {
          ikon: 'centang', judul: 'Saat pemasangan (install-time)', warna: C.accent6, tag: 'Contoh: INTERNET',
          poin: [
            'Cukup ditulis di AndroidManifest.xml',
            'Diberikan otomatis saat aplikasi dipasang',
            'Pengguna tidak ditanya',
          ],
        },
        {
          ikon: 'dialog', judul: 'Saat dipakai (runtime)', warna: C.accent1, tag: 'Lokasi, kamera, mikrofon, kontak', sorot: true,
          poin: [
            'Ditulis di AndroidManifest.xml DAN ditanyakan lewat dialog',
            'Bisa ditolak, diblokir, atau dicabut kapan saja',
            'iOS: selalu ditanyakan + wajib kalimat alasan di Info.plist',
            'Web: browser yang bertanya, hanya di HTTPS atau localhost',
          ],
        },
      ],
      ukuranPoin: 16,
      pesan: 'Izin INTERNET sudah Anda temui di Pertemuan 10 (Bagian 14.2): cukup satu baris di AndroidManifest.xml, tanpa dialog.',
      catatan: 'Di iOS, alasan pemakaian di Info.plist ikut tampil di dialog izin. Di web, dialog ditampilkan browser, dan izinnya diatur lewat ikon di sebelah kiri alamat situs.',
    });

    d.tabel({
      judul: 'Lima Status Izin Lokasi',
      kepala: ['LocationPermission', 'Artinya', 'Boleh diminta lagi?'],
      lebarKolom: [3.2, 6.2, 2.2],
      baris: [
        [kode('denied'), 'Belum pernah diminta, ATAU baru saja ditolak', '✔'],
        [kode('deniedForever'), 'Ditolak permanen. Dialog tidak akan muncul lagi', '✘ (Pengaturan)'],
        [kode('whileInUse'), 'Diizinkan selama aplikasi sedang dipakai', '—'],
        [kode('always'), 'Diizinkan, termasuk saat aplikasi di latar belakang', '—'],
        [kode('unableToDetermine'), 'Tidak bisa diketahui (hanya browser lama)', '✔'],
      ],
      ukuran: 16,
      tinggiBaris: 0.7,
      pesan: 'denied mencakup DUA keadaan: belum pernah ditanya, dan sudah ditolak sekali. Keduanya sama-sama boleh diminta lagi.',
      catatan: 'Contoh 01 meniru enum ini dengan nama Indonesia: ditolak, ditolakPermanen, saatDipakai, selalu, tidakDiketahui. Uji pemahaman: checkPermission() mendapat denied. Apakah pasti pengguna pernah menolak? Tidak, bisa juga belum pernah diminta.',
    });

    d.tabel({
      judul: 'Aturan Main di Android',
      kepala: ['Aturan', 'Akibatnya bagi aplikasi'],
      lebarKolom: [4.6, 7.0],
      baris: [
        ['Penolakan kedua dianggap permanen (Android 11+)', 'requestPermission() langsung menjawab deniedForever tanpa dialog. Jalan satu-satunya: Pengaturan'],
        ['"Hanya kali ini" (lokasi, kamera, mikrofon)', 'Izin dicabut otomatis setelah aplikasi ditutup; saat dibuka lagi kembali denied'],
        ['Lokasi perkiraan atau tepat (Android 12+)', 'Perkiraan ± 3 km persegi; tepat ± 50 m, kadang beberapa meter. Aplikasi harus tetap berfungsi'],
        ['Reset otomatis', 'Izin aplikasi yang lama tidak dibuka bisa dicabut Android'],
        ['Pengguna bisa mengubah izin kapan saja', 'Izin bisa berubah saat aplikasi di latar belakang'],
      ],
      ukuran: 15,
      tinggiBaris: 0.68,
      pesan: 'Jangan pernah menganggap izin sudah pasti ada. Periksa setiap kali.',
      catatan: 'Uji pemahaman: mengapa aplikasi tidak boleh hanya memeriksa izin sekali saat pertama dibuka? Karena izin bisa dicabut lewat Pengaturan, berakhir karena "Hanya kali ini", atau dicabut otomatis jika aplikasi lama tidak dibuka.',
    });

    d.kode({
      judul: 'Dari Keadaan ke Tindakan',
      berkas: 'kode/contoh_01_status_izin_dart_murni.dart',
      kode: [
        '/// Urutan pemeriksaannya penting: layanan dulu, baru izin.',
        'Tindakan tindakanUntuk({',
        '  required bool layananAktif,',
        '  required StatusIzin izin,',
        '}) {',
        '  if (!layananAktif) return Tindakan.nyalakanLayanan;',
        '  // switch ekspresi WAJIB menangani semua nilai enum. Jika kelak ada',
        '  // status baru, analyzer langsung mengingatkan kita.',
        '  return switch (izin) {',
        '    StatusIzin.saatDipakai || StatusIzin.selalu => Tindakan.ambilLokasi,',
        '    // Di browser lama status tidak bisa diketahui, jadi langsung minta.',
        '    StatusIzin.ditolak || StatusIzin.tidakDiketahui => Tindakan.mintaIzin,',
        '    StatusIzin.ditolakPermanen => Tindakan.bukaPengaturan,',
        '  };',
        '}',
      ].join('\n'),
      ukuran: 11.5,
      lebarKode: 7.8,
      poin: [
        'Dua sakelar berbeda: LAYANAN lokasi (sakelar Lokasi di HP) dan IZIN aplikasi.',
        'Layanan mati → izin tidak berguna; jangan tampilkan dialog yang percuma.',
        'deniedForever punya tindakan sendiri: jelaskan, lalu tawarkan Buka Pengaturan.',
      ],
      catatan: 'Di slide, parameter fungsi ditulis per baris agar muat; di berkas aslinya dalam satu baris. Tanyakan: jika izin sudah saatDipakai tetapi sakelar Lokasi mati, apa yang terjadi saat mengambil posisi? Gagal. Karena itu layanan diperiksa lebih dulu.',
    });

    d.kode({
      judul: 'Contoh 01: Cerita Rina',
      berkas: 'kode/contoh_01_status_izin_dart_murni.dart',
      shell: true,
      kode: [
        '=== 2. Cerita Rina ===',
        '[1] Aplikasi baru dipasang. Periksa izin: ditolak',
        '[2] Rina mengetuk "Gunakan lokasi saya".',
        '    Dialog sistem muncul -> dipilih "Jangan izinkan"',
        '    Hasil: ditolak (penolakan ke-1, masih boleh diminta)',
        '[3] Rina mengetuk lagi.',
        '    Dialog sistem muncul -> dipilih "Jangan izinkan"',
        '    Hasil: ditolakPermanen (penolakan ke-2)',
        '[4] Rina mengetuk lagi.',
        '    Dialog TIDAK muncul -> langsung: ditolakPermanen',
        '    Aplikasi: Jelaskan, lalu tawarkan tombol "Buka Pengaturan"',
        '[5] Rina membuka Pengaturan dan memilih "Izinkan".',
        '    Periksa izin: saatDipakai -> Ambil lokasi sekarang',
        '[6] Rina mematikan sakelar Lokasi di HP.',
        '    Izin tetap saatDipakai, tetapi: Minta pengguna menyalakan layanan lokasi',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.7,
      poin: [
        'SistemOperasiTiruan meniru aturan Android, di DartPad.',
        'Langkah [4]: dialog tidak muncul lagi walaupun diminta.',
        'Tanpa penanganan deniedForever, tombol seolah rusak: diketuk berkali-kali, tidak terjadi apa-apa.',
        'Bagian 3: Budi memilih "Hanya kali ini"; besoknya kembali ditolak.',
      ],
      catatan: 'Jalankan Contoh 01 di DartPad bersama mahasiswa. Baris [6] menunjukkan bahwa izin dan layanan adalah dua hal berbeda.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 3', judul: 'Menyiapkan Proyek: Paket dan Pengaturan Platform', ikon: 'setel', catatan: 'Dua persiapan: paketnya dipasang, lalu pengaturan platform ditulis agar sistem operasi tahu aplikasi kita memakai lokasi atau kamera.' });

    d.kode({
      judul: 'Menambah Paket',
      shell: true,
      kode: [
        '# di folder proyek',
        'flutter pub add image_picker geolocator',
        '',
        '# pubspec.yaml (urut abjad)',
        'dependencies:',
        '  flutter:',
        '    sdk: flutter',
        '  geolocator: ^14.1.1',
        '  image_picker: ^1.2.4',
      ].join('\n'),
      ukuran: 15,
      lebarKode: 6.6,
      poin: [
        'Contoh 07 dan 08 juga memakai provider, seperti Pertemuan 9–12.',
        'Setelah menambah plugin atau mengubah pengaturan platform: HENTIKAN aplikasi, lalu flutter run ulang.',
        'Hot reload/hot restart hanya memuat ulang kode Dart → galat MissingPluginException.',
      ],
      catatan: 'Kesalahan paling sering di lab: plugin baru dipasang, lalu hanya menekan r (hot reload). Kode asli Android/iOS belum ikut di-build, sehingga muncul MissingPluginException(No implementation found for method ...).',
    });

    d.kode({
      judul: 'Android: AndroidManifest.xml',
      shell: true,
      kode: [
        '<manifest xmlns:android="http://schemas.android.com/apk/res/android">',
        '    <!-- Lokasi perkiraan (area sekitar 3 km persegi). -->',
        '    <uses-permission',
        '        android:name="android.permission.ACCESS_COARSE_LOCATION" />',
        '    <!-- Lokasi tepat (GPS). Di Android 12 ke atas wajib ditulis',
        '         bersama ACCESS_COARSE_LOCATION. -->',
        '    <uses-permission',
        '        android:name="android.permission.ACCESS_FINE_LOCATION" />',
        '',
        '    <application',
        '        android:label="presensi_praktikum"',
        '        ...>',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.6,
      poin: [
        'Ditulis DI ATAS tag <application>.',
        'image_picker: TIDAK perlu baris tambahan (Photo Picker sistem + kamera bawaan).',
        'JANGAN tambahkan izin CAMERA hanya karena image_picker: jika belum diberikan, Android justru menolak membuka kamera bawaan.',
        'Lokasi latar belakang tidak dipakai.',
      ],
      catatan: 'Berkas: android/app/src/main/AndroidManifest.xml. Di slide, setiap <uses-permission> dipecah dua baris agar muat. Dialog Android menampilkan pilihan "Tepat" dan "Perkiraan" jika kedua baris ada. Izin CAMERA hanya untuk tampilan kamera buatan sendiri (paket camera). ACCESS_BACKGROUND_LOCATION hanya untuk aplikasi yang benar-benar harus melacak lokasi saat tidak dibuka, dan diperiksa ketat oleh Google Play.',
    });

    d.kode({
      judul: 'iOS: Kalimat Alasan di Info.plist',
      shell: true,
      kode: [
        '<!-- ios/Runner/Info.plist, di dalam <dict> -->',
        '<key>NSPhotoLibraryUsageDescription</key>',
        '<string>Anda bisa memilih foto dari galeri sebagai foto profil.</string>',
        '<key>NSCameraUsageDescription</key>',
        '<string>Aplikasi memotret foto profil dan foto presensi dengan kamera.</string>',
        '<key>NSLocationWhenInUseUsageDescription</key>',
        '<string>Aplikasi memeriksa jarak Anda ke laboratorium saat presensi.</string>',
      ].join('\n'),
      ukuran: 10.5,
      lebarKode: 7.7,
      poin: [
        'Wajib untuk setiap fitur sensitif; kalimatnya TAMPIL di dialog izin iOS.',
        'Lupa menulis: iOS menutup paksa aplikasi saat kamera/galeri dibuka; geolocator melempar galat saat izin lokasi diminta.',
        'Video bersuara: tambah NSMicrophoneUsageDescription.',
      ],
      catatan: 'Galat dari geolocator itu adalah PermissionDefinitionsNotFoundException. Aplikasi iOS hanya bisa di-build di komputer Mac, tetapi baris-baris ini sebaiknya tetap ditulis sejak awal agar proyek siap untuk iOS. Galat PermissionDefinitionsNotFoundException juga muncul di Android jika izin lokasi lupa ditulis di AndroidManifest.xml.',
    });

    d.banding({
      judul: 'Menulis Kalimat Alasan yang Baik',
      kolom: [
        {
          ikon: 'peringatan', judul: 'Kurang baik', warna: C.accent5,
          poin: [
            '"Lokasi dibutuhkan agar pengalaman lebih baik." → kalimat pasif, alasannya kabur',
            '"Izinkan akses kamera." → kalimat perintah tanpa alasan',
          ],
        },
        {
          ikon: 'centang', judul: 'Lebih baik', warna: C.accent4, sorot: true,
          poin: [
            '"Aplikasi memeriksa jarak Anda ke laboratorium saat presensi."',
            '"Aplikasi memotret foto profil dan foto presensi dengan kamera."',
          ],
        },
      ],
      ukuranPoin: 18,
      pesan: 'Pedoman Apple: satu kalimat lengkap yang AKTIF, SPESIFIK tentang cara dan alasan data dipakai, mudah dipahami, dan diakhiri titik.',
      catatan: 'Minta mahasiswa menulis kalimat alasan untuk fitur proyek akhirnya sendiri, lalu saling menilai dengan pedoman di bawah slide.',
    });

    d.tabel({
      judul: 'Web: Perbedaan Perilaku di Browser',
      kepala: ['Hal', 'Perilaku di browser'],
      lebarKolom: [2.6, 9.0],
      baris: [
        ['Alamat', 'Lokasi dan kamera hanya di konteks aman: HTTPS atau localhost (flutter run -d chrome memakai localhost)'],
        ['Dialog izin', 'Ditampilkan browser; izin situs diatur lewat ikon di sebelah kiri alamat situs'],
        ['Layanan lokasi', 'isLocationServiceEnabled() SELALU true'],
        ['Fungsi yang tidak ada', 'openAppSettings(), openLocationSettings(), getLastKnownPosition(), getServiceStatusStream() → UnsupportedError'],
        ['Foto', 'XFile.path berisi alamat sementara blob:..., bukan lokasi berkas → tampilkan dengan Image.memory'],
        ['Kamera di laptop', 'Biasanya membuka pemilih berkas; di browser HP kamera bisa terbuka langsung'],
      ],
      ukuran: 15,
      tinggiBaris: 0.66,
      catatan: 'Tabel ini menjelaskan banyak perilaku yang akan terlihat di lab: tombol Pengaturan diganti petunjuk ikon situs, dan foto ditampilkan dengan Image.memory, bukan Image.file.',
    });

    d.tabel({
      judul: 'Ringkasan Persiapan',
      kepala: ['', 'Android', 'iOS', 'Web'],
      lebarKolom: [2.0, 3.6, 3.6, 2.4],
      baris: [
        ['Galeri', '—', 'NSPhotoLibraryUsageDescription', '—'],
        ['Kamera', '— (jangan tambah CAMERA)', 'NSCameraUsageDescription', '—'],
        ['Lokasi', 'ACCESS_COARSE_LOCATION + ACCESS_FINE_LOCATION', 'NSLocationWhenInUseUsageDescription', 'HTTPS atau localhost'],
        ['Setelah mengubah', 'Hentikan, lalu flutter run ulang', 'Hentikan, lalu flutter run ulang', 'Muat ulang halaman'],
      ],
      ukuran: 15,
      tinggiBaris: 0.9,
      catatan: 'Minta mahasiswa memotret tabel ini: hampir semua masalah "fitur tidak jalan" di lab berasal dari langkah persiapan yang terlewat.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 4', judul: 'Foto dari Galeri dan Kamera', ikon: 'kamera', catatan: 'image_picker tidak membuat tampilan kamera sendiri. Ia meminjam pemilih foto dan aplikasi kamera bawaan sistem, lalu mengembalikan hasilnya. Seperti meminta teman memotretkan.' });

    d.kode({
      judul: 'Memanggil pickImage',
      berkas: 'kode/contoh_02_galeri_dan_kamera.dart',
      kode: [
        'Future<void> _ambilFoto(ImageSource sumber) async {',
        '  if (_sedangMemilih) return; // cegah pemilih terbuka dua kali',
        '  setState(() => _sedangMemilih = true);',
        '  try {',
        '    final XFile? berkas = await _pemilih.pickImage(',
        '      source: sumber,',
        '      maxWidth: 1080, // foto 4000 piksel diperkecil menjadi 1080',
        '      imageQuality: 80, // 0-100; berlaku untuk JPEG (dan WebP)',
        '      preferredCameraDevice: CameraDevice.front,',
        '      requestFullMetadata: false,',
        '    );',
        '    if (berkas == null) {',
        "      _beriTahu('Tidak ada foto yang dipilih.');",
        '      return;',
        '    }',
        '    await _tampilkan(berkas);',
        '  } on PlatformException catch (e) {',
        '    _beriTahu(pesanGalatFoto(e));',
        '  } finally {',
        '    if (mounted) setState(() => _sedangMemilih = false);',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 10.5,
      lebarKode: 7.2,
      poin: [
        'final ImagePicker _pemilih = ImagePicker(); cukup SEKALI sebagai field (tanpa const).',
        'ImageSource.gallery atau ImageSource.camera.',
        'Kamera depan hanya DIMINTA; tidak semua HP menurutinya.',
        'requestFullMetadata: false → tanpa metadata seperti lokasi pemotretan.',
        '_sedangMemilih: penjaga ketukan ganda (galat already_active / multiple_request).',
      ],
      catatan: 'Di slide, empat baris komentar di dalam pickImage dilewati (lihat modul Bagian 4.2). Di Android 13+, galeri dibuka lewat Photo Picker: pengguna hanya menyerahkan foto yang dipilihnya, sehingga aplikasi tidak perlu izin galeri. Di iOS, requestFullMetadata: false juga menghindari permintaan izin galeri tambahan.',
    });

    d.banding({
      judul: 'Tiga Kemungkinan Hasil',
      kolom: [
        {
          ikon: 'centang', judul: 'XFile', warna: C.accent4, tag: 'Foto dipilih atau dipotret',
          poin: ['Tampilkan fotonya'],
        },
        {
          ikon: 'kembali', judul: 'null', warna: C.accent6, tag: 'Pengguna MEMBATALKAN', sorot: true,
          poin: ['Bukan kesalahan', 'Pesan singkat, atau tanpa pesan sama sekali', 'Jangan pakai berkas!'],
        },
        {
          ikon: 'galat', judul: 'PlatformException', warna: C.accent5, tag: 'Ada masalah',
          poin: ['Misalnya akses kamera ditolak', 'Pesan yang menjelaskan masalah dan jalan keluarnya'],
        },
      ],
      ukuranPoin: 16,
      pesan: 'pickMultiImage: batal menghasilkan daftar KOSONG, bukan null.',
      catatan: 'Kesalahan klasik: setState(() => _jalur = berkas!.path). Saat pengguna menutup pemilih, berkas bernilai null dan aplikasi galat (soal C1 Latihan). Batal adalah salah satu HASIL yang harus diputuskan dengan sengaja.',
    });

    d.kode({
      judul: 'Satu Fungsi untuk Pesan Galat',
      berkas: 'kode/contoh_02_galeri_dan_kamera.dart',
      kode: [
        'String pesanGalatFoto(PlatformException e) {',
        '  return switch (e.code) {',
        "    'camera_access_denied' =>",
        "      'Akses kamera ditolak. Anda bisa mengizinkannya di Pengaturan.',",
        "    'photo_access_denied' =>",
        "      'Akses galeri ditolak. Anda bisa mengizinkannya di Pengaturan.',",
        "    'camera_access_restricted' ||",
        "    'photo_access_restricted' => 'Akses dibatasi oleh pengaturan perangkat.',",
        "    'no_available_camera' => 'Perangkat ini tidak memiliki kamera.',",
        "    'already_active' ||",
        "    'multiple_request' => 'Pemilih foto masih terbuka. Coba lagi.',",
        "    _ => 'Foto gagal diambil (${e.code}).',",
        '  };',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.7,
      poin: [
        'camera_access_denied: Android dan iOS.',
        'photo_access_denied, ..._restricted: iOS (misalnya kontrol orang tua).',
        'no_available_camera: Android tanpa kamera.',
        'Cabang _: kode lain ikut ditampilkan agar mudah dilaporkan.',
      ],
      catatan: 'Pesan disusun di SATU fungsi, sehingga mudah diperiksa dan diubah. Di Bagian 9, gagasan ini diperluas menjadi tanggapanUntuk(Kegagalan) yang juga menentukan tombol perbaikan.',
    });

    d.kode({
      judul: 'Membaca dan Menampilkan Foto',
      berkas: 'kode/contoh_02_galeri_dan_kamera.dart',
      kode: [
        '/// Membaca isi berkas, lalu mencari tahu ukuran gambarnya.',
        'Future<void> _tampilkan(XFile berkas) async {',
        '  final Uint8List bita = await berkas.readAsBytes();',
        '  final ui.Image gambar = await decodeImageFromList(bita);',
        '  final FotoTerpilih foto = FotoTerpilih(',
        '    nama: berkas.name,',
        '    bita: bita,',
        '    lebar: gambar.width,',
        '    tinggi: gambar.height,',
        '    jenis: berkas.mimeType,',
        '  );',
        '  gambar.dispose(); // yang kita perlukan hanya ukurannya',
        '  if (!mounted) return;',
        '  setState(() => _foto = foto);',
        '}',
        '',
        '// cacheWidth: gambar diuraikan (decode) seukuran tampilan',
        '// saja, sehingga memori tidak terbuang untuk foto besar.',
        'Image.memory(f.bita, fit: BoxFit.cover, cacheWidth: 480),',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.2,
      poin: [
        'XFile: name, path, mimeType (bisa null di Android), length(), readAsBytes().',
        'Image.memory berjalan di SEMUA platform.',
        'Image.file(File(path)) memakai dart:io → tidak tersedia di web.',
        'Foto kamera ada di folder sementara (cache); salin (XFile.saveTo) atau unggah jika perlu disimpan lama.',
      ],
      catatan: 'Di web, XFile.path berisi alamat sementara blob:... Kode yang memakai File(berkas.path) menghasilkan galat Unsupported operation di Chrome (soal C1 Latihan). cacheWidth mencegah memori terbuang: foto besar tidak perlu diuraikan dengan ukuran aslinya hanya untuk ditampilkan di lingkaran kecil.',
    });

    d.kode({
      judul: 'Kamera, Foto "Hilang", dan Banyak Foto',
      berkas: 'kode/contoh_02_galeri_dan_kamera.dart',
      kode: [
        '// Di Android, iOS, dan web: true. Di Windows/Linux/macOS: false.',
        'final bool kameraAda = _pemilih.supportsImageSource(ImageSource.camera);',
        '',
        '// Khusus Android, dipanggil di initState:',
        'Future<void> _pulihkanFotoYangHilang() async {',
        '  if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;',
        '  final LostDataResponse respons = await _pemilih.retrieveLostData();',
        '  final XFile? berkas = respons.file;',
        '  if (respons.isEmpty || berkas == null) return;',
        '  await _tampilkan(berkas);',
        '}',
        '',
        'final List<XFile> daftar = await _pemilih.pickMultiImage(',
        '  maxWidth: 1080,',
        '  imageQuality: 80,',
        '  limit: 5, // paling banyak 5 foto (berlaku di Android dan iOS)',
        ');',
        'if (daftar.isEmpty) return; // dibatalkan: daftar kosong, bukan null',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.4,
      poin: [
        'supportsImageSource: tombol Kamera hanya tampil jika didukung.',
        'retrieveLostData(): foto yang sempat "hilang" diminta SEKALI.',
        'Urutan kIsWeb || penting: di browser HP, defaultTargetPlatform bisa android.',
        'pickMultiImage untuk beberapa foto sekaligus.',
      ],
      catatan: 'Saat aplikasi kamera terbuka, aplikasi kita berpindah ke latar belakang. Jika memori HP menipis, Android boleh mematikannya. Ketika pengguna selesai memotret, aplikasi dibuka ulang dari awal, dan foto seolah hilang. image_picker menyimpannya, dan foto itu diminta sekali lewat retrieveLostData(). Dua baris komentar pemisah ditambahkan di slide. image_picker juga punya pickVideo dan pickMedia.',
    });

    d.layar({
      judul: 'Contoh 02: Foto Profil',
      gambar: ['hasil_contoh_02a.jpg', 'hasil_contoh_02b.jpg'],
      lebarMaks: 6.9,
      berkas: 'kode/contoh_02_galeri_dan_kamera.dart',
      poin: [
        'Kiri: pemilih ditutup tanpa memilih → null → pesan singkat "Tidak ada foto yang dipilih."',
        'Kanan: foto kamera sudah diperkecil menjadi lebar 1080 piksel (maxWidth), 48 KB.',
        'Jalankan: flutter create foto_profil → flutter pub add image_picker → flutter run -d chrome.',
      ],
      ukuranPoin: 16,
      catatan: 'Kartu di gambar kanan menampilkan nama berkas, ukuran gambar 1080 x 1440 piksel, dan ukuran berkas 48 KB image/jpeg. Tombol Hapus foto mengosongkan kembali lingkarannya.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 5', judul: 'Lokasi Perangkat', ikon: 'lokasi', catatan: 'Setiap titik di permukaan bumi bisa ditulis dengan dua angka: lintang dan bujur. GPS juga selalu memberi tahu seberapa yakin ia dengan posisinya.' });

    d.kartu({
      judul: 'Koordinat dan Akurasi',
      kolom: 3,
      item: [
        { ikon: 'jelajah', judul: 'Lintang (latitude)', isi: '−90 (kutub selatan) sampai 90 (kutub utara). Negatif = di selatan khatulistiwa. Contoh: -0.4700' },
        { ikon: 'jelajah', judul: 'Bujur (longitude)', isi: '−180 sampai 180. Positif = di timur Greenwich (Inggris). Contoh: 117.1580', warna: C.accent6 },
        { ikon: 'lokasi', judul: 'Akurasi (meter)', isi: 'Jari-jari lingkaran tempat posisi sebenarnya kemungkinan besar berada. Makin kecil, makin baik', warna: C.accent4 },
        { ikon: 'peta', judul: 'Indonesia', isi: 'Lintang kira-kira −11 sampai 6, bujur 95 sampai 141.' },
        { ikon: 'pin', judul: 'Koordinat kampus', isi: 'Google Maps di laptop: klik kanan titiknya, lalu klik angka koordinat di baris paling atas.', warna: C.accent6 },
        { ikon: 'lihat', judul: 'Lingkaran biru', isi: 'Di aplikasi peta, akurasi digambar sebagai lingkaran biru transparan di sekitar titik biru.', warna: C.accent4 },
      ],
      catatan: 'Koordinat di modul hanyalah contoh; ganti dengan koordinat kampus Anda.',
    });

    d.tabel({
      judul: 'Akurasi: Lingkaran Ketidakpastian',
      kepala: ['Keadaan', 'Akurasi yang biasa didapat'],
      lebarKolom: [6.6, 5.0],
      baris: [
        ['Di luar ruangan, langit terbuka', '± 3–10 m'],
        ['Di dalam gedung, dekat jendela', '± 10–30 m'],
        ['Di dalam gedung, jauh dari jendela', 'Puluhan sampai ratusan meter'],
        ['Pengguna hanya memberi lokasi PERKIRAAN', 'Area ± 3 km persegi'],
      ],
      ukuran: 17,
      tinggiBaris: 0.7,
      pesan: 'Aplikasi yang mengambil keputusan dari lokasi (misalnya presensi) WAJIB ikut memeriksa akurasi.',
      catatan: 'Angka di atas hanya gambaran; hasil nyata bergantung pada HP, cuaca, dan bangunan. Uji pemahaman: akurasi 45 m lebih baik atau lebih buruk daripada 30 m? Lebih buruk: angka yang lebih kecil berarti lebih yakin.',
    });

    d.kode({
      judul: 'Tiga Pemeriksaan Berurutan',
      berkas: 'kode/contoh_03_lokasi_sekarang.dart',
      kode: [
        'Future<KeadaanLokasi> _ambilLokasi() async {',
        '  // 1. Sakelar Lokasi di perangkat. (Di web selalu true.)',
        '  if (!await Geolocator.isLocationServiceEnabled()) {',
        '    return const LokasiGagal(MasalahLokasi.layananMati);',
        '  }',
        '  // 2. Izin. checkPermission() tidak pernah menampilkan dialog;',
        '  //    requestPermission() menampilkannya jika masih boleh.',
        '  LocationPermission izin = await Geolocator.checkPermission();',
        '  if (izin == LocationPermission.denied ||',
        '      izin == LocationPermission.unableToDetermine) {',
        '    izin = await Geolocator.requestPermission();',
        '  }',
        '  final MasalahLokasi? masalahIzin = switch (izin) {',
        '    LocationPermission.denied => MasalahLokasi.izinDitolak,',
        '    LocationPermission.deniedForever => MasalahLokasi.izinDiblokir,',
        '    LocationPermission.whileInUse ||',
        '    LocationPermission.always ||',
        '    LocationPermission.unableToDetermine => null,',
        '  };',
        '  if (masalahIzin != null) return LokasiGagal(masalahIzin);',
        '  // 3. Posisi, dengan batas waktu (slide berikutnya) ...',
        '}',
      ].join('\n'),
      ukuran: 10.5,
      lebarKode: 7.2,
      poin: [
        'checkPermission(): TANPA dialog.',
        'requestPermission(): dialog, hanya jika status masih denied.',
        'Kelima status wajib ditangani; deniedForever punya pesan sendiri.',
        'Empat keadaan layar (sealed class): BelumDiminta, SedangMencari, LokasiDitemukan, LokasiGagal.',
      ],
      catatan: 'Langkah 3 ada di slide berikutnya. KeadaanLokasi adalah sealed class, persis seperti Hasil di Pertemuan 12; di build, switch atas keadaan ini menentukan apa yang tampil.',
    });

    d.kode({
      judul: 'Posisi dengan Batas Waktu',
      berkas: 'kode/contoh_03_lokasi_sekarang.dart',
      kode: [
        '// 3. Posisi. GPS bisa lama di dalam gedung, jadi diberi batas waktu.',
        'try {',
        '  final Position posisi = await Geolocator.getCurrentPosition(',
        '    locationSettings: const LocationSettings(',
        '      accuracy: LocationAccuracy.high,',
        '      timeLimit: Duration(seconds: 15),',
        '    ),',
        '  );',
        '  return LokasiDitemukan(posisi);',
        '} on TimeoutException {',
        '  return const LokasiGagal(MasalahLokasi.waktuHabis);',
        '} on LocationServiceDisabledException {',
        '  return const LokasiGagal(MasalahLokasi.layananMati);',
        '} on PermissionDeniedException {',
        '  return const LokasiGagal(MasalahLokasi.izinDitolak);',
        '} on PositionUpdateException {',
        '  return const LokasiGagal(MasalahLokasi.lainnya);',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.6,
      poin: [
        'Tanpa timeLimit, pengguna di dalam gedung bisa menunggu tanpa akhir.',
        'TimeoutException berasal dari dart:async.',
        'high: cukup untuk presensi. best/bestForNavigation: paling boros baterai.',
        'desiredAccuracy: dan timeLimit: langsung di getCurrentPosition sudah USANG.',
      ],
      catatan: 'Exception lain: PermissionRequestInProgressException (requestPermission dipanggil lagi sebelum dialog dijawab) dan PermissionDefinitionsNotFoundException (izin lupa ditulis di manifest/Info.plist). Keduanya menandakan kesalahan kode kita, jadi sengaja tidak ditangkap. LocationAccuracy lain: lowest/low (hemat, ratusan meter sampai kilometer), medium, reduced (iOS 14+, dikaburkan). getLastKnownPosition() cepat tetapi bisa sudah lama atau null: tidak cocok untuk presensi.',
    });

    d.kode({
      judul: 'Kembali dari Pengaturan',
      berkas: 'kode/contoh_03_lokasi_sekarang.dart',
      kode: [
        'late final AppLifecycleListener _pendengar;',
        '',
        '@override',
        'void initState() {',
        '  super.initState();',
        '  _pendengar = AppLifecycleListener(onResume: _saatKembali);',
        '}',
        '',
        '@override',
        'void dispose() {',
        '  _pendengar.dispose();',
        '  super.dispose();',
        '}',
        '',
        'void _saatKembali() {',
        '  final KeadaanLokasi k = _keadaan;',
        '  if (k is LokasiGagal &&',
        '      (k.masalah == MasalahLokasi.layananMati ||',
        '          k.masalah == MasalahLokasi.izinDiblokir)) {',
        '    _cariLokasi();',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 10.5,
      lebarKode: 7.0,
      poin: [
        'Pengaturan = aplikasi LAIN; aplikasi kita ke latar belakang.',
        'onResume: periksa ulang tanpa menyuruh pengguna mengetuk lagi; hanya jika tadi gagal karena layanan mati atau izin diblokir.',
        'Tombol: openLocationSettings() untuk layanan, openAppSettings() untuk izin (tidak ada di web).',
        'Di web: klik ikon alamat → inactive; klik halaman → resumed → lokasi diperiksa ulang sendiri.',
      ],
      catatan: 'AppLifecycleListener sudah dikenal di Pertemuan 1 Bagian 6. Jangan lupa dispose(), seperti TextEditingController di Pertemuan 5. Komentar di dalam kode dilewati di slide (lihat modul Bagian 5.6). Dialog izin TIDAK muncul lagi untuk izin yang diblokir, jadi pemeriksaan ulang ini tidak mengganggu pengguna. Di browser, untuk izin yang diblokir, Contoh 03 menampilkan petunjuk "Klik ikon di sebelah kiri alamat situs" sebagai ganti tombol (memeriksa kIsWeb).',
    });

    d.layar({
      judul: 'Contoh 03: Di Mana Saya?',
      gambar: ['hasil_contoh_03a.jpg', 'hasil_contoh_03b.jpg', 'hasil_contoh_03c.jpg'],
      lebarMaks: 8.1,
      berkas: 'kode/contoh_03_lokasi_sekarang.dart',
      poin: [
        'Berhasil: koordinat, ± 8 m, 21 m ke kampus.',
        'HP: izin diblokir → Buka Pengaturan.',
        'Browser: petunjuk ikon situs.',
      ],
      ukuranPoin: 15,
      catatan: 'Jalankan: flutter create di_mana_saya, flutter pub add geolocator, tambahkan izin lokasi di AndroidManifest.xml (dan Info.plist), salin Contoh 03, lalu jalankan. Coba ketiga jawaban dialog izin. Untuk mengulang dari awal, cabut izinnya (Bagian 11.4). Jarak dihitung dengan Geolocator.distanceBetween, arah dengan Geolocator.bearingBetween; jika posisi.isMocked, kartu menambahkan peringatan lokasi palsu.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 6', judul: 'Jarak, Arah, dan Zona', ikon: 'ukur', catatan: 'Setelah mendapat koordinat: seberapa jauh dari kampus, ke arah mana, dan apakah sudah berada di dalam area presensi? Contoh 04 menjawabnya dengan Dart murni di DartPad.' });

    d.statistik({
      judul: 'Satu Derajat Itu Sejauh Apa?',
      ukuranAngka: 54,
      item: [
        { ikon: 'ukur', angka: '111,3 km', label: '1 derajat lintang (dan 1 derajat bujur di khatulistiwa)', warna: C.accent1 },
        { ikon: 'jelajah', angka: '55,7 km', label: '1 derajat bujur di lintang 60', warna: C.accent6 },
        { ikon: 'lokasi', angka: '11 m', label: '0,0001 derajat lintang (4 angka di belakang koma)', warna: C.accent4 },
      ],
      pesan: 'Garis bujur bertemu di kutub, jadi 1 derajat bujur makin pendek ke arah kutub. 6 angka di belakang koma ≈ 10 cm → toStringAsFixed(6).',
      catatan: 'Keluaran bagian 1 Contoh 04. Inilah alasan jarak dua koordinat tidak bisa dihitung dengan Pythagoras langsung pada angka derajatnya (soal A10 dan B2 Latihan).',
    });

    d.kode({
      judul: 'Rumus Jarak di Permukaan Bumi (Haversine)',
      berkas: 'kode/contoh_04_jarak_dan_zona_dart_murni.dart',
      kode: [
        'const double jariJariBumiMeter = 6378137.0;',
        '',
        'double _keRadian(double derajat) => derajat * pi / 180;',
        '',
        '/// Jarak "garis lurus di permukaan bumi" antara dua titik, dalam meter.',
        'double jarakMeter(Koordinat a, Koordinat b) {',
        '  final double dLintang = _keRadian(b.lintang - a.lintang);',
        '  final double dBujur = _keRadian(b.bujur - a.bujur);',
        '  final double h =',
        '      pow(sin(dLintang / 2), 2) +',
        '      pow(sin(dBujur / 2), 2) *',
        '          cos(_keRadian(a.lintang)) *',
        '          cos(_keRadian(b.lintang));',
        '  return jariJariBumiMeter * 2 * asin(sqrt(h));',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.8,
      poin: [
        'Tidak perlu dihafal.',
        'sin dan cos di dart:math memakai RADIAN.',
        'Jari-jari 6378137 m = Geolocator.distanceBetween → hasil sama.',
        'Jarak GARIS LURUS, bukan jarak tempuh lewat jalan.',
        'Ditulis sendiri karena aturan bisnis di domain = Dart murni (Pertemuan 12).',
      ],
      catatan: 'Di aplikasi biasa, cukup panggil Geolocator.distanceBetween. Contoh 04 dan studi kasus menulis rumusnya sendiri agar domain tidak mengimpor paket perangkat, sehingga aturan bisa diuji di mana saja, termasuk DartPad. Untuk rute jalan, dibutuhkan layanan peta.',
    });

    d.kode({
      judul: 'Arah: Delapan Mata Angin',
      berkas: 'kode/contoh_04_jarak_dan_zona_dart_murni.dart',
      kode: [
        'String namaArah(double derajat) {',
        '  const List<String> nama = [',
        "    'utara', 'timur laut', 'timur', 'tenggara',",
        "    'selatan', 'barat daya', 'barat', 'barat laut',",
        '  ];',
        '  // Satu arah mencakup 45 derajat, berpusat pada sudutnya (utara: -22,5',
        '  // sampai 22,5 derajat).',
        '  return nama[((derajat + 22.5) ~/ 45) % 8];',
        '}',
        '',
        '// === 2. Jarak dan arah dari lab ===',
        '// Depan pintu lab    25 m  arah 153 derajat (tenggara)',
        '// Kantin            176 m  arah 125 derajat (tenggara)',
        '// Gerbang kampus    553 m  arah 214 derajat (barat daya)',
        '// Rumah kos        2,1 km  arah 216 derajat (barat daya)',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.8,
      poin: [
        'Arah (bearing): derajat searah jarum jam dari utara.',
        '0 utara, 90 timur, 180 selatan, 270 barat.',
        'bearingBetween memberi −180..180 → ubah dulu ke 0..360.',
        '~/ = pembagian bulat; % 8 membuat 360 kembali ke utara.',
      ],
      catatan: 'Di slide, daftar nama arah dirapatkan empat per baris; di berkas aslinya satu per baris. Uji pemahaman: namaArah(22.5)? Tepat di batas, masuk ke sektor berikutnya: timur laut (soal B2).',
    });

    d.kode({
      judul: 'Aturan Zona Presensi',
      berkas: 'kode/contoh_04_jarak_dan_zona_dart_murni.dart',
      kode: [
        '/// Aturan presensi. Urutan pemeriksaan disengaja:',
        '/// 1. lokasi palsu (aplikasi pemalsu GPS) langsung ditolak;',
        '/// 2. GPS dengan akurasi buruk (lingkaran ketidakpastiannya lebar)',
        '///    belum bisa dipercaya, apa pun jaraknya;',
        '/// 3. baru jaraknya dibandingkan dengan radius.',
        'HasilZona periksaZona({',
        '  required Koordinat posisi,',
        '  required double akurasiMeter,',
        '  required bool palsu,',
        '  required Koordinat pusat,',
        '  double radiusMeter = 100,',
        '  double akurasiMaksimal = 50,',
        '}) {',
        '  if (palsu) return HasilZona.lokasiPalsu;',
        '  if (akurasiMeter > akurasiMaksimal) return HasilZona.kurangAkurat;',
        '  if (jarakMeter(posisi, pusat) > radiusMeter) return HasilZona.diLuar;',
        '  return HasilZona.diDalam;',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.8,
      poin: [
        'Di dalam lab, akurasi 120 m → "lokasi kurang akurat" (tetap ditolak).',
        'Batas diuji: 100 m boleh, 101 m di luar area.',
        'Lokasi palsu: Position.isMocked (Android).',
        'Pemeriksaan di aplikasi tidak pernah benar-benar aman: server sebaiknya ikut memeriksa.',
      ],
      catatan: 'Keluaran bagian 3: di depan pintu (25 m, ± 8 m) boleh presensi; di kantin (176 m) di luar area; di dalam lab dengan akurasi 120 m kurang akurat; pemalsu GPS terdeteksi; hampir 100 m boleh; sedikit lewat 100 m (101 m) di luar area. Deteksi isMocked tidak sempurna, jadi untuk keperluan resmi server ikut memeriksa (waktu, Wi-Fi kampus, foto). Uji pemahaman: 30 m dengan akurasi ± 80 m? kurangAkurat, karena akurasi diperiksa sebelum jarak.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 7', judul: 'Alur Izin yang Sopan', ikon: 'dialog', catatan: 'Dialog izin hanya punya satu kesempatan yang baik. Jika pengguna kaget atau tidak mengerti gunanya, ia akan menolak; setelah dua kali, dialognya tidak muncul lagi.' });

    d.banding({
      judul: 'Minta Saat Fiturnya Dipakai',
      kolom: [
        {
          ikon: 'peringatan', judul: 'Aplikasi A', warna: C.accent5,
          poin: [
            'Baru dibuka, langsung tiga dialog berturut-turut: lokasi, kamera, notifikasi',
            'Pengguna belum tahu untuk apa izinnya',
            'Akibatnya: semua ditolak',
          ],
        },
        {
          ikon: 'centang', judul: 'Aplikasi B', warna: C.accent4, sorot: true,
          poin: [
            'Aplikasi langsung bisa dipakai',
            'Dialog lokasi baru muncul saat pengguna mengetuk "Urutkan dari yang terdekat"',
            'Pengguna paham hubungannya → lebih mungkin mengizinkan',
          ],
        },
      ],
      ukuranPoin: 17,
      pesan: 'Pedoman Android dan Apple sama-sama menyarankan Aplikasi B: minta izin DALAM KONTEKS.',
      catatan: 'Tanyakan: aplikasi apa di HP mereka yang berperilaku seperti Aplikasi A? Ini juga pertanyaan Refleksi 1 di Jobsheet.',
    });

    d.layar({
      judul: 'Jelaskan Dulu di Layar Sendiri',
      gambar: ['hasil_contoh_05a.jpg', 'hasil_contoh_05b.jpg'],
      lebarMaks: 6.9,
      berkas: 'kode/contoh_05_alur_izin_yang_sopan.dart',
      poin: [
        'Kartu yang baik menjawab: APA manfaatnya, KE MANA datanya pergi, BAGAIMANA jika tidak mau ("Nanti saja").',
        'Baru setelah diketuk: dialog sistem (di contoh ini simulasi).',
        'iOS lebih ketat: layar penjelasan hanya boleh satu tombol "Lanjutkan".',
      ],
      ukuranPoin: 15,
      catatan: 'Contoh 05 "Ruang Belajar" berjalan di DartPad; dialog izin dan halaman Pengaturan adalah simulasi yang meniru Android, sehingga alurnya bisa dipelajari tanpa HP. Kartu memakai pola switch dengan syarat tambahan (case StatusIzin.ditolak when !pernahMinta && !nantiSaja), sehingga status ditolak bisa punya tampilan berbeda sebelum dan sesudah izin pernah diminta. Pedoman Apple: layar pra-izin tanpa tombol batal; pengguna tetap bisa menolak di dialog sistem. Pedoman Android membolehkan pilihan untuk tidak melanjutkan.',
    });

    d.layar({
      judul: 'Ditolak? Tetap Jalan. Diblokir? Tawarkan Pengaturan',
      gambar: ['hasil_contoh_05c.jpg', 'hasil_contoh_05d.jpg'],
      lebarMaks: 6.9,
      berkas: 'kode/contoh_05_alur_izin_yang_sopan.dart',
      poin: [
        'Ditolak: daftar tetap tampil (urut abjad) + tombol Coba lagi.',
        'Diblokir: jelaskan dengan tenang + tombol Buka Pengaturan.',
        'Degradasi anggun (graceful degradation): fitur dikurangi, sisanya tetap berfungsi.',
        'Tidak sopan: peringatan "Izinkan lokasi!" setiap kali dibuka, atau menutup aplikasi.',
      ],
      ukuranPoin: 15,
      catatan: 'Pesannya tidak menyalahkan pengguna, karena menolak izin adalah hak pengguna. Kode urutan: final bool urutJarak = status == StatusIzin.saatDipakai; lalu daftar.sort menurut jarak atau menurut nama.',
    });

    d.layar({
      judul: 'Kembali dari Pengaturan: Langsung Terurut',
      gambar: ['hasil_contoh_05e.jpg', 'hasil_contoh_05f.jpg'],
      lebarMaks: 6.9,
      berkas: 'kode/contoh_05_alur_izin_yang_sopan.dart',
      poin: [
        'Pengaturan (simulasi): "Izinkan hanya saat aplikasi digunakan".',
        'Kembali: daftar langsung diurutkan dari yang terdekat (31 m, 118 m, 205 m, ...).',
        'Menu titik tiga: "Tutup lalu buka lagi" (efek Hanya kali ini) dan "Pasang ulang aplikasi".',
      ],
      ukuranPoin: 15,
      catatan: 'Urutan percobaan di kelas: (1) Gunakan lokasi saya → dialog; (2) Jangan izinkan → urut abjad + Coba lagi; (3) Coba lagi → Jangan izinkan sekali lagi → diblokir; (4) Buka Pengaturan → izinkan → kembali → terurut menurut jarak.',
    });

    d.tabel({
      judul: 'Daftar Periksa Izin yang Sopan',
      kepala: ['✔ Lakukan', '✘ Hindari'],
      lebarKolom: [5.8, 5.8],
      baris: [
        ['Minta izin saat pengguna memakai fiturnya', 'Meminta semua izin saat aplikasi pertama dibuka'],
        ['Jelaskan manfaatnya sebelum dialog sistem', 'Dialog sistem tanpa konteks apa pun'],
        ['Tetap berfungsi saat izin ditolak, dengan pesan jelas', 'Aplikasi macet, kosong, atau menutup sendiri'],
        ['Tawarkan tombol Pengaturan saat izin diblokir', 'Peringatan berulang-ulang yang memaksa'],
        ['Periksa ulang saat kembali dari Pengaturan', 'Menyuruh menutup lalu membuka ulang aplikasi'],
        ['Minta izin paling kecil yang cukup ("saat dipakai")', 'Meminta lokasi latar belakang padahal tidak perlu'],
      ],
      ukuran: 15,
      tinggiBaris: 0.66,
      catatan: 'Daftar ini juga dipakai sebagai rubrik "izin yang sopan" di tugas mandiri dan proyek akhir.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 8', judul: 'Mengikuti Lokasi Terus-Menerus', ikon: 'rute', catatan: 'getCurrentPosition seperti memotret: satu posisi. Aplikasi peta, olahraga, dan pesan-antar butuh posisi baru setiap kali perangkat berpindah, seperti merekam video.' });

    d.banding({
      judul: 'Sekali Ambil atau Terus Mengikuti?',
      kolom: [
        {
          ikon: 'kamera', judul: 'getCurrentPosition()', warna: C.accent6, tag: 'Future<Position>: satu posisi',
          poin: ['GPS menyala sebentar, sampai posisi didapat', 'Presensi, menandai lokasi laporan'],
        },
        {
          ikon: 'rute', judul: 'getPositionStream()', warna: C.accent1, tag: 'Stream<Position>: banyak posisi', sorot: true,
          poin: ['GPS menyala TERUS selama masih berlangganan', 'Pencatat olahraga, navigasi', 'Wajib dihentikan: cancel()'],
        },
      ],
      ukuranPoin: 17,
      pesan: 'Contoh 06 "Jalan Pagi" memakai getPositionStream untuk mencatat jarak jalan kaki, hanya SELAMA aplikasi terbuka.',
      catatan: 'Stream sudah dikenal di Pertemuan 3. Langganan (StreamSubscription) dibuat dengan listen dan dihentikan dengan cancel.',
    });

    d.kode({
      judul: 'Berlangganan: Membuka Keran',
      berkas: 'kode/contoh_06_lokasi_terus_menerus.dart',
      kode: [
        '// Dua "keran" yang harus ditutup: langganan lokasi dan pewaktu.',
        'StreamSubscription<Position>? _langganan;',
        'Timer? _pewaktu;',
        '',
        '// Di _mulai(), setelah layanan dan izin siap:',
        '// Mulai berlangganan. Selama langganan aktif, GPS menyala.',
        '_langganan = Geolocator.getPositionStream(',
        '  locationSettings: const LocationSettings(',
        '    accuracy: LocationAccuracy.high,',
        '    distanceFilter: 5, // kirim posisi baru setiap pindah >= 5 m',
        '  ),',
        ').listen(_titikBaru, onError: _galatLokasi);',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.6,
      poin: [
        'Langganan = KERAN AIR: selama terbuka, posisi mengalir dan baterai terpakai.',
        '_titikBaru dipanggil untuk setiap posisi baru; _galatLokasi jika terjadi galat.',
        'distanceFilter: 5 → posisi baru hanya jika berpindah ≥ 5 m; mengurangi pekerjaan dan "getaran" titik saat diam.',
      ],
      catatan: 'Contoh 06 "Jalan Pagi" mencatat jarak jalan kaki. Pewaktu (Timer) menghitung lama berjalan. Penjaga _menyiapkan mencegah dua ketukan cepat pada Mulai mencatat membuat dua langganan sekaligus (gagasan yang sama dengan Perintah di Pertemuan 12).',
    });

    d.kode({
      judul: 'Berhenti: Menutup Keran',
      berkas: 'kode/contoh_06_lokasi_terus_menerus.dart',
      kode: [
        'void _berhenti() {',
        '  _langganan?.cancel();',
        '  _pewaktu?.cancel();',
        '  setState(() {',
        '    _langganan = null;',
        '    _pewaktu = null;',
        '  });',
        '}',
        '',
        '@override',
        'void dispose() {',
        '  // Halaman ditutup: hentikan GPS dan pewaktu.',
        '  _langganan?.cancel();',
        '  _pewaktu?.cancel();',
        '  super.dispose();',
        '}',
      ].join('\n'),
      ukuran: 14,
      lebarKode: 6.6,
      poin: [
        'cancel() menutup keran: GPS boleh dimatikan sistem.',
        'Lupa cancel → GPS tetap menyala walau halaman sudah ditutup; baterai terkuras tanpa disadari.',
        'dispose(): tempat terakhir menutup keran, misalnya saat pengguna menekan tombol kembali.',
      ],
      catatan: 'Kesalahan umum "baterai cepat habis setelah memakai aplikasi" hampir selalu berasal dari langganan getPositionStream yang tidak dibatalkan.',
    });

    d.kode({
      judul: 'Menyaring Titik yang Kabur',
      berkas: 'kode/contoh_06_lokasi_terus_menerus.dart',
      kode: [
        'void _titikBaru(Position p) {',
        '  if (p.accuracy > 25) {',
        '    setState(() => _diabaikan++); // terlalu kabur, abaikan',
        '    return;',
        '  }',
        '  setState(() {',
        '    if (_titik.isNotEmpty) {',
        '      final Position sebelum = _titik.last;',
        '      _totalMeter += Geolocator.distanceBetween(',
        '        sebelum.latitude,',
        '        sebelum.longitude,',
        '        p.latitude,',
        '        p.longitude,',
        '      );',
        '    }',
        '    _titik.add(p);',
        '  });',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 6.6,
      poin: [
        'GPS kadang mengirim posisi berakurasi buruk, misalnya saat melewati gedung tinggi.',
        'Jika ikut dijumlahkan, total jarak "melompat" puluhan meter.',
        'Contoh 06 mengabaikan titik dengan akurasi lebih dari 25 m, dan menghitung berapa yang diabaikan.',
      ],
      catatan: 'Jarak antartitik dihitung dengan Geolocator.distanceBetween, lalu dijumlahkan ke _totalMeter.',
    });

    d.kode({
      judul: 'Galat di Tengah Jalan',
      berkas: 'kode/contoh_06_lokasi_terus_menerus.dart',
      kode: [
        'void _galatLokasi(Object galat) {',
        '  _berhenti();',
        '  setState(() {',
        '    _pesan = switch (galat) {',
        '      LocationServiceDisabledException() =>',
        "        'Layanan lokasi dimatikan, jadi pencatatan dihentikan.',",
        '      PermissionDeniedException() =>',
        "        'Izin lokasi dicabut, jadi pencatatan dihentikan.',",
        "      _ => 'Lokasi terputus, jadi pencatatan dihentikan.',",
        '    };',
        '  });',
        '}',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.6,
      poin: [
        'Saat mencatat, pengguna bisa mematikan sakelar Lokasi atau mencabut izin.',
        'Galat datang lewat onError → pencatatan dihentikan dengan pesan yang jelas.',
        'switch atas jenis galat, dengan pola objek seperti LocationServiceDisabledException().',
      ],
      catatan: 'Ini mirip penanganan exception di getCurrentPosition (Bagian 5.4), tetapi galatnya datang lewat Stream, sehingga ditangkap di onError, bukan dengan try/catch.',
    });

    d.layar({
      judul: 'Contoh 06: Jalan Pagi',
      gambar: 'hasil_contoh_06a.jpg',
      lebarMaks: 3.6,
      berkas: 'kode/contoh_06_lokasi_terus_menerus.dart',
      poin: [
        'Jarak 88 m dalam 00:09; 7 titik tercatat, 1 diabaikan (akurasi lebih dari 25 m).',
        'Titik yang diabaikan berakurasi ± 40 m: tanpa penyaringan, ia menambah jarak palsu.',
        'Mencoba: HP Android sambil berjalan; Chrome → DevTools → Sensors (ubah lokasi beberapa kali); emulator → Routes.',
        'Hanya mencatat SELAMA aplikasi terbuka.',
      ],
      catatan: 'Mencatat di latar belakang membutuhkan izin lokasi "selalu", layanan latar depan (foreground service) di Android, pengaturan khusus iOS, dan pemeriksaan ketat toko aplikasi. Hanya lakukan jika fitur utama aplikasi benar-benar membutuhkannya.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 9', judul: 'Fitur Perangkat di Balik Kontrak', ikon: 'lapisan', catatan: 'Di mata arsitektur, GPS dan kamera hanyalah SUMBER DATA baru, sama seperti server dan SQLite.' });

    d.kartu({
      judul: 'Masalahnya: Kode yang Hanya Bisa Diuji di HP',
      pengantar: 'Contoh 02, 03, dan 06 memanggil ImagePicker dan Geolocator langsung dari widget. Untuk aplikasi sungguhan:',
      kolom: 3,
      item: [
        { ikon: 'hp', judul: 'Tidak bisa diuji tanpa perangkat', isi: 'Pesan "izin diblokir" baru terlihat setelah menolak izin dua kali di HP sungguhan.', warna: C.accent5 },
        { ikon: 'tanya', judul: 'Sulit mencoba semua keadaan', isi: 'Bagaimana mencoba "GPS kurang akurat" atau "lokasi palsu" di laboratorium?', warna: C.accent5 },
        { ikon: 'tautan', judul: 'Tampilan ikut mengenal paket', isi: 'Widget harus tahu LocationServiceDisabledException, PlatformException, dan kode galatnya.', warna: C.accent5 },
        { ikon: 'buku', judul: 'Kontrak di domain', isi: 'LayananLokasi, PemilihFoto, PengaturanPerangkat: tanpa Position atau XFile.', warna: C.accent4 },
        { ikon: 'perkakas', judul: 'Implementasi asli di data', isi: 'Satu-satunya yang mengenal geolocator dan image_picker; penerjemah exception.', warna: C.accent4 },
        { ikon: 'uji', judul: 'Data palsu berskenario', isi: 'Semua keadaan bisa dicoba dan diperiksa otomatis, tanpa HP.', warna: C.accent4 },
      ],
      catatan: 'Baris atas: masalah. Baris bawah: jalan keluarnya, persis seperti kode kusut di Pertemuan 12.',
    });

    d.kode({
      judul: 'Kontrak di Domain',
      berkas: 'kode/contoh_07_kontrak_perangkat_dan_data_palsu.dart',
      kode: [
        'abstract interface class LayananLokasi {',
        '  /// Memeriksa layanan dan izin, lalu mengambil posisi sekarang.',
        '  Future<Hasil<Posisi>> posisiSekarang();',
        '}',
        '',
        'abstract interface class PemilihFoto {',
        '  bool get kameraTersedia;',
        '',
        '  Future<Hasil<FotoBukti>> ambil({required bool dariKamera});',
        '}',
        '',
        'abstract interface class PengaturanPerangkat {',
        '  Future<void> bukaPengaturanAplikasi();',
        '',
        '  Future<void> bukaPengaturanLokasi();',
        '}',
      ].join('\n'),
      ukuran: 13,
      lebarKode: 7.6,
      poin: [
        'Tidak ada Position, XFile, atau LocationPermission di domain.',
        'Domain memakai entitasnya sendiri: Posisi (lintang, bujur, akurasiMeter, waktu, palsu) dan FotoBukti.',
        'interface: hanya boleh diimplementasikan (implements), bukan diwarisi (extends).',
      ],
      catatan: 'Kelas Posisi lengkap ada di modul Bagian 9.2: constructor const dengan lima field final; palsu bernilai true jika berasal dari aplikasi pemalsu GPS. Di studi kasus (Contoh 08), PengaturanPerangkat juga punya getter bisaDibuka (false di browser).',
    });

    d.tabel({
      judul: 'Kegagalan Baru untuk Dunia Perangkat',
      kepala: ['Kegagalan', 'Artinya', 'Berasal dari (implementasi asli)'],
      lebarKolom: [3.6, 3.6, 4.4],
      baris: [
        [kode('LayananLokasiMati()'), 'Sakelar Lokasi mati', 'isLocationServiceEnabled() false, LocationServiceDisabledException'],
        [kode('IzinDitolak(fitur)'), 'Belum diberikan, masih boleh diminta', 'denied, PermissionDeniedException'],
        [kode('IzinDiblokir(fitur)'), 'Hanya bisa lewat Pengaturan', 'deniedForever, camera_access_denied'],
        [kode('PerangkatTidakMendukung(fitur)'), 'Perangkat tak punya fiturnya', 'no_available_camera'],
        [kode('Dibatalkan()'), 'Pengguna sengaja membatalkan', 'pickImage mengembalikan null'],
        [kode('WaktuHabis()'), 'Posisi tak didapat dalam batas waktu', 'TimeoutException'],
      ],
      ukuran: 14,
      tinggiBaris: 0.6,
      pesan: 'fitur = Fitur.lokasi, Fitur.kamera, atau Fitur.galeri. Studi kasus menambah GangguanPerangkat(kode).',
      catatan: 'Kegagalan dari Pertemuan 12 adalah sealed class, jadi setiap switch atasnya dipaksa lengkap oleh analyzer. Mengapa camera_access_denied menjadi IzinDiblokir, bukan IzinDitolak? Karena image_picker sendiri yang menampilkan dialog izin saat kamera dibuka; jika kode ini sampai kepada kita, pengguna sudah menolak, dan jalan yang tersisa adalah Pengaturan.',
    });

    d.kode({
      judul: 'Implementasi Asli Lokasi: Penerjemah',
      berkas: 'kode/contoh_08_studi_kasus_presensi.dart',
      kode: [
        'class LayananLokasiGeolocator implements LayananLokasi {',
        '  @override',
        '  Future<Hasil<Posisi>> posisiSekarang() async {',
        '    if (!await Geolocator.isLocationServiceEnabled()) {',
        '      return const Gagal(LayananLokasiMati());',
        '    }',
        '    // ... izin seperti Contoh 03 -> IzinDitolak atau IzinDiblokir ...',
        '    try {',
        '      final Position p = await Geolocator.getCurrentPosition(/* ... */);',
        '      return Berhasil(Posisi(/* ..., palsu: p.isMocked */));',
        '    } on TimeoutException {',
        '      return const Gagal(WaktuHabis());',
        '    } on LocationServiceDisabledException {',
        '      return const Gagal(LayananLokasiMati());',
        '    } on PermissionDeniedException {',
        '      return const Gagal(IzinDitolak(Fitur.lokasi));',
        '    } on PositionUpdateException {',
        "      return const Gagal(GangguanPerangkat('position_update'));",
        '    }',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.4,
      poin: [
        'SATU-SATUNYA bagian yang mengenal paket geolocator.',
        'Setiap exception diterjemahkan menjadi Kegagalan, tanpa catch-all.',
        'Position diubah menjadi Posisi milik domain; palsu diambil dari p.isMocked.',
      ],
      catatan: 'Potongan dari Contoh 08 (modul Bagian 9.4). Bagian yang dilewati: constructor const, pemeriksaan izin (checkPermission, requestPermission, switch seperti Contoh 03), LocationSettings (akurasi high, batas waktu 20 detik), dan isi Posisi (lintang, bujur, akurasiMeter, waktu: p.timestamp.toLocal(), palsu: p.isMocked).',
    });

    d.kode({
      judul: 'Implementasi Asli Kamera',
      berkas: 'kode/contoh_08_studi_kasus_presensi.dart',
      kode: [
        'Future<Hasil<FotoBukti>> ambil({required bool dariKamera}) async {',
        '  try {',
        '    final XFile? berkas = await _pemilih.pickImage(',
        '      source: dariKamera ? ImageSource.camera : ImageSource.gallery,',
        '      preferredCameraDevice: CameraDevice.front,',
        '      maxWidth: 720,',
        '      imageQuality: 70,',
        '      requestFullMetadata: false,',
        '    );',
        '    if (berkas == null) return const Gagal(Dibatalkan());',
        '    return Berhasil(',
        '      FotoBukti(nama: berkas.name, bita: await berkas.readAsBytes()),',
        '    );',
        '  } on PlatformException catch (e) {',
        '    return Gagal(switch (e.code) {',
        "      'camera_access_denied' => const IzinDiblokir(Fitur.kamera),",
        "      'photo_access_denied' => const IzinDiblokir(Fitur.galeri),",
        "      'no_available_camera' => const PerangkatTidakMendukung(Fitur.kamera),",
        '      _ => GangguanPerangkat(e.code),',
        '    });',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 10.5,
      lebarKode: 7.6,
      poin: [
        'Batal (null) → Dibatalkan.',
        'camera_access_denied → IzinDiblokir: image_picker sudah menampilkan dialognya sendiri.',
        'Kode galat lain → GangguanPerangkat(kode).',
      ],
      catatan: 'Potongan method ambil() dari kelas PemilihFotoImagePicker di Contoh 08 (anotasi @override di atasnya tidak ditampilkan). Kelasnya menerima ImagePicker lewat constructor (pemilih ?? ImagePicker()), dan kameraTersedia memakai supportsImageSource(ImageSource.camera).',
    });

    d.kode({
      judul: 'Data Palsu Berskenario',
      berkas: 'kode/contoh_07_kontrak_perangkat_dan_data_palsu.dart',
      kode: [
        'class LayananLokasiPalsu implements LayananLokasi {',
        '  SkenarioLokasi skenario = SkenarioLokasi.berhasil;',
        '  int dipanggil = 0; // mata-mata (spy)',
        '',
        '  @override',
        '  Future<Hasil<Posisi>> posisiSekarang() async {',
        '    dipanggil++;',
        '    await Future<void>.delayed(const Duration(milliseconds: 300));',
        '    return switch (skenario) {',
        '      SkenarioLokasi.berhasil => Berhasil(Posisi(/* ... ± 8 m */)),',
        '      SkenarioLokasi.layananMati => const Gagal(LayananLokasiMati()),',
        '      SkenarioLokasi.izinDitolak => const Gagal(IzinDitolak(Fitur.lokasi)),',
        '      SkenarioLokasi.izinDiblokir => const Gagal(IzinDiblokir(Fitur.lokasi)),',
        '      SkenarioLokasi.waktuHabis => const Gagal(WaktuHabis()),',
        '    };',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.6,
      poin: [
        'Tidak menyentuh perangkat sama sekali.',
        'Skenario dipilih lewat chip di layar atau di pemeriksaan.',
        'dipanggil: memastikan dua ketukan cepat hanya memanggil layanan SEKALI.',
      ],
      catatan: 'Isi Posisi pada skenario berhasil dipersingkat di slide: lintang -0.470180, bujur 117.158050, akurasi 8 m, waktu 16 Oktober 2026 pukul 09.30. enum SkenarioLokasi menyimpan label untuk chip: berhasil(\'Berhasil\'), layananMati(\'Layanan mati\'), dan seterusnya. Mata-mata (spy) sudah dikenal di Pertemuan 12.',
    });

    d.kode({
      judul: 'Satu Tempat untuk Pesan dan Tombol',
      berkas: 'kode/contoh_07_kontrak_perangkat_dan_data_palsu.dart',
      kode: [
        '/// SATU-SATUNYA tempat yang mengubah Kegagalan menjadi kalimat.',
        '/// null berarti tidak perlu pesan apa pun.',
        'Tanggapan? tanggapanUntuk(Kegagalan kegagalan) {',
        '  return switch (kegagalan) {',
        '    Dibatalkan() => null,',
        '    LayananLokasiMati() => const Tanggapan(',
        "      'Layanan lokasi mati. Nyalakan, lalu coba lagi.',",
        '      AksiPerbaikan.nyalakanLokasi,',
        '    ),',
        '    IzinDiblokir(:final Fitur fitur) => Tanggapan(',
        "      'Izin ${fitur.nama} diblokir. Jika ingin memakai fitur ini, '",
        "      'izinkan di Pengaturan.',",
        '      AksiPerbaikan.bukaPengaturan,',
        '    ),',
        '    // ... IzinDitolak, PerangkatTidakMendukung, WaktuHabis ...',
        '  };',
        '}',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 7.4,
      poin: [
        'Pesan DAN tombol perbaikan ditentukan di satu fungsi.',
        'Dibatalkan → tanpa pesan.',
        'Kegagalan baru tanpa cabang = galat analyzer (switch wajib lengkap).',
      ],
      catatan: 'Potongan; tiga cabang lainnya ada di modul Bagian 9.6: IzinDitolak → \'Izin ... belum diberikan, jadi fitur ini belum bisa dipakai.\' + cobaLagi; PerangkatTidakMendukung → \'Perangkat ini tidak memiliki ....\' + tidakAda; WaktuHabis → \'Lokasi belum didapat. Coba di dekat jendela atau di luar ruangan.\' + cobaLagi. Soal C3 Latihan: IzinDiblokir yang dipetakan ke cobaLagi membuat pengguna terjebak.',
    });

    d.tabel({
      judul: 'Kegagalan dan Tombolnya',
      kepala: ['Kegagalan', 'Tombol yang ditawarkan', 'ViewModel memanggil'],
      lebarKolom: [3.6, 4.0, 4.0],
      baris: [
        [kode('Dibatalkan'), 'Tidak ada pesan (pengguna sendiri yang membatalkan)', '—'],
        [kode('LayananLokasiMati'), 'Nyalakan lokasi', kode('bukaPengaturanLokasi()')],
        [kode('IzinDitolak'), 'Coba lagi (dialog izin muncul lagi)', kode('cobaLagi()')],
        [kode('IzinDiblokir'), 'Buka Pengaturan', kode('bukaPengaturanAplikasi()')],
        [kode('PerangkatTidakMendukung'), 'Tidak ada tombol', '—'],
        [kode('WaktuHabis'), 'Coba lagi', kode('cobaLagi()')],
      ],
      ukuran: 15,
      tinggiBaris: 0.6,
      pesan: 'perbaiki(aksi, cobaLagi) di ViewModel: switch atas AksiPerbaikan, lalu meneruskan ke kontrak PengaturanPerangkat.',
      catatan: 'ViewModel memakai Perintah dari Pertemuan 12. Karena PengaturanPerangkat adalah kontrak, versi palsunya cukup mencatat bahwa Pengaturan "dibuka", sehingga pemeriksaan "Buka Pengaturan -> pengaturan aplikasi" bisa berjalan tanpa HP.',
    });

    d.layar({
      judul: 'Contoh 07: Catatan Lapangan',
      gambar: ['hasil_contoh_07a.jpg', 'hasil_contoh_07b.jpg'],
      lebarMaks: 6.9,
      berkas: 'kode/contoh_07_kontrak_perangkat_dan_data_palsu.dart',
      poin: [
        'Sebelum runApp: 15 dari 15 pemeriksaan LULUS, tanpa HP, dialog izin, maupun GPS.',
        'Setiap kegagalan mendapat tombolnya sendiri.',
        'Foto dan lokasi yang sudah ada TIDAK hilang karena percobaan berikutnya gagal.',
      ],
      ukuranPoin: 15,
      catatan: 'Contoh pemeriksaan: "Izin diblokir -> tombol bukaPengaturan", "Foto dibatalkan -> tanpa pesan", "Tanpa kamera -> kameraTersedia false", "Dua ketukan cepat -> layanan dipanggil sekali". Di Contoh 07, MultiProvider menitipkan kelas PALSU karena chip skenario perlu mengubah skenarionya. Di aplikasi sungguhan, yang dititipkan selalu KONTRAKNYA.',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 10', judul: 'Studi Kasus: Presensi Praktikum', ikon: 'tugas', catatan: 'Contoh 08 menggabungkan semua materi hari ini dengan arsitektur Pertemuan 12. Setiap bagian diberi judul BERKAS: ... yang menunjukkan letaknya jika dipecah menjadi banyak berkas.' });

    d.tabel({
      judul: 'Fitur dan Aturan',
      pengantar: 'Presensi praktikum dengan foto selfie dan lokasi. Diterima jika:',
      kepala: ['No', 'Aturan', 'Pesan jika dilanggar'],
      lebarKolom: [0.6, 5.8, 5.2],
      baris: [
        ['1', 'Sesi dibuka: 15 menit sebelum mulai sampai 30 menit sesudahnya', '"Presensi baru dibuka pukul ..." / "... sudah ditutup ..."'],
        ['2', 'Belum presensi di sesi yang sama', '"Anda sudah presensi untuk sesi ini."'],
        ['3', 'Ada foto selfie dari KAMERA (bukan galeri)', '"Ambil foto selfie terlebih dahulu."'],
        ['4', 'Lokasi bukan dari pemalsu GPS', '"Lokasi palsu terdeteksi. ..."'],
        ['5', 'Akurasi paling buruk 50 m', '"Lokasi kurang akurat (± ... m). ..."'],
        ['6', 'Paling jauh 100 m dari laboratorium', '"Anda berada ... m dari .... Presensi hanya bisa dalam radius 100 m."'],
      ],
      ukuran: 14,
      tinggiBaris: 0.62,
      catatan: 'Aturan 1–3 tidak membutuhkan lokasi; aturan 4–6 membutuhkan lokasi saat ini. Urutan ini penting di use case.',
    });

    d.lapisan({
      judul: 'Peta Arsitektur',
      lapisan: [
        { ikon: 'perkakas', judul: 'Kerangka dan perangkat', isi: 'Flutter, geolocator, image_picker, GPS, kamera', warna: C.text2 },
        { ikon: 'tautan', judul: 'Penghubung', isi: 'View, ViewModel, tanggapanUntuk(); implementasi asli dan palsu; RepositoriPresensiMemori', warna: C.accent6 },
        { ikon: 'tugas', judul: 'Use case', isi: 'CatatPresensi', warna: C.accent4 },
        { ikon: 'buku', judul: 'Entitas, aturan, dan kontrak', isi: 'SesiPraktikum, Posisi, statusSesi(), periksaLokasi(); kontrak LayananLokasi, PemilihFoto, RepositoriPresensi', warna: C.accent1 },
      ],
      keterangan: [
        'Sama seperti Pertemuan 12: panah ketergantungan hanya menunjuk ke dalam.',
        'GPS dan kamera hanyalah sumber data baru, di lingkaran paling luar.',
        'Implementasi asli DAN palsu sama-sama "implements" kontrak di dalam.',
        'Nama paket perangkat tidak pernah muncul di use case dan aturan.',
      ],
      catatan: 'Gambar ini dibaca dari luar ke dalam, seperti di Pertemuan 12; panah menunjuk arah ketergantungan yang diizinkan. Diagram lengkap (mermaid) ada di modul Bagian 10.2: HalamanPresensi dan PresensiViewModel (Perintah ambilFoto, kirim) di lapisan UI; CatatPresensi, aturan, dan kontrak di domain; LayananLokasiGeolocator, PemilihFotoImagePicker, versi palsu, dan RepositoriPresensiMemori di lapisan data.',
    });

    d.kode({
      judul: 'Use Case: Urutannya Penting',
      berkas: 'kode/contoh_08_studi_kasus_presensi.dart',
      kode: [
        'Future<Hasil<Presensi>> jalankan({',
        '  required SesiPraktikum sesi,',
        '  required FotoBukti? foto,',
        '}) async {',
        '  // 1. Pemeriksaan tanpa lokasi: sesi dibuka? sudah presensi? foto ada?',
        '  // ... riwayat dibaca dari _repositori; jika Gagal, dikembalikan ...',
        '  final String? alasanAwal = periksaSebelumLokasi(',
        '    sesi: sesi,',
        '    foto: foto,',
        '    sekarang: _jam.sekarang(),',
        '    sudahPresensi: riwayat.any((Presensi p) => p.kodeSesi == sesi.kode),',
        '  );',
        '  if (alasanAwal != null) return Gagal(AturanDilanggar(alasanAwal));',
        '  // 2. Lokasi diambil SAAT INI JUGA, bukan lokasi yang tersimpan.',
        '  final Hasil<Posisi> hasilPosisi = await _lokasi.posisiSekarang();',
        '  // ... jika Gagal, kembalikan kegagalannya ...',
        '  final String? alasanLokasi = periksaLokasi(sesi: sesi, posisi: posisi);',
        '  if (alasanLokasi != null) return Gagal(AturanDilanggar(alasanLokasi));',
        '  // 3. Semua aturan terpenuhi: simpan.',
        '  return _repositori.simpan(/* ..., jarakMeter, akurasiMeter, ... */);',
        '}',
      ].join('\n'),
      ukuran: 11,
      lebarKode: 7.6,
      poin: [
        'Yang tidak butuh lokasi diperiksa DULU.',
        'Sesi ditutup → lokasi tidak diminta: tanpa dialog percuma, tanpa baterai terbuang.',
        'Pengujian memeriksa lokasi.dipanggil tidak bertambah.',
        'Disimpan: jarak dan akurasi, bukan koordinat.',
      ],
      catatan: 'Potongan dari modul Bagian 10.3 (baris kosong dihapus agar muat). CatatPresensi layak menjadi use case karena menggabungkan repository, layanan lokasi, jam, dan aturan bisnis dalam urutan tertentu (kriteria Pertemuan 12 Bagian 7.1). Yang disimpan: kodeSesi, nim, waktu, jarakMeter (dari posisi ke titik sesi), akurasiMeter, dan nama foto. Uji mandiri: mengapa "sudah presensi" dan "foto ada" diperiksa sebelum lokasi? Agar GPS, waktu tunggu sampai 20 detik, dan dialog izin tidak dipakai percuma.',
    });

    d.tabel({
      judul: 'Dua Lingkungan dan Jam Palsu',
      kepala: ['Kebutuhan', 'Pengembangan', 'Produksi'],
      lebarKolom: [2.2, 5.0, 4.4],
      baris: [
        ['Lokasi', 'LayananLokasiPalsu (menu skenario)', 'LayananLokasiGeolocator'],
        ['Kamera', 'PemilihFotoPalsu', 'PemilihFotoImagePicker'],
        ['Pengaturan', 'PengaturanPerangkatPalsu (hanya mencatat)', 'PengaturanPerangkatGeolocator'],
        ['Jam', 'Jam(jamPengembangan): selalu pukul 13.10', 'Jam(): jam sungguhan'],
      ],
      ukuran: 15,
      tinggiBaris: 0.75,
      pesan: 'const Lingkungan lingkungan = Lingkungan.produksi;  ← satu-satunya baris yang diubah',
      catatan: 'Jam palsu penting: tanpa itu, sesi praktikum hanya bisa dicoba pada jam tertentu. Dengan jam tetap 13.10, sesi Basis Data (13.00–15.30) selalu dibuka kapan pun Anda belajar. Selama lingkungan pengembangan, setiap halaman diberi pita DATA PALSU.',
    });

    d.layar({
      judul: 'Contoh 08: Jadwal, Presensi, dan Skenario',
      gambar: ['hasil_contoh_08a.jpg', 'hasil_contoh_08b.jpg', 'hasil_contoh_08c.jpg'],
      lebarMaks: 8.1,
      berkas: 'kode/contoh_08_studi_kasus_presensi.dart',
      poin: [
        'Jadwal: ditutup, dibuka sampai 13.30, dibuka 15.30.',
        'Foto selfie, lalu Kirim (lokasi diambil saat itu).',
        'Menu skenario lokasi palsu.',
      ],
      ukuranPoin: 15,
      catatan: 'Ubah barisnya menjadi Lingkungan.pengembangan, lalu jalankan; aplikasi berjalan di Chrome tanpa mengubah apa pun selain baris tersebut. Menu skenario: Di laboratorium, Di luar area, Akurasi buruk, Pemalsu GPS, Izin diblokir, Layanan lokasi mati.',
    });

    d.layar({
      judul: 'Contoh 08: Ditolak, Diblokir, Tercatat',
      gambar: ['hasil_contoh_08d.jpg', 'hasil_contoh_08e.jpg', 'hasil_contoh_08f.jpg'],
      lebarMaks: 8.1,
      berkas: 'kode/contoh_08_studi_kasus_presensi.dart',
      poin: [
        'Di luar area: 234 m dari Lab Basis Data.',
        'Izin diblokir: tombol Buka Pengaturan.',
        'Berhasil: "Presensi tercatat pukul 13.10 (8 m dari ...)".',
      ],
      ukuranPoin: 15,
      catatan: 'Di browser, PengaturanPerangkat melaporkan bisaDibuka false, sehingga tombol Pengaturan diganti petunjuk ikon situs. Tab Riwayat (gambar hasil_contoh_08g di modul) menampilkan "Pukul 13.10, 8 m dari Lab Basis Data, ± 9 m" dengan nomor PR-001.',
    });

    d.kode({
      judul: 'Kembali dari Pengaturan: Pesan Lama Dibersihkan',
      berkas: 'kode/contoh_08_studi_kasus_presensi.dart',
      kode: [
        '/// Kembali dari Pengaturan: hapus pesan lama tentang izin atau layanan,',
        '/// agar pengguna bisa langsung menekan Kirim lagi.',
        'void _saatKembali() {',
        '  final Hasil<Presensi>? hasil = _vm.kirim.hasil;',
        '  if (hasil case Gagal(kegagalan: IzinDiblokir() || LayananLokasiMati())) {',
        '    _vm.kirim.bersihkanHasil();',
        '  }',
        '}',
      ].join('\n'),
      ukuran: 11.5,
      lebarKode: 7.8,
      poin: [
        'Pola dibaca: hasilnya Gagal DAN kegagalannya IzinDiblokir ATAU LayananLokasiMati.',
        'Pesan "izin diblokir" yang masih tampil bisa membingungkan: mungkin izinnya sudah diberikan.',
        'Pengguna tinggal mengetuk Kirim lagi.',
      ],
      catatan: 'Dipanggil oleh AppLifecycleListener(onResume: ...), seperti Contoh 03. Di browser, kontrak PengaturanPerangkat melaporkan bisaDibuka bernilai false, sehingga tombol Pengaturan diganti petunjuk "Klik ikon di sebelah kiri alamat situs".',
    });

    d.kode({
      judul: 'Contoh 08: 18 Pemeriksaan Otomatis',
      berkas: 'kode/contoh_08_studi_kasus_presensi.dart',
      shell: true,
      kode: [
        '=== Pemeriksaan Presensi Praktikum ===',
        'LULUS  Jarak dua titik contoh = 25 m',
        'LULUS  12.44 belum dibuka',
        'LULUS  12.45 dibuka',
        'LULUS  13.30 masih dibuka',
        'LULUS  13.31 ditutup',
        'LULUS  Tanpa foto ditolak',
        'LULUS  Di dalam radius (8 m) diterima',
        'LULUS  Akurasi 120 m ditolak',
        'LULUS  234 m dari lab ditolak',
        'LULUS  Di lab pukul 13.10 -> tercatat',
        'LULUS  Presensi kedua -> ditolak',
        'LULUS  Presensi kedua -> lokasi TIDAK diminta',
        'LULUS  Pukul 14.00 -> ditutup, lokasi tidak diminta',
        'LULUS  Izin lokasi diblokir -> gagal, tidak tersimpan',
        'LULUS  Izin diblokir -> tombol Buka Pengaturan',
        'LULUS  Kirim tanpa foto -> diminta foto',
        'LULUS  Foto dibatalkan -> foto tetap kosong',
        'LULUS  Dua ketukan cepat -> satu presensi',
        'Ringkasan: 18 dari 18 uji lulus',
      ].join('\n'),
      ukuran: 11.5,
      lebarKode: 6.4,
      poin: [
        'Domain, use case, dan ViewModel diperiksa dengan data palsu serta jam tetap.',
        'Batas waktu diuji: 12.44 belum dibuka, 12.45 dibuka, 13.30 masih dibuka, 13.31 ditutup.',
        'Presensi kedua dan pukul 14.00: lokasi TIDAK diminta.',
        'Pertemuan 14: pemeriksaan ini pindah ke folder test/ dan dijalankan dengan flutter test.',
      ],
      catatan: 'Versi produksi: siapkan proyek seperti Bagian 3 (flutter pub add geolocator image_picker provider, izin di AndroidManifest.xml, kalimat alasan di Info.plist), lalu ubah jam dan koordinat sesi di RepositoriPresensiMemori agar sesuai, atau di Chrome palsukan lokasinya ke koordinat laboratorium lewat DevTools → Sensors dengan Accuracy kecil (misalnya 10).',
    });

    // ------------------------------------------------------------------
    d.bagian({ label: 'BAGIAN 11–15', judul: 'Menguji, Privasi, Paket Lain, dan Proyek Akhir', ikon: 'privasi', catatan: 'Menguji fitur lokasi tidak harus berjalan keliling kampus. Dan karena lokasi serta foto wajah adalah data paling pribadi, privasi bukan tambahan, melainkan bagian dari rancangan.' });

    d.alur({
      judul: 'Chrome DevTools: Sensors',
      langkah: [
        { ikon: 'perkakas', judul: 'Buka DevTools', isi: 'F12, lalu Ctrl+Shift+P → ketik sensors → Show Sensors' },
        { ikon: 'lokasi', judul: 'Atur lokasi', isi: 'Pilih kota, atau Other… → Latitude dan Longitude' },
        { ikon: 'ukur', judul: 'Isi Accuracy', isi: 'Misalnya 10. Kosong = 150 m → ditolak aturan akurasi' },
        { ikon: 'ulang', judul: 'Ketuk lagi', isi: 'Posisi baru langsung dipakai. Location unavailable = posisi gagal', warna: C.accent4 },
        { ikon: 'gembok', judul: 'Blokir atau reset', isi: 'Ikon di kiri alamat situs → Lokasi: Blokir, atau Reset izin', warna: C.accent6 },
      ],
      catatan: 'Mac: Cmd+Option+I lalu Cmd+Shift+P. Di sebagian versi Chrome, pilihan Other… tertulis Custom location. Emulator Android: Extended controls (⋯) → Location → Single points → Set location; tab Routes memutar rute. Lokasi bawaan emulator biasanya di Amerika Serikat, jadi jarak ke kampus bisa belasan ribu kilometer sebelum diatur.',
    });

    d.tabel({
      judul: 'Menguji Setiap Keadaan',
      kepala: ['Keadaan yang ingin dicoba', 'Cara paling mudah'],
      lebarKolom: [5.2, 6.4],
      baris: [
        ['Lokasi berhasil, di dalam atau di luar area', 'Data palsu, atau DevTools → Sensors'],
        ['Akurasi buruk', 'Data palsu, atau Sensors dengan Accuracy besar'],
        ['Pemalsu GPS', 'Data palsu (di browser isMocked selalu false)'],
        ['Izin ditolak lalu diblokir', 'Emulator/HP Android, atau simulasi Contoh 05'],
        ['Layanan lokasi mati', 'Emulator atau HP: matikan sakelar Lokasi'],
        ['Batas waktu habis', 'Data palsu, atau HP di ruangan tertutup'],
        ['Kamera tidak tersedia', 'Data palsu, atau aplikasi desktop'],
      ],
      ukuran: 15,
      tinggiBaris: 0.52,
      pesan: 'Mencabut izin: Android → Pengaturan → Aplikasi → Izin; Chrome → ikon alamat → Reset izin.',
      catatan: 'Cara tercepat tetap data palsu (Bagian 9): semua keadaan bisa dicoba dalam hitungan detik, berulang-ulang, tanpa mengubah pengaturan. HP Android dengan kabel USB memberi pengalaman paling lengkap; uji juga di dalam dan di luar gedung untuk melihat perbedaan akurasinya.',
    });

    d.tabel({
      judul: 'Lima Prinsip Privasi',
      kepala: ['Prinsip', 'Contoh penerapan di studi kasus'],
      lebarKolom: [3.6, 8.0],
      baris: [
        ['Ambil hanya yang dibutuhkan', 'Lokasi "saat dipakai", bukan "selalu"; tanpa metadata foto (requestFullMetadata: false)'],
        ['Ambil saat dibutuhkan', 'Lokasi diambil saat tombol Kirim ditekan, bukan terus-menerus'],
        ['Jelaskan pemakaiannya', '"Lokasi Anda diambil saat tombol Kirim ditekan, hanya untuk memeriksa jarak ke ..."'],
        ['Simpan seperlunya', 'Yang disimpan hanya jarak dan akurasi, bukan koordinat persis'],
        ['Lindungi yang disimpan', 'Kirim lewat HTTPS; hapus foto setelah tidak diperlukan'],
      ],
      ukuran: 15,
      tinggiBaris: 0.72,
      catatan: 'Uji mandiri modul: riwayat presensi menyimpan jarakMeter dan akurasiMeter, tetapi tidak menyimpan lintang dan bujurnya. Keuntungannya: lebih menjaga privasi (minimisasi data).',
    });

    d.kartu({
      judul: 'UU PDP dan Aturan Toko Aplikasi',
      kolom: 3,
      item: [
        { ikon: 'buku', judul: 'UU No. 27 Tahun 2022', isi: 'Data pribadi umum dan spesifik (misalnya biometrik). Lokasi + nama + NIM, atau foto wajah, perlu sangat hati-hati.' },
        { ikon: 'gembok', judul: 'Dasar yang sah dan tujuan', isi: 'Persetujuan yang jelas, tujuan disampaikan, data dijaga keamanannya dan tidak disimpan lebih lama dari perlu.', warna: C.accent6 },
        { ikon: 'kotak', judul: 'Google Play', isi: 'Pemilih foto sistem (bukan izin seluruh galeri); formulir Keamanan Data; lokasi latar belakang diperiksa ketat.', warna: C.accent4 },
        { ikon: 'lokasi', judul: 'Tombol lokasi sistem', isi: 'Aplikasi target Android 17 (API 37) yang hanya butuh lokasi sesaat wajib memakainya, mulai 27 Januari 2027.', warna: C.accent3 },
        { ikon: 'hp', judul: 'App Store', isi: 'Setiap izin wajib punya kalimat alasan yang jelas; halaman aplikasi mencantumkan ringkasan privasi.', warna: C.accent6 },
        { ikon: 'peringatan', judul: 'Bukan nasihat hukum', isi: 'Untuk aplikasi resmi, libatkan pihak kampus yang berwenang. Aturan toko berubah: periksa kebijakan terbaru.', warna: C.accent5 },
      ],
      catatan: 'Bagian ini hanyalah pengantar. Kebijakan tombol lokasi Google Play diumumkan Google; periksa halaman kebijakan resmi yang terbaru saat menyiapkan rilis di Pertemuan 15.',
    });

    d.tabel({
      judul: 'Paket Lain dan Kapan Memakainya',
      kepala: ['Kebutuhan', 'Paket', 'Keterangan'],
      lebarKolom: [4.0, 2.9, 4.7],
      baris: [
        ['Tampilan kamera buatan sendiri', kode('camera'), 'Butuh izin CAMERA; pakai hanya jika kamera bawaan tak cukup'],
        ['Memindai kode QR atau barcode', kode('mobile_scanner'), 'Misalnya presensi dengan kode QR di kelas'],
        ['Izin fitur lain (mikrofon, kontak, notifikasi)', kode('permission_handler'), 'Termasuk openAppSettings()'],
        ['Membuka aplikasi peta atau navigasi', kode('url_launcher'), 'Maps URLs, tanpa kunci API (slide berikut)'],
        ['Menampilkan peta di dalam aplikasi', kode('flutter_map'), 'Atau google_maps_flutter (butuh kunci API)'],
        ['Koordinat ⇄ alamat', kode('geocoding'), 'Bergantung layanan sistem dan internet'],
      ],
      ukuran: 14,
      tinggiBaris: 0.66,
      catatan: 'image_picker dan geolocator sudah cukup untuk sebagian besar kebutuhan, termasuk proyek akhir.',
    });

    d.kode({
      judul: 'Membuka Google Maps Tanpa Kunci API',
      kode: [
        "import 'package:url_launcher/url_launcher.dart';",
        '',
        '/// Petunjuk arah jalan kaki ke titik tertentu.',
        'Future<bool> petunjukArah(double lintang, double bujur) {',
        "  final Uri alamat = Uri.https('www.google.com', '/maps/dir/', {",
        "    'api': '1',",
        "    'destination': '$lintang,$bujur',",
        "    'travelmode': 'walking',",
        '  });',
        '  return launchUrl(alamat, mode: LaunchMode.externalApplication);',
        '}',
        '',
        '// Hasil: https://www.google.com/maps/dir/?api=1',
        '//   &destination=-0.4697%2C117.1611&travelmode=walking',
      ].join('\n'),
      ukuran: 12,
      lebarKode: 8.0,
      poin: [
        'Uri.https menyusun alamat dan mengubah koma menjadi %2C.',
        'launchUrl → false jika tidak ada aplikasi yang bisa membuka.',
        'Siapkan pesan (SnackBar) untuk keadaan itu.',
        'Dipakai di tugas mandiri "Parkir Motorku".',
      ],
      catatan: 'Untuk menampilkan satu titik di peta, pakai /maps/search/ dengan parameter query=LINTANG,BUJUR (fungsi bukaDiPeta di modul Bagian 13). launchUrl dipanggil langsung lalu nilai kembaliannya diperiksa; canLaunchUrl di Android 11+ membutuhkan deklarasi <queries>.',
    });

    d.tabel({
      judul: 'Kesalahan Umum Pemula',
      kepala: ['Gejala', 'Solusi'],
      lebarKolom: [6.3, 5.3],
      baris: [
        [kode('MissingPluginException(...)'), 'Hentikan aplikasi, lalu flutter run ulang'],
        [kode('PermissionDefinitionsNotFoundException'), 'Tulis izin di AndroidManifest.xml / Info.plist'],
        ['Tombol lokasi diketuk, tidak terjadi apa-apa', 'Tangani deniedForever: pesan + Pengaturan'],
        ['Kamera tak mau terbuka di Android, galeri bisa', 'Hapus izin CAMERA jika hanya image_picker'],
        ['Unsupported operation saat menampilkan foto di web', 'readAsBytes() lalu Image.memory'],
        ['Tombol lokasi berputar terus', 'Beri timeLimit + pesan "coba di dekat jendela"'],
        ['Baterai cepat habis', 'cancel() langganan di Berhenti dan dispose()'],
        [kode('setState() called after dispose()'), 'if (!mounted) return; setelah await'],
        ['Di Chrome selalu "kurang akurat (± 150 m)"', 'Isi Accuracy di DevTools → Sensors'],
      ],
      ukuran: 13,
      tinggiBaris: 0.52,
      catatan: 'Tabel lengkap di modul Bagian 14, termasuk aplikasi iOS yang tertutup sendiri saat kamera dibuka (kalimat alasan belum ditulis), dialog izin yang tidak muncul di browser (situs pernah diblokir, atau alamat tidak aman), jarak yang melompat-lompat (titik berakurasi buruk ikut dihitung), aplikasi lambat setelah memilih foto (maxWidth, imageQuality, cacheWidth), dan jarak belasan ribu kilometer di emulator.',
    });

    d.kartu({
      judul: 'Fitur Perangkat untuk Proyek Akhir',
      pengantar: 'Nilai tambah, bukan syarat wajib. Contoh: presensi kegiatan (lokasi + foto), katalog UMKM (foto produk, buka di peta), pencatat keuangan (foto struk).',
      kolom: 3,
      item: [
        { ikon: 'dialog', judul: 'Izin yang sopan', isi: 'Diminta saat fitur dipakai, dengan penjelasan; aplikasi tetap berfungsi saat ditolak.' },
        { ikon: 'galat', judul: 'Semua keadaan punya pesan', isi: 'Berhasil, dibatalkan, ditolak, diblokir, layanan mati, waktu habis.', warna: C.accent5 },
        { ikon: 'lapisan', judul: 'Kontrak + data palsu', isi: 'Fitur perangkat dibungkus kontrak; ada versi palsu untuk pengembangan dan pengujian.', warna: C.accent6 },
        { ikon: 'dokumen', judul: 'README proyek', isi: 'Sebutkan izin apa saja yang dipakai dan untuk apa.', warna: C.accent3 },
        { ikon: 'perangkat', judul: 'Dicoba di dua tempat', isi: 'Minimal di Chrome DAN di emulator atau HP Android.', warna: C.accent4 },
        { ikon: 'privasi', judul: 'Privasi', isi: 'Ambil seperlunya, saat dibutuhkan; jelaskan kepada pengguna (Refleksi 3).', warna: C.accent4 },
      ],
      catatan: 'Panduan Proyek Akhir menempatkan fitur perangkat sebagai nilai tambah. Lima kartu pertama adalah daftar periksa di modul Bagian 15; kartu Privasi mengingatkan Refleksi 3 di Jobsheet: fitur perangkat apa yang benar-benar dibutuhkan proyek, data pribadi apa yang ikut terkumpul, dan bagaimana menjelaskannya kepada pengguna.',
    });

    d.tabel({
      judul: 'Memilih Alat yang Tepat',
      kepala: ['Kebutuhan', 'Pakai'],
      lebarKolom: [5.0, 6.6],
      baris: [
        ['Satu foto dari galeri atau kamera', kode('ImagePicker().pickImage(source: ...)')],
        ['Beberapa foto sekaligus', kode('pickMultiImage(limit: ...)')],
        ['Satu posisi sekarang', kode('Geolocator.getCurrentPosition(...)')],
        ['Posisi terus-menerus', kode('getPositionStream(...) + cancel()')],
        ['Jarak dan arah dua titik', kode('distanceBetween / bearingBetween, atau haversine')],
        ['Membuka Pengaturan (bukan di web)', kode('openAppSettings() / openLocationSettings()')],
        ['Tahu kapan pengguna kembali', kode('AppLifecycleListener(onResume: ...)')],
        ['Membuka Google Maps', kode('url_launcher + Maps URLs')],
        ['Menguji tanpa HP', 'Kontrak + data palsu; DevTools → Sensors'],
      ],
      ukuran: 14,
      tinggiBaris: 0.52,
      catatan: 'Minta mahasiswa memetakan proyek akhirnya ke tabel ini: fitur perangkat apa yang benar-benar dibutuhkan, dan bagaimana mengujinya tanpa HP.',
    });

    d.ringkasan({
      poin: [
        'Plugin = kode Dart + kode asli platform: image_picker dan geolocator.',
        'Izin: aplikasi bertanya, sistem mencatat, pengguna memutuskan. Penolakan kedua = diblokir.',
        'Persiapan: AndroidManifest.xml, kalimat alasan Info.plist, HTTPS/localhost; jalankan ulang.',
        'pickImage → XFile, null (batal), atau PlatformException; Image.memory di semua platform.',
        'Lokasi: layanan → izin → posisi dengan batas waktu; selalu periksa akurasi.',
        'Zona: lokasi palsu → akurasi → jarak (haversine).',
        'Izin yang sopan: saat dipakai, jelaskan, tetap jalan, tawarkan Pengaturan, onResume.',
        'Stream lokasi wajib cancel(); fitur perangkat di balik kontrak + data palsu; privasi.',
      ],
      catatan: 'Minta mahasiswa menjelaskan dengan kata-kata sendiri: apa bedanya izin ditolak dan diblokir, dan mengapa layanan lokasi diperiksa sebelum izin.',
    });

    d.penutup({
      judul: 'Saatnya Praktik!',
      subjudul: 'Kerjakan Jobsheet Pertemuan 13 (lima praktikum "Lapor Fasilitas" + tugas Parkir Motorku), lalu uji diri di Latihan. Pertemuan berikutnya: pengujian dan debugging dengan flutter test.',
      tautan: [
        { teks: 'Jobsheet P13', ikon: 'tugas', url: d.urlBerkas('pertemuan_13_fitur_perangkat_dan_izin/JOBSHEET.md') },
        { teks: 'Latihan P13', ikon: 'kuis', url: d.urlBerkas('pertemuan_13_fitur_perangkat_dan_izin/LATIHAN.md') },
        { teks: 'Proyek Akhir', ikon: 'roket', url: d.urlBerkas('panduan/05_proyek_akhir.md') },
      ],
      catatan: 'Praktikum 1: aturan laporan fasilitas dalam Dart murni (jarak, arah, akurasi, lokasi palsu). Praktikum 2: foto bukti dengan image_picker. Praktikum 3: lokasi kerusakan dengan geolocator. Praktikum 4: kontrak perangkat, data palsu, dan pemeriksaan (DartPad). Praktikum 5: perangkat asli di balik kontrak, dua titik masuk. Tugas mandiri Parkir Motorku: menandai tempat parkir (lokasi, catatan, foto), mencarinya lagi (jarak, arah, Google Maps), disimpan sebagai JSON dengan SharedPreferencesAsync. Pertemuan 14: jalankanUji() dipindahkan ke folder test/ dan dijalankan dengan flutter test.',
    });
  },
};

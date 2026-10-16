// =====================================================================
// PEMBUAT TEMPLAT SLIDE UAS UNTUK MAHASISWA
// Menghasilkan pertemuan_16_uas/templat/TEMPLAT_SLIDE_UAS.pptx: enam slide
// kerangka presentasi proyek akhir (Panduan UAS Bagian 4), dengan tanda
// <...> untuk diganti dan petunjuk di catatan pembicara.
//
// Sesuai Panduan UAS, semua teks isi berukuran minimal 24 pt.
//
// Pemakaian (dari folder tools/slide):
//   node buat_templat_uas.js
// =====================================================================
const path = require('path');
const { Dek, M, L, ATAS } = require('./desain');

const MIN = 24; // ukuran huruf isi paling kecil (pt)
const ABU = '4A5870';
const LATAR_KOTAK = 'F4F7FB';
const GARIS_KOTAK = '9AA9BD';

// Kotak bergaris putus-putus: tempat menempel gambar (tangkapan layar,
// kode QR) yang nanti dihapus setelah gambar dipasang.
function kotakTempel(d, s, { x, y, w, h, teks }) {
  s.addText(teks, {
    x, y, w, h,
    shape: d.pres.ShapeType.roundRect,
    rectRadius: 0.12,
    fill: { color: LATAR_KOTAK },
    line: { color: GARIS_KOTAK, width: 1.5, dashType: 'dash' },
    color: ABU,
    fontSize: 18,
    italic: true,
    align: 'center',
    valign: 'middle',
    margin: 8,
    isTextBox: true,
    objectName: 'tempat gambar',
  });
}

function bangun(d) {
  const C = d.C;

  // ------------------------------------------------------------------
  // Slide 1: identitas
  // ------------------------------------------------------------------
  const s1 = d.judul({
    judul: '<Nama Aplikasi>',
    subjudul: [
      { text: '<Nama tim>', options: { fontSize: 28, bold: true, breakLine: true } },
      { text: '<Nama 1> (tampilan)  ·  <Nama 2> (data)  ·  <Nama 3> (ViewModel dan tes)', options: { fontSize: MIN } },
    ],
    catatan: 'SLIDE 1 (± 15 detik). Ganti <Nama Aplikasi>, nama tim, nama anggota, dan perannya. Ganti lingkaran ikon di kanan dengan IKON APLIKASI Anda sendiri (klik kanan → Change Picture, atau hapus lalu sisipkan gambar). Tulis alamat repositori di bawah. Contoh kalimat pembuka: "Kami tim Resep Hemat Anak Kos: Rina di tampilan, Bima di data, Sari di ViewModel dan tes." Ingat: slide hanya pengantar; seluruh slide selesai dalam ± 2 menit.',
  });
  s1.addText('UAS PEMROGRAMAN PIRANTI BERGERAK', {
    x: M + 0.2, y: 1.1, w: 9, h: 0.4, fontSize: 16, bold: true, color: C.accent2, charSpacing: 2, margin: 0, isTextBox: true,
  });
  s1.addText('<tautan repositori GitHub>', {
    x: M + 0.2, y: 6.45, w: 9, h: 0.45, fontSize: 18, color: 'D6E2F0', margin: 0, isTextBox: true,
  });

  // ------------------------------------------------------------------
  // Slide 2: masalah dan pengguna
  // ------------------------------------------------------------------
  const s2 = d._slide('KONTEN', 'Masalah dan Pengguna', 'SLIDE 2 (± 20 detik). Tulis singkat: SIAPA penggunanya, APA masalahnya, dan BAGAIMANA aplikasi membantu. Satu atau dua kalimat per kotak, huruf tetap minimal 24 pt. Contoh: "Mahasiswa kos sering bingung memasak dengan bahan seadanya..." Kalimat yang sama menjadi awal cerita demo (tokoh dan masalahnya).');
  const kolom = [
    { ikon: 'orang', judul: 'Pengguna', isi: '<Siapa yang memakai aplikasi ini?>', warna: C.accent1 },
    { ikon: 'peringatan', judul: 'Masalah', isi: '<Kesulitan apa yang mereka alami?>', warna: C.accent5 },
    { ikon: 'lampu', judul: 'Bantuan aplikasi', isi: '<Bagaimana aplikasi membantu?>', warna: C.accent4 },
  ];
  const gx = 0.35;
  const lebar = (L - 2 * M - 2 * gx) / 3;
  kolom.forEach((k, i) => {
    const x = M + i * (lebar + gx);
    const y = ATAS + 0.15;
    s2.addShape(d.pres.ShapeType.roundRect, { x, y, w: lebar, h: 4.9, rectRadius: 0.12, fill: { color: C.background2 }, line: { type: 'none' }, objectName: `kotak ${k.judul}` });
    d.ikonBulat(s2, { x: x + 0.3, y: y + 0.3, d: 0.9, ikon: k.ikon, warna: k.warna });
    s2.addText(k.judul, { x: x + 1.35, y: y + 0.3, w: lebar - 1.5, h: 0.9, fontSize: 28, bold: true, color: C.text2, valign: 'middle', margin: 0, isTextBox: true });
    s2.addText(k.isi, { x: x + 0.3, y: y + 1.5, w: lebar - 0.6, h: 3.2, fontSize: MIN, color: C.text1, valign: 'top', margin: 0, isTextBox: true });
  });

  // ------------------------------------------------------------------
  // Slide 3: fitur utama dan alur demo
  // ------------------------------------------------------------------
  const s3 = d._slide('KONTEN', 'Fitur Utama dan Alur Demo', 'SLIDE 3 (± 20 detik). Tulis tiga fitur yang akan DIDEMOKAN, berurutan seperti naskah demo (templat NASKAH_DEMO.md). Contoh: "Kami akan menunjukkan: mencari resep, membuka detail, menyimpan favorit." Tempel dua tangkapan layar ASLI dari aplikasi Anda di kotak bergaris (Sisipkan → Gambar), lalu hapus kotaknya.');
  const langkah = ['<Fitur utama 1>', '<Fitur utama 2>', '<Fitur utama 3>'];
  langkah.forEach((t, i) => {
    const y = ATAS + 0.3 + i * 1.6;
    s3.addText(`${i + 1}`, { x: M, y, w: 0.85, h: 0.85, shape: d.pres.ShapeType.ellipse, fill: { color: C.accent1 }, color: C.background1, fontSize: 28, bold: true, align: 'center', valign: 'middle', margin: 0, isTextBox: true });
    s3.addText([
      { text: t, options: { fontSize: 28, bold: true, color: C.text2, breakLine: true } },
      { text: '<apa yang ditunjukkan>', options: { fontSize: MIN, color: ABU } },
    ], { x: M + 1.1, y: y - 0.1, w: 5.4, h: 1.3, valign: 'middle', margin: 0, isTextBox: true });
  });
  const lebarLayar = 2.65;
  const tinggiLayar = 4.95;
  [0, 1].forEach((i) => {
    kotakTempel(d, s3, {
      x: L - M - 2 * lebarLayar - 0.3 + i * (lebarLayar + 0.3),
      y: ATAS + 0.1,
      w: lebarLayar,
      h: tinggiLayar,
      teks: `Tempel tangkapan layar ${i + 1}\n(Sisipkan → Gambar)`,
    });
  });

  // ------------------------------------------------------------------
  // Slide 4: arsitektur
  // ------------------------------------------------------------------
  const s4 = d._slide('KONTEN', 'Arsitektur', 'SLIDE 4 (± 30 detik). Sesuaikan nama lapisan dengan proyek Anda (MVVM atau Clean Architecture), lalu ganti isi kotak "Folder lib/" dengan struktur folder Anda yang sebenarnya. Contoh kalimat: "Data dari DummyJSON masuk lewat repository, diolah ViewModel, ditampilkan View." Penguji akan membuka folder lib/ saat tanya jawab, jadi pastikan gambarnya sama dengan kodenya.');
  const lapisan = [
    { judul: 'View', isi: '<halaman dan widget>', ikon: 'widget' },
    { judul: 'ViewModel', isi: '<state dan logika>', ikon: 'setel' },
    { judul: 'Repository', isi: '<kontrak dan implementasi>', ikon: 'gudang' },
    { judul: 'Sumber data', isi: '<nama API> + <SQLite / shared_preferences>', ikon: 'server' },
  ];
  const lebarLapis = 7.0;
  const tinggiLapis = 1.05;
  const gy = 0.25;
  lapisan.forEach((l, i) => {
    const y = ATAS + 0.1 + i * (tinggiLapis + gy);
    s4.addShape(d.pres.ShapeType.roundRect, { x: M, y, w: lebarLapis, h: tinggiLapis, rectRadius: 0.12, fill: { color: C.background2 }, line: { type: 'none' }, objectName: `lapisan ${l.judul}` });
    d.ikonBulat(s4, { x: M + 0.2, y: y + 0.15, d: 0.75, ikon: l.ikon, warna: i === 3 ? C.accent6 : C.accent1 });
    s4.addText([
      { text: `${l.judul}  `, options: { fontSize: 26, bold: true, color: C.text2 } },
      { text: l.isi, options: { fontSize: MIN, color: C.text1 } },
    ], { x: M + 1.15, y, w: lebarLapis - 1.3, h: tinggiLapis, valign: 'middle', margin: 0, isTextBox: true });
    if (i < lapisan.length - 1) {
      s4.addShape(d.pres.ShapeType.downArrow, { x: M + lebarLapis / 2 - 0.15, y: y + tinggiLapis - 0.02, w: 0.3, h: gy + 0.04, fill: { color: C.accent2 }, line: { type: 'none' } });
    }
  });
  const xKanan = M + lebarLapis + 0.4;
  s4.addText('Folder lib/', { x: xKanan, y: ATAS + 0.1, w: L - M - xKanan, h: 0.55, fontSize: 26, bold: true, color: C.text2, margin: 0, isTextBox: true });
  d.kotakKode(s4, {
    x: xKanan,
    y: ATAS + 0.75,
    w: L - M - xKanan,
    h: 4.3,
    ukuran: MIN,
    shell: true,
    kode: ['lib/', '├─ data/', '├─ domain/', '├─ ui/', '└─ main.dart', '', '<sesuaikan>'].join('\n'),
  });

  // ------------------------------------------------------------------
  // Slide 5: kualitas dan rilis
  // ------------------------------------------------------------------
  const s5 = d._slide('KONTEN', 'Kualitas dan Rilis', 'SLIDE 5 (± 20 detik). Ganti angka di setiap kartu dengan keadaan proyek Anda: jumlah tes yang lulus (flutter test), hasil flutter analyze, versi rilis terakhir, dan berkas rilis yang tersedia. Tulis tautan versi web dan halaman rilis agar penguji bisa membukanya dari HP; lebih praktis lagi jika ditambah kode QR. Contoh kalimat: "17 tes lulus, versi 1.0.1 ada di GitHub Releases."');
  const kartu = [
    { ikon: 'uji', angka: '<17>', label: 'tes lulus', warna: C.accent4 },
    { ikon: 'centang', angka: '0', label: 'temuan flutter analyze', warna: C.accent1 },
    { ikon: 'label', angka: 'v<1.0.1>', label: 'versi rilis', warna: C.accent6 },
    { ikon: 'unduh', angka: '<Web + APK>', label: 'berkas rilis', warna: C.accent5 },
  ];
  const lebarKartu = (L - 2 * M - 3 * 0.3) / 4;
  kartu.forEach((k, i) => {
    const x = M + i * (lebarKartu + 0.3);
    const y = ATAS + 0.1;
    s5.addShape(d.pres.ShapeType.roundRect, { x, y, w: lebarKartu, h: 2.75, rectRadius: 0.12, fill: { color: C.background2 }, line: { type: 'none' }, objectName: `kartu ${k.label}` });
    d.ikonBulat(s5, { x: x + 0.25, y: y + 0.25, d: 0.7, ikon: k.ikon, warna: k.warna });
    s5.addText(k.angka, { x: x + 0.2, y: y + 1.0, w: lebarKartu - 0.4, h: 0.85, fontSize: 28, bold: true, color: k.warna, valign: 'middle', margin: 0, isTextBox: true });
    s5.addText(k.label, { x: x + 0.25, y: y + 1.85, w: lebarKartu - 0.5, h: 0.8, fontSize: MIN, color: C.text1, valign: 'top', margin: 0, isTextBox: true });
  });
  s5.addText([
    { text: 'Web: ', options: { bold: true, color: C.text2 } },
    { text: '<https://akun.github.io/nama-repositori/>', options: { color: C.text1, breakLine: true } },
    { text: 'Rilis: ', options: { bold: true, color: C.text2 } },
    { text: '<https://github.com/akun/nama-repositori/releases>', options: { color: C.text1 } },
  ], { x: M, y: 4.55, w: 8.9, h: 1.6, fontSize: MIN, valign: 'middle', margin: 0, isTextBox: true });
  kotakTempel(d, s5, { x: L - M - 1.9, y: 4.5, w: 1.9, h: 1.9, teks: 'Kode QR\n(opsional)' });

  // ------------------------------------------------------------------
  // Slide 6: pelajaran dan rencana
  // ------------------------------------------------------------------
  const s6 = d._slide('KONTEN', 'Pelajaran dan Rencana Berikutnya', 'SLIDE 6 (± 15 detik). Satu atau dua pelajaran terpenting selama mengerjakan proyek, dan satu atau dua rencana jika aplikasi dilanjutkan. Contoh: "Kalau dilanjutkan, kami ingin menambah pengingat memasak." Setelah slide ini, LANGSUNG beralih ke demo aplikasi.');
  const dua = [
    { ikon: 'lampu', judul: 'Pelajaran terpenting', isi: ['<pelajaran 1>', '<pelajaran 2>'], warna: C.accent3 },
    { ikon: 'roket', judul: 'Rencana berikutnya', isi: ['<rencana 1>', '<rencana 2>'], warna: C.accent1 },
  ];
  const lebarDua = (L - 2 * M - 0.4) / 2;
  dua.forEach((k, i) => {
    const x = M + i * (lebarDua + 0.4);
    const y = ATAS + 0.1;
    s6.addShape(d.pres.ShapeType.roundRect, { x, y, w: lebarDua, h: 3.9, rectRadius: 0.12, fill: { color: C.background2 }, line: { type: 'none' }, objectName: `kotak ${k.judul}` });
    d.ikonBulat(s6, { x: x + 0.3, y: y + 0.3, d: 0.9, ikon: k.ikon, warna: k.warna });
    s6.addText(k.judul, { x: x + 1.4, y: y + 0.3, w: lebarDua - 1.6, h: 0.9, fontSize: 28, bold: true, color: C.text2, valign: 'middle', margin: 0, isTextBox: true });
    d.daftarPoin(s6, { x: x + 0.4, y: y + 1.5, w: lebarDua - 0.8, h: 2.2, poin: k.isi, ukuran: MIN });
  });
  s6.addText('Terima kasih. Sekarang kami tunjukkan aplikasinya.', {
    x: M, y: 5.35, w: L - 2 * M, h: 0.8, fontSize: 28, bold: true, color: C.accent1, align: 'center', valign: 'middle', margin: 0, isTextBox: true,
  });
}

async function main() {
  const dek = new Dek({
    nomor: '16',
    folder: 'pertemuan_16_uas',
    namaBerkas: 'TEMPLAT_SLIDE_UAS',
    topik: 'Presentasi Proyek Akhir',
    kaki: 'UAS Pemrograman Piranti Bergerak  ·  Presentasi Proyek Akhir',
    templat: true,
  });
  dek.pres.title = 'Templat Slide Presentasi UAS';
  dek.pres.subject = 'Kerangka enam slide presentasi proyek akhir (Panduan UAS Bagian 4)';
  bangun(dek);
  const folderRepo = path.resolve(__dirname, '..', '..');
  const berkas = await dek.simpan(folderRepo, 'templat');
  console.log(`✔ ${path.relative(folderRepo, berkas)}`);
}

main().catch((galat) => {
  console.error(galat);
  process.exit(1);
});

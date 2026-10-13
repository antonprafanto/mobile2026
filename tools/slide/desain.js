// =====================================================================
// SISTEM DESAIN SLIDE "PPB FLUTTER 2026"
// Berisi tema warna, layout (slide master), dan fungsi pembuat jenis-jenis
// slide. Konten setiap pertemuan ada di folder ./konten.
// =====================================================================
const fs = require('fs');
const path = require('path');
const PptxGenJS = require('pptxgenjs');

// --------------------------------------------------------------------
// Pengaturan repositori: ubah di sini jika alamat repositori berpindah.
// --------------------------------------------------------------------
const REPO = 'https://github.com/antonprafanto/mobile2026';
const CABANG = 'main';

const TEMA = {
  name: 'PPB Flutter 2026',
  headFontFace: 'Calibri',
  bodyFontFace: 'Calibri',
  colors: {
    dk1: '1B2333', // teks utama
    lt1: 'FFFFFF', // latar slide terang
    dk2: '0B2545', // biru tua: latar slide gelap & judul
    lt2: 'EEF3FA', // latar kartu
    accent1: '0175C2', // biru Dart
    accent2: '13B9FD', // biru muda Flutter
    accent3: 'F2A900', // kuning sorotan
    accent4: '2E7D32', // hijau (berhasil / benar)
    accent5: 'C62828', // merah (galat / salah)
    accent6: '6750A4', // ungu Material 3
    hlink: '0175C2',
    folHlink: '6750A4',
  },
};

// Warna kode (tetap, tidak mengikuti tema) agar mudah dibaca di proyektor.
const WARNA_KODE = {
  latar: '0E1A2B',
  teks: 'E6EDF3',
  kunci: 'C792EA',
  tipe: 'FFCB6B',
  string: 'C3E88D',
  komentar: '8FA3BC',
  angka: 'F78C6C',
  anotasi: '89DDFF',
};
const FONT_KODE = 'Consolas';

// Ukuran kanvas 16:9 (inci) dan grid.
const L = 13.333;
const T = 7.5;
const M = 0.6; // margin kiri-kanan
const ATAS = 1.45; // batas atas area konten
const BAWAH = 6.8; // batas bawah area konten

const IKON = path.join(__dirname, 'ikon');

function ikonPath(nama) {
  const p = path.join(IKON, `${nama}.png`);
  if (!fs.existsSync(p)) throw new Error(`Ikon "${nama}" tidak ditemukan di ${IKON}`);
  return p;
}

// --------------------------------------------------------------------
// Pewarnaan sintaks Dart sederhana (untuk kotak kode di slide).
// --------------------------------------------------------------------
const KATA_KUNCI = new Set([
  'import', 'void', 'return', 'class', 'extends', 'const', 'final', 'var',
  'if', 'else', 'for', 'while', 'do', 'switch', 'case', 'default', 'break',
  'continue', 'late', 'required', 'super', 'this', 'true', 'false', 'null',
  'in', 'new', 'async', 'await', 'dynamic', 'with', 'is', 'as',
  // Pertemuan 3: OOP dan asinkron
  'abstract', 'implements', 'mixin', 'enum', 'factory', 'get', 'set',
  'try', 'on', 'catch', 'finally', 'throw', 'yield', 'sealed',
]);
const TIPE_DASAR = new Set(['int', 'double', 'num', 'bool', 'String', 'List', 'Map', 'Set', 'Object']);

function tokenBaris(baris, shell, status = { dalamBlok: false }) {
  const hasil = [];
  let i = 0;
  if (status.dalamBlok) {
    const akhir = baris.indexOf('*/');
    if (akhir < 0) {
      return [{ teks: baris, warna: WARNA_KODE.komentar, miring: true }];
    }
    hasil.push({ teks: baris.slice(0, akhir + 2), warna: WARNA_KODE.komentar, miring: true });
    status.dalamBlok = false;
    i = akhir + 2;
  }
  const dorong = (teks, warna, miring) => {
    if (teks) hasil.push({ teks, warna, miring: !!miring });
  };
  let polos = '';
  const lepasPolos = () => {
    dorong(polos, WARNA_KODE.teks);
    polos = '';
  };
  while (i < baris.length) {
    const c = baris[i];
    if (c === '/' && baris[i + 1] === '*' && !shell) {
      lepasPolos();
      const akhir = baris.indexOf('*/', i + 2);
      if (akhir < 0) {
        dorong(baris.slice(i), WARNA_KODE.komentar, true);
        status.dalamBlok = true;
        break;
      }
      dorong(baris.slice(i, akhir + 2), WARNA_KODE.komentar, true);
      i = akhir + 2;
      continue;
    }
    if ((c === '/' && baris[i + 1] === '/' && !shell) || (shell && c === '#')) {
      lepasPolos();
      dorong(baris.slice(i), WARNA_KODE.komentar, true);
      break;
    }
    if (c === "'" || c === '"') {
      lepasPolos();
      let j = i + 1;
      while (j < baris.length && baris[j] !== c) {
        if (baris[j] === '\\') j++;
        j++;
      }
      dorong(baris.slice(i, j + 1), WARNA_KODE.string);
      i = j + 1;
      continue;
    }
    if (c === '@') {
      lepasPolos();
      let j = i + 1;
      while (j < baris.length && /\w/.test(baris[j])) j++;
      dorong(baris.slice(i, j), WARNA_KODE.anotasi);
      i = j;
      continue;
    }
    if (/[A-Za-z_]/.test(c) && !shell) {
      let j = i;
      while (j < baris.length && /\w/.test(baris[j])) j++;
      const kata = baris.slice(i, j);
      if (KATA_KUNCI.has(kata)) {
        lepasPolos();
        dorong(kata, WARNA_KODE.kunci);
      } else if (TIPE_DASAR.has(kata) || /^[A-Z]/.test(kata)) {
        lepasPolos();
        dorong(kata, WARNA_KODE.tipe);
      } else {
        polos += kata;
      }
      i = j;
      continue;
    }
    if (/[0-9]/.test(c) && !/\w/.test(baris[i - 1] || '')) {
      lepasPolos();
      let j = i;
      while (j < baris.length && /[0-9.]/.test(baris[j])) j++;
      dorong(baris.slice(i, j), WARNA_KODE.angka);
      i = j;
      continue;
    }
    polos += c;
    i++;
  }
  lepasPolos();
  return hasil;
}

function runsKode(kode, ukuran, shell) {
  const baris = kode.replace(/\s+$/, '').split('\n');
  const runs = [];
  const status = { dalamBlok: false };
  baris.forEach((b, idx) => {
    const token = tokenBaris(b, shell, status);
    if (token.length === 0) token.push({ teks: ' ', warna: WARNA_KODE.teks });
    token.forEach((t, k) => {
      const opsi = { color: t.warna, fontFace: FONT_KODE, fontSize: ukuran, italic: t.miring };
      if (k === token.length - 1 && idx < baris.length - 1) opsi.breakLine = true;
      runs.push({ text: t.teks, options: opsi });
    });
  });
  return { runs, jumlahBaris: baris.length, terpanjang: Math.max(...baris.map((b) => b.length)) };
}

// Ukuran piksel gambar PNG/JPEG, dipakai agar perbandingan sisi gambar
// tidak berubah saat ditempel ke slide.
function ukuranGambar(berkas) {
  const b = fs.readFileSync(berkas);
  if (b[0] === 0x89 && b[1] === 0x50) {
    return { w: b.readUInt32BE(16), h: b.readUInt32BE(20) };
  }
  let i = 2;
  while (i + 9 < b.length) {
    if (b[i] !== 0xff) {
      i++;
      continue;
    }
    const kode = b[i + 1];
    const panjang = b.readUInt16BE(i + 2);
    // Penanda SOF (C0..CF) menyimpan tinggi dan lebar, kecuali C4, C8, CC.
    if (kode >= 0xc0 && kode <= 0xcf && ![0xc4, 0xc8, 0xcc].includes(kode)) {
      return { h: b.readUInt16BE(i + 5), w: b.readUInt16BE(i + 7) };
    }
    i += 2 + panjang;
  }
  throw new Error(`Ukuran gambar tidak terbaca: ${berkas}`);
}

// --------------------------------------------------------------------
// Pembuat dek
// --------------------------------------------------------------------
class Dek {
  constructor({ nomor, folder, namaBerkas, topik }) {
    this.nomor = nomor;
    this.folder = folder;
    this.namaBerkas = namaBerkas;
    this.topik = topik;
    this.pres = new PptxGenJS();
    this.pres.layout = 'LAYOUT_WIDE';
    this.pres.author = 'Pemrograman Piranti Bergerak - Informatika S1';
    this.pres.title = `Pertemuan ${nomor} - ${topik}`;
    this.pres.subject = 'Materi kuliah Pemrograman Piranti Bergerak (Flutter 2026)';
    this.pres.theme = { headFontFace: TEMA.headFontFace, bodyFontFace: TEMA.bodyFontFace };
    this.C = this.pres.SchemeColor;
    this.bagianAktif = 'Pembuka';
    this.pres.addSection({ title: this.bagianAktif });
    this._layout();
  }

  // ---------------- layout (slide master) ----------------
  _layout() {
    const C = this.C;
    const footer = `Pemrograman Piranti Bergerak  ·  Pertemuan ${this.nomor}  ·  ${this.topik}`;

    this.pres.defineSlideMaster({
      title: 'JUDUL',
      background: { color: C.text2 },
      objects: [
        { text: { text: '', options: { shape: 'ellipse', x: 9.2, y: 3.2, w: 6.2, h: 6.2, fill: { color: C.accent1, transparency: 70 }, line: { type: 'none' } } } },
        { text: { text: '', options: { shape: 'ellipse', x: 10.6, y: -1.4, w: 3.6, h: 3.6, fill: { color: C.accent2, transparency: 80 }, line: { type: 'none' } } } },
        {
          text: {
            text: 'PEMROGRAMAN PIRANTI BERGERAK  ·  INFORMATIKA S1',
            options: { x: M + 0.2, y: 1.1, w: 9, h: 0.4, fontSize: 14, bold: true, color: C.accent2, charSpacing: 2, margin: 0 },
          },
        },
        {
          text: {
            text: REPO.replace('https://', ''),
            options: { x: M + 0.2, y: 6.55, w: 8, h: 0.35, fontSize: 13, color: C.background2, margin: 0 },
          },
        },
        {
          placeholder: {
            options: { name: 'judul', type: 'title', x: M + 0.2, y: 1.7, w: 9.6, h: 2.3, fontSize: 44, bold: true, color: C.background1, valign: 'bottom', align: 'left', margin: 0 },
            text: '',
          },
        },
        {
          placeholder: {
            options: { name: 'subjudul', type: 'body', x: M + 0.2, y: 4.2, w: 9.2, h: 1.4, fontSize: 20, color: C.background2, valign: 'top', align: 'left', margin: 0 },
            text: '',
          },
        },
      ],
    });

    this.pres.defineSlideMaster({
      title: 'BAGIAN',
      background: { color: C.text2 },
      objects: [
        { text: { text: '', options: { shape: 'ellipse', x: -1.8, y: 4.4, w: 5, h: 5, fill: { color: C.accent1, transparency: 75 }, line: { type: 'none' } } } },
        {
          placeholder: {
            options: { name: 'label', type: 'body', x: 4.2, y: 2.3, w: 8.4, h: 0.5, fontSize: 18, bold: true, color: C.accent2, charSpacing: 2, margin: 0 },
            text: '',
          },
        },
        {
          placeholder: {
            options: { name: 'judul', type: 'title', x: 4.2, y: 2.85, w: 8.4, h: 1.9, fontSize: 40, bold: true, color: C.background1, valign: 'top', align: 'left', margin: 0 },
            text: '',
          },
        },
        { text: { text: footer, options: { x: M, y: 6.95, w: 9, h: 0.3, fontSize: 10, color: C.background2, margin: 0 } } },
      ],
      slideNumber: { x: 12.1, y: 6.95, w: 0.6, h: 0.3, fontSize: 10, color: 'D6E2F0', align: 'right' },
    });

    this.pres.defineSlideMaster({
      title: 'KONTEN',
      background: { color: C.background1 },
      objects: [
        {
          placeholder: {
            options: { name: 'judul', type: 'title', x: M, y: 0.35, w: L - 2 * M, h: 0.9, fontSize: 32, bold: true, color: C.text2, valign: 'middle', align: 'left', margin: 0 },
            text: '',
          },
        },
        { text: { text: footer, options: { x: M, y: 6.95, w: 9, h: 0.3, fontSize: 10, color: '6B7A90', margin: 0 } } },
      ],
      slideNumber: { x: 12.1, y: 6.95, w: 0.6, h: 0.3, fontSize: 10, color: '6B7A90', align: 'right' },
    });
  }

  _slide(master, judul, catatan) {
    const s = this.pres.addSlide({ masterName: master, sectionTitle: this.bagianAktif });
    if (judul) s.addText(judul, { placeholder: 'judul' });
    if (catatan) s.addNotes(catatan);
    return s;
  }

  urlKode(berkas) {
    return `${REPO}/blob/${CABANG}/${this.folder}/${berkas}`;
  }

  urlBerkas(relatif) {
    return `${REPO}/blob/${CABANG}/${relatif}`;
  }

  // ---------------- komponen kecil ----------------
  ikonBulat(s, { x, y, d, ikon, warna }) {
    s.addShape(this.pres.ShapeType.ellipse, { x, y, w: d, h: d, fill: { color: warna || this.C.accent1 }, line: { type: 'none' }, objectName: `lingkaran ${ikon}` });
    const u = d * 0.56;
    s.addImage({ path: ikonPath(ikon), x: x + (d - u) / 2, y: y + (d - u) / 2, w: u, h: u, altText: ikon });
  }

  tombol(s, { x, y, w, h = 0.5, teks, url, warna, ikon = 'kode', ukuran = 13 }) {
    const d = h * 0.6;
    s.addText(teks, {
      x, y, w, h,
      shape: this.pres.ShapeType.roundRect,
      rectRadius: 0.12,
      fill: { color: warna || this.C.accent1 },
      line: { type: 'none' },
      color: this.C.background1,
      fontSize: ukuran,
      bold: true,
      align: 'left',
      valign: 'middle',
      // urutan margin pptxgenjs: [kiri, kanan, bawah, atas] (dalam poin)
      margin: [Math.round((d + 0.32) * 72), 6, 0, 0],
      hyperlink: { url, tooltip: url },
      isTextBox: true,
      objectName: 'tombol tautan',
    });
    s.addImage({ path: ikonPath(ikon), x: x + 0.16, y: y + (h - d) / 2, w: d, h: d, hyperlink: { url, tooltip: url }, altText: 'ikon tautan' });
  }

  tombolKode(s, { x, y, w, berkas }) {
    const nama = berkas.split('/').pop();
    // Perkiraan lebar teks: huruf Calibri tebal rata-rata ±0,46 em. Jika
    // label panjang tidak muat dalam satu baris, pakai label yang pendek.
    const ruang = (w - 0.75) * 72;
    const panjang = `Buka kode lengkap di GitHub  ·  ${nama}`;
    const teks = panjang.length * 13 * 0.46 <= ruang ? panjang : `Kode di GitHub  ·  ${nama}`;
    this.tombol(s, { x, y, w, teks, url: this.urlKode(berkas), ikon: 'kode' });
  }

  kotakKode(s, { x, y, w, h, kode, ukuran = 15, shell = false }) {
    const { runs } = runsKode(kode, ukuran, shell);
    s.addText(runs, {
      x, y, w, h,
      shape: this.pres.ShapeType.roundRect,
      rectRadius: 0.1,
      fill: { color: WARNA_KODE.latar },
      line: { type: 'none' },
      valign: 'top',
      margin: [14, 12, 14, 12],
      lineSpacingMultiple: 1.05,
      isTextBox: true,
      objectName: 'kotak kode',
    });
  }

  daftarPoin(s, { x, y, w, h, poin, ukuran = 18, warna }) {
    const runs = [];
    poin.forEach((p, i) => {
      const bagian = Array.isArray(p) ? p : [{ text: p }];
      bagian.forEach((b, k) => {
        const opsi = Object.assign({ fontSize: ukuran, color: warna || this.C.text1 }, b.options || {});
        if (k === 0) {
          opsi.bullet = { indent: 18 };
          opsi.paraSpaceAfter = 8;
        }
        if (k === bagian.length - 1 && i < poin.length - 1) opsi.breakLine = true;
        runs.push({ text: b.text, options: opsi });
      });
    });
    s.addText(runs, { x, y, w, h, valign: 'top', margin: 0, isTextBox: true, objectName: 'daftar poin' });
  }

  // ---------------- jenis-jenis slide ----------------
  judul({ judul, subjudul, catatan }) {
    const s = this._slide('JUDUL', null, catatan);
    s.addText(judul, { placeholder: 'judul' });
    s.addText(subjudul, { placeholder: 'subjudul' });
    this.ikonBulat(s, { x: 10.55, y: 2.0, d: 1.9, ikon: 'hp', warna: this.C.accent1 });
    return s;
  }

  bagian({ label, judul, ikon, catatan }) {
    this.bagianAktif = judul;
    this.pres.addSection({ title: judul });
    const s = this._slide('BAGIAN', null, catatan);
    s.addText(label, { placeholder: 'label' });
    s.addText(judul, { placeholder: 'judul' });
    this.ikonBulat(s, { x: 1.2, y: 2.35, d: 2.2, ikon, warna: this.C.accent1 });
    return s;
  }

  tujuan({ judul = 'Tujuan Pembelajaran', pengantar, poin, catatan }) {
    const s = this._slide('KONTEN', judul, catatan);
    if (pengantar) {
      s.addText(pengantar, { x: M, y: ATAS, w: L - 2 * M, h: 0.45, fontSize: 18, italic: true, color: '4A5870', margin: 0, isTextBox: true });
    }
    const y0 = pengantar ? ATAS + 0.65 : ATAS + 0.1;
    const kolom = poin.length > 4 ? 2 : 1;
    const per = Math.ceil(poin.length / kolom);
    const lebar = (L - 2 * M - (kolom - 1) * 0.4) / kolom;
    const tinggi = Math.min(1.3, (BAWAH - y0) / per);
    poin.forEach((p, i) => {
      const k = Math.floor(i / per);
      const r = i % per;
      const x = M + k * (lebar + 0.4);
      const y = y0 + r * tinggi;
      this.ikonBulat(s, { x, y: y + 0.1, d: 0.65, ikon: 'centang', warna: this.C.accent4 });
      s.addText(p, { x: x + 0.85, y, w: lebar - 0.85, h: 0.85, fontSize: 19, color: this.C.text1, valign: 'middle', margin: 0, isTextBox: true });
    });
    return s;
  }

  alur({ judul, pengantar, langkah, catatan, warna, tinggiKotak = 3.9 }) {
    const s = this._slide('KONTEN', judul, catatan);
    if (pengantar) {
      s.addText(pengantar, { x: M, y: ATAS, w: L - 2 * M, h: 0.6, fontSize: 18, color: '4A5870', margin: 0, isTextBox: true });
    }
    const n = langkah.length;
    const jarak = 0.35;
    const lebar = (L - 2 * M - (n - 1) * jarak) / n;
    const y = pengantar ? 2.3 : 2.0;
    langkah.forEach((l, i) => {
      const x = M + i * (lebar + jarak);
      s.addShape(this.pres.ShapeType.roundRect, { x, y, w: lebar, h: tinggiKotak, rectRadius: 0.15, fill: { color: this.C.background2 }, line: { type: 'none' }, objectName: `langkah ${i + 1}` });
      this.ikonBulat(s, { x: x + (lebar - 0.95) / 2, y: y + 0.3, d: 0.95, ikon: l.ikon, warna: l.warna || warna || this.C.accent1 });
      s.addText(`${i + 1}`, { x: x + 0.12, y: y + 0.1, w: 0.5, h: 0.4, fontSize: 14, bold: true, color: '6B7A90', margin: 0, isTextBox: true });
      // Perkiraan lebar kata terpanjang agar judul tidak terpotong di tengah kata.
      const kataTerpanjang = Math.max(...l.judul.split(/\s+/).map((k) => k.length));
      const ukuranJudul = Math.max(13, Math.min(17, Math.floor(((lebar - 0.3) * 72) / (kataTerpanjang * 0.56))));
      s.addText(l.judul, { x: x + 0.15, y: y + 1.4, w: lebar - 0.3, h: 0.85, fontSize: ukuranJudul, bold: true, color: this.C.text2, align: 'center', valign: 'top', margin: 0, isTextBox: true });
      s.addText(l.isi, { x: x + 0.15, y: y + 2.3, w: lebar - 0.3, h: tinggiKotak - 2.4, fontSize: 14, color: this.C.text1, align: 'center', valign: 'top', margin: 0, isTextBox: true });
      if (i < n - 1) {
        s.addShape(this.pres.ShapeType.rightArrow, { x: x + lebar + 0.04, y: y + 0.62, w: jarak - 0.08, h: 0.3, fill: { color: this.C.accent2 }, line: { type: 'none' } });
      }
    });
    return s;
  }

  kartu({ judul, pengantar, kolom = 3, item, catatan, tinggiKartu }) {
    const s = this._slide('KONTEN', judul, catatan);
    let y0 = ATAS + 0.05;
    if (pengantar) {
      s.addText(pengantar, { x: M, y: ATAS, w: L - 2 * M, h: 0.55, fontSize: 18, color: '4A5870', margin: 0, isTextBox: true });
      y0 = ATAS + 0.75;
    }
    const baris = Math.ceil(item.length / kolom);
    const gx = 0.35;
    const gy = 0.3;
    const lebar = (L - 2 * M - (kolom - 1) * gx) / kolom;
    const tinggi = tinggiKartu || (BAWAH - y0 - (baris - 1) * gy) / baris;
    item.forEach((it, i) => {
      const x = M + (i % kolom) * (lebar + gx);
      const y = y0 + Math.floor(i / kolom) * (tinggi + gy);
      s.addShape(this.pres.ShapeType.roundRect, { x, y, w: lebar, h: tinggi, rectRadius: 0.12, fill: { color: this.C.background2 }, line: { type: 'none' }, objectName: `kartu ${i + 1}` });
      this.ikonBulat(s, { x: x + 0.25, y: y + 0.25, d: 0.75, ikon: it.ikon, warna: it.warna || this.C.accent1 });
      s.addText(it.judul, { x: x + 1.15, y: y + 0.22, w: lebar - 1.35, h: 0.8, fontSize: 18, bold: true, color: this.C.text2, valign: 'middle', margin: 0, isTextBox: true });
      const tinggiKode = it.kode ? 0.32 + it.kode.split('\n').length * 0.26 : 0;
      s.addText(it.isi, { x: x + 0.25, y: y + 1.15, w: lebar - 0.5, h: tinggi - 1.3 - tinggiKode, fontSize: 15, color: this.C.text1, valign: 'top', margin: 0, isTextBox: true });
      if (it.kode) {
        this.kotakKode(s, { x: x + 0.2, y: y + tinggi - tinggiKode - 0.2, w: lebar - 0.4, h: tinggiKode, kode: it.kode, ukuran: 13 });
      }
    });
    return s;
  }

  statistik({ judul, item, pesan, sumber, catatan }) {
    const s = this._slide('KONTEN', judul, catatan);
    const n = item.length;
    const lebar = (L - 2 * M - (n - 1) * 0.5) / n;
    item.forEach((it, i) => {
      const x = M + i * (lebar + 0.5);
      s.addShape(this.pres.ShapeType.roundRect, { x, y: ATAS + 0.1, w: lebar, h: 3.2, rectRadius: 0.15, fill: { color: this.C.background2 }, line: { type: 'none' } });
      this.ikonBulat(s, { x: x + 0.35, y: ATAS + 0.4, d: 0.8, ikon: it.ikon, warna: it.warna });
      s.addText(it.angka, { x: x + 0.3, y: ATAS + 1.25, w: lebar - 0.6, h: 1.3, fontSize: 66, bold: true, color: it.warna, margin: 0, isTextBox: true });
      s.addText(it.label, { x: x + 0.35, y: ATAS + 2.55, w: lebar - 0.7, h: 0.6, fontSize: 18, color: this.C.text1, margin: 0, isTextBox: true });
    });
    if (pesan) {
      this.ikonBulat(s, { x: M, y: 5.05, d: 0.6, ikon: 'lampu', warna: this.C.accent3 });
      s.addText(pesan, { x: M + 0.8, y: 4.95, w: L - 2 * M - 0.8, h: 0.9, fontSize: 18, color: this.C.text1, valign: 'middle', margin: 0, isTextBox: true });
    }
    if (sumber) {
      s.addText(sumber, { x: M, y: 6.15, w: L - 2 * M, h: 0.4, fontSize: 11, italic: true, color: '6B7A90', margin: 0, isTextBox: true });
    }
    return s;
  }

  banding({ judul, kolom, catatan, pesan, tinggiKolom, ukuranPoin = 16, ukuranContoh = 14 }) {
    const s = this._slide('KONTEN', judul, catatan);
    const n = kolom.length;
    const gx = 0.35;
    const lebar = (L - 2 * M - (n - 1) * gx) / n;
    const tinggi = tinggiKolom || (pesan ? 4.3 : 5.2);
    kolom.forEach((k, i) => {
      const x = M + i * (lebar + gx);
      const y = ATAS + 0.05;
      s.addShape(this.pres.ShapeType.roundRect, { x, y, w: lebar, h: tinggi, rectRadius: 0.12, fill: { color: k.sorot ? 'E3F2FD' : this.C.background2 }, line: k.sorot ? { color: this.C.accent1, width: 2 } : { type: 'none' }, objectName: `kolom ${i + 1}` });
      this.ikonBulat(s, { x: x + 0.25, y: y + 0.25, d: 0.75, ikon: k.ikon, warna: k.warna || this.C.accent1 });
      s.addText(k.judul, { x: x + 1.15, y: y + 0.2, w: lebar - 1.3, h: 0.85, fontSize: 19, bold: true, color: this.C.text2, valign: 'middle', margin: 0, isTextBox: true });
      if (k.tag) {
        s.addText(k.tag, { x: x + 0.25, y: y + 1.15, w: lebar - 0.5, h: 0.4, fontSize: 14, bold: true, color: k.warna || this.C.accent1, margin: 0, isTextBox: true });
      }
      const tinggiContoh = k.contoh ? 0.32 + k.contoh.split('\n').length * 0.28 * (ukuranContoh / 14) : 0;
      this.daftarPoin(s, { x: x + 0.25, y: y + (k.tag ? 1.7 : 1.3), w: lebar - 0.5, h: tinggi - (k.tag ? 1.85 : 1.45) - tinggiContoh, poin: k.poin, ukuran: ukuranPoin });
      if (k.contoh) {
        this.kotakKode(s, { x: x + 0.2, y: y + tinggi - tinggiContoh - 0.2, w: lebar - 0.4, h: tinggiContoh, kode: k.contoh, ukuran: ukuranContoh });
      }
    });
    if (pesan) {
      this.ikonBulat(s, { x: M, y: ATAS + tinggi + 0.3, d: 0.6, ikon: 'lampu', warna: this.C.accent3 });
      s.addText(pesan, { x: M + 0.8, y: ATAS + tinggi + 0.2, w: L - 2 * M - 0.8, h: 0.8, fontSize: 17, color: this.C.text1, valign: 'middle', margin: 0, isTextBox: true });
    }
    return s;
  }

  tabel({ judul, pengantar, kepala, baris, lebarKolom, catatan, ukuran = 17, pesan, tinggiBaris, batasBawah }) {
    const s = this._slide('KONTEN', judul, catatan);
    let y = ATAS + 0.05;
    if (pengantar) {
      s.addText(pengantar, { x: M, y: ATAS, w: L - 2 * M, h: 0.55, fontSize: 18, color: '4A5870', margin: 0, isTextBox: true });
      y = ATAS + 0.7;
    }
    const bawah = batasBawah || (pesan ? 5.75 : BAWAH);
    const jumlahBaris = baris.length + 1;
    const rowH = tinggiBaris || Math.max(0.45, Math.min(0.75, (bawah - y) / jumlahBaris));
    const lebarTotal = L - 2 * M;
    const colW = (lebarKolom || kepala.map(() => 1)).map((v, i, arr) => (v / arr.reduce((a, b) => a + b, 0)) * lebarTotal);
    const rows = [
      kepala.map((h) => ({ text: h, options: { bold: true, color: 'FFFFFF', fill: { color: TEMA.colors.dk2 }, fontSize: ukuran } })),
      ...baris.map((r, i) => r.map((c) => {
        const sel = typeof c === 'string' ? { text: c } : c;
        return { text: sel.text, options: Object.assign({ fill: { color: i % 2 === 0 ? 'FFFFFF' : TEMA.colors.lt2 }, color: TEMA.colors.dk1, fontSize: ukuran }, sel.options || {}) };
      })),
    ];
    s.addTable(rows, {
      x: M, y, w: lebarTotal, colW,
      rowH: rows.map(() => rowH),
      fontFace: TEMA.bodyFontFace,
      border: { type: 'solid', pt: 0.75, color: 'D5DEEA' },
      valign: 'middle',
      margin: [4, 8, 4, 8],
      autoPage: false,
    });
    if (pesan) {
      this.ikonBulat(s, { x: M, y: 6.0, d: 0.55, ikon: 'lampu', warna: this.C.accent3 });
      s.addText(pesan, { x: M + 0.75, y: 5.9, w: L - 2 * M - 0.75, h: 0.75, fontSize: 16, color: this.C.text1, valign: 'middle', margin: 0, isTextBox: true });
    }
    return s;
  }

  kode({ judul, kode, berkas, poin, catatan, ukuran = 15, lebarKode = 7.4, tinggiKode, shell = false }) {
    const s = this._slide('KONTEN', judul, catatan);
    const { jumlahBaris } = runsKode(kode, ukuran, shell);
    const h = tinggiKode || Math.min(4.6, 0.45 + jumlahBaris * ukuran * 1.2 / 72 * 1.05);
    this.kotakKode(s, { x: M, y: ATAS + 0.05, w: lebarKode, h, kode, ukuran, shell });
    if (berkas) this.tombolKode(s, { x: M, y: ATAS + 0.05 + h + 0.25, w: lebarKode, berkas });
    const xk = M + lebarKode + 0.45;
    this.daftarPoin(s, { x: xk, y: ATAS + 0.1, w: L - M - xk, h: 5.1, poin, ukuran: 17 });
    return s;
  }

  // Tangkapan layar aplikasi (satu atau beberapa gambar dari folder
  // <pertemuan>/gambar/) di kanan, serta kode/tombol/poin di kiri.
  layar({ judul, gambar, kode, berkas, poin, catatan, ukuranKode = 14, ukuranPoin = 17, tinggiGambar = 5.15, lebarMaks = 6.4 }) {
    const s = this._slide('KONTEN', judul, catatan);
    const daftar = Array.isArray(gambar) ? gambar : [gambar];
    const gx = 0.3;
    const ruangCelah = gx * (daftar.length - 1);
    const ukuran = daftar.map((g) => {
      const p = path.join(__dirname, '..', '..', this.folder, 'gambar', g);
      const { w, h } = ukuranGambar(p);
      return { p, nama: g, w: (tinggiGambar * w) / h, h: tinggiGambar };
    });
    let totalW = ukuran.reduce((a, u) => a + u.w, 0) + ruangCelah;
    if (totalW > lebarMaks) {
      const f = (lebarMaks - ruangCelah) / (totalW - ruangCelah);
      ukuran.forEach((u) => {
        u.w *= f;
        u.h *= f;
      });
      totalW = lebarMaks;
    }
    const y0 = ATAS + 0.05;
    let x = L - M - totalW;
    ukuran.forEach((u, i) => {
      s.addShape(this.pres.ShapeType.roundRect, { x: x - 0.06, y: y0 - 0.06, w: u.w + 0.12, h: u.h + 0.12, rectRadius: 0.1, fill: { color: 'FFFFFF' }, line: { color: 'C9D3E0', width: 1 }, objectName: `bingkai layar ${i + 1}` });
      s.addImage({ path: u.p, x, y: y0, w: u.w, h: u.h, altText: `Tangkapan layar aplikasi (${u.nama})`, objectName: `layar ${i + 1}` });
      x += u.w + gx;
    });
    const lebarKiri = L - 2 * M - totalW - 0.5;
    let y = ATAS + 0.05;
    if (kode) {
      const { jumlahBaris } = runsKode(kode, ukuranKode, false);
      const h = Math.min(3.8, 0.45 + ((jumlahBaris * ukuranKode * 1.2) / 72) * 1.05);
      this.kotakKode(s, { x: M, y, w: lebarKiri, h, kode, ukuran: ukuranKode });
      y += h + 0.2;
    }
    if (berkas) {
      this.tombolKode(s, { x: M, y, w: lebarKiri, berkas });
      y += 0.75;
    }
    if (poin) {
      this.daftarPoin(s, { x: M, y: y + 0.05, w: lebarKiri, h: BAWAH - y - 0.05, poin, ukuran: ukuranPoin });
    }
    return s;
  }

  lapisan({ judul, lapisan, keterangan, catatan }) {
    const s = this._slide('KONTEN', judul, catatan);
    const n = lapisan.length;
    const gy = 0.2;
    const tinggi = Math.min(0.95, (BAWAH - ATAS - 0.1 - (n - 1) * gy) / n);
    const lebar = 7.2;
    lapisan.forEach((l, i) => {
      const y = ATAS + 0.05 + i * (tinggi + gy);
      s.addShape(this.pres.ShapeType.roundRect, { x: M, y, w: lebar, h: tinggi, rectRadius: 0.12, fill: { color: l.latar || this.C.background2 }, line: { type: 'none' }, objectName: `lapisan ${i + 1}` });
      this.ikonBulat(s, { x: M + 0.2, y: y + (tinggi - 0.7) / 2, d: 0.7, ikon: l.ikon, warna: l.warna || this.C.accent1 });
      s.addText([
        { text: l.judul, options: { bold: true, fontSize: 18, color: this.C.text2, breakLine: true } },
        { text: l.isi, options: { fontSize: 15, color: this.C.text1 } },
      ], { x: M + 1.1, y, w: lebar - 1.3, h: tinggi, valign: 'middle', margin: 0, isTextBox: true });
      if (i < n - 1) {
        s.addShape(this.pres.ShapeType.downArrow, { x: M + lebar / 2 - 0.15, y: y + tinggi - 0.02, w: 0.3, h: gy + 0.04, fill: { color: this.C.accent2 }, line: { type: 'none' } });
      }
    });
    if (keterangan) {
      this.daftarPoin(s, { x: M + lebar + 0.5, y: ATAS + 0.1, w: L - 2 * M - lebar - 0.5, h: 5.0, poin: keterangan, ukuran: 18 });
    }
    return s;
  }

  ringkasan({ judul = 'Ringkasan', poin, catatan }) {
    const s = this._slide('KONTEN', judul, catatan);
    const kolom = 2;
    const per = Math.ceil(poin.length / kolom);
    const lebar = (L - 2 * M - 0.5) / kolom;
    const tinggi = Math.min(1.25, (BAWAH - ATAS) / per);
    poin.forEach((p, i) => {
      const k = Math.floor(i / per);
      const r = i % per;
      const x = M + k * (lebar + 0.5);
      const y = ATAS + 0.05 + r * tinggi;
      s.addText(`${i + 1}`, { x, y: y + 0.05, w: 0.55, h: 0.55, shape: this.pres.ShapeType.ellipse, fill: { color: this.C.accent1 }, color: this.C.background1, fontSize: 16, bold: true, align: 'center', valign: 'middle', margin: 0, isTextBox: true });
      s.addText(p, { x: x + 0.75, y, w: lebar - 0.75, h: tinggi - 0.1, fontSize: 17, color: this.C.text1, valign: 'top', margin: 0, isTextBox: true });
    });
    return s;
  }

  penutup({ judul, subjudul, tautan, catatan }) {
    const s = this._slide('JUDUL', null, catatan);
    s.addText(judul, { placeholder: 'judul' });
    s.addText(subjudul, { placeholder: 'subjudul' });
    tautan.forEach((t, i) => {
      this.tombol(s, { x: M + 0.2 + i * 3.15, y: 5.65, w: 2.95, h: 0.6, teks: t.teks, url: t.url, ikon: t.ikon, ukuran: 16, warna: i === 0 ? this.C.accent1 : this.C.accent6 });
    });
    this.ikonBulat(s, { x: 10.55, y: 2.0, d: 1.9, ikon: 'roket', warna: this.C.accent1 });
    return s;
  }

  // ---------------- simpan ----------------
  async simpan(folderRepo) {
    const tujuan = path.join(folderRepo, this.folder, 'slide', `${this.namaBerkas}.pptx`);
    fs.mkdirSync(path.dirname(tujuan), { recursive: true });
    await this.pres.writeFile({ fileName: tujuan });
    await rapikanBerkas(tujuan);
    return tujuan;
  }
}

// --------------------------------------------------------------------
// Pasca-proses: tulis warna tema ke theme1.xml dan buang hyperlink
// tingkat teks pada tombol (agar teks tombol tetap putih tanpa garis
// bawah; tautan tetap aktif di tingkat bentuk/shape).
// --------------------------------------------------------------------
async function rapikanBerkas(berkas) {
  const JSZip = require(require.resolve('jszip', { paths: [require.resolve('pptxgenjs')] }));
  const zip = await JSZip.loadAsync(fs.readFileSync(berkas));

  const pTema = 'ppt/theme/theme1.xml';
  let tema = await zip.file(pTema).async('string');
  const slot = ['dk1', 'lt1', 'dk2', 'lt2', 'accent1', 'accent2', 'accent3', 'accent4', 'accent5', 'accent6', 'hlink', 'folHlink'];
  const isi = slot.map((k) => `<a:${k}><a:srgbClr val="${TEMA.colors[k]}"/></a:${k}>`).join('');
  tema = tema.replace(/<a:clrScheme name="[^"]*">[\s\S]*?<\/a:clrScheme>/, `<a:clrScheme name="${TEMA.name}">${isi}</a:clrScheme>`);
  tema = tema.replace(/(<a:theme\b[^>]*\bname=")[^"]*(")/, `$1${TEMA.name}$2`);
  zip.file(pTema, tema);

  const slides = Object.keys(zip.files).filter((f) => /^ppt\/slides\/slide\d+\.xml$/.test(f));
  for (const f of slides) {
    let xml = await zip.file(f).async('string');
    // pptxgenjs 4 menulis <a:pPr> untuk SETIAP potongan teks (run), sehingga
    // paragraf berisi beberapa run (kode berwarna, poin bercampur format)
    // memiliki <a:pPr> di tengah paragraf. Itu melanggar skema OOXML dan
    // bisa memicu "perbaikan berkas" di PowerPoint, serta menghapus bullet.
    // Pertahankan hanya <a:pPr> pertama yang berada di awal paragraf.
    const PPR = /<a:pPr\b[^>]*?(?:\/>|>[\s\S]*?<\/a:pPr>)/;
    xml = xml.replace(/<a:p>([\s\S]*?)<\/a:p>/g, (p, isi) => {
      let awal = '';
      const m = new RegExp(`^${PPR.source}`).exec(isi);
      if (m) {
        awal = m[0];
        isi = isi.slice(m[0].length);
      }
      return `<a:p>${awal}${isi.replace(new RegExp(PPR.source, 'g'), '')}</a:p>`;
    });
    xml = xml.replace(/<p:sp>[\s\S]*?<\/p:sp>/g, (sp) => {
      if (!/<p:cNvPr[^>]*>\s*<a:hlinkClick/.test(sp)) return sp;
      // Pertahankan hyperlink milik shape (di <p:cNvPr>), hapus hyperlink
      // tingkat teks beserta garis bawahnya.
      const akhirNv = sp.indexOf('</p:cNvPr>');
      const kepala = sp.slice(0, akhirNv);
      let badan = sp.slice(akhirNv);
      badan = badan.replace(/<a:hlinkClick\b[^>]*\/>/g, '');
      badan = badan.replace(/<a:hlinkClick\b[^>]*>[\s\S]*?<\/a:hlinkClick>/g, '');
      badan = badan.replace(/ u="sng"/g, '');
      return kepala + badan;
    });
    zip.file(f, xml);
  }

  const buf = await zip.generateAsync({ type: 'nodebuffer', compression: 'DEFLATE' });
  fs.writeFileSync(berkas, buf);
}

module.exports = { Dek, REPO, CABANG, TEMA, M, L, T, ATAS, BAWAH };

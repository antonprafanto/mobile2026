// =====================================================================
// GENERATOR SLIDE PERKULIAHAN (pptxgenjs)
// Menghasilkan berkas .pptx 16:9 untuk setiap pertemuan dari konten di
// folder ./konten, lalu menyimpannya ke <folder pertemuan>/slide/.
//
// Pemakaian (dari folder tools/slide):
//   npm install            (sekali saja)
//   node buat_slide.js      -> membuat semua slide
//   node buat_slide.js 01   -> hanya Pertemuan 01
// =====================================================================
const fs = require('fs');
const path = require('path');
const { Dek } = require('./desain');

function daftarKonten() {
  const folder = path.join(__dirname, 'konten');
  const hasil = {};
  for (const berkas of fs.readdirSync(folder).sort()) {
    const cocok = /^p(\d{2})\.js$/.exec(berkas);
    if (cocok) hasil[cocok[1]] = require(path.join(folder, berkas));
  }
  return hasil;
}

async function main() {
  const semua = daftarKonten();
  const argumen = process.argv[2] || 'semua';
  const pilihan = argumen === 'semua' ? Object.keys(semua) : [argumen.padStart(2, '0')];
  const folderRepo = path.resolve(__dirname, '..', '..');

  for (const nomor of pilihan) {
    const konten = semua[nomor];
    if (!konten) throw new Error(`Konten pertemuan ${nomor} tidak ditemukan di folder konten/`);
    const dek = new Dek(konten);
    konten.bangun(dek);
    const berkas = await dek.simpan(folderRepo);
    console.log(`✔ ${path.relative(folderRepo, berkas)}`);
  }
}

main().catch((galat) => {
  console.error(galat);
  process.exit(1);
});

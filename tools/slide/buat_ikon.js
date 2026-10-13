// =====================================================================
// PEMBUAT IKON SLIDE (opsional)
// Mengubah ikon Material Design (paket react-icons) menjadi PNG putih
// 256x256 di folder ./ikon. Hasilnya sudah ikut disimpan di repositori,
// jadi skrip ini HANYA perlu dijalankan jika Anda menambah ikon baru.
//
// Persiapan (sekali saja, di folder tools/slide):
//   npm install --no-save react react-dom react-icons sharp
// Menjalankan:
//   node buat_ikon.js
// =====================================================================
const fs = require('fs');
const path = require('path');
const React = require('react');
const { renderToStaticMarkup } = require('react-dom/server');
const sharp = require('sharp');
const md = require('react-icons/md');

// Nama berkas (tanpa .png) -> nama komponen ikon Material Design.
const DAFTAR_IKON = {
  hp: 'MdPhoneAndroid',
  sentuh: 'MdTouchApp',
  baterai: 'MdBatteryChargingFull',
  sinyal: 'MdSignalCellularAlt',
  sensor: 'MdSensors',
  pindah: 'MdSwapHoriz',
  kode: 'MdCode',
  perkakas: 'MdBuild',
  terminal: 'MdTerminal',
  folder: 'MdFolder',
  jalankan: 'MdPlayArrow',
  kilat: 'MdFlashOn',
  ulang: 'MdRestartAlt',
  centang: 'MdCheckCircle',
  galat: 'MdError',
  peringatan: 'MdWarning',
  lampu: 'MdLightbulb',
  topi: 'MdSchool',
  lapisan: 'MdLayers',
  palet: 'MdPalette',
  perangkat: 'MdDevices',
  cepat: 'MdSpeed',
  web: 'MdLanguage',
  memori: 'MdMemory',
  usb: 'MdUsb',
  komputer: 'MdComputer',
  widget: 'MdWidgets',
  pohon: 'MdAccountTree',
  tugas: 'MdAssignment',
  kuis: 'MdQuiz',
  buku: 'MdMenuBook',
  data: 'MdDataObject',
  fungsi: 'MdFunctions',
  putar: 'MdLoop',
  cabang: 'MdCallSplit',
  daftar: 'MdList',
  kotak: 'MdInventory2',
  tanya: 'MdHelpOutline',
  lihat: 'MdVisibility',
  jeda: 'MdPauseCircle',
  daya: 'MdPowerSettingsNew',
  serangga: 'MdBugReport',
  kuas: 'MdBrush',
  simpan: 'MdStorage',
  teks: 'MdTextFields',
  gembok: 'MdLock',
  hitung: 'MdCalculate',
  saring: 'MdFilterAlt',
  ubah: 'MdTransform',
  urut: 'MdSort',
  dokumen: 'MdDescription',
  riwayat: 'MdHistory',
  roket: 'MdRocketLaunch',
  kunci: 'MdKey',
  label: 'MdLabel',
  keranjang: 'MdShoppingCart',
  tabel: 'MdTableChart',
  banding: 'MdCompareArrows',
  masuk: 'MdInput',
  keluar: 'MdOutput',
  grup: 'MdGroups',
  setel: 'MdTune',
  bintang: 'MdAutoAwesome',
  unduh: 'MdDownload',
  orang: 'MdPerson',
  // Pertemuan 3
  kelas: 'MdClass',
  pabrik: 'MdFactory',
  puzzle: 'MdExtension',
  perisai: 'MdShield',
  jam: 'MdHourglassTop',
  aliran: 'MdStream',
  nomor: 'MdFormatListNumbered',
  // Pertemuan 4
  kolom: 'MdViewColumn',
  baris: 'MdTableRows',
  ukur: 'MdStraighten',
  bungkus: 'MdWrapText',
  gulir: 'MdSwipeVertical',
  dasbor: 'MdDashboard',
  rata: 'MdFormatAlignLeft',
  bingkai: 'MdBorderOuter',
  layarpas: 'MdFitScreen',
};

async function main() {
  const folderIkon = path.join(__dirname, 'ikon');
  fs.mkdirSync(folderIkon, { recursive: true });
  for (const [namaBerkas, namaKomponen] of Object.entries(DAFTAR_IKON)) {
    const Komponen = md[namaKomponen];
    if (!Komponen) throw new Error(`Ikon ${namaKomponen} tidak ditemukan`);
    const svg = renderToStaticMarkup(
      React.createElement(Komponen, { color: '#FFFFFF', size: 256 }),
    );
    await sharp(Buffer.from(svg))
      .resize(256, 256)
      .png()
      .toFile(path.join(folderIkon, `${namaBerkas}.png`));
  }
  console.log(`Selesai: ${Object.keys(DAFTAR_IKON).length} ikon di ${folderIkon}`);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - SIMULASI UTS
// BAHAN AWAL SIMULASI: "Sewa Alat Mapala"
// ---------------------------------------------------------------------
// Nama  : (isi nama lengkap)
// NIM   : (isi NIM)
// Paket : Simulasi
// Pernyataan: saya mengerjakan ini sendiri, tanpa bantuan orang lain
// dan tanpa asisten AI.
// ---------------------------------------------------------------------
// Simpan sebagai simulasi_nim_namapanggilan.dart (huruf kecil semua),
// misalnya simulasi_2609106001_rina.dart.
// =====================================================================
// CARA MEMAKAI:
// 1. Salin seluruh isi berkas ini ke lib/main.dart (atau DartPad).
// 2. Jalankan sekali. Jika layar menampilkan "Bahan siap: 8 alat",
//    bahan sudah terbaca dengan benar.
// 3. Ganti main() dan class HalamanMulai dengan aplikasi Anda. Bagian
//    BAHAN AWAL di bawahnya boleh dipakai apa adanya; jangan diubah.
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: HalamanMulai()));
}

// Hanya untuk memeriksa bahan. Hapus setelah Anda mulai mengerjakan.
class HalamanMulai extends StatelessWidget {
  const HalamanMulai({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Bahan siap: ${dataAwal.length} alat')),
    );
  }
}

// ===================== BAHAN AWAL =====================

enum JenisAlat {
  tenda('Tenda', Icons.cabin),
  tas('Tas', Icons.backpack),
  masak('Alat masak', Icons.outdoor_grill),
  tidur('Alat tidur', Icons.bed);

  const JenisAlat(this.label, this.ikon);

  final String label;
  final IconData ikon;
}

class Alat {
  const Alat({
    required this.id,
    required this.nama,
    required this.jenis,
    required this.hargaPerHari,
    required this.keterangan,
  });

  final int id;
  final String nama;
  final JenisAlat jenis;
  final int hargaPerHari;
  final String keterangan;
}

const List<Alat> dataAwal = [
  Alat(
    id: 1,
    nama: 'Tenda Dome 4 Orang',
    jenis: JenisAlat.tenda,
    hargaPerHari: 35000,
    keterangan: 'Muat 4 orang, lengkap dengan flysheet dan pasak.',
  ),
  Alat(
    id: 2,
    nama: 'Tenda Ultralight 2 Orang',
    jenis: JenisAlat.tenda,
    hargaPerHari: 30000,
    keterangan: 'Hanya 1,6 kg, cocok untuk pendakian jauh.',
  ),
  Alat(
    id: 3,
    nama: 'Carrier 60 Liter',
    jenis: JenisAlat.tas,
    hargaPerHari: 20000,
    keterangan: 'Dilengkapi pelindung hujan dan sabuk pinggang empuk.',
  ),
  Alat(
    id: 4,
    nama: 'Daypack 25 Liter',
    jenis: JenisAlat.tas,
    hargaPerHari: 10000,
    keterangan: 'Untuk perjalanan sehari atau menuju puncak.',
  ),
  Alat(
    id: 5,
    nama: 'Kompor Portabel',
    jenis: JenisAlat.masak,
    hargaPerHari: 15000,
    keterangan: 'Gas kaleng tidak termasuk. Bawa korek cadangan.',
  ),
  Alat(
    id: 6,
    nama: 'Nesting Set',
    jenis: JenisAlat.masak,
    hargaPerHari: 10000,
    keterangan: 'Panci, wajan, dan mangkuk untuk 2-3 orang.',
  ),
  Alat(
    id: 7,
    nama: 'Sleeping Bag',
    jenis: JenisAlat.tidur,
    hargaPerHari: 12000,
    keterangan: 'Tetap hangat sampai suhu 10 derajat Celsius.',
  ),
  Alat(
    id: 8,
    nama: 'Matras Gulung',
    jenis: JenisAlat.tidur,
    hargaPerHari: 5000,
    keterangan: 'Busa setebal 1 cm, ringan, dan tahan air.',
  ),
];

// Mengubah 15000 menjadi "Rp15.000".
String formatRupiah(int angka) {
  final String digit = angka.toString();
  String hasil = '';
  for (int i = 0; i < digit.length; i++) {
    final int sisaDiKanan = digit.length - i;
    if (i > 0 && sisaDiKanan % 3 == 0) {
      hasil += '.';
    }
    hasil += digit[i];
  }
  return 'Rp$hasil';
}

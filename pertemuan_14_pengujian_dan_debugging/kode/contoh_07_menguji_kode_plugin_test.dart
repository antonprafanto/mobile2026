// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 14: PENGUJIAN & DEBUGGING
// CONTOH 07: Menguji Kode yang Memakai Plugin
// Topik: Studi kasus "Presensi Praktikum" (Pertemuan 13) diuji TANPA
//        diubah satu baris pun, dan tanpa kamera maupun GPS:
//        1. Implementasi ASLI PemilihFotoImagePicker diuji dengan
//           ImagePicker PALSU (extends Fake implements ImagePicker), yang
//           disuntikkan lewat constructor-nya. Yang diperiksa: argumen ke
//           plugin dan terjemahan PlatformException menjadi Kegagalan.
//        2. Aturan domain diuji di nilai BATAS: jam buka/tutup presensi,
//           jarak 99/101 m, dan akurasi 50/51 m.
//        3. Use case CatatPresensi diuji dengan data palsu Pertemuan 13
//           (LayananLokasiPalsu, RepositoriPresensiMemori, jam tetap).
//        Tes memanggil kode PRODUKSI dari berkas lain lewat import,
//        persis seperti folder test/ mengimpor folder lib/.
// =====================================================================
// CARA MENJALANKAN (tidak bisa di DartPad, karena memakai image_picker):
// Terminal, dari folder utama repositori:
//    flutter test pertemuan_14_pengujian_dan_debugging/kode/contoh_07_menguji_kode_plugin_test.dart
// =====================================================================

import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';

// Kode yang diuji. Di proyek sungguhan baris ini berbentuk
//   import 'package:presensi_praktikum/data/services/pemilih_foto_image_picker.dart';
import '../../pertemuan_13_fitur_perangkat_dan_izin/kode/contoh_08_studi_kasus_presensi.dart';

// ========== BERKAS: testing/fakes/image_picker_palsu.dart ==========

/// ImagePicker PALSU. Hanya dua method yang dipakai PemilihFotoImagePicker
/// yang ditiru. Fake (dari flutter_test) membuat method lain melempar
/// UnimplementedError, sehingga kita tidak perlu menulis semuanya.
class ImagePickerPalsu extends Fake implements ImagePicker {
  // Jawaban yang diatur tes.
  XFile? hasil; // null = pengguna menekan "batal"
  PlatformException? galat;
  bool kameraAda = true;

  // Mata-mata: argumen panggilan terakhir.
  ImageSource? sumber;
  CameraDevice? kameraDipilih;
  double? lebarMaksimal;
  int? kualitas;
  bool? metadataLengkap;

  @override
  bool supportsImageSource(ImageSource source) {
    return source == ImageSource.gallery || kameraAda;
  }

  @override
  Future<XFile?> pickImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    bool requestFullMetadata = true,
  }) async {
    sumber = source;
    kameraDipilih = preferredCameraDevice;
    lebarMaksimal = maxWidth;
    kualitas = imageQuality;
    metadataLengkap = requestFullMetadata;
    final PlatformException? galatDiatur = galat;
    if (galatDiatur != null) throw galatDiatur;
    return hasil;
  }
}

/// Foto palsu tiga bita. Di Android dan desktop, nama berkas XFile diambil
/// dari path; di web dari name. Keduanya diisi agar hasilnya sama.
XFile fotoPalsu() => XFile.fromData(
  Uint8List.fromList([1, 2, 3]),
  path: 'selfie.jpg',
  name: 'selfie.jpg',
);

/// Matcher: Hasil yang Gagal dengan kegagalan tertentu.
Matcher gagalDengan(Matcher kegagalan) => isA<Gagal<Object?>>().having(
  (Gagal<Object?> g) => g.kegagalan,
  'kegagalan',
  kegagalan,
);

void main() {
  ujiPemilihFoto();
  ujiAturanPresensi();
  ujiCatatPresensi();
}

// ===== BERKAS: test/data/services/pemilih_foto_image_picker_test.dart =====
// (Di proyek, isi fungsi ini adalah isi main() berkas tersebut.)

void ujiPemilihFoto() {
  group('PemilihFotoImagePicker', () {
    late ImagePickerPalsu pemilih;
    late PemilihFotoImagePicker pemilihFoto;

    setUp(() {
      pemilih = ImagePickerPalsu();
      // Constructor Pertemuan 13 MENERIMA ImagePicker dari luar. Inilah
      // "pintu" yang membuat implementasi asli bisa diuji.
      pemilihFoto = PemilihFotoImagePicker(pemilih: pemilih);
    });

    test('kamera: kamera depan, lebar 720 px, kualitas 70', () async {
      pemilih.hasil = fotoPalsu();

      final Hasil<FotoBukti> hasil = await pemilihFoto.ambil(dariKamera: true);

      expect(hasil, isA<Berhasil<FotoBukti>>());
      final FotoBukti foto = (hasil as Berhasil<FotoBukti>).nilai;
      expect(foto.nama, 'selfie.jpg');
      expect(foto.bita, [1, 2, 3]);
      expect(pemilih.sumber, ImageSource.camera);
      expect(pemilih.kameraDipilih, CameraDevice.front);
      expect(pemilih.lebarMaksimal, 720);
      expect(pemilih.kualitas, 70);
      expect(pemilih.metadataLengkap, isFalse);
    });

    test('galeri: sumbernya ImageSource.gallery', () async {
      pemilih.hasil = fotoPalsu();

      await pemilihFoto.ambil(dariKamera: false);

      expect(pemilih.sumber, ImageSource.gallery);
    });

    test('pengguna membatalkan: Gagal(Dibatalkan)', () async {
      pemilih.hasil = null;

      final Hasil<FotoBukti> hasil = await pemilihFoto.ambil(dariKamera: true);

      expect(hasil, gagalDengan(isA<Dibatalkan>()));
    });

    // Tabel kasus: kode PlatformException -> Kegagalan milik aplikasi.
    final Map<String, Matcher> terjemahan = {
      'camera_access_denied': isA<IzinDiblokir>().having(
        (IzinDiblokir k) => k.fitur,
        'fitur',
        Fitur.kamera,
      ),
      'photo_access_denied': isA<IzinDiblokir>().having(
        (IzinDiblokir k) => k.fitur,
        'fitur',
        Fitur.galeri,
      ),
      'no_available_camera': isA<PerangkatTidakMendukung>().having(
        (PerangkatTidakMendukung k) => k.fitur,
        'fitur',
        Fitur.kamera,
      ),
      'already_active': isA<GangguanPerangkat>().having(
        (GangguanPerangkat k) => k.kode,
        'kode',
        'already_active',
      ),
    };
    terjemahan.forEach((String kode, Matcher harapan) {
      test('PlatformException "$kode" diterjemahkan', () async {
        pemilih.galat = PlatformException(code: kode);

        final Hasil<FotoBukti> hasil = await pemilihFoto.ambil(
          dariKamera: true,
        );

        expect(hasil, gagalDengan(harapan));
      });
    });

    test('kameraTersedia mengikuti supportsImageSource', () {
      expect(pemilihFoto.kameraTersedia, isTrue);
      pemilih.kameraAda = false;
      expect(pemilihFoto.kameraTersedia, isFalse);
    });
  });
}

// ====== BERKAS: test/domain/models/aturan_presensi_test.dart ======

void ujiAturanPresensi() {
  group('aturan presensi di nilai batas', () {
    // Sesi 13.00-15.30: presensi dibuka 12.45, ditutup 13.30.
    final SesiPraktikum sesi = SesiPraktikum(
      kode: 'BD-B',
      mataKuliah: 'Praktikum Basis Data',
      ruang: 'Lab Basis Data',
      titik: const Koordinat(-0.4712, 117.1595),
      mulai: DateTime(2026, 10, 19, 13),
      selesai: DateTime(2026, 10, 19, 15, 30),
    );

    DateTime pukul(int jam, int menit) => DateTime(2026, 10, 19, jam, menit);

    StatusSesi statusPukul(int jam, int menit) =>
        statusSesi(sesi, sekarang: pukul(jam, menit), sudahPresensi: false);

    /// Posisi [meter] di utara laboratorium.
    Posisi berjarak(double meter, {double akurasi = 8}) => Posisi(
      lintang: sesi.titik.lintang + meter / 6378137 * 180 / pi,
      bujur: sesi.titik.bujur,
      akurasiMeter: akurasi,
      waktu: pukul(13, 10),
    );

    test('12.44 belum dibuka, 12.45 sudah dibuka', () {
      expect(statusPukul(12, 44), StatusSesi.belumDibuka);
      expect(statusPukul(12, 45), StatusSesi.dibuka);
    });

    test('13.30 masih dibuka, 13.31 sudah ditutup', () {
      expect(statusPukul(13, 30), StatusSesi.dibuka);
      expect(statusPukul(13, 31), StatusSesi.ditutup);
    });

    test('99 m masih boleh, 101 m ditolak', () {
      expect(periksaLokasi(sesi: sesi, posisi: berjarak(99)), isNull);
      expect(
        periksaLokasi(sesi: sesi, posisi: berjarak(101)),
        contains('101 m dari Lab Basis Data'),
      );
    });

    test('akurasi 50 m masih boleh, 51 m ditolak', () {
      expect(
        periksaLokasi(sesi: sesi, posisi: berjarak(10, akurasi: 50)),
        isNull,
      );
      expect(
        periksaLokasi(sesi: sesi, posisi: berjarak(10, akurasi: 51)),
        contains('kurang akurat'),
      );
    });
  });
}

// ====== BERKAS: test/domain/use_cases/catat_presensi_test.dart ======

void ujiCatatPresensi() {
  group('CatatPresensi dengan data palsu', () {
    // Jam tetap: Senin, 19 Oktober 2026 pukul 13.10.
    final Jam jam = Jam(() => DateTime(2026, 10, 19, 13, 10));
    const Mahasiswa dimas = Mahasiswa(nim: '2609106021', nama: 'Dimas');
    final FotoBukti foto = FotoBukti(nama: 'selfie.jpg', bita: Uint8List(3));

    late LayananLokasiPalsu lokasi;
    late RepositoriPresensiMemori repositori;
    late CatatPresensi catat;
    late SesiPraktikum sesiLab;

    setUp(() async {
      lokasi = LayananLokasiPalsu();
      repositori = RepositoriPresensiMemori(jam: jam);
      catat = CatatPresensi(
        repositori: repositori,
        lokasi: lokasi,
        jam: jam,
        mahasiswa: dimas,
      );
      final Hasil<List<SesiPraktikum>> semuaSesi = await repositori
          .sesiHariIni();
      sesiLab = (semuaSesi as Berhasil<List<SesiPraktikum>>).nilai.firstWhere(
        (SesiPraktikum s) => s.kode == 'BD-B',
      );
    });

    Future<List<Presensi>> riwayatDimas() async {
      final Hasil<List<Presensi>> hasil = await repositori.riwayat(dimas.nim);
      return (hasil as Berhasil<List<Presensi>>).nilai;
    }

    test('di lab pukul 13.10: presensi tercatat', () async {
      final Hasil<Presensi> hasil = await catat.jalankan(
        sesi: sesiLab,
        foto: foto,
      );

      expect(hasil, isA<Berhasil<Presensi>>());
      expect(await riwayatDimas(), hasLength(1));
    });

    test('tanpa foto: ditolak dan GPS TIDAK dinyalakan', () async {
      final Hasil<Presensi> hasil = await catat.jalankan(
        sesi: sesiLab,
        foto: null,
      );

      expect(
        hasil,
        gagalDengan(
          isA<AturanDilanggar>().having(
            (AturanDilanggar k) => k.alasan,
            'alasan',
            'Ambil foto selfie terlebih dahulu.',
          ),
        ),
      );
      expect(lokasi.dipanggil, 0);
    });

    test('di luar area: ditolak dan tidak tersimpan', () async {
      lokasi.skenario = SkenarioLokasi.diLuar;

      final Hasil<Presensi> hasil = await catat.jalankan(
        sesi: sesiLab,
        foto: foto,
      );

      expect(hasil, gagalDengan(isA<AturanDilanggar>()));
      expect(await riwayatDimas(), isEmpty);
    });

    test('pemalsu GPS ditolak', () async {
      lokasi.skenario = SkenarioLokasi.pemalsuGps;

      final Hasil<Presensi> hasil = await catat.jalankan(
        sesi: sesiLab,
        foto: foto,
      );

      expect(
        hasil,
        gagalDengan(
          isA<AturanDilanggar>().having(
            (AturanDilanggar k) => k.alasan,
            'alasan',
            startsWith('Lokasi palsu terdeteksi'),
          ),
        ),
      );
    });

    test('izin lokasi diblokir diteruskan ke ViewModel apa adanya', () async {
      lokasi.skenario = SkenarioLokasi.izinDiblokir;

      final Hasil<Presensi> hasil = await catat.jalankan(
        sesi: sesiLab,
        foto: foto,
      );

      expect(hasil, gagalDengan(isA<IzinDiblokir>()));
    });

    test('presensi kedua ditolak tanpa meminta lokasi lagi', () async {
      await catat.jalankan(sesi: sesiLab, foto: foto);
      expect(lokasi.dipanggil, 1);

      final Hasil<Presensi> kedua = await catat.jalankan(
        sesi: sesiLab,
        foto: foto,
      );

      expect(kedua, gagalDengan(isA<AturanDilanggar>()));
      expect(lokasi.dipanggil, 1);
      expect(await riwayatDimas(), hasLength(1));
    });
  });
}

// HASIL (baris terakhir; angka waktu di depannya bisa berbeda):
// 00:07 +18: All tests passed!

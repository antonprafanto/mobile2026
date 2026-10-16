// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 14: PENGUJIAN & DEBUGGING
// CONTOH 03: Menguji Kode Asinkron
// Topik: "Bus Kampus": jadwal bus diambil dari server, lalu posisi bus
//        diikuti lewat Stream. Yang diuji:
//        - tes async: test('...', () async { ... await ... });
//        - repository yang menerjemahkan exception menjadi Kegagalan
//          (Pertemuan 12), dengan server palsu MockClient (Pertemuan 10);
//        - Future yang DIHARAPKAN gagal: await expectLater(..., throwsA());
//        - Stream: emitsInOrder([...]), emitsDone, dan emitsError(...).
//        Semua berjalan tanpa internet dan selesai dalam sekejap.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
//    Hasil tes tampil di panel Console.
// B. Terminal, dari folder utama repositori:
//    flutter test pertemuan_14_pengujian_dan_debugging/kode/contoh_03_menguji_kode_asinkron_test.dart
// =====================================================================

import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

// ===================== BERKAS: lib/domain/hasil.dart =====================

sealed class Hasil<T> {
  const Hasil();
}

final class Berhasil<T> extends Hasil<T> {
  const Berhasil(this.nilai);

  final T nilai;
}

final class Gagal<T> extends Hasil<T> {
  const Gagal(this.kegagalan);

  final Kegagalan kegagalan;
}

sealed class Kegagalan {
  const Kegagalan();
}

final class TanpaKoneksi extends Kegagalan {
  const TanpaKoneksi();
}

final class WaktuHabis extends Kegagalan {
  const WaktuHabis();
}

final class ServerBermasalah extends Kegagalan {
  const ServerBermasalah(this.kodeStatus);

  final int kodeStatus;
}

final class DataRusak extends Kegagalan {
  const DataRusak();
}

// ================ BERKAS: lib/domain/models/jadwal_bus.dart ================

class JadwalBus {
  const JadwalBus({
    required this.rute,
    required this.berangkat,
    required this.halteAwal,
  });

  final String rute;
  final String berangkat; // jam, misalnya '07.15'
  final String halteAwal;
}

// ============== BERKAS: lib/domain/status_kedatangan.dart ==============

/// Mengubah aliran "sisa halte" (dari GPS bus) menjadi kalimat untuk
/// penumpang. Aliran berhenti setelah bus tiba.
Stream<String> statusKedatangan(Stream<int> sisaHalte) async* {
  await for (final int sisa in sisaHalte) {
    if (sisa < 0) {
      throw ArgumentError.value(sisa, 'sisa', 'tidak boleh negatif');
    }
    if (sisa == 0) {
      yield 'Bus tiba. Silakan naik!';
      return; // aliran selesai, data berikutnya diabaikan
    }
    yield sisa == 1 ? 'Bus 1 halte lagi. Bersiaplah!' : 'Bus $sisa halte lagi';
  }
}

// =============== BERKAS: lib/data/services/layanan_bus.dart ===============

class ApiException implements Exception {
  const ApiException(this.kodeStatus);

  final int kodeStatus;

  @override
  String toString() => 'ApiException: kode status $kodeStatus';
}

class LayananBus {
  // Klien HTTP disuntikkan: aplikasi memberi http.Client(), tes memberi
  // MockClient. Tanpa suntikan ini, layanan tidak bisa diuji tanpa
  // internet.
  LayananBus({required this._klien});

  static final Uri alamat = Uri.https('api.kampus.example', '/bus/jadwal');
  static const Duration batasWaktu = Duration(seconds: 10);

  final http.Client _klien;

  Future<Object?> ambilJadwal() async {
    final http.Response respons = await _klien.get(alamat).timeout(batasWaktu);
    if (respons.statusCode != 200) {
      throw ApiException(respons.statusCode);
    }
    return jsonDecode(respons.body);
  }
}

// =========== BERKAS: lib/data/repositories/repositori_bus.dart ===========

class RepositoriBus {
  RepositoriBus({required this._layanan});

  final LayananBus _layanan;

  // Satu-satunya penerjemah: exception teknis -> Kegagalan milik domain.
  Future<Hasil<List<JadwalBus>>> jadwalHariIni() async {
    try {
      final Object? json = await _layanan.ambilJadwal();
      final List<JadwalBus> daftar = switch (json) {
        {'jadwal': final List<Object?> isi} => isi.map(_dariJson).toList(),
        _ => throw const FormatException('Kolom jadwal tidak ditemukan'),
      };
      return Berhasil(daftar);
    } on TimeoutException {
      return const Gagal(WaktuHabis());
    } on http.ClientException {
      return const Gagal(TanpaKoneksi());
    } on ApiException catch (galat) {
      return Gagal(ServerBermasalah(galat.kodeStatus));
    } on FormatException {
      return const Gagal(DataRusak());
    }
  }

  JadwalBus _dariJson(Object? json) {
    return switch (json) {
      {
        'rute': final String rute,
        'berangkat': final String berangkat,
        'halte_awal': final String halteAwal,
      } =>
        JadwalBus(rute: rute, berangkat: berangkat, halteAwal: halteAwal),
      _ => throw FormatException('Jadwal tidak sesuai: $json'),
    };
  }
}

// ============ BERKAS: test/data/repositori_bus_test.dart ============

const String jsonContoh = '''
{
  "jadwal": [
    {"rute": "Gerbang Utama - Fakultas Teknik", "berangkat": "07.15",
     "halte_awal": "Gerbang Utama"},
    {"rute": "Asrama - Perpustakaan", "berangkat": "07.30",
     "halte_awal": "Asrama Putri"}
  ]
}
''';

/// Server palsu yang menjawab dengan [jawab], lalu kegagalan yang
/// dihasilkan repository (null jika berhasil).
Future<Kegagalan?> kegagalanDari(MockClientHandler jawab) async {
  final RepositoriBus repositori = RepositoriBus(
    layanan: LayananBus(klien: MockClient(jawab)),
  );
  final Hasil<List<JadwalBus>> hasil = await repositori.jadwalHariIni();
  return switch (hasil) {
    Berhasil() => null,
    Gagal(:final Kegagalan kegagalan) => kegagalan,
  };
}

void main() {
  group('RepositoriBus', () {
    // Fungsi tes diberi async, lalu Future di dalamnya ditunggu dengan
    // await. Tanpa await, tes selesai SEBELUM hasilnya diperiksa.
    test('JSON yang benar menjadi daftar jadwal', () async {
      final RepositoriBus repositori = RepositoriBus(
        layanan: LayananBus(
          klien: MockClient(
            (http.Request permintaan) async => http.Response(jsonContoh, 200),
          ),
        ),
      );

      final Hasil<List<JadwalBus>> hasil = await repositori.jadwalHariIni();

      expect(hasil, isA<Berhasil<List<JadwalBus>>>());
      final List<JadwalBus> daftar = (hasil as Berhasil<List<JadwalBus>>).nilai;
      expect(daftar, hasLength(2));
      expect(daftar.first.rute, 'Gerbang Utama - Fakultas Teknik');
      expect(daftar.last.berangkat, '07.30');
    });

    test('permintaan dikirim dengan GET ke alamat jadwal', () async {
      // Server palsu juga bisa MENCATAT permintaan yang diterimanya.
      final List<http.Request> tercatat = [];
      final RepositoriBus repositori = RepositoriBus(
        layanan: LayananBus(
          klien: MockClient((http.Request permintaan) async {
            tercatat.add(permintaan);
            return http.Response(jsonContoh, 200);
          }),
        ),
      );

      await repositori.jadwalHariIni();

      expect(tercatat, hasLength(1));
      expect(tercatat.single.method, 'GET');
      expect(tercatat.single.url.path, '/bus/jadwal');
    });

    test('kode 500 menjadi ServerBermasalah(500)', () async {
      final Kegagalan? kegagalan = await kegagalanDari(
        (http.Request _) async => http.Response('Galat server', 500),
      );
      expect(
        kegagalan,
        isA<ServerBermasalah>().having(
          (ServerBermasalah k) => k.kodeStatus,
          'kodeStatus',
          500,
        ),
      );
    });

    test('koneksi putus menjadi TanpaKoneksi', () async {
      final Kegagalan? kegagalan = await kegagalanDari(
        (http.Request _) async => throw http.ClientException('Terputus'),
      );
      expect(kegagalan, isA<TanpaKoneksi>());
    });

    test('server terlalu lama menjadi WaktuHabis', () async {
      final Kegagalan? kegagalan = await kegagalanDari(
        (http.Request _) async => throw TimeoutException('Terlalu lama'),
      );
      expect(kegagalan, isA<WaktuHabis>());
    });

    test('jawaban bukan JSON menjadi DataRusak', () async {
      final Kegagalan? kegagalan = await kegagalanDari(
        (http.Request _) async => http.Response('<html>Perbaikan</html>', 200),
      );
      expect(kegagalan, isA<DataRusak>());
    });

    test('kolom jadwal tidak ada menjadi DataRusak', () async {
      final Kegagalan? kegagalan = await kegagalanDari(
        (http.Request _) async => http.Response('{"data": []}', 200),
      );
      expect(kegagalan, isA<DataRusak>());
    });
  });

  group('LayananBus', () {
    test('kode 404 dilempar sebagai ApiException', () async {
      final LayananBus layanan = LayananBus(
        klien: MockClient((http.Request _) async => http.Response('', 404)),
      );

      // Future yang DIHARAPKAN gagal diperiksa dengan expectLater, lalu
      // ditunggu dengan await.
      await expectLater(
        layanan.ambilJadwal(),
        throwsA(
          isA<ApiException>().having(
            (ApiException e) => e.kodeStatus,
            'kodeStatus',
            404,
          ),
        ),
      );
    });

    test('kode 200 dikembalikan sebagai JSON', () async {
      final LayananBus layanan = LayananBus(
        klien: MockClient(
          (http.Request _) async => http.Response('{"jadwal": []}', 200),
        ),
      );

      await expectLater(
        layanan.ambilJadwal(),
        completion(equals({'jadwal': []})),
      );
    });
  });

  group('statusKedatangan()', () {
    test('menghitung mundur sampai bus tiba', () async {
      // Stream.fromIterable: aliran palsu dengan data yang kita tentukan.
      await expectLater(
        statusKedatangan(Stream<int>.fromIterable([3, 2, 1, 0])),
        emitsInOrder([
          'Bus 3 halte lagi',
          'Bus 2 halte lagi',
          'Bus 1 halte lagi. Bersiaplah!',
          'Bus tiba. Silakan naik!',
          emitsDone, // lalu aliran selesai
        ]),
      );
    });

    test('berhenti setelah bus tiba walaupun data masih datang', () async {
      await expectLater(
        statusKedatangan(Stream<int>.fromIterable([1, 0, 5])),
        emitsInOrder([
          'Bus 1 halte lagi. Bersiaplah!',
          'Bus tiba. Silakan naik!',
          emitsDone,
        ]),
      );
    });

    test('angka negatif menjadi galat di dalam aliran', () async {
      await expectLater(
        statusKedatangan(Stream<int>.fromIterable([2, -1])),
        emitsInOrder(['Bus 2 halte lagi', emitsError(isArgumentError)]),
      );
    });
  });
}

// HASIL di DartPad (panel Console), diringkas:
// 00:00 +0: RepositoriBus JSON yang benar menjadi daftar jadwal
// ...
// 00:00 +7: LayananBus kode 404 dilempar sebagai ApiException
// ...
// 00:00 +12: All tests passed!

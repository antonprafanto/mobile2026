// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 12: CLEAN ARCHITECTURE
// CONTOH 04: Model API, Model Domain, dan Pemetaan
// Topik: Server punya "bahasa" sendiri: nama kolom berbahasa Inggris,
//        kode fasilitas seperti "air_conditioner", dan kolom is_active.
//        Aplikasi juga punya bahasa sendiri: entitas Ruang. Lapisan data
//        menjadi penerjemahnya:
//        1. teks JSON -> RuangApiModel (bentuknya mengikuti server);
//        2. RuangApiModel -> Ruang (bentuknya mengikuti kebutuhan
//           aplikasi), dengan ruang tidak aktif dan fasilitas yang belum
//           dikenal disaring di sini;
//        3. server versi 2 mengganti nama kolom: cukup satu model API
//           baru, sedangkan entitas dan semua kode di atasnya tetap;
//        4. arah sebaliknya: data aplikasi -> JSON untuk dikirim;
//        5. data rusak berhenti di lapisan data (FormatException).
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_04_model_api_dan_pemetaan.dart
// =====================================================================

// Ini program konsol, jadi print() boleh dipakai. Di aplikasi Flutter
// kita tetap memakai debugPrint(), karena itu aturan avoid_print hanya
// dimatikan untuk berkas ini.
// ignore_for_file: avoid_print

import 'dart:convert';

// ======================= DOMAIN (milik aplikasi) =======================

enum Fasilitas {
  proyektor('Proyektor'),
  pendinginRuangan('AC'),
  komputer('Komputer'),
  papanTulis('Papan tulis'),
  pengerasSuara('Pengeras suara');

  const Fasilitas(this.label);

  final String label;
}

class Ruang {
  const Ruang({
    required this.kode,
    required this.nama,
    required this.gedung,
    required this.lantai,
    required this.kapasitas,
    required this.fasilitas,
  });

  final String kode;
  final String nama;
  final String gedung;
  final int lantai;
  final int kapasitas;
  final List<Fasilitas> fasilitas;

  String get ringkasan =>
      '$kode | $nama | $gedung, lantai $lantai | $kapasitas orang | '
      '${fasilitas.map((Fasilitas f) => f.label).join(', ')}';
}

class PengajuanPeminjaman {
  const PengajuanPeminjaman({
    required this.kodeRuang,
    required this.keperluan,
    required this.jumlahPeserta,
    required this.mulai,
    required this.selesai,
  });

  final String kodeRuang;
  final String keperluan;
  final int jumlahPeserta;
  final DateTime mulai;
  final DateTime selesai;
}

// ===================== DATA (penerjemah untuk server) =====================

const Map<String, Fasilitas> petaFasilitas = {
  'projector': Fasilitas.proyektor,
  'air_conditioner': Fasilitas.pendinginRuangan,
  'computer': Fasilitas.komputer,
  'whiteboard': Fasilitas.papanTulis,
  'sound_system': Fasilitas.pengerasSuara,
};

// Model API versi 1: nama field mengikuti kolom server.
class RuangApiModel {
  const RuangApiModel({
    required this.roomCode,
    required this.roomName,
    required this.building,
    required this.floor,
    required this.capacity,
    required this.facilities,
    required this.isActive,
  });

  final String roomCode;
  final String roomName;
  final String building;
  final int floor;
  final int capacity;
  final List<String> facilities;
  final bool isActive;

  factory RuangApiModel.fromJson(Object? json) {
    return switch (json) {
      {
        'room_code': final String roomCode,
        'room_name': final String roomName,
        'building': final String building,
        'floor': final int floor,
        'capacity': final int capacity,
        'facilities': final List<Object?> facilities,
        'is_active': final bool isActive,
      } =>
        RuangApiModel(
          roomCode: roomCode,
          roomName: roomName,
          building: building,
          floor: floor,
          capacity: capacity,
          facilities: facilities.whereType<String>().toList(),
          isActive: isActive,
        ),
      _ => throw const FormatException('Data ruang tidak sesuai'),
    };
  }

  Ruang keDomain() {
    return Ruang(
      kode: roomCode,
      nama: roomName,
      gedung: 'Gedung $building',
      lantai: floor,
      kapasitas: capacity,
      fasilitas: [for (final String f in facilities) ?petaFasilitas[f]],
    );
  }
}

// Model API versi 2: server mengganti nama dan bentuk kolomnya.
class RuangApiModelV2 {
  const RuangApiModelV2({
    required this.code,
    required this.name,
    required this.building,
    required this.floor,
    required this.seats,
    required this.amenities,
    required this.status,
  });

  final String code;
  final String name;
  final String building;
  final int floor;
  final int seats;
  final List<String> amenities;
  final String status;

  factory RuangApiModelV2.fromJson(Object? json) {
    return switch (json) {
      {
        'code': final String code,
        'name': final String name,
        'location': {
          'building': final String building,
          'floor': final int floor,
        },
        'seats': final int seats,
        'amenities': final List<Object?> amenities,
        'status': final String status,
      } =>
        RuangApiModelV2(
          code: code,
          name: name,
          building: building,
          floor: floor,
          seats: seats,
          amenities: amenities.whereType<String>().toList(),
          status: status,
        ),
      _ => throw const FormatException('Data ruang v2 tidak sesuai'),
    };
  }

  bool get aktif => status == 'active';

  Ruang keDomain() {
    return Ruang(
      kode: code,
      nama: name,
      gedung: 'Gedung $building',
      lantai: floor,
      kapasitas: seats,
      fasilitas: [for (final String f in amenities) ?petaFasilitas[f]],
    );
  }
}

// Arah sebaliknya: data aplikasi -> bentuk yang diminta server.
Map<String, Object?> pengajuanKeJson(PengajuanPeminjaman p) {
  return {
    'room_code': p.kodeRuang,
    'purpose': p.keperluan,
    'participants': p.jumlahPeserta,
    'start_time': p.mulai.toIso8601String(),
    'end_time': p.selesai.toIso8601String(),
  };
}

// ============================== PROGRAM ==============================

const String jsonVersi1 = '''
{"rooms": [
  {"room_code": "LAB-1", "room_name": "Laboratorium Komputer 1",
   "building": "B", "floor": 2, "capacity": 40,
   "facilities": ["projector", "air_conditioner", "computer"],
   "is_active": true},
  {"room_code": "AULA", "room_name": "Aula Fakultas",
   "building": "A", "floor": 1, "capacity": 200,
   "facilities": ["projector", "air_conditioner", "sound_system", "stage"],
   "is_active": true},
  {"room_code": "STUDIO", "room_name": "Studio Multimedia",
   "building": "C", "floor": 2, "capacity": 15,
   "facilities": ["computer"], "is_active": false}
]}
''';

const String jsonVersi2 = '''
{"data": [
  {"code": "LAB-1", "name": "Laboratorium Komputer 1",
   "location": {"building": "B", "floor": 2}, "seats": 40,
   "amenities": ["projector", "air_conditioner", "computer"],
   "status": "active"}
]}
''';

void main() {
  print('=== 1. JSON server -> model API ===');
  final List<RuangApiModel> modelApi = switch (jsonDecode(jsonVersi1)) {
    {'rooms': final List<Object?> rooms} =>
      rooms.map(RuangApiModel.fromJson).toList(),
    _ => throw const FormatException('Kolom rooms tidak ada'),
  };
  print('Jumlah baris di JSON: ${modelApi.length}');
  final RuangApiModel pertama = modelApi.first;
  print(
    'Model API pertama: room_code=${pertama.roomCode}, '
    'building=${pertama.building}, facilities=${pertama.facilities}',
  );
  print('');

  print('=== 2. Model API -> entitas domain ===');
  final List<Ruang> daftar = [
    for (final RuangApiModel m in modelApi)
      if (m.isActive) m.keDomain(),
  ];
  for (final Ruang r in daftar) {
    print(r.ringkasan);
  }
  print('STUDIO tidak aktif, jadi tidak ikut.');
  print('Fasilitas "stage" belum dikenal aplikasi, jadi dilewati.');
  print('');

  print('=== 3. Server versi 2 mengganti nama kolom ===');
  final List<Ruang> daftarV2 = switch (jsonDecode(jsonVersi2)) {
    {'data': final List<Object?> data} => [
      for (final RuangApiModelV2 m in data.map(RuangApiModelV2.fromJson))
        if (m.aktif) m.keDomain(),
    ],
    _ => throw const FormatException('Kolom data tidak ada'),
  };
  print(daftarV2.first.ringkasan);
  print(
    'Entitas dari versi 1 dan versi 2 sama: '
    '${daftar.first.ringkasan == daftarV2.first.ringkasan}',
  );
  print('');

  print('=== 4. Data aplikasi -> JSON untuk dikirim ===');
  final PengajuanPeminjaman pengajuan = PengajuanPeminjaman(
    kodeRuang: 'C-105',
    keperluan: 'Seminar Proposal',
    jumlahPeserta: 60,
    mulai: DateTime(2026, 10, 19, 9),
    selesai: DateTime(2026, 10, 19, 11),
  );
  print(jsonEncode(pengajuanKeJson(pengajuan)));
  print('');

  print('=== 5. Data rusak berhenti di lapisan data ===');
  try {
    RuangApiModel.fromJson(
      jsonDecode(
        '{"room_code": "X-1", "room_name": "Uji", "building": "A", '
        '"floor": 1, "capacity": "empat puluh", "facilities": [], '
        '"is_active": true}',
      ),
    );
  } on FormatException catch (galat) {
    print('Kapasitas berupa teks -> FormatException: ${galat.message}');
  }
}

// OUTPUT:
// === 1. JSON server -> model API ===
// Jumlah baris di JSON: 3
// Model API pertama: room_code=LAB-1, building=B, facilities=[projector, air_conditioner, computer]
//
// === 2. Model API -> entitas domain ===
// LAB-1 | Laboratorium Komputer 1 | Gedung B, lantai 2 | 40 orang | Proyektor, AC, Komputer
// AULA | Aula Fakultas | Gedung A, lantai 1 | 200 orang | Proyektor, AC, Pengeras suara
// STUDIO tidak aktif, jadi tidak ikut.
// Fasilitas "stage" belum dikenal aplikasi, jadi dilewati.
//
// === 3. Server versi 2 mengganti nama kolom ===
// LAB-1 | Laboratorium Komputer 1 | Gedung B, lantai 2 | 40 orang | Proyektor, AC, Komputer
// Entitas dari versi 1 dan versi 2 sama: true
//
// === 4. Data aplikasi -> JSON untuk dikirim ===
// {"room_code":"C-105","purpose":"Seminar Proposal","participants":60,"start_time":"2026-10-19T09:00:00.000","end_time":"2026-10-19T11:00:00.000"}
//
// === 5. Data rusak berhenti di lapisan data ===
// Kapasitas berupa teks -> FormatException: Data ruang tidak sesuai

// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 10: ASINKRON & REST API
// CONTOH 03: Dari Teks JSON Menjadi Objek Dart (dan Sebaliknya)
// Topik: Data dari REST API datang sebagai TEKS berformat JSON. Program
//        konsol ini (tanpa internet) menunjukkan empat langkah:
//        1. jsonDecode(): teks JSON -> Map/List;
//        2. factory fromJson(): Map -> objek model, sekaligus memeriksa
//           bentuk datanya dengan pola (pattern) Dart 3;
//        3. menangani data yang bentuknya salah (FormatException);
//        4. toJson() + jsonEncode(): objek -> teks JSON, untuk dikirim.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_03_json_dan_model.dart
// =====================================================================

// Ini program konsol, jadi print() boleh dipakai. Di aplikasi Flutter
// kita tetap memakai debugPrint(), karena itu aturan avoid_print hanya
// dimatikan untuk berkas ini.
// ignore_for_file: avoid_print

import 'dart:convert';

// Teks JSON yang bentuknya sama dengan jawaban
// https://dummyjson.com/products?limit=3&select=title,price,stock,rating
// (isinya dipersingkat agar mudah dibaca).
const String teksJson = '''
{
  "products": [
    {"id": 1, "title": "Mascara Lash Princess", "price": 9.99, "stock": 99, "rating": 2.56},
    {"id": 2, "title": "Eyeshadow Palette", "price": 19.99, "stock": 34, "rating": 2.86},
    {"id": 3, "title": "Powder Canister", "price": 15, "stock": 89, "rating": 4.64}
  ],
  "total": 194,
  "skip": 0,
  "limit": 3
}
''';

class Produk {
  const Produk({
    required this.id,
    required this.judul,
    required this.harga,
    required this.stok,
    required this.rating,
  });

  // Map hasil jsonDecode -> objek Produk.
  // Pola map di bawah sekaligus MEMERIKSA bentuk data: setiap kunci harus
  // ada dan tipenya harus cocok. Jika tidak, yang dipakai cabang `_`.
  // Harga memakai pola `num`, karena di JSON angka 15 dibaca sebagai int,
  // sedangkan 9.99 dibaca sebagai double. toDouble() menyeragamkannya.
  factory Produk.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'title': String judul,
        'price': num harga,
        'stock': int stok,
        'rating': num rating,
      } =>
        Produk(
          id: id,
          judul: judul,
          harga: harga.toDouble(),
          stok: stok,
          rating: rating.toDouble(),
        ),
      _ => throw const FormatException('Bentuk data produk tidak sesuai'),
    };
  }

  final int id;
  final String judul;
  final double harga;
  final int stok;
  final double rating;

  // Objek -> Map, siap diubah menjadi teks JSON dengan jsonEncode().
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': judul,
    'price': harga,
    'stock': stok,
    'rating': rating,
  };
}

void main() {
  print('=== 1. Teks JSON -> Map ===');
  final Object? hasil = jsonDecode(teksJson);
  print('Hasil jsonDecode adalah Map: ${hasil is Map<String, dynamic>}');
  final Map<String, dynamic> data = hasil as Map<String, dynamic>;
  print('Kunci tingkat atas: ${data.keys.toList()}');

  // Membaca sebuah List di dalam Map, juga dengan pola.
  final List<Produk> daftar = switch (data) {
    {'products': List<dynamic> isi} =>
      isi
          .map((dynamic item) => Produk.fromJson(item as Map<String, dynamic>))
          .toList(),
    _ => throw const FormatException('Kunci "products" tidak ditemukan'),
  };
  print('Produk di server: ${data['total']}, diambil: ${daftar.length}');

  print('');
  print('=== 2. Map -> objek Produk ===');
  double nilaiStok = 0;
  for (final Produk produk in daftar) {
    print(
      '#${produk.id} ${produk.judul} | \$${produk.harga.toStringAsFixed(2)}'
      ' | stok ${produk.stok} | rating ${produk.rating}',
    );
    nilaiStok += produk.harga * produk.stok;
  }
  print('Nilai seluruh stok: \$${nilaiStok.toStringAsFixed(2)}');

  print('');
  print('=== 3. Data yang bentuknya salah ===');
  const Map<String, String> dataRusak = {
    'Harga berupa teks': '{"id": 4, "title": "Pulpen", "price": "9.99", "stock": 5, "rating": 4.1}',
    'Kolom tidak lengkap': '{"id": 5, "title": "Buku Tulis"}',
  };
  dataRusak.forEach((String keterangan, String teks) {
    try {
      Produk.fromJson(jsonDecode(teks) as Map<String, dynamic>);
      print('$keterangan -> berhasil (tidak terduga!)');
    } on FormatException catch (galat) {
      print('$keterangan -> FormatException: ${galat.message}');
    }
  });

  try {
    // Koma terakhir sebelum } membuat teks ini bukan JSON yang sah.
    jsonDecode('{"id": 6, "title": "Penghapus",}');
  } on FormatException {
    print('Teks bukan JSON yang sah -> FormatException');
  }

  // Salah tulis nama kunci tidak menimbulkan error, tetapi hasilnya null.
  final Object? salahKunci = data['produk'];
  print('Salah tulis kunci "produk" -> hasilnya $salahKunci, bukan List');

  print('');
  print('=== 4. Objek Produk -> teks JSON ===');
  print(jsonEncode(daftar.first.toJson()));
}

// OUTPUT:
// === 1. Teks JSON -> Map ===
// Hasil jsonDecode adalah Map: true
// Kunci tingkat atas: [products, total, skip, limit]
// Produk di server: 194, diambil: 3
//
// === 2. Map -> objek Produk ===
// #1 Mascara Lash Princess | $9.99 | stok 99 | rating 2.56
// #2 Eyeshadow Palette | $19.99 | stok 34 | rating 2.86
// #3 Powder Canister | $15.00 | stok 89 | rating 4.64
// Nilai seluruh stok: $3003.67
//
// === 3. Data yang bentuknya salah ===
// Harga berupa teks -> FormatException: Bentuk data produk tidak sesuai
// Kolom tidak lengkap -> FormatException: Bentuk data produk tidak sesuai
// Teks bukan JSON yang sah -> FormatException
// Salah tulis kunci "produk" -> hasilnya null, bukan List
//
// === 4. Objek Produk -> teks JSON ===
// {"id":1,"title":"Mascara Lash Princess","price":9.99,"stock":99,"rating":2.56}

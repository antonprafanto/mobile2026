# MODUL PRAKTIKUM 04: RESTful API (DIO) & PERSISTENSI DATA LURING
## Laboratorium Rekayasa Perangkat Lunak - Teknik Informatika

---

## 1. Tujuan Pembelajaran
1. Mahasiswa mampu mengintegrasikan layanan *RESTful API* menggunakan library **Dio** dengan konfigurasi interceptor dan batas waktu (*timeout*).
2. Mahasiswa mampu memetakan respons JSON ke model objek Dart menggunakan serialisasi tipe data yang aman.
3. Mahasiswa mampu mengimplementasikan strategi penyimpanan lokal (*Local Persistence*) untuk mewujudkan arsitektur *Offline-First*.

---

## 2. Langkah Kerja Terpandu

### Bagian A: Menghubungkan API dengan Dio & Error Handling
Gunakan endpoint pengujian publik (seperti `https://jsonplaceholder.typicode.com/posts`):

```dart
import 'package:dio/dio.dart';

class PostModel {
  final int id;
  final String title;
  final String body;

  PostModel({required this.id, required this.title, required this.body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}

class PostRemoteDataSource {
  final Dio dio;
  PostRemoteDataSource(this.dio);

  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await dio.get('/posts');
      final data = response.data as List;
      return data.map((json) => PostModel.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Koneksi internet lambat / timeout');
      } else if (e.response?.statusCode == 404) {
        throw Exception('Data tidak ditemukan di server');
      } else {
        throw Exception('Terjadi gangguan jaringan: ${e.message}');
      }
    }
  }
}
```

---

### Bagian B: Strategi Caching Data Luring (*Offline-First*)
Simpan data terakhir ke dalam `SharedPreferences` dalam bentuk string JSON agar aplikasi tetap dapat menampilkan data saat pengguna menyalakan *Airplane Mode*:

```dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PostRepository {
  final PostRemoteDataSource remoteSource;
  static const _cacheKey = 'CACHED_POSTS';

  PostRepository(this.remoteSource);

  Future<List<PostModel>> getPosts() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      // 1. Coba ambil dari remote API
      final remotePosts = await remoteSource.fetchPosts();
      
      // 2. Simpan salinan ke cache lokal
      final rawJson = jsonEncode(remotePosts.map((p) => {'id': p.id, 'title': p.title, 'body': p.body}).toList());
      await prefs.setString(_cacheKey, rawJson);
      
      return remotePosts;
    } catch (e) {
      // 3. Jika jaringan gagal, gunakan data cache lokal
      final cachedData = prefs.getString(_cacheKey);
      if (cachedData != null) {
        final List decoded = jsonDecode(cachedData);
        return decoded.map((item) => PostModel.fromJson(item as Map<String, dynamic>)).toList();
      }
      rethrow; // Jika cache kosong dan jaringan gagal, baru lemparkan error
    }
  }
}
```

---

## 3. Tugas Latihan Mandiri (Graded Lab Task)

> **Tantangan Praktikum 4:**
> 1. Buat halaman daftar artikel berita yang mengonsumsi endpoint berita publik.
> 2. Buat status Cubit yang menangani: `PostsLoading`, `PostsLoaded(List<Post> posts, bool isFromCache)`, dan `PostsError(String message)`.
> 3. Jika data dimuat dari cache lokal (offline), tampilkan *Banner/Badge* kuning di bagian atas: *"Mode Offline: Menampilkan data tersimpan"*.
> 4. Sediakan tombol *Pull-to-Refresh* (`RefreshIndicator`) untuk memperbarui data saat internet kembali online.

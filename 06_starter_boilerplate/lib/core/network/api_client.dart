import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// HTTP Client terpusat berbasis Dio dengan Interceptor autentikasi dan error handling.
class ApiClient {
  late final Dio _dio;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  ApiClient() {
    final baseUrl = dotenv.env['BASE_URL'] ?? 'https://api.escuelajs.co/api/v1';
    final timeout = int.tryParse(dotenv.env['API_TIMEOUT_MS'] ?? '15000') ?? 15000;

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: timeout),
        receiveTimeout: Duration(milliseconds: timeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Injeksi token JWT secara otomatis dari FlutterSecureStorage jika tersedia
          final token = await _secureStorage.read(key: 'auth_token');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          if (kDebugMode) {
            debugPrint('🌐 [HTTP REQUEST] ${options.method} -> ${options.uri}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            debugPrint('✅ [HTTP RESPONSE] ${response.statusCode} <- ${response.requestOptions.uri}');
          }
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          if (kDebugMode) {
            debugPrint('❌ [HTTP ERROR] ${error.response?.statusCode} : ${error.message}');
          }
          return handler.next(error);
        },
      ),
    );
  }

  Dio get client => _dio;
}

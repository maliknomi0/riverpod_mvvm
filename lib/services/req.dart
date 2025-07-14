import 'package:dio/dio.dart';
import 'package:zene/services/storage.dart';

import '../Utils/app_exceptions.dart';

class Req {
  final Dio _dio = Dio(
    BaseOptions(headers: {'Content-Type': 'application/json'}),
  );

  final Storage _storage = Storage();

  // Attach Authorization Header
  Future<void> _attachAuthHeader() async {
    final String token = await _storage.getToken();

    if (token.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      // No token, allow the request to proceed without Authorization
      _dio.options.headers.remove('Authorization');
    }
  }

  // JSON POST Request
  Future<dynamic> post(String url, Map<String, dynamic> data) async {
    await _attachAuthHeader();
    try {
      final response = await _dio.post(url, data: data);
      return response.data;
    } on DioException catch (error) {
      throw _handleError(error);
    }
  }

  // Multipart FormData POST Request
  Future<dynamic> postMultipart(String url, FormData data) async {
    await _attachAuthHeader();
    _dio.options.headers['Content-Type'] = 'multipart/form-data';
    try {
      final response = await _dio.post(url, data: data);
      return response.data;
    } on DioException catch (error) {
      throw _handleError(error);
    }
  }

  // GET Request
  Future<dynamic> get(String url) async {
    await _attachAuthHeader();
    try {
      final response = await _dio.get(url);
      return response.data;
    } on DioException catch (error) {
      throw _handleError(error);
    }
  }

  // PUT Request
  Future<dynamic> put(String url, Map<String, dynamic> data) async {
    await _attachAuthHeader();
    try {
      final response = await _dio.put(url, data: data);
      return response.data;
    } on DioException catch (error) {
      throw _handleError(error);
    }
  }

  // DELETE Request
  Future<dynamic> delete(String url) async {
    await _attachAuthHeader();
    try {
      final response = await _dio.delete(url);
      return response.data;
    } on DioException catch (error) {
      throw _handleError(error);
    }
  }

  AppException _handleError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return NoInternetException('Connection timed out');
    } else if (error.type == DioExceptionType.badResponse) {
      final statusCode = error.response?.statusCode ?? 0;
      final message = error.response?.data?['message'] ?? 'Unknown error';

      switch (statusCode) {
        case 400:
          return BadRequestException(message);
        case 401:
          return UnauthorizedException(message);
        case 403:
          return UnauthorizedException("Forbidden");
        case 404:
          return NotFoundException(message);
        case 409:
          return ConflictException(message);
        case 500:
        case 502:
        case 503:
          return InternalServerErrorException("Server error");
        default:
          return AppException(message);
      }
    } else if (error.type == DioExceptionType.unknown) {
      return NoInternetException('No internet connection');
    } else {
      return UnknownException(error.message ?? "Unknown error occurred");
    }
  }
}

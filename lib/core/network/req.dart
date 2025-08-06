import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpordmvvm/core/storage/hive_storage_helper.dart';
import 'package:riverpordmvvm/core/utils/app_exceptions.dart';
import 'package:riverpordmvvm/widgets/my_snackbar.dart';

class Req {
  final Dio _dio = Dio(
    BaseOptions(
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 10),
    ),
  );

  static const int _maxRetries = 2;

  Future<void> _attachAuthHeader() async {
    final String token = HiveStorageHelper.getToken();

    if (token.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  // Handle logout on unauthorized access
  Future<void> _handleLogout(BuildContext? context) async {
    await HiveStorageHelper.clearAll();
    _dio.options.headers.remove('Authorization');
    if (context != null) {
      mysnackbar.showError(context, 'Session expired. Please log in again.');
      // Optionally navigate to login screen
      // Example: Navigator.pushReplacementNamed(context, '/login');
    }
  }

  // Parse API response
  dynamic _parseResponse(dynamic responseData, {BuildContext? context}) {
    if (responseData is Map<String, dynamic>) {
      final bool success = responseData['success'] ?? false;
      final String message = responseData['message'] ?? 'Unknown response';

      if (success && context != null) {
        mysnackbar.showSuccess(context, message);
        return responseData;
      } else if (!success && context != null) {
        mysnackbar.showError(context, message);
        throw BadRequestException(message);
      }
    }
    return responseData;
  }

  // Generic request handler with retry logic
  Future<dynamic> _makeRequest(
    Future<Response> Function() request, {
    BuildContext? context,
    bool isMultipart = false,
  }) async {
    await _attachAuthHeader();

    if (isMultipart) {
      _dio.options.headers['Content-Type'] = 'multipart/form-data';
    }

    int attempt = 0;
    while (attempt < _maxRetries) {
      try {
        final response = await request();
        return _parseResponse(response.data, context: context);
      } on DioException catch (error) {
        if (_shouldRetry(error) && attempt < _maxRetries - 1) {
          attempt++;
          await Future.delayed(Duration(milliseconds: 500 * attempt));
          continue;
        }
        throw await _handleError(error, context: context);
      } finally {
        if (isMultipart) {
          _dio.options.headers['Content-Type'] = 'application/json';
        }
      }
    }
    throw UnknownException('Max retries reached');
  }

  // Check if request should be retried
  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        (error.response?.statusCode == 503);
  }

  // JSON POST Request
  Future<dynamic> post(
    String url,
    Map<String, dynamic> data, {
    BuildContext? context,
  }) async {
    return _makeRequest(() => _dio.post(url, data: data), context: context);
  }

  // Multipart FormData POST Request
  Future<dynamic> postMultipart(
    String url,
    FormData data, {
    BuildContext? context,
  }) async {
    return _makeRequest(
      () => _dio.post(url, data: data),
      context: context,
      isMultipart: true,
    );
  }

  // GET Request
  Future<dynamic> get(String url, {BuildContext? context}) async {
    return _makeRequest(() => _dio.get(url), context: context);
  }

  // GET Request
  Future<dynamic> patch(
    String url,
    Map<String, dynamic> data, {
    BuildContext? context,
  }) async {
    return _makeRequest(() => _dio.patch(url, data: data), context: context);
  }

  // PUT Request
  Future<dynamic> put(
    String url,
    Map<String, dynamic> data, {
    BuildContext? context,
  }) async {
    return _makeRequest(() => _dio.put(url, data: data), context: context);
  }

  Future<dynamic> putwithoutdata(String url, {BuildContext? context}) async {
    return _makeRequest(() => _dio.put(url), context: context);
  }

  // DELETE Request
  Future<dynamic> delete(String url, {BuildContext? context}) async {
    return _makeRequest(() => _dio.delete(url), context: context);
  }

  Future<dynamic> deletewithpayload(
    String url,
    Map<String, dynamic> data, {
    BuildContext? context,
  }) async {
    return _makeRequest(() => _dio.delete(url, data: data), context: context);
  }

  Future<AppException> _handleError(
    DioException error, {
    BuildContext? context,
  }) async {
    String message = 'Unknown error';

    if (error.response?.data is Map<String, dynamic>) {
      message = error.response?.data['message'] ?? 'Unknown error';
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      if (context != null) {
        mysnackbar.showError(context, 'Connection timed out');
      }
      return NoInternetException('Connection timed out');
    } else if (error.type == DioExceptionType.badResponse) {
      final statusCode = error.response?.statusCode ?? 0;

      switch (statusCode) {
        case 400:
          if (context != null) {
            mysnackbar.showError(context, message);
          }
          return BadRequestException(message);
        case 401:
          await _handleLogout(context);
          return UnauthorizedException('Session expired');
        case 403:
          if (context != null) {
            mysnackbar.showError(context, 'Forbidden: $message');
          }
          return UnauthorizedException('Forbidden: $message');
        case 404:
          if (context != null) {
            mysnackbar.showError(context, message);
          }
          return NotFoundException(message);
        case 409:
          if (context != null) {
            mysnackbar.showError(context, message);
          }
          return ConflictException(message);
        case 429:
          if (context != null) {
            mysnackbar.showError(context, 'Too many requests');
          }
          return RateLimitException('Too many requests');
        case 500:
        case 502:
        case 503:
          if (context != null) {
            mysnackbar.showError(context, 'Server error: $message');
          }
          return InternalServerErrorException('Server error: $message');
        default:
          if (context != null) {
            mysnackbar.showError(context, message);
          }
          return AppException(message);
      }
    } else if (error.type == DioExceptionType.connectionTimeout) {
      if (context != null) {
        mysnackbar.showError(context, 'No internet connection');
      }
      return NoInternetException('No internet connection');
    } else {
      if (context != null) {
        mysnackbar.showError(
          context,
          error.message ?? 'Unknown error occurred',
        );
      }
      return UnknownException(error.message ?? 'Unknown error occurred');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';
import 'package:pouch/data/modules/userAgent.dart';

import '../../utils/configs/app_config.dart';
import 'api/api_exception.dart';

class DioService {
  late final Dio _dio;
  final UserSessionController userSessionController = Get.find<UserSessionController>();

  DioService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: API_BASE_URL,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          _addAuthHeader(options);
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            bool tokenRefreshed = await _refreshToken();

            if (tokenRefreshed) {
              _addAuthHeader(error.requestOptions);
              return handler.resolve(await _dio.fetch(error.requestOptions));
            } else {
              userSessionController.logoutUser(
                logoutMessage: "Session expired. Please log in again.",
              );
            }
          }
          return handler.next(error);
        }
    ));
  }

  // ✅ Add Authorization Header
  void _addAuthHeader(RequestOptions options) async {
    String? token = await userSessionController.getAccessToken();
    final userAgent = await getUserAgent();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      options.headers['User-Agent'] = userAgent;
    }
  }

  // ✅ Refresh Token Logic
  Future<bool> _refreshToken() async {
    try {
      String? refreshToken = await userSessionController.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) return false;

      final response = await _dio.post('/auth/token/refresh', data: {'token': refreshToken});

      if (response.statusCode == 200) {
        // ✅ Update Token
        String newAccessToken = response.data['access_token'];
        String newRefreshToken = response.data['refresh_token'];

        await userSessionController.setToken(newAccessToken);
        await userSessionController.setRefreshToken(newRefreshToken);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


  // GET Request
  Future<dynamic> getRequest({required String endpoint, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParameters);
      return response.data;
    } catch (error) {
      throw _handleDioError(error);
    }
  }

  // POST Request
  Future<dynamic> postRequest({required String endpoint, required Map<String, dynamic> data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } catch (error) {
      throw _handleDioError(error);
    }
  }

  // PUT Request
  Future<dynamic> putRequest({required String endpoint, Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response.data;
    } catch (error) {
      throw _handleDioError(error);
    }
  }

  // DELETE Request
  Future<dynamic> deleteRequest({required String endpoint, Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response.data;
    } catch (error) {
      throw _handleDioError(error);
    }
  }

  // Handle API Errors
  String _handleDioError(dynamic error) {
    if (error is DioException) {
      return ApiErrorHandler.handleDioError(error);
    }
    return 'An unexpected error occurred';
  }
}

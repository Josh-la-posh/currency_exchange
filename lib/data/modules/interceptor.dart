import 'dart:async';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetX;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';
import 'package:pouch/data/modules/userAgent.dart';
import 'package:pouch/utils/shared/error_dialog_response.dart';
import '../../utils/configs/app_config.dart';

class AppInterceptor extends Interceptor {
  final Dio dio = Dio();
  final UserSessionController userSessionController = GetX.Get.find<UserSessionController>();
  final bool showLoader;

  static CancelToken globalCancelToken = CancelToken();

  AppInterceptor({this.showLoader = false}) {
    dio.options = BaseOptions(
      baseUrl: API_BASE_URL,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
    );

    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: _handleRequest,
        onResponse: _handleResponse,
        onError: _handleError,
      ),
    );
  }

  /// Handle outgoing requests
  Future<void> _handleRequest(
      RequestOptions requestOptions, RequestInterceptorHandler handler) async {
    try {
      requestOptions.cancelToken = globalCancelToken;
      // Check for internet connectivity
      final hasInternet = await InternetConnection().hasInternetAccess;
      if (!hasInternet) {
        print('No internet connection.');
        showErrorAlertHelper(errorMessage: 'Check your internet connection and try again');
        globalCancelToken.cancel();
        return handler.next(requestOptions);


        // return handler.reject(DioException(
        //     requestOptions: requestOptions,
        //     type: DioExceptionType.unknown,
        //     error: 'No internet connection'
        // ));
      }

      // Add authorization and user-agent headers
      final token = await userSessionController.getAccessToken();
      final userAgent = await getUserAgent();
      if (token != null) {
        requestOptions.headers['Accept'] = "application/json";
        requestOptions.headers['Authorization'] = 'Bearer $token';
      }
      requestOptions.headers['User-Agent'] = userAgent;
      // print('Request Headers: ${requestOptions.headers}');
      // print('Request URL: ${requestOptions.uri}');

      return handler.next(requestOptions);
    } catch (e) {
      handler.reject(DioException(requestOptions: requestOptions, error: 'Request handling error: $e'));
    }

  }

  /// Handle incoming responses
  void _handleResponse(Response response, ResponseInterceptorHandler handler) {
    print('I got it fam');
    return handler.next(response);
  }

  /// Handle errors and manage token refresh
  Future<void> _handleError(
      DioException err, ErrorInterceptorHandler handler) async {
    final isLoggedIn = await userSessionController.isLoginBool();

    print('The request was nt successful. Check me out ${err.response}');

    // Handle 401 Unauthorized - Token expired
     if (err.response?.statusCode == 401 && isLoggedIn) {
       try {
         // Attempt to refresh the token
         final newToken = await _refreshToken();
         if (newToken != null) {
           return handler.resolve(await _retry(err.requestOptions));
         } else {
           print('Refresh token failed, redirecting to login page');
           userSessionController.logoutUser(
             logoutMessage: "Session expired. Please log in again.",
           );
           return handler.reject(err);
         }
       } catch (e) {
         print('Refresh token error, redirecting to login page');
         userSessionController.logoutUser(
           logoutMessage: "Session expired. Please log in again.",
         );
         return handler.reject(err);
       }

    } else if (err.response?.statusCode == 401 && !isLoggedIn) {
       userSessionController.logoutUser(
         logoutMessage: "Session expired. Please log in again.",
       );
     } else {
       // Pass all other errors
       return handler.next(err);

     }
  }

  /// Refresh the access token using the refresh token
  Future<String?> _refreshToken() async {
    await userSessionController.removeAccessToken();
    final refreshToken = await userSessionController.getRefreshToken();
    try {
      final response = await dio.post('$API_BASE_URL/auth/token/refresh',
        data: {"token": refreshToken});
      final newToken = response.data['access_token'];
      final newRefreshToken = response.data['refresh_token'];


      print('Refreshing token...: ${response}');


      if (response.statusCode == 200 || response.statusCode == 201) {
        await userSessionController.setToken(newToken);
        await userSessionController.setRefreshToken(newRefreshToken);
        return newToken;
      } else {
        return null;
      }
    } catch (e) {
      print('Let us check for e $e');
      return null;
    }
  }

  /// Retry a failed request
  Future<Response> _retry(RequestOptions requestOptions) async {
    try {
      final token = await userSessionController.getAccessToken();
      final options = Options(
        method: requestOptions.method,
        headers: {
          ...requestOptions.headers,
          "Authorization": "Bearer $token",
        },
      );
      return dio.request<dynamic>(
        requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options,
      );
    } catch (e) {
      throw DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.unknown,
          error: 'Retry failed: $e',
      );
    }
  }

  /// Cancel ongoing requests
  // void cancelOngoingRequest(Function endLoadingState) {
  //   if (!globalCancelToken.isCancelled) {
  //     globalCancelToken.cancel("Request was cancelled by the user.");
  //     endLoadingState();
  //     globalCancelToken = CancelToken();
  //   }
  // }

  void cancelOngoingRequest([VoidCallback? endLoadingState]) {
    if (!globalCancelToken.isCancelled) {
      try {
        globalCancelToken.cancel("Request manually canceled");
        print('I never cancel ooooo');
      } catch (e) {
        print('Cancel token error: $e');
      } finally {
        endLoadingState?.call();
        globalCancelToken = CancelToken();
      }
    } else {
      print('I don cancel ooooo');
    }
  }


  /// Refresh the Dio instance
  void refreshDioInstance() {
    dio.options = BaseOptions(
      baseUrl: API_BASE_URL,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
    );
    dio.interceptors.clear();
    dio.interceptors.add(this);
  }

  /// Cancel requests and refresh Dio instance
  void cancelAndRefresh() {
    cancelOngoingRequest(() {});
    refreshDioInstance();
  }
}

import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetX;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../features/authentication/controllers/auth_controller.dart';
import '../../utils/configs/app_config.dart';

_doNothingFn() {}

class AppInterceptor extends Interceptor {
  var dio = Dio();
  final bool showLoader;
  final Function onProcessingRequestStart;
  final Function onProcessingRequestEnds;
  final Function noInternetConnection;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;
  static CancelToken cancelToken = CancelToken();

  final UserSessionController userSessionController = GetX.Get.find<UserSessionController>();
  final authController = GetX.Get.find<AuthController>();

  int retryCount = 0;
  final int maxRetry = 3;

  AppInterceptor({
    this.showLoader = false,
    this.onProcessingRequestEnds = _doNothingFn,
    this.onProcessingRequestStart = _doNothingFn,
    this.noInternetConnection = _doNothingFn,
    this.connectTimeout = const Duration(minutes: 2),
    this.receiveTimeout = const Duration(minutes: 2),
    this.sendTimeout = const Duration(minutes: 2),
  }) {
    dio.options = BaseOptions(
      baseUrl: API_BASE_URL,
      connectTimeout: connectTimeout,
      contentType: 'application/json',
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    );

    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (RequestOptions requestOptions, RequestInterceptorHandler handler) async {
          // Log the request initiation
          print('onRequest received for path: ${requestOptions.path}');

          // Reset cancelToken before each request
          requestOptions.cancelToken = cancelToken = CancelToken();

          // Check internet connection
          final connectivityResult = await InternetConnection().hasInternetAccess;
          print('Internet connection check: $connectivityResult');

          if (connectivityResult) {
            // Add token to headers
            String? token = await userSessionController.getAccessToken();
            requestOptions.headers['Authorization'] = 'Bearer $token';

            // Log request details
            THelperFunctions.showDebugMessageInConsole([
              'Request path: ${requestOptions.path}',
              'Request data: ${requestOptions.data}'
            ]);

            // Proceed with the request
            handler.next(requestOptions);
          } else {
            print('No internet connection');
            noInternetConnection();
            _handleNoInternetConnection(requestOptions, handler);
          }
        },
        onError: (DioException err, ErrorInterceptorHandler handler) async {
          print('onError called: ${err.message}');
          bool checkIfUserIsLogin = await userSessionController.isLoginBool();

          // Handle request completion
          onProcessingRequestEnds();

          if (err.response?.statusCode == 401 && checkIfUserIsLogin) {
            print('Authentication error. Trying to refresh token');
            if (retryCount < maxRetry) {
              retryCount++;
              await refreshToken();

              try {
                // Retry the failed request
                handler.resolve(await _retry(err.requestOptions));
              } on DioException catch (e) {
                handler.next(e);
              }
              return;
            } else {
              retryCount = 0;
              cancelToken.cancel('Session expired, Outgoing requests terminated');
              THelperFunctions.showDebugMessageInConsole(['Session expired, Outgoing requests terminated']);
              await userSessionController.logoutUser(
                logoutMessage: "Session expired. Please login.",
              );
            }
          } else {
            THelperFunctions.showDebugMessageInConsole([
              'Error: ${err.response?.statusCode} ${err.toString()} ${err.response?.data}'
            ]);
            handler.reject(err);
          }
        },
        onResponse: (Response res, ResponseInterceptorHandler handler) {
          print('onResponse received with status code: ${res.statusCode}');

          THelperFunctions.showDebugMessageInConsole([
            'Response status: ${res.statusCode}',
            'Response data: ${res.data != null ? res.data : ''}'
          ]);

          // Handle request completion
          onProcessingRequestEnds();
          handler.resolve(res);
        },
      ),
    );
  }

  // Function to cancel ongoing requests
  void cancelOngoingRequest() {
    if (!cancelToken.isCancelled) {
      print('Request cancelled by the user');
      cancelToken.cancel('Request was cancelled by the user.');
      cancelToken = CancelToken(); // Reset the cancel token for future requests
    }
  }

  // Handle token refresh
  Future<String?> refreshToken() async {
    print('Trying to refresh token');
    String? refreshToken = await userSessionController.getRefreshToken();
    if (refreshToken != null) {
      try {
        var response = await dio.post('$API_BASE_URL/auth/token/refresh', data: {"token": refreshToken});
        if (response.statusCode == 200 || response.statusCode == 201) {
          final newToken = response.data['access_token'];
          final newRefreshToken = response.data['refresh_token'];
          if (newToken != '') {
            await userSessionController.setToken(newToken);
            await userSessionController.setRefreshToken(newRefreshToken);
            return newToken;
          }
        }
      } catch (e) {
        print('Error while refreshing token: $e');
        return null;
      }
    }
    return null;
  }

  // Retry request after token refresh
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    print('Retrying request with new token');
    String? token = await userSessionController.getAccessToken();
    final options = Options(
      method: requestOptions.method,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  // Handle no internet connection
  void _handleNoInternetConnection(RequestOptions requestOptions, RequestInterceptorHandler handler) async {
    print('Handling no internet connection');
    bool isConnected = await InternetConnection().hasInternetAccess;

    if (isConnected) {
      print('Restoring connection and retrying request');
      handler.resolve(await _retry(requestOptions));
    } else {
      print('Couldn\'t restore connection, rejecting request');
      handler.reject(DioError(
        requestOptions: requestOptions,
        type: DioErrorType.connectionError,
        error: 'No internet connection. Please try again.',
      ));
    }
  }
}

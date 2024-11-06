import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetX;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';
import 'package:pouch/data/modules/userAgent.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/shared/error_dialog_response.dart';
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

  // Global CancelToken for all requests
  static CancelToken globalCancelToken = CancelToken();

  final UserSessionController userSessionController = GetX.Get.find<UserSessionController>();

  int retryCount = 0;
  final int maxRetry = 3;

  AppInterceptor({
    this.showLoader = false,
    this.onProcessingRequestEnds = _doNothingFn,
    this.onProcessingRequestStart = _doNothingFn,
    this.noInternetConnection = _doNothingFn,
    this.connectTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
    this.sendTimeout = const Duration(seconds: 30),
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
          print('onRequest received for path: ${requestOptions.path}');
          // requestOptions.cancelToken = globalCancelToken;

          final connectivityResult = await InternetConnection().hasInternetAccess;
          print('Internet connection check: $connectivityResult');

          if (connectivityResult) {
            String? token = await userSessionController.getAccessToken();
            String userAgent = await getUserAgent();

            requestOptions.headers['Authorization'] = 'Bearer $token';
            requestOptions.headers['User-Agent'] = userAgent;

            THelperFunctions.showDebugMessageInConsole([
              'Request path: ${requestOptions.path}',
              'Request data: ${requestOptions.data}'
            ]);

            handler.next(requestOptions);
          } else {
            noInternetConnection();
            // showErrorAlertHelper(errorMessage: 'Check your internet connection and try again');
            cancelAndRefresh();
          }
        },
        onError: (DioException err, ErrorInterceptorHandler handler) async {
          print('onError called: ${err.message}');
          bool checkIfUserIsLogin = await userSessionController.isLoginBool();

          onProcessingRequestEnds();

          if (err.response?.statusCode == 401 && checkIfUserIsLogin) {
            if (retryCount < maxRetry) {
              retryCount++;
              await refreshToken();

              try {
                handler.resolve(await _retry(err.requestOptions));
              } on DioException catch (e) {
                handler.next(e);
              }
              return;
            } else {
              retryCount = 0;
              globalCancelToken.cancel('Session expired, Outgoing requests terminated');
              THelperFunctions.showDebugMessageInConsole(['Session expired, Outgoing requests terminated']);
              await userSessionController.logoutUser(
                logoutMessage: "Session expired. Please login.",
              );
            }
          } else if (err.response?.statusCode == 401 && !checkIfUserIsLogin){
            userSessionController.logoutUser();
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

          onProcessingRequestEnds();
          handler.resolve(res);
        },
      ),
    );
  }

  // Cancel all ongoing requests
  void cancelOngoingRequest(Function endLoadingState) {
    if (!globalCancelToken.isCancelled) {
      globalCancelToken.cancel('Request was cancelled by the user.');
      endLoadingState();
      globalCancelToken = CancelToken();
    }
  }

  // Handle token refresh
  Future<String?> refreshToken() async {
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
        } else {
          await userSessionController.logoutUser(
            logoutMessage: "Session expired. Please login.",
          );
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

  // Refresh Dio instance to reset configurations
  void refreshDioInstance() {
    print('Refreshing Dio instance');
    dio = Dio(BaseOptions(
      baseUrl: API_BASE_URL,
      connectTimeout: connectTimeout,
      contentType: 'application/json',
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    ));

    dio.interceptors.add(this);
  }

  // Combine cancel all requests and refresh Dio
  void cancelAndRefresh() {
    cancelOngoingRequest(() {});
    refreshDioInstance();
  }
}

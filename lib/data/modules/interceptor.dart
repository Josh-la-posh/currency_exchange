import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetX;
import 'package:get/get_core/src/get_main.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';
import 'package:pouch/features/authentication/screens/login/login.dart';
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
          if (showLoader) {
            onProcessingRequestStart();
          }
          requestOptions.cancelToken = cancelToken;
          final connectivityResult = await InternetConnection().hasInternetAccess;

          if (connectivityResult) {
            String? token = await userSessionController.getAccessToken();

            // if (token == null || token.isEmpty) {
            //   Get.snackbar('', 'Session expired, please login');
            //   Get.offAll(() => LoginScreen());
            //   return handler.reject(DioError(
            //     requestOptions: requestOptions,
            //     type: DioErrorType.badResponse,
            //     error: 'Session expired, no valid token available.',
            //   ));
            // }

            requestOptions.headers['Authorization'] = 'Bearer $token';

            THelperFunctions.showDebugMessageInConsole([
              'api path logger ${requestOptions.path} \n api data ${requestOptions.data}',
            ]);

            handler.next(requestOptions);
          } else {
            print('Sorry, did not pass connectivity test');
            noInternetConnection();
            handler.reject(DioError(
              requestOptions: requestOptions,
              type: DioErrorType.connectionError,
              error: 'No internet connection.',
            ));
          }
        },
        onError: (DioException err, ErrorInterceptorHandler handler) async {
          bool checkIfUserIsLogin = await userSessionController.isLoginBool();

          onProcessingRequestEnds();

          if (err.response?.statusCode == 401 && checkIfUserIsLogin) {
            // await refreshToken();
            //
            // try {
            //   handler.resolve(await _retry(err.requestOptions));
            // } on DioException catch (e) {
            //   handler.next(e);
            // }
            // return;

            cancelToken.cancel('Session expired, Outgoing requests terminated');
            THelperFunctions.showDebugMessageInConsole(
                ['Session expired, Outgoing requests terminated']);

            await userSessionController.logoutUser();

            cancelToken = CancelToken();
          } else {
            THelperFunctions.showDebugMessageInConsole([
              'err logger status code: ${err.response?.statusCode} ${err.toString()} ${err.response?.data}'
            ]);
            handler.reject(err);
          }
        },
        onResponse: (Response res, ResponseInterceptorHandler handler) {
          THelperFunctions.showDebugMessageInConsole([
            'res logger status code: ${res.statusCode} res data: ${res.data != null ? res.data : ''}'
          ]);

          onProcessingRequestEnds();
          handler.resolve(res); // Pass the response
        },
      ),
    );
  }

  // Future<Response<dynamic>> refreshToken() async {
  //   var response = await dio.post(APIs.refreshToken,
  //       options: Options(
  //           headers: {"Refresh-Token": "refresh-token" }));
  //   // on success response, deserialize the response
  //   if (response.statusCode == 200) {
  //     // LoginRequestResponse requestResponse =
  //     //    LoginRequestResponse.fromJson(response.data);
  //     // UPDATE the STORAGE with new access and refresh-tokens
  //     return response;
  //   }
  // }

  // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  //   final options = Options(
  //     method: requestOptions.method,
  //     headers: {
  //       "Authorization": "Bearer ${token}",
  //     },
  //   );
  //
  //   // Retry the request with the new `RequestOptions` object.
  //   return dio.request<dynamic>(requestOptions.path,
  //       data: requestOptions.data,
  //       queryParameters: requestOptions.queryParameters,
  //       options: options);
  // }
}









// class AppInterceptor extends Interceptor {
//   var dio = Dio();
//   final bool showLoader;
//   final Function onProcessingRequestStart;
//   final Function onProcessingRequestEnds;
//   final Function noInternetConnection;
//   final Duration connectTimeout;
//   final Duration receiveTimeout;
//   final Duration sendTimeout;
//   static CancelToken cancelToken = CancelToken();
//
//   final UserSessionController userSessionController = GetX.Get.find<UserSessionController>();
//   final authController = GetX.Get.find<AuthController>();
//
//   AppInterceptor({
//     this.showLoader = false,
//     this.onProcessingRequestEnds = _doNothingFn,
//     this.onProcessingRequestStart = _doNothingFn,
//     this.noInternetConnection = _doNothingFn,
//     this.connectTimeout = const Duration(minutes: 2),
//     this.receiveTimeout = const Duration(minutes: 2),
//     this.sendTimeout = const Duration(minutes: 2),
//   }) {
//     dio.options = BaseOptions(
//       baseUrl: API_BASE_URL,
//       connectTimeout: connectTimeout,
//       contentType: 'application/json',
//       receiveTimeout: receiveTimeout,
//       sendTimeout: sendTimeout,
//     );
//
//     dio.interceptors.add(
//       QueuedInterceptorsWrapper(
//           onRequest: (RequestOptions requestOptions, RequestInterceptorHandler handler) async {
//             if (showLoader) {
//               print('can I start loading');
//               onProcessingRequestStart();
//             }
//             requestOptions.cancelToken = cancelToken;
//
//             final connectivityResult = await InternetConnection().hasInternetAccess;
//
//             if (connectivityResult) {
//               String? token = await userSessionController.getAccessToken();
//
//               // If token is null or empty, stop the request and redirect to login
//               if (token == null || token.isEmpty) {
//                 Get.snackbar('', 'Session expired, please login');
//                 Get.offAll(() => LoginScreen());
//                 return handler.reject(DioError(
//                   requestOptions: requestOptions,
//                   type: DioErrorType.cancel,
//                   error: 'Session expired, no valid token available.',
//                 ));
//               }
//
//               requestOptions.headers['Authorization'] = 'Bearer $token';
//
//               THelperFunctions.showDebugMessageInConsole([
//                 'api path logger ${requestOptions.path} \n api data ${requestOptions.data}',
//               ]);
//
//               handler.next(requestOptions);
//             } else {
//               print('Sorry, did not pass connectivity test');
//               noInternetConnection();
//               handler.reject(DioError(
//                 requestOptions: requestOptions,
//                 type: DioErrorType.connectionError,
//                 error: 'No internet connection.',
//               ));
//             }
//           },
//         onError: (DioException err, ErrorInterceptorHandler handler) async {
//           bool checkIfUserIsLogin = await userSessionController.isLoginBool();
//
//           onProcessingRequestEnds();
//
//           // Check for both 401 status or if the user is not logged in
//           if (err.response?.statusCode == 401 || !checkIfUserIsLogin) {
//             GetX.Get.snackbar('Session expired', 'Please login again.');
//
//             // Cancel ongoing requests
//             cancelToken.cancel('Session expired, Outgoing requests terminated');
//             THelperFunctions.showDebugMessageInConsole(
//                 ['Session expired, Outgoing requests terminated']);
//
//             // Clear user session and navigate to login
//             await userSessionController.logoutUser();
//             authController.removeUser();
//
//             // Reset cancelToken for future requests
//             cancelToken = CancelToken();
//
//             // Navigate to LoginScreen
//             GetX.Get.offAll(() => LoginScreen());
//           } else {
//             // If not a session-related error, pass the error on
//             THelperFunctions.showDebugMessageInConsole([
//               'err logger status code: ${err.response?.statusCode} ${err.toString()} ${err.response?.data}'
//             ]);
//             handler.reject(err);
//           }
//         },
//         onResponse: (Response res, ResponseInterceptorHandler handler) {
//           THelperFunctions.showDebugMessageInConsole([
//             'res logger status code: ${res.statusCode} res data: ${res.data != null ? res.data : ''}'
//           ]);
//
//           onProcessingRequestEnds();
//           handler.resolve(res); // Pass the response
//         },
//       ),
//     );
//   }
// }

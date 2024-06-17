import 'dart:async';

import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:swappr/data/modules/session_manager.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import '../../utils/configs/app_config.dart';
import '../../utils/loader.dart';
import '../../utils/responses/error_dialog.dart';

class AppInterceptor extends Interceptor {
  var dio = Dio();
  final bool showLoader;
  static CancelToken cancelToken = CancelToken();

  AppInterceptor({required this.showLoader}) {
    dio.options = BaseOptions(
      baseUrl: API_BASE_URL,
      connectTimeout: const Duration(minutes: 2),
      contentType: 'application/json',
      receiveTimeout: const Duration(minutes: 2),
      sendTimeout: const Duration(minutes: 2),
    );

    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (RequestOptions requestOptions,
            RequestInterceptorHandler handler) async {
          if (showLoader) {
            handleShowLoader();
            Timer(Duration(seconds: 2), () {
              handleHideLoader();
            });
          }
          requestOptions.cancelToken = cancelToken;
          final connectivityResult = await Connectivity().checkConnectivity();

          if (connectivityResult == ConnectivityResult.wifi ||
              connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.ethernet) {
            String? token = await UserSession.instance.getAccessToken();
            requestOptions.headers['Authorization'] = 'Bearer $token';

            // if (EnvConfigurationModule.instance.getEnvType() == 'DEV') {
            //   THelperFunctions.showDebugMessageInConsole([
            //     'api path logger ${requestOptions.path} \n api data ${requestOptions.data}',
            //   ]);
            // }

            handler.next(requestOptions);
          } else {
            showErrorAlertHelper(
                errorMessage: 'Please connect to the internet');
          }
        },
        onError: (DioException err, ErrorInterceptorHandler handler) async {
          bool checkIfUserIsLogin = await UserSession.instance.isLoginBool();
          if (showLoader) {
            handleHideLoader();
          }
          if (err.response?.statusCode == 401 && checkIfUserIsLogin) {
            cancelToken.cancel([
              {'message': 'Session expired, Outgoing requests terminated'}
            ]);
            THelperFunctions.showDebugMessageInConsole(
                ['Session expired, Outgoing requests terminated']);
            cancelToken = CancelToken();

            UserSession.instance
                .logoutUser(logoutMessage: 'Session expired, Please login');
          } else {
            handler.reject(err);
          }
        },
        onResponse: (Response res, ResponseInterceptorHandler handler) => {
          THelperFunctions.showDebugMessageInConsole([
            'res logger status code: ${res.statusCode} res data: ${res.data != null ? res.data : ''}'
          ]),
          handleHideLoader(),
          handler.resolve(res),
        },
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:qulip/apis/services/custom_log_intercepter.dart';
import 'package:qulip/utils/log_utils.dart';

const title = 'ApiUtils';

ApiUtils apiUtils = ApiUtils();

class ApiUtils {
  ApiUtils._i() {
    _dio.interceptors.add(
      CustomLogInterceptor(
        requestBody: true,
        responseHeader: false,
        responseBody: true,
      ),
    );
  }

  factory ApiUtils() {
    return _apiUtils;
  }
  static final ApiUtils _apiUtils = ApiUtils._i();
  final Dio _dio = Dio();

  Map<String, String> header = {'Content-Type': 'application/json'};

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'api-version': '1'
  };

  Map<String, String> secureHeaders = {
    'Content-Type': 'application/json',
    'api-version': '1',
    'Authorization': ''
  };

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final result = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> post({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    //Sending FormData:
    //FormData formData = FormData.fromMap({"name": ""});

    final result = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> postWithProgress({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
  }) async {
    //
    final result = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      onSendProgress: onSendProgress,
    );
    return result;
  }

  Future<Response> put({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final result = await _dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> delete({
    required String api,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    //Options options = Options(headers: secureHeaders);

    //var result = await _dio.delete(api, options: options);
    final result = await _dio.delete(
      api,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  String handleError(dynamic error) {
    String errorDescription = '';

    Log.loga(title, 'handleError:: error >> $error');

    if (error is DioError) {
      Log.loga(
        title,
        '************************ DioError ************************',
      );

      final DioException dioError = error;
      Log.loga(title, 'dioError:: $dioError');
      if (dioError.response != null) {
        Log.loga(title, 'dioError:: response >> ${dioError.response}');
      }

      switch (dioError.type) {
        case DioExceptionType.unknown:
          errorDescription = '由於網路連接，與 API 伺服器的連接失敗’';
          break;
        case DioExceptionType.cancel:
          errorDescription = '對 API 伺服器的請求被取消';
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = '與 API 伺服器的連線逾時';
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = '接收與 API 伺服器連接逾時';
          break;
        case DioExceptionType.badResponse:
          errorDescription = '收到無效狀態代碼: ${dioError.response?.statusCode}';
          break;
        case DioExceptionType.sendTimeout:
          errorDescription = '與 API 伺服器連接發送逾時';
          break;
        case DioExceptionType.badCertificate:
          errorDescription = '接收與 API 伺服器連接逾時';
        case DioExceptionType.connectionError:
          errorDescription = '與 API 伺服器的連線逾時';
      }
    } else {
      errorDescription = '發生意外錯誤';
    }
    Log.loga(title, 'handleError:: errorDescription >> $errorDescription');
    return errorDescription;
  }

  Map<String, String> getFormattedError() {
    return {'error': 'Error'};
  }

  String getNetworkError() {
    return 'No Internet Connection.';
  }
}

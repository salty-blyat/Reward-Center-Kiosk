import 'package:dio/dio.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:reward_center_kiosk/app_setting.dart';
import 'package:reward_center_kiosk/util/widgets/modal.dart';

class DioClient {
  final Dio dio = Dio();
  final String baseUrl = '${AppSetting.setting['BASE_API_URL']}';

  DioClient() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers['Tenant-Code'] = AppSetting.setting['TENANT_CODE'];
        options.headers['App-Code'] = AppSetting.setting['APP_CODE'];
        options.headers['Content-Type'] = 'application/json';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        if (Get.isDialogOpen == true) Get.back();
        Modal.errorDialog('Unsuccessful', _getResponseMessage(e));

        return handler.next(e);
      },
    ));
  }
  Future<Response?> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response =
          await dio.get('$baseUrl/$url', queryParameters: queryParameters);
      return response;
    } on DioException {
      rethrow;
    }
  }
 
  Future<Response?> post(String url, {Map<String, dynamic>? data}) async {
    try {
      Response response = await dio.post('$baseUrl/$url', data: data);
      return response;
    } on DioException {
      return null;
    }
  }

  Future<Response?> getCustom(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await dio.get(url, queryParameters: queryParameters);
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response?> postCustom(String url, {Map<String, dynamic>? data}) async {
    try {
      Response response = await dio.post(url, data: data);
      return response;
    } on DioException {
      return null;
    }
  }
 
  Future<Response> put(String url, {Map<String, dynamic>? data}) async {
    try {
      Response response = await dio.put('$baseUrl/$url', data: data);
      return response;
    } on DioException { 
      rethrow;
    }
  }
 
  Future<Response?> delete(String url, Map<String, dynamic>? data) async {
    try {
      Response response = await dio.delete('$baseUrl/$url',
          data: data,
          options: Options(
            headers: {
              'disableErrorNotification': 'yes',
            },
          ));
      return response;
    } on DioException {
      // Modal.errorDialog('Error', _getResponseMessage(e));
      return null;
    }
  }

  String _getResponseMessage(DioException e) {
    if (e.response?.data['args'] != null) {
      String messageTemplate = e.response!.data['message'].toString().tr;
      Map<String, dynamic> args = e.response!.data['args'];

      args.forEach((key, value) {
        String placeholder = '{{$key}}';
        messageTemplate =
            messageTemplate.replaceAll(placeholder, value.toString());
      });
      return messageTemplate;
    }
    return e.response?.data['message'].toString().tr ?? '';
  }
}

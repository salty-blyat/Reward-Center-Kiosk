import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:reward_center_kiosk/app_setting.dart';
import 'package:reward_center_kiosk/util/theme.dart'; 

class DioClient {  final Dio dio = Dio();
  final String baseUrl = '${AppSetting.setting['BASE_API_URL']}';

  DioClient() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers['Content-Type'] = 'application/json';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        if (!Get.isSnackbarOpen) {
          Get.showSnackbar(
            GetSnackBar(
              title: 'Unsuccessful'.tr,
              duration: const Duration(seconds: 2),
              message: _getResponseMessage(e),
              margin: const EdgeInsets.all(32),
              borderRadius: 8,
              backgroundColor: AppTheme.dangerColor,
            ),
          );
        }
 
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
    try {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) { 
        String messageTemplate =
            data['message']?.toString().tr ?? 'Unknown error';
 
        final args = data['args'];
        if (args is Map<String, dynamic>) {
          args.forEach((key, value) {
            final placeholder = '{{$key}}';
            messageTemplate =
                messageTemplate.replaceAll(placeholder, value.toString());
          });
        }
        return messageTemplate;
      }
 
      return e.message ?? 'Unknown error';
    } catch (err) { 
      return e.message ?? 'Unexpected error';
    }
  }

}

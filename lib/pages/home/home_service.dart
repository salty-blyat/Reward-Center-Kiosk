import 'dart:convert';

import 'package:reward_center_kiosk/helpers/token_interceptor.dart';
import 'package:reward_center_kiosk/model/company_model.dart';
import 'package:reward_center_kiosk/model/location_model.dart';

class HomeService {
  final dio = DioClient();

  Future<CompanyModel> getCompanyInfo() async {
    try {
      final response = await dio.get("company");
      if (response!.statusCode == 200) {
        return CompanyModel.fromJson(response!.data);
      } else {
        throw Exception(
            'Failed to fetch company info. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching company info: $e');
    }
  }

  Future<List<LocationModel>> getLocations() async {
    try {
      final response = await dio.get("location");
      if (response!.statusCode == 200) {
        return (response!.data as List)
            .map((e) => LocationModel.fromJson(e))
            .toList();
      } else {
        throw Exception(
            'Failed to fetch location. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching locations: $e');
    }
  }
}

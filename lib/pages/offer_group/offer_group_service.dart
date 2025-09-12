import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:reward_center_kiosk/helpers/token_interceptor.dart';
import 'package:reward_center_kiosk/model/offer_group_model.dart';
 

class OfferGroupService {
  final dio = DioClient();
  final String endpoint = 'offergroup';

  Future<List<OfferGroupModel>> search() async {
    final response = await dio.get(endpoint, queryParameters: {
      'pageSize': 50,
      'pageIndex': 1,
      'sorts': '',
      'filters': json.encode([])
    });
    return (response?.data['results'] as List)
        .map((e) => OfferGroupModel.fromJson(e))
        .toList();
  }
}

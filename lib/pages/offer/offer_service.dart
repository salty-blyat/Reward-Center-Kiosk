import 'dart:convert';
 
import 'package:reward_center_kiosk/helpers/base_service.dart';
import 'package:reward_center_kiosk/helpers/token_interceptor.dart';
import 'package:reward_center_kiosk/model/offer_model.dart'; 

class OfferService {
  final dio = DioClient();
  final String endpoint = 'offer';

  Future<List<OfferModel>> available(int id, int offerGroupId) async {
    var filters = [];
    filters.add({
      'field': 'memberId',
      'operator': 'eq',
      'value': id,
    });
    if (offerGroupId != 0) {
      filters.add({
        'field': 'offerGroupId',
        'operator': 'eq',
        'value': offerGroupId,
      });
    }

    final response = await dio.get("$endpoint/available", queryParameters: {
      'pageSize': 100,
      'pageIndex': 1,
      'sorts': '',
      'filters': json.encode(filters)
    });
    return (response?.data['results'] as List)
        .map((e) => OfferModel.fromJson(e))
        .toList();
  }

  Future<SearchResult<OfferModel>> search(QueryParam query) async {
    try {
      final response = await dio.get(
        'offer?pageIndex=${query.pageIndex}&pageSize=${query.pageSize}&sorts=${query.sorts}&filters=${query.filters}',
      );

      if (response?.statusCode == 200) {
        return SearchResult<OfferModel>.fromJson(
            response?.data, (json) => OfferModel.fromJson(json));
      }
      throw Exception('Failed to search.');
    } catch (e) {
      print(e);
      throw Exception('Failed to search.');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:reward_center_kiosk/helpers/base_service.dart';
import 'package:reward_center_kiosk/helpers/token_interceptor.dart';
import 'package:reward_center_kiosk/model/redemption_model.dart'; 

class RedemptionService {
  final dio = DioClient();
  final String endpoint = "redemption";

  Future<SearchResult<RedemptionModel>> getByMemberId(
      QueryParam query, int id) async {
    try {
      final response = await dio.get(
        'redemption?pageIndex=${query.pageIndex}&pageSize=${query.pageSize}&sorts=${query.sorts}&filters=${query.filters}',
      );

      if (response?.statusCode == 200) {
        return SearchResult<RedemptionModel>.fromJson(
            response?.data, (json) => RedemptionModel.fromJson(json));
      }
      throw Exception('Failed to search.');
    } catch (e) {
      throw Exception('Failed to search.');
    }
  }

  Future<RedemptionModel> add(
      RedemptionModel model, Function(Map<String, dynamic>) fromJsonT) async {
    final response = await dio.post(
      endpoint,
      data: model.toJson(),
    );

    if (response!.statusCode == 200) {
      return fromJsonT(response.data);
    }
    throw Exception('Failed to add item');
  }

  Future<RedemptionModel> getTransactionById(int id) async {
    final response = await dio.get('redemption/$id');
    return RedemptionModel.fromJson(response?.data);
  }
}

enum RedemptionEnum { processing, used, removed }

extension RedemptionEnumExtension on RedemptionEnum {
  static const Map<RedemptionEnum, int> _values = {
    RedemptionEnum.processing: 1,
    RedemptionEnum.used: 2,
    RedemptionEnum.removed: 4,
  };

  int get value => _values[this]!;
}

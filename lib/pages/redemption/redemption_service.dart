import 'package:dio/dio.dart';
import 'package:reward_center_kiosk/helpers/base_service.dart';
import 'package:reward_center_kiosk/helpers/token_interceptor.dart';
import 'package:reward_center_kiosk/model/redeem_model.dart';
import 'package:reward_center_kiosk/model/redemption_model.dart';

class RedemptionService {
  final dio = DioClient();

  Future<RedeemModel> add(int playerId, RedeemModel model,
      Function(Map<String, dynamic>) fromJsonT) async {
    final payload = model.toJson();
    payload.remove('id');
    final response = await dio.post(
      'player/$playerId/redeem',
      data: payload,
    );

    if (response!.statusCode == 200) {
      return fromJsonT(response.data);
    }
    throw Exception('Failed to add item');
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

import 'package:dio/dio.dart';
import 'package:reward_center_kiosk/helpers/common_validators.dart';
import 'package:reward_center_kiosk/helpers/storage.dart';
import 'package:reward_center_kiosk/helpers/token_interceptor.dart';
import 'package:reward_center_kiosk/model/member_model.dart';
import 'package:reward_center_kiosk/model/offer_model.dart';

class MemberService {
  final dio = DioClient();

  Future<MemberModel> findByCard(String id) async {
    // get num only
    // card has weird chars (;028347?a)
    final cleanId = id.replaceAll(RegExp(r'[^0-9]'), '');

    try {
      final response = await dio.get('player/with-card/$cleanId');
      if (response!.statusCode == 200) {
        return MemberModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to fetch member. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching member: $e');
    }
  }

  Future<List<OfferModel>> availableOffer(
      {required String playerId, required String locationId}) async {
    try {
      final response = await dio.get('player/$playerId/gift-at/$locationId');
      if (response!.statusCode == 200) {
        return (response.data as List).map((e) => OfferModel.fromJson(e)).toList();
      } else {
        throw Exception(
            'Failed to fetch offer. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching offer: $e');
    }
  }
}

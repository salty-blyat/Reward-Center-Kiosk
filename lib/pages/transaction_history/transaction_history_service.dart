import 'package:reward_center_kiosk/helpers/token_interceptor.dart';
import 'package:reward_center_kiosk/model/transaction_model.dart';

class TransactionHistoryService {
  final dio = DioClient();

  Future<List<TransactionModel>> search(String playerId) async {
    var res = await dio.get('player/$playerId/point/history');

    if (res!.statusCode == 200) {
      return (res.data as List).map((e) => TransactionModel.fromJson(e)).toList();
    } else {
      throw Exception("Cannot fetch transaction");
    }
  }
}

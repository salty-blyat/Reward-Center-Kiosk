import 'package:get/get.dart';
import 'package:reward_center_kiosk/model/offer_group_model.dart';
import 'package:reward_center_kiosk/pages/offer_group/offer_group_service.dart'; 

class OfferGroupController extends GetxController {
  final OfferGroupService service = OfferGroupService();
  final lists = <OfferGroupModel>[OfferGroupModel(id: 0, name: 'All')].obs;
  final isLoading = false.obs;

  @override
  onInit() {
    search();

    super.onInit();
  }

  Future<void> search() async {
    isLoading.value = true;
    try {
      final result = await service.search();
      lists.addAll(result);
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}

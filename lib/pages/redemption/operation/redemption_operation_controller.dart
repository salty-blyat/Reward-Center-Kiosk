import 'dart:convert';

import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reward_center_kiosk/helpers/common_validators.dart';
import 'package:reward_center_kiosk/helpers/storage.dart';
import 'package:reward_center_kiosk/model/location_model.dart';
import 'package:reward_center_kiosk/model/member_model.dart';
import 'package:reward_center_kiosk/model/offer_model.dart';
import 'package:reward_center_kiosk/model/redeem_model.dart';
import 'package:reward_center_kiosk/pages/member/member_controller.dart';
import 'package:reward_center_kiosk/pages/redemption/redemption_service.dart';
import 'package:reward_center_kiosk/util/widgets/modal.dart';

class RedemptionController extends GetxController {
  RxBool loading = false.obs;
  Rx<OfferModel> gift = OfferModel().obs;
  final RedemptionService service = RedemptionService();
  Rx<MemberModel> member = MemberModel().obs;
  final MemberController memberController = Get.put(MemberController());
  final storage = InMemoryStorage();
  final Rx<LocationModel> selectedLocation = LocationModel().obs;

  final FormGroup formGroup = fb.group({
    "redeemDate": FormControl<DateTime>(value: DateTime.now()),
    "playerId": FormControl<int>(
        value: 0,
        validators: [Validators.delegate(CommonValidators.mustBiggerThanZero)]),
    "locationId": FormControl<int>(
      value: 0,
      validators: [Validators.delegate(CommonValidators.mustBiggerThanZero)],
    ),
    "giftId": FormControl<int>(
        value: 0,
        validators: [Validators.delegate(CommonValidators.mustBiggerThanZero)]),
    "quantity": FormControl<double>(
        value: 1,
        validators: [Validators.delegate(CommonValidators.mustBiggerThanZero)]),
    "unitCost": FormControl<double>(value: 0, validators: []),
    "totalPoint": FormControl<double>(value: 0, validators: []),
    "note": FormControl<String>(value: ''),
  });

  @override
  Future<void> onReady() async {
    super.onReady();
    resetForm();
    setGift();
    setModel();
  }

  resetForm() {
    formGroup.reset(value: {
      "redeemDate": DateTime.now(),
      "playerId": 0,
      "locationId": 0,
      "giftId": 0,
      "quantity": 1.0,
      "unitCost": 0.0,
      "totalPoint": 0.0,
      "note": '',
    });
  }

  @override
  void onInit() {
    super.onInit();
    formGroup
        .control('quantity')
        .valueChanges
        .listen((_) => _updateTotalPoint());
    formGroup
        .control('unitCost')
        .valueChanges
        .listen((_) => _updateTotalPoint());
  }

  void _updateTotalPoint() {
    final quantity = formGroup.control('quantity').value ?? 0.0;
    final unitCost = formGroup.control('unitCost').value ?? 0.0;
    formGroup.control('totalPoint').value = quantity * unitCost;
    print(formGroup.rawValue);
  }

  Future<void> setModel() async {
    formGroup.control('unitCost').value = gift.value.cost;
    formGroup.control('playerId').value = memberController.member.value.id;
    final location = await loadSelectedLocation();
    formGroup.control('locationId').value = location?.id;
    formGroup.control('giftId').value = gift.value.id;
    print(formGroup.rawValue);
  }

  setGift() {
    try {
      if (Get.arguments['gift'] != null) {
        gift.value = Get.arguments['gift'];
      }
    } catch (e) {
      print("Get.arguments['gift'] is null");
      print("error: $e");
    }
  }

  void increment() {
    formGroup.control('quantity').value++;
  }

  void decrement() {
    if (formGroup.control('quantity').value <= 0) {
      return;
    }
    formGroup.control('quantity').value--;
  }

  Future<void> submit() async {
    loading.value = true;

    try {
      print('formGroup.rawValue ${formGroup.rawValue}');
      final playerId = formGroup.control('playerId').value;
      final rawValue = Map<String, dynamic>.from(formGroup.value);

      rawValue['redeemDate'] =
          (rawValue['redeemDate'] as DateTime?)?.toIso8601String();
      final model = RedeemModel.fromJson(rawValue);
      var res = await service.add(playerId, model, RedeemModel.fromJson); 
      Get.back();

      Modal.successDialog("Redeemed Successfully!", "Please claim your receipt below.");
      loading.value = false;

    } catch (e) {
      loading.value = false;
    }
    loading.value = false;
  }

  Future<LocationModel?> loadSelectedLocation() async {
    final data = await storage.read(StorageKeys.selectedLocation);

    if (data == null) return null;
    if (data is String) {
      final Map<String, dynamic> map = jsonDecode(data);
      final location = LocationModel.fromJson(map);
      Future.delayed(Duration.zero, () => selectedLocation.value = location);
      return location;
    }
    return null;
  }

  @override
  void onClose() {
    formGroup.dispose();
    super.onClose();
  }
}

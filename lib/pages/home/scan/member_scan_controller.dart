import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/route.dart'; 

enum ScanCardStatus {
  start,
  processing,
  found,
  notFound,
}

extension LookupTypeEnumExtension on ScanCardStatus {
  static const Map<ScanCardStatus, int> _values = {
    ScanCardStatus.start: 1,
    ScanCardStatus.processing: 2,
    ScanCardStatus.found: 3,
    ScanCardStatus.notFound: 4,
  };

  int get value => _values[this]!;
}

class MemberScanController extends GetxController {
  // final MemberService service = MemberService();
  final FocusNode focusNode = FocusNode();
  final cardNumber = TextEditingController();
  final cardNumberText = ''.obs;
  final isLoadingCard = false.obs;
  final cardStatus = ScanCardStatus.start.obs;
  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 300), () {
      focusNode.requestFocus();
    });
    cardNumber.addListener(() {
      cardNumberText.value = cardNumber.text;
    });
    debounce<String>(cardNumberText, (val) async { 
      cardNumberText.value = val;
      if (cardNumberText.value.isNotEmpty) {
        try {
          cardStatus.value = ScanCardStatus.processing;
          // var res = await service.findByCard(cardNumberText.value);
          cardStatus.value = ScanCardStatus.found;
          Get.toNamed(RouteName.member,
              arguments: {'id': 1, 'cardNumber': cardNumberText.value});
          cardStatus.value = ScanCardStatus.start;
          cardNumberText.value = '';
          cardNumber.clear();
          focusNode.requestFocus();
        } catch (e) {
          cardNumber.clear();
          cardNumberText.value = '';
          cardStatus.value = ScanCardStatus.notFound;
          focusNode.requestFocus();
        }
      }
    }, time: const Duration(milliseconds: 500));
    super.onInit();
  }
}

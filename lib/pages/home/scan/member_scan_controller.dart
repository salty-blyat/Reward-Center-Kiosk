import 'dart:async';

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
    print('called member scan controller');
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
          
          await Future.delayed(Duration(seconds: 3));
          
          cardStatus.value = ScanCardStatus.found;
          await Future.delayed(Duration(seconds: 1));  
          
          Get.toNamed(RouteName.member,
              arguments: {'id': 1, 'cardNumber': cardNumberText.value}); 

          await Future.delayed(Duration(milliseconds: 500));
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

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/helpers/storage.dart';
import 'package:reward_center_kiosk/pages/home/home_controller.dart';
import 'package:reward_center_kiosk/pages/member/member_controller.dart';
import 'package:reward_center_kiosk/route.dart';
import 'package:reward_center_kiosk/util/widgets/modal.dart';

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
  Timer? timer;
  final HomeController homeController = Get.put(HomeController());
  final MemberController memberController = Get.put(MemberController());
  final FocusNode focusNode = FocusNode();
  final cardNumber = TextEditingController();
  final cardNumberText = ''.obs;
  final isLoadingCard = false.obs;
  final cardStatus = ScanCardStatus.start.obs;
  final storage = InMemoryStorage();

  @override
  void onInit() {
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!focusNode.hasFocus) {
        focusNode.requestFocus();
      }
    });

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
          await Future.delayed(const Duration(milliseconds: 500));

          final selectedLocation = homeController.loadSelectedLocation();
          print("selected location $selectedLocation");
          if (selectedLocation == null) {
            if (!Get.isDialogOpen!) {
              Modal.noLocationDialog();
            }
            cardStatus.value = ScanCardStatus.start;
            cardNumberText.value = '';
            cardNumber.clear();
            focusNode.requestFocus();
            return;
          }
          bool exist =
              await memberController.checkExistUser(cardNumberText.value);
          if (!exist) {
            cardNumber.clear();
            cardNumberText.value = '';
            cardStatus.value = ScanCardStatus.notFound;
            focusNode.requestFocus();
            await Future.delayed(const Duration(seconds: 2));
            cardStatus.value = ScanCardStatus.start;
            return;
          }

          cardStatus.value = ScanCardStatus.found;
          await Future.delayed(const Duration(milliseconds: 500));

          Get.toNamed(RouteName.member,
              arguments: {'cardNumber': cardNumberText.value});
          print("card number: ${cardNumberText.value}");

          await Future.delayed(const Duration(milliseconds: 500));
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

  void dispose() {
    timer?.cancel();
    focusNode.dispose();
    super.dispose();
  }
}

import 'dart:async';

import 'package:get/get.dart';
import 'package:reward_center_kiosk/app_setting.dart';
import 'package:reward_center_kiosk/route.dart';

class InActiveController extends GetxController {
  late Timer _timer;
  int deadline = AppSetting.setting['Inactive_After'];
  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    //  if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (Get.currentRoute != RouteName.home) {
        if (deadline == 0) {
          extendDeadline();
          kickUserOut();
        } else {
          deadline--;
        }
      }
      print('timer $deadline');
    });
  }

  void extendDeadline() {
    deadline = AppSetting.setting['Inactive_After'];
  }

  void kickUserOut() {
    Get.toNamed(RouteName.home);
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}

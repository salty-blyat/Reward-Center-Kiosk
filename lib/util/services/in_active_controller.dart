import 'dart:async';

import 'package:get/get.dart';
import 'package:reward_center_kiosk/route.dart';

class InActiveController extends GetxController {
  late Timer _timer;
  int deadline = 10;
  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    //  if (_timer != null && _timer!.isActive) return;
    print('init timerr');
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print('timer $timer');
      if (deadline == 0) {
        extendDeadline();
        kickUserOut();
      } else {
        deadline--;
      }
      print('deadline $deadline');
    });
  }

  void extendDeadline() {
    deadline = 10;
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

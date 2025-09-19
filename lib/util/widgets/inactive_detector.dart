import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/util/services/in_active_controller.dart';

class InactiveDetector extends StatelessWidget {
  final Widget child;
  final InActiveController controller = Get.find();

  InactiveDetector({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => controller.extendDeadline(), // user touched
      onPointerMove: (_) => controller.extendDeadline(), // user moved
      onPointerHover: (_) => controller.extendDeadline(), // optional
      child: child,
    );
  }
}

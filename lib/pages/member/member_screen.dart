import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:reward_center_kiosk/pages/member/member_controller.dart';
import 'package:reward_center_kiosk/route.dart';

class MemberScreen extends StatelessWidget {
  MemberScreen({super.key});
  final MemberController controller = Get.put(MemberController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading:
      IconButton(onPressed: () => Get.toNamed(RouteName.home), icon: const Icon(Icons.arrow_back_ios_rounded))  ),
        body: SafeArea(
      child: Obx(() => Text(controller.cardNumber.value)),
    ));
  }
}

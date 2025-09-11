import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/model/member_detail_model.dart';
import 'package:reward_center_kiosk/pages/member/member_controller.dart';
import 'package:reward_center_kiosk/route.dart';
import 'package:reward_center_kiosk/util/const.dart';
import 'package:reward_center_kiosk/util/widgets/avartar.dart';

class MemberScreen extends StatelessWidget {
  MemberScreen({super.key});
  final MemberController controller = Get.put(MemberController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.toNamed(RouteName.home),
              icon: const Icon(Icons.arrow_back_ios_rounded)),
          // title: Text(
          //   "Member".tr,
          //   style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          // ),
          // centerTitle: true,
        ),
        body: SafeArea(
            child: Column(
          children: [
            _buildProfile(controller.member.value),
          ],
        )));
  }
}

Widget _buildProfile(MemberDetailModel member) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 8,
        ),
        InkWell(
          onTap: () {
            // if (controller.isViewMember.isFalse) {
            //   Modal.showAccessDenied();
            //   return;
            // }
            // Get.to(() => MemberViewScreen(member: member));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: SizedBox(
              width: 200,
              child: Avartar(
                iconSize: 100,
                isCircular: false,
                imageUrl: '${member.photo}',
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 32,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Member name',
              style: const TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Icon(Icons.phone, size: 16),
                const SizedBox(
                  width: 4,
                ),
                Text("098264262", style: TextStyle(fontSize: 32))
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  size: 16,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                    // Const.getDate(member.joinDate)
                    "2025-05-02",
                    style: TextStyle(fontSize: 32)),
              ],
            ),
            Row(
              children: [
                const Icon(
                  CupertinoIcons.building_2_fill,
                  size: 16,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "Agent Name",
                  style: TextStyle(fontSize: 32),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

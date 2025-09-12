import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/model/member_detail_model.dart';
import 'package:reward_center_kiosk/pages/member/member_controller.dart';
import 'package:reward_center_kiosk/route.dart'; 
import 'package:reward_center_kiosk/util/widgets/avartar.dart';
import 'package:reward_center_kiosk/util/widgets/switch_language.dart'; 

class MemberScreen extends StatelessWidget {
  MemberScreen({super.key});
  final MemberController controller = Get.put(MemberController());
  @override
  Widget build(BuildContext context) {
    final MemberDetailModel member = controller.member.value;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.toNamed(RouteName.home),
            icon: const Icon(Icons.arrow_back_ios_rounded)), 
            actions: const [SwitchLanguage()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Hello".tr),
            _buildProfile(member)
          ],
        ),
      ),
    );
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
              width: 180,
              child: Avartar(
                iconSize: 52,
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
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            infoRow(icon: Icons.phone, text: "098264262"),
            const SizedBox(height: 8),
            infoRow(icon: Icons.calendar_month_outlined, text: "2025-05-02"),
            const SizedBox(height: 8),
            infoRow(icon: CupertinoIcons.building_2_fill, text: "Agent Name"),
          ],
        ),
      ],
    ),
  );
}

Widget infoRow({
  required IconData icon,
  required String text,
  double iconSize = 24,
  double fontSize = 24,
}) {
  return Row(
    children: [
      Icon(icon, size: iconSize),
      const SizedBox(width: 12),
      Text(
        text,
        style: TextStyle(fontSize: fontSize),
      ),
    ],
  );
}

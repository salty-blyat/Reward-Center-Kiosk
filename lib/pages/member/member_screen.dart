import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/model/member_detail_model.dart';
import 'package:reward_center_kiosk/model/offer_model.dart';
import 'package:reward_center_kiosk/pages/member/member_controller.dart';
import 'package:reward_center_kiosk/route.dart';
import 'package:reward_center_kiosk/util/services/printer_controller.dart';
import 'package:reward_center_kiosk/util/theme.dart';
import 'package:reward_center_kiosk/util/widgets/appbar_icon.dart';
import 'package:reward_center_kiosk/util/widgets/avartar.dart';
import 'package:reward_center_kiosk/util/widgets/button.dart';
import 'package:reward_center_kiosk/util/widgets/network_img.dart';
import 'package:reward_center_kiosk/util/widgets/switch_language.dart';

class MemberScreen extends StatelessWidget {
  MemberScreen({super.key});
  final MemberController controller = Get.put(MemberController());
  @override
  Widget build(BuildContext context) {
    final MemberDetailModel member = controller.member.value;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(84),
        child: AppbarIcon(),
      ),
      body: Column(
        children: [_buildProfile(member), _buildAvailableOffer()],
      ),
    );
  }
}

Widget _buildAvailableOffer() {
  return Expanded(
    child: Container(
      color: AppTheme.defaultColor.withAlpha(20),
      margin: const EdgeInsets.only(top: 18),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Available Offers",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 5 / 7,
              children: List.generate(100, (index) {
                return _buildOffer();
              }),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildOffer() {
  final PrinterController printerController = Get.put(PrinterController());
  return Container(
      margin: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: NetworkImg(
                height: 200,
                badge: "10 pts",
                src:
                    "https://img.freepik.com/free-vector/special-offer-buy-one-get-one-free-discount-coupon-background_1017-51061.jpg?semt=ais_hybrid&w=740&q=80"),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              'Buy 1 Get 1 Free',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Text(
              'Seasonal',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: MyButton(
                  label: 'Redeem'.tr,
                  fontSize: 18,
                  onPressed: () {
                    Get.toNamed(RouteName.redemptionOp);
                  }),
            ),
          )
        ],
      ));
}

Widget _buildProfile(MemberDetailModel member) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(
        width: 8,
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        child: SizedBox(
          width: 300,
          height: 400,
          child: Avartar(
            iconSize: 250,
            isCircular: false,
            imageUrl: 'https://static.wikia.nocookie.net/naruto/images/4/4a/Obito_Uchiha.png/revision/latest/scale-to-width-down/1200?cb=20220223045744',
          ),
        ),
        // ),
      ),
      const SizedBox(
        width: 16,
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            width: 440,
            child: Text(
              'Leng hok hor',
              style: TextStyle(
                  height: 1, fontSize: 52, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          infoRow(icon: Icons.phone, text: "098264262"),
          const SizedBox(height: 8),
          infoRow(icon: Icons.calendar_month_outlined, text: "2025-05-02"),
          const SizedBox(height: 8),
          infoRow(icon: CupertinoIcons.building_2_fill, text: "Agent Name"),
          const SizedBox(height: 32),
          Container(
            width: 430,
            height: 145,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Material(
                color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                splashColor: AppTheme.primaryColor.withOpacity(0.2),
                onTap: () => Get.toNamed(RouteName.transactionHistory),
                child: const Center(
                  child: Text(
                    '97,600 pts',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,  
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ],
  );
}

Widget infoRow({
  required IconData icon,
  required String text,
  double iconSize =32,
  double fontSize =32,
}) {
  return Row(
    children: [
      Icon(icon, size: iconSize, color: AppTheme.defaultColor),
      const SizedBox(width: 12),
      Text(
        text,
        style: TextStyle(fontSize: fontSize, color: AppTheme.defaultColor),
      ),
    ],
  );
}

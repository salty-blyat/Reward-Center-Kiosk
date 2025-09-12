import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/model/member_detail_model.dart';
import 'package:reward_center_kiosk/model/offer_model.dart';
import 'package:reward_center_kiosk/pages/member/member_controller.dart';
import 'package:reward_center_kiosk/route.dart';
import 'package:reward_center_kiosk/util/theme.dart';
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
      appBar: AppBar(  
        leading: IconButton(
            onPressed: () => Get.toNamed(RouteName.home),
            icon: const Icon(Icons.arrow_back_ios_rounded)),
        actions: const [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 4, 16, 4),
              child: SwitchLanguage())
        ],
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
      color: AppTheme.defaultColor.withAlpha(20)
      ,margin: EdgeInsets.only(top: 18),
      child: GridView.count(
        crossAxisCount: 2, 
        childAspectRatio: 6 / 8,
        scrollDirection: Axis.vertical,
        children: List.generate(100, (index) {
          return _buildOffer();
        }),
      ),
    ),
  );
}

Widget _buildOffer() {
  return Container(
    margin: EdgeInsets.all(16),
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
                height: 300,
                badge: "10 pts",
                src:
                    "https://img.freepik.com/free-vector/special-offer-buy-one-get-one-free-discount-coupon-background_1017-51061.jpg?semt=ais_hybrid&w=740&q=80"),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              'Buy 1 Get 1 Free',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              'Seasonal',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16),
              child: MyButton(
                  label: 'Redeem',
                  onPressed: () {
                    print('hi');
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
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        child: SizedBox(
          width: 300,
          height: 440,
          child: Avartar(
            iconSize: 250,
            isCircular: false,
            imageUrl: '${member.photo}',
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
  child: const Center(
    child: Text(
      '97,600 pts',
      style: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Colors.white, // contrast!
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
  double iconSize = 36,
  double fontSize = 36,
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

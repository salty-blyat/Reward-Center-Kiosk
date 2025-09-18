import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reward_center_kiosk/model/offer_model.dart';
import 'package:reward_center_kiosk/pages/member/member_controller.dart';
import 'package:reward_center_kiosk/route.dart';
import 'package:reward_center_kiosk/util/const.dart';
import 'package:reward_center_kiosk/util/services/printer_controller.dart';
import 'package:reward_center_kiosk/util/theme.dart';
import 'package:reward_center_kiosk/util/widgets/appbar_icon.dart';
import 'package:reward_center_kiosk/util/widgets/avartar.dart';
import 'package:reward_center_kiosk/util/widgets/button.dart';
import 'package:reward_center_kiosk/util/widgets/loading.dart';
import 'package:reward_center_kiosk/util/widgets/network_img.dart';
import 'package:reward_center_kiosk/util/widgets/not_found.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MemberScreen extends StatelessWidget {
  MemberScreen({super.key});
  final MemberController controller = Get.put(MemberController());

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(84),
        child: AppbarIcon(),
      ),
      body: Column(
        children: [_buildProfile(), _buildAvailableOffer()],
      ),
    );
  }
}

Widget _buildAvailableOffer() {
  final MemberController controller = Get.put(MemberController());
  return Expanded(
    child: Container(
      color: AppTheme.defaultColor.withAlpha(20),
      margin: const EdgeInsets.only(top: 18),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Available Offers".tr,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await controller.availableOffer();
              },
              child: Obx(() {
                if (controller.isLoadingOffer.isTrue) {
                  return const SizedBox(
                      height: 300, child: Center(child: Loading()));
                } else if (controller.listOffer.isEmpty) {
                  return const SizedBox(
                      height: 300, child: Center(child: NotFound()));
                }
                return GridView.count(
                    crossAxisCount: 4, // maybe 4 is better looking
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 5 / 7,
                    children: controller.listOffer
                        .map((OfferModel offer) => _buildOffer(offer))
                        .toList());
              }),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildOffer(OfferModel offer) {
  final PrinterController printerController = Get.put(PrinterController());
  return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: NetworkImg(
                  height: 150,
                  badge: "${offer.cost ?? 0} pts",
                  src: offer.image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(offer.name ?? '-',
                textAlign: TextAlign.left,
                style: Get.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Text(offer.code ?? '-', style: Get.textTheme.bodySmall),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: MyButton(
                  // disabled: offer.canRedeem ?? false,
                  label: 'Redeem'.tr,
                  fontSize: 16,
                  onPressed: () {
                    Get.toNamed(RouteName.redemptionOp);
                  }),
            ),
          )
        ],
      ));
}

Widget _buildProfile() {
  final MemberController controller = Get.put(MemberController());
  String passCode = controller.member.value.hasPassCode == true
      ? "PassCode Set"
      : "PassCode not Set";
  return Obx(() {
    return Skeletonizer(
        enabled: controller.isLoading.isTrue,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // const SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 195,
                        width:  195,
                        child: Avartar(
                          iconSize: 32,
                          imageUrl: controller.member.value.photo,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star_outline,
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(controller.member.value.playerClassName ?? '-',
                                style: Get.textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     const SizedBox(height: 12),
                      //     Text("Code: ${controller.member.value.code ?? '-'}",
                      //         style: Get.textTheme.bodySmall
                      //             ?.copyWith(color: AppTheme.defaultColor)),
                      //     Text(
                      //         "Member since: ${Const.getDate(controller.member.value.joinDate)}",
                      //         style: Get.textTheme.bodySmall
                      //             ?.copyWith(color: AppTheme.defaultColor)),
                      //   ],
                      // ),
                    ],
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.member.value.name ?? '-',
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                      // const SizedBox(height: 24),
                      // 
                      Text("Code: ${controller.member.value.code ?? '-'}",
                          style: Get.textTheme.bodySmall
                              ?.copyWith(color: AppTheme.defaultColor)),
                      Text(
                          "Member since: ${Const.getDate(controller.member.value.joinDate)}",
                          style: Get.textTheme.bodySmall
                              ?.copyWith(color: AppTheme.defaultColor)),const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildCard(
                              icon: Icons.stars_outlined,
                              title:
                                  "${controller.member.value.point ?? ''} pts",
                              subtitle: "Total Points"),
                          const SizedBox(width: 16),
                          _buildCard(
                              icon: Icons.trending_up_outlined,
                              title:
                                  "+${controller.member.value.pointEarnToday ?? ''} pts",
                              subtitle: "Earned Today"),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildInfoChunk(
                      icon: Icons.person_2_outlined,
                      title: "Junket Name",
                      child: Text(
                        controller.member.value.junketName ?? '-',
                        style: Get.textTheme.bodyMedium?.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(width: 32 ),
                  _buildInfoChunk(
                      icon: Icons.lock_outline,
                      title: "Security",
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                            color: controller.member.value.hasPassCode == true
                                ? AppTheme.primaryColor
                                : AppTheme.dangerColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          passCode,
                          style: Get.textTheme.bodySmall?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                  const SizedBox(width: 32 ),
                  _buildInfoChunk(
                      icon: Icons.access_time_rounded,
                      title: "Last Seen",
                      child: Text(
                        Const.prettyDate(controller.member.value.lastSeenAt ??
                            DateTime.now()),
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(width: 32 ),
                  _buildInfoChunk(
                      icon: Icons.credit_card_outlined,
                      title: "Card Number",
                      child: Text(
                        Const.formatCardNumber(
                            controller.member.value.cardNumber ?? "0"),
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ],
          ),
        ));
  });
}

Widget _buildCard(
    {required IconData icon, required String title, required String subtitle}) {
  return Container(
    height: 140,
    width: 180,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.white, // required for shadow to be visible
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1), // shadow color
          spreadRadius: 2, // how much it spreads
          blurRadius: 8, // softness of the shadow
          offset: const Offset(0, 4), // (x, y) → downwards 4px
        ),
      ],
    ),
    child: Column(children: [
      Icon(
        icon,
        color: AppTheme.primaryColor,
      ),
      Text(
        title,
        style: Get.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      Text(subtitle,
          style: TextStyle(color: AppTheme.defaultColor, fontSize: 14)),
    ]),
  );
}

Widget _buildInfoChunk(
    {required IconData icon, required String title, required Widget child}) {
  return Column(
    children: [
      Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppTheme.defaultColor,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            title.tr,
            style: Get.textTheme.bodyMedium
                ?.copyWith(color: AppTheme.defaultColor),
          )
        ],
      ),
      child
    ],
  );
}

// Widget infoRow({
//   required IconData icon,
//   required String text,
//   double iconSize = 24,
//   double fontSize = 24,
// }) {
//   return Row(
//     children: [
//       Icon(icon, size: iconSize, color: AppTheme.defaultColor),
//       const SizedBox(width: 12),
//       Text(
//         text,
//         style: TextStyle(fontSize: fontSize, color: AppTheme.defaultColor),
//       ),
//     ],
//   );
// }

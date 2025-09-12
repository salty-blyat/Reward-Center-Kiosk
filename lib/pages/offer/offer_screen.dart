// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:reward_center_kiosk/pages/offer/offer_controller.dart';
// import 'package:reward_center_kiosk/pages/offer/offer_tab.dart';
// import 'package:reward_center_kiosk/pages/offer/redemption_history_tab.dart';
// import 'package:reward_center_kiosk/pages/offer_group/offer_group_controller.dart';
// import 'package:reward_center_kiosk/util/theme.dart';

// class OfferScreen extends StatelessWidget {
//   OfferScreen({
//     super.key,
//   });
//   final OfferController controller = Get.put(OfferController());
//   final OfferGroupController offerGroupController =
//       Get.put(OfferGroupController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Offer'.tr),
//       ),
//       body: Column(
//         children: [
//           if (controller.isRedeemList.isTrue)
//             TabBar.secondary(
//               controller: controller.tabController,
//               dividerColor: Colors.black.withOpacity(0.1),
//               unselectedLabelStyle: const TextStyle(
//                 fontFamilyFallback: ['Kantumruy', 'Gilroy'],
//                 fontSize: 14,
//                 color: Colors.black,
//               ),
//               labelStyle: const TextStyle(
//                   fontFamilyFallback: ['Kantumruy', 'Gilroy'],
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: AppTheme.primaryColor),
//               tabs: [
//                 Tab(height: 32, text: "Offer".tr),
//                 Tab(height: 32, text: "History".tr),
//               ],
//             ),
//           Container(
//             height: 8,
//             color: Colors.black.withOpacity(0.05),
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.05),
//               ),
//               child: TabBarView(
//                 controller: controller.tabController,
//                 children: [
//                   OfferTab(),
//                   RedemptionTab(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

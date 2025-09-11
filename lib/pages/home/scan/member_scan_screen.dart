// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:staff_view_ui/pages/member/scan/member_scan_controller.dart';
// import 'package:staff_view_ui/utils/theme.dart';

// class MemberScanScreen extends StatelessWidget {
//   MemberScanScreen({super.key});
//   final MemberScanController controller = Get.put(MemberScanController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('Card Finder'.tr),
//       ),
//       body: Obx(
//         () => controller.isLoadingCard.isTrue
//             ? const CircularProgressIndicator()
//             : SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         switch (controller.cardStatus.value) {
//                           ScanCardStatus.found => const Card(
//                               color: AppTheme.successColor,
//                               icon: CupertinoIcons.check_mark_circled),
//                           ScanCardStatus.notFound => const Card(
//                               color: AppTheme.dangerColor,
//                               icon: CupertinoIcons.creditcard),
//                           ScanCardStatus.start => const Card(
//                               color: AppTheme.primaryColor,
//                               icon: CupertinoIcons.wifi),
//                           ScanCardStatus.processing => const Card(
//                               color: AppTheme.processingColor,
//                               icon: CupertinoIcons.search),
//                         },
//                         Offstage(
//                           child: TextField(
//                             controller: controller.cardNumber,
//                             focusNode: controller.focusNode,
//                             keyboardType: TextInputType.none,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           'Find Member'.tr,
//                           style: const TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           'Please insert membership card into the reader to continue'
//                               .tr,
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }

// class Card extends StatelessWidget {
//   const Card({
//     super.key,
//     required this.color,
//     required this.icon,
//   });
//   final Color color;
//   final IconData icon;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       width: double.infinity,
//       margin: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//           color: color.withAlpha(50),
//           border: Border.all(color: color),
//           borderRadius: const BorderRadius.all(Radius.circular(8))),
//       child: Icon(
//         icon,
//         size: 40,
//         color: color,
//       ),
//     );
//   }
// }

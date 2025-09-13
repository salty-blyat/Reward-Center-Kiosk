import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/pages/home/scan/member_scan_controller.dart';
import 'package:reward_center_kiosk/util/theme.dart';
import 'package:reward_center_kiosk/util/widgets/loading.dart';
import 'package:reward_center_kiosk/util/widgets/switch_language.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final MemberScanController controller = Get.put(MemberScanController());

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        actions: const [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 4, 16, 4),
              child: SwitchLanguage())
        ],
      ),
      body: Center(
        child: Container(
          height: 900,
          width: 600,
          padding: const EdgeInsets.all(48),
          // color: const Color.fromARGB(255, 230, 240, 250),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text('Hello'.tr),
                  const Icon(Icons.fullscreen, size: 56, weight: 600),
                  Text(
                    'Scan Card'.tr,
                    style: const TextStyle(
                        fontSize: 48, height: 1, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                "Kindly scan your loyalty card.".tr,
                style:
                    const TextStyle(fontSize: 32, color: AppTheme.defaultColor),
              ),
              Obx(
                () => controller.isLoadingCard.isTrue
                    ? const CircularProgressIndicator()
                    : Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            switch (controller.cardStatus.value) {
                              ScanCardStatus.found => const Card(
                                  color: AppTheme.primaryColor,
                                  icon: CupertinoIcons.check_mark_circled,
                                  loading: false),
                              ScanCardStatus.notFound => const Card(
                                  color: AppTheme.dangerColor,
                                  loading: false,
                                  icon: CupertinoIcons.creditcard),
                              ScanCardStatus.start => const Card(
                                  color: AppTheme.primaryColor,
                                  loading: false,
                                  icon: CupertinoIcons.wifi),
                              ScanCardStatus.processing => const Card(
                                  color: AppTheme.primaryColor,
                                  loading: true,
                                  icon: CupertinoIcons.wifi),
                            },
                            // Text(controller.cardStatus.value.toString()),   for debugging
                            Offstage(
                              child: TextField(
                                controller: controller.cardNumber,
                                focusNode: controller.focusNode,
                                keyboardType: TextInputType.none,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              Text(
                "Hold your loyalty card close to the NFC reader to proceed.".tr,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 24, color: AppTheme.defaultColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card(
      {super.key,
      required this.color,
      required this.icon,
      required this.loading});
  final Color color;
  final IconData icon;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 500,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          // border: Border.all(color: color),
          color: color.withAlpha(50),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: loading
          ? const Loading()
          : Icon(
              icon,
              size: 80,
              color: color,
            ),
    );
  }
}

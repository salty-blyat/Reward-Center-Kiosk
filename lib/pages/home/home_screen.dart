import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/pages/home/scan/member_scan_controller.dart';
import 'package:reward_center_kiosk/util/theme.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final MemberScanController controller = Get.put(MemberScanController());
  
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      body: Center(
        child: Container(
          height: 900,
          padding: const EdgeInsets.all(48),
          width: 600,
          color: const Color.fromARGB(255, 230, 240, 250),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.fullscreen, size: 56, weight: 600),
                  Text(
                    'Scan'.tr,
                    style: const TextStyle(
                        fontSize: 52, height: 1, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                "Please put your card to scan.".tr,
                style: const TextStyle(fontSize: 32),
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
                                  icon: CupertinoIcons.check_mark_circled),
                              ScanCardStatus.notFound => const Card(
                                  color: AppTheme.dangerColor,
                                  icon: CupertinoIcons.creditcard),
                              ScanCardStatus.start => const Card(
                                  color: AppTheme.primaryColor,
                                  icon: CupertinoIcons.wifi),
                              ScanCardStatus.processing => const Card(
                                  color: AppTheme.processingColor,
                                  icon: CupertinoIcons.search),
                            },
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
                "Please put your card to scan.".tr,
                style: const TextStyle(fontSize: 32),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    super.key,
    required this.color,
    required this.icon,
  });
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: color.withAlpha(50),
          border: Border.all(color: color),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Icon(
        icon,
        size: 80,
        color: color,
      ),
    );
  }
}

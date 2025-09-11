import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/pages/home/scan/member_scan_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final MemberScanController controller = Get.put(MemberScanController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
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
              Obx(() => controller.cardNumberText.value.isNotEmpty ? Text(controller.cardNumberText.value) : const SizedBox.shrink()),
              Offstage(
                child: TextField(
                  controller: controller.cardNumber,
                  focusNode: controller.focusNode,
                  keyboardType: TextInputType.none,
                ),
              ),
              const Expanded( 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo,
                      size: 64,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Please hold your card against the scan area below.",
                      textAlign: TextAlign.center,  
                      style: TextStyle(fontSize: 24, ),
                    )
                  ],
                ),
              ),
              const Text('Make sure the QR code or barcode is clearly visible')
            ],
          ),
        ),
      ),
    ));
  }
}

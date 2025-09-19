import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/model/location_model.dart';
import 'package:reward_center_kiosk/pages/home/home_controller.dart';
import 'package:reward_center_kiosk/pages/home/scan/member_scan_controller.dart';
import 'package:reward_center_kiosk/util/theme.dart';
import 'package:reward_center_kiosk/util/widgets/loading.dart';
import 'package:reward_center_kiosk/util/widgets/not_found.dart';
import 'package:reward_center_kiosk/util/widgets/switch_language.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController homeController = Get.put(HomeController());
  final MemberScanController controller = Get.put(MemberScanController());

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        actions: [
          Obx(() => homeController.selectedLocation.value != null &&
                  homeController.selectedLocation.value?.name != null
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 20, color: AppTheme.primaryColor),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                          homeController.selectedLocation.value?.name ??
                              "Unknown",
                          style: Get.textTheme.bodyMedium?.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                )
              : const SizedBox.shrink()),
          const SizedBox(width: 16),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 4, 16, 4),
              child: SwitchLanguage())
        ],
      ),
      body: Center(
        child: Container(
          height: 600,
          width: 600,
          padding: const EdgeInsets.all(48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onLongPress: () {
                      Get.dialog(
                        Dialog(
                          child: _buildLocationDialog(),
                        ),
                      );
                      controller.focusNode.requestFocus();
                    },
                    child: const Icon(Icons.fullscreen,
                        size: AppTheme.iconExtraLarge, weight: 600),
                  ),
                  Text('Scan Card'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(height: 1, color: Colors.black)),
                ],
              ),
              // Text("Kindly scan your loyalty card.".tr,
              // style: Theme.of(context)
              //     .textTheme
              //     .displaySmall
              //     ?.copyWith(color: AppTheme.defaultColor)),
              // style:  TextStyle(fontSize: 26, color:AppTheme.defaultColor),),
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
                                  color: AppTheme.successColor,
                                  icon: CupertinoIcons.check_mark_circled,
                                  loading: false),
                              ScanCardStatus.notFound => const Card(
                                  color: AppTheme.dangerColor,
                                  loading: false,
                                  icon: CupertinoIcons.creditcard),
                              ScanCardStatus.start => const Card(
                                  color: AppTheme.primaryColor,
                                  loading: false,
                                  icon: FontAwesomeIcons.idCard),
                              ScanCardStatus.processing => const Card(
                                  color: AppTheme.primaryColor,
                                  loading: true,
                                  icon: FontAwesomeIcons.wifi),
                            },
                            // Text(controller.cardStatus.value
                            //     .toString()), // for debugging
                            // Text(controller.cardNumberText.value),  // for debugging
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
                  "Hold your loyalty card close to the NFC reader to proceed."
                      .tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(color: AppTheme.defaultColor)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildLocationDialog() {
  final HomeController controller = Get.put(HomeController());
  controller.getLocations();

  return Obx(() {
    double width = 490;
    double height = 500;
    if (controller.loadingLocation.isTrue) {
      return SizedBox(
          height: height, width: width, child: const Center(child: Loading()));
    } else if (controller.locations.isEmpty) {
      return SizedBox(
          height: height, width: width, child: const Center(child: NotFound()));
    }

    return SizedBox(
      height: height,
      width: width,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                iconSize: 16,
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.clear,
                  color: Colors.transparent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 28),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Location'.tr,
                      style: Get.textTheme.displayMedium
                          ?.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: IconButton(
                  iconSize: 24,
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(CupertinoIcons.clear),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemCount: controller.locations.length,
              itemBuilder: (context, index) {
                final location = controller.locations[index];

               return FutureBuilder(
                    future: controller.loadSelectedLocation(),
                    builder: (context, snapshot) {
                      final selectedLocation = snapshot.data;
                      final isSelected = selectedLocation != null &&
                          location.id == selectedLocation.id;

                      return ListTile(
                        minVerticalPadding: 24,
                        selected: isSelected,
                        selectedColor: AppTheme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppTheme.borderRadius,
                          side: BorderSide(
                            color: isSelected
                                ? AppTheme.primaryColor
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        trailing: Icon(
                          CupertinoIcons.checkmark_circle,
                          size: 32,
                          color: isSelected
                              ? AppTheme.primaryColor
                              : Colors.transparent,
                        ),
                        title: Text(
                          location.name ?? 'Unknown',
                          style: const TextStyle(fontSize: 24),
                          // style: Get.textTheme.bodyLarge,
                        ),
                        onTap: ()  async {
                         await controller.saveLocation(location);
                         await controller.loadSelectedLocation();
                          Get.back();
                        },
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  });
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
          color: color.withAlpha(50),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: loading
          ? const Loading()
          : Icon(
              icon,
              size: AppTheme.iconLarge,
              color: color,
            ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/util/const.dart';
import 'package:reward_center_kiosk/util/theme.dart';
import 'package:reward_center_kiosk/util/widgets/button.dart';

class Modal {
   static successDialog(String title, String message) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 250,
          width: 350,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 12),
                    const Icon(CupertinoIcons.checkmark_circle,
                        size: 70, color: AppTheme.successColor),
                    const SizedBox(height: 10),
                    Text(
                      title.tr,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(message.tr),
                  ],
                ),
                MyButton(
                  padding: const EdgeInsets.all(8),
                  label: 'OK'.tr,
                  fontSize: 18,
                  onPressed: () {
                    Navigator.of(Get.context!).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  static showLanguageDialog({bool dismissable = true}) {
    Get.dialog(
      barrierDismissible: dismissable,
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: AppTheme.borderRadius,
        ),
        child: SizedBox( 
          height: 350,
          width: 400,
          child: Column( 
            children: [
              // Header Row
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
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Language'.tr,
                      style: Get.textTheme.titleSmall?.copyWith(color:Colors.black),
                    ),
                  ),
                  dismissable
                      ? Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: IconButton(
                            iconSize: 24,
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(CupertinoIcons.clear),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ), 
              // Scrollable ListView
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  padding: const EdgeInsets.all(16),
                  itemCount: Const.languages.length,
                  itemBuilder: (context, index) {
                    final language = Const.languages[index];
                    final isSelected =
                        Get.locale?.languageCode == language['code'];
                    return ListTile(
                      minTileHeight: 64,
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
                      trailing: Icon(CupertinoIcons.checkmark_circle,
                          size: 42,
                          color: isSelected
                              ? AppTheme.primaryColor
                              : Colors.transparent),
                      title: Text(
                        language['label'] ?? 'Unknown',
                        style: Get.textTheme.bodyLarge,
                      ),
                      leading: Image.asset(
                        language['image'] ??
                            'assets/default.png', // Fallback image
                        width:  42,
                        height: 42,
                        fit: BoxFit.cover,
                      ),
                      onTap: () async {
                        // Handle language selection
                        if (language['key'] != null) {
                          Get.updateLocale(language['key']);

                          Get.back();
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static noLocationDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Location Not Found".tr,
                style: const TextStyle(fontSize: 32, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Text(
                "Please contact administrator or staff.".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, color: Colors.black),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppTheme.primaryColor,
                    ),
                    child: Text("Return".tr),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static errorDialog(String title, String message) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 500,
          width: 450,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 12),
                    const Icon(CupertinoIcons.clear_circled,
                        size: 70, color: AppTheme.dangerColor),
                    const SizedBox(height: 10),
                    Text(
                      title.tr,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(message.tr, textAlign: TextAlign.center),
                  ],
                ),
                ElevatedButton(
                  child: Text('Ok'.tr),
                  onPressed: () => Navigator.of(Get.context!).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

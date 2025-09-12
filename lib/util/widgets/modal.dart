import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/helpers/storage.dart';
import 'package:reward_center_kiosk/util/const.dart';
import 'package:reward_center_kiosk/util/theme.dart';

class Modal {
  static showLanguageDialog({bool dismissable = true}) {
    Get.dialog(
      barrierDismissible: dismissable,
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: AppTheme.borderRadius,
        ),
        child: SizedBox(
          height: 500,
          width: 490,
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
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Choose Language'.tr,
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                  dismissable
                      ? Container(
                        margin: EdgeInsets.only(right: 8),
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
              const SizedBox(height: 10),
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
                      minTileHeight: 84, 
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
                          size: 48,
                          color: isSelected
                              ? AppTheme.primaryColor
                              : Colors.transparent),
                      title: Text( language['label'] ?? 'Unknown', style:  TextStyle(fontSize: 32), ), 
                      leading: Image.asset(
                        language['image'] ??
                            'assets/default.png', // Fallback image
                        width:  72,
                        height: 72,
                        fit: BoxFit.contain,
                      ),
                      onTap: () async {
                        // Handle language selection
                        if (language['key'] != null) {
                          // var box = Storage();
                          // box.write(
                          //     Const.authorized['Lang']!, language['code']);
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

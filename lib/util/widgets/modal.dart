import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/helpers/storage.dart';
import 'package:reward_center_kiosk/util/const.dart'; 
import 'package:reward_center_kiosk/util/theme.dart';

class Modal {
   static showLanguageDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: AppTheme.borderRadius,
        ),
        child: SizedBox(
          height: 250,
          width: double.infinity,
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
                  Text(
                    'Choose Language'.tr,
                    style: Theme.of(Get.context!).textTheme.titleMedium,
                  ),
                  IconButton(
                    iconSize: 16,
                    onPressed: () {
                      Get.back(); // Close the dialog
                    },
                    icon: const Icon(CupertinoIcons.clear),
                  ),
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
                          size: 20,
                          color: isSelected
                              ? AppTheme.primaryColor
                              : Colors.transparent),
                      title: Text(
                          language['label'] ?? 'Unknown'), // Handle null safely
                      leading: Image.asset(
                        language['image'] ??
                            'assets/default.png', // Fallback image
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
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
}
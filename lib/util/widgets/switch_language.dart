import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/util/const.dart';
import 'package:reward_center_kiosk/util/widgets/modal.dart';

class SwitchLanguage extends StatelessWidget {
  const SwitchLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentLocale = Const.languages
        .firstWhere((language) => Get.locale?.languageCode == language['code']);
    return GestureDetector(
      onTap: () => Modal.showLanguageDialog(),
      child: Image.asset(currentLocale['image'] ?? 'assets/default.png',
          width:  42, 
          height: 42, fit: BoxFit.cover),
    );
  }
}

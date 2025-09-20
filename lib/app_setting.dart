import 'dart:convert'; 
 
import 'package:flutter/services.dart';
import 'package:reward_center_kiosk/helpers/storage.dart'; 

class AppSetting {
  static var setting; 
  var storage = InMemoryStorage();
  Future<void> initSetting() async {
    String jsonString = await rootBundle.loadString('assets/setting.json');
    var data = jsonDecode(jsonString); 
    setting = data;
    // if (storage.read('setting') == null) {
    //   try {
    //   } catch (e) {
    //     kDebugMode ? print('Error loading settings: $e') : null;
    //   }
    //   storage.write('setting', jsonEncode(setting));
    // } else {
    //   setting = jsonDecode(storage.read('setting') ?? '');
    // }
    print("setting: $setting");
  }
}

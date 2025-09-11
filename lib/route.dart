import 'package:get/get.dart';
import 'package:reward_center_kiosk/pages/home/home_screen.dart';
import 'package:reward_center_kiosk/pages/member/member_screen.dart'; 



class Routes {
  static final List<GetPage> pages = [
    GetPage(name: RouteName.home, page: () => HomeScreen()), 
    GetPage(name: RouteName.member, page: () => MemberScreen()), 
  ];
}

class RouteName {
  static const String home = '/';
  static const String member = '/member';  
}

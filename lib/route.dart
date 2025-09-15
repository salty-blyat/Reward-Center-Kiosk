import 'package:get/get.dart';
import 'package:reward_center_kiosk/pages/home/home_screen.dart';
import 'package:reward_center_kiosk/pages/member/member_screen.dart';
import 'package:reward_center_kiosk/pages/redemption/operation/redemption_operation_screen.dart';
import 'package:reward_center_kiosk/pages/transaction_history/transaction_history_screen.dart'; 



class Routes {
  static final List<GetPage> pages = [
    GetPage(name: RouteName.home, page: () => HomeScreen()), 
    GetPage(name: RouteName.member, page: () => MemberScreen()), 
    GetPage(name: RouteName.transactionHistory, page: () => TransactionHistoryScreen()), 
    GetPage(name: RouteName.redemptionOp, page: () => RedemptionOperationScreen())
  ];
}

class RouteName {
  static const String home = '/';
  static const String member = '/member';
  static const String transactionHistory = '/transaction-history';
  static const String redemptionOp = '/redemption-op';  
} 
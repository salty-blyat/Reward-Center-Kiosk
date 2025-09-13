import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:reward_center_kiosk/route.dart';
import 'package:reward_center_kiosk/util/theme.dart';
import 'package:reward_center_kiosk/util/widgets/switch_language.dart';

class AppbarIcon extends StatelessWidget implements PreferredSizeWidget {
  const AppbarIcon({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () => Get.toNamed(RouteName.home),
            icon: Icon(Icons.home, size: 48),
          ),
          const SizedBox(width: 16),
          _buildIcon(routeName: RouteName.member, icon: Icons.person),
          const SizedBox(width: 16),  
          _buildIcon(
              routeName: RouteName.transactionHistory,
              icon: Icons.monetization_on_outlined),
        ],
      ),
      actions: const [
        Padding(
            padding: EdgeInsets.fromLTRB(0, 4, 16, 4), child: SwitchLanguage())
      ],
    );
  }
}

Widget _buildIcon({required String routeName, required IconData icon}) {
  bool isCurrent = Get.currentRoute == routeName;

  return IconButton(
    style: IconButton.styleFrom(
      backgroundColor: isCurrent
          ? AppTheme.primaryColor.withOpacity(0.2)
          : Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isCurrent
              ? AppTheme.primaryColor.withOpacity(0.5)
              : AppTheme.primaryColor.withOpacity(0.2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    onPressed: () => Get.toNamed(routeName),
    icon: Icon(icon, size: 48),
  );
}

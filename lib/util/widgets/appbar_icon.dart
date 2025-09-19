import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/route_manager.dart';
import 'package:reward_center_kiosk/pages/home/home_controller.dart';
import 'package:reward_center_kiosk/route.dart';
import 'package:reward_center_kiosk/util/theme.dart';
import 'package:reward_center_kiosk/util/widgets/switch_language.dart';

class AppbarIcon extends StatelessWidget implements PreferredSizeWidget {
  AppbarIcon({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: IntrinsicHeight(
        child: Row(
          children: [
            Transform.flip(
              flipX: true,
              child: IconButton(
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Get.dialog(buildExitDialog());
                },
                icon:
                    const Icon(Icons.exit_to_app_outlined, size: AppTheme.iconMedium),
              ),
            ),
            const SizedBox(width: 2),
            const VerticalDivider(
              thickness: 2,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(width: 2),
            _buildIcon(
                routeName: RouteName.member,
                icon: Icons.person_outline,
                selectedIcon: Icons.person),
            const SizedBox(width: 16),
            _buildIcon(
                routeName: RouteName.transactionHistory,
                icon: Icons.monetization_on_outlined,
                selectedIcon: Icons.monetization_on),
          ],
        ),
      ),
      actions: [
        Obx(() => controller.selectedLocation.value != null &&
                controller.selectedLocation.value?.name != null
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                margin: const EdgeInsets.only(right: 4),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 20, color: AppTheme.primaryColor),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(controller.selectedLocation.value?.name ?? "Unknown",
                        style: Get.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              )
            : const SizedBox.shrink()),
        const SizedBox(width: 16),
        const Padding(
            padding: EdgeInsets.fromLTRB(0, 4, 16, 4), child: SwitchLanguage())
      ],
    );
  }
}

Dialog buildExitDialog() {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Container(
      width: 400,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Exit".tr,
            style: 
            Get.textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Text(
            "Are you sure you want to exit?".tr,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.back(); 
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    backgroundColor: Colors.white,
                    side: const BorderSide( color: AppTheme.primaryColor)
),
                child:  Text("No".tr , style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: AppTheme.primaryColor)),
              ),
              const SizedBox(
                width: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.offAllNamed(RouteName.home);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    backgroundColor: AppTheme.dangerColor,
                     side: const BorderSide( color: AppTheme.dangerColor), 
                ),
                child: Text("Yes".tr, style: Get.textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget _buildIcon(
    {required String routeName,
    required IconData icon,
    required IconData selectedIcon}) {
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
    icon: Icon(isCurrent ? selectedIcon : icon, size: AppTheme.iconMedium),
  );
}

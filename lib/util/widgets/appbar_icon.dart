import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            onPressed: () {
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
                          "Exit".tr,
                          style: const TextStyle(
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Are you sure you want to exit?".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 48),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.back(); // close dialog
                              },
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  backgroundColor: AppTheme.dangerColor),
                              child: const Text("No"),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: AppTheme.primaryColor,
                              ),
                              child: Text("Yes".tr),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: Icon(Icons.home_outlined, size: 48),
          ),
          const SizedBox(width: 16),
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
      actions: [
              Obx(() => controller.selectedLocation.value != null &&
                  controller.selectedLocation.value?.name != null
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  margin: const EdgeInsets.only(right: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 24, color: AppTheme.primaryColor),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                          controller.selectedLocation.value?.name ??
                              "Unknown",
                          style: Get.textTheme.bodyLarge?.copyWith(
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
    icon: Icon(isCurrent ? selectedIcon : icon, size: 48),
  );
}

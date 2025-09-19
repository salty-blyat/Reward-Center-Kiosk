import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reward_center_kiosk/pages/redemption/operation/redemption_operation_controller.dart';
import 'package:reward_center_kiosk/util/format.dart';
import 'package:reward_center_kiosk/util/theme.dart';
import 'package:reward_center_kiosk/util/widgets/appbar_icon.dart';
import 'package:reward_center_kiosk/util/widgets/avartar.dart';
import 'package:reward_center_kiosk/util/widgets/input.dart';
import 'package:reward_center_kiosk/util/widgets/network_img.dart';

class RedemptionOperationScreen extends StatelessWidget {
  RedemptionOperationScreen({super.key});
  final RedemptionController controller = Get.put(RedemptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(84),
        child: AppbarIcon(),
      ),
      body: Column(
        children: [
          Expanded(
            child: ReactiveForm(
              formGroup: controller.formGroup,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Processing redemption',
                          style: TextStyle(fontSize: 24 ,fontWeight: FontWeight.w600)),
                      const SizedBox(height: 16),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width:  195,
                              height: 90,
                              child: Avartar(
                                iconSize: 150,
                                isCircular: false,
                                imageUrl:
                                    'https://static.wikia.nocookie.net/naruto/images/4/4a/Obito_Uchiha.png/revision/latest/scale-to-width-down/1200?cb=20220223045744',
                              ),
                            ),
                                   
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text(
                                    "Leng hok hor",
                                    style: Get.textTheme.bodyLarge,
                                  ),
                                  Container(
                                    color: AppTheme.primaryColor.withAlpha(20),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Row(
                                      children: [
                                        const NetworkImg(
                                            height: 42,
                                            width: 42,
                                            src:
                                                "https://core.sgx.bz/files/s8server/vip/25/09/aceed8488b254f76baa750c59b283a8b.png"),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'member class',
                                          style: Get.textTheme.bodyLarge
                                              ?.copyWith(
                                                  color: AppTheme.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text("06-05-2025",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge)
                                  ],
                                )
                              ],
                            )
                          ])
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTheme.style.copyWith(
              color: Colors.black.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: AppTheme.style.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

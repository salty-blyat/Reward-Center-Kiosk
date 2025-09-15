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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(84),
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
                    // Member Info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 100,
                              child: Avartar(
                                isCircular: false,
                                iconSize: 100,
                                imageUrl:
                                    'https://static.wikia.nocookie.net/naruto/images/4/4a/Obito_Uchiha.png/revision/latest/scale-to-width-down/1200?cb=20220223045744',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Leng hokhor',
                                  style: AppTheme.style.copyWith(
                                    color: Colors.black,
                                    height: 1,
                                    fontSize: 58,
                                  ),
                                ),
                                Text(
                                  'Akatsuki',
                                  style: AppTheme.style.copyWith(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          formatCurrency(0, isPoint: true),
                          style: AppTheme.style.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Voucher Card
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          // Image
                          Container(
                            width: 100,
                            height: double.infinity,
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: const NetworkImg(
                              src:
                                  'https://img.freepik.com/free-vector/special-offer-buy-one-get-one-free-discount-coupon-background_1017-51061.jpg?semt=ais_hybrid&w=740&q=80',
                              height: 130,
                            ),
                          ),
                          // Content
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "controller.offer.value.name",
                                        style: AppTheme.style.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "controller.offer.value.offerTypeNameEn",
                                        style: AppTheme.style.copyWith(
                                          fontSize: 10,
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        formatCurrency(0, isPoint: true),
                                        style: AppTheme.style.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        height: 24,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              onTap: () => print('decrement'),
                                              child: const Icon(
                                                  CupertinoIcons.minus,
                                                  size: 18),
                                            ),
                                            const SizedBox(width: 8),
                                            ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                minWidth: 40,
                                                maxWidth: 60,
                                                minHeight: 36,
                                              ),
                                              child: Center(
                                                child:
                                                    ReactiveTextField<double>(
                                                  onChanged: (control) {
                                                    print(control);
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  formControlName: 'qty',
                                                  textAlign: TextAlign.center,
                                                  decoration:
                                                      const InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            GestureDetector(
                                              onTap: () => print('increment'),
                                              child: const Icon(
                                                  CupertinoIcons.plus,
                                                  size: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Transaction Summary
                    // Obx(
                    //   () => Container(
                    //     padding: const EdgeInsets.all(16),
                    //     width: double.infinity,
                    //     decoration: BoxDecoration(
                    //       color: Colors.black.withOpacity(0.04),
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           'Transaction Summary'.tr,
                    //           style: AppTheme.style.copyWith(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 14,
                    //           ),
                    //         ),
                    //         const SizedBox(height: 8),
                    //         _summaryRow(
                    //           'Current Balance'.tr,
                    //           formatCurrency(0, isPoint: true),
                    //         ),
                    //         _summaryRow(
                    //           '${'Redeem Cost'.tr} (x${controller.formGroup.control('qty').value})',
                    //           'asdjfldkasjflk',
                    //           color: AppTheme.dangerColor,
                    //         ),
                    //         Divider(
                    //           height: 20,
                    //           color: Colors.black.withOpacity(
                    //             0.1,
                    //           ),
                    //         ),
                    //         _summaryRow(
                    //           'Remaining Balance'.tr,
                    //           formatCurrency(0, isPoint: true),
                    //           // color: controller.remainBalance.value > 0
                    //           //     ? AppTheme.successColor
                    //           //     : controller.remainBalance.value < 0
                    //           //         ? AppTheme.dangerColor
                    //           //         : Colors.black,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyFormField(
                      label: 'Note'.tr,
                      controlName: 'note',
                      maxLines: 2,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Attachment'.tr,
                      style: AppTheme.style.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // FilePickerWidget(formGroup: controller.formGroup),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Button
          // O
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

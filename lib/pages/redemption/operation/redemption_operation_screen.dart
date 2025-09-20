import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reward_center_kiosk/pages/member/member_controller.dart';
import 'package:reward_center_kiosk/pages/redemption/operation/redemption_operation_controller.dart';
import 'package:reward_center_kiosk/route.dart';
import 'package:reward_center_kiosk/util/const.dart';
import 'package:reward_center_kiosk/util/theme.dart';
import 'package:reward_center_kiosk/util/widgets/appbar_icon.dart';
import 'package:reward_center_kiosk/util/widgets/avartar.dart';
import 'package:reward_center_kiosk/util/widgets/button.dart';
import 'package:reward_center_kiosk/util/widgets/input.dart';
import 'package:reward_center_kiosk/util/widgets/network_img.dart';
import 'package:reward_center_kiosk/util/widgets/player_class_badge.dart';

class RedemptionOperationScreen extends StatelessWidget {
  RedemptionOperationScreen({super.key});
  final RedemptionController controller = Get.put(RedemptionController());
  final MemberController memberController = Get.put(MemberController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.onReady();
    });

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
                      Text('Processing redemption'.tr,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 32),
                      _buildMemberInfo(),
                      const SizedBox(height: 32),
                      _buildGift(),
                      const SizedBox(height: 32),
                      _buildTranSummary(),
                      const SizedBox(height: 32),
                      _buildActionButton()
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    final MemberController memberController = Get.find<MemberController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MyButton(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textColor: AppTheme.defaultColor,
            label: "Cancel".tr,
            fontSize: 24,
            onPressed: () => Get.back()),
        const SizedBox(width: 32),
        ReactiveFormConsumer(builder: (context, form, child) {
          final remainingPoints = memberController.member.value.point! -
              controller.formGroup.control('totalPoint').value;
          Future.delayed(const Duration(milliseconds: 100));
          return MyButton(
              label: 'Redeem',
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              fontSize: 24,
              disabled: remainingPoints < 0 || !form.valid,
              onPressed: () async => await controller.submit());
        })
      ],
    );
  }

  Widget _buildGift() {
    final RedemptionController controller = Get.find<RedemptionController>();
    return Obx(() => Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: AppTheme.defaultColor.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4))
            ],
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 130,
              width: 130,
              child: NetworkImg(src: controller.gift.value.image, height: 130),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.gift.value.name ?? '-',
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                            "${Const.formatCurrency(controller.gift.value.cost ?? 0)}",
                            style: const TextStyle(fontSize: 24)),
                        const Spacer(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReactiveFormConsumer(
                              builder: (context, form, child) {
                                return Material(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1, color: AppTheme.defaultColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: form.control('quantity').value !=
                                                null &&
                                            form.control("quantity").value > 0
                                        ? () => controller.decrement()
                                        : null,
                                    child: SizedBox(
                                      width: 54,
                                      height: 42,
                                      child: Icon(Icons.remove,
                                          color: form
                                                          .control('quantity')
                                                          .value !=
                                                      null &&
                                                  form
                                                          .control("quantity")
                                                          .value >=
                                                      0
                                              ? Colors.black
                                              : AppTheme.defaultColor),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 4),
                            const SizedBox(
                              width: 110,
                              height: 56,
                              child: MyFormField(
                                  textAlign: TextAlign.center,
                                  controlName: "quantity",
                                  textInputType: TextInputType.number),
                            ),
                            const SizedBox(width: 4),
                            Material(
                              color: AppTheme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                onTap: () => controller.increment(),
                                child: const SizedBox(
                                  width: 54,
                                  height: 42,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }

  Widget _buildTranSummary() {
    final RedemptionController controller = Get.find<RedemptionController>();
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: AppTheme.defaultColor.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4))
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Transaction Summary".tr,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
            const SizedBox(height: 32),
            _buildRowTranSum(
                title: "Current Balance".tr,
                value:
                    "${Const.formatCurrency(memberController.member.value.point)}"),
            const SizedBox(height: 12),
            _buildRowTranSum(
                title: "Quantity".tr,
                value: "x${controller.formGroup.control('quantity').value}"),
            const SizedBox(height: 12),
            ReactiveFormConsumer(
              builder: (context, form, child) {
                return _buildRowTranSum(
                    title: "Cost per item".tr,
                    value:
                        "${Const.formatCurrency(form.control('unitCost').value)}");
              },
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            ReactiveFormConsumer(
              builder: (context, form, child) {
                return _buildRowTranSum(
                    title: "Total Cost".tr,
                    value:
                        "${Const.formatCurrency(form.control('totalPoint').value)}");
              },
            ),
            ReactiveFormConsumer(
              builder: (context, form, child) {
                final remainingPoints = memberController.member.value.point! -
                    form.control('totalPoint').value;
                return _buildRowTranSum(
                    title: "Remaining Points".tr,
                    color: remainingPoints < 0
                        ? AppTheme.dangerColor
                        : Colors.black,
                    value: "${Const.formatCurrency(remainingPoints)}");
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildRowTranSum(
      {required String title, Color? color, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 20, color: color),
        )
      ],
    );
  }

  Widget _buildMemberInfo() {
    return Obx(() {
      return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 84,
          width: 84,
          child: Avartar(
            iconSize: 42,
            imageUrl: memberController.member.value.photo,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              Row(children: [
                Text(
                  memberController.member.value.name ?? "-",
                  style: Get.textTheme.titleMedium,
                ),
                const Spacer(),
                PlayerClassBadge(
                    size: 24,
                    playerClass:
                        memberController.member.value.playerClassName ?? '-'),
              ]),
              Row(
                children: [
                  Text(
                      "${'Member since'.tr}: ${Const.getDate(memberController.member.value.joinDate)}",
                      style: Get.textTheme.bodyMedium
                          ?.copyWith(color: AppTheme.defaultColor)),
                ],
              )
            ],
          ),
        )
      ]);
    });
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

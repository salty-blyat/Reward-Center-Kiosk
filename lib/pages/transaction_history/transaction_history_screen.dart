import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/model/transaction_model.dart';
import 'package:reward_center_kiosk/pages/transaction_history/transaction_detail_screen.dart';
import 'package:reward_center_kiosk/pages/transaction_history/transaction_history_controller.dart';
import 'package:reward_center_kiosk/util/const.dart';
import 'package:reward_center_kiosk/util/theme.dart';
import 'package:reward_center_kiosk/util/widgets/appbar_icon.dart';
import 'package:reward_center_kiosk/util/widgets/loading.dart';
import 'package:reward_center_kiosk/util/widgets/not_found.dart';

class TransactionHistoryScreen extends StatelessWidget {
  TransactionHistoryScreen({super.key});
  final TransactionHistoryController controller =
      Get.put(TransactionHistoryController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await controller.search();
    });
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(84),
          child: AppbarIcon(),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 16),
            Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text('Transaction History'.tr,
                     style: const TextStyle(
                        fontSize: 24 ,fontWeight: FontWeight.w600))),
            const SizedBox(height: 16),
            Expanded(child: Obx(() {
              if (controller.loading.value) {
                return const Center(child: Loading());
              } else if (controller.list.isEmpty) {
                return const Center(child: NotFound());
              }

              return RefreshIndicator(
                onRefresh: () async {
                  Future.delayed(Duration.zero, () async {
                    await controller.search();
                  });
                },
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: controller.list.length,
                  itemBuilder: (context, index) {
                    final transaction = controller.list[index];
                    return _transaction(transaction);
                  },
                ),
              );
            })),
          ]),
        ));
  }
}

Widget _transaction(TransactionModel transaction) {
  return Column(
    children: [
      Material(
        elevation: 0.5,
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          splashColor: AppTheme.primaryColor.withOpacity(0.2),
          // onTap: () => Get.dialog(Dialog(child: TransactionDetailScreen())),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Const.getTransType(transaction.transType ?? 0),
                          style: Get.textTheme.bodyMedium),
                      const SizedBox(height: 4),
                      Text(
                          Const.getDateTime(
                              transaction.transDate ?? DateTime.now()),
                          style: Get.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Text( 
                  '${transaction.point ?? 0} pts',
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: transaction.point != null
                        ? transaction.point! > 0
                            ? AppTheme.successColor
                            : transaction.point! < 0
                                ? AppTheme.dangerColor
                                : Colors.black
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 12,
      )
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:reward_center_kiosk/model/transaction_model.dart';
import 'package:reward_center_kiosk/pages/transaction_history/transaction_detail.dart';
import 'package:reward_center_kiosk/util/const.dart';
import 'package:reward_center_kiosk/util/theme.dart';
import 'package:reward_center_kiosk/util/widgets/appbar_icon.dart';

class TransactionHistoryScreen extends StatelessWidget {
  TransactionHistoryScreen({super.key});
  final List<TransactionModel> mockTransactions = [
    TransactionModel(
      transNo: 'TXN001',
      transDate: DateTime.now().subtract(const Duration(days: 1)),
      amount: 10,
      typeNameEn: 'Purchase',
      offerName: 'Coffee Coupon',
    ),
    TransactionModel(
      transNo: 'TXN002',
      transDate: DateTime.now().subtract(const Duration(days: 2)),
      amount: -5,
      typeNameEn: 'Refund',
      offerName: 'Snack Coupon',
    ),
    TransactionModel(
      transNo: 'TXN003',
      transDate: DateTime.now(),
      amount: 20,
      typeNameEn: 'Reward',
      offerName: 'Gift Voucher',
    ),
    TransactionModel(
      transNo: 'TXN003',
      transDate: DateTime.now(),
      amount: 20,
      typeNameEn: 'Reward',
      offerName: 'Gift Voucher',
    ),
    TransactionModel(
      transNo: 'TXN003',
      transDate: DateTime.now(),
      amount: 20,
      typeNameEn: 'Reward',
      offerName: 'Gift Voucher',
    ),
    TransactionModel(
      transNo: 'TXN003',
      transDate: DateTime.now(),
      amount: 20,
      typeNameEn: 'Reward',
      offerName: 'Gift Voucher',
    ),
    TransactionModel(
      transNo: 'TXN003',
      transDate: DateTime.now(),
      amount: 20,
      typeNameEn: 'Reward',
      offerName: 'Gift Voucher',
    ),
    TransactionModel(
      transNo: 'TXN003',
      transDate: DateTime.now(),
      amount: 20,
      typeNameEn: 'Reward',
      offerName: 'Gift Voucher',
    ),
    TransactionModel(
      transNo: 'TXN003',
      transDate: DateTime.now(),
      amount: 20,
      typeNameEn: 'Reward',
      offerName: 'Gift Voucher',
    ),
    TransactionModel(
      transNo: 'TXN003',
      transDate: DateTime.now(),
      amount: 20,
      typeNameEn: 'Reward',
      offerName: 'Gift Voucher',
    ),
    TransactionModel(
      transNo: 'TXN003',
      transDate: DateTime.now(),
      amount: 20,
      typeNameEn: 'Reward',
      offerName: 'Gift Voucher',
    ),
    TransactionModel(
      transNo: 'TXN003',
      transDate: DateTime.now(),
      amount: 20,
      typeNameEn: 'Reward',
      offerName: 'Gift Voucher',
    ),
    TransactionModel(
      transNo: 'TXN003',
      transDate: DateTime.now(),
      amount: 20,
      typeNameEn: 'Reward',
      offerName: 'Gift Voucher',
    ),
    TransactionModel(
      transNo: 'TXN003',
      transDate: DateTime.now(),
      amount: 20,
      typeNameEn: 'Reward',
      offerName: 'Gift Voucher',
    ),
    TransactionModel(
      transNo: 'TXN003',
      transDate: DateTime.now(),
      amount: 20,
      typeNameEn: 'Reward',
      offerName: 'Gift Voucher',
    ),
    TransactionModel(
      transNo: 'TXN003',
      transDate: DateTime.now(),
      amount: 20,
      typeNameEn: 'Reward',
      offerName: 'Gift Voucher',
    ),
    TransactionModel(
      transNo: 'TXN003',
      transDate: DateTime.now(),
      amount: 20,
      typeNameEn: 'Reward',
      offerName: 'Gift Voucher',
    ),
    TransactionModel(
      transNo: 'TXN003',
      transDate: DateTime.now(),
      amount: 20,
      typeNameEn: 'Reward',
      offerName: 'Gift Voucher',
    ),
    TransactionModel(
      transNo: 'TXN003',
      transDate: DateTime.now(),
      amount: 20,
      typeNameEn: 'Reward',
      offerName: 'Gift Voucher',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(84),
          child: AppbarIcon(),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                'Transaction History'.tr,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: mockTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = mockTransactions[index];
                  return _transaction(transaction);
                },
              ),
            ),
          ]),
        ));
  }
}

Widget _transaction(TransactionModel transaction) {
  return Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      splashColor: AppTheme.primaryColor.withOpacity(0.2),
      onTap: () => Get.dialog(Dialog(child: TransactionDetail())),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${transaction.typeNameEn} ${transaction.offerName}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    Const.getDateTime(transaction.transDate ?? DateTime.now()),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Text(
              '${transaction.amount?.toStringAsFixed(0) ?? 0} pts',
              style: TextStyle(
                color: transaction.amount != null
                    ? transaction.amount! > 0
                        ? AppTheme.successColor
                        : transaction.amount! < 0
                            ? AppTheme.dangerColor
                            : Colors.black
                    : Colors.black,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

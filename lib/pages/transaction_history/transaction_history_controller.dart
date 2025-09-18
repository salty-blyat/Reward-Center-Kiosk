import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/helpers/storage.dart';
import 'package:reward_center_kiosk/model/member_model.dart';
import 'package:reward_center_kiosk/model/transaction_model.dart';
import 'package:reward_center_kiosk/pages/transaction_history/transaction_history_service.dart';


enum TransactionTypeEnum {
  open,
  fill,
  credit,
  drop,
  count,
  update,
  close,
}

extension TransactionTypeEnumExtension on TransactionTypeEnum {
  static const Map<TransactionTypeEnum, int> _values = {
    TransactionTypeEnum.open: 1,
    TransactionTypeEnum.fill: 2,
    TransactionTypeEnum.credit: 3,
    TransactionTypeEnum.drop: 4,
    TransactionTypeEnum.count: 5,
    TransactionTypeEnum.update: 6,
    TransactionTypeEnum.close: 7,
  };

  int get value => _values[this]!;
}

class TransactionHistoryController extends GetxController {
  final loading = false.obs;
  RxList<TransactionModel> list = <TransactionModel>[].obs;
  final TransactionHistoryService service = TransactionHistoryService();
  final storage = InMemoryStorage();

  @override
  void onInit() async {
    super.onInit();
    Future.delayed(Duration.zero, () async {
      await search();
    });
  }

  Future<void> search() async {
    try {
      loading.value = true;
      final member = loadCurrentMember();
      var res = await service.search(member.id.toString());
      list.assignAll(res);
    } catch (e) {
      loading.value = false;
      print("Error getting transaction history $e");
    } finally {
      loading.value = false;
    }
  }

  MemberModel loadCurrentMember() {
    final data = storage.read("member");
    final Map<String, dynamic> map = jsonDecode(data as String);
    return MemberModel.fromJson(map);
  }
}

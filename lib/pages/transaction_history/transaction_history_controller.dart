import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/helpers/storage.dart';
import 'package:reward_center_kiosk/model/member_model.dart';
import 'package:reward_center_kiosk/model/transaction_model.dart';
import 'package:reward_center_kiosk/pages/transaction_history/transaction_history_service.dart';

enum TransactionTypeEnum {
  adjust,
  topup,
  order,
  earn,
  redeem,
  reverse,
  expired
}

extension TransactionTypeEnumExtension on TransactionTypeEnum {
  static const Map<TransactionTypeEnum, int> _values = {
    TransactionTypeEnum.adjust: 1,
    TransactionTypeEnum.topup: 101,
    TransactionTypeEnum.order: 102,
    TransactionTypeEnum.earn: 201,
    TransactionTypeEnum.redeem: 202,
    TransactionTypeEnum.reverse: 203,
    TransactionTypeEnum.expired: 204,
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
      final member = await loadCurrentMember();
      var res = await service.search(member.id.toString());
      list.assignAll(res);
    } catch (e) {
      loading.value = false;
      print("Error getting transaction history $e");
    } finally {
      loading.value = false;
    }
  }

  Future<MemberModel> loadCurrentMember() async {
    final data = await storage.read(StorageKeys.member);
    final Map<String, dynamic> map = jsonDecode(data as String);
    return MemberModel.fromJson(map);
  }
}

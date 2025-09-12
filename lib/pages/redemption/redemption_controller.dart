import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/helpers/base_service.dart';
import 'package:reward_center_kiosk/model/redemption_model.dart';
import 'package:reward_center_kiosk/pages/redemption/redemption_service.dart';


class RedemptionHistoryController extends GetxController
    with SingleGetTickerProviderMixin {
  late TabController tabController; 
  final lists = [].obs;
  final loading = false.obs;
  final canLoadMore = false.obs;
  final isLoadingMore = false.obs;
  final id = 0.obs;
  final isLoadingDetail = false.obs;
  final detail = RedemptionModel().obs;
  final locationId = 0.obs;
  final offerGroupId = 0.obs;
  final isRedeem = false.obs;
  final isRedeemView = false.obs;
  final isReeemHistory = false.obs;
  final param = QueryParam(
    pageIndex: 1,
    pageSize: 25,
    sorts: 'redeemedDate-',
    filters: '[]',
  ).obs;
  final RedemptionService service = RedemptionService();
  @override
  onInit() {
    super.onInit();
    // setPermission();
    tabController = TabController(length: 3, vsync: this);
  }

  // setPermission() {
  //   isRedeem.value =
  //       _authController.isAuthorized(AuthKeys.APP__REDEMPTION__ADD);
  //   isReeemHistory.value =
  //       _authController.isAuthorized(AuthKeys.APP__REDEMPTION__LIST);
  //   isRedeemView.value =
  //       _authController.isAuthorized(AuthKeys.APP__REDEMPTION__VIEW);
  //   int length = 1;

  //   // if (isRedeem.isTrue) length++;
  //   if (isReeemHistory.isTrue) length++;

  // }

  Future<void> search() async {
    final filters = [
      // {'field': 'status', 'operator': 'neq', 'value': RedemptionEnum.removed}
    ];
    if (id.value != 0) {
      filters.add({'field': 'memberId', 'operator': 'eq', 'value': id.value});
    }
    if (offerGroupId.value != 0) {
      filters.add({
        'field': 'offerGroupId',
        'operator': 'eq',
        'value': offerGroupId.value
      });
    }
    if (locationId.value != 0) {
      filters.add(
          {'field': 'locationId', 'operator': 'eq', 'value': locationId.value});
    }
    loading.value = true;
    try {
      param.update((params) {
        params?.pageIndex = 1;
      });
      param.value.filters = jsonEncode(filters);
      final result = await service.getByMemberId(param.value, id.value);
      lists.value = result.results;
      canLoadMore.value = result.results.length == param.value.pageSize;
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  Future<void> onLoadMore() async {
    if (!canLoadMore.value) return;

    isLoadingMore.value = true;
    param.update((params) {
      params?.pageIndex = (params.pageIndex ?? 0) + 1;
    });

    try {
      // final response = await service.getByMemberId(param.value, id.value);
      // lists.addAll(response.results);
      // canLoadMore.value = response.results.length == param.value.pageSize;
    } catch (e) {
      canLoadMore.value = false;
      print("Error during onLoadMore: $e");
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> find(int id) async {
    isLoadingDetail.value = true;
    try {
      // final member = await service.getTransactionById(id);
      // detail.value = member;
      isLoadingDetail.value = false;
    } catch (e) {
      isLoadingDetail.value = false;
    } finally {}
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/helpers/base_service.dart';
import 'package:reward_center_kiosk/model/offer_model.dart';
import 'package:reward_center_kiosk/pages/offer/offer_service.dart';

enum OfferTypes {
  gift,
  coupon,
  voucher,
}

extension AccountTypesExtension on OfferTypes {
  static const Map<OfferTypes, int> _values = {
    OfferTypes.gift: 1,
    OfferTypes.coupon: 2,
    OfferTypes.voucher: 3,
  };

  int get value => _values[this]!;
}

class OfferController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController; 

  final OfferService service = OfferService();
  final lists = [].obs;
  final available = <OfferModel>[].obs;
  final selectedOffer = Rxn<OfferModel>();
  final offerGroupId = 0.obs;
  final isLoading = false.obs;
  final canLoadMore = false.obs;
  final isLoadingMore = false.obs;
  final isRedeemList = false.obs;
  final isOfferList = false.obs;
  final param = QueryParam(
    pageIndex: 1,
    pageSize: 25,
    sorts: '',
    filters: '[]',
  ).obs;
  @override
  onInit() async {
    tabController = TabController(length: 2, vsync: this); 
    search();
    super.onInit();
  }

  Future<void> getAvailables(int id, int offerGroupId) async {
    isLoading.value = true;
    try {
      final result = await service.available(id, offerGroupId);
      available.value = result;
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> search() async {
    isLoading.value = true;

    try {
      // Build filters
      final List<Map<String, dynamic>> filters = [];

      if (offerGroupId.value != 0) {
        filters.add({
          'field': 'offerGroupId',
          'operator': 'eq',
          'value': offerGroupId.value,
        });
      }

      // Reset page index and list
      param.update((params) {
        params?.pageIndex = 1;
      });
      lists.value = [];

      // Set filters and perform search
      param.value.filters = jsonEncode(filters);
      final result = await service.search(param.value);
      lists.value = result.results;
      canLoadMore.value = result.results.length == param.value.pageSize;
    } catch (e) {
      print('Search error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onLoadMore() async {
    if (!canLoadMore.value) return;

    isLoadingMore.value = true;
    param.update((params) {
      params?.pageIndex = (params.pageIndex ?? 0) + 1;
    });

    try {
      final response = await service.search(param.value);
      lists.addAll(response.results);
      canLoadMore.value = response.results.length == param.value.pageSize;
    } catch (e) {
      canLoadMore.value = false;
    } finally {
      isLoadingMore.value = false;
    }
  }
}

import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/helpers/storage.dart';
import 'package:reward_center_kiosk/model/location_model.dart';
import 'package:reward_center_kiosk/model/member_detail_model.dart';
import 'package:reward_center_kiosk/model/member_model.dart';
import 'package:reward_center_kiosk/model/offer_model.dart';
import 'package:reward_center_kiosk/pages/home/home_controller.dart';
import 'package:reward_center_kiosk/pages/member/member_service.dart';
import 'package:reward_center_kiosk/util/widgets/modal.dart';

class MemberController extends GetxController {
  final isLoading = false.obs;
  final HomeController homeController = Get.put(HomeController());
  final isLoadingOffer = false.obs;
  final cardNumber = ''.obs;
  final MemberService service = MemberService();
  final member = MemberModel().obs;
  RxList<OfferModel> listOffer = <OfferModel>[].obs;
  final storage = InMemoryStorage();


@override
  void onReady() async {
     super.onReady();
     if (Get.arguments != null && Get.arguments['cardNumber'] != null) {
      cardNumber.value = Get.arguments['cardNumber'];
      await find(cardNumber.value);
      await availableOffer();
    }
  } 

  Future<void> availableOffer() async {
    try {
      isLoadingOffer.value = true;
      final selectedLocation = await storage.loadDataAsync<LocationModel>(StorageKeys.selectedLocation, LocationModel.fromJson);

      if (member.value.id == null || selectedLocation?.id == null) {
        print("Member id or location id null");
        return;
      }
      final response = await service.availableOffer(
          playerId: member.value.id.toString(),
          locationId: selectedLocation!.id.toString());
      listOffer.assignAll(response);
    } catch (e) {
      isLoadingOffer.value = false;
    } finally {
      isLoadingOffer.value = false;
    }
  }

  Future<void> find(String id) async {
    // by card
    isLoading.value = true;
    try {
      final response = await service.findByCard(id);
      await setMemberData(response);
      member.value = response;
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  } 

  Future<bool> checkExistUser(String id) async {
    try {
      MemberModel member = await service.findByCard(id);
      if (member != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> setMemberData(MemberModel model) async {
    await storage.write(StorageKeys.member, jsonEncode(model.toJson()));
  }
}

import 'dart:convert';

import 'package:get/get.dart';
import 'package:reward_center_kiosk/app_setting.dart';
import 'package:reward_center_kiosk/helpers/storage.dart';
import 'package:reward_center_kiosk/model/company_model.dart';
import 'package:reward_center_kiosk/model/location_model.dart';
import 'package:reward_center_kiosk/pages/home/home_service.dart';

class HomeController extends GetxController {
  final HomeService service = HomeService();
  final storage = InMemoryStorage();
  Rx<CompanyModel> companyInfo = CompanyModel().obs;
  RxList<LocationModel> locations = <LocationModel>[].obs;
  RxBool loadingLocation = false.obs;
  Rx<LocationModel?> selectedLocation = LocationModel().obs;

  @override
  void onInit() async {
    super.onInit();
    await setCompanyInfoAsync();
    companyInfo.value = await loadCompanyFromStorage();
    final location = await storage.loadDataAsync<LocationModel>(StorageKeys.selectedLocation, LocationModel.fromJson);
    if (location != null) {
      Future.delayed(Duration.zero, () => selectedLocation.value = location);
    }
  }

  Future<void> getCompanyInfo() async {
    try {
      var res = await service.getCompanyInfo();
      companyInfo.value = res;
    } catch (e) {
      print("error on :  $e");
    }
  }

  Future<void> getLocations() async {
    loadingLocation.value = true;
    try {
      var res = await service.getLocations();
      locations.assignAll(res);
      loadingLocation.value = false;
      print('locations: ${locations.toJson()}');
    } catch (e) {
      loadingLocation.value = false;
      print("error on :  $e");
    } finally {
      loadingLocation.value = false;
    }
  }

  // utils
  Future<void> saveLocation(LocationModel model) async {
    selectedLocation.value = model;
    await storage.write("selected_location", jsonEncode(model.toJson()));
  }

  Future<void> setCompanyInfoAsync() async {
    await getCompanyInfo();
    final Map<String, dynamic> model = companyInfo.value.toJson();
    await storage.write("company", jsonEncode(model));
  }

  Future<CompanyModel> loadCompanyFromStorage() async {
    String model = await storage.read(StorageKeys.company);
    if (model.isEmpty) {
      return CompanyModel();
    }
    return CompanyModel.fromJson(jsonDecode(model));
  }
}

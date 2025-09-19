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
    loadCompanyFromStorage();
    loadSelectedLocation(); 
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
  void saveLocation(LocationModel model) {
    selectedLocation.value = model;
    storage.write("selected_location", jsonEncode(model.toJson()));
  }

  LocationModel? loadSelectedLocation() {
    final data = storage.read("selected_location");

    if (data == null) return null;
    if (data is String) {
      final Map<String, dynamic> map = jsonDecode(data as String);
      final location = LocationModel.fromJson(map);
      Future.delayed(Duration.zero , () =>  
      selectedLocation.value = location 
      );
      return location;
    }
    return null;
  }

  Future<void> setCompanyInfoAsync() async {
    await getCompanyInfo();
    final Map<String, dynamic> json = companyInfo.value.toJson();

    json.forEach((key, value) {
      if (value != null) {
        storage.write("company_$key", value.toString());
      }
    });
  }

  CompanyModel loadCompanyFromStorage() {
    final json = <String, dynamic>{};

    final sample = CompanyModel();
    sample.toJson().keys.forEach((key) {
      final value = storage.read("company_$key");

      if (value != null) {
        json[key] =
            key == "passcodeThresholdPoint" ? int.tryParse(value) : value;
      }
    });
    print('company info: ${json}');
    return CompanyModel.fromJson(json);
  }
}

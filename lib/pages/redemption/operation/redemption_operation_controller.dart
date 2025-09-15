import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reward_center_kiosk/helpers/common_validators.dart';
import 'package:reward_center_kiosk/util/widgets/loading.dart';

class RedemptionController extends GetxController {
  RxBool loading = false.obs;

  final FormGroup formGroup = fb.group({
    'qty': FormControl<double>(value: 1.0, validators: [
      Validators.delegate(CommonValidators.required),
      Validators.delegate(CommonValidators.mustBiggerThanZero),
    ]),
    'note': FormControl<String?>(validators: []),
    'attachments': FormControl<List<dynamic>>(
      value: [],
    ),
  });

  Future<void> submit() async {
    loading.value = true;

    try {} catch (e) {
      loading.value = false;
    }

    loading.value = false;
  }

  @override
  void onClose() {
    formGroup.dispose();
    super.onClose();
  }
}

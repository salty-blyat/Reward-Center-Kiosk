import "dart:async";

import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:reward_center_kiosk/util/services/audio_service.dart";
import "package:reward_center_kiosk/util/services/printer_service.dart";

// import "package:test_kiosk_v2/services/audio_service.dart";

class PrinterController extends GetxController {
  PrinterService service = PrinterService();
  AudioService audioService = AudioService();
  RxString message = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    message.value = await service.initPrinter() ?? 'No message.';
  }

  Future<void> printTest() async {
    var res = await service.printTest();
    Timer(
        Duration(seconds: 2), () async => await audioService.playClaimTicket());

    message.value = res ?? 'No message in printTest()';
  }
}

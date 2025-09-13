import 'package:flutter/services.dart';

class PrinterService {
  static const _channel = MethodChannel('printer_channel');

  Future<String?> initPrinter() async {
    try {
      var response = await _channel.invokeMethod('initPrinter');
      print(response);
      return response;
    } on PlatformException catch (e) {
      print("Init failed: ${e.message}");
      return e.message;
    }
  }

  Future<String?> printTest() async {
    try {
      final result = await _channel.invokeMethod('printTest');
      return result;
    } on PlatformException catch (e) {
      print("Failed to print: '${e.message}'.");
      return e.message;
    }
  }
}

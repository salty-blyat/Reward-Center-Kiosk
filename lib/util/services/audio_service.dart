import 'package:flutter/services.dart';
// enum Audio {
//   completed("assets/post-print.mp3"),

//   final String label;

//   const OrderStatus(this.label);

//   bool get isFinal => this == OrderStatus.completed || this == OrderStatus.cancelled;
// }

class AudioService {
  static const _channel = MethodChannel('printer_channel');

  Future<void> playWelcome() async {
    await _channel.invokeMethod('playAudio', {'file': "welcome"});
  }

  Future<void> playPreprint() async {
    await _channel.invokeMethod('playAudio', {'file': "preprint"});
  }

  Future<void> playClaimTicket() async {
    await _channel.invokeMethod('playAudio', {'file': "claimticket"});
  }
}

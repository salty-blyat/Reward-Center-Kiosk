import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reward_center_kiosk/pages/transaction_history/transaction_history_controller.dart';

class Const {
  static const String version = '1.9';
  static const String date = '06-06-2025';

  static String numberFormat(double value) {
    return NumberFormat('###.##').format(value);
  }

  static String formatCardNumber(String cardNumber) {
    return cardNumber
        .replaceAllMapped(
          RegExp(r".{1,3}"), // split every 4 chars
          (match) => "${match.group(0)} ",
        )
        .trim();
  }
static formatCurrency(dynamic amount, {bool isPoint = true}) {
    if (isPoint) {
      return '${NumberFormat('#,##0.##', 'en_US').format(amount)} pts';
    }
    return '\$ ${NumberFormat('#,##0.00', 'en_US').format(amount)}';
  }

  static String getTransType(int tran) {
    print('tran $tran');
    if (tran == TransactionTypeEnum.adjust.value) {
      return "Adjust";
    } else if (tran == TransactionTypeEnum.topup.value) {
      return "Topup";
    } else if (tran == TransactionTypeEnum.order.value) {
      return "Order";
    } else if (tran == TransactionTypeEnum.earn.value) {
      return "Earn";
    } else if (tran == TransactionTypeEnum.redeem.value) {
      return "Redeem";
    } else if (tran == TransactionTypeEnum.reverse.value) {
      return "Reverse";
    } else if (tran == TransactionTypeEnum.expired.value) {
      return "Expired";
    } else {
      return "Transaction Type Not found";
    }
  }

  static String getDateTime(DateTime? dateTime) {
    if (dateTime == null) return '-';
    return DateFormat('dd-MM-yyyy HH:mm').format(dateTime.toLocal());
  }

  static String prettyDate(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    } else if (diff.inDays < 30) {
      final weeks = (diff.inDays / 7).floor();
      return '${weeks}w ago';
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return '${months}mo ago';
    } else {
      final years = (diff.inDays / 365).floor();
      return '${years}y ago';
    }
  }

  static String getDate(DateTime? dateTime) {
    if (dateTime == null) return '-';
    return DateFormat('dd-MM-yyyy').format(dateTime.toLocal());
  }

  static const Map<String, String> authorized = {
    'Authorized': 'authorized',
    'Lang': 'lang',
  };
  static const List<Map<String, dynamic>> languages = [
    {
      'key': Locale('en'),
      'label': 'English',
      'image': 'assets/images/en_FLAG.png',
      'code': 'en'
    },
    {
      'key': Locale('zh'),
      'label': 'Chinese',
      'image': 'assets/images/zh_FLAG.png',
      'code': 'zh'
    },
    {
      'key': Locale('vi'),
      'label': 'Vietnamese',
      'image': 'assets/images/vi_FLAG.png',
      'code': 'vi'
    },
  ];
}

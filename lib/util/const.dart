import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Const {
  static const String version = '1.9';
  static const String date = '06-06-2025';

  static String numberFormat(double value) {
    return NumberFormat('###.##').format(value);
  }

  static String getDateTime(DateTime? dateTime) {
    if (dateTime == null) return '-';
    return DateFormat('dd-MM-yyyy HH:mm').format(dateTime.toLocal());
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

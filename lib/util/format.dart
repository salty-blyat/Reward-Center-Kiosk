 
import 'package:intl/intl.dart';
import 'package:decimal/decimal.dart';

// String formatPoint(double amount) {
//   return '${NumberFormat('#,##0', 'en_US').format(amount)} pts';
// }

// String formatWallet(double amount) {
//   return '\$ ${NumberFormat('#,##0.00', 'en_US').format(amount)}';
// }

formatCurrency(dynamic amount, {bool isPoint = false}) {
  if (isPoint) {
    return '${NumberFormat('#,##0.##', 'en_US').format(amount)} pts';
  }
  return '\$ ${NumberFormat('#,##0.00', 'en_US').format(amount)}';
}

double formatCurrencyToDouble(double amount) {
  return Decimal.parse(
          NumberFormat('#,##0.00', 'en_US').format(amount).replaceAll(',', ''))
      .toDouble();
}

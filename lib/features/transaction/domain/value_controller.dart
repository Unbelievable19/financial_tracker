import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class ValueController extends ChangeNotifier {
  String rawInput = "";
  bool isDecimal = false;

  void onKeyTap(String key) {
    if (decimalDigits == 2 && key != "") return;
    if (isDecimal && key == ".") return;
    if (key == "" && rawInput.isNotEmpty) {
      if (isDecimal && rawInput.endsWith("0")) {
        rawInput = rawInput.substring(0, rawInput.length - 2);
      } else {
        rawInput = rawInput.substring(0, rawInput.length - 1);
      }
      isDecimal = rawInput.contains(".");
      notifyListeners();
      return; 
    }
    rawInput += key;
    isDecimal = rawInput.contains(".");
    notifyListeners();
  }

  int get decimalDigits {
    final splitted = rawInput.split(".");
    if (splitted.length == 1) return 0;
    return splitted.last.length;
  }
  int get value {
    final parsed = double.tryParse(rawInput) ?? 0;
    return (parsed * 100).toInt();

  }

  void setInitialValue(int valueKopecks) {
    if (valueKopecks % 100 == 0) {
      rawInput = (valueKopecks / 100).toInt().toString();
      notifyListeners();
      return;
    }
    rawInput = (valueKopecks / 100).toString();
    isDecimal = rawInput.contains(".");
    notifyListeners();
  }

  String get formatted => NumberFormat.currency(
    locale: "ru_RU",
    symbol: "₽",
    decimalDigits: isDecimal ? 2 : 0,
  ).format(double.tryParse(rawInput) ?? 0);
}

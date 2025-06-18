import 'package:financial_tracker/core/data/db/database.dart';
import 'package:financial_tracker/core/theme/theme.dart';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  AppColorsExtension get colors => theme.extension<AppColorsExtension>()!;
  Size get sizeScreen => MediaQuery.of(this).size;

  // MediaQueryData get mediaQuery => MediaQuery.of(this);
  // Size get sizeScreen => mediaQuery.size;

}

extension ColorToHexExtension on Color {
  String get hex {
    final red = (r * 255).toInt().toRadixString(16).padLeft(2, "0");
    final green = (g * 255).toInt().toRadixString(16).padLeft(2, "0");
    final blue = (b * 255).toInt().toRadixString(16).padLeft(2, "0");
    final alpha = (a * 255).toInt().toRadixString(16).padLeft(2, "0");

    return "$alpha$red$green$blue";
  }
}

extension CategoryColorExtension on Category {
  Color get flutterColor {
    final parsed = int.tryParse(color, radix: 16);
    if (parsed == null) return Colors.black;
    return Color(parsed);
  }
}

extension ShouldInvertOverlayTextColorExt on Color {
  Color maybeInvertedTextColor(Color onDark, Color onLight) {
    if (computeLuminance() > 0.5) return onLight;
    return onDark;
  }
}



extension DateExtenion on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool get isToday {
    final now = DateTime.now();
    return isSameDay(now);
  }

  DateTime get roundToDayStart => DateTime(year, month, day);

  DateTime get roundToDayEnd => DateTime(year, month, day, 23, 59, 59);
}

extension CapitalizeFirstLetterExt on String {
  String capitalizeFirstLetter() {
    return replaceRange(0, 1, this[0].toUpperCase());
  }
}

import 'package:flutter/material.dart';

class ChartSegment {
  final int? categoryId;
  final String title;
  final Color? color;
  final int valueKopecks;

  ChartSegment({
    required this.categoryId,
    required this.title,
    required this.color,
    required this.valueKopecks,
  });
}

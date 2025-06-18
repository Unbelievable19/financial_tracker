import 'package:auto_size_text/auto_size_text.dart';
import 'package:financial_tracker/core/misc/utils.dart';
import 'package:flutter/material.dart';

class TotalTile extends StatelessWidget {
  const TotalTile({
    super.key,
    required this.label,
    required this.icon,
    required this.valueKopecks,
    required this.gradient,
    this.textColor,
    required this.isLoaded,
  });

  final String label;
  final Icon icon;
  final int valueKopecks;
  final LinearGradient gradient;
  final Color? textColor;
  final bool isLoaded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icon,
              SizedBox(width: 8),
              Text(label, style: TextStyle(color: textColor)),
            ],
          ),
          SizedBox(height: 4),
          SizedBox(
            height: 32,
            child: Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    AppFormatters.convertKopecsToRublesAndFormat(valueKopecks),
                    minFontSize: 9,
                    maxFontSize: 22,
                    style: TextStyle(
                      fontSize: 22,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:financial_tracker/core/misc/extensions.dart';
import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  const TabButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isSelected,
    required this.verticalInset,
  });

  final Icon icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;
  final double verticalInset;

  @override
  Widget build(BuildContext context) {
    final width = context.sizeScreen.width * 0.4;
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: verticalInset),
            child: Material(
              child: InkWell(
                onTap: () => onTap(),
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: width,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon,
                      if (isSelected) SizedBox(width: 8),
                      if (isSelected) Text(label),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

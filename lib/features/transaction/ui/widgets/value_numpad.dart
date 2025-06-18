import 'package:financial_tracker/core/misc/extensions.dart';
import 'package:flutter/material.dart';

class ValueNumpad extends StatelessWidget {
  const ValueNumpad({super.key, required this.onTap});
  final Function(String key) onTap;

  @override
  Widget build(BuildContext context) {
    final size = context.sizeScreen;
    final horizontalSpacing = size.width * 0.05;
    final verticalSpacing = size.height * 0.02;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //боттом экшнс сделать в боттом щите
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: horizontalSpacing,
          children: [
            NumpadKey(symbol: "1", onTap: () => onTap("1")),
            NumpadKey(symbol: "2", onTap: () => onTap("2")),
            NumpadKey(symbol: "3", onTap: () => onTap("3")),
          ],
        ),
        SizedBox(height: verticalSpacing),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: horizontalSpacing,
          children: [
            NumpadKey(symbol: "4", onTap: () => onTap("4")),
            NumpadKey(symbol: "5", onTap: () => onTap("5")),
            NumpadKey(symbol: "6", onTap: () => onTap("6")),
          ],
        ),
        SizedBox(height: verticalSpacing),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: horizontalSpacing,
          children: [
            NumpadKey(symbol: "7", onTap: () => onTap("7")),
            NumpadKey(symbol: "8", onTap: () => onTap("8")),
            NumpadKey(symbol: "9", onTap: () => onTap("9")),
          ],
        ),
        SizedBox(height: verticalSpacing),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: horizontalSpacing,
          children: [
            NumpadKey(symbol: ",", onTap: () => onTap(".")),
            NumpadKey(symbol: "0", onTap: () => onTap("0")),
            NumpadKey(
              icon: Icon(
                Icons.backspace_outlined,
                color: context.colors.delete,
              ),
              symbol: "",
              onTap: () => onTap(""),
            ),
          ],
        ),
      ],
    );
  }
}

class NumpadKey extends StatelessWidget {
  const NumpadKey({
    super.key,
    required this.symbol,
    this.icon,
    required this.onTap,
  });
  final String symbol;
  final Icon? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final sizeScreen = context.sizeScreen;
    final side = sizeScreen.width * 0.1;
    const fontRatio = 0.9;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: context.colors.border),
        color: Colors.transparent,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SizedBox(
              height: side,
              width: side,
              child: Center(
                child:
                    icon ??
                    Text(
                      symbol,
                      style: TextStyle(
                        fontSize: fontRatio * side,
                        fontWeight: FontWeight.w700,
                        height: 0.8,
                      ),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

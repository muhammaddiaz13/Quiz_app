import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    required this.index,
    required this.optionText,
    required this.onTap,
    super.key,
  });

  final int index;
  final String optionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final shortSide = screenSize.shortestSide.clamp(1.0, 600.0);
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.onSurface.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(shortSide * 0.035),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(shortSide * 0.035),
        splashColor: colorScheme.primary.withValues(alpha: 0.3),
        highlightColor: colorScheme.primary.withValues(alpha: 0.12),
        child: Container(
          constraints: BoxConstraints(minHeight: screenSize.height * 0.075),
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.045,
            vertical: screenSize.height * 0.018,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(shortSide * 0.035),
            border: Border.all(
              color: colorScheme.onSurface.withValues(alpha: 0.22),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: shortSide * 0.1,
                height: shortSide * 0.1,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primary.withValues(alpha: 0.22),
                ),
                child: Text(
                  String.fromCharCode(65 + index),
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: shortSide * 0.042,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: screenSize.width * 0.04),
              Expanded(
                child: Text(
                  optionText,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: shortSide * 0.045,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurface.withValues(alpha: 0.65),
                size: shortSide * 0.065,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

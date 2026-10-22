import 'package:flutter/material.dart';

class CustomSpaceButton extends StatelessWidget {
  const CustomSpaceButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final shortSide = screenSize.shortestSide.clamp(1.0, 600.0);
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth,
        height: screenSize.height * 0.075,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.05,
              vertical: screenSize.height * 0.015,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(shortSide * 0.05),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: shortSide * 0.05,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

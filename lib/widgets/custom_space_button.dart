import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

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
    final shortSide = screenSize.shortestSide;

    return SizedBox(
      width: screenSize.width * 0.84,
      height: screenSize.height * 0.075,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.nebulaPurple,
          foregroundColor: AppColors.starlightWhite,
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
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
    );
  }
}

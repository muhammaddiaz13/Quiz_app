import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/welcome_screen.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(const SpaceQuizApp());
}

class SpaceQuizApp extends StatelessWidget {
  const SpaceQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.nebulaPurple,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColors.nebulaPurple,
      secondary: AppColors.starlightWhite,
      surface: AppColors.deepSpaceBlue,
    );

    return MaterialApp(
      title: 'Space Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: AppColors.deepSpaceBlue,
        textTheme: GoogleFonts.spaceGroteskTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ).apply(bodyColor: AppColors.starlightWhite),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.starlightWhite.withValues(alpha: 0.08),
          hintStyle: TextStyle(
            color: AppColors.starlightWhite.withValues(alpha: 0.6),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.starlightWhite.withValues(alpha: 0.3),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.nebulaPurple),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
      },
    );
  }
}

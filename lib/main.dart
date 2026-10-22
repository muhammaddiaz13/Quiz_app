import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'providers/quiz_provider.dart';
import 'screens/welcome_screen.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(const SpaceQuizApp());
}

class SpaceQuizApp extends StatelessWidget {
  const SpaceQuizApp({super.key});

  ThemeData _buildTheme(ColorScheme colorScheme) {
    final baseTheme = ThemeData(
      colorScheme: colorScheme,
      brightness: colorScheme.brightness,
      scaffoldBackgroundColor: colorScheme.surface,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.spaceGroteskTextTheme(baseTheme.textTheme).apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.onSurface.withValues(alpha: 0.08),
        hintStyle: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.onSurface.withValues(alpha: 0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: Consumer<QuizProvider>(
        builder: (context, quizProvider, _) => MaterialApp(
          title: 'Space Quiz',
          debugShowCheckedModeBanner: false,
          theme: _buildTheme(AppColors.lightScheme),
          darkTheme: _buildTheme(AppColors.darkScheme),
          themeMode: quizProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: '/',
          routes: {'/': (context) => const WelcomeScreen()},
        ),
      ),
    );
  }
}

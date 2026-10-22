import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<QuizProvider>().isDarkMode;

    return IconButton(
      tooltip: isDarkMode ? 'Beralih ke tema terang' : 'Beralih ke tema gelap',
      onPressed: context.read<QuizProvider>().toggleTheme,
      icon: Icon(
        isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
      ),
    );
  }
}

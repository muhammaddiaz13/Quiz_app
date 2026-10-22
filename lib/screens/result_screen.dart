import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../widgets/custom_space_button.dart';
import 'welcome_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  void _returnToBase(BuildContext context) {
    context.read<QuizProvider>().resetQuiz();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<void>(builder: (_) => const WelcomeScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final shortSide = screenSize.shortestSide.clamp(1.0, 600.0);
    final colorScheme = Theme.of(context).colorScheme;
    final quizProvider = context.watch<QuizProvider>();

    return Scaffold(
      body: SafeArea(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.surfaceContainerHighest,
                colorScheme.surface,
              ],
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.08,
                    vertical: screenSize.height * 0.05,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: screenSize.height * 0.035),
                      Image.asset(
                        'assets/images/rocket.png',
                        width: shortSide * 0.24,
                        height: shortSide * 0.24,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: screenSize.height * 0.025),
                      Text(
                        'Misi Selesai!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spaceGrotesk(
                          color: colorScheme.onSurface,
                          fontSize: shortSide * 0.09,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.018),
                      Text(
                        'Selamat, ${quizProvider.userName}!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colorScheme.onSurface.withValues(alpha: 0.85),
                          fontSize: shortSide * 0.052,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.045),
                      Container(
                        width: constraints.maxWidth,
                        padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.1,
                          vertical: screenSize.height * 0.03,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.onSurface.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(shortSide * 0.05),
                          border: Border.all(
                            color: colorScheme.primary.withValues(alpha: 0.7),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'SKOR AKHIR',
                              style: TextStyle(
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.7,
                                ),
                                fontSize: shortSide * 0.04,
                                letterSpacing: shortSide * 0.006,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: screenSize.height * 0.012),
                            Text(
                              '${quizProvider.score} / ${quizProvider.questions.length}',
                              style: GoogleFonts.spaceGrotesk(
                                color: colorScheme.onSurface,
                                fontSize: shortSide * 0.13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.055),
                      CustomSpaceButton(
                        label: 'Kembali ke Pangkalan',
                        onPressed: () => _returnToBase(context),
                      ),
                      SizedBox(height: screenSize.height * 0.04),
                    ],
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

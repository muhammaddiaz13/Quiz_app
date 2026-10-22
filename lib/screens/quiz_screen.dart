import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../widgets/option_card.dart';
import '../widgets/theme_toggle_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final QuizProvider _quizProvider;

  @override
  void initState() {
    super.initState();
    _quizProvider = context.read<QuizProvider>()..addListener(_checkQuizEnd);
  }

  @override
  void dispose() {
    _quizProvider.removeListener(_checkQuizEnd);
    super.dispose();
  }

  void _checkQuizEnd() {
    if (_quizProvider.currentQuestionIndex < _quizProvider.questions.length) {
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const ResultScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final shortSide = screenSize.shortestSide.clamp(1.0, 600.0);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Misi Berlangsung',
          style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
        ),
        actions: const [ThemeToggleButton()],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Consumer<QuizProvider>(
              builder: (context, quizProvider, _) {
                final question =
                    quizProvider.questions[quizProvider.currentQuestionIndex
                        .clamp(0, quizProvider.questions.length - 1)];
                final questionNumber = quizProvider.currentQuestionIndex + 1;

                return LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.07,
                      vertical: screenSize.height * 0.025,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Misi $questionNumber dari ${quizProvider.questions.length}',
                              style: TextStyle(
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.8,
                                ),
                                fontSize: shortSide * 0.042,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${((questionNumber / quizProvider.questions.length) * 100).round()}%',
                              style: TextStyle(
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.8,
                                ),
                                fontSize: shortSide * 0.04,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.015),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(shortSide * 0.03),
                          child: LinearProgressIndicator(
                            value:
                                questionNumber / quizProvider.questions.length,
                            minHeight: screenSize.height * 0.012,
                            backgroundColor: colorScheme.onSurface.withValues(
                              alpha: 0.12,
                            ),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              colorScheme.primary,
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.06),
                        Icon(
                          Icons.auto_awesome,
                          size: shortSide * 0.13,
                          color: colorScheme.primary,
                        ),
                        SizedBox(height: screenSize.height * 0.025),
                        Text(
                          question.questionText,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.spaceGrotesk(
                            color: colorScheme.onSurface,
                            fontSize: shortSide * 0.065,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.045),
                        ...List.generate(
                          question.options.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(
                              bottom: screenSize.height * 0.015,
                            ),
                            child: OptionCard(
                              index: index,
                              optionText: question.options[index],
                              onTap: () => quizProvider.answerQuestion(index),
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

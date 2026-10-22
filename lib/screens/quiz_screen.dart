import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/option_card.dart';
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
    final shortSide = screenSize.shortestSide.clamp(1.0, double.infinity);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Misi Berlangsung',
          style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.deepSpaceBlue,
        foregroundColor: AppColors.starlightWhite,
      ),
      body: SafeArea(
        child: Consumer<QuizProvider>(
          builder: (context, quizProvider, _) {
            final question =
                quizProvider.questions[quizProvider.currentQuestionIndex.clamp(
                  0,
                  quizProvider.questions.length - 1,
                )];
            final questionNumber = quizProvider.currentQuestionIndex + 1;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.07,
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
                          color: AppColors.starlightWhite.withValues(
                            alpha: 0.8,
                          ),
                          fontSize: shortSide * 0.042,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${((questionNumber / quizProvider.questions.length) * 100).round()}%',
                        style: TextStyle(
                          color: AppColors.starlightWhite.withValues(
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
                      value: questionNumber / quizProvider.questions.length,
                      minHeight: screenSize.height * 0.012,
                      backgroundColor: AppColors.starlightWhite.withValues(
                        alpha: 0.12,
                      ),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.nebulaPurple,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.06),
                  Icon(
                    Icons.auto_awesome,
                    size: shortSide * 0.13,
                    color: AppColors.nebulaPurple,
                  ),
                  SizedBox(height: screenSize.height * 0.025),
                  Text(
                    question.questionText,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.starlightWhite,
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
            );
          },
        ),
      ),
    );
  }
}

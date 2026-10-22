import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/providers/quiz_provider.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/screens/result_screen.dart';
import 'package:quiz_app/screens/welcome_screen.dart';

void main() {
  testWidgets('answers all questions and can restart from the result screen', (
    tester,
  ) async {
    await tester.pumpWidget(const SpaceQuizApp());

    expect(find.text('Space Quiz'), findsOneWidget);
    expect(find.text('Mulai Misi'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Misi Berlangsung'), findsNothing);

    await tester.tap(find.text('Mulai Misi'));
    await tester.pumpAndSettle();
    expect(find.text('Misi Berlangsung'), findsNothing);

    await tester.enterText(find.byType(TextField), 'Alya');
    await tester.tap(find.text('Mulai Misi'));
    await tester.pumpAndSettle();

    expect(find.byType(QuizScreen), findsOneWidget);
    expect(
      find.text('Planet apa yang dikenal sebagai Planet Merah?'),
      findsOneWidget,
    );
    expect(find.text('Misi 1 dari 5'), findsOneWidget);

    final answers = [
      'Mars',
      'Matahari',
      'Jupiter',
      'Bima Sakti',
      'Satelit alami',
    ];
    for (final answer in answers) {
      final answerFinder = find.text(answer);
      await tester.ensureVisible(answerFinder);
      await tester.tap(answerFinder);
      await tester.pumpAndSettle();
    }

    expect(find.byType(ResultScreen), findsOneWidget);
    expect(find.text('Selamat, Alya!'), findsOneWidget);
    expect(find.text('5 / 5'), findsOneWidget);

    final restartButton = find.text('Kembali ke Pangkalan');
    await tester.ensureVisible(restartButton);
    await tester.tap(restartButton);
    await tester.pumpAndSettle();

    expect(find.byType(WelcomeScreen), findsOneWidget);
    final welcomeContext = tester.element(find.byType(WelcomeScreen));
    final quizProvider = welcomeContext.read<QuizProvider>();
    expect(quizProvider.userName, isEmpty);
    expect(quizProvider.currentQuestionIndex, 0);
    expect(quizProvider.score, 0);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/providers/quiz_provider.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

void main() {
  testWidgets('welcome screen requires a name before starting a mission', (
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
    expect(find.text('Halaman Kuis'), findsOneWidget);
    final quizContext = tester.element(find.byType(QuizScreen));
    expect(quizContext.read<QuizProvider>().userName, 'Alya');
  });
}

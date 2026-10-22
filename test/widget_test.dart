import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/main.dart';

void main() {
  testWidgets('welcome screen accepts a name and shows the mission button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SpaceQuizApp());

    expect(find.text('Space Quiz'), findsOneWidget);
    expect(find.text('Mulai Misi'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Alya');
    await tester.tap(find.text('Mulai Misi'));
    await tester.pump();
  });
}

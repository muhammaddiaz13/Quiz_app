import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/providers/quiz_provider.dart';

void main() {
  group('QuizProvider', () {
    test('holds five astronomy questions and stores the astronaut name', () {
      final provider = QuizProvider();

      expect(provider.questions, hasLength(5));
      provider.setUserName('Alya');

      expect(provider.userName, 'Alya');
    });

    test('updates score and question progress when answering', () {
      final provider = QuizProvider();

      provider.answerQuestion(provider.questions.first.correctAnswerIndex);
      provider.answerQuestion(-1);

      expect(provider.score, 1);
      expect(provider.currentQuestionIndex, 1);

      provider.answerQuestion(0);

      expect(provider.score, 1);
      expect(provider.currentQuestionIndex, 2);
    });

    test('does not advance past the final question', () {
      final provider = QuizProvider();

      for (final question in provider.questions) {
        final incorrectIndex =
            (question.correctAnswerIndex + 1) % question.options.length;
        provider.answerQuestion(incorrectIndex);
      }
      provider.answerQuestion(provider.questions.last.correctAnswerIndex);

      expect(provider.currentQuestionIndex, provider.questions.length);
      expect(provider.score, 0);
    });

    test('resets name, score, and progress for a new mission', () {
      final provider = QuizProvider();
      provider.setUserName('Alya');
      provider.answerQuestion(provider.questions.first.correctAnswerIndex);

      provider.resetQuiz();

      expect(provider.userName, isEmpty);
      expect(provider.currentQuestionIndex, 0);
      expect(provider.score, 0);
    });
  });
}

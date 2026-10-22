import 'package:flutter/foundation.dart';

import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  String _userName = '';
  int _currentQuestionIndex = 0;
  int _score = 0;

  String get userName => _userName;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;

  final List<Question> questions = const [
    Question(
      questionText: 'Planet apa yang dikenal sebagai Planet Merah?',
      options: ['Venus', 'Mars', 'Jupiter', 'Merkurius'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'Bintang apa yang berada di pusat Tata Surya?',
      options: ['Sirius', 'Proxima Centauri', 'Matahari', 'Vega'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'Planet terbesar di Tata Surya adalah?',
      options: ['Saturnus', 'Neptunus', 'Bumi', 'Jupiter'],
      correctAnswerIndex: 3,
    ),
    Question(
      questionText: 'Apa nama galaksi tempat Tata Surya berada?',
      options: ['Andromeda', 'Bima Sakti', 'Sombrero', 'Triangulum'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'Benda langit apa yang mengorbit sebuah planet?',
      options: ['Komet', 'Asteroid', 'Satelit alami', 'Nebula'],
      correctAnswerIndex: 2,
    ),
  ];

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void answerQuestion(int selectedIndex) {
    if (_currentQuestionIndex >= questions.length) {
      return;
    }

    final currentQuestion = questions[_currentQuestionIndex];
    if (selectedIndex < 0 || selectedIndex >= currentQuestion.options.length) {
      return;
    }

    if (selectedIndex == currentQuestion.correctAnswerIndex) {
      _score++;
    }

    _currentQuestionIndex++;
    notifyListeners();
  }

  void resetQuiz() {
    _userName = '';
    _currentQuestionIndex = 0;
    _score = 0;
    notifyListeners();
  }
}

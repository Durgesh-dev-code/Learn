import 'package:flutter/material.dart';
import 'package:flutter_quiz/questions_screen.dart';
import 'package:flutter_quiz/results_screen.dart';
import 'package:flutter_quiz/start_screen.dart';
import 'package:flutter_quiz/data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  final List<String> _selectedAnswer = [];
  //--- Used for navigation between screens
  // Widget? activeScreen;
  // @override
  // void initState() {
  //   activeScreen = StartScreen(
  //       switchScreen); // allow the switchScreen function to be called from StartScreen
  //   super.initState(); // call the parent's initState
  // }

  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(
      () {
        // activeScreen = const QuestionsScreen();
        activeScreen = "questions-screen";
      },
    );
  }

  void ChooseAnswer(String answer) {
    _selectedAnswer.add(answer);

    if (_selectedAnswer.length == questions.length) {
      setState(() {
        //_selectedAnswer.length = 0;
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      _selectedAnswer.length = 0;
      activeScreen = "start-screen";
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == "questions-screen") {
      screenWidget = QuestionsScreen(
        onSelectAnswer: ChooseAnswer,
      ); // show the questions screen
    } else if (activeScreen == "results-screen") {
      screenWidget = ResultsScreen(
        chosenAnswer: _selectedAnswer,
        restartQuiz: restartQuiz,
      );
    }
    //Main App layout
    //Switch from StartScreen to QuestionsScreen

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            // color: Color.fromARGB(255, 120, 5, 236),
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 120, 5, 236),
              Color.fromARGB(255, 181, 121, 241)
            ], begin: Alignment.topRight, end: Alignment.bottomRight),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}

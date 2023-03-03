import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

void main() {
  runApp(
      const MyApp()); //entry point of flutter app, takes widget as argument and start the flutter framework execution with that widget as root
  // attaches root widget to the screen and starts the event loop for handing user inputs, UI updates, etc
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'question': 'What is you favorite Cricket format?',
      'answers': [
        {'text': 'Test', 'score': 9},
        {'text': 'ODI', 'score': 7},
        {'text': 'T20', 'score': 5}
      ]
    },
    {
      'question': 'Who is your favorite T20 Batsman?',
      'answers': [
        {'text': 'Babar Azam', 'score': 5},
        {'text': 'Virat Kohli', 'score': 9},
        {'text': 'Steven Smith', 'score': 7}
      ]
    },
    {
      'question': 'Who is your favorite Test bowler?',
      'answers': [
        {'text': 'Shaheen Afridi', 'score': 7},
        {'text': 'Harris Rauf', 'score': 5},
        {'text': 'James Anderson', 'score': 9}
      ]
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz(){
    setState((){
      _questionIndex =0;
      _totalScore = 0;
    
    });
  }
  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    //build method is called whenever the state changes
    return MaterialApp(
      //provides various visual elements and layout widgets
      home: Scaffold(
        //provides basic structure fore the app screen
        appBar: AppBar(title: const Text('Quiz App')), //title bar
        body: _questionIndex < _questions.length
            ? Quiz(
                //Quiz widget requires three args
                questions: _questions,
                questionIndex: _questionIndex,
                answerQuestion:
                    _answerQuestion) //function that is provided to quiz
            :  Result(_totalScore, _resetQuiz),
      ),
    );
  }
}

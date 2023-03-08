import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;

  const Result(this.resultScore, this.resetHandler, {super.key});

  String get result {
    String resultText = "";
    if (resultScore <= 27) {
      resultText = "You possess an excellent knowledge. Keep it up!";
    }
    if (resultScore <= 25) {
      resultText = "You have a decent knowledge";
    }
    if (resultScore <= 23) {
      resultText = "You have an average knowledge";
    }
    if (resultScore <= 20) {
      resultText = "You have a terrible knowledge";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(

          
      children: <Widget>[
                    const SizedBox(height: 60),

        Text(
          
          result,
          style: const TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
            const SizedBox(height: 200),

        ElevatedButton(
          
          onPressed: resetHandler,
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 27, 122, 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              textStyle:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.w300)),
          child: const Text("Restart Quiz"),
        )
      ],
    ));
  }
}

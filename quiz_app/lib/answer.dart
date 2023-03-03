import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answer;

  Answer(this.selectHandler, this.answer, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(top: 50.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 40, 146, 152),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            textStyle:
                const TextStyle(fontSize: 30, fontWeight: FontWeight.w300)),
        onPressed: selectHandler,
        child: Text(answer),
      ),
    );
  }
}

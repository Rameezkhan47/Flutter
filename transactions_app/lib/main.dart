import 'package:flutter/material.dart';
import 'package:transactions_app/transactions_list.dart';
import './user_transactions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
        return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: MaterialApp(
        title: 'Transactions App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
            return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Transactions App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // ignore: avoid_unnecessary_containers
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: const Card(
                elevation: 5,
                color: Color.fromRGBO(215, 196, 158, 1),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Transactions",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const UserTransactions(),
          ],
        ),
      ),
    ));
  }
}

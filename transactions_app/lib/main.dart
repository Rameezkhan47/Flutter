import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transactions',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(id: 'T1', title: 'Shirt', amount: 3500, date: DateTime.now()),
    Transaction(id: 'T2', title: 'Jeans', amount: 5000, date: DateTime.now()),
    Transaction(id: 'T3', title: 'Shoes', amount: 18000, date: DateTime.now()),
  ];

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body: Column(
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
          Column(
            children: transactions.map((e) {
              final formattedDate = DateFormat.yMMMMd()
                  .format(e.date); // format date as 'Month Day, Year'

              return Card(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(52, 49, 72, 1),
                ),
                child: Row(
                  children: <Widget>[
                    // ignore: avoid_unnecessary_containers
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromRGBO(215, 196, 158, 1),
                          width: 2,
                        ),
                      ),
                      child: Text(
                        'PKR ${e.amount.toString()}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          e.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(formattedDate,
                            style: const TextStyle(color: Colors.white))
                      ],
                    )
                  ],
                ),
              ));
            }).toList(),
          )
        ],
      ),
    );
  }
}

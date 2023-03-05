import 'package:flutter/material.dart';

import './new_transaction.dart';
import './transactions_list.dart';
import './model/transaction.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   final List<Transaction> _userTransaction = [
    Transaction(id: 'T1', title: 'Shirt', amount: 3500, date: DateTime.now()),
    Transaction(id: 'T2', title: 'Jeans', amount: 5000, date: DateTime.now()),
    Transaction(id: 'T3', title: 'Shoes', amount: 18000, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
        id: DateTime.now().toString());
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext context){ ///takes two arguments context and builder (context of which we want it to render when button is pressed)
    showModalBottomSheet(context: context, builder: (_){ //builder is a function that returns the widget we need to be inside modal bottom sheet
      return NewTransaction(_addNewTransaction);
    });

  }
  @override
  Widget build(BuildContext context) {
            return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Transactions App'),
        actions:<Widget>[
          IconButton(icon: const Icon(Icons.add), onPressed: () {_startAddNewTransaction(context);})
        ],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:  <Widget>[
            // ignore: avoid_unnecessary_containers
            // Container(
            //   margin: const EdgeInsets.only(bottom: 5),
            //   child: const Card(
            //     elevation: 5,
            //     color: Color.fromRGBO(215, 196, 158, 1),
            //     child: Padding(
            //       padding: EdgeInsets.all(2.0),
            //       child: Center(
            //         child: Padding(
            //           padding: EdgeInsets.all(2),
            //           child: Text(
            //             "Transactions",
            //             style: TextStyle(
            //                 fontSize: 20.0, fontWeight: FontWeight.bold),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
             Expanded(child: TransactionList(_userTransaction))
          ],
        ),
        floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){_startAddNewTransaction(context);},),
      ),
    );
  }
}

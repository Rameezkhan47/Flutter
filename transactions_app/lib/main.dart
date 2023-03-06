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
        title: 'Personal Expenses',
        theme: ThemeData(
          primarySwatch: Colors
              .purple, //sets the theme for the app, the widgets will inherit shades of primary swatch
          colorScheme: const ColorScheme(
            primary: Colors.purple,
            secondary: Colors.amber,
            surface: Colors.white,
            background: Colors.grey,
            error: Colors.redAccent,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.black,
            onBackground: Colors.black,
            onError: Colors.white,
            brightness: Brightness.light,
          ),
          fontFamily: 'Quicksand',
          textTheme: const TextTheme( // sets theme for different texts
            displayLarge:
            TextStyle(fontSize: 24.0, color: Colors.white),
            titleLarge: TextStyle(fontSize: 24.0, fontFamily: 'OpenSans' ),
            bodyMedium: TextStyle(fontSize: 20.0, fontFamily: 'OpenSans'),
            bodySmall: TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 114, 114, 114)), 
          ),
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
  late final List<Transaction> _userTransaction = [];

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

  void _startAddNewTransaction(BuildContext context) {
    ///takes two arguments context and builder (context of which we want it to render when button is pressed)
    showModalBottomSheet(
        context: context,
        builder: (_) {
          //builder is a function that returns the widget we need to be inside modal bottom sheet
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
          title:  Text('Personal Expenses',
          style: Theme.of(context).textTheme.displayLarge,  //copy theme from textTheme
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _startAddNewTransaction(context);
                })
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            _startAddNewTransaction(context);
          },
        ),
      ),
    );
  }
}

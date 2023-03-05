import 'package:flutter/material.dart';
import './new_transaction.dart';
import './transactions_list.dart';
import './model/transaction.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({super.key});

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        Expanded(child: TransactionList(_userTransaction))
      ],
    );
  }
}

import 'package:flutter/material.dart';
import './new_transaction.dart';
import './transactions_list.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({super.key});

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(),
        // ignore: prefer_const_constructors
        TransactionsList(),
      ],
    );
  }
}

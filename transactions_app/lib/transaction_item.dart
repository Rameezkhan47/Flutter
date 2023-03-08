import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/transaction.dart';
import 'package:string_formate/string_extension.dart';









class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.backgroundColor,
    required this.backgroundColorCircle,
    required this.transaction,
    required this.deleteTransaction,
  });

  final Color backgroundColor;
  final Color backgroundColorCircle;
  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(bottom: 15),
        elevation: 2,
        color: backgroundColor,
        child: ListTile(
            //aesthetic widget provided by material library for rendering list
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: backgroundColorCircle,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: FittedBox(
                  child: Text(
                    'PKR ${transaction.amount.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
            title: Text(
              transaction.title.capitalize(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(transaction.date),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            trailing: MediaQuery.of(context).size.width > 460
                ? TextButton.icon(
                    icon: const Icon(
                      Icons.delete,
                    ),
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.background,
                    )),
                    label: const Text('Delete'),
                    onPressed: () => deleteTransaction(transaction.id),
                  )
                : IconButton(
                    icon: const Icon(Icons.delete_rounded),
                    color: Theme.of(context).colorScheme.background,
                    onPressed: () =>
                        deleteTransaction(transaction.id))));
  }
}
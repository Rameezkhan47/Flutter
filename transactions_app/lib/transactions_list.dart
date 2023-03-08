import 'package:flutter/material.dart';
import 'model/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  const TransactionList(this.transactions, this.deleteTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // ignore: sized_box_for_whitespace
    return Container(
        height: screenHeight,
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (context, constraints) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text("No transactions yet!",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset('assets/images/waiting.png'))
                  ],
                );
              })
            : ListView.builder(
                itemBuilder: (context, index) {
                  if (index >= transactions.length) {
                    return null; // or return a placeholder widget
                  }
// format date as 'Month Day, Year'
                  final backgroundColor = index % 2 == 0
                      ? Colors.white
                      : const Color.fromARGB(255, 240, 240, 240);
                  final backgroundColorCircle = index % 2 == 0
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary;

                  return TransactionItem(
                      backgroundColor: backgroundColor,
                      backgroundColorCircle: backgroundColorCircle,
                      transaction: transactions[index],
                      deleteTransaction: deleteTransaction);
                },
              ));
  }
}



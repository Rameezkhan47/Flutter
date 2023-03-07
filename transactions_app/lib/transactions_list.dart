import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/transaction.dart';
import 'package:string_formate/string_extension.dart';

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
            ? Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text("No transactions yet!",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                      width: 150,
                      child: Image.asset('assets/images/waiting.png'))
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  if (index >= transactions.length) {
                    return null; // or return a placeholder widget
                  }
// format date as 'Month Day, Year'
                  final backgroundColor = index % 2 == 0
                      ? Colors.white
                      : Color.fromARGB(255, 240, 240, 240);
                  final backgroundColorCircle = index % 2 == 0
                      ? Theme.of(context).colorScheme.primary
                      :Theme.of(context).colorScheme.secondary;

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
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text(
                                'PKR ${transactions[index].amount.toStringAsFixed(0)}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          transactions[index].title.capitalize(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_rounded),
                          color: Theme.of(context).colorScheme.background,
                          onPressed: ()=>deleteTransaction(transactions[index].id)
                        )
                      ));
                },
              ));
  }
}

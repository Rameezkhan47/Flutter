import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/transaction.dart';
import 'package:string_formate/string_extension.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionList(this.transactions, {super.key});

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
                   Text("No transactions yet!", style: Theme.of(context).textTheme.titleLarge),
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
                  final formattedDate = DateFormat.yMMMMd().format(
                      transactions[index]
                          .date); // format date as 'Month Day, Year'
                  final backgroundColor = index % 2 == 0
                      ? Colors.white
                      : const Color.fromRGBO(211, 211, 211, 0.4);
                  return Card(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: backgroundColor),
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
                                  color: Theme.of(context).primaryColorDark,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                'PKR ${transactions[index].amount.toStringAsFixed(0)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium, //copy theme from textTheme
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  transactions[index].title.capitalize(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge, //copy theme from textTheme
                                ),
                                Text(formattedDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall) //copy theme from textTheme
                              ],
                            )
                          ],
                        ),
                      ));
                },
              ));
  }
}

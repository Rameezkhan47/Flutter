import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionList(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // ignore: sized_box_for_whitespace
    return Container(
        height: screenHeight,
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (index >= transactions.length) {
              return null; // or return a placeholder widget
            }
            final formattedDate = DateFormat.yMMMMd().format(
                transactions[index].date); // format date as 'Month Day, Year'
            final backgroundColor = index % 2 == 0?Colors.white:  const Color.fromRGBO(211, 211, 211, 0.4);
            return Card(
              margin: const EdgeInsets.only(bottom:15),
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: backgroundColor
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
                      'PKR ${transactions[index].amount.toString()}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        transactions[index].title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(formattedDate)
                    ],
                  )
                ],
              ),
            ));
          },
        ));
  }
}

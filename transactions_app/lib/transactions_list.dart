import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/transaction.dart';



class TransactionList extends StatelessWidget {
   final List<Transaction> transactions;
   const TransactionList(this.transactions, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Column(
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
          );
  }
}
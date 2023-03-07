import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import 'model/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

 List get groupedTransactionValues {
    final today = DateTime.now();
    final daysSinceSunday = today.weekday%7;
    final sunday = today.subtract(Duration(days: daysSinceSunday));
    return List.generate(7, (index) {
      final weekDay = sunday.subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: groupedTransactionValues.map((data) {
            return Expanded(
              child: ChartBar(
                data['day'],
                data['amount'],
               (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

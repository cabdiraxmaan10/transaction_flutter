import 'package:flutter/material.dart';
import 'package:transaction_app/model/transaction.dart';
import 'package:intl/intl.dart';
import 'package:transaction_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction>? recentTransaction;
  Chart({this.recentTransaction});

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weaklyDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (int i = 0; i < recentTransaction!.length; i++) {
        if (recentTransaction![i].dateTime!.day == weaklyDay.day &&
            recentTransaction![i].dateTime!.month == weaklyDay.month &&
            recentTransaction![i].dateTime!.year == weaklyDay.year) {
          totalSum += recentTransaction![i].amount as double;
        }
      }

      return {
        'date': DateFormat.E().format(weaklyDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get maxSpending {
    return groupedTransaction.fold(0.0, (sum, items) {
      return sum + (items['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Flexible(
        fit: FlexFit.tight,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransaction.map((data) {
              return ChartBar(
                label: data['date'] as String,
                spendingAmount: data['amount'] as double,
                spendingPrecentage: maxSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / maxSpending,
              );
            }).toList()),
      ),
    );
  }
}

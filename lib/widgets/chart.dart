import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../models/one_day_transactions.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  List<OneDayTransactions> get _lastWeekTransactions {
    return List.generate(7, (index) {
      final curDate = DateTime.now().subtract(Duration(days: index));

      final totalAmount = _recentTransactions.fold<double>(0.0, (total, transaction) {
        if (transaction.date.day == curDate.day &&
            transaction.date.month == curDate.month &&
            transaction.date.year == curDate.year) {
          return total + transaction.amount;
        }
        return total + 0.0;
      });

      return OneDayTransactions(
        day: DateFormat.E().format(curDate).substring(0, 1),
        totalAmount: totalAmount,
      );
    }).reversed.toList();
  }

  double get _lastWeekTotalAmount {
    return _lastWeekTransactions.fold(0.0, (total, transaction) {
      return total + transaction.totalAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: _lastWeekTransactions.map((transaction) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                transaction.day,
                transaction.totalAmount,
                _lastWeekTotalAmount == 0.0
                    ? 0.0
                    : transaction.totalAmount / _lastWeekTotalAmount,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

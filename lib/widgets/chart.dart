import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  List<Map<String, Object>> get _lastWeekTransactions {
    return List.generate(7, (index) {
      final curDate = DateTime.now().subtract(Duration(days: index));

      final totalAmount = _recentTransactions.fold(0.0, (total, transaction) {
        if (transaction.date.day == curDate.day &&
            transaction.date.month == curDate.month &&
            transaction.date.year == curDate.year) {
          return total + transaction.amount;
        }
        return total + 0.0;
      });

      return {
        'day': DateFormat.E().format(curDate).substring(0, 1),
        'amount': totalAmount,
      };
    });
  }

  double get _lastWeekTotalAmount {
    return _lastWeekTransactions.fold(0.0, (total, recentTransaction) {
      return total + recentTransaction['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: _lastWeekTransactions.map((recentTransaction) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                recentTransaction['day'],
                recentTransaction['amount'],
                _lastWeekTotalAmount == 0.0
                    ? 0.0
                    : (recentTransaction['amount'] as double) /
                        _lastWeekTotalAmount,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

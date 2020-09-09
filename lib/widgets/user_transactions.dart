import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
      title: 'New Shoes',
      amount: 69.99,
    ),
    Transaction(
      title: 'Weekly Groceries',
      amount: 16.53,
    ),
    Transaction(
      title: 'New Shoes',
      amount: 69.99,
    ),
    Transaction(
      title: 'Weekly Groceries',
      amount: 16.53,
    ),
    Transaction(
      title: 'New Shoes',
      amount: 69.99,
    ),
    Transaction(
      title: 'Weekly Groceries',
      amount: 16.53,
    )
  ];

  void _addNewTransaction(String inputTitle, double inputAmount) {
    setState(() {
      _transactions.add(new Transaction(
        title: inputTitle,
        amount: inputAmount,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_transactions),
      ],
    );
  }
}

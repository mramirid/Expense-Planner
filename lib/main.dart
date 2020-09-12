import 'dart:io';

import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now().subtract(Duration(days: 0)),
    ),
    Transaction(
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      title: 'T-Shirt Nike',
      amount: 39.99,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      title: 'Adidas Shoes',
      amount: 45.55,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      title: 'Jacket Hoodie',
      amount: 35.99999,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      title: 'MacDonald',
      amount: 10.5,
      date: DateTime.now().subtract(Duration(days: 5)),
    )
  ];
  bool _isChartDisplayed = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String inputTitle, double inputAmount, DateTime pickedDate) {
    setState(() {
      _transactions.add(new Transaction(
        title: inputTitle,
        amount: inputAmount,
        date: pickedDate,
      ));
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _startAddNewTransaction() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      context: context,
      isScrollControlled: true,
      builder: (_) => GestureDetector(
        child: NewTransaction(_addNewTransaction),
        onTap: () {},
        behavior: HitTestBehavior.opaque,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBarWidget = AppBar(
      title: Text('Expense Planner'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(),
        ),
      ],
    );

    final bodyHeight = MediaQuery.of(context).size.height -
        appBarWidget.preferredSize.height -
        MediaQuery.of(context).padding.top;

    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final chartWidget = Container(
      height: isLandscape ? bodyHeight * 0.7 : bodyHeight * 0.3,
      child: Chart(_recentTransactions),
    );
    final transactionListWidget = Container(
      height: bodyHeight * 0.7,
      child: TransactionList(_transactions, _deleteTransaction),
    );

    return Scaffold(
      appBar: appBarWidget,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _isChartDisplayed,
                    onChanged: (value) => setState(() => _isChartDisplayed = value),
                  ),
                ],
              ),
            if (isLandscape) _isChartDisplayed ? chartWidget : transactionListWidget,
            if (!isLandscape) chartWidget,
            if (!isLandscape) transactionListWidget,
          ],
        ),
      ),
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

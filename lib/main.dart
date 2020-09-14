import 'dart:io';

import 'package:flutter/cupertino.dart';
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
              headline6: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              button: const TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
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
  final List<Transaction> _transactions = [];

  bool _isChartDisplayed = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String inputTitle, double inputAmount, DateTime pickedDate) {
    setState(() {
      _transactions.add(Transaction(
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
    showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (_) => GestureDetector(
        child: NewTransaction(_addNewTransaction),
        onTap: () {},
        behavior: HitTestBehavior.opaque,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Expense Planner'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButton(
                  child: const Icon(CupertinoIcons.add, color: Colors.white),
                  onPressed: _startAddNewTransaction,
                ),
              ],
            ),
          )
        : AppBar(
            title: const Text('Expense Planner'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _startAddNewTransaction,
              ),
            ],
          ) as PreferredSizeWidget);
  }

  List<Widget> _buildPortraitContent(double bodyHeight) {
    return [
      Container(
        height: bodyHeight * 0.3,
        child: Chart(_recentTransactions),
      ),
      Container(
        height: bodyHeight * 0.7,
        child: TransactionList(_transactions, _deleteTransaction),
      ),
    ];
  }

  List<Widget> _buildLandscapeContent(double bodyHeight) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show Chart', style: Theme.of(context).textTheme.headline6),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _isChartDisplayed,
            onChanged: (value) => setState(() => _isChartDisplayed = value),
          ),
        ],
      ),
      _isChartDisplayed
          ? Container(
              height: bodyHeight * 0.7,
              child: Chart(_recentTransactions),
            )
          : Container(
              height: bodyHeight * 0.7,
              child: TransactionList(_transactions, _deleteTransaction),
            ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final appBarWidget = _buildAppBar();

    final bodyHeight = MediaQuery.of(context).size.height -
        appBarWidget.preferredSize.height -
        MediaQuery.of(context).padding.top;

    final bodyWidget = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!isLandscape) ..._buildPortraitContent(bodyHeight),
            if (isLandscape) ..._buildLandscapeContent(bodyHeight),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBarWidget as ObstructingPreferredSizeWidget,
            child: bodyWidget,
          )
        : Scaffold(
            appBar: appBarWidget,
            body: bodyWidget,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: _startAddNewTransaction,
                  ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
  }
}

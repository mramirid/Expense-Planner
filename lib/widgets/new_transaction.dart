import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function _addNewTransaction;

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  NewTransaction(this._addNewTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: () {
                _addNewTransaction(
                  _titleController.text,
                  double.parse(_amountController.text),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

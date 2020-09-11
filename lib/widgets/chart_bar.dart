import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String _labelDay;
  final double _totalAmount;
  final double _percentageOfTotalAmount;

  ChartBar(this._labelDay, this._totalAmount, this._percentageOfTotalAmount);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(child: Text('\$${_totalAmount.toStringAsFixed(0)}')),
        ),
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: _percentageOfTotalAmount,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(_labelDay),
      ],
    );
  }
}
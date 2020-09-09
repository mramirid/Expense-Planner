import 'package:flutter/foundation.dart';

import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Transaction {
  String id;
  String title;
  double amount;
  DateTime date;

  Transaction({@required this.title, @required this.amount})
      : id = uuid.v4(),
        date = DateTime.now();
}

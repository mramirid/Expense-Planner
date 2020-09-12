import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String _text;
  final Function _clickHandler;

  AdaptiveFlatButton(this._text, this._clickHandler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: _clickHandler,
          )
        : FlatButton(
            child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold)),
            textColor: Theme.of(context).primaryColor,
            onPressed: _clickHandler,
          );
  }
}

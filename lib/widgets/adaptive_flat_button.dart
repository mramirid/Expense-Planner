import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String _text;
  final void Function() _clickHandler;

  const AdaptiveFlatButton(this._text, this._clickHandler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(_text, style: const TextStyle(fontWeight: FontWeight.bold)),
            onPressed: _clickHandler,
          )
        : FlatButton(
            child: Text(_text, style: const TextStyle(fontWeight: FontWeight.bold)),
            textColor: Theme.of(context).primaryColor,
            onPressed: _clickHandler,
          );
  }
}
